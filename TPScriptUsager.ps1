# Travail Pratique 3 - Creating users through scripting
# Travail remis dans le cadre du cours Systèmes d'exploitation 
# 420-W12-SF
# 17 Décembre 2021

# Début du script
Clear-Host # Mise à zéro du terminal
Set-Location D:\ # Emplacement des opérations
$ErrorActionPreference = "Stop" # Prévention des erreurs
try {
    Get-Item -Path D:\BerGuiTP03ScriptUsager-SystExpl\nom.csv # Validation de la présence du fichier source
}
catch {
    git clone https://github.com/BarluGaming/BerGuiTP03ScriptUsager-SystExpl.git # Récupération du fichier source si non-existant
}
$Names = Get-Content BerGuiTP03ScriptUsager-SystExpl\nom.csv # Déclaration - Contenu du fichier source
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
    $ExpiryDate = (Get-Date).AddMonths(6) # Déclaration - Date d'expiration en utilisant la date de création + 6 mois
    try {
        Get-LocalUser $UserName # Validation de l'existence de l'utilisateur
    }
    catch {
        New-LocalUser -Name $UserName -AccountExpires $ExpiryDate -Description "Utilisateur de l'Entreprise" -FullName $Name -NoPassword # Création de l'utilisateur si non-existant
        Add-LocalGroupMember -Name $Group -Member $UserName # Ajout de l'utilisateur au groupe
        New-Item -Name $UserName -ItemType "directory" -Path $Group # Création d'un dossier au nom de l'utilisateur
        $FilePathGreetings = "$($Group)\$($UserName)" # Déclaration - Emplacement du futur fichier contenant le message de bienvenue
        $FileGreetings = "Greetings $($UserName).txt" # Déclaration - Nom du futur fichier contenant le message de bienvenue
        New-Item -Name $FileGreetings -ItemType "file" -Path $FilePathGreetings -Value "Bienvenue $($Name)." # Création du fichier contenant le message de bienvenue
    }
}
Write-Host "Script Terminé - Usagers Ajoutés" # Fin du script




