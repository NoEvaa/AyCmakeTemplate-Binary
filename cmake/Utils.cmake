# Utils
# 

# ==================================================
# Copy dynamic lib from `_source_lib` to `_target_lib`.
# Copy only when `_source_lib` is a shared library.
function(auto_copy_dynamic_lib _target_lib _source_lib)
    get_target_property(_source_lib_type ${_source_lib} TYPE)
    if(NOT ${_source_lib_type} MATCHES "SHARED")
        return()
    endif()
    add_custom_command(
        TARGET ${_target_lib}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:${_source_lib}>
        $<TARGET_FILE_DIR:${_target_lib}>
    )
endfunction()
