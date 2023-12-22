<#
.SYNOPSIS
Retrieves session data from the Oura Ring API.

.DESCRIPTION
The Get-OuraSessions function retrieves session data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the date range for which session data should be retrieved.

.PARAMETER endDate
The end date of the date range for which session data should be retrieved.

.EXAMPLE
Get-OuraSessions -startDate "2022-01-01" -endDate "2022-01-31"

This example retrieves session data from January 1, 2022, to January 31, 2022.

#>
function Get-Sessions {
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
            Uri = "https://api.ouraring.com/v2/usercollection/session"
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