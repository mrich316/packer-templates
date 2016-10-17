Param(
  [string]$proxyServer = "",
  [string]$proxyOverride = "",
  [string]$unattend,
  [string]$out
)

$xml = [xml](Get-Content $unattend)

$proxyNode = $xml.unattend.settings.component | where {$_.Name -eq 'Microsoft-Windows-IE-ClientNetworkProtocolImplementation'}
$proxyNode.HKLMProxyServer = $proxyServer
$proxyNode.HKLMProxyOverride = $proxyOverride

$xml.Save($out)