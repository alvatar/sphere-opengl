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
      (cond-expand
       (osx (pkg-config--cflags "glew") "-w")
       (else
        (pkg-config--cflags "gl glew") "-w")))
     (ld-options
      (cond-expand
       (osx (pkg-config--libs "glew") "-L/usr/X11/lib/" "-lGL" "-w")
       (else
        (pkg-config--libs "gl glew") "-w")))
     (include
      (core: ffi-macros))
     (prelude
      (core: ffi-prelude))
     (load
      (core: ffi))))

