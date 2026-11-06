//! Transpiled from Horizon Rust crate
//! Module: horizon-shader-api_inputs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What a pack's WGSL reads: the frame uniform every stage sees, which the
//! renderer fills and uploads as the Rust struct below, and the stage input
//! and output structs. The WGSL of each is generated from these definitions
//! (`Struct::wgsl`), and so is the reference (docs/api/shaders-reference.md).

/// One field of a WGSL struct, for the prelude and the reference.
pub const Field = struct {
    name: *'static str,
    ty: *'static str,
    /// Its meaning, unit and range.
    doc: *'static str,
};

/// A struct a pack's WGSL can name.
pub const Struct = struct {
    name: *'static str,
    doc: *'static str,
    fields: *'static [Field],
};

    // rust: impl Struct {
pub fn wgsl(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = format!("struct {} {{\n", self.name);
    // rust: for f in self.fields {
    // rust: out += &format!("    {}: {},\n", f.name, f.ty);
}
    // rust: out + "}\n"
}
}

/// The WGSL type of a Rust field the renderer uploads.
    // rust: pub trait Wgsl {
    // rust: const TYPE: &'static str;
}

    // rust: macro_rules! wgsl_types {
    // rust: ($($rust:ty => $wgsl:literal),* $(,)?) => {
    // rust: $(impl Wgsl for $rust {
pub const TYPE: *'static str = $wgsl;
    // rust: })*
}
}

    // rust: wgsl_types! {
    // rust: f32 => "f32",
    // rust: u32 => "u32",
    // rust: i32 => "i32",
    // rust: [f32; 2] => "vec2<f32>",
    // rust: [f32; 3] => "vec3<f32>",
    // rust: [f32; 4] => "vec4<f32>",
    // rust: [[f32; 4]; 4] => "mat4x4<f32>",
    // rust: [[f32; 4]; 8] => "array<vec4<f32>, 8>",
}

/// A uniform struct: the Rust type the renderer uploads, and its WGSL. `pad` names a trailing
/// field in Rust only, which fills the struct out to WGSL's size (a multiple of its 16-byte
/// alignment), since `Pod` allows no implicit padding.
    // rust: macro_rules! uniform {
    // rust: ($(#[doc = $doc:literal])* $name:ident {
    // rust: $($(#[doc = $fdoc:literal])* $field:ident: $ty:ty,)*
    // rust: } $(pad $pad:ident: $pad_ty:ty)?) => {
    // rust: $(#[doc = $doc])*
    // rust: pub struct $name {
    // rust: $($(#[doc = $fdoc])* pub $field: $ty,)*
    // rust: $(/// Not in the WGSL: zeros up to its size.
    // rust: pub $pad: $pad_ty,)?
}

    // rust: impl $name {
    // rust: pub const WGSL: Struct = Struct {
    // rust: name: stringify!($name),
    // rust: doc: concat!($($doc, "\n"),*),
    // rust: fields: &[$(Field {
    // rust: name: stringify!($field),
    // rust: ty: <$ty as Wgsl>::TYPE,
    // rust: doc: concat!($($fdoc),*),
    // rust: }),*],
}
            /// Each field's byte offset, in `WGSL.fields`' order.
