<#
.SYNOPSIS
Connects to the Oura API using the provided access token.

.DESCRIPTION
The Connect-OuraRing function connects to the Oura API using the provided access token. It verifies the connection by making a GET request to the personal_info endpoint of the API.

.PARAMETER accessToken
The access token required to authenticate with the Oura API. This should be a SecureString object.

.EXAMPLE
$accessToken = ConvertTo-SecureString -String "myAccessToken" -AsPlainText -Force
Connect-OuraRing -accessToken $accessToken

This example demonstrates how to connect to the Oura API using an access token.

.NOTES
Author: daoradmin
Date: Current Date
#>
function Connect-Ring {
    param (
        [Parameter(Mandatory=$true)]
        [securestring]$accessToken
    )

    try {
        $token = ConvertFrom-SecureString -SecureString $accessToken -AsPlainText
        
        try {
            $checkParams = @{
                Uri = "https://api.ouraring.com/v2/usercollection/personal_info"
                Method = "GET"
                Headers = @{Authorization = "Bearer $token"}
            }
            
            $reponse = Invoke-RestMethod @checkParams
        }
        catch {
            return Write-Error "Could not connect to Oura API. Please check your access token and try again."
        }

        if ($global:ouraAccessToken) {
            Write-Warning "You are already connected to the Oura API. If you want to connect to a different account, please disconnect first."
            return
        }
        else {
            $global:ouraAccessToken = $accessToken
            Write-Output "Successfully connected to Oura API."
        }

    }
    catch {
        $_
    }
    
}