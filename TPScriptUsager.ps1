# Travail Pratique 3 - Creating users through scripting
# Travail remis dans le cadre du cours Systèmes d'exploitation 
# 420-W12-SF
# 17 Décembre 2021

# Début du script
Clear-Host # Mise à zéro du terminal
Set-Location C:\TPSE\ # Emplacement des opérations
$ErrorActionPreference = "Stop" # Prévention des erreurs

$Names = Get-Content .\nom.csv # Déclaration - Contenu du fichier source
$Group = "Entreprise" # Déclaration variable

try {
    Get-LocalGroup $Group # Validation de l'existence du groupe
}
catch {  
    New-LocalGroup -Name $Group # Création du groupe
}
try {
    Get-Item $Group # Validation de l'existence du répertoire
}
catch {
    New-Item -ItemType "directory" -Name $Group # Création du répertoire
}



