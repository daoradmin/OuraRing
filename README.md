# Oura Ring

Powershell Module for Oura Ring.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

1. Use following command to install module : "Install-Module Oura.Ring"

## Usage

1. Go to https://cloud.ouraring.com/personal-access-tokens and create an access token.
2. Create a secure string with your access token.
    1. $accessToken = "xxxxx"
    2. $secureString = ConvertTo-SecureString -String $accessToken -AsPlainText -Force
    3. Connect-OuraRing -AccessToken $secureString

3. Use "Get-Command -Module Oura.Ring" to see all cmdlets.