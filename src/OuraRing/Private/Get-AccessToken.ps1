function Get-AccessToken {
    try {
        $accessToken = ConvertFrom-SecureString -SecureString $global:ouraAccessToken -AsPlainText
    }
    catch {
        throw "No access token found. Please run Connect-Oura first."
    }

    return $accessToken
}