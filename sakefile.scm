(include "~~spheres/prelude#.scm")
(%include sake: utils#)

(define gl-es-modules '(gl-es))
(define gl-modules '(gl))

(define-task clean ()
  (sake:default-clean))

(define-task compile ()
  ;; GL ES
  (for-each (lambda (m)
              (let ((include '((base: ffi#))))
                (sake:generate-c-file m include: include)
                (sake:generate-c-file m
                                      version: '(debug)
                                      include: include
                                      compiler-options: '(debug))))
            gl-es-modules)
  ;; GL
  (let ((cc-options "-w -I/usr/include/GL")
        (ld-options "-lGL"))
    (for-each (lambda (m)
                (sake:compile-c-file (sake:generate-c-file m include: '((base: ffi#)) verbose: #t)
                                     cc-options: cc-options
                                     ld-options: ld-options)
                (sake:compile-c-file (sake:generate-c-file
                                      m
                                      version: '(debug)
                                      include: '((base: ffi))
                                      compiler-options: '(debug))
                                     cc-options: cc-options
                                     ld-options: ld-options))
              gl-modules)))

(define-task install ()
  (for-each (lambda (m)
              (sake:install-compiled-module m omit-o: #t)
              (sake:install-compiled-module m version: '(debug) omit-o: #t))
            gl-es-modules)
  (for-each (lambda (m)
              (sake:install-compiled-module m omit-c: #t)
              (sake:install-compiled-module m version: '(debug)))
            gl-modules)
  (sake:install-system-sphere))

(define-task uninstall ()
  (sake:uninstall-system-sphere))

(define-task all (compile install)
  'all)
