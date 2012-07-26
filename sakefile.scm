(define lib-directory "lib/")
(define gl-name "gl")
(define gl-es-name "gl-es")
(define lib-suffix ".o1")
(define c-suffix ".c")

(define-task init ()
  (make-directory (current-build-directory)))

(define-task clean (init)
  (delete-file (current-build-directory))
  (delete-file lib-directory))

(define-task gl (init)
  (gambit-eval-here
   `(begin
      (include "~~base/prelude#.scm")
      (define-cond-expand-feature x86)
      (compile-file "module.scm"
                    output: ,(string-append (current-build-directory) gl-name lib-suffix)
                    cc-options: "-w -I/usr/include/GL"
                    ld-options: "-lGL"))))

(define-task gl-es (init)
  (gambit-eval-here
   `(begin
      (include "~~base/prelude#.scm")
      (define-cond-expand-feature arm)
      (compile-file-to-target
       "module.scm"
       output: ,(string-append (current-build-directory) "gl-es" c-suffix)))))

(define-task install (gl gl-es)
  (make-directory lib-directory)
  (delete-file (string-append lib-directory gl-name lib-suffix))
  (delete-file (string-append lib-directory gl-es-name c-suffix))
  (copy-file (string-append (current-build-directory) gl-name lib-suffix)
             (string-append lib-directory gl-name lib-suffix))
  (copy-file (string-append (current-build-directory) gl-es-name c-suffix)
             (string-append lib-directory gl-es-name c-suffix)))

(define-task all (gl gl-es install)
  '(compile and install))
