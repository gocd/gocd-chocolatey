## Building package

- ensure Chocolatey is installed.
- `cd gocd-server|gocd-agent`
- `$env:version = <version>`
- `$env:revision = <revision>`
- `choco pack --version=<version>`

## Pushing to Chocolatey

- `choco push "<package>.nupkg" -k="<api-key>"`


## Installing go server or agent 

- `choco install gocdagent --ia "/SERVERURL=""https://<go_server_ip>:<go_server_ssl_port/go"""`
- `choco install gocdserver`