pub const OFFSETS: *'static [usize] = &[$(std::mem::offset_of!($name, $field)),*];
}
}
}

    // rust: uniform! {
    /// The frame, as `frame` in every stage. Positions and directions are
    /// in world axes relative to the camera (x east, y up, z south), so they
    /// stay precise far from the world's origin; depth is reversed (1 near,
    /// 0 at the far plane and in the sky).
    // rust: Frame {
        /// Camera-relative world to view space: the camera's rotation.
    // rust: view: [[f32; 4]; 4],
        /// View to clip space (reversed depth, wgpu's clip space: z 0..1).
    // rust: projection: [[f32; 4]; 4],
        /// View to camera-relative world space.
    // rust: view_inverse: [[f32; 4]; 4],
        /// Clip to view space.
    // rust: projection_inverse: [[f32; 4]; 4],
        /// The camera's world position, in blocks (about a millimetre of precision 10 000 blocks out).
    // rust: camera_position: [f32; 3],
        /// Seconds since the pack was loaded, wrapping to 0 every hour.
    // rust: time: f32,
        /// Unit vector toward the sun (below the horizon at night).
    // rust: sun_direction: [f32; 3],
        /// The time of day, 0..1: 0 sunrise, 0.25 noon, 0.5 sunset, 0.75 midnight.
    // rust: day_time: f32,
        /// Unit vector toward the moon.
    // rust: moon_direction: [f32; 3],
        /// Vanilla's GameTime: (game time % 24000 + partial tick) / 24000, 0..1.
    // rust: game_time: f32,
        /// Vanilla's sky colour this frame, 0..1.
    // rust: sky_color: [f32; 3],
        /// Rain strength, 0..1.
    // rust: rain: f32,
        /// Vanilla's fog colour this frame (also the clear colour), 0..1.
    // rust: fog_color: [f32; 3],
        /// Thunder strength, 0..1.
    // rust: thunder: f32,
        /// The size of the world's picture, in pixels (the resolution scale applied).
    // rust: resolution: [f32; 2],
        /// Block and sky light at the camera, 0..1 (level / 15).
    // rust: eye_light: [f32; 2],
        /// Where vanilla's fog starts, in blocks from the camera.
    // rust: fog_start: f32,
        /// Where vanilla's fog is full, in blocks.
    // rust: fog_end: f32,
        /// The render distance, in blocks.
    // rust: render_distance: f32,
        /// The far plane, in blocks.
    // rust: far: f32,
        /// Night vision strength, 0..1.
    // rust: night_vision: f32,
        /// Blindness strength, 0..1.
    // rust: blindness: f32,
        /// The darkness effect's strength, 0..1.
    // rust: darkness: f32,
        /// The Brightness option, 0..1 (Moody to Bright).
    // rust: brightness: f32,
        /// What the camera is in: 0 air, 1 water, 2 lava, 3 powder snow.
    // rust: eye_in: u32,
        /// 0 the Overworld, -1 the Nether, 1 the End, 2 any other dimension.
    // rust: dimension: i32,
        /// Frames drawn since the pack was loaded (wraps).
    // rust: frame_index: u32,
        /// 1 while F1 hides the HUD, else 0.
    // rust: hide_gui: u32,
        /// What falls in the biome at the camera while it rains: 0 nothing, 1 rain, 2 snow.
    // rust: precipitation: u32,
        /// The biome at the camera's temperature (vanilla's, -0.7..2.0; it snows below 0.15).
    // rust: temperature: f32,
        /// The biome at the camera's downfall, 0..1.
    // rust: downfall: f32,
        /// `rain`, smoothed: rises over about 30 seconds and dries over about 10, 0..1.
    // rust: wetness: f32,
        /// Last frame's camera-relative world to clip space (its `projection * view`); a point
        /// at camera-relative `p` now was at `p + camera_motion` relative to last frame's camera.
        /// This frame's on the first frame and after a gap of over half a second (a pause, a
        /// world load), when last frame's camera says nothing about this one.
    // rust: previous_view_projection: [[f32; 4]; 4],
        /// How far the camera moved since last frame, in blocks (0 after such a gap).
    // rust: camera_motion: [f32; 3],
        /// Seconds since last frame (0 on the first and after such a gap).
    // rust: delta_time: f32,
        /// `eye_light` eased with a half-life of 2 seconds: it follows the light levels' steps
        /// without stepping itself (for exposure and indoor fog).
    // rust: eye_light_smooth: [f32; 2],
        /// 1 while the camera is in water (`eye_in` 1), eased with a half-life of a quarter
        /// second in and out.
    // rust: in_water: f32,
        /// The same for lava (`eye_in` 2).
    // rust: in_lava: f32,
        /// The y of the horizontal water plane `reflection` mirrors the world about, in world
        /// blocks, while `has_reflection` is 1.
    // rust: water_plane: f32,
        /// 1 while the material stage's `reflection` holds this frame's water mirror, else 0.
    // rust: has_reflection: u32,
        /// The size of `reflection`, in pixels: half the world's picture.
    // rust: reflection_resolution: [f32; 2],
        /// Eight values a native mod hands its own pack each frame (`native_shader_params`,
        /// docs/native-mods.md): what they mean is that mod's, such as where and when
        /// something happened in the world. All 0 when no mod sets them.
    // rust: mods: [[f32; 4]; 8],
        /// Unit vector toward the body casting this frame's shadows: the sun by day, the moon
        /// by night.
    // rust: light_direction: [f32; 3],
        /// 1 while `shadow_map` holds this frame's shadow map, else 0.
    // rust: has_shadow: u32,
        /// Camera-relative world to the shadow camera's clip space, before the distortion
        /// (orthographic, looking along `-light_direction`; z 0 at the light, 1 away from it).
    // rust: shadow_view_proj: [[f32; 4]; 4],
        /// Half the side of the square the shadow map covers, in blocks (the manifest's
        /// `[shadow] distance`); 0 without a shadow map.
    // rust: shadow_distance: f32,
        /// How strongly the shadow map is distorted toward its centre, 0..1: a point at
        /// shadow clip `xy` is stored at `xy / (length(xy) * k + 1 - k)`, so texels near the
        /// camera cover less ground (`shadow_position` applies it).
    // rust: shadow_distortion: f32,
        /// The shadow map's side, in texels; 0 without a shadow map.
    // rust: shadow_resolution: f32,
        /// The ground one shadow texel covers at the map's centre, in blocks (for a bias that
        /// scales with it); 0 without a shadow map.
    // rust: shadow_center_texel: f32,
        /// 1 while the output is HDR, else 0.
    // rust: hdr: u32,
        /// The peak over paper white: the brightest value the display shows (Apple's EDR
        /// headroom, Android's HDR/SDR ratio). 1 in SDR. It changes while the game runs (the
        /// system's SDR white, a calibration, another display), so read it every frame.
    // rust: headroom: f32,
        /// Paper white in nits; a nominal 80 in SDR.
    // rust: paper_white: f32,
        /// The peak brightness in nits; a nominal 80 in SDR, as `paper_white`.
    // rust: peak: f32,
        /// The display's black in nits (HDR's Black Level); 0 in SDR.
    // rust: black_level: f32,
    // rust: } pad padding: [u32; 3]
}

    // rust: impl Frame {
    /// The fields 0.1's prelude declares: the struct up to `shadow_center_texel`, a prefix of
    /// the buffer the renderer uploads.
