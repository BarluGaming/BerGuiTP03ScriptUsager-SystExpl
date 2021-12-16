# Travail Pratique 3 - Creating users through scripting
# Travail remis dans le cadre du cours Systèmes d'exploitation 
# 420-W12-SF
# 17 Décembre 2021

# Début du script
Clear-Host
Set-Location C:\TPSE\

# Prévention des erreurs
$ErrorActionPreference = "Stop"

# Déclaration des variables
$Names = Get-Content .\nom.csv
$Group = "Entreprise"

# Création du groupe
New-LocalGroup -Name $Group

# Création du répertoire
New-Item -ItemType "directory" -Name $Group

