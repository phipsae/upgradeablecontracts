// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBox} from "script/DeployBox.s.sol";
import {UpgradeBox} from "script/UpgradeBox.s.sol";
import {BoxV1} from "src/BoxV1.sol";
import {BoxV2} from "src/BoxV2.sol";

contract DeployAndUpgrade is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("OWNER");

    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); // right now points to Box V1
    }

    function testUpgrades() public {
        BoxV2 box2 = new BoxV2();

        uint256 versionBefore = BoxV2(proxy).version();
        console.log("Version before: ", versionBefore);
        BoxV2(proxy).setNumber(42);

        upgrader.upgradeBox(proxy, address(box2));
        uint256 versionAfter = BoxV2(proxy).version();
        console.log("Version after: ", versionAfter);

        BoxV2(proxy).setNumber(42);
        uint256 number = BoxV1(proxy).getNumber();
        console.log("Number: ", number);
    }
}
