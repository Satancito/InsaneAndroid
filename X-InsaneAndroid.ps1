[CmdletBinding()]
param (
    [Parameter(ParameterSetName = "Build_Lib")]
    [string]
    $AndroidAPI = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [string]
    $DestinationDir = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [string]
    $DistDirSuffix = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [string]
    $LibSuffix = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [string]
    $LibsDir = [string]::Empty,

    [Parameter(ParameterSetName = "Build_Lib")]
    [switch]
    $ForceDownloadNDK,

    [Parameter(Mandatory = $true, ParameterSetName = "Build_Botan")]
    [switch]
    $BuildBotan,

    [Parameter(Mandatory = $true, ParameterSetName = "Build_ICU")]
    [switch]
    $BuildICU,

    [Parameter(Mandatory = $true, ParameterSetName = "Build_All")]
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

function Build-InsaneLibrary {
    if ([string]::IsNullOrWhiteSpace($AndroidAPI)) {
        $AndroidAPI = [AndroidNDKApiValidateSet]::ValidValues | Select-Object -Last 1
    }
    Assert-AndroidNDKApi -Api $AndroidAPI

    $DestinationDir = [string]::IsNullOrWhiteSpace($DestinationDir) ? "$(Get-CppLibsDir)" : $DestinationDir
    $LibsDir = [string]::IsNullOrWhiteSpace($LibsDir) ? "$(Get-CppLibsDir)" : $LibsDir
    $DistDirSuffix = [string]::IsNullOrWhiteSpace($DistDirSuffix) ? [string]::Empty : "-$($DistDirSuffix)"

    Install-AndroidNDK -Force:$ForceDownloadNDK

    $ndkProps = $__PSCOREFXS_ANDROID_NDK_OS_VARIANTS["$(Get-OsName -Minimal)"]
    $jniLibsDir = "$DestinationDir/$("$__INSANEANDROID_JNILIBS_DIST_DIR_NAME_FORMAT" -f $AndroidAPI)"
    New-Item -Path "$jniLibsDir" -ItemType Directory -Force | Out-Null
    $__INSANEANDROID_INSANE_BUILD_CONFIGURATIONS.Keys | ForEach-Object {
        $configuration = $__INSANEANDROID_INSANE_BUILD_CONFIGURATIONS[$_]
        $botanConfiguration = $__PSBOTAN_ANDROID_BUILD_CONFIGURATIONS[$_]
        $icuConfiguration = $__PSICU_ANDROID_BUILD_CONFIGURATIONS[$_]

        $botanConfiguration.DistDirName = "$($botanConfiguration.DistDirName -f $AndroidAPI)-Insane"
        $botanConfiguration.DistDir = "$LibsDir/$($botanConfiguration.DistDirName)"

        $icuConfiguration.DistDirName = "$($icuConfiguration.DistDirName -f $AndroidAPI)-Insane"
        $icuConfiguration.DistDir = "$LibsDir/$($icuConfiguration.DistDirName)"
        
        if (!(Test-Path "$($botanConfiguration.DistDir)" -PathType Container)) {
            throw "Botan library path not found `"$($botanConfiguration.DistDir)`"."
        }

        if (!(Test-Path "$($icuConfiguration.DistDir)" -PathType Container)) {
            throw "ICU library path not found `"$($icuConfiguration.DistDir)`"."
        }

        try {
            $prefix = "$DestinationDir/$($configuration.DistDirName -f $AndroidAPI)$DistDirSuffix"
            New-Item -Path "$($configuration.CurrentWorkingDir)" -ItemType Directory -Force | Out-Null
            Push-Location "$($configuration.CurrentWorkingDir)"
            Write-Host
            Write-InfoBlue "█ InsaneAndroid - Building `"$prefix`""
            Copy-Item -Path "$PSScriptRoot/Makefile" -Destination "$($configuration.CurrentWorkingDir)" -Force
            
            $env:CXX = "$($ndkProps.ToolchainsDir)/bin/$($configuration.Triplet)$AndroidAPI-$__PSCOREFXS_ANDROID_NDK_CLANG_PLUS_PLUS_EXE_SUFFIX"
            $env:AR = "$($ndkProps.ToolchainsDir)/bin/$__PSCOREFXS_ANDROID_NDK_AR_EXE"
            $env:LD = $env:CXX
            $env:CONFIGURATION = "$($configuration.Name)"
            $env:SOURCES_DIR = "$PSScriptRoot"
            $env:BUILD_DIR = "$($configuration.CurrentWorkingDir)"
            $env:LIB_SUFFIX = $LibSuffix
            $env:BOTAN_MAJOR_VERSION = $__PSBOTAN_BOTAN_MAJOR_VERSION
            $env:BOTAN_DIST_DIR = $botanConfiguration.DistDir
            $env:ICU_DIST_DIR = $icuConfiguration.DistDir
            $env:DIST_DIR = $prefix
            $env:ICU_VERSION = $__PSICU_ICU_VERSION
            $env:ANDROID_ABI = $configuration.Abi
            $env:JNILIBS_DIR = $jniLibsDir

            $null = Test-ExternalCommand -Command "`"$__PSCOREFXS_MAKE_EXE`" -j8 All" -ThrowOnFailure -NoAssertion
            Remove-Item -Path "$prefix" -Force -Recurse -ErrorAction Ignore
            Join-CompileCommandsJson -SourceDir "$($configuration.CurrentWorkingDir)" -DestinationDir "$PSScriptRoot"
            $null = Test-ExternalCommand -Command "`"$__PSCOREFXS_MAKE_EXE`" Install" -ThrowOnFailure -NoAssertion 
            Write-Host
        }
        finally {
            Pop-Location
            Remove-Item -Path "$($configuration.CurrentWorkingDir)" -Force -Recurse -ErrorAction Ignore
        }
    }
}

function Build-BotanLibraryForInsane {
    & "$PSScriptRoot/submodules/PsBotan/X-PsBotan-Android.ps1" -DistDirSuffix "Insane" -AndroidAPI $AndroidAPI
}

function Build-IcuLibraryForInsane {
    & "$PSScriptRoot/submodules/PsICU/X-PsIcu-Android.ps1" -DistDirSuffix "Insane" -AndroidAPI $AndroidAPI
}

function New-JniLibsDirs {
    New-Item -Path "$__INSANEANDROID_JNILIBS_DIST_DIR_NAME_FORMAT" -ItemType Directory -Force
    $__INSANEANDROID_INSANE_BUILD_CONFIGURATIONS.Keys | ForEach-Object {
        $configuration = $__INSANEANDROID_INSANE_BUILD_CONFIGURATIONS[$_]
        $botanConfiguration = $__PSBOTAN_ANDROID_BUILD_CONFIGURATIONS[$_]

        $botanConfiguration.DistDirName = "$($botanConfiguration.DistDirName -f $AndroidAPI)-Insane"
        $botanConfiguration.DistDir = "$LibsDir/$($botanConfiguration.DistDirName)"

        
        if (!(Test-Path "$($botanConfiguration.DistDir)" -PathType Container)) {
            throw "Botan library path not found `"$($botanConfiguration.DistDir)`"."
        }

    }
    
}

if ($BuildBotan.IsPresent) {
    Build-BotanLibraryForInsane
    exit
}

if ($BuildICU.IsPresent) {
    Build-IcuLibraryForInsane
    exit
}

if ($BuildAll.IsPresent) {
    if (!$SkipBotan.IsPresent) {
        Build-BotanLibraryForInsane
    }
    if (!$SkipICU.IsPresent) {
        Build-IcuLibraryForInsane
    }
    Build-InsaneLibrary
    exit
}

if ($Clean.IsPresent) {
    Remove-InsaneAndroid
    exit
}

Build-InsaneLibrary
exit