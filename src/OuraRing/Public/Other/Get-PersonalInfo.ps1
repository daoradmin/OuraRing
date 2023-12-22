<#
.SYNOPSIS
Retrieves personal information from the Oura Ring API.

.DESCRIPTION
The Get-OuraPersonalInfo function retrieves personal information from the Oura Ring API by making a GET request to the "https://api.ouraring.com/v2/usercollection/personal_info" endpoint. It requires an access token obtained from the Get-AccessToken function.

.PARAMETER None
This function does not accept any parameters.

.EXAMPLE
Get-OuraPersonalInfo
Returns the personal information retrieved from the Oura Ring API.

.NOTES
This function is part of the Oura.Ring module.
#>
function Get-PersonalInfo {
        
    try {
        $token = Get-AccessToken
    }
    catch {
        return $_
    }

    try {
        $params = @{
            Uri = "https://api.ouraring.com/v2/usercollection/personal_info"
            Method = "GET"
            Headers = @{Authorization = "Bearer $token"}
        }
        $response = Invoke-RestMethod @params
    }
    catch {
        $_
    }

    return $response
}