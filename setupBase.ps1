<#

https://github.com/muskra/pwshenv

This script deploy an environment to the current user.

The following custom directories are created:
    ~/.tools/
        | /bin/
        | /src/

The variable '$profile.CurrentUserAllHosts' is being used to generate a user configuration wich do:

    Check for any executables in '~/.tools/bin' that are of types:
        '.exe', '.lnk', '.ps1'

    And make them aliases from their names, example:
        '~/.tools/bin/test.ps1'

    Will be 'test'

This config file is in general stored in:
    '~/Documents/WindowsPowerShell/profile.ps1'

#>


# creates the ~/.tools/bin directory
function createBin {

    if ( -Not ( Test-Path ~/.tools/bin ) ) {
        Write-Host $("< ! >")$("Creating new file '~/.tools/bin'.")
        mkdir ~/.tools/bin | Out-Null
        Write-Host $("< ! > DONE.")

    } else {
        Write-Host "< ! > PASS: '~/.tools/bin' already exist."
    }
}

# creates the ~/.tools/src directory
function createSrc {

    if ( -Not ( Test-Path ~/.tools/src ) ) {
        Write-Host $("< ! >")$("Creating new file '~/.tools/src'.")
        mkdir ~/.tools/src | Out-Null
        Write-Host $("< ! > DONE.")

    } else {
        Write-Host "< ! > PASS: '~/.tools/src' already exist."
    }
}

# this function generate the file tree where we will store the binaries and the sources of the programs
function generateTree {

    if ( -Not ( Test-Path ~/.tools ) ) {
        Write-Host $("< ! >")$("Creating new file '~/.tools'.")
        mkdir ~/.tools | Out-Null
        Write-Host $("< ! > DONE.")

        createBin
        createSrc
        
    } else {
        Write-Host "< ! > PASS: '~/.tools' already exist."

        createBin
        createSrc
    }
}

# this function generates the config file for the current user where we will generate aliases from existing executables in the ~/.tools/bin directory
function generateConfig {
    
    $fullPath = $profile.CurrentUserAllHosts
    $filepath = Split-Path -Parent $fullPath
    $content = @"
# Set all scripts, shortcuts and binary files from ~/.tools/bin as an alias

`$fileTypes = "*.ps1", "*.lnk", "*.exe"

foreach (`$type in `$fileTypes) {
    foreach (`$file in Get-ChildItem -Path ~/.tools/bin -Filter `$type) {
        `$baseName = `$file | Select-Object -Expand Basename
        `$fullName = `$file | Select-Object -Expand FullName
        Set-Alias `$basename `$fullName
    }
}
"@

    if ( -Not ( Test-Path $filePath ) ) {
        Write-Host $("< ! >")$("Creating new directory")$($filePath)
        mkdir $filePath | Out-Null
        Write-Host $("< ! > DONE.")

    } else {
        Write-Host $("< ! > PASS:")$($filePath)$("already exist.")
    }

    if ( -Not ( Test-Path $fullPath ) ) {

        Write-Host $("< ! >")$("Creating new file")$($fullPath)
        New-Item $fullPath | Out-Null
        Write-Host $("< ! > DONE.")

        Write-Host $("< ! > Appending content to the file")$($fullpath)
        Add-Content -Path $fullPath -Value $content
        Write-Host $("< ! > DONE.")

    } else {

        Write-Host $("< ! > PASS:")$($fullPath)$("already exist.")
        $prompt = Read-Host $("< ! > Would you like to append the content to the file ? (yes/no)")
        
        if ( ($prompt -eq "yes") -or ($prompt -eq "y") ) {
            
            Write-Host $("< ! > Appending content to the file")$($fullpath)
            Add-Content -Path $fullPath -Value $content
            Write-Host $("< ! > DONE.")
        }
    }
}

# main function of the program
function main {

    generateTree
    generateConfig
    exit
}

# entrypoint
main
exit