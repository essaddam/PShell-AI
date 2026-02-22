# V0.3.0

- Add multi-provider support: OpenAI, OpenRouter, and Synthetic
- Add `Set-AIProvider` and `Get-AIProvider` functions
- Remove `ValidateSet` from `Set-DefaultModel` for flexible model names across providers
- Add `Private/Invoke-AIChat.ps1` for direct OpenAI-compatible API calls
- Fix cross-platform clipboard: replace `clip` with `Set-Clipboard`
- Add input validation and error handling to `q` function
- Update model list and documentation

# V0.2.3

- Add support for `PwshSpectreConsole`

# V0.2.2

- Bump module version to 0.2.2 in PShell-AI.psd1
- Add Get-DefaultModel and Set-DefaultModel functions to PShell-AI module
- Update terminal assistant instructions and integrate default model retrieval
- Add functions to get and set the default model in PShell-AI module
- Format shell command examples in README.md for better readability

# V0.2.1

- Fix GUID
- Remove CmdletBinding from function

# V0.1.1

- Initial commit
