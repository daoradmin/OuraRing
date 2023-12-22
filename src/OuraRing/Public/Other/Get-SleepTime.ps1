<#
.SYNOPSIS
Retrieves sleep time data from the Oura Ring API.

.DESCRIPTION
The Get-OuraSleepTime function retrieves sleep time data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the sleep time data range.

.PARAMETER endDate
The end date of the sleep time data range.

.EXAMPLE
Get-OuraSleepTime -startDate "2022-01-01" -endDate "2022-01-31"

This example retrieves sleep time data from January 1, 2022, to January 31, 2022.

#>
function Get-SleepTime {
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
            Uri = "https://api.ouraring.com/v2/usercollection/sleep_time"
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