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

1. Update the follwing fields in the powershell script
    ```powershell
    "TENANT ID"
 "PATH TO OLD APP MANIFEST
    ```

2. Run the script:
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

## Example Manifest

Here is an example of the JSON manifest that the script can process:

```json
{
    "id": "4111c311-bcf7-4d6b-a919-6b016aab8a61",
    "appId": "fe1f72fa-dde3-48fc-a033-615666a7ab50",
    "displayName": "AudreysNewApp",
    "description": null,
    "signInAudience": "AzureADMyOrg",
    "publisherDomain": "AudreysAZExam.onmicrosoft.com",
    "api": {
        "acceptMappedClaims": null,
        "knownClientApplications": [],
        "requestedAccessTokenVersion": null,
        "oauth2PermissionScopes": [],
        "preAuthorizedApplications": []
    },
    "appRoles": [],
    "info": {
        "logoUrl": null,
        "marketingUrl": null,
        "privacyStatementUrl": null,
        "supportUrl": null,
        "termsOfServiceUrl": null
    },
    "keyCredentials": [],
    "passwordCredentials": [
        {
            "customKeyIdentifier": null,
            "displayName": "Provider SP secret",
            "endDateTime": "2023-02-22T19:39:55.621Z",
            "hint": "SiY",
            "keyId": "88d97a80-d72f-4892-b6c6-84e3fe2ff4b8",
            "secretText": null,
            "startDateTime": "2022-08-22T18:39:55.621Z"
        }
    ],
    "web": {
        "redirectUris": []
    }
}
