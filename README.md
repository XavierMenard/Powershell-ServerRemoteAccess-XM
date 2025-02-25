# Powershell-ServerRemoteAccess
Open Source Scripts By Xavier Menard

Ce script permet à l'utilisateur de se connecter à un serveur local via PowerShell, avec une vérification simple de la connexion en affichant une liste des processus en cours sur le serveur. Assure-toi de remplacer les valeurs de $serverName et $userName avec celles qui conviennent à ton environnement.


# ServerRemoteAccess.ps1

**ServerRemoteAccess.ps1** est un script PowerShell permettant de se connecter à un serveur local depuis un autre ordinateur sur le réseau. Il utilise une authentification par nom d'utilisateur et mot de passe.

## Fonctionnalités

- Connexion sécurisée à un serveur via PowerShell.
- Authentification par nom d'utilisateur et mot de passe.
- Personnalisation facile des paramètres tels que le nom du serveur et le nom d'utilisateur.
- Test de la connexion en exécutant une commande sur le serveur distant (par exemple, `Get-Process`).

## Prérequis

- PowerShell version 5.1 ou supérieure.
- Le script doit être exécuté sur un réseau local avec des connexions sécurisées.
- Accès au serveur avec des informations d'identification valides.

## Installation

1. Clonez ce projet en utilisant Git :

   ```bash
   git clone https://github.com/XavierMenard/Powershell-ServerRemoteAccess-XM.git
