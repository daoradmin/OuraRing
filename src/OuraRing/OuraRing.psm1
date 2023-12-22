function Get-AccessToken {
    try {
        $accessToken = ConvertFrom-SecureString -SecureString $global:ouraAccessToken -AsPlainText
    }
    catch {
        throw "No access token found. Please run Connect-Oura first."
    }

    return $accessToken
}
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
<#
.SYNOPSIS
Retrieves personal information from the Oura Ring API.

.DESCRIPTION
The Get-OuraPersonalInfo function retrieves personal information from the Oura Ring API by making a GET request to the "https://api.ouraring.com/v2/usercollection/personal_info" endpoint. It requires an access token obtained from the Get-AccessToken function.

.PARAMETER None
This function does not accept any parameters.

.EXAMPLE
Get-OuraPersonalInfo
Returns the personal information retrieved from the Oura Ring API.

.NOTES
This function is part of the Oura.Ring module.
#>
function Get-PersonalInfo {
        
    try {
        $token = Get-AccessToken
    }
    catch {
        return $_
    }

    try {
        $params = @{
            Uri = "https://api.ouraring.com/v2/usercollection/personal_info"
            Method = "GET"
            Headers = @{Authorization = "Bearer $token"}
        }
        $response = Invoke-RestMethod @params
    }
    catch {
        $_
    }

    return $response
}
<#
.SYNOPSIS
Retrieves the rest mode period for a given start date and end date.

.DESCRIPTION
The Get-OuraRestModePeriod function retrieves the rest mode period for a given start date and end date from the Oura Ring API. It requires an access token obtained from the Get-AccessToken function.

.PARAMETER startDate
The start date of the rest mode period.

.PARAMETER endDate
The end date of the rest mode period.

.EXAMPLE
Get-OuraRestModePeriod -startDate "2022-01-01" -endDate "2022-01-07"

This example retrieves the rest mode period from January 1, 2022, to January 7, 2022.

.INPUTS
None.

.OUTPUTS
System.Object.

.NOTES
Author: daoradmin
Date: Current Date

.LINK
https://api.ouraring.com/v2/usercollection/rest_mode_period
#>
function Get-RestModePeriod {
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
            Uri = "https://api.ouraring.com/v2/usercollection/rest_mode_period"
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
<#
.SYNOPSIS
Retrieves session data from the Oura Ring API.

.DESCRIPTION
The Get-OuraSessions function retrieves session data from the Oura Ring API for a specified date range.

.PARAMETER startDate
The start date of the date range for which session data should be retrieved.

.PARAMETER endDate
The end date of the date range for which session data should be retrieved.

.EXAMPLE
Get-OuraSessions -startDate "2022-01-01" -endDate "2022-01-31"

This example retrieves session data from January 1, 2022, to January 31, 2022.

#>
function Get-Sessions {
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
            Uri = "https://api.ouraring.com/v2/usercollection/session"
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
<#
.SYNOPSIS
Connects to the Oura API using the provided access token.

.DESCRIPTION
The Connect-OuraRing function connects to the Oura API using the provided access token. It verifies the connection by making a GET request to the personal_info endpoint of the API.

.PARAMETER accessToken
The access token required to authenticate with the Oura API. This should be a SecureString object.

.EXAMPLE
$accessToken = ConvertTo-SecureString -String "myAccessToken" -AsPlainText -Force
Connect-OuraRing -accessToken $accessToken

This example demonstrates how to connect to the Oura API using an access token.

.NOTES
Author: daoradmin
Date: Current Date
#>
function Connect-Ring {
    param (
        [Parameter(Mandatory=$true)]
        [securestring]$accessToken
    )

    try {
        $token = ConvertFrom-SecureString -SecureString $accessToken -AsPlainText
        
        try {
            $checkParams = @{
                Uri = "https://api.ouraring.com/v2/usercollection/personal_info"
                Method = "GET"
                Headers = @{Authorization = "Bearer $token"}
            }
            
            $reponse = Invoke-RestMethod @checkParams
        }
        catch {
            return Write-Error "Could not connect to Oura API. Please check your access token and try again."
        }

        if ($global:ouraAccessToken) {
            Write-Warning "You are already connected to the Oura API. If you want to connect to a different account, please disconnect first."
            return
        }
        else {
            $global:ouraAccessToken = $accessToken
            Write-Output "Successfully connected to Oura API."
        }

    }
    catch {
        $_
    }
    
}
<#
.SYNOPSIS
Disconnects from the Oura API.

.DESCRIPTION
The Disconnect-OuraRing function is used to disconnect from the Oura API.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disconnect-OuraRing
Disconnects from the Oura API.

.NOTES
Author: daoradmin
Date: Current Date
#>
function Disconnect-Ring {
    try {
        if ($global:ouraAccessToken) {
            $global:ouraAccessToken = $null
            Write-Output "Successfully disconnected from Oura API."
        }
        else {
            Write-Warning "You are not connected to the Oura API."
        }
    }
    catch {
        $_
    }
}
