// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.20;

import "./Ownerable.sol";

contract Allowerable is Ownerable {
    mapping(address => bool) private allowed;

    event AllowanceChanged(address indexed account, bool allowed);

    modifier onlyAllowed() {
        require(allowed[msg.sender], "Caller is not allowed");
        _;
    }

    constructor() Ownerable(msg.sender) {
        allowed[msg.sender] = true;
        emit AllowanceChanged(msg.sender, true);
    }

    function setAllowance(address account, bool isAllowed) public onlyOwner {
        require(account != address(0), "Invalid account address");
        allowed[account] = isAllowed;
        emit AllowanceChanged(account, isAllowed);
    }

    function isAllowed(address account) public view returns (bool) {
        return allowed[account];
    }

    function renounceAllowance(address account) public onlyOwner {
        require(account != owner, "Invalid account address");
        allowed[msg.sender] = false;
        emit AllowanceChanged(msg.sender, false);
    }
}
