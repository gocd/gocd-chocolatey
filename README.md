## Building package

- ensure Chocolatey is installed.
- `cd gocd-server|gocd-agent`
- `$env:version = <version>`
- `$env:revision = <revision>`
- `choco pack --version=<version>`

## Pushing to Chocolatey

- `choco push "<package>.nupkg" -k="<api-key>"`
