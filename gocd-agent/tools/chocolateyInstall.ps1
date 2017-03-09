$packageParameters = Get-PackageParameters

$packageName = 'gocd-agent'
$installerType = 'exe'
$version = $env:version
$revision = $env:revision
$url = "https://download.gocd.io/binaries/${version}-${revision}/win/go-agent-${version}-${revision}-jre-32bit-setup.exe"
$url64 = "https://download.gocd.io/binaries/${version}-${revision}/win/go-agent-${version}-${revision}-jre-64bit-setup.exe"
$args = '/S'

if ($pp["SERVERURL"] -ne $null -or $pp["SERVERURL"] -ne '') { $args += " /SERVERURL=$packageParameters['SERVERURL']" }
if ($pp["GO_AGENT_JAVA_HOME"] -ne $null -or $pp["GO_AGENT_JAVA_HOME"] -ne '') { $args += " /GO_AGENT_JAVA_HOME=$packageParameters['GO_AGENT_JAVA_HOME']" }
if ($pp["PATH_TO_AGENT_DIRECTORY"] -ne $null -or $pp["PATH_TO_AGENT_DIRECTORY"] -ne '') { $args += " /D=$packageParameters['PATH_TO_AGENT_DIRECTORY']" }

$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$args" "$url" "$url64"  -validExitCodes $validExitCodes