(sphere: "opengl")
(dependencies:
 (gl-es (include
         (core: ffi-macros))
        (prelude
         (core: ffi-prelude))
        (load
         (core: ffi)))
 (gl-es-ext (include
             (core: ffi-macros))
            (prelude
             (core: ffi-prelude))
            (load
             (core: ffi)))
 (gl-es2 (include
          (core: ffi-macros))
         (prelude
          (core: ffi-prelude))
         (load
          (core: ffi)))
 (gl (cc-options
      (pkg-config--cflags "gl glew") "-w")
     (ld-options
      (pkg-config--libs "gl glew") "-w")
     (include
      (core: ffi-macros))
     (prelude
      (core: ffi-prelude))
     (load
      (core: ffi))))

