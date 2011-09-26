# Define arm tool chain
MACRO (USE_ARM_TOOLCHAIN)
    MESSAGE("Use arm toolchain.")

    # Define the dependency libraries root path.
    if (ONYX_SDK_ROOT)
        message("Onyx SDK Root path ${ONYX_SDK_ROOT}")
        SET(CMAKE_FIND_ROOT_PATH ${ONYX_SDK_ROOT})
        link_directories(${ONYX_SDK_ROOT}/lib)
    else (ONYX_SDK_ROOT)
        message("Use default path: /opt/onyx/arm/")
        SET(CMAKE_FIND_ROOT_PATH "/opt/onyx/arm/")
        link_directories("/opt/onyx/arm/lib")
    endif (ONYX_SDK_ROOT)
    SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

    if (${CMAKE_FIND_ROOT_PATH})
        SET(CMAKE_INSTALL_PREFIX  ${CMAKE_FIND_ROOT_PATH})
    else (${CMAKE_FIND_ROOT_PATH})
        SET(CMAKE_INSTALL_PREFIX  "/opt/onyx/arm/")
    endif (${CMAKE_FIND_ROOT_PATH})

    # For libraries and headers in the target directories
    SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

    # Set up development build mode
    SET(CMAKE_CXX_FLAGS "-s ")

    if (USE_CORTEX_A8)
        set(CMAKE_CXX_FLAGS "-s -fPIC -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=softfp ")
    endif (USE_CORTEX_A8)

    SET(CMAKE_BUILD_TYPE Release CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Devel."
        FORCE)

    SET(PDF_LIB libfpdfemb_arm.a)
    SET(TTS_LIB AiSound4)

    if (LINK_ZLIB_DEFAULT)
        SET(ADD_LIB m rt pthread dl z)
    else (LINK_ZLIB_DEFAULT)
        set(ADD_LIB m rt pthread dl)
    endif (LINK_ZLIB_DEFAULT)

    ADD_DEFINITIONS(-DBUILD_FOR_ARM)
    ADD_DEFINITIONS(-DENABLE_EINK_SCREEN)
    ADD_DEFINITIONS(-DBS60_INIT_MAIN)
    ADD_DEFINITIONS(-DBS80_INIT_MAIN)
    ADD_DEFINITIONS(-DBS97_INIT_MAIN)
    ADD_DEFINITIONS(-DSFM_M25P20) 

ENDMACRO(USE_ARM_TOOLCHAIN)
