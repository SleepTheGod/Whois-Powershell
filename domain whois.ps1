# Import the necessary module
Import-Module Net.DNS

# Define the function to perform WHOIS lookups
function Get-Whois($domain) {
    # Use the Net.DNS module to query the WHOIS server for the specified domain
    $whoisRecord = New-Object Net.DNS.WhoisRecord($domain)
    $whoisData = $whoisRecord.Query()

    # Extract relevant information from the WHOIS data
    $registrar = $whoisData[0].Name | Where-Object {$_ -match "Registrar:"}
    $registrar = $registrar.Matches.Value.Trim()

    $creationDate = $whoisData[0].Text | Where-Object {$_ -match "Created:"}
    $creationDate = $creationDate.Matches.Value.Trim()

    $expirationDate = $whoisData[0].Text | Where-Object {$_ -match "Expires:"}
    $expirationDate = $expirationDate.Matches.Value.Trim()

    # Format the extracted information into a readable output
    $output = "Domain: $domain"
    $output += "`nRegistrar: $registrar"
    $output += "`nCreated: $creationDate"
    $output += "`nExpiration Date: $expirationDate"

    return $output
}

# Prompt the user for the domain to look up
$domain = Read-Host "Enter the domain to look up:"

# Perform the WHOIS lookup and display the results
if ($domain) {
    $whoisResult = Get-Whois $domain
    Write-Host $whoisResult
} else {
    Write-Warning "No domain provided. Please enter a valid domain name."
}
