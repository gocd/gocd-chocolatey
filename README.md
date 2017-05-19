## Building package

- ensure Chocolatey is installed.
- `$env:version = <version>`
- `$env:revision = <revision>`
- `.\createPackage <server|agent>`

## Pushing to Chocolatey

- `choco push "<package>.nupkg" -k="<api-key>"`


## Installing go server or agent
Server:
- `choco install gocdserver`
Agent (cmd.exe):
- `choco install gocdagent --ia "/SERVERURL=""https://<go_server_ip>:<go_server_ssl_port/go"""`
Agent (poweshell.exe):
- `choco install gocdagent --ia '/SERVERURL=""https://<go_server_ip>:<go_server_ssl_port/go""'`
