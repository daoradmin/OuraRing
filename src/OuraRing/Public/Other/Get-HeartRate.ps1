<#
.SYNOPSIS
Retrieves heart rate data from the Oura Ring API.

.DESCRIPTION
The Get-OuraHeartRate function retrieves heart rate data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the date range for which to retrieve heart rate data.

.PARAMETER endDate
The end date of the date range for which to retrieve heart rate data.

.EXAMPLE
Get-OuraHeartRate -startDate "2022-01-01" -endDate "2022-01-31"
Retrieves heart rate data from January 1, 2022 to January 31, 2022.

.INPUTS
None.

.OUTPUTS
System.Object.

.NOTES
This function requires the Get-AccessToken function to retrieve the access token for authentication.

.LINK
https://api.ouraring.com/v2/usercollection/heartrate

#>
function Get-HeartRate {
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
            Uri = "https://api.ouraring.com/v2/usercollection/heartrate"
            Method = "GET"
            Headers = @{Authorization = "Bearer $token"}
            Body = @{start_date = $startDate; end_date = $endDate}
        }
        $response = Invoke-RestMethod @params
    }
    catch {
        $_
    }
    return $response
}