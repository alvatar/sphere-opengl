(%include base: ffi#)

(c-declare "#include \"gl.h\"")

(c-define-type GLenum unsigned-int)	
(c-define-type GLboolean unsigned-char)
(c-define-type GLbitfield unsigned-int)
(c-define-type GLvoid void)
(c-define-type GLbyte signed-char)
(c-define-type GLshort short)
(c-define-type GLint int)
(c-define-type GLubyte unsigned-char)
(c-define-type GLushort unsigned-short)
(c-define-type GLuint unsigned-int)
(c-define-type GLsizei int)
(c-define-type GLfloat float)
(c-define-type GLclampf float)
(c-define-type GLdouble double)
(c-define-type GLclampd double)


(define make-GLuint*
  (c-lambda () (pointer GLuint)
    "___result_voidstar = ___EXT(___alloc_rc)(sizeof(GLuint));\n"))

;; (define dereference-write-int*
;;   (c-lambda ((pointer int) int) void
;;     "*(int*)___arg1_voidstar = ___arg2;"))

;; (define dereference-read-int*
;;   (c-lambda ((pointer int)) int
;;     "___result = *(int*)___arg1_voidstar;"))


(c-constants
 GL_CURRENT_BIT
 GL_POINT_BIT
 GL_LINE_BIT
 GL_POLYGON_BIT
 GL_POLYGON_STIPPLE_BIT
 GL_PIXEL_MODE_BIT
 GL_LIGHTING_BIT
 GL_FOG_BIT
 GL_DEPTH_BUFFER_BIT
 GL_ACCUM_BUFFER_BIT
 GL_STENCIL_BUFFER_BIT
 GL_VIEWPORT_BIT
 GL_TRANSFORM_BIT
 GL_ENABLE_BIT
 GL_COLOR_BUFFER_BIT
 GL_HINT_BIT
 GL_EVAL_BIT
 GL_LIST_BIT
 GL_TEXTURE_BIT
 GL_SCISSOR_BIT
 GL_ALL_ATTRIB_BITS
 
 GL_MATRIX_MODE
 GL_MODELVIEW
 GL_PROJECTION
 GL_TEXTURE
 GL_VENDOR
 GL_RENDERER
 GL_VERSION
 GL_EXTENSIONS)


(define glBegin
  (c-lambda (GLenum) void "glBegin"))

(define glClear
  (c-lambda (GLbitfield) void "glClear"))

(define glClearColor
  (c-lambda (GLclampf GLclampf GLclampf GLclampf) void "glClearColor"))

(define glDeleteTextures
  (c-lambda (GLsizei (pointer GLuint)) void "glDeleteTextures"))

(define glEnd
  (c-lambda () void "glEnd"))

(define glGenTextures
  (c-lambda (GLsizei (pointer GLuint)) void "glGenTextures"))

(define glGetString
  (c-lambda (GLenum) char-string "glGetString"))

(define glLoadIdentity
  (c-lambda () void "glLoadIdentity"))

(define glMatrixMode
  (c-lambda (GLenum) void "glMatrixMode"))

(define glOrtho
  (c-lambda (GLdouble GLdouble GLdouble GLdouble GLdouble GLdouble) void
            "glOrtho"))

(define glVertex3f
  (c-lambda (GLfloat GLfloat GLfloat) void "glVertex3f"))

(define glViewport
  (c-lambda (GLint GLint GLsizei GLsizei) void "glViewport"))