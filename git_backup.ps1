param (
  [string]$configName
)

$config = Get-Content -Path (".\$configName\"+"$configName"+".json") | ConvertFrom-Json
$commandPath = $PSCommandPath | Split-Path -Parent
Import-Module (".\$configName\"+"$configName"+".psm1") -Force


$pair = "$($config.username):$($config.password)"
$encodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$basicAuthValue = 'Basic '+$encodedCredentials

$folderName = Get-Date -Format "MMddyyyy-HH-mm"
md $commandPath/$folderName
Set-Location $commandPath/$folderName

$size = 1
$pagelen = 100
For ($i=1; $i -le $size; $i++) {

    $params = @{
        Uri         = ($config.apiurl + "$i")
        Headers     = @{ 'Authorization' = $basicAuthValue }
        Method      = 'GET'
        Body        = $jsonSample
        ContentType = 'application/json'
    }

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $response = Invoke-RestMethod @params
    
    if($response.size) {
        $size = [int][Math]::Ceiling($response.size / $pagelen)
    }

    GitClone -config $config -response $response
}
