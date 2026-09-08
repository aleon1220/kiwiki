function Update-Environment {
    foreach ($level in "Machine", "User") {
        [Environment]::GetEnvironmentVariables($level).GetEnumerator() | ForEach-Object {
            [Environment]::SetEnvironmentVariable($_.Name, $_.Value)
        }
    }
}

# common across OS

function onePassword {
    # usually home path is C:\Users\user123
    # suggest alias cat and echo. in future windows releases this will be available
    Get-Content "$HOME\.ssh\1.txt" | clip.exe
    Write-Output "key in clipboard"
}

function Get-DirectoryStack {
    [CmdletBinding()]
    param()

    # Get current location and stack contents
    $current = Get-Location
    $stack = Get-Location -Stack

    # Combine current location (index 0) with stack items
    $fullStack = @($current) + $stack

    # Output formatted index and path
    $index = 0
    foreach ($item in $fullStack) {
        [PSCustomObject]@{
            Index = $index
            Path  = $item.Path
        }
        $index++
    }
}

# Alias 'dirs' to the function
Set-Alias -Name dirs -Value Get-DirectoryStack -Option AllScope