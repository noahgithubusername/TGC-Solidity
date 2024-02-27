// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {
    uint256 unlockTime;
    uint256 number;

    // TODO: Task 1
    // 1. Change the constructor function to take in a parameter of type uint256 called duration
    // 2. Assign the state variable unlockTime to be the addition of currentTime and duration

    // CODE BLOCK //
    constructor() {
    // END OF CODE BLOCK //

        uint256 currentTime = block.timestamp; // The current time when the smart contract is deployed

        // CODE BLOCK //


        // END OF CODE BLOCK //
    }


    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        uint256 timeNow = block.timestamp; // The current time when the retrieve function is called

        // CODE BLOCK //

        return number;

        // END OF CODE BLOCK //

        // TODO: Task 2
        // 1. Use a control flow to change the amount code so that it will only return
        //    the state variable number if the timeNow is greater than the unlockTime
        //    if not the function should return 0
    }

}