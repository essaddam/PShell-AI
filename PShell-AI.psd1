@{
    RootModule        = 'PShell-AI.psm1'
    ModuleVersion     = '0.3.0'
    GUID              = '68e0c6dd-369a-4899-9fe7-c53deeef185d'
    Author            = 'Douglas Finke'
    CompanyName       = 'Doug Finke'
    Copyright         = '© 2024-2025 All rights reserved.'

    Description       = @'
Is a minimal, powerful AI assistant in your console. Supports OpenAI, OpenRouter, and Synthetic providers.
'@

    PowerShellVersion = '5.1'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @(
        @{ModuleName = 'PSAI'; ModuleVersion = "0.1.0" ; GUID = "68662d19-a8f1-484f-b1b7-3bf0e8a436df" }
    )
    FunctionsToExport = @(
        'Get-AIProvider',
        'Get-DefaultModel',
        'Set-AIProvider',
        'Set-DefaultModel',
        'q'
    )

    AliasesToExport   = @(    )

    PrivateData       = @{
        PSData = @{
            Category   = "PShell AI Assistant Module"
            Tags       = @("PowerShell", "GPT", "OpenAI", "OpenRouter", "Synthetic", "AI", "Assistant")
            ProjectUri = "https://github.com/dfinke/PShell-AI"
            LicenseUri = "https://github.com/dfinke/PShell-AI/blob/main/LICENSE"
            IconUri    = 'https://raw.githubusercontent.com/dfinke/PShell-AI/main/media/PShell-AI.png'
        }
    }
}
