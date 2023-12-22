<#
.SYNOPSIS
Retrieves the rest mode period for a given start date and end date.

.DESCRIPTION
The Get-OuraRestModePeriod function retrieves the rest mode period for a given start date and end date from the Oura Ring API. It requires an access token obtained from the Get-AccessToken function.

.PARAMETER startDate
The start date of the rest mode period.

.PARAMETER endDate
The end date of the rest mode period.

.EXAMPLE
Get-OuraRestModePeriod -startDate "2022-01-01" -endDate "2022-01-07"

This example retrieves the rest mode period from January 1, 2022, to January 7, 2022.

.INPUTS
None.

.OUTPUTS
System.Object.

.NOTES
Author: daoradmin
Date: Current Date

.LINK
https://api.ouraring.com/v2/usercollection/rest_mode_period
#>
function Get-RestModePeriod {
    param (
        [Parameter(Mandatory=$true)]
        [datetime]$startDate,
        
        [Parameter(Mandatory=$true)]
        [datetime]$endDate
    )

    try {
        $token = Get-AccessToken
    }
    catch {
        return $_
    }
    
    try {
        $params = @{
            Uri = "https://api.ouraring.com/v2/usercollection/rest_mode_period"
            Method = "GET"
            Headers = @{Authorization = "Bearer $token"}
            Body = @{start_date = $startDate.ToString("yyyy-MM-dd"); end_date = $endDate.ToString("yyyy-MM-dd")}
        }
        $response = Invoke-RestMethod @params
    }
    catch {
        $_
    }
    return $response
}