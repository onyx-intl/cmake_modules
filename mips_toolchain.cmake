# Define mips tool chain
MACRO (USE_MIPS_TOOLCHAIN)
    MESSAGE("Use mips toolchain.")

    # Define the dependency libraries root path.
    if (ONYX_SDK_ROOT)
        message("Onyx SDK Root path ${ONYX_SDK_ROOT}")
        SET(CMAKE_FIND_ROOT_PATH ${ONYX_SDK_ROOT})
        link_directories(${ONYX_SDK_ROOT}/lib)
    else (ONYX_SDK_ROOT)
        message("Use default path: /opt/onyx/mips/")
        SET(CMAKE_FIND_ROOT_PATH "/opt/onyx/mips/")
        link_directories("/opt/onyx/mips/lib")
        link_directories("/opt/onyx/mips/lib/adobe")
    endif (ONYX_SDK_ROOT)
    SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

    if (${CMAKE_FIND_ROOT_PATH})
        SET(CMAKE_INSTALL_PREFIX  ${CMAKE_FIND_ROOT_PATH})
    else (${CMAKE_FIND_ROOT_PATH})
        SET(CMAKE_INSTALL_PREFIX  "/opt/onyx/mips/")
    endif (${CMAKE_FIND_ROOT_PATH})

    # For libraries and headers in the target directories
    SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

    # Set up development build mode
    SET(CMAKE_CXX_FLAGS "-s ")

    SET(CMAKE_BUILD_TYPE Release CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Devel."
        FORCE)

    SET(TTS_LIB AiSound4)
    SET(ADD_LIB m rt pthread dl)

    ADD_DEFINITIONS(-DBUILD_FOR_ARM)
    ADD_DEFINITIONS(-DENABLE_EINK_SCREEN)

ENDMACRO(USE_MIPS_TOOLCHAIN)
