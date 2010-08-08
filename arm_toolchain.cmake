# Define arm tool chain
MACRO (USE_ARM_TOOLCHAIN)
    MESSAGE("Use arm toolchain.")
    list(LENGTH "$ENV{CC}" cc_length)
    list(LENGTH "$ENV{CXX}" cxx_length)

    INCLUDE(CMakeForceCompiler)
    if (${cc_length} EQUAL 0)
        CMAKE_FORCE_C_COMPILER(arm-linux-gcc GNU)
    endif (${cc_length} EQUAL 0)
    if (${cxx_length} EQUAL 0)
        CMAKE_FORCE_CXX_COMPILER(arm-linux-g++ GNU)
    endif (${cxx_length} EQUAL 0)

    # Define the dependency libraries root path.
    if ($ENV{ONYX_SDK_ROOT})
        message("Onyx SDK Root path $ENV{ONYX_SDK_ROOT}")
        SET(CMAKE_FIND_ROOT_PATH $ENV{ONYX_SDK_ROOT})
    else ($ENV{ONYX_SDK_ROOT})
        message("Use default path: /opt/onyx/arm/")
        SET(CMAKE_FIND_ROOT_PATH "/opt/onyx/arm/")
    endif ($ENV{ONYX_SDK_ROOT})
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

    SET(PDF_LIB libfpdfemb_arm.a)
    SET(TTS_LIB AiSound4)
    SET(ADD_LIB z m rt pthread dl)

    ADD_DEFINITIONS(-DBUILD_FOR_ARM)
    ADD_DEFINITIONS(-DENABLE_EINK_SCREEN)
    ADD_DEFINITIONS(-DBS60_INIT_MAIN)
    ADD_DEFINITIONS(-DBS80_INIT_MAIN)
    ADD_DEFINITIONS(-DBS97_INIT_MAIN)
    ADD_DEFINITIONS(-DSFM_M25P20)


    IF($ENV{HAS_TOUCH})
        ADD_DEFINITIONS(-DHAS_TOUCH)
    ELSE ($ENV{HAS_TOUCH})
        UNSET(HAS_TOUCH)
    ENDIF ($ENV{HAS_TOUCH})

ENDMACRO(USE_ARM_TOOLCHAIN)