pub const FIELDS_0_1: usize = 49;

    /// `Frame` as the line's prelude declares it.
pub fn line(api: crate::Api) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fields = match api {
    // rust: crate::Api::V0_1 => &Self::WGSL.fields[..Self::FIELDS_0_1],
    // rust: crate::Api::V0_2 => Self::WGSL.fields,
}
    // rust: Struct {
    // rust: fields,
    // rust: ..Self::WGSL
}
}
}

    // rust: macro_rules! fields {
    // rust: ($($name:ident: $ty:literal = $doc:literal,)*) => {
    // rust: &[$(Field { name: stringify!($name), ty: $ty, doc: $doc }),*]
}
}

/// The post stage's input: one pixel of the picture.
    // rust: pub const POST_INPUT: Struct = Struct {
    // rust: name: "PostInput",
    // rust: doc: "One pixel of the picture, for `fn post(input: PostInput) -> vec4<f32>`.",
    // rust: fields: fields! {
    // rust: uv: "vec2<f32>" = "Where the pixel is, 0..1 from the top left.",
    // rust: pixel: "vec2<f32>" = "The pixel's centre, in pixels from the top left of what the pass draws (the world's size; the window's for the last pass).",
    // rust: color: "vec4<f32>" = "The previous pass's colour here (the world's picture for the first pass).",
    // rust: depth: "f32" = "The world's depth here, reversed: 0 is the sky.",
    // rust: },
}

