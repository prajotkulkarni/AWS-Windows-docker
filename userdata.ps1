<powershell>

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))   

choco install git -y

$Headers = @{
   "Authorization" = "token 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"
 }

$GitHubApiUrl = "https://api.github.com/repos/prajotkulkarni/AWS-Windows-docker/actions/runners/registration-token"

$response = Invoke-RestMethod -Uri $GitHubApiUrl -Headers $Headers -Method POST
$RegistrationToken = $response.token
Write-Host "GitHub Runner Registration Token: $RegistrationToken"

mkdir actions-runner; cd actions-runner

Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-win-x64-2.310.2.zip -OutFile actions-runner-win-x64-2.310.2.zip

Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.310.2.zip", "$PWD")

./config.cmd  --unattended --url https://github.com/prajotkulkarni/AWS-Windows-docker --token $RegistrationToken 

.\run.cmd

</powershell>