(c-declare "#include \"glew.h\"")
(c-declare "#include \"gl.h\"")

(c-define-type GLenum unsigned-int)
(c-define-type GLboolean bool)
(c-define-type GLbitfield unsigned-int)
(c-define-type GLvoid void)
(c-define-type GLvoid* (pointer void))
(c-define-type GLbyte signed-char)
(c-define-type GLbyte* (pointer GLbyte))
(c-define-type GLshort short)
(c-define-type GLshort* (pointer GLshort))
(c-define-type GLint int)
(c-define-type GLint* (pointer GLint))
(c-define-type GLubyte unsigned-char)
(c-define-type GLubyte* (pointer GLubyte))
(c-define-type GLushort unsigned-short)
(c-define-type GLushort* (pointer GLushort))
(c-define-type GLuint unsigned-int)
(c-define-type GLuint* (pointer GLuint))
(c-define-type GLsizei int)
(c-define-type GLsizei* (pointer GLsizei))
(c-define-type GLfloat float)
(c-define-type GLfloat* (pointer GLfloat))
(c-define-type GLclampf float)
(c-define-type GLdouble double)
(c-define-type GLdouble* (pointer GLdouble))
(c-define-type GLclampd double)

(c-build-sizeof GLbyte)
(c-build-sizeof GLshort)
(c-build-sizeof GLint)
(c-build-sizeof GLbyte)
(c-build-sizeof GLubyte)
(c-build-sizeof GLushort)
(c-build-sizeof GLuint)
(c-build-sizeof GLsizei)
(c-build-sizeof GLfloat)
(c-build-sizeof GLdouble)

;;! GLint
(define make-GLint*
  (c-lambda (size-t) GLint*
    "___result_voidstar = ___EXT(___alloc_rc)(___arg1*sizeof(GLint));"))

(define *->GLint
  (c-lambda (GLint*) GLint
            "___result = *___arg1;"))

;;! GLuint
(define GLuint*-ref
  (c-lambda (GLuint* size-t) GLuint
            "___result = ((GLuint*)___arg1)[___arg2];"))

(define *->GLuint
  (c-lambda (GLuint*) GLuint
            "___result = *___arg1;"))

(define make-GLuint*
  (c-lambda (size-t) GLuint*
    "___result_voidstar = ___EXT(___alloc_rc)(___arg1*sizeof(GLuint));"))

;;! GLushort array
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

;;! GLfloat
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

;; Defined in terms of vector-based matrices. No checks are performed
(define (matrix->GLfloat* mat)
  (let* ((rows (vector-length mat))
         (columns (vector-length (vector-ref mat 0)))
         (max-i (fx- rows 1))
         (max-j (fx- columns 1))
         (buf-size (fx* rows columns))
         (buf (make-GLfloat* buf-size)))
    (let loop ((i 0)
               (i-offset 0)
               (j 0))
      (GLfloat*-set! buf
                     (fx+ i-offset j)
                     (vector-ref (vector-ref mat i) j))
      (if (< j max-j)
          (loop i
                i-offset
                (fx+ 1 j))
          (if (< i max-i)
              (loop (fx+ 1 i)
                    (fx+ i-offset columns)
                    0)
              buf)))))

