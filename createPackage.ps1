#Requires -Version 2.0

<#
    .SYNOPSIS
        Build NuGet Packages (.nupkg) for GoCD Server or Agent.

    .PARAMETER type
        The type of package being built--either agent or server.

    .PARAMETER version
        The release version of the package being built (ie, YY.MM.XX).
        Defaults to $env:version.

    .PARAMETER revision
        The build number of the package being built.
        Defaults to $env:revision

    .EXAMPLE
        Using environment variables.

        $env:version=17.4.0
        $env:revision=4892
        .\createPackage.ps1 server
        .\createPackage.ps1 agent

    .EXAMPLE
        Using unnamed arguments.

        .\createPackage.ps1 server 17.4.0 4892
        .\createPackage.ps1 agent 17.4.0 4892

    .EXAMPLE
        Using named arguments.

        .\createPackage.ps1 -type server -version 17.4.0 -revision 4892
        .\createPackage.ps1 -type agent -version 17.4.0 -revision 4892
#>
param(
    [string][parameter(mandatory=$true)][ValidateSet("agent", "server")]$type,

    # Note that parameter validation doesn't work for parameter defaults,
    # so if $env:version or $env:revision are unset, things will probably
    # fail in some undefined way.
    [string][parameter()][ValidateNotNullOrEmpty()]$version = $env:version,
    [string][parameter()][ValidateNotNullOrEmpty()]$revision = $env:revision
)

$path = "gocd-$type"

If ((-Not $version) -and (-Not $revision)) {
    $json = (Get-Content ..\version.json) | Out-String | ConvertFrom-Json
    $version = $json.go_version
    $revision = $json.go_build_number
}

$fullVersion = "$version-$revision"

Push-Location $path

$checksum32 = (New-Object System.Net.WebClient).DownloadString("https://download.gocd.org/binaries/$fullVersion/win/go-$type-$fullVersion-jre-32bit-setup.exe.sha256sum").Split(' ')[0]
$checksum64 = (New-Object System.Net.WebClient).DownloadString("https://download.gocd.org/binaries/$fullVersion/win/go-$type-$fullVersion-jre-64bit-setup.exe.sha256sum").Split(' ')[0]

(Get-Content tools\chocolateyInstall.ps1.template) -replace '{{fullVersion}}', $fullVersion -replace '{{checksum-32bit}}', $checksum32 -replace '{{checksum-64bit}}', $checksum64 | out-file tools\chocolateyInstall.ps1;
choco pack --version=$version

Pop-Location
