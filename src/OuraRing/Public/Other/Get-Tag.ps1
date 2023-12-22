<#
.SYNOPSIS
Retrieves tag data from the Oura API for a specified date range.

.DESCRIPTION
The Get-OuraTag function retrieves tag data from the Oura API for a specified date range. It requires the start date and end date as mandatory parameters.

.PARAMETER startDate
The start date of the date range for which to retrieve tag data.

.PARAMETER endDate
The end date of the date range for which to retrieve tag data.

.EXAMPLE
Get-OuraTag -startDate "2022-01-01" -endDate "2022-01-31"
Retrieves tag data from the Oura API for the month of January 2022.

#>

function Get-Tag {
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
            Uri = "https://api.ouraring.com/v2/usercollection/tag"
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