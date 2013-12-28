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
  (for-each (lambda (m)
              (sake#compile-module m compiler-options: '(debug))
              (sake#compile-module m))
            gl-modules))

(define-task install ()
  (for-each (lambda (m) (sake#install-compiled-module m omit-o: #t versions: '(() (debug)))) gl-es-modules)
  (for-each (lambda (m) (sake#install-compiled-module m versions: '(() (debug)))) gl-modules))

(define-task force-install ()
  (sake#install-sphere-to-system))

(define-task all (compile install)
  'all)
