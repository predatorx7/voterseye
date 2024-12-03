// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VotingContract {
    mapping(address => bool) public hasVoted;
    mapping(address => bool) public isVerified;
    uint256 public optionAVotes;
    uint256 public optionBVotes;
    
    event Voted(address indexed voter, uint256 option);
    event Verified(address indexed user);

    function verifyUser(address _user) external {
        require(!isVerified[_user], "User already verified");
        isVerified[_user] = true;
        emit Verified(_user);
    }

    function vote(uint256 _option) external {
        require(isVerified[msg.sender], "User not verified");
        require(!hasVoted[msg.sender], "Already voted");
        require(_option == 1 || _option == 2, "Invalid option");

        hasVoted[msg.sender] = true;
        
        if(_option == 1) {
            optionAVotes++;
        } else {
            optionBVotes++;
        }
        
        emit Voted(msg.sender, _option);
    }

    function getVotes() external view returns (uint256, uint256) {
        return (optionAVotes, optionBVotes);
    }
}