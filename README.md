# InsaneAndroid
Insane native lib for Android.
### Prerequisites
- [PowerShell]("https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.4")
- GNU Make tool.
- Build Botan library.
- Build ICU library.

### Concept List
- ***AndroidAPI*** is the Android minSdkVersion. The Lowest value supported by NDK is 21 at this time.

- ***DistDir, distDir, DIST_DIR*** is the dist folder of the library. Format is `a/destination/dir/Insane-<Version>-Android-Api<AndroidAPI>-<ABI>-<Configuration><DistDirSuffix>`
Configuration values are Debug or Release. ABI values are Arm, Arm64, X86, X64. AndroidAPI is user defined. DistDirSuffix is user defined.   

- ***JNI_LIBS*** is the dist folder of the library for all ABIs. Format is `a/destination/dir/Insane-<Version>-Android-Api<AndroidAPI> JniLibs`

e.g. `Insane-1.0.0-Android-Api34 JniLibs`

### how to use?

## First steps
- Clone repository `git clone https://github.com/Satancito/InsaneAndroid.git`
- Update repository submodules. Inside repo run `./T-UpdateSubmodules.ps1`

## Build Botan library
Command `./X-InsaneAndroid.ps1 -BuildBotan -AndroidAPI <string> -DestinationDir <string> [-ForceDownloadNDK]`    
This command allows building Botan library for Android. If you have previously built ICU, ignore this step.
### Parameters
- ***AndroidAPI*** Optional. Defaults to lowest supported value. For consistency use the same value or lower in all libraries.  

- ***DestinationDir*** Optional. Defaults to `<USER_DIRECTORY>/.CppLibs/<DIST_DIR>`. This is the destination where the dist folder will be created.

- ***ForceDownloadNDK*** Optional. This flag forces the download of Android NDK.    

## Build ICU library
Command `./X-InsaneAndroid.ps1 -BuildICU -AndroidAPI <string> -DestinationDir <string> [-ForceDownloadNDK]`    
This command allows building ICU library for Android. If you have previously built ICU, ignore this step. 
### Parameters
- ***AndroidAPI*** Optional. Defaults to lowest supported value. For consistency use the same value or lower in all libraries.  

- ***DestinationDir*** Optional. Defaults to `<USER_DIRECTORY>/.CppLibs/<DIST_DIR>`. This is the destination where the dist folder will be created.

- ***ForceDownloadNDK*** Optional. This flag forces the download of Android NDK.    

## Build Insane
Command `./X-InsaneAndroid.ps1 [-Build] [-AndroidAPI <string>] [-DestinationDir <string>] [-DistDirSuffix <string>] [-LibSuffix <string>] [-LibsDir <string>] [-ForceDownloadNDK]`    
This command allows building the Insane library for all Android ABIs and generates a JniLibs folder for use in Android Native projects with Debug/Release configurations variants.

### Parameters
- ***AndroidAPI*** Optional. Defaults to lowest supported value. For consistency use the same value or lower in all libraries.  

- ***DestinationDir*** Optional. Defaults to `<USER_DIRECTORY>/.CppLibs/<DIST_DIR>`. This is the destination where the dist folder will be created.

- ***DistDirSuffix*** Optional. Defaults to empty. This is a suffix to add to the name of the dist folder.    
e.g. if `DistDirSuffix` is `Dev`, the dist folder is `<USER_DIRECTORY>/.CppLibs/<DIST_DIR>-Dev`

- ***LibSuffix*** Optional. Defaults to empty. This is a suffix to add to the name of the library.    
e.g. `LibSuffix` is `Internal`, the library names are `<USER_DIRECTORY>/.CppLibs/<DIST_DIR>/Lib/libInsaneInternal.so` and `<USER_DIRECTORY>/.CppLibs/<DIST_DIR>/Lib/libInsaneInternal.a`

- ***LibsDir*** Optional. Defaults to `<USER_DIRECTORY>/.CppLibs/.` This is the path where ICU and Botan libraries are located. 

- ***ForceDownloadNDK*** Optional. This flag forces the download of Android NDK. 

Compiled lib tree
```
<DIST_DIR>
├───Include
│   └───Insane
│           Insane.h
│           InsaneAndroid.h
│           InsaneCore.h
│           InsaneCryptography.h
│           InsaneException.h
│           InsanePreprocessor.h
│           InsaneString.h
│           InsaneTest.h
│
└───Lib
        libInsane.a
        libInsane.so
```

JniLibs dir tree
```
<JNI_LIBS>
├───Debug
│   ├───arm64-v8a
│   │   └───Include
│   │       └───Insane
│   ├───armeabi-v7a
│   │   └───Include
│   │       └───Insane
│   ├───x86
│   │   └───Include
│   │       └───Insane
│   └───x86_64
│       └───Include
│           └───Insane
└───Release
    ├───arm64-v8a
    │   └───Include
    │       └───Insane
    ├───armeabi-v7a
    │   └───Include
    │       └───Insane
    ├───x86
    │   └───Include
    │       └───Insane
    └───x86_64
        └───Include
            └───Insane
```


## Build Combo - (Botan + ICU + Insane)
Command `./X-InsaneAndroid.ps1 -BuildAll -AndroidAPI <string> [-DestinationDir <string>] [-DistDirSuffix <string>] [-LibSuffix <string>] [-LibsDir <string>] [-ForceDownloadNDK] [-SkipICU] [-SkipBotan]`    
This command allows building Botan, ICU and Insane libs. Building Botan and ICU can be skipped.

### Parameters

Same parameters as Insane build command with the following aditions

- ***SkipBotan*** Optional. This flag allow skipping Botan build.

- ***SkipICU*** Optional. This flag allow skipping ICU build.

## Clean - Temp
Command `./X-InsaneAndroid.ps1 -Clean`   
This Command allows to remove InsaneAndroid temp dir `<USER_DIRECTORY>/.InsaneAndroid`