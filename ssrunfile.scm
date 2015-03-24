(define libraries
  `(((spheres/opengl gl)
     .
     ,(lambda (lib)
        (if (eq? 'osx (ssrun#host-platform))
            (let ((cc-options
                   (string-append
                    (with-input-from-process
                     (list path: "pkg-config"
                           arguments: '("--cflags" "glew")) read-line)
                    "-I/System/Library/Frameworks/OpenGL.framework/Headers/ -w"))
                  (ld-options
                   (string-append
                    (with-input-from-process
                     (list path: "pkg-config"
                           arguments: '("--libs" "glew"))
                     read-line)
                    "-framework OpenGL -lGLEW")))
              (ssrun#compile-library
               lib
               cond-expand-features: '(debug)
               cc-options: cc-options
               ld-options: ld-options))
            (ssrun#compile-library
             lib
             cond-expand-features: '(debug)
             cc-options: "-w"
             ld-options: "-lGL"))))
    ((spheres/opengl gl-es)
     .
     ,(lambda (lib) (error "pending update")))))

(define-task (compile library) ()
  ;; This fixes and issue in OSX: pkg-config not finding GL
  ;; (if (eq? (sake#host-platform) 'osx)
  ;;     (setenv "PKG_CONFIG_PATH" "/opt/X11/lib/pkgconfig/"))
  (if library
      (let ((entry (assoc library libraries))) ((cdr entry) (car entry)))
      (for-each (lambda (entry) ((cdr entry) (car entry))) libraries)))

(define-task (test file) ()
  (if file
      (ssrun#run-file (string-append "test/" file))
      (ssrun#run-all-files "test/")))

(define-task clean ()
  (ssrun#clean-libraries (map car libraries)))

(define-task all (compile)
  (void))
