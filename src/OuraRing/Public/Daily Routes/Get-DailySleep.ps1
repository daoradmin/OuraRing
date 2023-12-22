<#
.SYNOPSIS
Retrieves daily sleep data from the Oura API.

.DESCRIPTION
The Get-OuraDailySleep function retrieves daily sleep data from the Oura API for a specified date range.

.PARAMETER startDate
The start date of the date range for which to retrieve sleep data.

.PARAMETER endDate
The end date of the date range for which to retrieve sleep data.

.EXAMPLE
Get-OuraDailySleep -startDate "2022-01-01" -endDate "2022-01-07"

This example retrieves daily sleep data from January 1, 2022 to January 7, 2022.

#>
function Get-DailySleep {
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
            Uri = "https://api.ouraring.com/v2/usercollection/daily_sleep"
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