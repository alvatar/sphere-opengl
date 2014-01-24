;; Incomplete API

(c-declare "#include \"GLES/gl.h\"")

(c-define-type GLenum unsigned-int)
(c-define-type GLboolean bool)
(c-define-type GLbitfield unsigned-int)
(c-define-type GLvoid void)
(c-define-type GLvoid* (pointer void #f))
(c-define-type GLbyte signed-char)
(c-define-type GLshort short)
(c-define-type GLint int)
(c-define-type GLubyte unsigned-char)
(c-define-type GLushort unsigned-short)
(c-define-type GLuint unsigned-int)
(c-define-type GLsizei int)
(c-define-type GLfloat float)
(c-define-type GLclampf float)
(c-define-type GLclampd double)

;;! GLbyte
(c-define-type* GLbyte)
(c-define-sizeof GLbyte)
(c-define-array GLbyte scheme-vector: s8)

;;! GLubyte
(c-define-type* GLubyte)
(c-define-sizeof GLubyte)
(c-define-array GLubyte scheme-vector: u8)

;;! GLushort
(c-define-type* GLshort)
(c-define-sizeof GLshort)
(c-define-array GLshort scheme-vector: s16)

;;! GLushort
(c-define-type* GLushort)
(c-define-sizeof GLushort)
(c-define-array GLushort scheme-vector: u16)

;;! GLint
(c-define-type* GLint)
(c-define-sizeof GLint)
(c-define-array GLint scheme-vector: s32)

;;! GLuint
(c-define-type* GLuint)
(c-define-sizeof GLuint)
(c-define-array GLuint scheme-vector: u32)

;;! GLsizei
(c-define-type* GLsizei)
(c-define-sizeof GLsizei)
(c-define-array GLsizei scheme-vector: s64)

;;! GLfloat
(c-define-type* GLfloat)
(c-define-sizeof GLfloat)
(c-define-array GLfloat scheme-vector: f32)


(define make-GLuint*
  (c-lambda (size-t) GLuint*
    "___result_voidstar = ___EXT(___alloc_rc)(___arg1*sizeof(GLuint));\n"))

(define GLuint*-ref
  (c-lambda (GLuint* size-t) GLuint
            "___result = ((GLuint*)___arg1)[___arg2];"))

;;; GLfloat array

(define make-GLfloat*
  (c-lambda (size-t) GLfloat*
            "___result_voidstar = malloc(___arg1*sizeof(GLfloat));"))

(define GLfloat*-ref
  (c-lambda (GLfloat* size-t) GLfloat
            "___result = ((GLfloat*)___arg1)[___arg2];"))

(define GLfloat*-set!
  (c-lambda (GLfloat* size-t GLfloat) void
            "((GLfloat*)___arg1)[___arg2] = ___arg3;"))

(define (vector->GLfloat* vec)
  (let* ((length (vector-length vec))
         (buf (make-GLfloat* length)))
    (let loop ((i 0))
      (if (< i length)
          (begin
            (GLfloat*-set! buf i (vector-ref vec i))
            (loop (+ i 1)))
          buf))))

;;; GLushort array

(define make-GLushort*
  (c-lambda (size-t) GLushort*
            "___result_voidstar = malloc(___arg1*sizeof(GLushort));"))

(define GLushort*-ref
  (c-lambda (GLushort* size-t) GLushort
            "___result = ((GLushort*)___arg1)[___arg2];"))

(define GLushort*-set!
  (c-lambda (GLushort* size-t GLushort) void
            "((GLushort*)___arg1)[___arg2] = ___arg3;"))

(define (vector->GLushort* vec)
  (let* ((length (vector-length vec))
         (buf (make-GLushort* length)))
    (let loop ((i 0))
      (if (< i length)
          (begin
            (GLushort*-set! buf i (vector-ref vec i))
            (loop (+ i 1)))
          buf))))

;; (define GLshort*->void*
;;   (c-lambda (GLshort*) (pointer void)
;;             "___result_voidstar = (void*)___arg1;"))

;; (define dereference-write-int*
;;   (c-lambda ((pointer int) int) void
;;     "*(int*)___arg1_voidstar = ___arg2;"))

;; (define dereference-read-int*
;;   (c-lambda ((pointer int)) int
;;     "___result = *(int*)___arg1_voidstar;"))


(c-define-constants
 ;; Core versions
 GL_VERSION_ES_CM_1_0
 GL_VERSION_ES_CL_1_0
 GL_VERSION_ES_CM_1_1
 GL_VERSION_ES_CL_1_1

 ;; ClearBufferMask
 GL_DEPTH_BUFFER_BIT  
 GL_STENCIL_BUFFER_BIT
 GL_COLOR_BUFFER_BIT  

 ;; Boolean
GL_FALSE
GL_TRUE 

;; BeginMode
GL_POINTS        
GL_LINES         
GL_LINE_LOOP     
GL_LINE_STRIP    
GL_TRIANGLES     
GL_TRIANGLE_STRIP
GL_TRIANGLE_FAN  

;; AlphaFunction
GL_NEVER   
GL_LESS    
GL_EQUAL   
GL_LEQUAL  
GL_GREATER 
GL_NOTEQUAL
GL_GEQUAL  
GL_ALWAYS  

;; BlendingFactorDest
GL_ZERO               
GL_ONE                
GL_SRC_COLOR          
GL_ONE_MINUS_SRC_COLOR
GL_SRC_ALPHA          
GL_ONE_MINUS_SRC_ALPHA
GL_DST_ALPHA          
GL_ONE_MINUS_DST_ALPHA

;; BlendingFactorSrc
GL_DST_COLOR          
GL_ONE_MINUS_DST_COLOR
GL_SRC_ALPHA_SATURATE 

;; ClipPlaneName
GL_CLIP_PLANE0
GL_CLIP_PLANE1
GL_CLIP_PLANE2
GL_CLIP_PLANE3
GL_CLIP_PLANE4
GL_CLIP_PLANE5

;; CullFaceMode
GL_FRONT         
GL_BACK          
GL_FRONT_AND_BACK

;; EnableCap
GL_FOG           
GL_LIGHTING      
GL_TEXTURE_2D    
GL_CULL_FACE     
GL_ALPHA_TEST    
GL_BLEND         
GL_COLOR_LOGIC_OP
GL_DITHER        
GL_STENCIL_TEST  
GL_DEPTH_TEST    
GL_POINT_SMOOTH            
GL_LINE_SMOOTH             
GL_SCISSOR_TEST            
GL_COLOR_MATERIAL          
GL_NORMALIZE               
GL_RESCALE_NORMAL          
GL_POLYGON_OFFSET_FILL     
GL_VERTEX_ARRAY            
GL_NORMAL_ARRAY            
GL_COLOR_ARRAY             
GL_TEXTURE_COORD_ARRAY     
GL_MULTISAMPLE             
GL_SAMPLE_ALPHA_TO_COVERAGE
GL_SAMPLE_ALPHA_TO_ONE     
GL_SAMPLE_COVERAGE         

;; ErrorCode
GL_NO_ERROR         
GL_INVALID_ENUM     
GL_INVALID_VALUE    
GL_INVALID_OPERATION
GL_STACK_OVERFLOW   
GL_STACK_UNDERFLOW  
GL_OUT_OF_MEMORY    

;; FogMode
GL_EXP 
GL_EXP2

;; FogParameter
GL_FOG_DENSITY
GL_FOG_START  
GL_FOG_END    
GL_FOG_MODE   
GL_FOG_COLOR  

;; FrontFaceDirection
GL_CW 
GL_CCW

;; GetPName
GL_CURRENT_COLOR              
GL_CURRENT_NORMAL             
GL_CURRENT_TEXTURE_COORDS     
GL_POINT_SIZE                 
GL_POINT_SIZE_MIN             
GL_POINT_SIZE_MAX             
GL_POINT_FADE_THRESHOLD_SIZE  
GL_POINT_DISTANCE_ATTENUATION 
GL_SMOOTH_POINT_SIZE_RANGE    
GL_LINE_WIDTH                 
GL_SMOOTH_LINE_WIDTH_RANGE    
GL_ALIASED_POINT_SIZE_RANGE   
GL_ALIASED_LINE_WIDTH_RANGE   
GL_CULL_FACE_MODE             
GL_FRONT_FACE                 
GL_SHADE_MODEL                
GL_DEPTH_RANGE                
GL_DEPTH_WRITEMASK            
GL_DEPTH_CLEAR_VALUE          
GL_DEPTH_FUNC                 
GL_STENCIL_CLEAR_VALUE        
GL_STENCIL_FUNC               
GL_STENCIL_VALUE_MASK         
GL_STENCIL_FAIL               
GL_STENCIL_PASS_DEPTH_FAIL    
GL_STENCIL_PASS_DEPTH_PASS    
GL_STENCIL_REF                
GL_STENCIL_WRITEMASK          
GL_MATRIX_MODE                
GL_VIEWPORT                   
GL_MODELVIEW_STACK_DEPTH      
GL_PROJECTION_STACK_DEPTH     
GL_TEXTURE_STACK_DEPTH        
GL_MODELVIEW_MATRIX           
GL_PROJECTION_MATRIX          
GL_TEXTURE_MATRIX             
GL_ALPHA_TEST_FUNC            
GL_ALPHA_TEST_REF             
GL_BLEND_DST                  
GL_BLEND_SRC                  
GL_LOGIC_OP_MODE              
GL_SCISSOR_BOX                
GL_SCISSOR_TEST               
GL_COLOR_CLEAR_VALUE          
GL_COLOR_WRITEMASK            
GL_UNPACK_ALIGNMENT           
GL_PACK_ALIGNMENT             
GL_MAX_LIGHTS                 
GL_MAX_CLIP_PLANES            
GL_MAX_TEXTURE_SIZE           
GL_MAX_MODELVIEW_STACK_DEPTH  
GL_MAX_PROJECTION_STACK_DEPTH 
GL_MAX_TEXTURE_STACK_DEPTH    
GL_MAX_VIEWPORT_DIMS          
GL_MAX_TEXTURE_UNITS          
GL_SUBPIXEL_BITS              
GL_RED_BITS                   
GL_GREEN_BITS                 
GL_BLUE_BITS                  
GL_ALPHA_BITS                 
GL_DEPTH_BITS                 
GL_STENCIL_BITS               
GL_POLYGON_OFFSET_UNITS       
GL_POLYGON_OFFSET_FILL        
GL_POLYGON_OFFSET_FACTOR      
GL_TEXTURE_BINDING_2D         
GL_VERTEX_ARRAY_SIZE          
GL_VERTEX_ARRAY_TYPE          
GL_VERTEX_ARRAY_STRIDE        
GL_NORMAL_ARRAY_TYPE          
GL_NORMAL_ARRAY_STRIDE        
GL_COLOR_ARRAY_SIZE           
GL_COLOR_ARRAY_TYPE           
GL_COLOR_ARRAY_STRIDE         
GL_TEXTURE_COORD_ARRAY_SIZE   
GL_TEXTURE_COORD_ARRAY_TYPE   
GL_TEXTURE_COORD_ARRAY_STRIDE 
GL_VERTEX_ARRAY_POINTER       
GL_NORMAL_ARRAY_POINTER       
GL_COLOR_ARRAY_POINTER        
GL_TEXTURE_COORD_ARRAY_POINTER
GL_SAMPLE_BUFFERS             
GL_SAMPLES                    
GL_SAMPLE_COVERAGE_VALUE      
GL_SAMPLE_COVERAGE_INVERT     

;; GetTextureParameter
GL_NUM_COMPRESSED_TEXTURE_FORMATS
GL_COMPRESSED_TEXTURE_FORMATS    

;; HintMode
GL_DONT_CARE
GL_FASTEST  
GL_NICEST   

;; HintTarget
GL_PERSPECTIVE_CORRECTION_HINT
GL_POINT_SMOOTH_HINT          
GL_LINE_SMOOTH_HINT           
GL_FOG_HINT                   
GL_GENERATE_MIPMAP_HINT       

;; LightModelParameter
GL_LIGHT_MODEL_AMBIENT 
GL_LIGHT_MODEL_TWO_SIDE

;; LightParameter
GL_AMBIENT              
GL_DIFFUSE              
GL_SPECULAR             
GL_POSITION             
GL_SPOT_DIRECTION       
GL_SPOT_EXPONENT        
GL_SPOT_CUTOFF          
GL_CONSTANT_ATTENUATION 
GL_LINEAR_ATTENUATION   
GL_QUADRATIC_ATTENUATION

;; DataType
GL_BYTE          
GL_UNSIGNED_BYTE 
GL_SHORT         
GL_UNSIGNED_SHORT
GL_FLOAT         
GL_FIXED         

;; LogicOp
GL_CLEAR        
GL_AND          
GL_AND_REVERSE  
GL_COPY         
GL_AND_INVERTED 
GL_NOOP         
GL_XOR          
GL_OR           
GL_NOR          
GL_EQUIV        
GL_INVERT       
GL_OR_REVERSE   
GL_COPY_INVERTED
GL_OR_INVERTED  
GL_NAND         
GL_SET          

;; MaterialParameter
GL_EMISSION           
GL_SHININESS          
GL_AMBIENT_AND_DIFFUSE

;; MatrixMode
GL_MODELVIEW 
GL_PROJECTION
GL_TEXTURE   

;; PixelFormat
GL_ALPHA          
GL_RGB            
GL_RGBA
GL_LUMINANCE      
GL_LUMINANCE_ALPHA

;; PixelStoreParameter
GL_UNPACK_ALIGNMENT
GL_PACK_ALIGNMENT  

;; PixelType
GL_UNSIGNED_SHORT_4_4_4_4
GL_UNSIGNED_SHORT_5_5_5_1
GL_UNSIGNED_SHORT_5_6_5  

;; ShadingModel
GL_FLAT  
GL_SMOOTH

;; StencilOp
GL_KEEP   
GL_REPLACE
GL_INCR   
GL_DECR   

;; StringName
GL_VENDOR    
GL_RENDERER  
GL_VERSION   
GL_EXTENSIONS

;; TextureEnvMode
GL_MODULATE
GL_DECAL   
GL_ADD     

;; TextureEnvParameter
GL_TEXTURE_ENV_MODE 
GL_TEXTURE_ENV_COLOR

;; TextureEnvTarget
GL_TEXTURE_ENV_MODE 
GL_TEXTURE_ENV_COLOR

;; TextureMagFilter
GL_NEAREST
GL_LINEAR 

;; TextureMinFilter
GL_NEAREST_MIPMAP_NEAREST
GL_LINEAR_MIPMAP_NEAREST 
GL_NEAREST_MIPMAP_LINEAR 
GL_LINEAR_MIPMAP_LINEAR  

;; TextureParameterName
GL_TEXTURE_MAG_FILTER
GL_TEXTURE_MIN_FILTER
GL_TEXTURE_WRAP_S    
GL_TEXTURE_WRAP_T    
GL_GENERATE_MIPMAP   

;; TextureUnit
GL_TEXTURE0             
GL_TEXTURE1             
GL_TEXTURE2             
GL_TEXTURE3             
GL_TEXTURE4             
GL_TEXTURE5             
GL_TEXTURE6             
GL_TEXTURE7             
GL_TEXTURE8             
GL_TEXTURE9             
GL_TEXTURE10            
GL_TEXTURE11            
GL_TEXTURE12            
GL_TEXTURE13            
GL_TEXTURE14            
GL_TEXTURE15            
GL_TEXTURE16            
GL_TEXTURE17            
GL_TEXTURE18            
GL_TEXTURE19            
GL_TEXTURE20            
GL_TEXTURE21            
GL_TEXTURE22            
GL_TEXTURE23            
GL_TEXTURE24            
GL_TEXTURE25            
GL_TEXTURE26            
GL_TEXTURE27            
GL_TEXTURE28            
GL_TEXTURE29            
GL_TEXTURE30            
GL_TEXTURE31            
GL_ACTIVE_TEXTURE       
GL_CLIENT_ACTIVE_TEXTURE

;; TextureWrapMode
GL_REPEAT       
GL_CLAMP_TO_EDGE

;; LightName
GL_LIGHT0
GL_LIGHT1
GL_LIGHT2
GL_LIGHT3
GL_LIGHT4
GL_LIGHT5
GL_LIGHT6
GL_LIGHT7

;; Buffer Objects
GL_ARRAY_BUFFER        
GL_ELEMENT_ARRAY_BUFFER
GL_ARRAY_BUFFER_BINDING              
GL_ELEMENT_ARRAY_BUFFER_BINDING      
GL_VERTEX_ARRAY_BUFFER_BINDING       
GL_NORMAL_ARRAY_BUFFER_BINDING       
GL_COLOR_ARRAY_BUFFER_BINDING        
GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING
GL_STATIC_DRAW   
GL_DYNAMIC_DRAW  
GL_BUFFER_SIZE   
GL_BUFFER_USAGE  
GL_SUBTRACT      
GL_COMBINE       
GL_COMBINE_RGB   
GL_COMBINE_ALPHA 
GL_RGB_SCALE     
GL_ADD_SIGNED    
GL_INTERPOLATE   
GL_CONSTANT      
GL_PRIMARY_COLOR 
GL_PREVIOUS      
GL_OPERAND0_RGB  
GL_OPERAND1_RGB  
GL_OPERAND2_RGB  
GL_OPERAND0_ALPHA
GL_OPERAND1_ALPHA
GL_OPERAND2_ALPHA
GL_ALPHA_SCALE   
GL_SRC0_RGB      
GL_SRC1_RGB      
GL_SRC2_RGB      
GL_SRC0_ALPHA    
GL_SRC1_ALPHA    
GL_SRC2_ALPHA    
GL_DOT3_RGB      
GL_DOT3_RGBA
)


(define glBlendFunc
  (c-lambda (GLenum GLenum) void "glBlendFunc"))

(define glBindTexture
  (c-lambda (GLenum GLint) void "glBindTexture"))

(define glClear
  (c-lambda (GLbitfield) void "glClear"))

(define glClearColor
  (c-lambda (GLclampf GLclampf GLclampf GLclampf) void "glClearColor"))

;; (define glColor4f
;;   (c-lambda (GLfloat GLfloat GLfloat GLfloat) void "glColor4f"))

(define glDeleteTextures
  (c-lambda (GLsizei (pointer GLuint)) void "glDeleteTextures"))

(define glDrawElements
  (c-lambda (GLenum GLsizei GLenum (pointer GLvoid))
            void
            "glDrawElements"))

(define glEnable
  (c-lambda (GLenum) void "glEnable"))

(define glEnableClientState
  (c-lambda (GLenum) void "glEnableClientState"))

(define glDisable
  (c-lambda (GLenum) void "glDisable"))

(define glDisableClientState
  (c-lambda (GLenum) void "glDisableClientState"))

(define glGenTextures
  (c-lambda (GLsizei (pointer GLuint)) void "glGenTextures"))

(define glGetString
  (c-lambda (GLenum) char-string "glGetString"))

(define glLoadIdentity
  (c-lambda () void "glLoadIdentity"))

(define glMatrixMode
  (c-lambda (GLenum) void "glMatrixMode"))

(define glOrthof
  (c-lambda (GLfloat GLfloat GLfloat GLfloat GLfloat GLfloat) void
            "glOrthof"))

;; (define glOrthox
;;   (c-lambda (GLfixed GLfixed GLfixed GLfixed GLfixed GLfixed) void
;;             "glOrtho"))

(define glPopMatrix
  (c-lambda () void "glPopMatrix"))

(define glPushMatrix
  (c-lambda () void "glPushMatrix"))

(define glTexParameteri
  (c-lambda (GLenum GLenum GLint) void "glTexParameteri"))

(define glTexParameterf
  (c-lambda (GLenum GLenum GLfloat) void "glTexParameterf"))

(define glTexImage2D
  (c-lambda (GLenum GLint GLint GLsizei GLsizei GLint GLenum GLenum (pointer GLvoid))
            void
            "glTexImage2D"))

(define glTexCoordPointer
  (c-lambda (GLint GLenum GLsizei GLvoid*) void "glTexCoordPointer"))

(define glTexSubImage2D
  (c-lambda (GLenum GLint GLint GLint GLsizei GLsizei GLenum GLenum GLvoid*) void "glTexSubImage2D"))

(define glVertexPointer
  (c-lambda (GLint GLenum GLsizei GLvoid*) void "glVertexPointer"))

(define glViewport
  (c-lambda (GLint GLint GLsizei GLsizei) void "glViewport"))
