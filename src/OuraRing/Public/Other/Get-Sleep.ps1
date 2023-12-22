<#
.SYNOPSIS
Retrieves sleep data from the Oura Ring API.

.DESCRIPTION
The Get-OuraSleep function retrieves sleep data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the sleep data range.

.PARAMETER endDate
The end date of the sleep data range.

.EXAMPLE
Get-OuraSleep -startDate "2022-01-01" -endDate "2022-01-07"

This example retrieves sleep data from January 1, 2022 to January 7, 2022.

#>
function Get-Sleep {
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
            Uri = "https://api.ouraring.com/v2/usercollection/sleep"
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