Param(
  [string]$proxyServer = "",
  [string]$proxyOverride = "",
  [string]$unattend,
  [string]$out
)

$xml = [xml](Get-Content $unattend)

$proxyNode = $xml.unattend.settings.component | where {$_.Name -eq 'Microsoft-Windows-IE-ClientNetworkProtocolImplementation'}

if ($proxyServer -Or $proxyOverride) {

  $proxyNode.HKLMProxyServer = $proxyServer
  $proxyNode.HKLMProxyOverride = $proxyOverride

} else {

  $proxyNode.ParentNode.RemoveChild($proxyNode) | Out-Null

}

$xml.Save($out)