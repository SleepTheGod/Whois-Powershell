# Download the whois executable from the Microsoft TechNet Gallery
$whoisURL = "https://gallery.technet.microsoft.com/whois-tools-bce78bb5"
$downloadPath = "C:\whois.exe"

if (-not (Test-Path $downloadPath)) {
    # Download the whois executable
    Invoke-RestMethod -Uri $whoisURL -OutFile $downloadPath
}

# Create a shortcut for the whois executable
$shortcutPath = "$env:USERPROFILE\Desktop\whois.lnk"
if (-not (Test-Path $shortcutPath)) {
    $shortcut = New-Object -ComObject WScript.Shell
    $shortcut.CreateLink($shortcutPath, $downloadPath)
}

# Add the whois directory to the PATH environment variable
$path = (Get-ChildItem -Path "Env:PATH" -SplitPath).Value
if (-not $path.Contains("C:\whois")) {
    $path += ";C:\whois"
    Set-Item -Path "Env:PATH" -Value $path -NoTypeInformation
}

# Write a message to the console indicating that the installation is complete
Write-Host "Whois has been installed successfully."

# Perform a domain lookup using whois
$domainToLookup = "example.com"  # Replace with the domain you want to look up
if (Test-Path $downloadPath) {
    $whoisOutput = & $downloadPath $domainToLookup
    Write-Host "WHOIS Lookup for $domainToLookup:"
    Write-Host $whoisOutput
} else {
    Write-Host "Whois tool not found."
}
