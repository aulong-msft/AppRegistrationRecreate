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
1. Reads the app registration manifest JSON file.
1. Extracts necessary properties from the manifest such as secrets and redirect URIs.
1. Converts properties to the correct types as required by the Microsoft Graph API.
1. Creates a new app registration in the target tenant with the extracted properties.
1. Outputs the details of the new app registration.

## Notes
- Ensure that you have the necessary permissions to create and manage app registrations in the target tenant.
- The script sets the StartDateTime for the PasswordCredentials to today's date and the EndDateTime to 6 months from the start date.
- The publisherDomain property is read-only and cannot be set during app creation.
- The script now handles API permissions by including the requiredResourceAccess property.
- If your app uses certificates for authentication, you will need to handle the keyCredentials property properly. This might involve uploading certificates to the new app registration.

