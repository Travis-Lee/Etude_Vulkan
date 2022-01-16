cmake_minimum_required(VERSION 3.10)
project(StartVulkan)
set(CMAKE_CXX_STANDARD 23)
set(AUTO_LOAD_VULKAN ON)
include_directories(${PROJECT_NAME} SYSTEM ThirdParty/glfw3/include)
# ##################################
# 查找Vulkan位置并设置
# ##################################
#set(VULKAN_INCLUDE /usr/local/include)
#include_directories(${VULKAN_INCLUDE})
#set(VULKAN_DIR /usr/local/lib)
#link_directories(${VULKAN_DIR})
set(VULKAN_PATH "")
set(VULKAN_INCLUDE "")
set(VULKAN_LIBS "vulkan.1")
#set(VULKAN_LIBS "vulkan.1")

if (AUTO_LOAD_VULKAN MATCHES ON)
    MESSAGE(STATUS "start find package of vulkan...")

    # 查询vulkan包
    find_package(Vulkan)

    # 检查是否查询到Vulkan库了
    if (NOT ${Vulkan_INCLUDE_DIRS} STREQUAL "")
        set(VULKAN_PATH ${Vulkan_INCLUDE_DIRS})
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

link_directories(${PROJECT_NAME} ThirdParty/glfw3/lib-universal;${VULKAN_PATH}/../Lib)

add_executable(${PROJECT_NAME}
        main.cpp
        ElvApplication.cpp
        ElvWindow.cpp
        Vulkan/ElvDeviceVk.cpp
        Vulkan/ElvSwapchain.cpp
)


target_link_libraries(${PROJECT_NAME} glfw.3 ${VULKAN_LIBS} )
