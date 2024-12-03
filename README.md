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
    .\appreg.ps1
    ```
Please note, you will log in with the user credentials belonging to the tenant you would like to recreate the application registration in, you will also need Entra tenant admin priviledges to create the app registration and secrets.

## Script Details

The script performs the following steps:

1. Connects to the tenant using the Microsoft Graph PowerShell SDK.
2. Reads the app registration manifest JSON file.
3. Extracts necessary properties from the manifest such as secrets and redirect URIs.
4. This script will recreate the secrets with a start day of the time the script was ran, and will expire 6 months after creation.
5. Converts properties to the correct types as required by the Microsoft Graph API.
6. Creates a new app registration in the target tenant with the extracted properties.
7. Outputs the details of the new app registration.


