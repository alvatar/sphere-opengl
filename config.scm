(sphere: "opengl")
(dependencies:
 (gl-es (include
         (base: ffi#))
        (load
         (base: ffi)))
 ((= gl-es version: (debug))
  (include
   (base: ffi# version: (debug)))
  (load
   (base: ffi version: (debug))))
 (gl (include
      (base: ffi#))
     (load
      (base: ffi)))
 ((= gl version: (debug))
  (include
   (base: ffi# version: (debug)))
  (load
   (base: ffi version: (debug)))))

