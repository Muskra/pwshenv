function main($programName) {
    
    $rootDir = Split-Path -Path $programName
    
    $binDir = "$($rootDir)\bin\*"
    $srcDir = "$($rootDir)\src\*"
    
    $destBinDir = "~/.tools/bin/"
    $destSrcDir = "~/.tools/src/"
    
    $pwshenv = "$($rootDir)\setupBase.ps1"

    # installing the environment
    if (Test-Path "$pwshenv") {
        Invoke-Expression -Command $pwshenv
    
    } else {
        Write-Host "< ! > PASS: Can't install environment, installation file not found."
    }

    # copying binaries
    if ((Test-Path $binDir) -And (Test-Path $destBinDir)) {
        Write-Host "< ! > Moving elements from '$($binDir)' to '$($destBinDir)'."
        Copy-Item -Path $binDir -Destination $destBinDir -Recurse
        Write-Host $("< ! > DONE.")
    
    } else {
        Write-Host "< ! > PASS: '$($binDir)', does not exist. Can't copy to '$($destBinDir)'."
    }

    # copying sources
    if ((Test-Path $srcDir) -And (Test-Path $destSrcDir)) {
        Write-Host "< ! > Moving elements from '$($srcDir)' to '$($destSrcDir)'."
        Copy-Item -Path $srcDir -Destination $destSrcDir -Recurse
        Write-Host $("< ! > DONE.")
    
    } else {
        Write-Host "< ! > PASS: '$($srcDir)', does not exist. Can't copy to '$($destSrcDir)'."
    }
}

# entrypoint
main $MyInvocation.MyCommand.Path