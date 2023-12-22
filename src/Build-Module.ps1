$ErrorActionPreference = "Stop"
try {
    
    $CurrentDirectory = $PSScriptRoot
    $ModulePath = "$CurrentDirectory/OuraRing"
    
    #Changing Directory to the module root
    Set-Location $CurrentDirectory
    
    #Getting Current Manifest Info
    if (Test-Path "$ModulePath/OuraRing.psd1"){
        $ManifestInfo = Test-ModuleManifest -Path "$ModulePath/OuraRing.psd1"
    }
    
    #Getting Public Functions to Export
    $PublicFunctions = Get-ChildItem -Path "$ModulePath/Public" -Recurse -Filter "*.ps1"

    
    #Creating Module Manifest
    $Params = @{
        Author = "daoradmin"
        CompanyName = "daoradmin"
        Description = "Powershell Module for Oura Ring"
        ModuleVersion = "1.0.0"
        PowerShellVersion = "5.1"
        Path = "$ModulePath/OuraRing.psd1"
        FunctionsToExport = $PublicFunctions | Select-Object -ExpandProperty BaseName
        ProjectUri = "https://github.com/daoradmin/OuraRing"
        LicenseUri = "https://github.com/daoradmin/OuraRing/blob/master/LICENSE.txt"
        Tags = @("PSMODULE", "OuraRing", "Oura", "Ring")
        RootModule = "OuraRing.psm1"
        DefaultCommandPrefix = "Oura"
    }
    
    #Checking if the module version is the same as the current version
    #If it is the same, then we will not update the module version
    if ($Params.ModuleVersion -eq $ManifestInfo.Version){
        Write-Warning "Module version is the same as the current version"
        Write-Warning "Please update the module version!"
        return
    }
    
    #Creating Module Manifest
    New-ModuleManifest @Params
    
    #Creating ADO-PSModule.psm1 file
    New-Item -Path "$ModulePath/OuraRing.psm1" -ItemType File -Force | Out-Null
    
    $AllFunctions = @()
    $AllFunctions += (Get-ChildItem -Path "$ModulePath/Private" -Recurse -Filter "*.ps1")
    $AllFunctions += $PublicFunctions
    
    foreach ($Function in $AllFunctions){
        $Content = Get-Content -Path $Function.ResolvedTarget
        #Adding content to ADO-PSModule.psm1 file
        Add-Content -Path "$ModulePath/OuraRing.psm1" -Value $Content
    }
}
catch {
    $_
}