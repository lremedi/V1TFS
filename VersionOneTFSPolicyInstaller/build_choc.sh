#!/bin/sh

set -xe
. ./$WORKSPACE/build.properties
#api key info
MYGET_API_KEY="$1"

PKGDIR="chocolateyPackage"
NUSPEC="VersionOne.TFS.PolicyInstaller.nuspec"
FILE_BASE_NAME="VersionOneTFSPolicyInstaller"
FILE_EXT="vsix"
BIN_FOLDER="bin/$Configuration"
BUILT_VSIX="$BIN_FOLDER/$FILE_BASE_NAME.$FILE_EXT"
VERSIONED_BUILT_VSIX="$BIN_FOLDER/$FILE_BASE_NAME.$VERSION_NUMBER.$BUILD_NUMBER.$FILE_EXT"
MY_SOURCE="https://www.myget.org/F/versionone"
PS1_FILE="Install.ps1"

mv "$WORKSPACE/VersionOneTFSPolicyInstaller/$BUILT_VSIX" "$WORKSPACE/VersionOneTFSPolicyInstaller/$VERSIONED_BUILT_VSIX"

cd "$WORKSPACE/VersionOneTFSPolicyInstaller/$PKGDIR/tools"

cat > "$PS1_FILE" <<EOF
Install-ChocolateyVsixPackage "VersionOne.TFS.Policy" "http://platform.versionone.com.s3.amazonaws.com/downloads/$FILE_BASE_NAME.$VERSION_NUMBER.$BUILD_NUMBER.$FILE_EXT"
EOF

cd "$WORKSPACE/VersionOneTFSPolicyInstaller/$PKGDIR"

cat > "$NUSPEC" <<EOF
<?xml version="1.0"?>
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
<metadata>
<id>VersionOne.TFS.PolicyInstaller</id>
<title>VersionOne.TFS.PolicyInstaller</title>
<version>$VERSION_NUMBER.$BUILD_NUMBER</version>
<authors>$ORGANIZATION_NAME</authors>
<owners>$ORGANIZATION_NAME</owners>
<summary>Ensure that commits checked into TFS via Visual Studio have VersionOne annotation.</summary>
<description>VersionOne's TFS integration allows you to employ VersionOne in your TFS workflow.</description>
<projectUrl>$GITHUB_WEB_URL</projectUrl>
<tags>VersionOne TFS Visual Studio VS2012 VS2013</tags>
<licenseUrl>$GITHUB_WEB_URL/blob/master/LICENSE.md</licenseUrl>
<requireLicenseAcceptance>false</requireLicenseAcceptance>
</metadata>
<files>
<file src="tools\**" target="tools" />
</files>
</package>
EOF

$WORKSPACE/.nuget/nuget.exe pack "$NUSPEC" # output ./Whatever.Nupkg?????
# NuGet SetApiKey <your key here> -source http://chocolatey.org/
# $MYGET_APIKEY
for NUPKG in VersionOne.TFS*.nupkg
do
    $WORKSPACE/.nuget/nuget.exe setApiKey "$MYGET_API_KEY" -Source "$MY_SOURCE"
    $WORKSPACE/.nuget/nuget.exe push "$NUPKG" -Source "$MY_SOURCE"
done