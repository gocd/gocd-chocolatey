param(
    [string][parameter(mandatory=$true)][ValidateSet("agent", "server")]$type,

    # Note that parameter validation doesn't work for parameter defaults,
    # so if $env:version or $env:revision are unset, things will probably
    # fail in some undefined way.
    [string][parameter()][ValidateNotNullOrEmpty()]$version = $env:version,
    [string][parameter()][ValidateNotNullOrEmpty()]$revision = $env:revision
)

$path = "gocd-" + $type
$fullVersion = $version + "-" + $revision

Push-Location $path

$checksum32 = (Invoke-RestMethod "https://download.gocd.io/binaries/$fullVersion/win/go-$type-$fullVersion-jre-32bit-setup.exe.sha256sum").Split(' ')[0]
$checksum64 = (Invoke-RestMethod "https://download.gocd.io/binaries/$fullVersion/win/go-$type-$fullVersion-jre-64bit-setup.exe.sha256sum").Split(' ')[0]

(Get-Content tools\chocolateyInstall.ps1.template) -replace '{{fullVersion}}', $fullVersion -replace '{{checksum-32bit}}', $checksum32 -replace '{{checksum-64bit}}', $checksum64 | out-file tools\chocolateyInstall.ps1;
choco pack --version=$version

Pop-Location
