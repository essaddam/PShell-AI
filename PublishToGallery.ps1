param(
    [Parameter(Mandatory = $true)]
    [string]$NuGetApiKey
)

$p = @{
    Name        = "PShell-AI"
    NuGetApiKey = $NuGetApiKey
}

Publish-Module @p
