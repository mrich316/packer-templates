@echo off

:: There needs to be Oracle CA (Certificate Authority) certificates installed in order
:: to prevent user intervention popups which will undermine a silent installation.
if exist E:\cert\vbox-sha1.cer (
    cmd /c certutil -addstore -f "TrustedPublisher" E:\cert\vbox-sha1.cer
)
if exist E:\cert\vbox-sha256.cer (
    cmd /c certutil -addstore -f "TrustedPublisher" E:\cert\vbox-sha256.cer
)
if exist E:\cert\vbox-sha256-r3.cer (
    cmd /c certutil -addstore -f "TrustedPublisher" E:\cert\vbox-sha256-r3.cer
)

echo Installing VBoxWindowsAdditions...
cmd /c E:\VBoxWindowsAdditions.exe /S
echo Done VBoxWindowsAdditions.
