<#
.SYNOPSIS
Disconnects from the Oura API.

.DESCRIPTION
The Disconnect-OuraRing function is used to disconnect from the Oura API.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disconnect-OuraRing
Disconnects from the Oura API.

.NOTES
Author: daoradmin
Date: Current Date
#>
function Disconnect-Ring {
    try {
        if ($global:ouraAccessToken) {
            $global:ouraAccessToken = $null
            Write-Output "Successfully disconnected from Oura API."
        }
        else {
            Write-Warning "You are not connected to the Oura API."
        }
    }
    catch {
        $_
    }
}