<#
.SYNOPSIS
Retrieves workout data from the Oura Ring API.

.DESCRIPTION
The Get-OuraWorkout function retrieves workout data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the date range for which to retrieve workout data.

.PARAMETER endDate
The end date of the date range for which to retrieve workout data.

.EXAMPLE
Get-OuraWorkout -startDate "2022-01-01" -endDate "2022-01-31"
Retrieves workout data from January 1, 2022 to January 31, 2022.

#>
function Get-Workout {
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
            Uri = "https://api.ouraring.com/v2/usercollection/workout"
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