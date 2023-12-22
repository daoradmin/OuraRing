<#
.SYNOPSIS
Retrieves the daily activity data from the Oura Ring API.

.DESCRIPTION
The Get-OuraDailyActivity function retrieves the daily activity data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the date range for which to retrieve the daily activity data.

.PARAMETER endDate
The end date of the date range for which to retrieve the daily activity data.

.EXAMPLE
Get-OuraDailyActivity -startDate "2022-01-01" -endDate "2022-01-07"
Retrieves the daily activity data from January 1, 2022 to January 7, 2022.

.INPUTS
None.

.OUTPUTS
System.Object

.NOTES
This function requires the Get-OuraAccessToken function to retrieve the access token for authentication with the Oura Ring API.

.LINK
https://api.ouraring.com/v2/usercollection/daily_activity
The Oura Ring API documentation for the daily activity endpoint.
#>
function Get-DailyActivity {
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
            Uri = "https://api.ouraring.com/v2/usercollection/daily_activity"
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