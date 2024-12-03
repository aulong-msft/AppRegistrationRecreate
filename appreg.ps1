# Install the Microsoft Graph PowerShell SDK if not already installed
Install-Module Microsoft.Graph -Scope CurrentUser

# Connect to the tenant
Connect-MgGraph -Scopes "Application.ReadWrite.All" -TenantId "TENANT ID"

# Read the manifest JSON file
$manifest = Get-Content -Path "PATH TO OLD APP MANIFEST" -Raw | ConvertFrom-Json

# Extract necessary properties from the manifest
$appName = $manifest.displayName
$appDescription = if ($null -ne $manifest.description -and $manifest.description -ne "") { $manifest.description } else { $null }
$signInAudience = $manifest.signInAudience

# Convert the Api property to the correct type
$api = @{
    acceptMappedClaims = $manifest.api.acceptMappedClaims
    knownClientApplications = $manifest.api.knownClientApplications
    requestedAccessTokenVersion = $manifest.api.requestedAccessTokenVersion
    oauth2PermissionScopes = $manifest.api.oauth2PermissionScopes
    preAuthorizedApplications = $manifest.api.preAuthorizedApplications
}

# Convert the Info property to the correct type
$info = @{
    logoUrl = $manifest.info.logoUrl
    marketingUrl = $manifest.info.marketingUrl
    privacyStatementUrl = $manifest.info.privacyStatementUrl
    supportUrl = $manifest.info.supportUrl
    termsOfServiceUrl = $manifest.info.termsOfServiceUrl
}

# Convert the PasswordCredentials property to the correct type, excluding the Hint and KeyId properties
$passwordCredentials = @()
foreach ($cred in $manifest.passwordCredentials) {
    $passwordCredentials += [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphPasswordCredential]@{
        CustomKeyIdentifier = $cred.customKeyIdentifier
        DisplayName = $cred.displayName
        EndDateTime = (Get-Date).AddMonths(6).ToString("yyyy-MM-ddTHH:mm:ssZ")
        SecretText = $cred.secretText
        StartDateTime = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
    }
}

# Extract redirect URIs
$redirectUris = $manifest.web.redirectUris

# Convert the requiredResourceAccess property to the correct type
$requiredResourceAccess = @()
foreach ($resource in $manifest.requiredResourceAccess) {
    $resourceAccess = @()
    foreach ($access in $resource.resourceAccess) {
        $resourceAccess += [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphResourceAccess]@{
            Id = $access.id
            Type = $access.type
        }
    }
    $requiredResourceAccess += [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphRequiredResourceAccess]@{
        ResourceAppId = $resource.resourceAppId
        ResourceAccess = $resourceAccess
    }
}

$appRoles = $manifest.appRoles
$keyCredentials = $manifest.keyCredentials

# Create a new app registration in the target tenant
if ($appDescription) {
    $newApp = New-MgApplication -DisplayName $appName -Description $appDescription -SignInAudience $signInAudience -Api $api -AppRoles $appRoles -Info $info -KeyCredentials $keyCredentials -PasswordCredentials $passwordCredentials -Web @{ RedirectUris = $redirectUris } -RequiredResourceAccess $requiredResourceAccess
} else {
    $newApp = New-MgApplication -DisplayName $appName -SignInAudience $signInAudience -Api $api -AppRoles $appRoles -Info $info -KeyCredentials $keyCredentials -PasswordCredentials $passwordCredentials -Web @{ RedirectUris = $redirectUris } -RequiredResourceAccess $requiredResourceAccess
}

# Output the new app registration details
$newApp | Format-List

# Disconnect from the tenant
Disconnect-MgGraph
