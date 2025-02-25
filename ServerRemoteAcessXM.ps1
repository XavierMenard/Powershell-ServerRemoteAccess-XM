#ServerRemoteAccess.ps1
# Script pour se connecter � un serveur local depuis un PC

# --- Configuration � modifier avant l'ex�cution ---
$serverName = "NomDuServeur"  # Nom du serveur local, � remplacer par le nom r�el du serveur
$userName = "NomUtilisateur"  # Nom d'utilisateur pour la connexion, � remplacer
$passwordPrompt = "Veuillez entrer votre mot de passe pour la connexion au serveur"  # Texte du prompt pour entrer le mot de passe

# --- Fin de la configuration ---

$OutputEncoding = New-Object -typename System.Text.UTF8Encoding  # Forcer l'encodage UTF-8

Add-Type -AssemblyName "System.Windows.Forms"  # Permet l'utilisation des bo�tes de dialogue

# Fonction pour cr�er un d�grad� de couleur
function Write-ColorGradient {
    param (
        [string]$text
    )

    $colors = @('Red', 'Yellow', 'Green', 'Cyan', 'Blue', 'Magenta', 'White')
    $colorIndex = 0
    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline ($char) -ForegroundColor $colors[$colorIndex]
        $colorIndex = ($colorIndex + 1) % $colors.Length
    }
    Write-Host ""
}

# Juste pour le fun
$asciiArt = @"
   _____                            _____                      _                                       
  / ____|                          |  __ \                    | |           /\                         
 | (___   ___ _ ____   _____ _ __  | |__) |___ _ __ ___   ___ | |_ ___     /  \   ___ ___ ___  ___ ___ 
  \___ \ / _ \ '__\ \ / / _ \ '__| |  _  // _ \ '_ ` _ \ / _ \| __/ _ \   / /\ \ / __/ __/ _ \/ __/ __|
  ____) |  __/ |   \ V /  __/ |    | | \ \  __/ | | | | | (_) | ||  __/  / ____ \ (_| (_|  __/\__ \__ \
 |_____/ \___|_|    \_/ \___|_|    |_|  \_\___|_| |_| |_|\___/ \__\___| /_/    \_\___\___\___||___/___/ v1
                                                                                                       
                                                                                                               
                                             By Xavier Menard   
                                      
                                                          
"@

# Appliquer un d�grad� couleur pour chaque ligne de l'ASCII Art
$asciiArt.Split("`n") | ForEach-Object { Write-ColorGradient $_ }

# Demander � l'utilisateur de fournir le mot de passe
$password = Read-Host $passwordPrompt -AsSecureString  # Mot de passe s�curis�

# Cr�er une session de connexion au serveur
$credential = New-Object System.Management.Automation.PSCredential($userName, $password)

# Tentative de connexion
try {
    # Essayer de cr�er la session
    $session = New-PSSession -ComputerName $serverName -Credential $credential -ErrorAction Stop
    Write-Host "Connexion r�ussie � $serverName !"

    # Ex�cuter une commande test sur le serveur
    Invoke-Command -Session $session -ScriptBlock {
        Get-Process
    }

    # Fermer la session
    Remove-PSSession -Session $session
} catch {
    # G�rer l'erreur si la connexion �choue
    $errorMessage = "Erreur de connexion � $serverName : $($_.Exception.Message)"
    Write-Host $errorMessage
    [System.Windows.Forms.MessageBox]::Show($errorMessage, "Erreur de connexion", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
}
