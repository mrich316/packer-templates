# Packer-based image templates
## Templates used to build our dev machines.

On our network, almost every request must pass through a corporate proxy.
Before calling packer, you can set or remove the proxy configuration in
answer files with set_unattend_proxy.ps1.

Currently, we only provide virtualbox compatible images.