/// The material stage's input: one point of a block's surface.
    // rust: pub const MATERIAL_INPUT: Struct = Struct {
    // rust: name: "MaterialInput",
    // rust: doc: "One point of a block's surface, for `fn material(input: MaterialInput) -> Surface`.",
    // rust: fields: fields! {
    // rust: albedo: "vec4<f32>" = "The block texture's colour here (alpha 0..1).",
    // rust: tint: "vec4<f32>" = "The vertex colour: biome tint, face shade and ambient occlusion.",
    // rust: light: "vec2<f32>" = "Block and sky light, 0..1, smoothed over the face.",
    // rust: lightmap: "vec3<f32>" = "Vanilla's light colour for that light this frame.",
    // rust: position: "vec3<f32>" = "The point, camera-relative, in blocks.",
    // rust: uv: "vec2<f32>" = "The texture coordinate inside the block atlas.",
    // rust: translucent: "bool" = "Drawn in the translucent pass (water, stained glass, ice).",
    // rust: tags: "u32" = "The pack's sprite tags this surface's sprite has: bit i for the manifest's i-th `[[tags]]`.",
    // rust: material: "u32" = "The `[[materials]]` id of this surface's sprite (0 when no entry names it).",
    // rust: screen: "vec2<f32>" = "Where the point is on the screen, 0..1 from the top left (`opaque_depth` and `opaque_color` at `screen * frame.resolution`).",
    // rust: face: "u32" = "For a fluid, which face of the block the point is on, `Direction` order: 0 down, 1 up, 2 north, 3 south, 4 west, 5 east. 0 elsewhere.",
    // rust: fluid: "u32" = "0 not a fluid, 1 water, 2 lava.",
    // rust: emission: "f32" = "How strongly the block itself shines, 0..1, by its kind of light: a redstone torch or a candle 7/15, a torch or lava 14/15, glowstone 1; 0 for most blocks.",
    // rust: normal: "vec3<f32>" = "The surface's geometric normal, a unit vector in world axes, facing the camera. A normal within about 3.6 degrees of an axis is that axis exactly, so distant block faces do not shimmer; flowing water's slopes are steeper and keep theirs.",
    // rust: tangent: "vec4<f32>" = "The surface's tangent: xyz the unit direction in world axes along which `uv.x` grows, w the sign (1 or -1) that makes `cross(normal, tangent.xyz) * tangent.w` the direction `uv.y` grows along (down the texture). With `normal` it turns a normal map's normals into world axes.",
    // rust: colored_light: "vec3<f32>" = "The frame's coloured lights at this point (`[[particle_lights]]`, held and dropped items in their `[[lights]]` colour while dynamic lights are on, and mods' visual lights), 0..1, to light the surface with as the pack likes; 0 where none reaches.",
    // rust: displaced: "f32" = "How much of the relief `[displacement]` gave this point as geometry, 0..1: 1 near the camera, where the surface already lies where `displacement` put it (`position` is that point; a parallax effect would count its depth twice), easing to 0 at `[displacement] distance`; always 0 without `[displacement]`.",
    // rust: },
}

/// What the material stage returns.
    // rust: pub const SURFACE: Struct = Struct {
    // rust: name: "Surface",
    // rust: doc: "What `material` returns. Vanilla's own is `albedo * tint * vec4(lightmap, 1.0)`; \
    // rust: Horizon then applies the alpha test (cutout and translucent) and fog.",
    // rust: fields: fields! {
    // rust: color: "vec4<f32>" = "The lit colour, 0..1, with its alpha.",
    // rust: },
}

/// The sky stage's input: one direction of the sky.
    // rust: pub const SKY_INPUT: Struct = Struct {
    // rust: name: "SkyInput",
    // rust: doc: "One direction of the sky, for `fn sky(input: SkyInput) -> vec4<f32>`. The sun, moon, \
    // rust: stars and clouds are drawn over the result.",
    // rust: fields: fields! {
    // rust: direction: "vec3<f32>" = "Unit view ray, camera-relative world axes.",
    // rust: color: "vec4<f32>" = "Vanilla's sky colour along the ray (sky, fog and sunrise).",
    // rust: },
}

/// The input of the material stage's `displacement`, under `[displacement]`.
    // rust: pub const DISPLACEMENT_INPUT: Struct = Struct {
    // rust: name: "DisplacementInput",
    // rust: doc: "One corner of the grid a block face near the camera is cut into, for `fn displacement(input: DisplacementInput) -> f32` (`[displacement]`), which returns how deep below the face, in blocks, the surface lies at `height`.",
    // rust: fields: fields! {
    // rust: position: "vec3<f32>" = "The corner on the flat face, camera-relative, in blocks.",
    // rust: normal: "vec3<f32>" = "The face's normal, a unit vector in world axes.",
    // rust: uv: "vec2<f32>" = "The texture coordinate inside the block's sprite (as `MaterialInput.uv`).",
    // rust: material: "u32" = "The `[[materials]]` id of the block texture (0 when none matches).",
    // rust: height: "f32" = "A LabPBR height, 0..1 (1 the top of the relief): the normal map's alpha here, or the texture's average height (what the face's edges are pinned to).",
    // rust: },
}

