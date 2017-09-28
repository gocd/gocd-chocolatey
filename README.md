## Building package

Ensure Chocolatey is installed.

```PowerShell
$env:version = <version>
$env:revision = <revision>
.\createPackage <server|agent>
```

--or--

```PowerShell
.\createPackage <server|agent> -version <version> -revision <revision>
```

Run `help .\createPackage.ps1 -detailed` for more help.

## Pushing to Chocolatey

- `choco push "<package>.nupkg" -k="<api-key>"`


## Installing go server or agent
Server:
- `choco install gocdserver`

Agent (cmd.exe):
- `choco install -y gocdagent --ia "/SERVERURL=""https://<go_server_ip>:<go_server_ssl_port/go"""`

Agent (poweshell.exe):
- `choco install -y gocdagent --ia '/SERVERURL=""https://<go_server_ip>:<go_server_ssl_port/go""'`
