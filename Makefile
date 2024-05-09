# CXX = # Parameter
# AR = # Parameter
# LD = # Parameter
# CONFIGURATION = # Parameter
# SOURCES_DIR = # Parameter
# BUILD_DIR = # Parameter
# LIB_SUFFIX = # Parameter
# DIST_DIR = # Parameter
# JNILIBS_DIR = # Parameter
# ANDROID_ABI = # Parameter

# BOTAN_MAJOR_VERSION = # Parameter
# BOTAN_DIST_DIR = # Parameter
BOTAN_INCLUDE_DIR = $(BOTAN_DIST_DIR)/include/botan-$(BOTAN_MAJOR_VERSION)
BOTAN_LIB_DIR = $(BOTAN_DIST_DIR)/lib
BOTAN_LIB_NAME = libbotan-$(BOTAN_MAJOR_VERSION)
BOTAN_STATIC_LIB = $(BOTAN_LIB_DIR)/$(BOTAN_LIB_NAME).a
BOTAN_SHARED_LIB = $(BOTAN_LIB_DIR)/$(BOTAN_LIB_NAME).so
BOTAN_LIB_LD_PARAM = -lbotan-$(BOTAN_MAJOR_VERSION)

# ICU_DIST_DIR = # Parameter
# ICU_VERSION = # Parameter
ICU_INCLUDE_DIR = $(ICU_DIST_DIR)/include
ICU_LIB_DIR = $(ICU_DIST_DIR)/lib
ICU_STATIC_LIBS = $(ICU_LIB_DIR)/libicudata.a $(ICU_LIB_DIR)/libicui18n.a $(ICU_LIB_DIR)/libicuio.a $(ICU_LIB_DIR)/libicutu.a $(ICU_LIB_DIR)/libicuuc.a 
ICU_LIBS_LD_PARAM = -licudata -licui18n -licuio -licutu -licuuc

MY_SOURCES_DIR = $(SOURCES_DIR)/Source
MY_INCLUDE_DIR = $(SOURCES_DIR)/Include
LIB_NAME = libInsane$(LIB_SUFFIX)
STATIC_LIB_NAME = $(LIB_NAME).a
SHARED_LIB_NAME = $(LIB_NAME).so

INSANE_CPP_DIST_DIR = $(SOURCES_DIR)/submodules/InsaneCpp
INSANE_CPP_INCLUDE_DIR = $(INSANE_CPP_DIST_DIR)/Include
INSANE_CPP_SOURCE_DIR = $(INSANE_CPP_DIST_DIR)/Src

COMMON_CPP_INCLUDES_DIR = $(SOURCES_DIR)/submodules/CommonCppIncludes

DEBUG_STR      = Debug
RELEASE_STR    = Release
COMPILATION_DB_EXT = compile_commands.json

ifeq ($(CONFIGURATION), $(DEBUG_STR))
    OPTIMIZATION = -g -O0
else
	OPTIMIZATION = -O2
endif
INCLUDEFLAGS = -I$(MY_INCLUDE_DIR) -I$(BOTAN_INCLUDE_DIR) -I$(ICU_INCLUDE_DIR) -I$(COMMON_CPP_INCLUDES_DIR) -I$(INSANE_CPP_INCLUDE_DIR)
CXXFLAGS = -std=c++20 -fPIC $(OPTIMIZATION) $(INCLUDEFLAGS) -fexceptions -Wall -Wextra -Wpedantic -Wshadow -Wstrict-aliasing -Wstrict-overflow=5 -Wcast-align -Wmissing-declarations -Wpointer-arith -Wcast-qual -Wshorten-64-to-32 -Wtautological-compare
CPPFLAGS = -DINSANE_EXPORTS -D_REENTRANT
LDFLAGS = 
ARFLAGS = rcs

BUILD_FLAGS = $(CXXFLAGS) $(CPPFLAGS)
OBJS = $(BUILD_DIR)/InsaneTest.o $(BUILD_DIR)/InsaneException.o $(BUILD_DIR)/InsanePreprocessor.o $(BUILD_DIR)/InsaneString.o $(BUILD_DIR)/InsaneCore.o $(BUILD_DIR)/__InsaneCore.o $(BUILD_DIR)/InsaneCryptography.o $(BUILD_DIR)/Insane.o
OBJS_ALL = $(OBJS) $(BUILD_DIR)/InsaneAndroid.o

#Commands
CRLF = @pwsh -Command "[System.Console]::WriteLine()"
END = @echo END 

.PHONY: All Install

