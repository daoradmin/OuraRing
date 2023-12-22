<#
.SYNOPSIS
Retrieves daily SpO2 data from the Oura Ring API.

.DESCRIPTION
The Get-OuraDailySpo2 function retrieves daily SpO2 (oxygen saturation) data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the date range for which to retrieve SpO2 data.

.PARAMETER endDate
The end date of the date range for which to retrieve SpO2 data.

.EXAMPLE
Get-OuraDailySpo2 -startDate "2022-01-01" -endDate "2022-01-07"
Retrieves daily SpO2 data from January 1, 2022 to January 7, 2022.

.INPUTS
None.

.OUTPUTS
System.Object

.NOTES
This function requires the Get-OuraAccessToken function to retrieve the access token for authenticating with the Oura Ring API.

.LINK
https://api.ouraring.com/v2/usercollection/daily_spo2

#>
function Get-DailySpo2 {
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
            Uri = "https://api.ouraring.com/v2/usercollection/daily_spo2"
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