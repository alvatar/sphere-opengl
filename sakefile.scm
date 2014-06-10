(define gl-es-modules '(gl-es gl-es2 gl-es-ext))
(define gl-modules '(gl))

(define-task compile ()
  ;; This fixes and issue in OSX: pkg-config not finding Gl
  (if (eq? (sake#host-platform) 'osx)
      (setenv "PKG_CONFIG_PATH" "/opt/X11/lib/pkgconfig/"))
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

(define-task post-compile ()
  (for-each (lambda (m) (sake#make-module-available m omit-o: #t versions: '(() (debug)))) gl-es-modules)
  (for-each (lambda (m) (sake#make-module-available m versions: '(() (debug)))) gl-modules))

(define-task install ()
  (sake#install-sphere-to-system))

(define-task test ()
  (sake#test-all))

(define-task clean ()
  (sake#default-clean))

(define-task all (compile post-compile)
  'all)