/// The vertex stage's input: one corner of a block's surface.
    // rust: pub const VERTEX_INPUT: Struct = Struct {
    // rust: name: "VertexInput",
    // rust: doc: "One corner of a block's surface, for `fn vertex(input: VertexInput) -> vec3<f32>`, which returns where it is drawn (camera-relative, in blocks; `input.position` where it stays).",
    // rust: fields: fields! {
    // rust: position: "vec3<f32>" = "The corner, camera-relative, in blocks (`+ frame.camera_position` for the world's).",
    // rust: uv: "vec2<f32>" = "The texture coordinate inside the block's sprite.",
    // rust: material: "u32" = "The `[[materials]]` id of the block's sprite (0 when none matches).",
    // rust: light: "vec2<f32>" = "Block and sky light, 0..1.",
    // rust: tint: "vec4<f32>" = "The vertex colour (biome tint, face shade, ambient occlusion); alpha 1.",
    // rust: face: "u32" = "For a fluid, the face of the block the corner is on (as `MaterialInput.face`), else 0.",
    // rust: fluid: "u32" = "1 on a fluid's surface (water or lava), else 0.",
    // rust: },
}

/// The weather stage's input: one point of a rain or snow streak.
    // rust: pub const WEATHER_INPUT: Struct = Struct {
    // rust: name: "WeatherInput",
    // rust: doc: "One point of a rain or snow streak, for `fn weather(input: WeatherInput) -> vec4<f32>`, \
    // rust: which returns the colour blended over the world (alpha its opacity).",
    // rust: fields: fields! {
    // rust: color: "vec4<f32>" = "The rain or snow texture's colour here times the streak's vertex colour (alpha 0.1..1).",
    // rust: light: "vec2<f32>" = "Block and sky light, 0..1.",
    // rust: position: "vec3<f32>" = "The point, camera-relative, in blocks.",
    // rust: snow: "bool" = "A snow streak (rain otherwise).",
    // rust: },
}

/// The tonemap stage's input (0.2): one pixel of the window.
    // rust: pub const TONEMAP_INPUT: Struct = Struct {
    // rust: name: "TonemapInput",
    // rust: doc: "One pixel of the window, for `fn tonemap(input: TonemapInput) -> vec3<f32>`, which returns its colour for the display: linear light, 1.0 at paper white, from 0 to `frame.headroom` (Horizon clamps it there).",
    // rust: fields: fields! {
    // rust: uv: "vec2<f32>" = "Where the pixel is, 0..1 from the top left.",
    // rust: pixel: "vec2<f32>" = "The pixel's centre, in pixels from the top left of the window.",
    // rust: color: "vec3<f32>" = "The post chain's picture here (the world's without one), linear light, never negative or NaN.",
    // rust: },
}

    // rust: mod tests {
//     use super::*;

pub fn frame_fields_carry_their_docs() void {
}
    // rust: let wgsl = Frame::WGSL;
    // rust: assert_eq!(wgsl.fields.len(), 54);
    // rust: assert!(wgsl.fields.iter().all(|f| !f.doc.trim().is_empty()));
        // 0.1's 49 fields, then 0.2's five and the padding to a multiple of 16.
    // rust: assert_eq!(
    // rust: std::mem::size_of::<Frame>(),
    // rust: 6 * 64 + 15 * 16 + 8 * 16 + 2 * 16
    // rust: );
    // rust: assert_eq!(Frame::OFFSETS[Frame::FIELDS_0_1], 6 * 64 + 15 * 16 + 8 * 16);
    // rust: assert_eq!(
    // rust: Frame::line(crate::Api::V0_1).fields.len(),
    // rust: Frame::FIELDS_0_1
    // rust: );
    // rust: assert!(
    // rust: wgsl.wgsl()
    // rust: .contains("    camera_position: vec3<f32>,\n    time: f32,\n")
    // rust: );
}
}
