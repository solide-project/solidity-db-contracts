// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.20;

import "./Allowerable.sol";

contract SolidityDatabaseRegistry is Allowerable {
    struct ContractInfo {
        string id;
        uint256 timestamp;
    }

    mapping(string => ContractInfo) bytecodeDB;

    constructor() Allowerable() {}

    function find(
        string memory hash
    ) public view returns (ContractInfo memory) {
        return bytecodeDB[hash];
    }

    /**
     * @dev allows the service to add data
     */
    function add(string memory hash, string memory cid) public onlyAllowed {
        require(
            bytes(bytecodeDB[hash].id).length == 0,
            "Contract already added"
        );

        ContractInfo memory newContract;
        newContract.id = cid;
        newContract.timestamp = block.number;

        bytecodeDB[hash] = newContract;
    }

    /**
     * @dev allows the service to add data multi
     */
    function adds(
        string[] memory hashes,
        string memory cid
    ) public onlyAllowed {
        for (uint256 i = 0; i < hashes.length; i++) {
            add(hashes[i], cid);
        }
    }

    /**
     * @dev Note: This should never to called unless something happens
     */
    function addOverride(
        string memory hash,
        string memory cid
    ) public onlyOwner {
        ContractInfo memory newContract;
        newContract.id = cid;
        newContract.timestamp = block.number;

        bytecodeDB[hash] = newContract;
    }
}
