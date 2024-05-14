[CmdletBinding()]
param (
    [Parameter(ParameterSetName = "Build_Lib")]
    [switch]
    $Build,

    [Parameter(ParameterSetName = "Build_Lib")]
    [Parameter(ParameterSetName = "Build_Botan")]
    [Parameter(ParameterSetName = "Build_ICU")]
    [Parameter(ParameterSetName = "Build_All")]
    [string]
    $AndroidAPI = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [Parameter(ParameterSetName = "Build_Botan")]
    [Parameter(ParameterSetName = "Build_ICU")]
    [Parameter(ParameterSetName = "Build_All")]
    [string]
    $DestinationDir = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [Parameter(ParameterSetName = "Build_All")]
    [string]
    $DistDirSuffix = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [Parameter(ParameterSetName = "Build_All")]
    [string]
    $LibSuffix = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [Parameter(ParameterSetName = "Build_All")]
    [string]
    $LibsDir = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [Parameter(ParameterSetName = "Build_All")]
    [Parameter(ParameterSetName = "Build_Botan")]
    [Parameter(ParameterSetName = "Build_ICU")]
    [switch]
    $ForceDownloadNDK,

    [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "Build_Botan")]
    [switch]
    $BuildBotan,

    [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "Build_ICU")]
    [switch]
    $BuildICU,

    [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "Build_All")]
    [switch]
    $BuildAll,

    [Parameter(ParameterSetName = "Build_All")]
    [switch]
    $SkipICU,

    [Parameter(ParameterSetName = "Build_All")]
    [switch]
    $SkipBotan,

    [Parameter(Mandatory = $true, ParameterSetName = "Clean_objects")]
    [switch]
    $Clean
)

Import-Module -Name "$PSScriptRoot/Z-InsaneAndroid.ps1" -Force -NoClobber

if ($BuildBotan.IsPresent) {
    Build-BotanLibraryForInsane -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -ForceDownloadNDK:$ForceDownloadNDK
    exit
}

if ($BuildICU.IsPresent) {
    Build-IcuLibraryForInsane -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -ForceDownloadNDK:$ForceDownloadNDK
    exit
}

if ($BuildAll.IsPresent) {
    if (!$SkipBotan.IsPresent) {
        Build-BotanLibraryForInsane -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -ForceDownloadNDK:$ForceDownloadNDK
    }
    if (!$SkipICU.IsPresent) {
        Build-IcuLibraryForInsane -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -ForceDownloadNDK:$ForceDownloadNDK
    }
}

if ($Clean.IsPresent) {
    Remove-InsaneAndroid
    exit
}

Build-InsaneLibrary -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -DistDirSuffix $DistDirSuffix -LibSuffix $LibSuffix  -LibsDir $LibsDir -ForceDownloadNDK:$ForceDownloadNDK
exit