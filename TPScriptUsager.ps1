# Travail Pratique 3 - Creating users through scripting
# Travail remis dans le cadre du cours Systèmes d'exploitation 
# 420-W12-SF
# 17 Décembre 2021

# Début du script
Clear-Host # Mise à zéro du terminal
Set-Location C:\TPSE\ # Emplacement des opérations
$ErrorActionPreference = "Stop" # Prévention des erreurs
$Names = Get-Content .\nom.csv # Déclaration - Contenu du fichier source
$Group = "Entreprise" # Déclaration variable à usage multiple
try {
    Get-LocalGroup $Group # Validation de l'existence du groupe
}
catch {  
    New-LocalGroup -Name $Group # Création du groupe si non-existant
}
try {
    Get-Item $Group # Validation de l'existence du répertoire
}
catch {
    New-Item -ItemType "directory" -Name $Group # Création du répertoire si non-existant
}
# Boucle effectuant les opérations
foreach ($Name in $Names) {    
    $UserName = $Name.split(' ')[1] # Obtention du nom de famille seul
    $UserName = $Name[0] + $UserName # Concaténation de la première lettre du prénom et du nom de famille
    $UserName = $UserName.ToLower() # Convertir le tout en minuscules pour obtention du format désiré    
    Remove-LocalUser -Name $UserName
    Remove-LocalGroupMember -Name $Group -Member $UserName # Ajout de l'utilisateur au groupe
    Remove-Item -Name $UserName -ItemType "directory" -Path $Group # Création d'un dossier au nom de l'utilisateur
    $FilePathGreetings = "$($Group)\$($UserName)" # Déclaration - Emplacement du futur fichier contenant le message de bienvenue
    $FileGreetings = "Greetings $($UserName).txt" # Déclaration - Nom du futur fichier contenant le message de bienvenue
    Remove-Item -Name $FileGreetings -ItemType "file" -Path $FilePathGreetings -Value "Bienvenue $($Name)." # Création du fichier contenant le message de bienvenue
    
}
Write-Host "Script Terminé - Usagers Ajoutés" # Fin du script




