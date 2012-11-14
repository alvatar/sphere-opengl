(sphere: "opengl")
(dependencies:
 (gl-es (include
         (base: ffi-macros))
        (load
         (base: ffi)))
 ((= gl-es version: (debug))
  (include
   (base: ffi-macros version: (debug)))
  (load
   (base: ffi version: (debug))))
 (gl (include
      (base: ffi-macros))
     (load
      (base: ffi)))
 ((= gl version: (debug))
  (include
   (base: ffi-macros version: (debug)))
  (load
   (base: ffi version: (debug)))))

