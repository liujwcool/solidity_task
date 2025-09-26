// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleERC20 {
    string public name;
    string public symbol;
    uint8 public constant decimals = 18;

    uint256 private _totalSupply;
    address public owner;

    // 某个账户的余额
    mapping (address => uint256) _balances;
    
    // A账户owner授权给B账户的额度
    mapping (address => mapping (address => uint256)) private _allowances;

    // 代币转移事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // 授权事件
    event Approval(address indexed owner, address indexed spender, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    constructor(string memory tokenName, string memory tokenSymol, uint256 initialSupplyTokens) {
        owner = msg.sender;
        name = tokenName;
        symbol = tokenSymol;
        
        if (initialSupplyTokens > 0) {
            uint256 ammount = initialSupplyTokens * 10 ** uint256(decimals);
            _mint(msg.sender, ammount);
        }
    }
    

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view  returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        address from = msg.sender;
        _transfer(from, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        _approve(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address spender) public view returns(uint256) {
        return _allowances[_owner][spender];
    }

    // 增发代币（仅所有者）
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }


    // === 内部方法 ==

    // 挖矿 增发代币
    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "mint to zero");
        _totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(from != address(0), "transfer from zero");
        require(to != address(0), "transfer to zero");

        // 要求转出的余额要大于value值
        require(value <= _balances[from], "transfer insufficient");
        _balances[from] -= value;
        _balances[to] += value;
        emit Transfer(from, to, value);
    }

    // _owner授权给spender金额数量amount
    function _approve(address _owner, address spender, uint256 amount) internal {
        require(_owner != address(0), "approve from zero");
        require(spender != address(0), "approve to zero");
        _allowances[_owner][spender] = amount;

        emit Approval(_owner, spender, amount);
    }

    // 花费之后要减掉授权金额
    function _spendAllowance(address _owner, address spender, uint256 amount) internal {
        uint256 currentAllowance = _allowances[_owner][spender];
        require(currentAllowance >= amount, "allowance insufficient");
        _approve(_owner, spender, currentAllowance - amount);
    }

}