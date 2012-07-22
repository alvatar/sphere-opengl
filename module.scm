(%include base: ffi#)
(cond-expand
 (arm
  (%include gl-es))
 (x86
  (%include gl)))
