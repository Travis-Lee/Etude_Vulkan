#!/usr/bin/env bash

# we run clang-format and astyle twice to get stable format output

find example/ example_01/ example_02/ example_03/ -type f -name '*.h' -o -name '*.cpp' | xargs -i clang-format -i {}

astyle -n -r "example/*.h,*.cpp,*.cc" "example_01/*.h,*.cpp,*.cc" "example_02/*.h,*.cpp,*.cc" "example_03/*.h,*.cpp,*.cc" 
