// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";

error Raffle__NotEnoughEth();
error Raffle__TransferFailed();
error Raffle__NotOpen();
error Raffle__UpKeepNotNeeded(
    uint256 currentBalance,
    uint256 numPlayers,
    // makes sure raffle is open
    uint256 raffleState
);
                
/** @title A simple Raffle Contract
 *  @author Jamal'TheAtlantean
 *  @notice The contract is for creating a truly decentralized smart contract
 *  @dev It implements Chainlink VRF V2 and Chainlink keepers
 */

contract Raffle is VRFConsumerBaseV2, KeeperCompatibleInterface {

    /* Type declaration */
    enum RaffleState {
        OPEN,
        CALCULATING
    }

    /* State Variables */
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private immutable i_callbackGasLimit;
    uint32 private constant NUM_WORDS = 1;

    // Lottery variables
    address private s_recentWinner;
    RaffleState private s_raffleState;
    uint256 private s_lastTimeStamp;
    uint256 private immutable i_interval;

    /* Events */
    event RaffleEntered(address indexed player);
    event RequestedRaffleWinner(uint256 indexed requestId);
    event WinnerPicked(address indexed player);

    constructor(
        address vrfCoordinatorV2,
        uint64 subscriptionId,
        bytes32 gasLane,
        uint256 interval,
        uint256 entranceFee, 
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_subscriptionId = subscriptionId;
        i_gasLane = gasLane;
        i_interval = interval;
        i_entranceFee = entranceFee;
        i_callbackGasLimit = callbackGasLimit;
        s_raffleState = RaffleState.OPEN;
        s_lastTimeStamp = block.timestamp;
    }
    
    function enterRaffle() public payable {
        if(msg.value < i_entranceFee) { 
            revert Raffle__NotEnoughEth();
        }
        if(s_raffleState != RaffleState.OPEN){
            revert Raffle__NotOpen();
        }
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    /**
     * @dev Chainlink keeper nodes calls this function
     * they wait for the upkeedNeeded to return true.
     * the following should be true for it to return true
     * 1.) Lottery is open
     * 2.) Desired time has passed
     * 3.) Lottery should have least 1 player,
     * 4.) Lottery has ETH
     */

    function checkUpkeep(bytes memory /* check data */ ) public view
    override returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        bool isOpen = (RaffleState.OPEN  == s_raffleState);
        bool timePassed = ((block.timestamp - s_lastTimeStamp) > i_interval);
        bool hasPlayers = (s_players.length > 0);
        bool hasBalance = address(this).balance > 0;
        // declare bools for the upkeepNeeded
        upkeepNeeded = (isOpen && timePassed && hasPlayers && hasBalance);

    }

    function performUpkeep(bytes calldata /* performData */ ) external override {
        (bool upkeepNeeded, ) = checkUpkeep("");
        if(!upkeepNeeded) {
            revert Raffle__UpKeepNotNeeded(
                address(this).balance,
                s_players.length,
                // makes sure raffle is open
                uint256 (s_raffleState)
                );
        }
        s_raffleState = RaffleState.CALCULATING;
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, // gasLane
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
    );
    emit RequestedRaffleWinner(requestId);
    }


    function fulfillRandomWords(uint256 /*requestId*/ , 
    uint256[] memory randomWords
    ) internal override {
        uint256 indexOfWinner = randomWords[0] % s_players.length;
        address payable recentWinner = s_players[indexOfWinner];
        s_recentWinner = recentWinner;
        // open back the raffle state to enable new entries once the
        // previous winner has been given their ETH
        s_raffleState = RaffleState.OPEN;
        // reset the players address array
        s_players = new address payable[](0);
        // restart the timestamp
        s_lastTimeStamp = block.timestamp;
        // send winner the cheddar
        (bool success, ) = recentWinner.call{value: address(this).balance}("");
        if(!success){
            revert Raffle__TransferFailed();
        }
        emit WinnerPicked(recentWinner);
    }

    /* View / Pure Functions */ 
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns(address) {
        return s_players[index];
        
    }

    function getRecentWinner() public view returns (address) {
        return s_recentWinner;
    }

    function getRaffleState() public view returns (RaffleState) {
        return s_raffleState;
    }

    function getNumWords() public pure returns(uint256) {
        return NUM_WORDS;
    }

    function getNumOfPlayers() public view returns (uint256) {
        return s_players.length;
    }

    function getLastTimeStamp() public view returns (uint256) {
        return s_lastTimeStamp;
    }

    function getRequestConfirmations() public pure returns (uint256) {
        return REQUEST_CONFIRMATIONS;
    }

    function getInterval() public view returns (uint256) {
        return i_interval;
    }

}
