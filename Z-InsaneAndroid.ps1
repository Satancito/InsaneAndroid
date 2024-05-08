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