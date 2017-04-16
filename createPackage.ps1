$version = $env:version
$revision = $env:revision
$path = "gocd-" + $args[0]
$fullVersion = $version + "-" + $revision
cd $path
(Get-Content tools\chocolateyInstall.ps1.template) -replace '{{fullVersion}}', $fullVersion | out-file tools\chocolateyInstall.ps1;
choco pack --version=$version
cd ..