(sphere: "opengl")
(dependencies:
 (gl-es (prelude
         (core: ffi-header))
        (load
         (core: ffi)))
 (gl-es-ext (prelude
             (core: ffi-header))
            (load
             (core: ffi)))
 (gl-es2 (prelude
          (core: ffi-header))
         (load
          (core: ffi)))
 (gl (cc-options
      (pkg-config--cflags "gl glew") "-w")
     (ld-options
      (pkg-config--libs "gl glew") "-w")
     (prelude
      (core: ffi-header))
     (load
      (core: ffi))))

