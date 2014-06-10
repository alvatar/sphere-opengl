;; Incomplete

;; for GL 3.x+
;; /* If using gl3.h */
;; /* Ensure we are using opengl's core profile only */
;; #define GL3_PROTOTYPES 1
;; #include <OpenGL/gl3.h>

(c-declare "#include \"glew.h\"")


(c-define-type GLbitfield unsigned-int)
(c-define-type GLvoid void)
(c-define-type GLvoid* (pointer void #f))
(c-define-type GLvoid** (pointer GLvoid* #f))
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


;;! GLenum
(c-define-type GLenum unsigned-int)
(c-define-type* GLenum)
(c-define-sizeof GLenum)
(c-define-array GLenum scheme-vector: u64)

;;! GLboolean
(c-define-type GLboolean bool)
(c-define-type* GLboolean)
(c-define-sizeof GLboolean)
(c-define-array GLboolean scheme-vector: u8)

;;! GLchar
(c-define-type GLchar char)
(c-define-type GLchar** nonnull-char-string-list)
(c-define-type* GLchar)
(c-define-sizeof GLchar)
(c-define-array GLchar scheme-vector: s8)

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

;;! GLdouble
(c-define-type* GLdouble)
(c-define-sizeof GLdouble)
(c-define-array GLdouble scheme-vector: f64)

;; Defined in terms of vector-based matrices. No checks are performed
(define (matrix->GLfloat* mat)
  (let* ((rows (vector-length mat))
         (columns (vector-length (vector-ref mat 0)))
         (max-i (fx- rows 1))
         (max-j (fx- columns 1))
         (buf-size (fx* rows columns))
         (buf (alloc-GLfloat* buf-size)))
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

;; TODO!: Only for debug
(define print-GLfloats*
  (c-lambda (GLfloat* int) void "
int i;
for(i=0; i<___arg2; i++)
{
  printf(\"GLfloat[%i]: %f\\n\", i, ___arg1[i]);
}
"))


(c-define-constants
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

;; ;; Defined as __int64 in glew
(c-define-type GLintptr unsigned-long-long)
(c-define-type GLsizeiptr unsigned-long-long)
(c-define-type GLintptrARB unsigned-long-long)
(c-define-type GLsizeiptrARB unsigned-long-long)

;; TODO!
(c-define-constants
 GL_FRAGMENT_SHADER
 GL_VERTEX_SHADER
 GL_MAX_VERTEX_ATTRIBS
 GL_MAX_VERTEX_UNIFORM_VECTORS
 GL_MAX_VARYING_VECTORS
 GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS
 GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS
 GL_MAX_TEXTURE_IMAGE_UNITS
 GL_MAX_FRAGMENT_UNIFORM_VECTORS
 GL_SHADER_TYPE
 GL_DELETE_STATUS
 GL_LINK_STATUS
 GL_VALIDATE_STATUS
 GL_ATTACHED_SHADERS
 GL_ACTIVE_UNIFORMS
 GL_ACTIVE_UNIFORM_MAX_LENGTH
 GL_ACTIVE_ATTRIBUTES
 GL_ACTIVE_ATTRIBUTE_MAX_LENGTH
 GL_SHADING_LANGUAGE_VERSION
 GL_CURRENT_PROGRAM

 GL_ARRAY_BUFFER
 GL_STATIC_DRAW
 GL_DYNAMIC_DRAW
 GL_COMPILE_STATUS
 GL_LINK_STATUS
 GL_INFO_LOG_LENGTH
 GL_TEXTURE0)

(define glewInit
  (c-lambda () GLenum "glewInit"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define glActiveTexture (c-lambda (GLenum) void "glActiveTexture"))
(define glAttachShader (c-lambda (GLuint GLuint) void "glAttachShader"))
(define glBindAttribLocation (c-lambda (GLuint GLuint char-string) void "glBindAttribLocation"))
(define glBindBuffer (c-lambda (GLenum GLuint) void "glBindBuffer"))
(define glBindFramebuffer (c-lambda (GLenum GLuint) void "glBindFramebuffer"))
(define glBindRenderbuffer (c-lambda (GLenum GLuint) void "glBindRenderbuffer"))
(define glBindTexture (c-lambda (GLenum GLuint) void "glBindTexture"))
(define glBlendColor (c-lambda (GLclampf GLclampf GLclampf GLclampf) void "glBlendColor"))
(define glBlendEquation (c-lambda (GLenum) void "glBlendEquation"))
(define glBlendEquationSeparate (c-lambda (GLenum GLenum) void "glBlendEquationSeparate"))
(define glBlendFunc (c-lambda (GLenum GLenum) void "glBlendFunc"))
(define glBlendFuncSeparate (c-lambda (GLenum GLenum GLenum GLenum) void "glBlendFuncSeparate"))
(define glBufferData (c-lambda (GLenum GLsizeiptr GLvoid* GLenum) void "glBufferData"))
(define glBufferSubData (c-lambda (GLenum GLintptr GLsizeiptr GLvoid*) void "glBufferSubData"))
(define glCheckFramebufferStatus (c-lambda (GLenum) GLenum "glCheckFramebufferStatus"))
(define glClear (c-lambda (GLbitfield) void "glClear"))
(define glClearColor (c-lambda (GLclampf GLclampf GLclampf GLclampf) void "glClearColor"))
(define glClearDepthf (c-lambda (GLclampf) void "glClearDepthf"))
(define glClearStencil (c-lambda (GLint) void "glClearStencil"))
(define glColorMask (c-lambda (GLboolean GLboolean GLboolean GLboolean) void "glColorMask"))
(define glCompileShader (c-lambda (GLuint) void "glCompileShader"))
(define glCompressedTexImage2D (c-lambda (GLenum GLint GLenum GLsizei GLsizei GLint GLsizei GLvoid*) void "glCompressedTexImage2D"))
(define glCompressedTexSubImage2D (c-lambda (GLenum GLint GLint GLint GLsizei GLsizei GLenum GLsizei GLvoid*) void "glCompressedTexSubImage2D"))
(define glCopyTexImage2D (c-lambda (GLenum GLint GLenum GLint GLint GLsizei GLsizei GLint) void "glCopyTexImage2D"))
(define glCopyTexSubImage2D (c-lambda (GLenum GLint GLint GLint GLint GLint GLsizei GLsizei) void "glCopyTexSubImage2D"))
(define glCreateProgram (c-lambda () GLuint "glCreateProgram"))
(define glCreateShader (c-lambda (GLenum) GLuint "glCreateShader"))
(define glCullFace (c-lambda (GLenum) void "glCullFace"))
(define glDeleteBuffers (c-lambda (GLsizei GLuint*) void "glDeleteBuffers"))
(define glDeleteFramebuffers (c-lambda (GLsizei GLuint*) void "glDeleteFramebuffers"))
(define glDeleteProgram (c-lambda (GLuint) void "glDeleteProgram"))
(define glDeleteRenderbuffers (c-lambda (GLsizei GLuint*) void "glDeleteRenderbuffers"))
(define glDeleteSamplers (c-lambda (GLsizei GLuint*) void "glDeleteSamplers"))
(define glDeleteShader (c-lambda (GLuint) void "glDeleteShader"))
(define glDeleteTextures (c-lambda (GLsizei GLuint*) void "glDeleteTextures"))
(define glDepthFunc (c-lambda (GLenum) void "glDepthFunc"))
(define glDepthMask (c-lambda (GLboolean) void "glDepthMask"))
(define glDepthRangef (c-lambda (GLclampf GLclampf) void "glDepthRangef"))
(define glDetachShader (c-lambda (GLuint GLuint) void "glDetachShader"))
(define glDisable (c-lambda (GLenum) void "glDisable"))
(define glDisableClientState (c-lambda (GLenum) void "glDisableClientState"))
(define glDisableVertexAttribArray (c-lambda (GLuint) void "glDisableVertexAttribArray"))
(define glDrawArrays (c-lambda (GLenum GLint GLsizei) void "glDrawArrays"))
(define glDrawElements (c-lambda (GLenum GLsizei GLenum GLvoid*) void "glDrawElements"))
(define glEnable (c-lambda (GLenum) void "glEnable"))
(define glEnableClientState (c-lambda (GLenum) void "glEnableClientState"))
(define glEnableVertexAttribArray (c-lambda (GLuint) void "glEnableVertexAttribArray"))
(define glEnd (c-lambda () void "glEnd"))
(define glFinish (c-lambda () void "glFinish"))
(define glFlush (c-lambda () void "glFlush"))
(define glFramebufferRenderbuffer (c-lambda (GLenum GLenum GLenum GLuint) void "glFramebufferRenderbuffer"))
(define glFramebufferTexture2D (c-lambda (GLenum GLenum GLenum GLuint GLint) void "glFramebufferTexture2D"))
(define glFrontFace (c-lambda (GLenum) void "glFrontFace"))
(define glGenBuffers (c-lambda (GLsizei GLuint*) void "glGenBuffers"))
(define glGenerateMipmap (c-lambda (GLenum) void "glGenerateMipmap"))
(define glGenFramebuffers (c-lambda (GLsizei GLuint*) void "glGenFramebuffers"))
(define glGenRenderbuffers (c-lambda (GLsizei GLuint*) void "glGenRenderbuffers"))
(define glGenTextures (c-lambda (GLsizei GLuint*) void "glGenTextures"))
(define glGenVertexArrays (c-lambda (GLsizei GLuint*) void "glGenVertexArrays"))
(define glGetActiveAttrib (c-lambda (GLuint GLuint GLsizei GLsizei* GLint* GLenum* GLchar*) void "glGetActiveAttrib"))
(define glGetActiveUniform (c-lambda (GLuint GLuint GLsizei GLsizei* GLint* GLenum* GLchar*) void "glGetActiveUniform"))
(define glGetAttachedShaders (c-lambda (GLuint GLsizei GLsizei* GLuint*) void "glGetAttachedShaders"))
(define glGetAttribLocation (c-lambda (GLuint GLchar*) GLint "glGetAttribLocation"))
(define glGetBooleanv (c-lambda (GLenum GLboolean*) void "glGetBooleanv"))
(define glGetBufferParameteriv (c-lambda (GLenum GLenum GLint*) void "glGetBufferParameteriv"))
(define glGetError (c-lambda () GLenum "glGetError"))
(define glGetFloatv (c-lambda (GLenum GLfloat*) void "glGetFloatv"))
(define glGetFramebufferAttachmentParameteriv (c-lambda (GLenum GLenum GLenum GLint*) void "glGetFramebufferAttachmentParameteriv"))
(define glGetIntegerv (c-lambda (GLenum GLint*) void "glGetIntegerv"))
(define glGetProgramiv (c-lambda (GLuint GLenum GLint*) void "glGetProgramiv"))
(define glGetProgramInfoLog (c-lambda (GLuint GLsizei GLsizei* GLchar*) void "glGetProgramInfoLog"))
(define glGetRenderbufferParameteriv (c-lambda (GLenum GLenum GLint*) void "glGetRenderbufferParameteriv"))
(define glGenSamplers (c-lambda (GLsizei GLuint*) void "glGenSamplers"))
(define glGetAttribLocation (c-lambda (GLuint char-string) GLuint "glGetAttribLocation"))
(define glGetShaderiv (c-lambda (GLuint GLenum GLint*) void "glGetShaderiv"))
(define glGetShaderInfoLog (c-lambda (GLuint GLsizei GLsizei* GLchar*) void "glGetShaderInfoLog"))
(define glGetShaderPrecisionFormat (c-lambda (GLenum GLenum GLint* GLint*) void "glGetShaderPrecisionFormat"))
(define glGetShaderSource (c-lambda (GLuint GLsizei GLsizei* GLchar*) void "glGetShaderSource"))
(define glGetString (c-lambda (GLenum) GLubyte* "glGetString"))
(define glGetTexParameterfv (c-lambda (GLenum GLenum GLfloat*) void "glGetTexParameterfv"))
(define glGetTexParameteriv (c-lambda (GLenum GLenum GLint*) void "glGetTexParameteriv"))
(define glGetUniformfv (c-lambda (GLuint GLint GLfloat*) void "glGetUniformfv"))
(define glGetUniformiv (c-lambda (GLuint GLint GLint*) void "glGetUniformiv"))
(define glGetUniformLocation (c-lambda (GLuint char-string) GLint "glGetUniformLocation"))
(define glGetVertexAttribfv (c-lambda (GLuint GLenum GLfloat*) void "glGetVertexAttribfv"))
(define glGetVertexAttribiv (c-lambda (GLuint GLenum GLint*) void "glGetVertexAttribiv"))
(define glGetVertexAttribPointerv (c-lambda (GLuint GLenum GLvoid**) void "glGetVertexAttribPointerv"))
(define glHint (c-lambda (GLenum GLenum) void "glHint"))
(define glIsBuffer (c-lambda (GLuint) GLboolean "glIsBuffer"))
(define glIsEnabled (c-lambda (GLenum) GLboolean "glIsEnabled"))
(define glIsFramebuffer (c-lambda (GLuint) GLboolean "glIsFramebuffer"))
(define glIsProgram (c-lambda (GLuint) GLboolean "glIsProgram"))
(define glIsRenderbuffer (c-lambda (GLuint) GLboolean "glIsRenderbuffer"))
(define glIsShader (c-lambda (GLuint) GLboolean "glIsShader"))
(define glIsTexture (c-lambda (GLuint) GLboolean "glIsTexture"))
(define glLineWidth (c-lambda (GLfloat) void "glLineWidth"))
(define glLinkProgram (c-lambda (GLuint) void "glLinkProgram"))
(define glLoadIdentity (c-lambda () void "glLoadIdentity"))
(define glMatrixMode (c-lambda (GLenum) void "glMatrixMode"))
(define glOrtho (c-lambda (GLdouble GLdouble GLdouble GLdouble GLdouble GLdouble) void           "glOrtho"))
(define glPopMatrix (c-lambda () void "glPopMatrix"))
(define glPushMatrix (c-lambda () void "glPushMatrix"))
(define glSamplerParameterf (c-lambda (GLuint GLenum GLfloat) void "glSamplerParameterf"))
(define glSamplerParameteri (c-lambda (GLuint GLenum GLint) void "glSamplerParameteri"))
(define glPixelStorei (c-lambda (GLenum GLint) void "glPixelStorei"))
(define glPolygonOffset (c-lambda (GLfloat GLfloat) void "glPolygonOffset"))
(define glReadPixels (c-lambda (GLint GLint GLsizei GLsizei GLenum GLenum GLvoid*) void "glReadPixels"))
(define glReleaseShaderCompiler (c-lambda () void "glReleaseShaderCompiler"))
(define glRenderbufferStorage (c-lambda (GLenum GLenum GLsizei GLsizei) void "glRenderbufferStorage"))
(define glSampleCoverage (c-lambda (GLclampf GLboolean) void "glSampleCoverage"))
(define glScissor (c-lambda (GLint GLint GLsizei GLsizei) void "glScissor"))
(define glShaderBinary (c-lambda (GLsizei GLuint* GLenum GLvoid* GLsizei) void "glShaderBinary"))
(define glShaderSource (c-lambda (GLuint GLsizei GLchar** GLint*) void "glShaderSource"))
(define glStencilFunc (c-lambda (GLenum GLint GLuint) void "glStencilFunc"))
(define glStencilFuncSeparate (c-lambda (GLenum GLenum GLint GLuint) void "glStencilFuncSeparate"))
(define glStencilMask (c-lambda (GLuint) void "glStencilMask"))
(define glStencilMaskSeparate (c-lambda (GLenum GLuint) void "glStencilMaskSeparate"))
(define glStencilOp (c-lambda (GLenum GLenum GLenum) void "glStencilOp"))
(define glStencilOpSeparate (c-lambda (GLenum GLenum GLenum GLenum) void "glStencilOpSeparate"))
(define glTexCoordPointer (c-lambda (GLint GLenum GLsizei GLvoid*) void "glTexCoordPointer"))
(define glTexImage2D (c-lambda (GLenum GLint GLint GLsizei GLsizei GLint GLenum GLenum GLvoid*) void "glTexImage2D"))
(define glTexParameteri (c-lambda (GLenum GLenum GLint) void "glTexParameteri"))
(define glTexParameterf (c-lambda (GLenum GLenum GLfloat) void "glTexParameterf"))
(define glTexParameterfv (c-lambda (GLenum GLenum GLfloat*) void "glTexParameterfv"))
(define glTexParameteri (c-lambda (GLenum GLenum GLint) void "glTexParameteri"))
(define glTexParameteriv (c-lambda (GLenum GLenum GLint*) void "glTexParameteriv"))
(define glTexSubImage2D (c-lambda (GLenum GLint GLint GLint GLsizei GLsizei GLenum GLenum GLvoid*) void "glTexSubImage2D"))
(define glUniform1f (c-lambda (GLint GLfloat) void "glUniform1f"))
(define glUniform1fv (c-lambda (GLint GLsizei GLfloat*) void "glUniform1fv"))
(define glUniform1i (c-lambda (GLint GLint) void "glUniform1i"))
(define glUniform1iv (c-lambda (GLint GLsizei GLint*) void "glUniform1iv"))
(define glUniform2f (c-lambda (GLint GLfloat GLfloat) void "glUniform2f"))
(define glUniform2fv (c-lambda (GLint GLsizei GLfloat*) void "glUniform2fv"))
(define glUniform2i (c-lambda (GLint GLint GLint) void "glUniform2i"))
(define glUniform2iv (c-lambda (GLint GLsizei GLint*) void "glUniform2iv"))
(define glUniform3f (c-lambda (GLint GLfloat GLfloat GLfloat) void "glUniform3f"))
(define glUniform3fv (c-lambda (GLint GLsizei GLfloat*) void "glUniform3fv"))
(define glUniform3i (c-lambda (GLint GLint GLint GLint) void "glUniform3i"))
(define glUniform3iv (c-lambda (GLint GLsizei GLint*) void "glUniform3iv"))
(define glUniform4f (c-lambda (GLint GLfloat GLfloat GLfloat GLfloat) void "glUniform4f"))
(define glUniform4fv (c-lambda (GLint GLsizei GLfloat*) void "glUniform4fv"))
(define glUniform4i (c-lambda (GLint GLint GLint GLint GLint) void "glUniform4i"))
(define glUniform4iv (c-lambda (GLint GLsizei GLint*) void "glUniform4iv"))
(define glUniformMatrix2fv (c-lambda (GLint GLsizei GLboolean GLfloat*) void "glUniformMatrix2fv"))
(define glUniformMatrix3fv (c-lambda (GLint GLsizei GLboolean GLfloat*) void "glUniformMatrix3fv"))
(define glUniformMatrix4fv (c-lambda (GLint GLsizei GLboolean GLfloat*) void "glUniformMatrix4fv"))
(define glUseProgram (c-lambda (GLuint) void "glUseProgram"))
(define glValidateProgram (c-lambda (GLuint) void "glValidateProgram"))
(define glVertexAttrib1f (c-lambda (GLuint GLfloat) void "glVertexAttrib1f"))
(define glVertexAttrib1fv (c-lambda (GLuint GLfloat*) void "glVertexAttrib1fv"))
(define glVertexAttrib2f (c-lambda (GLuint GLfloat GLfloat) void "glVertexAttrib2f"))
(define glVertexAttrib2fv (c-lambda (GLuint GLfloat*) void "glVertexAttrib2fv"))
(define glVertexAttrib3f (c-lambda (GLuint GLfloat GLfloat GLfloat) void "glVertexAttrib3f"))
(define glVertexAttrib3fv (c-lambda (GLuint GLfloat*) void "glVertexAttrib3fv"))
(define glVertexAttrib4f (c-lambda (GLuint GLfloat GLfloat GLfloat GLfloat) void "glVertexAttrib4f"))
(define glVertexAttrib4fv (c-lambda (GLuint GLfloat*) void "glVertexAttrib4fv"))
(define glVertexPointer (c-lambda (GLint GLenum GLsizei GLvoid*) void "glVertexPointer"))
(define glVertexAttribPointer (c-lambda (GLuint GLint GLenum GLboolean GLsizei GLvoid*) void "glVertexAttribPointer"))
(define glViewport (c-lambda (GLint GLint GLsizei GLsizei) void "glViewport"))

;; OpenGL 2
(define glBindSampler (c-lambda (GLuint GLuint) void "glBindSampler"))

(define glBegin (c-lambda (GLenum) void "glBegin"))
(define glBlendFunc (c-lambda (GLenum GLenum) void "glBlendFunc"))
(define glBindTexture (c-lambda (GLenum GLuint) void "glBindTexture"))

(define glBindVertexArray (c-lambda (GLuint) void "glBindVertexArray"))

(define glColor3f (c-lambda (GLfloat GLfloat GLfloat) void "glColor3f"))

(define glVertex3f (c-lambda (GLfloat GLfloat GLfloat) void "glVertex3f"))
