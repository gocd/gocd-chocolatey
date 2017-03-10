$packageName = 'gocdserver'
$installerType = 'exe'
$version = $env:version
$revision = $env:revision
$url = "https://download.gocd.io/binaries/${version}-${revision}/win/go-server-${version}-${revision}-jre-32bit-setup.exe"
$url64 = "https://download.gocd.io/binaries/${version}-${revision}/win/go-server-${version}-${revision}-jre-64bit-setup.exe"
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes