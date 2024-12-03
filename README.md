# App Registration Recreation Script

This PowerShell script allows you to recreate an app registration from one tenant to another using the Microsoft Graph PowerShell SDK. The script reads an app registration manifest in JSON format and recreates the app registration in the target tenant.

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
- The script includes the preAuthorizedApplications property, but you might need to ensure that these applications are also registered and authorized in the target tenant.
- If your app uses optional claims, you will need to include the optionalClaims property in the script.
- If your app has specific branding settings (like a logo), you might need to handle these settings separately.
- The script currently handles web redirect URIs, but if your app supports other platforms (like mobile or SPA), you will need to include those redirect URIs as well.
- Ensure that all app roles and OAuth2 permission scopes are correctly set up in the new tenant.
- If your app has specific user or group assignments, you will need to recreate these assignments in the new tenant.
- If there are any conditional access policies associated with the app, you will need to recreate these policies in the new tenant.
- f your app is configured to be multi-tenant, ensure that the necessary settings are applied in the new tenant.

