$script:defaultModel = 'gpt-4o-mini'

. $PSScriptRoot\Public\q.ps1

function Get-DefaultModel {
    $script:defaultModel
}

function Set-DefaultModel {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet(
            "gpt-3.5-turbo",
            "gpt-4",
            "gpt-4-turbo",
            "gpt-4-turbo-2024-04-09",
            "gpt-4o",
            "gpt-4o-2024-05-13",
            "gpt-4o-2024-08-06",
            "gpt-4o-2024-11-20",
            "gpt-4o-mini",
            "gpt-4o-mini-2024-07-18",
            "gpt-4.1",
            "gpt-4.1-mini",
            "gpt-4.1-nano",
            "o1",
            "o1-mini",
            "o1-preview",
            "o3",
            "o3-mini",
            "o4-mini"
        )]
        [string]$model
    )

    Write-Verbose "Setting default model to $model"
    $script:defaultModel = $model
}
