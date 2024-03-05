// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MLToken is IERC20, Ownable {
    using SafeMath for uint256;

    // Définir les paramètres de distribution
    uint256 public constant R = 1000000; // Valeur arbitraire, ajustez selon vos besoins
    uint256 public constant alpha = 1; // Valeur arbitraire, ajustez selon vos besoins
    uint256 public constant u = 1; // Valeur arbitraire, ajustez selon vos besoins


    constructor(uint256 initialSupply) ERC20("MLToken", "MLT") {
            _mint(msg.sender, initialSupply);
        }

    // Fonction pour vérifier si l'utilisateur a entraîné le modèle
    function verifyModelTraining() external onlyOwner {
            // Ajoutez ici la logique pour vérifier l'entraînement du modèle
        }
    
    // Fonction de distribution personnalisée
    function distributeTokens(uint256 numberOfUpdates) external onlyOwner {
        require(numberOfUpdates > 0, "Number of updates must be greater than 0");

        // Calculer la quantité de jetons à distribuer
        uint256 tokensToDistribute = calculateDistribution(numberOfUpdates);

        // Distribuer les jetons au premier utilisateur du modèle
        _mint(firstModelUser, tokensToDistribute);
    }

    // Fonction de calcul de la distribution
    function calculateDistribution(uint256 numberOfUpdates) public view returns (uint256) {
        // Utiliser la formule de distribution
        return (R * alpha) / u * (2**numberOfUpdates - 1);
    }
}


    // // C'est cette fonction que'on va devoir modifier pour vérifier si l'utilisateur a bien entrainé le modèle

    // function mint(address account, uint256 amount) external onlyOwner {
    //     require(account != address(0), "ERC20: mint to the zero address");
    //     _totalSupply = _totalSupply.add(amount);
    //     _balances[account] = _balances[account].add(amount);
    //     emit Transfer(address(0), account, amount);
    // }

}
