// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * @title ComradeToken
 * @dev Implementation of a BEP20 token for the COMRADE PROTOCOL
 *
 * This contract provides a basic BEP20 token implementation for use within the comrade ecosystem.
 * BEP20 is a standard interface for Binance Smart Chain tokens, compatible with ERC20.
 * It includes standard functionalities of a token, such as transferring tokens, approving tokens
 * to be spent by third parties, and transferring on behalf of others. The token has a fixed supply
 * which is assigned to the creator of the contract at deployment. The number of decimals can be set,
 * allowing the token to be divided into smaller units.
 *
 * The contract follows the BEP20 standard and includes best practices such as safe math
 * operations and thorough documentation for ease of understanding and security.
 */
contract ComradeToken {
    // BEP20 Token Name
    string public name;
    // BEP20 Token Symbol (short string like 'BNB')
    string public symbol;
    // Number of decimal places the token can be divided into
    uint8 public decimals;
    // Total supply of the tokens
    uint256 public totalSupply;

    // Mapping to store the balance of each address
    mapping(address => uint256) public balanceOf;
    // Mapping of mapping to store allowances (how much one address is allowed to take from another)
    mapping(address => mapping(address => uint256)) public allowance;

    // Event emitted when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Event emitted when an approval is made
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        name = "Comradetoken"; // Set the name of the token
        symbol = "CMRDT"; // Set the symbol of the token
        decimals = 18; // Set the decimal places
        // Set the total supply of the token, accounting for the decimals
        totalSupply = 70000000000000 * (10 ** uint256(decimals));
        // Assign the total supply to the contract deployer
        balanceOf[msg.sender] = totalSupply;
    }

    // Function to transfer tokens from one address to another
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Check for enough balance
        balanceOf[msg.sender] -= _value; // Deduct from sender's balance
        balanceOf[_to] += _value; // Add to recipient's balance
        emit Transfer(msg.sender, _to, _value); // Emit transfer event
        return true;
    }

    // Function to approve another address to spend tokens on behalf of the sender
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value; // Set the allowance
        emit Approval(msg.sender, _spender, _value); // Emit approval event
        return true;
    }

    // Function to transfer tokens on behalf of another address
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from], "Insufficient balance"); // Check balance of from address
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance"); // Check allowance

        balanceOf[_from] -= _value; // Deduct from sender's balance
        balanceOf[_to] += _value; // Add to recipient's balance
        allowance[_from][msg.sender] -= _value; // Adjust the allowance
        emit Transfer(_from, _to, _value); // Emit transfer event
        return true;
    }
}