$script:defaultModel = 'gpt-4o-mini'
$script:aiProvider = 'OpenAI'

$script:providerDefaults = @{
    OpenAI     = @{
        BaseUrl      = 'https://api.openai.com/v1'
        ApiKeyEnv    = 'OpenAIKey'
        DefaultModel = 'gpt-4o-mini'
    }
    OpenRouter = @{
        BaseUrl      = 'https://openrouter.ai/api/v1'
        ApiKeyEnv    = 'OpenRouterKey'
        DefaultModel = 'openai/gpt-4o-mini'
    }
    Synthetic  = @{
        BaseUrl      = 'https://api.glhf.chat/v1'
        ApiKeyEnv    = 'SyntheticKey'
        DefaultModel = 'hf:meta-llama/Meta-Llama-3.1-70B-Instruct'
    }
}

. $PSScriptRoot\Private\Invoke-AIChat.ps1
. $PSScriptRoot\Public\q.ps1

function Get-DefaultModel {
    $script:defaultModel
}

function Set-DefaultModel {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$model
    )

    Write-Verbose "Setting default model to $model"
    $script:defaultModel = $model
}

function Get-AIProvider {
    [CmdletBinding()]
    param()

    [PSCustomObject]@{
        Provider = $script:aiProvider
        BaseUrl  = $script:providerDefaults[$script:aiProvider].BaseUrl
        ApiKeyEnv = $script:providerDefaults[$script:aiProvider].ApiKeyEnv
        Model    = $script:defaultModel
    }
}

function Set-AIProvider {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("OpenAI", "OpenRouter", "Synthetic")]
        [string]$Provider
    )

    $script:aiProvider = $Provider
    $script:defaultModel = $script:providerDefaults[$Provider].DefaultModel
    Write-Verbose "Provider set to $Provider (model: $($script:defaultModel))"
}
