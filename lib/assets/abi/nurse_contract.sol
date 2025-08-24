// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NurseRegistry {
    // Struct to hold nurse data
    struct Nurse {
        uint nurseId;
        address owner; // Ethereum/Monad address of the nurse
        string name;
        bool professionalLicense; // True if nurse has a license
        uint age;
        bool carer;
        bool sex; // True for one value (e.g., Male), False for the other (e.g., Female)
        string telephoneNumber;
        string country;
        string city;
        uint registrationTime; // Timestamp of registration
    }

    // Mapping to store nurses by their ID
    mapping(uint => Nurse) public nurses;
    // Mapping to track registered addresses to prevent duplicates
    mapping(address => bool) public registeredAddresses;
    // Array to store all nurse IDs for iteration
    uint[] public nurseIds;
    // Counter for unique nurse IDs
    uint public nurseCount;

    // Event to log nurse registration
    event NurseRegistered(uint indexed nurseId, address indexed owner, string name, uint timestamp);

    // Modifier to restrict registration to unregistered addresses
    modifier onlyUnregistered() {
        require(!registeredAddresses[msg.sender], "Address already registered");
        _;
    }

    // Constructor (optional, can be empty)
    constructor() {
        nurseCount = 0;
    }

    // Function to register a new nurse
    function registerNurse(
        string memory _name,
        bool _professionalLicense,
        uint _age,
        bool _carer,
        bool _sex,
        string memory _telephoneNumber,
        string memory _country,
        string memory _city
    ) public onlyUnregistered {
        require(_age > 0 && _age <= 150, "Invalid age");
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_telephoneNumber).length > 0, "Telephone number cannot be empty");
        require(bytes(_country).length > 0, "Country cannot be empty");
        require(bytes(_city).length > 0, "City cannot be empty");

        nurseCount++;
        nurses[nurseCount] = Nurse(
            nurseCount,
            msg.sender,
            _name,
            _professionalLicense,
            _age,
            _carer,
            _sex,
            _telephoneNumber,
            _country,
            _city,
            block.timestamp
        );
        registeredAddresses[msg.sender] = true;
        nurseIds.push(nurseCount); // Add new nurse ID to the array

        emit NurseRegistered(nurseCount, msg.sender, _name, block.timestamp);
    }

    // Function to get nurse details by ID
    function getNurse(uint _nurseId) public view returns (
        uint, address, string memory, bool, uint, bool, bool, string memory, string memory, string memory, uint
    ) {
        Nurse memory nurse = nurses[_nurseId];
        require(nurse.nurseId > 0, "Nurse not found");
        return (
            nurse.nurseId,
            nurse.owner,
            nurse.name,
            nurse.professionalLicense,
            nurse.age,
            nurse.carer,
            nurse.sex,
            nurse.telephoneNumber,
            nurse.country,
            nurse.city,
            nurse.registrationTime
        );
    }

    // Function to get the total number of registered nurses
    function getNurseCount() public view returns (uint) {
        return nurseCount;
    }

    // Paginated function to get nurse IDs (to handle gas limits)
    function getNurseIds(uint startIndex, uint endIndex) public view returns (uint[] memory) {
        require(startIndex < endIndex, "Invalid range");
        require(endIndex <= nurseIds.length, "End index out of bounds");

        uint[] memory result = new uint[](endIndex - startIndex);
        for (uint i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = nurseIds[i];
        }
        return result;
    }
}