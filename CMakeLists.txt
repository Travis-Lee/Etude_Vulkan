cmake_minimum_required(VERSION 3.10)
project(StartVulkan)


if(APPLE)
    set(CMAKE_MACOSX_RPATH 0)
    message(STATUS "Using MacOS for Complie Project")
endif()
add_definitions("-Wall -g")
set(CMAKE_BUILD_TYPE Release)

if (CMAKE_BUILD_TYPE MATCHES "(Release|RELEASE|release)")
   add_definitions(-Ofast)
   add_definitions(-ffast-math)
else()
   set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -g -ggdb")
endif()

add_definitions(-Wall -Wextra -Wno-unused-function)
add_definitions(-fPIC)

if(Android)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIE")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIE")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fPIE -pie")
endif()

set(CMAKE_CXX_STANDARD 23)
set(AUTO_LOAD_VULKAN ON)

include_directories(${PROJECT_NAME}  SYSTEM 3rdparty/glfw3/include)



# ##################################
# 查找Vulkan位置并设置
# ##################################
set(VULKAN_PATH "")
set(VULKAN_INCLUDE "")
set(VULKAN_LIBS "vulkan.1")

if (AUTO_LOAD_VULKAN MATCHES ON)
    MESSAGE(STATUS "start find package of vulkan...")
    # 查询vulkan包
    find_package(Vulkan)
    # 检查是否查询到Vulkan库了
    if (NOT ${Vulkan_INCLUDE_DIRS} STREQUAL "")
        set(VULKAN_PATH ${Vulkan_INCLUDE_DIRS})
        message(STATUS "vulkan path=======>${Vulkan_INCLUDE_DIRS}")
        set(VULKAN_INCLUDE ${Vulkan_INCLUDE_DIRS})
        # 将路径中的/include替换掉，得到VulkanSDK根目录
        #STRING(REGEX REPLACE "/Include" "" VULKAN_PATH ${VULKAN_PATH})
        # 打印vulkan目录结构信息
        MESSAGE(STATUS "Set VulkanSDK location and libs path: ")
        MESSAGE(STATUS "    VulkanSDK Path: ${VULKAN_PATH}")
        MESSAGE(STATUS "    VulkanSDK Include: ${VULKAN_INCLUDE}")
    else()
        # 没找到VulkanSDK
        MESSAGE(STATUS "Cannot found VulkanSDK folder, please make sure your installed VulkanSDK and try again...")
        return()
    endif()
endif()
message(STATUS "vulkan path:${VULKAN_PATH}")
# 设置头文件
include_directories(${PROJECT_NAME} ${VULKAN_INCLUDE})
link_directories(${PROJECT_NAME} 3rdparty/glfw3/lib-universal;${VULKAN_PATH}/../Lib)

add_executable(${PROJECT_NAME}
        example/main.cpp
)
target_link_libraries(${PROJECT_NAME} glfw.3 ${VULKAN_LIBS} )

add_executable(ex01
        example_01/main.cpp
)
target_link_libraries(ex01 glfw.3 ${VULKAN_LIBS} )

add_executable(ex02
        example_02/main.cpp
)
target_link_libraries(ex02 glfw.3 ${VULKAN_LIBS} )

add_executable(ex03
        example_03/main.cpp
)
target_link_libraries(ex03 glfw.3 ${VULKAN_LIBS} )
