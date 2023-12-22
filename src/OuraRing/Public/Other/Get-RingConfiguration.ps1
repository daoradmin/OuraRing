<#
.SYNOPSIS
Retrieves the ring configuration data for a specified date range.

.DESCRIPTION
The Get-OuraRingConfiguration function retrieves the ring configuration data from the Oura API for a specified date range. It requires the start date and end date as mandatory parameters.

.PARAMETER startDate
The start date of the date range for which to retrieve the ring configuration data.

.PARAMETER endDate
The end date of the date range for which to retrieve the ring configuration data.

.EXAMPLE
Get-OuraRingConfiguration -startDate "2022-01-01" -endDate "2022-01-31"
Retrieves the ring configuration data for the month of January 2022.

#>
function Get-RingConfiguration {
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
            Uri = "https://api.ouraring.com/v2/usercollection/ring_configuration"
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