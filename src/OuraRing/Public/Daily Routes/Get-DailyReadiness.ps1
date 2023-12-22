<#
.SYNOPSIS
Retrieves the daily readiness data for a specified date range.

.DESCRIPTION
The Get-OuraDailyReadiness function retrieves the daily readiness data from the Oura API for a specified start and end date. It requires an access token obtained from the Get-AccessToken function.

.PARAMETER startDate
The start date of the date range for which to retrieve the daily readiness data.

.PARAMETER endDate
The end date of the date range for which to retrieve the daily readiness data.

.EXAMPLE
Get-OuraDailyReadiness -startDate "2022-01-01" -endDate "2022-01-07"

This example retrieves the daily readiness data from January 1, 2022 to January 7, 2022.

#>

function Get-DailyReadiness {
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
            Uri = "https://api.ouraring.com/v2/usercollection/daily_readiness"
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