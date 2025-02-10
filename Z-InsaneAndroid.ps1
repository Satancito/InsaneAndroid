Import-Module -Name "$PSScriptRoot/submodules/PsCoreFxs/Z-PsCoreFxs.ps1" -Force -NoClobber
Import-Module -Name "$PSScriptRoot/submodules/PsICU/Z-PsIcu.ps1" -Force -NoClobber
Import-Module -Name "$PSScriptRoot/submodules/PsBotan/Z-PsBotan.ps1" -Force -NoClobber
$__INSANEANDROID_INSANE_VERSION = "1.0.0"; $null = $__INSANEANDROID_INSANE_VERSION
$__INSANEANDROID_TEMP_DIR = "$(Get-UserHome)/.InsaneAndroid"; $null = $__INSANEANDROID_TEMP_DIR
$__INSANEANDROID_DIST_DIR_NAME_FORMAT = "Insane-$__INSANEANDROID_INSANE_VERSION-Android-Api{0}-{1}-{2}" # 0=ApiLevel / 1=Abi / 2=Configuration
$__INSANEANDROID_JNILIBS_DIST_DIR_NAME_FORMAT = "Insane-$__INSANEANDROID_INSANE_VERSION-Android-Api{0} JniLibs"; $null = $__INSANEANDROID_JNILIBS_DIST_DIR_NAME_FORMAT # 0=ApiLevel
$__INSANEANDROID_STATIC_LIB_NAME = "libInsane.a"; $null = $__INSANEANDROID_STATIC_LIB_NAME
$__INSANEANDROID_SHARED_LIB_NAME = "libInsane.so"; $null = $__INSANEANDROID_SHARED_LIB_NAME
$__INSANEANDROID_INSANE_BUILD_CONFIGURATIONS = [ordered]@{
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.NameDebug)"     = [ordered]@{ 
        Name              = "Debug"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Debug/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Name)", "Debug")
    }
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.NameDebug)"   = @{ 
        Name              = "Debug"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Debug/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Name)", "Debug")
    }
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.NameDebug)"     = @{ 
        Name              = "Debug"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Debug/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Name)", "Debug")
    }
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.NameDebug)"     = @{ 
        Name              = "Debug"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Debug/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Name)", "Debug")
    }

    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.NameRelease)"   = @{ 
        Name              = "Release"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Release/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm.Name)", "Release")
    }
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.NameRelease)" = @{ 
        Name              = "Release"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Triplet)" 
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Release/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.Arm64.Name)", "Release")
    }
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.NameRelease)"   = @{ 
        Name              = "Release"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Release/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X86.Name)", "Release")
    }
    "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.NameRelease)"   = @{ 
        Name              = "Release"
        AbiName           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Name)"
        Abi               = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.AbiNormalized)"
        Triplet           = "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Triplet)"
        Options           = @()
        CurrentWorkingDir = "$__INSANEANDROID_TEMP_DIR/Bin/Release/Android-$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Name)"
        DistDirName       = $__INSANEANDROID_DIST_DIR_NAME_FORMAT -f @("{0}", "$($__PSCOREFXS_ANDROIDNDK_ANDROID_ABI_CONFIGURATIONS.X64.Name)", "Release")
    }
}; $null = $__INSANEANDROID_INSANE_BUILD_CONFIGURATIONS

function Remove-InsaneAndroid {
    Write-InfoBlue "Removing InsaneAndroid"
    Write-Host "$__INSANEANDROID_TEMP_DIR"
    Remove-Item -Path "$__INSANEANDROID_TEMP_DIR" -Force -Recurse -ErrorAction Ignore
}

function Build-IcuLibraryForInsane {
    [CmdletBinding()]
    param (
        [string]
        $AndroidAPI = [string]::Empty,

        [string]
        $DestinationDir = [string]::Empty,

        [switch]
        $ForceDownloadNDK
    )
    $AndroidAPI = Test-AndroidNDKApi -Api $AndroidAPI -Assert
    $DestinationDir = [string]::IsNullOrWhiteSpace($DestinationDir) ? "$(Get-CppLibsDir)" : $DestinationDir
    & "$PSScriptRoot/submodules/PsICU/X-PsIcu-Android.ps1" -Clean
    & "$PSScriptRoot/submodules/PsICU/X-PsIcu-Android.ps1" -DistDirSuffix "Insane" -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -ForceDownloadNDK:$ForceDownloadNDK
}

function Build-BotanLibraryForInsane {
    [CmdletBinding()]
    param (
        [string]
        $AndroidAPI = [string]::Empty,

        [string]
        $DestinationDir = [string]::Empty,

        [switch]
        $ForceDownloadNDK
    )
    $DestinationDir = [string]::IsNullOrWhiteSpace($DestinationDir) ? "$(Get-CppLibsDir)" : $DestinationDir
    $AndroidAPI = Test-AndroidNDKApi -Api $AndroidAPI -Assert
    & "$PSScriptRoot/submodules/PsBotan/X-PsBotan-Android.ps1" -Clean
    & "$PSScriptRoot/submodules/PsBotan/X-PsBotan-Android.ps1" -DistDirSuffix "Insane" -AndroidAPI $AndroidAPI -DestinationDir $DestinationDir -ForceDownloadNDK:$ForceDownloadNDK
}

function Build-InsaneLibrary {
    [CmdletBinding()]
    param (
        [string]
        $AndroidAPI = [string]::Empty,

        [string]
        $DestinationDir = [string]::Empty,

        [string]
        $DistDirSuffix = [string]::Empty,

        [string]
        $LibSuffix = [string]::Empty,

        [string]
        $LibsDir = [string]::Empty,

        [switch]
        $ForceDownloadNDK
    )
    $AndroidAPI = Get-ValidAndroidNDKApi -Api $AndroidAPI -Latest -Assert
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
            throw "Botan $__PSBOTAN_BOTAN_VERSION library path not found `"$($botanConfiguration.DistDir)`"."
        }

        if (!(Test-Path "$($icuConfiguration.DistDir)" -PathType Container)) {
            throw "ICU $__PSICU_ICU_VERSION library path not found `"$($icuConfiguration.DistDir)`"."
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
        }
    }
}
