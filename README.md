# App Registration Migration Script

This PowerShell script allows you to migrate an app registration from one tenant to another using the Microsoft Graph PowerShell SDK. The script reads an app registration manifest in JSON format and recreates the app registration in the target tenant.

## Prerequisites

- PowerShell 5.1 or later
- Microsoft Graph PowerShell SDK

## Installation

1. Install the Microsoft Graph PowerShell SDK if not already installed:
    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    ```

## Usage

1. Navigate to your old app registration -> Manage -> Manifest and download that manifest file for your application registration you want to recreate.
   
1. Update the follwing fields in the powershell script
 - "TENANT ID"
 - "PATH TO OLD APP MANIFEST

1. Run the script:
    ```powershell
    .\YourScript.ps1
    ```

    Replace `YourScript.ps1` with the name of your PowerShell script file.

## Script Details

The script performs the following steps:

1. Connects to the tenant using the Microsoft Graph PowerShell SDK.
2. Reads the app registration manifest JSON file.
3. Extracts necessary properties from the manifest.
4. Converts properties to the correct types as required by the Microsoft Graph API.
5. Creates a new app registration in the target tenant with the extracted properties.
6. Outputs the details of the new app registration.


