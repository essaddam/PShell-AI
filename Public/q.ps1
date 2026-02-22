function q {
    [CmdletBinding()]
    param()

    $spectreInstalled = $null -ne (Get-Command Format-SpectrePanel -ErrorAction SilentlyContinue)

    $prompt = $args -join ' '

    if ([string]::IsNullOrWhiteSpace($prompt)) {
        Write-Warning "Please provide a prompt. Usage: q <your question or command description>"
        return
    }

    $instructions = @"
You are a terminal assistant. Turn the natural language instructions into a terminal command.

By default use PowerShell unless otherwise specified. Always only output code, no usage, explanation or examples.

- just the code
- no fence blocks

However, if the user is clearly asking a question then answer it very briefly and well.
"@

    $provider = $script:aiProvider
    $providerConfig = $script:providerDefaults[$provider]
    $model = Get-DefaultModel

    if ($provider -eq 'OpenAI') {
        # Use PSAI agent pipeline for OpenAI
        try {
            $agent = New-Agent -Instructions $instructions -LLM (New-OpenAIChat -model $model)
        }
        catch {
            Write-Error "Failed to initialize the AI agent. Ensure the PSAI module is installed and `$env:$($providerConfig.ApiKeyEnv) is set."
            return
        }

        While ($true) {
            try {
                $agentResponse = $agent | Get-AgentResponse $prompt
            }
            catch {
                Write-Error "Failed to get a response from the AI agent: $_"
                return
            }

            if ($spectreInstalled) {
                Format-SpectrePanel -Data (Get-SpectreEscapedText -Text $agentResponse) -Title "Agent Response ($provider)" -Border "Rounded" -Color "Blue"
                Format-SpectrePanel -Data "Follow up, Enter to copy & quit, Ctrl+C to quit." -Title "Next Steps" -Border "Rounded" -Color "Cyan1"
            }
            else {
                Write-Host $agentResponse
                Write-Host -ForegroundColor Green "Follow up, Enter to copy & quit, Ctrl+C to quit."
            }

            $prompt = Read-Host '> '
            if ([string]::IsNullOrEmpty($prompt)) {
                if ($spectreInstalled) {
                    Format-SpectrePanel -Data "Copied to clipboard." -Title "Information" -Border "Rounded" -Color "Green"
                }
                else {
                    Write-Host -ForegroundColor Green "Copied to clipboard."
                }
                $agentResponse | Set-Clipboard
                break
            }
        }
    }
    else {
        # Use direct API calls for OpenRouter / Synthetic
        $apiKey = [System.Environment]::GetEnvironmentVariable($providerConfig.ApiKeyEnv)
        if ([string]::IsNullOrWhiteSpace($apiKey)) {
            Write-Error "API key not found. Set `$env:$($providerConfig.ApiKeyEnv) to your $provider API key."
            return
        }

        $messages = [System.Collections.ArrayList]@(
            @{ role = "system"; content = $instructions }
        )

        While ($true) {
            try {
                $agentResponse = Invoke-AIChatConversation -Prompt $prompt -Messages $messages -Model $model -BaseUrl $providerConfig.BaseUrl -ApiKey $apiKey
            }
            catch {
                Write-Error "Failed to get a response from $provider`: $_"
                return
            }

            if ($spectreInstalled) {
                Format-SpectrePanel -Data (Get-SpectreEscapedText -Text $agentResponse) -Title "Agent Response ($provider)" -Border "Rounded" -Color "Blue"
                Format-SpectrePanel -Data "Follow up, Enter to copy & quit, Ctrl+C to quit." -Title "Next Steps" -Border "Rounded" -Color "Cyan1"
            }
            else {
                Write-Host $agentResponse
                Write-Host -ForegroundColor Green "Follow up, Enter to copy & quit, Ctrl+C to quit."
            }

            $prompt = Read-Host '> '
            if ([string]::IsNullOrEmpty($prompt)) {
                if ($spectreInstalled) {
                    Format-SpectrePanel -Data "Copied to clipboard." -Title "Information" -Border "Rounded" -Color "Green"
                }
                else {
                    Write-Host -ForegroundColor Green "Copied to clipboard."
                }
                $agentResponse | Set-Clipboard
                break
            }
        }
    }
}
