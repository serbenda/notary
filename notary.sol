// Solidity version of the Smart Contract
// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.16;
import "@openzeppelin/contracts/access/Ownable.sol";

// Smart Contract Information
// Name: Notary
// Logic: Implements the product notary

// Smart Contract Statement - Notary
contract Notary is Ownable{

    // ----------- Variables -----------


    // Contract variables
    address public contractOwner;
    bool public isActive;

    address payable public _originalOnwer;
    uint public baseRate;

    // Batch variables
    struct PatentRecord {
        string hashId; // Double HASH (Firt name,Last Name,DNI)
        string typePatent; // Text or Document
        string hashPatent; // HASH of product to be patented
        address originalOnwer; // Wallet of the patent owner
        string patentName; // Description of the event
        uint256 creationDate; // "creationDate": "1668283833"
        string currentStatus; // Patented/transferred
        address oldOwner; // Old owner the pantent
    }
    
    uint256[] public timestamps;

    mapping(string => PatentRecord) private record;
    mapping(string => mapping(uint256 => string)) private status;


    modifier contractActive() {
        require(isActive, "Sorry, contract disabled");
        _;
    }

    // Events
    event patentRecord(
        string message,
        address originalOnwer,
        string hashId,
        string hashPatent,
        uint256 creationDate
    );

    // ----------- Constructor -----------
    constructor() {
        contractOwner = msg.sender;
        baseRate = 1 gwei;
        isActive = true;
    }

    // Writing functions
    function createRecord(
        string calldata hashId,
        string calldata typePatent,
        string calldata hashPatent,
        string calldata patentName
    ) public contractActive {
        timestamps.push(block.timestamp);
        record[hashId] = PatentRecord(
            hashId,
            typePatent,
            hashPatent,
            msg.sender,
            patentName,
            block.timestamp,
            "ready",
            address(0)            
        );
        status[hashId][block.timestamp] = "ready";
        status[hashId][block.timestamp] = "ready";
        emit patentRecord(
            "Patent record successfully created",
            msg.sender,
            hashId,
            hashPatent,
            block.timestamp
        );
    }
   
    // Reading functions
    function getRecord(string calldata hashId)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            address,
            string memory,
            uint256,
            string memory
        )
    {
        return (
            record[hashId].hashId,
            record[hashId].typePatent,
            record[hashId].hashPatent,
            record[hashId].originalOnwer,
            record[hashId].patentName,
            record[hashId].creationDate,
            record[hashId].currentStatus
        );
    }

    // Panic functions

    function enableContract() external onlyOwner {
        require(!isActive, "Contract already enabled");
        isActive = true;
    }

    function disableContract() external onlyOwner {
        require(isActive, "Contract already disabled");
        isActive = false;
    }
}