function Invoke-AIChat {
    <#
    .SYNOPSIS
    Sends a chat completion request to an OpenAI-compatible API endpoint.

    .DESCRIPTION
    Internal function used by the q command to call OpenRouter, Synthetic,
    or any OpenAI-compatible provider directly via REST API.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Prompt,

        [Parameter(Mandatory)]
        [string]$SystemMessage,

        [Parameter(Mandatory)]
        [string]$Model,

        [Parameter(Mandatory)]
        [string]$BaseUrl,

        [Parameter(Mandatory)]
        [string]$ApiKey
    )

    $body = @{
        model    = $Model
        messages = @(
            @{ role = "system"; content = $SystemMessage }
            @{ role = "user"; content = $Prompt }
        )
    } | ConvertTo-Json -Depth 10

    $headers = @{
        "Authorization" = "Bearer $ApiKey"
        "Content-Type"  = "application/json"
    }

    $response = Invoke-RestMethod -Uri "$BaseUrl/chat/completions" -Method Post -Headers $headers -Body $body
    $response.choices[0].message.content
}

function Invoke-AIChatConversation {
    <#
    .SYNOPSIS
    Manages a multi-turn conversation with an OpenAI-compatible API endpoint.

    .DESCRIPTION
    Internal function that maintains message history for follow-up conversations
    with OpenRouter, Synthetic, or any OpenAI-compatible provider.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Prompt,

        [Parameter(Mandatory)]
        [System.Collections.ArrayList]$Messages,

        [Parameter(Mandatory)]
        [string]$Model,

        [Parameter(Mandatory)]
        [string]$BaseUrl,

        [Parameter(Mandatory)]
        [string]$ApiKey
    )

    $Messages.Add(@{ role = "user"; content = $Prompt }) | Out-Null

    $body = @{
        model    = $Model
        messages = $Messages.ToArray()
    } | ConvertTo-Json -Depth 10

    $headers = @{
        "Authorization" = "Bearer $ApiKey"
        "Content-Type"  = "application/json"
    }

    $response = Invoke-RestMethod -Uri "$BaseUrl/chat/completions" -Method Post -Headers $headers -Body $body
    $content = $response.choices[0].message.content

    $Messages.Add(@{ role = "assistant"; content = $content }) | Out-Null

    $content
}
