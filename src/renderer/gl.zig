//! Zigcraft GLES3 / OpenGL Renderer
//! Voxel terrain shaders, matrix uniforms, and mesh drawing pipeline.

const std = @import("std");
const math = @import("../core/math.zig");
const Mat4 = math.Mat4;
const Vec3 = math.Vec3;
const mesher = @import("../world/mesher.zig");
const Vertex = mesher.Vertex;
const ChunkMesh = mesher.ChunkMesh;

pub const GL_TRIANGLES = 0x0004;
pub const GL_FLOAT = 0x1406;
pub const GL_UNSIGNED_INT = 0x1405;
pub const GL_ARRAY_BUFFER = 0x8892;
pub const GL_ELEMENT_ARRAY_BUFFER = 0x8893;
pub const GL_STATIC_DRAW = 0x88E4;
pub const GL_DYNAMIC_DRAW = 0x88E8;
pub const GL_COLOR_BUFFER_BIT = 0x00004000;
pub const GL_DEPTH_BUFFER_BIT = 0x00000100;
pub const GL_DEPTH_TEST = 0x0B71;
pub const GL_CULL_FACE = 0x0B44;

pub const CHUNK_VERTEX_SHADER =
    \\#version 300 es
    \\precision highp float;
    \\layout(location = 0) in vec3 aPos;
    \\layout(location = 1) in vec2 aUv;
    \\layout(location = 2) in vec3 aNormal;
    \\layout(location = 3) in float aAo;
    \\layout(location = 4) in float aLight;
    \\
    \\uniform mat4 uModel;
    \\uniform mat4 uView;
    \\uniform mat4 uProjection;
    \\uniform vec3 uSunDirection;
    \\
    \\out vec2 vUv;
    \\out float vLight;
    \\
    \\void main() {
    \\    vUv = aUv;
    \\    float diffuse = max(dot(aNormal, normalize(uSunDirection)), 0.2);
    \\    vLight = aLight * aAo * diffuse;
    \\    gl_Position = uProjection * uView * uModel * vec4(aPos, 1.0);
    \\}
;

pub const CHUNK_FRAGMENT_SHADER =
    \\#version 300 es
    \\precision highp float;
    \\in vec2 vUv;
    \\in float vLight;
    \\out vec4 FragColor;
    \\
    \\uniform sampler2D uTextureAtlas;
    \\
    \\void main() {
    \\    vec4 texColor = texture(uTextureAtlas, vUv);
    \\    if (texColor.a < 0.1) discard;
    \\    FragColor = vec4(texColor.rgb * vLight, texColor.a);
    \\}
;

pub const RenderPipeline = struct {
    vao: u32,
    vbo: u32,
    ebo: u32,
    program: u32,
    u_model: i32,
    u_view: i32,
    u_proj: i32,
    u_sun: i32,
    index_count: usize,

    pub fn init() RenderPipeline {
        return .{
            .vao = 0,
            .vbo = 0,
            .ebo = 0,
            .program = 0,
            .u_model = -1,
            .u_view = -1,
            .u_proj = -1,
            .u_sun = -1,
            .index_count = 0,
        };
    }

    pub fn uploadMesh(self: *RenderPipeline, mesh: *const ChunkMesh) void {
        self.index_count = mesh.indices.items.len;
    }

    pub fn draw(self: *const RenderPipeline, model: Mat4, view: Mat4, proj: Mat4) void {
        _ = self;
        _ = model;
        _ = view;
        _ = proj;
    }
};
