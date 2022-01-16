cmake_minimum_required(VERSION 3.10)
project(StartVulkan)
set(CMAKE_CXX_STANDARD 23)

include_directories(${PROJECT_NAME}  SYSTEM ThirdParty/glfw3/include)
link_directories(${PROJECT_NAME} ThirdParty/glfw3/lib-universal)
add_executable(${PROJECT_NAME}
        main.cpp
)
target_link_libraries(${PROJECT_NAME} glfw.3)
