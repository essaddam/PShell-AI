![alt text](media/PShell-AI-Logo.png)

# PShell-AI

![pshell-ai-demo](media/PShell-AI.gif)

> "Ten minutes of Googling is now ten seconds in the terminal."
>
> ~ John D.

## About
For developers, referencing things online is inevitable – but one can only look up "how to do [X] in docker or git" so many times before losing your mind.

## Install
```powershell
Install-Module PShell-AI
```

## Usage

### Configuration

PShell-AI supports three AI providers: **OpenAI**, **OpenRouter**, and **Synthetic**.

#### OpenAI (default)

Set your [OpenAI API key](https://platform.openai.com/api-keys).

> **Note**: Make sure you add credits to your account. Otherwise you only get back blank responses.

```powershell
$env:OpenAIKey = '[your-key]'
```

#### OpenRouter

[OpenRouter](https://openrouter.ai/) gives you access to hundreds of AI models through a single unified API.

```powershell
$env:OpenRouterKey = '[your-key]'
Set-AIProvider -Provider OpenRouter
```

#### Synthetic

[Synthetic](https://synthetic.new/) runs open-source AI models in private, secure datacenters.

```powershell
$env:SyntheticKey = '[your-key]'
Set-AIProvider -Provider Synthetic
```

### Switching Providers

```powershell
# View current provider and configuration
Get-AIProvider

# Switch to OpenRouter
Set-AIProvider -Provider OpenRouter

# Switch back to OpenAI
Set-AIProvider -Provider OpenAI
```

### Model Configuration

Each provider has a sensible default model. You can change the model at any time:

```powershell
# View the current model
Get-DefaultModel

# Change the model
Set-DefaultModel -model gpt-4o

# Examples for OpenRouter
Set-AIProvider -Provider OpenRouter
Set-DefaultModel -model anthropic/claude-sonnet-4-20250514

# Examples for Synthetic
Set-AIProvider -Provider Synthetic
Set-DefaultModel -model hf:meta-llama/Meta-Llama-3.1-70B-Instruct
```

## Features

- Generate shell commands from a description.
- Reference code snippets for any programming language.
- Fast, minimal UI.
- Auto-extract code from response and copy to clipboard.
- Follow up to refine command or explanation.
- Concise, helpful responses.
- Configurable AI model selection.
- Multi-provider support: OpenAI, OpenRouter, Synthetic.

# Enhanced Display

If you install `PwshSpectreConsole` you will get a better display of the responses.

```powershell
Install-Module PwshSpectreConsole
```

![alt text](media/PwshSpectreConsole.png)


## Examples

### Shell Commands

```powershell
q make a new git branch
```

```powershell
git branch new-branch
```

```powershell
q find files that contain "administrative" in the name
```

```powershell
Get-ChildItem -Path "C:\Path\To\Search" -Filter "*administrative*" -Recurse
```

### Code Snippets

```powershell
q initialize a static map in golang
```

```powershell
    staticMap := map[string]int{
        "apple":  1,
        "banana": 2,
        "cherry": 3,
    }
```

```powershell
q greet fn in PowerShell
```

```powershell
function Greet {
    param (
        [string]$Name = "Guest"
    )
    Write-Host "Hello, $Name! Welcome to PowerShell!"
}
```

```powershell
q create a generator function in python for dates
```

```python
from datetime import datetime, timedelta

def date_generator(start_date, end_date):
    current_date = start_date
    while current_date <= end_date:
        yield current_date
        current_date += timedelta(days=1)
```
