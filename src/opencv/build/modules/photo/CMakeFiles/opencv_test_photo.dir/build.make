# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build

# Include any dependencies generated for this target.
include modules/photo/CMakeFiles/opencv_test_photo.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.make

# Include the progress variables for this target.
include modules/photo/CMakeFiles/opencv_test_photo.dir/progress.make

# Include the compile flags for this target's objects.
include modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make

modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/ocl/test_denoising.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/ocl/test_denoising.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/ocl/test_denoising.cpp > CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/ocl/test_denoising.cpp -o CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_cloning.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_cloning.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_cloning.cpp > CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_cloning.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_decolor.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_decolor.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_decolor.cpp > CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_decolor.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoise_tvl1.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoise_tvl1.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoise_tvl1.cpp > CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoise_tvl1.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cpp > CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cuda.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cuda.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cuda.cpp > CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_denoising.cuda.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_hdr.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_hdr.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_hdr.cpp > CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_hdr.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_inpaint.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_inpaint.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_inpaint.cpp > CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_inpaint.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_main.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_main.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_main.cpp > CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_main.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.s

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/flags.make
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o: /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_npr.cpp
modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o: modules/photo/CMakeFiles/opencv_test_photo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o -MF CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o.d -o CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o -c /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_npr.cpp

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.i"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_npr.cpp > CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.i

modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.s"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo/test/test_npr.cpp -o CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.s

# Object files for target opencv_test_photo
opencv_test_photo_OBJECTS = \
"CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o" \
"CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o"

# External object files for target opencv_test_photo
opencv_test_photo_EXTERNAL_OBJECTS =

bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/ocl/test_denoising.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_cloning.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_decolor.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoise_tvl1.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_denoising.cuda.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_hdr.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_inpaint.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_main.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/test/test_npr.cpp.o
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/build.make
bin/opencv_test_photo: lib/libopencv_ts.a
bin/opencv_test_photo: lib/libopencv_photo.a
bin/opencv_test_photo: lib/libopencv_imgcodecs.a
bin/opencv_test_photo: lib/libopencv_videoio.a
bin/opencv_test_photo: lib/libopencv_core.a
bin/opencv_test_photo: lib/libopencv_imgproc.a
bin/opencv_test_photo: lib/libopencv_core.a
bin/opencv_test_photo: lib/libopencv_imgproc.a
bin/opencv_test_photo: lib/libopencv_imgcodecs.a
bin/opencv_test_photo: lib/libopencv_videoio.a
bin/opencv_test_photo: lib/libopencv_highgui.a
bin/opencv_test_photo: lib/libopencv_core.a
bin/opencv_test_photo: lib/libopencv_imgproc.a
bin/opencv_test_photo: 3rdparty/lib/libippiw.a
bin/opencv_test_photo: 3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a
bin/opencv_test_photo: lib/libopencv_videoio.a
bin/opencv_test_photo: lib/libopencv_imgcodecs.a
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libjpeg.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libwebp.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libpng.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libtiff.so
bin/opencv_test_photo: /home/muhammad/anaconda3/lib/libopenjp2.so.2.4.0
bin/opencv_test_photo: 3rdparty/lib/libIlmImf.a
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libavcodec.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libavformat.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libavutil.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libswscale.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libgtk-3.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libgdk-3.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libpango-1.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libharfbuzz.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libatk-1.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libcairo-gobject.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libcairo.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libgio-2.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libgobject-2.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libgthread-2.0.so
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libglib-2.0.so
bin/opencv_test_photo: lib/libopencv_imgproc.a
bin/opencv_test_photo: lib/libopencv_core.a
bin/opencv_test_photo: /usr/lib/x86_64-linux-gnu/libz.so
bin/opencv_test_photo: 3rdparty/lib/libittnotify.a
bin/opencv_test_photo: 3rdparty/lib/libippiw.a
bin/opencv_test_photo: 3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a
bin/opencv_test_photo: modules/photo/CMakeFiles/opencv_test_photo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Linking CXX executable ../../bin/opencv_test_photo"
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/opencv_test_photo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
modules/photo/CMakeFiles/opencv_test_photo.dir/build: bin/opencv_test_photo
.PHONY : modules/photo/CMakeFiles/opencv_test_photo.dir/build

modules/photo/CMakeFiles/opencv_test_photo.dir/clean:
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo && $(CMAKE_COMMAND) -P CMakeFiles/opencv_test_photo.dir/cmake_clean.cmake
.PHONY : modules/photo/CMakeFiles/opencv_test_photo.dir/clean

modules/photo/CMakeFiles/opencv_test_photo.dir/depend:
	cd /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/modules/photo /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo /home/muhammad/Development/flutter-projects/camera_testing/native_test/opencv/build/modules/photo/CMakeFiles/opencv_test_photo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : modules/photo/CMakeFiles/opencv_test_photo.dir/depend

