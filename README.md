# Packer-based image templates
## Templates used to build our dev machines.

On our network, almost every request must pass through a corporate proxy.
Before calling packer, you can set or remove the proxy configuration in
answer files with **set_unattend_proxy.ps1**.

Currently, we only provide virtualbox compatible images.
Our build script looks like:

    powershell -File set_unattend_proxy.ps1 ^
      -unattend windows/answer_files/2012_r2/Autounattend.xml ^
      -out windows/answer_files/2012_r2/private/Autounattend.xml ^
      -proxyServer YOUR_PROXY:PORT ^
      -proxyOverride "YOUR;EXCEPTION;LIST"

    powershell -File set_unattend_proxy.ps1 ^
      -unattend windows/answer_files/2012_r2/sysprep-unattend.xml ^
      -out windows/answer_files/2012_r2/private/sysprep-unattend.xml ^
      -proxyServer YOUR_PROXY:PORT ^
      -proxyOverride "YOUR;EXCEPTION;LIST"

    packer build -only=virtualbox-iso ^
      -var 'autounattend=windows/answer_files/2012_r2/private/Autounattend.xml' ^
      -var 'sysprep_unattend=windows/answer_files/2012_r2/private/sysprep-unattend.xml' ^
      -var 'disk_size=61440' ^
      windows_2012_r2.json

When calling **set_unattend_proxy.ps1**, omitting **-proxyServer**
and **-proxyOverride** will remove the proxy configuration.