Install:
	@pwsh -Command "& \
	{ \
		Remove-Item -Path \"$(DIST_DIR)\" -Force -Recurse -ErrorAction Ignore; \
		New-Item -Path \"$(DIST_DIR)/Lib\" -ItemType Directory -Force | Out-Null; \
		Copy-Item -Path \"$(BUILD_DIR)/$(STATIC_LIB_NAME)\" -Destination \"$(DIST_DIR)/Lib\"; \
		Copy-Item -Path \"$(BUILD_DIR)/$(SHARED_LIB_NAME)\" -Destination \"$(DIST_DIR)/Lib\"; \
		New-Item -Path \"$(DIST_DIR)/Include/Insane\" -ItemType Directory -Force | Out-Null; \
		Copy-Item -Path \"$(INSANE_CPP_INCLUDE_DIR)/Insane/Insane*.h\" -Destination \"$(DIST_DIR)/Include/Insane\" -Force; \
		Copy-Item -Path \"$(MY_INCLUDE_DIR)/Insane/*.h\" -Destination \"$(DIST_DIR)/Include/Insane\" -Force; \
		Remove-Item -Path \"$(JNILIBS_DIR)/$(CONFIGURATION)/$(ANDROID_ABI)\" -Force -Recurse -ErrorAction Ignore; \
		New-Item -Path \"$(JNILIBS_DIR)/$(CONFIGURATION)/$(ANDROID_ABI)\" -ItemType Directory -Force | Out-Null; \
		New-Item -Path \"$(JNILIBS_DIR)/$(CONFIGURATION)/$(ANDROID_ABI)/Include/Insane\" -ItemType Directory -Force | Out-Null; \
		Copy-Item -Path \"$(BUILD_DIR)/$(SHARED_LIB_NAME)\" -Destination \"$(JNILIBS_DIR)/$(CONFIGURATION)/$(ANDROID_ABI)\"; \
		Copy-Item -Path \"$(BOTAN_SHARED_LIB)\" -Destination \"$(JNILIBS_DIR)/$(CONFIGURATION)/$(ANDROID_ABI)\"; \
		Copy-Item -Path \"$(DIST_DIR)/Include/Insane/*.h\" -Destination \"$(JNILIBS_DIR)/$(CONFIGURATION)/$(ANDROID_ABI)/Include/Insane\" -Force; \
	}"

All: $(BUILD_DIR)/$(STATIC_LIB_NAME) $(BUILD_DIR)/$(SHARED_LIB_NAME)

$(BUILD_DIR)/$(SHARED_LIB_NAME): $(OBJS_ALL)
	$(CRLF)	
	$(LD) -shared -fPIC -Wl,-soname,$(SHARED_LIB_NAME)  -o $@ $(OBJS_ALL) -L$(BOTAN_LIB_DIR) -L$(ICU_LIB_DIR) -Wl,-Bstatic $(ICU_LIBS_LD_PARAM) -Wl,-Bdynamic $(BOTAN_LIB_LD_PARAM) -ldl

$(BUILD_DIR)/$(STATIC_LIB_NAME): $(OBJS_ALL)
	$(CRLF)
	$(AR) $(ARFLAGS) $@ $(OBJS_ALL) $(BOTAN_STATIC_LIB) $(ICU_STATIC_LIBS)

$(BUILD_DIR)/InsaneAndroid.o: $(MY_SOURCES_DIR)/InsaneAndroid.cpp $(MY_INCLUDE_DIR)/Insane/InsaneAndroid.h $(INSANE_CPP_SOURCE_DIR)/*.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(MY_SOURCES_DIR)/InsaneAndroid.cpp -o $@

$(BUILD_DIR)/InsanePreprocessor.o: $(INSANE_CPP_SOURCE_DIR)/InsanePreprocessor.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/InsanePreprocessor.cpp -o $@

$(BUILD_DIR)/Insane.o: $(INSANE_CPP_SOURCE_DIR)/Insane.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/Insane.cpp -o $@

$(BUILD_DIR)/InsaneException.o: $(INSANE_CPP_SOURCE_DIR)/InsaneException.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/InsaneException.cpp -o $@

$(BUILD_DIR)/InsaneCore.o: $(INSANE_CPP_SOURCE_DIR)/InsaneCore.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/InsaneCore.cpp -o $@

$(BUILD_DIR)/__InsaneCore.o: $(INSANE_CPP_SOURCE_DIR)/__InsaneCore.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/__InsaneCore.cpp -o $@

$(BUILD_DIR)/InsaneTest.o: $(INSANE_CPP_SOURCE_DIR)/InsaneTest.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/InsaneTest.cpp -o $@

$(BUILD_DIR)/InsaneString.o: $(INSANE_CPP_SOURCE_DIR)/InsaneString.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/InsaneString.cpp -o $@

$(BUILD_DIR)/InsaneCryptography.o: $(INSANE_CPP_SOURCE_DIR)/InsaneCryptography.cpp $(INSANE_CPP_INCLUDE_DIR)/Insane/*.h
	$(CRLF)
	$(CXX) -MJ $@.$(COMPILATION_DB_EXT) $(BUILD_FLAGS) -c $(INSANE_CPP_SOURCE_DIR)/InsaneCryptography.cpp -o $@