(define print-GLfloats*
  (c-lambda (GLfloat* int) void "
int i;
for(i=0; i<___arg2; i++)
{
  printf(\"GLfloat[%i]: %f\\n\", i, ___arg1[i]);
}
"))


(c-constants
 ;; Boolean values
 GL_FALSE
 GL_TRUE	

 ;; Data types
 GL_BYTE			
 GL_UNSIGNED_BYTE	
 GL_SHORT		
 GL_UNSIGNED_SHORT	
 GL_INT			
 GL_UNSIGNED_INT		
 GL_FLOAT		
 GL_2_BYTES		
 GL_3_BYTES		
 GL_4_BYTES		
 GL_DOUBLE		

 ;; Primitives
 GL_POINTS		
 GL_LINES		
 GL_LINE_LOOP		
 GL_LINE_STRIP		
 GL_TRIANGLES		
 GL_TRIANGLE_STRIP	
 GL_TRIANGLE_FAN		
 GL_QUADS		
 GL_QUAD_STRIP		
 GL_POLYGON		

 ;; Vertex Arrays
 GL_VERTEX_ARRAY			
 GL_NORMAL_ARRAY			
 GL_COLOR_ARRAY			
 GL_INDEX_ARRAY			
 GL_TEXTURE_COORD_ARRAY		
 GL_EDGE_FLAG_ARRAY		
 GL_VERTEX_ARRAY_SIZE		
 GL_VERTEX_ARRAY_TYPE		
 GL_VERTEX_ARRAY_STRIDE		
 GL_NORMAL_ARRAY_TYPE		
 GL_NORMAL_ARRAY_STRIDE		
 GL_COLOR_ARRAY_SIZE		
 GL_COLOR_ARRAY_TYPE		
 GL_COLOR_ARRAY_STRIDE		
 GL_INDEX_ARRAY_TYPE		
 GL_INDEX_ARRAY_STRIDE		
 GL_TEXTURE_COORD_ARRAY_SIZE	
 GL_TEXTURE_COORD_ARRAY_TYPE	
 GL_TEXTURE_COORD_ARRAY_STRIDE	
 GL_EDGE_FLAG_ARRAY_STRIDE	
 GL_VERTEX_ARRAY_POINTER		
 GL_NORMAL_ARRAY_POINTER		
 GL_COLOR_ARRAY_POINTER		
 GL_INDEX_ARRAY_POINTER		
 GL_TEXTURE_COORD_ARRAY_POINTER	
 GL_EDGE_FLAG_ARRAY_POINTER	
 GL_V2F				
 GL_V3F				
 GL_C4UB_V2F			
 GL_C4UB_V3F			
 GL_C3F_V3F			
 GL_N3F_V3F			
 GL_C4F_N3F_V3F			
 GL_T2F_V3F			
 GL_T4F_V4F			
 GL_T2F_C4UB_V3F			
 GL_T2F_C3F_V3F			
 GL_T2F_N3F_V3F			
 GL_T2F_C4F_N3F_V3F		
 GL_T4F_C4F_N3F_V4F		

 ;; Matrix mode
 GL_MATRIX_MODE	
 GL_MODELVIEW	
 GL_PROJECTION	
 GL_TEXTURE	

 ;; Points
 GL_POINT_SMOOTH			
 GL_POINT_SIZE			
 GL_POINT_SIZE_GRANULARITY 	
 GL_POINT_SIZE_RANGE		

 ;; Line
 GL_LINE_SMOOTH			
 GL_LINE_STIPPLE			
 GL_LINE_STIPPLE_PATTERN		
 GL_LINE_STIPPLE_REPEAT		
 GL_LINE_WIDTH			
 GL_LINE_WIDTH_GRANULARITY	
 GL_LINE_WIDTH_RANGE		

 ;; Polygons
 GL_POINT		
 GL_LINE			
 GL_FILL			
 GL_CW			
 GL_CCW			
 GL_FRONT		
 GL_BACK			
 GL_POLYGON_MODE		
 GL_POLYGON_SMOOTH	
 GL_POLYGON_STIPPLE	
 GL_EDGE_FLAG		
 GL_CULL_FACE		
 GL_CULL_FACE_MODE	
 GL_FRONT_FACE		
 GL_POLYGON_OFFSET_FACTOR
 GL_POLYGON_OFFSET_UNITS	
 GL_POLYGON_OFFSET_POINT	
 GL_POLYGON_OFFSET_LINE	
 GL_POLYGON_OFFSET_FILL	

 ;; Display lists
 GL_COMPILE		
 GL_COMPILE_AND_EXECUTE	
 GL_LIST_BASE		
 GL_LIST_INDEX		
 GL_LIST_MODE		

 ;; Depth buffer
 GL_NEVER		
 GL_LESS			
 GL_EQUAL		
 GL_LEQUAL		
 GL_GREATER		
 GL_NOTEQUAL		
 GL_GEQUAL		
 GL_ALWAYS		
 GL_DEPTH_TEST		
 GL_DEPTH_BITS		
 GL_DEPTH_CLEAR_VALUE	
 GL_DEPTH_FUNC		
 GL_DEPTH_RANGE		
 GL_DEPTH_WRITEMASK	
 GL_DEPTH_COMPONENT	

 ;; Lighting
 GL_LIGHTING			
 GL_LIGHT0			
 GL_LIGHT1			
 GL_LIGHT2			
 GL_LIGHT3			
 GL_LIGHT4			
 GL_LIGHT5			
 GL_LIGHT6			
 GL_LIGHT7			
 GL_SPOT_EXPONENT		
 GL_SPOT_CUTOFF			
 GL_CONSTANT_ATTENUATION		
 GL_LINEAR_ATTENUATION		
 GL_QUADRATIC_ATTENUATION	
 GL_AMBIENT			
 GL_DIFFUSE			
 GL_SPECULAR			
 GL_SHININESS			
 GL_EMISSION			
 GL_POSITION			
 GL_SPOT_DIRECTION		
 GL_AMBIENT_AND_DIFFUSE		
 GL_COLOR_INDEXES		
 GL_LIGHT_MODEL_TWO_SIDE		
 GL_LIGHT_MODEL_LOCAL_VIEWER	
 GL_LIGHT_MODEL_AMBIENT		
 GL_FRONT_AND_BACK		
 GL_SHADE_MODEL			
 GL_FLAT				
 GL_SMOOTH			
 GL_COLOR_MATERIAL		
 GL_COLOR_MATERIAL_FACE		
 GL_COLOR_MATERIAL_PARAMETER	
 GL_NORMALIZE			

 ;; User clipping planes
 GL_CLIP_PLANE0	
 GL_CLIP_PLANE1	
 GL_CLIP_PLANE2	
 GL_CLIP_PLANE3	
 GL_CLIP_PLANE4	
 GL_CLIP_PLANE5	

 ;; Accumulation buffer
 GL_ACCUM_RED_BITS	
 GL_ACCUM_GREEN_BITS	
 GL_ACCUM_BLUE_BITS	
 GL_ACCUM_ALPHA_BITS	
 GL_ACCUM_CLEAR_VALUE	
 GL_ACCUM		
 GL_ADD			
 GL_LOAD			
 GL_MULT			
 GL_RETURN		

 ;; Alpha testing
 GL_ALPHA_TEST	  
 GL_ALPHA_TEST_REF 
 GL_ALPHA_TEST_FUNC

 ;; Blending
 GL_BLEND		
 GL_BLEND_SRC		
 GL_BLEND_DST		
 GL_ZERO			
 GL_ONE			
 GL_SRC_COLOR		
 GL_ONE_MINUS_SRC_COLOR	
 GL_SRC_ALPHA		
 GL_ONE_MINUS_SRC_ALPHA	
 GL_DST_ALPHA		
 GL_ONE_MINUS_DST_ALPHA	
 GL_DST_COLOR		
 GL_ONE_MINUS_DST_COLOR	
 GL_SRC_ALPHA_SATURATE	

 ;; Render mode
 GL_FEEDBACK	
 GL_RENDER	
 GL_SELECT	

 ;; Feedback
 GL_2D				
 GL_3D				
 GL_3D_COLOR			
 GL_3D_COLOR_TEXTURE		
 GL_4D_COLOR_TEXTURE		
 GL_POINT_TOKEN			
 GL_LINE_TOKEN			
 GL_LINE_RESET_TOKEN		
 GL_POLYGON_TOKEN		
 GL_BITMAP_TOKEN			
 GL_DRAW_PIXEL_TOKEN		
 GL_COPY_PIXEL_TOKEN		
 GL_PASS_THROUGH_TOKEN		
 GL_FEEDBACK_BUFFER_POINTER	
 GL_FEEDBACK_BUFFER_SIZE		
 GL_FEEDBACK_BUFFER_TYPE		

 ;; Selection
 GL_SELECTION_BUFFER_POINTER	
 GL_SELECTION_BUFFER_SIZE	

 ;; Fog
 GL_FOG		
 GL_FOG_MODE	
 GL_FOG_DENSITY	
 GL_FOG_COLOR	
 GL_FOG_INDEX	
 GL_FOG_START	
 GL_FOG_END	
 GL_LINEAR	
 GL_EXP		
 GL_EXP2		

 ;; Logic ops
 GL_LOGIC_OP		
 GL_INDEX_LOGIC_OP	
 GL_COLOR_LOGIC_OP	
 GL_LOGIC_OP_MODE	
 GL_CLEAR		
 GL_SET			
 GL_COPY			
 GL_COPY_INVERTED	
 GL_NOOP			
 GL_INVERT		
 GL_AND			
 GL_NAND			
 GL_OR			
 GL_NOR			
 GL_XOR			
 GL_EQUIV		
 GL_AND_REVERSE		
 GL_AND_INVERTED		
 GL_OR_REVERSE		
 GL_OR_INVERTED		

 ;; Stencil
 GL_STENCIL_BITS			
 GL_STENCIL_TEST			
 GL_STENCIL_CLEAR_VALUE		
 GL_STENCIL_FUNC			
 GL_STENCIL_VALUE_MASK		
 GL_STENCIL_FAIL			
 GL_STENCIL_PASS_DEPTH_FAIL	
 GL_STENCIL_PASS_DEPTH_PASS	
 GL_STENCIL_REF			
 GL_STENCIL_WRITEMASK		
 GL_STENCIL_INDEX		
 GL_KEEP				
 GL_REPLACE			
 GL_INCR				
 GL_DECR				

 ;; Buffers, Pixel drawing/reading
 GL_NONE	
 GL_LEFT	
 GL_RIGHT
 GL_FRONT_LEFT		
 GL_FRONT_RIGHT		
 GL_BACK_LEFT		
 GL_BACK_RIGHT		
 GL_AUX0			
 GL_AUX1			
 GL_AUX2			
 GL_AUX3			
 GL_COLOR_INDEX		
 GL_RED			
 GL_GREEN		
 GL_BLUE			
 GL_ALPHA		
 GL_LUMINANCE		
 GL_LUMINANCE_ALPHA	
 GL_ALPHA_BITS		
 GL_RED_BITS		
 GL_GREEN_BITS		
 GL_BLUE_BITS		
 GL_INDEX_BITS		
 GL_SUBPIXEL_BITS	
 GL_AUX_BUFFERS		
 GL_READ_BUFFER		
 GL_DRAW_BUFFER		
 GL_DOUBLEBUFFER		
 GL_STEREO		
 GL_BITMAP		
 GL_COLOR		
 GL_DEPTH		
 GL_STENCIL		
 GL_DITHER		
 GL_RGB			
 GL_RGBA			

 ;; Implementation limits
 GL_MAX_LIST_NESTING
 GL_MAX_EVAL_ORDER		
 GL_MAX_LIGHTS
 GL_MAX_CLIP_PLANES
 GL_MAX_TEXTURE_SIZE		
 GL_MAX_PIXEL_MAP_TABLE		
 GL_MAX_ATTRIB_STACK_DEPTH	
 GL_MAX_MODELVIEW_STACK_DEPTH	
 GL_MAX_NAME_STACK_DEPTH		
 GL_MAX_PROJECTION_STACK_DEPTH	
 GL_MAX_TEXTURE_STACK_DEPTH	
 GL_MAX_VIEWPORT_DIMS		
 GL_MAX_CLIENT_ATTRIB_STACK_DEPTH

 ;; Gets
 GL_ATTRIB_STACK_DEPTH		
 GL_CLIENT_ATTRIB_STACK_DEPTH	
 GL_COLOR_CLEAR_VALUE		
 GL_COLOR_WRITEMASK		
 GL_CURRENT_INDEX		
 GL_CURRENT_COLOR		
 GL_CURRENT_NORMAL		
 GL_CURRENT_RASTER_COLOR		
 GL_CURRENT_RASTER_DISTANCE	
 GL_CURRENT_RASTER_INDEX		
 GL_CURRENT_RASTER_POSITION	
 GL_CURRENT_RASTER_TEXTURE_COORDS
 GL_CURRENT_RASTER_POSITION_VALID
 GL_CURRENT_TEXTURE_COORDS	
 GL_INDEX_CLEAR_VALUE		
 GL_INDEX_MODE			
 GL_INDEX_WRITEMASK		
 GL_MODELVIEW_MATRIX		
 GL_MODELVIEW_STACK_DEPTH	
 GL_NAME_STACK_DEPTH		
 GL_PROJECTION_MATRIX		
 GL_PROJECTION_STACK_DEPTH	
 GL_RENDER_MODE			
 GL_RGBA_MODE			
 GL_TEXTURE_MATRIX		
 GL_TEXTURE_STACK_DEPTH		
 GL_VIEWPORT			

 ;; Evaluators
 GL_AUTO_NORMAL		
 GL_MAP1_COLOR_4		
 GL_MAP1_INDEX		
 GL_MAP1_NORMAL		
 GL_MAP1_TEXTURE_COORD_1	
 GL_MAP1_TEXTURE_COORD_2	
 GL_MAP1_TEXTURE_COORD_3	
 GL_MAP1_TEXTURE_COORD_4	
 GL_MAP1_VERTEX_3	
 GL_MAP1_VERTEX_4	
 GL_MAP2_COLOR_4		
 GL_MAP2_INDEX		
 GL_MAP2_NORMAL		
 GL_MAP2_TEXTURE_COORD_1	
 GL_MAP2_TEXTURE_COORD_2	
 GL_MAP2_TEXTURE_COORD_3	
 GL_MAP2_TEXTURE_COORD_4	
 GL_MAP2_VERTEX_3	
 GL_MAP2_VERTEX_4	
 GL_MAP1_GRID_DOMAIN	
 GL_MAP1_GRID_SEGMENTS	
 GL_MAP2_GRID_DOMAIN	
 GL_MAP2_GRID_SEGMENTS	
 GL_COEFF		
 GL_ORDER		
 GL_DOMAIN		

 ;; Hints
 GL_PERSPECTIVE_CORRECTION_HINT	
 GL_POINT_SMOOTH_HINT		
 GL_LINE_SMOOTH_HINT		
 GL_POLYGON_SMOOTH_HINT		
 GL_FOG_HINT			
 GL_DONT_CARE			
 GL_FASTEST			
 GL_NICEST			

 ;; Scissor box
 GL_SCISSOR_BOX	
 GL_SCISSOR_TEST	

 ;; Pixel mode/transfer
 GL_MAP_COLOR		
 GL_MAP_STENCIL		
 GL_INDEX_SHIFT		
 GL_INDEX_OFFSET		
 GL_RED_SCALE		
 GL_RED_BIAS		
 GL_GREEN_SCALE		
 GL_GREEN_BIAS		
 GL_BLUE_SCALE		
 GL_BLUE_BIAS		
 GL_ALPHA_SCALE		
 GL_ALPHA_BIAS		
 GL_DEPTH_SCALE		
 GL_DEPTH_BIAS		
 GL_PIXEL_MAP_S_TO_S_SIZE
 GL_PIXEL_MAP_I_TO_I_SIZE
 GL_PIXEL_MAP_I_TO_R_SIZE
 GL_PIXEL_MAP_I_TO_G_SIZE
 GL_PIXEL_MAP_I_TO_B_SIZE
 GL_PIXEL_MAP_I_TO_A_SIZE
 GL_PIXEL_MAP_R_TO_R_SIZE
 GL_PIXEL_MAP_G_TO_G_SIZE
 GL_PIXEL_MAP_B_TO_B_SIZE
 GL_PIXEL_MAP_A_TO_A_SIZE
 GL_PIXEL_MAP_S_TO_S	
 GL_PIXEL_MAP_I_TO_I	
 GL_PIXEL_MAP_I_TO_R	
 GL_PIXEL_MAP_I_TO_G	
 GL_PIXEL_MAP_I_TO_B	
 GL_PIXEL_MAP_I_TO_A	
 GL_PIXEL_MAP_R_TO_R	
 GL_PIXEL_MAP_G_TO_G	
 GL_PIXEL_MAP_B_TO_B	
 GL_PIXEL_MAP_A_TO_A	
 GL_PACK_ALIGNMENT	
 GL_PACK_LSB_FIRST	
 GL_PACK_ROW_LENGTH	
 GL_PACK_SKIP_PIXELS	
 GL_PACK_SKIP_ROWS	
 GL_PACK_SWAP_BYTES	
 GL_UNPACK_ALIGNMENT	
 GL_UNPACK_LSB_FIRST	
 GL_UNPACK_ROW_LENGTH	
 GL_UNPACK_SKIP_PIXELS	
 GL_UNPACK_SKIP_ROWS	
 GL_UNPACK_SWAP_BYTES	
 GL_ZOOM_X		
 GL_ZOOM_Y		

 ;; Texture mapping
 GL_TEXTURE_ENV			
 GL_TEXTURE_ENV_MODE		
 GL_TEXTURE_1D			
 GL_TEXTURE_2D			
 GL_TEXTURE_WRAP_S		
 GL_TEXTURE_WRAP_T		
 GL_TEXTURE_MAG_FILTER		
 GL_TEXTURE_MIN_FILTER		
 GL_TEXTURE_ENV_COLOR		
 GL_TEXTURE_GEN_S		
 GL_TEXTURE_GEN_T		
 GL_TEXTURE_GEN_R		
 GL_TEXTURE_GEN_Q		
 GL_TEXTURE_GEN_MODE		
 GL_TEXTURE_BORDER_COLOR		
 GL_TEXTURE_WIDTH		
 GL_TEXTURE_HEIGHT		
 GL_TEXTURE_BORDER		
 GL_TEXTURE_COMPONENTS		
 GL_TEXTURE_RED_SIZE		
 GL_TEXTURE_GREEN_SIZE		
 GL_TEXTURE_BLUE_SIZE		
 GL_TEXTURE_ALPHA_SIZE		
 GL_TEXTURE_LUMINANCE_SIZE	
 GL_TEXTURE_INTENSITY_SIZE	
 GL_NEAREST_MIPMAP_NEAREST	
 GL_NEAREST_MIPMAP_LINEAR	
 GL_LINEAR_MIPMAP_NEAREST	
 GL_LINEAR_MIPMAP_LINEAR		
 GL_OBJECT_LINEAR		
 GL_OBJECT_PLANE			
 GL_EYE_LINEAR			
 GL_EYE_PLANE			
 GL_SPHERE_MAP			
 GL_DECAL			
 GL_MODULATE			
 GL_NEAREST			
 GL_REPEAT			
 GL_CLAMP			
 GL_S				
 GL_T				
 GL_R				
 GL_Q				

 ;; Utility
 GL_VENDOR	
 GL_RENDERER	
 GL_VERSION	
 GL_EXTENSIONS	

 ;; Errors
 GL_NO_ERROR 		
 GL_INVALID_ENUM		
 GL_INVALID_VALUE	
 GL_INVALID_OPERATION	
 GL_STACK_OVERFLOW	
 GL_STACK_UNDERFLOW	
 GL_OUT_OF_MEMORY	

 ;; glPush/glPopAttrib bits
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

 ;; OpenGL 1.1
 GL_PROXY_TEXTURE_1D	  
 GL_PROXY_TEXTURE_2D	  
 GL_TEXTURE_PRIORITY	  
 GL_TEXTURE_RESIDENT	  
 GL_TEXTURE_BINDING_1D	  
 GL_TEXTURE_BINDING_2D	  
 GL_TEXTURE_INTERNAL_FORMAT
 GL_ALPHA4		  
 GL_ALPHA8		  
 GL_ALPHA12		  
 GL_ALPHA16		  
 GL_LUMINANCE4		  
 GL_LUMINANCE8		  
 GL_LUMINANCE12		  
 GL_LUMINANCE16		  
 GL_LUMINANCE4_ALPHA4	  
 GL_LUMINANCE6_ALPHA2	  
 GL_LUMINANCE8_ALPHA8	  
 GL_LUMINANCE12_ALPHA4	  
 GL_LUMINANCE12_ALPHA12	  
 GL_LUMINANCE16_ALPHA16	  
 GL_INTENSITY		  
 GL_INTENSITY4		  
 GL_INTENSITY8		  
 GL_INTENSITY12		  
 GL_INTENSITY16		  
 GL_R3_G3_B2		  
 GL_RGB4			  
 GL_RGB5			  
 GL_RGB8			  
 GL_RGB10		  
 GL_RGB12		  
 GL_RGB16		  
 GL_RGBA2		  
 GL_RGBA4		  
 GL_RGB5_A1		  
 GL_RGBA8		  
 GL_RGB10_A2		  
 GL_RGBA12		  
 GL_RGBA16		  
 GL_CLIENT_PIXEL_STORE_BIT 
 GL_CLIENT_VERTEX_ARRAY_BIT
 ;; GL_ALL_CLIENT_ATTRIB_BITS 
 ;; GL_CLIENT_ALL_ATTRIB_BITS 

 ;; OpenGL 1.2
 GL_RESCALE_NORMAL		
 GL_CLAMP_TO_EDGE		
 GL_MAX_ELEMENTS_VERTICES	
 GL_MAX_ELEMENTS_INDICES		
 GL_BGR				
 GL_BGRA				
 GL_UNSIGNED_BYTE_3_3_2		
 GL_UNSIGNED_BYTE_2_3_3_REV	
 GL_UNSIGNED_SHORT_5_6_5		
 GL_UNSIGNED_SHORT_5_6_5_REV	
 GL_UNSIGNED_SHORT_4_4_4_4	
 GL_UNSIGNED_SHORT_4_4_4_4_REV	
 GL_UNSIGNED_SHORT_5_5_5_1	
 GL_UNSIGNED_SHORT_1_5_5_5_REV	
 GL_UNSIGNED_INT_8_8_8_8		
 GL_UNSIGNED_INT_8_8_8_8_REV	
 GL_UNSIGNED_INT_10_10_10_2	
 GL_UNSIGNED_INT_2_10_10_10_REV	
 GL_LIGHT_MODEL_COLOR_CONTROL	
 GL_SINGLE_COLOR			
 GL_SEPARATE_SPECULAR_COLOR	
 GL_TEXTURE_MIN_LOD		
 GL_TEXTURE_MAX_LOD		
 GL_TEXTURE_BASE_LEVEL		
 GL_TEXTURE_MAX_LEVEL		
 GL_SMOOTH_POINT_SIZE_RANGE	
 GL_SMOOTH_POINT_SIZE_GRANULARITY
 GL_SMOOTH_LINE_WIDTH_RANGE	
 GL_SMOOTH_LINE_WIDTH_GRANULARITY
 GL_ALIASED_POINT_SIZE_RANGE	
 GL_ALIASED_LINE_WIDTH_RANGE	
 GL_PACK_SKIP_IMAGES		
 GL_PACK_IMAGE_HEIGHT		
 GL_UNPACK_SKIP_IMAGES		
 GL_UNPACK_IMAGE_HEIGHT		
 GL_TEXTURE_3D			
 GL_PROXY_TEXTURE_3D		
 GL_TEXTURE_DEPTH		
 GL_TEXTURE_WRAP_R		
 GL_MAX_3D_TEXTURE_SIZE		
 GL_TEXTURE_BINDING_3D		

 ;; GL_ARB_imaging
 GL_CONSTANT_COLOR			
 GL_ONE_MINUS_CONSTANT_COLOR		
 GL_CONSTANT_ALPHA			
 GL_ONE_MINUS_CONSTANT_ALPHA		
 GL_COLOR_TABLE				
 GL_POST_CONVOLUTION_COLOR_TABLE		
 GL_POST_COLOR_MATRIX_COLOR_TABLE	
 GL_PROXY_COLOR_TABLE			
 GL_PROXY_POST_CONVOLUTION_COLOR_TABLE	
 GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE	
 GL_COLOR_TABLE_SCALE			
 GL_COLOR_TABLE_BIAS			
 GL_COLOR_TABLE_FORMAT			
 GL_COLOR_TABLE_WIDTH			
 GL_COLOR_TABLE_RED_SIZE			
 GL_COLOR_TABLE_GREEN_SIZE		
 GL_COLOR_TABLE_BLUE_SIZE		
 GL_COLOR_TABLE_ALPHA_SIZE		
 GL_COLOR_TABLE_LUMINANCE_SIZE		
 GL_COLOR_TABLE_INTENSITY_SIZE		
 GL_CONVOLUTION_1D			
 GL_CONVOLUTION_2D			
 GL_SEPARABLE_2D				
 GL_CONVOLUTION_BORDER_MODE		
 GL_CONVOLUTION_FILTER_SCALE		
 GL_CONVOLUTION_FILTER_BIAS		
 GL_REDUCE				
 GL_CONVOLUTION_FORMAT			
 GL_CONVOLUTION_WIDTH			
 GL_CONVOLUTION_HEIGHT			
 GL_MAX_CONVOLUTION_WIDTH		
 GL_MAX_CONVOLUTION_HEIGHT		
 GL_POST_CONVOLUTION_RED_SCALE		
 GL_POST_CONVOLUTION_GREEN_SCALE		
 GL_POST_CONVOLUTION_BLUE_SCALE		
 GL_POST_CONVOLUTION_ALPHA_SCALE		
 GL_POST_CONVOLUTION_RED_BIAS		
 GL_POST_CONVOLUTION_GREEN_BIAS		
 GL_POST_CONVOLUTION_BLUE_BIAS		
 GL_POST_CONVOLUTION_ALPHA_BIAS		
 GL_CONSTANT_BORDER			
 GL_REPLICATE_BORDER			
 GL_CONVOLUTION_BORDER_COLOR		
 GL_COLOR_MATRIX				
 GL_COLOR_MATRIX_STACK_DEPTH		
 GL_MAX_COLOR_MATRIX_STACK_DEPTH		
 GL_POST_COLOR_MATRIX_RED_SCALE		
 GL_POST_COLOR_MATRIX_GREEN_SCALE	
 GL_POST_COLOR_MATRIX_BLUE_SCALE		
 GL_POST_COLOR_MATRIX_ALPHA_SCALE	
 GL_POST_COLOR_MATRIX_RED_BIAS		
 GL_POST_COLOR_MATRIX_GREEN_BIAS		
 GL_POST_COLOR_MATRIX_BLUE_BIAS		
 GL_POST_COLOR_MATRIX_ALPHA_BIAS		
 GL_HISTOGRAM				
 GL_PROXY_HISTOGRAM			
 GL_HISTOGRAM_WIDTH			
 GL_HISTOGRAM_FORMAT			
 GL_HISTOGRAM_RED_SIZE			
 GL_HISTOGRAM_GREEN_SIZE			
 GL_HISTOGRAM_BLUE_SIZE			
 GL_HISTOGRAM_ALPHA_SIZE			
 GL_HISTOGRAM_LUMINANCE_SIZE		
 GL_HISTOGRAM_SINK			
 GL_MINMAX				
 GL_MINMAX_FORMAT			
 GL_MINMAX_SINK				
 GL_TABLE_TOO_LARGE			
 GL_BLEND_EQUATION			
 GL_MIN					
 GL_MAX					
 GL_FUNC_ADD				
 GL_FUNC_SUBTRACT			
 GL_FUNC_REVERSE_SUBTRACT		
 GL_BLEND_COLOR				

 ;; OpenGL 1.3
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
 GL_MAX_TEXTURE_UNITS	
 GL_NORMAL_MAP				
 GL_REFLECTION_MAP			
 GL_TEXTURE_CUBE_MAP			
 GL_TEXTURE_BINDING_CUBE_MAP		
 GL_TEXTURE_CUBE_MAP_POSITIVE_X		
 GL_TEXTURE_CUBE_MAP_NEGATIVE_X		
 GL_TEXTURE_CUBE_MAP_POSITIVE_Y		
 GL_TEXTURE_CUBE_MAP_NEGATIVE_Y		
 GL_TEXTURE_CUBE_MAP_POSITIVE_Z		
 GL_TEXTURE_CUBE_MAP_NEGATIVE_Z		
 GL_PROXY_TEXTURE_CUBE_MAP		
 GL_MAX_CUBE_MAP_TEXTURE_SIZE		
 GL_COMPRESSED_ALPHA			
 GL_COMPRESSED_LUMINANCE			
 GL_COMPRESSED_LUMINANCE_ALPHA		
 GL_COMPRESSED_INTENSITY			
 GL_COMPRESSED_RGB			
 GL_COMPRESSED_RGBA			
 GL_TEXTURE_COMPRESSION_HINT		
 GL_TEXTURE_COMPRESSED_IMAGE_SIZE	
 GL_TEXTURE_COMPRESSED			
 GL_NUM_COMPRESSED_TEXTURE_FORMATS	
 GL_COMPRESSED_TEXTURE_FORMATS		
 GL_MULTISAMPLE				
 GL_SAMPLE_ALPHA_TO_COVERAGE		
 GL_SAMPLE_ALPHA_TO_ONE			
 GL_SAMPLE_COVERAGE			
 GL_SAMPLE_BUFFERS			
 GL_SAMPLES				
 GL_SAMPLE_COVERAGE_VALUE		
 GL_SAMPLE_COVERAGE_INVERT		
 GL_MULTISAMPLE_BIT			
 GL_TRANSPOSE_MODELVIEW_MATRIX		
 GL_TRANSPOSE_PROJECTION_MATRIX		
 GL_TRANSPOSE_TEXTURE_MATRIX		
 GL_TRANSPOSE_COLOR_MATRIX		
 GL_COMBINE				
 GL_COMBINE_RGB				
 GL_COMBINE_ALPHA			
 GL_SOURCE0_RGB				
 GL_SOURCE1_RGB				
 GL_SOURCE2_RGB				
 GL_SOURCE0_ALPHA			
 GL_SOURCE1_ALPHA			
 GL_SOURCE2_ALPHA			
 GL_OPERAND0_RGB				
 GL_OPERAND1_RGB				
 GL_OPERAND2_RGB				
 GL_OPERAND0_ALPHA			
 GL_OPERAND1_ALPHA			
 GL_OPERAND2_ALPHA			
 GL_RGB_SCALE				
 GL_ADD_SIGNED				
 GL_INTERPOLATE				
 GL_SUBTRACT				
 GL_CONSTANT				
 GL_PRIMARY_COLOR			
 GL_PREVIOUS				
 GL_DOT3_RGB				
 GL_DOT3_RGBA				
 GL_CLAMP_TO_BORDER			

 ;; GL_ARB_multitexture (ARB extension 1 and OpenGL 1.2.1)
 GL_TEXTURE0_ARB			
 GL_TEXTURE1_ARB			
 GL_TEXTURE2_ARB			
 GL_TEXTURE3_ARB			
 GL_TEXTURE4_ARB			
 GL_TEXTURE5_ARB			
 GL_TEXTURE6_ARB			
 GL_TEXTURE7_ARB			
 GL_TEXTURE8_ARB			
 GL_TEXTURE9_ARB			
 GL_TEXTURE10_ARB		
 GL_TEXTURE11_ARB		
 GL_TEXTURE12_ARB		
 GL_TEXTURE13_ARB		
 GL_TEXTURE14_ARB		
 GL_TEXTURE15_ARB		
 GL_TEXTURE16_ARB		
 GL_TEXTURE17_ARB		
 GL_TEXTURE18_ARB		
 GL_TEXTURE19_ARB		
 GL_TEXTURE20_ARB		
 GL_TEXTURE21_ARB		
 GL_TEXTURE22_ARB		
 GL_TEXTURE23_ARB		
 GL_TEXTURE24_ARB		
 GL_TEXTURE25_ARB		
 GL_TEXTURE26_ARB		
 GL_TEXTURE27_ARB		
 GL_TEXTURE28_ARB		
 GL_TEXTURE29_ARB		
 GL_TEXTURE30_ARB		
 GL_TEXTURE31_ARB		
 GL_ACTIVE_TEXTURE_ARB		
 GL_CLIENT_ACTIVE_TEXTURE_ARB	
 GL_MAX_TEXTURE_UNITS_ARB)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLEW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(c-define-type GLchar char)
(c-define-type GLchar* (pointer GLchar))
(c-define-type GLchar** nonnull-char-string-list)

;; ;; Defined as __int64 in glew
(c-define-type GLintptr unsigned-int)
(c-define-type GLsizeiptr unsigned-int)
(c-define-type GLintptrARB unsigned-int)
(c-define-type GLsizeiptrARB unsigned-int)

;;! GLchar
(define make-GLchar*
  (c-lambda (size-t) GLchar*
    "___result_voidstar = ___EXT(___alloc_rc)(___arg1*sizeof(GLchar));"))

(define *->GLchar
  (c-lambda (GLchar*) GLchar
            "___result = *___arg1;"))

;; TODO!
(c-constants
 GL_ARRAY_BUFFER
 GL_STATIC_DRAW
 GL_VERTEX_SHADER
 GL_FRAGMENT_SHADER
 GL_COMPILE_STATUS
 GL_LINK_STATUS
 GL_INFO_LOG_LENGTH
 GL_TEXTURE0)

(define glewInit
  (c-lambda () GLenum "glewInit"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define glActiveTexture
  (c-lambda (GLenum) void "glActiveTexture"))

(define glAttachShader
  (c-lambda (GLuint GLuint) void "glAttachShader"))

(define glBegin
  (c-lambda (GLenum) void "glBegin"))

(define glBlendFunc
  (c-lambda (GLenum GLenum) void "glBlendFunc"))

(define glBindTexture
  (c-lambda (GLenum GLuint) void "glBindTexture"))

(define glBindBuffer
  (c-lambda (GLenum GLuint) void "glBindBuffer"))

(define glBindSampler
  (c-lambda (GLuint GLuint) void "glBindSampler"))

(define glBindVertexArray
  (c-lambda (GLuint) void "glBindVertexArray"))

(define glBufferData
  (c-lambda (GLenum GLsizeiptr GLvoid* GLenum) void "glBufferData"))

(define glClear
  (c-lambda (GLbitfield) void "glClear"))

(define glClearColor
  (c-lambda (GLclampf GLclampf GLclampf GLclampf) void "glClearColor"))

(define glColor3f
  (c-lambda (GLfloat GLfloat GLfloat) void "glColor3f"))

(define glCompileShader
  (c-lambda (GLuint) void "glCompileShader"))

(define glCreateProgram
  (c-lambda () GLuint "glCreateProgram"))

(define glCreateShader
  (c-lambda (GLenum) GLuint "glCreateShader"))

(define glDeleteShader
  (c-lambda (GLuint) void "glDeleteShader"))

(define glDeleteTextures
  (c-lambda (GLsizei (pointer GLuint)) void "glDeleteTextures"))

(define glDetachShader
  (c-lambda (GLuint GLuint) void "glDetachShader"))

(define glDisable
  (c-lambda (GLenum) void "glDisable"))

(define glDisableClientState
  (c-lambda (GLenum) void "glDisableClientState"))

(define glDisableVertexAttribArray
  (c-lambda (GLenum) void "glDisableVertexAttribArray"))

(define glDrawArrays
  (c-lambda (GLenum GLint GLsizei) void "glDrawArrays"))

(define glDrawElements
  (c-lambda (GLenum GLsizei GLenum (pointer GLvoid))
            void
            "glDrawElements"))

(define glEnable
  (c-lambda (GLenum) void "glEnable"))

(define glEnableClientState
  (c-lambda (GLenum) void "glEnableClientState"))

(define glEnableVertexAttribArray
  (c-lambda (GLuint) void "glEnableVertexAttribArray"))

(define glEnd
  (c-lambda () void "glEnd"))

(define glGenBuffers
  (c-lambda (GLsizei (pointer GLuint)) void "glGenBuffers"))

(define glGenTextures
  (c-lambda (GLsizei (pointer GLuint)) void "glGenTextures"))

(define glGenVertexArrays
  (c-lambda (GLsizei (pointer GLuint)) void "glGenVertexArrays"))

(define glGetProgramiv
  (c-lambda (GLuint GLenum GLint*) void "glGetProgramiv"))

(define glGenSamplers
  (c-lambda (GLsizei GLuint*) void "glGenSamplers"))

(define glGetShaderiv
  (c-lambda (GLuint GLenum GLint*) void "glGetShaderiv"))

(define glGetShaderInfoLog
  (c-lambda (GLuint GLsizei GLsizei* GLchar*) void "glGetShaderInfoLog"))

(define glGetString
  (c-lambda (GLenum) GLubyte* "glGetString"))

(define glGetUniformLocation
  (c-lambda (GLuint char-string) GLint "glGetUniformLocation"))

(define glLinkProgram
  (c-lambda (GLuint) void "glLinkProgram"))

(define glLoadIdentity
  (c-lambda () void "glLoadIdentity"))

(define glMatrixMode
  (c-lambda (GLenum) void "glMatrixMode"))

(define glOrtho
  (c-lambda (GLdouble GLdouble GLdouble GLdouble GLdouble GLdouble) void
            "glOrtho"))

(define glPopMatrix
  (c-lambda () void "glPopMatrix"))

(define glPushMatrix
  (c-lambda () void "glPushMatrix"))

(define glSamplerParameterf
  (c-lambda (GLuint GLenum GLfloat) void "glSamplerParameterf"))

(define glSamplerParameteri
  (c-lambda (GLuint GLenum GLint) void "glSamplerParameteri"))

(define glScissor
  (c-lambda (GLint GLint GLsizei GLsizei) void "glScissor"))

(define glShaderSource
  (c-lambda (GLuint GLsizei GLchar** GLint*) void "glShaderSource"))

(define glTexParameteri
  (c-lambda (GLenum GLenum GLint) void "glTexParameteri"))

(define glTexParameterf
  (c-lambda (GLenum GLenum GLfloat) void "glTexParameterf"))

(define glTexImage2D
  (c-lambda (GLenum GLint GLint GLsizei GLsizei GLint GLenum GLenum (pointer GLvoid))
            void
            "glTexImage2D"))

;; OpenGL 2
(define glTexCoordPointer
  (c-lambda (GLint GLenum GLsizei GLvoid*) void "glTexCoordPointer"))

(define glTexSubImage2D
  (c-lambda (GLenum GLint GLint GLint GLsizei GLsizei GLenum GLenum (pointer GLvoid #f)) void "glTexSubImage2D"))

(define glUseProgram
  (c-lambda (GLuint) void "glUseProgram"))

(define glUniform1i
  (c-lambda (GLint GLint) void "glUniform1i"))

(define glUniformMatrix4fv
  (c-lambda (GLint GLsizei GLboolean GLfloat*) void "glUniformMatrix4fv"))

(define glVertex3f
  (c-lambda (GLfloat GLfloat GLfloat) void "glVertex3f"))

;; OpenGL 2
(define glVertexPointer
  (c-lambda (GLint GLenum GLsizei GLvoid*) void "glVertexPointer"))

(define glVertexAttribPointer
  (c-lambda (GLuint GLint GLenum GLboolean GLsizei GLvoid*) void "glVertexAttribPointer"))

(define glViewport
  (c-lambda (GLint GLint GLsizei GLsizei) void "glViewport"))
