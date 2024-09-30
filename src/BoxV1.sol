// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openZeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// /Users/philip/Programming/Ethereum/foundry-f23/foundry-upgrade/lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol

contract BoxV1 is UUPSUpgradeable {
    uint256 internal number;

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    // here I could say sth like msg.sender != owner revert
    function _authorizeUpgrade(address newImplementation) internal override {}
}
