# Download the whois executable from the Microsoft TechNet Gallery
$whoisURL = "https://gallery.technet.microsoft.com/whois-tools-bce78bb5"
$downloadPath = "C:\whois.exe"

if (-not (Test-Path $downloadPath)) {
    # Download the whois executable
    Invoke-RestMethod -Uri $whoisURL -OutFile $downloadPath
}

# Add the directory of whois to the PATH environment variable
$whoisDirectory = Split-Path $downloadPath
if (-not $env:Path.Contains($whoisDirectory)) {
    $env:Path += ";$whoisDirectory"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
}

# Perform a domain lookup using whois
$domainToLookup = "example.com"  # Replace with the domain you want to look up
if (Test-Path $downloadPath) {
    $whoisOutput = & $downloadPath $domainToLookup
    Write-Host "WHOIS Lookup for $domainToLookup:"
    Write-Host $whoisOutput
} else {
    Write-Host "Whois tool not found."
}
