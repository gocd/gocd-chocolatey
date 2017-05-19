$version = $env:version
$revision = $env:revision
$path = "gocd-" + $args[0]
$fullVersion = $version + "-" + $revision
$type = $args[0]
cd $path
$checksumFileContent = (New-Object System.Net.WebClient).DownloadString("https://download.gocd.io/binaries/$fullVersion/win/go-$type-$fullVersion-jre-32bit-setup.exe.sha256sum")
$checksum32 = $checksumFileContent.Split(" ")[0]
$checksumFileContent = (New-Object System.Net.WebClient).DownloadString("https://download.gocd.io/binaries/$fullVersion/win/go-$type-$fullVersion-jre-64bit-setup.exe.sha256sum")
$checksum64 = $checksumFileContent.Split(" ")[0]
(Get-Content tools\chocolateyInstall.ps1.template) -replace '{{fullVersion}}', $fullVersion -replace '{{checksum-32bit}}', $checksum32 -replace '{{checksum-64bit}}', $checksum64 | out-file tools\chocolateyInstall.ps1;
choco pack --version=$version
cd ..
