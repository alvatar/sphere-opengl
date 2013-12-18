(define gl-es-modules '(gl-es gl-es-ext))
(define gl-modules '(gl))

(define-task clean ()
  (sake#default-clean))

(define-task compile ()
  ;; GL ES
  (for-each (lambda (m)
              (sake#compile-to-c m)
              (sake#compile-to-c m compiler-options: '(debug)))
            gl-es-modules)
  ;; GL
  (let ((cc-options "-w -I/usr/include/GL")
        (ld-options "-lGL -lGLEW"))
    (for-each (lambda (m)
                (sake#compile-c-to-o (sake#compile-to-c m)
                                     cc-options: cc-options
                                     ld-options: ld-options)
                (sake#compile-c-to-o (sake#compile-to-c m compiler-options: '(debug))
                                     cc-options: cc-options
                                     ld-options: ld-options))
              gl-modules)))

(define-task install ()
  (for-each (lambda (m) (sake#install-compiled-module m omit-o: #t versions: '(() (debug)))) gl-es-modules)
  (for-each (lambda (m) (sake#install-compiled-module m versions: '(() (debug)))) gl-modules))

(define-task all (compile install)
  'all)
