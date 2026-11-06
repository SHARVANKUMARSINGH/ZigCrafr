//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_screen_effects
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Full-screen camera effects drawn between the world and the HUD:
//! `ScreenEffectRenderer` (in-wall block texture, underwater overlay, fire)
//! and the full-screen `Hud` camera overlays laid out by
//! `hud_overlays::camera_overlays` (vignette, pumpkin blur, powder-snow
//! outline, nether portal swirl). Positions are clip-space quads; textures
//! come from the shared 2D atlas and may repeat.
// use crate::{
    // rust: effects::EffectInstance,
    // rust: hud::{Rect, TextureFlags},
    // rust: hud_layout::GuiDraw,
}
// use std::collections::HashMap;

pub const Blend = enum {
    /// `GUI_TEXTURED` / screen effects: alpha blending.
    Alpha,
    /// `RenderPipelines.VIGNETTE`: `dst * (1 - src)`.
    Vignette,
};
/// One clip-space vertex of a screen quad.
pub const ScreenVertex = struct {
    pos: [f32,
    /// Texture coordinates in sprite units (repeat outside 0..1).
    uv: [f32,
    /// Atlas rectangle (u0, v0, u1, v1) of the sprite.
    rect: [f32,
    color: [f32,
};
/// Linear filtering (`TextureMetadataSection.blur`), else nearest.
pub const SAMPLE_BLUR: u32 = 1;
/// Clamp-to-edge addressing (`TextureMetadataSection.clamp`), else repeat.
pub const SAMPLE_CLAMP: u32 = 2;
/// The sampling bits of a standalone texture's flags.
pub fn sampling(flags: TextureFlags) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bit = |on: bool, bit: u32| if on { bit } else { 0 };
    // rust: bit(flags.blur, SAMPLE_BLUR) | bit(flags.clamp, SAMPLE_CLAMP)
}
pub const ScreenQuad = struct {
    vertices: [ScreenVertex,
    blend: Blend,
    /// How the sprite is sampled: [`SAMPLE_BLUR`] and [`SAMPLE_CLAMP`].
    sampling: u32,
    /// A tint of the whole view (the underwater overlay), not something in front of it: in HDR
    /// output the world shines through it (`Renderer::draw_overlay`).
    world_tint: bool,
};

/// What the camera sees this frame.
pub const ScreenInputs = struct {
    sprites: *'a HashMap<[]const u8,
    /// `.png.mcmeta` sampling of the standalone textures among `sprites`.
    flags: *'a HashMap<[]const u8,
    aspect: f32,
    partial: f32,
    /// Particle sprite of the view-blocking block around the eye.
    block_overlay: ?[]const u8,
    /// Eye in water: (lightmap brightness at the eye, yaw, pitch).
    water: Option<(f32,
    on_fire: bool,
    /// How far the fire overlay moves down, in its own heights (PvP & HUD's lower fire; 0 is
    /// vanilla's place).
    fire_lower: f32,
    /// `Hud.extractCameraOverlays` draws: the full-screen blits become
    /// screen quads (the spyglass, its fills and the nausea swirl do not).
    gui_overlays: *'a [GuiDraw],
};

/// Effect state advanced every tick.
pub const ScreenEffects = struct {
    /// `Hud.vignetteBrightness`.
    vignette_brightness: f32,
    portal: f32,
    o_portal: f32,
    /// Nausea's `MobEffectInstance.BlendState` factor and the previous tick's.
    nausea: f32,
    o_nausea: f32,
    /// `LocalPlayer.spinningEffectTime` and `spinningEffectSpeed` (degrees).
    spinning_time: f32,
    spinning_speed: f32,
};
    // rust: impl Default for ScreenEffects {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: vignette_brightness: 1.0,
    // rust: portal: 0.0,
    // rust: o_portal: 0.0,
    // rust: nausea: 0.0,
    // rust: o_nausea: 0.0,
    // rust: spinning_time: 0.0,
    // rust: spinning_speed: 0.0,
}
}
}
/// `Lightmap.getBrightness`.
pub fn lightmap_brightness(ambient_light: f32, level: u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = f32::from(level) / 15.0;
    // rust: let curved = v / (4.0 - 3.0 * v);
    // rust: curved + (1.0 - curved) * ambient_light
}
/// Clip-space scale of the hand projection (fov 70) at view depth 0.5.
pub fn hand_scale(aspect: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = 0.5 * (35.0f32).to_radians().tan();
    // rust: [1.0 / (half * aspect), 1.0 / half]
}
    // rust: impl ScreenEffects {
    /// `Hud.updateVignetteBrightness` and `LocalPlayer.handlePortalTransitionEffect`.
pub fn tick(self: *Self, eye_brightness: f32, inside_portal: bool) void {
}
    // rust: let target = (1.0 - eye_brightness).clamp(0.0, 1.0);
    // rust: self.vignette_brightness += (target - self.vignette_brightness) * 0.01;
    // rust: self.o_portal = self.portal;
    // rust: let step = if inside_portal {
    // rust: 0.0125
    // rust: } else if self.portal > 0.0 {
    // rust: -0.05
    // rust: } else {
    // rust: 0.0
}
    // rust: self.portal = (self.portal + step).clamp(0.0, 1.0);
}
    /// `LocalPlayer.tickSpinningEffect` and Nausea's blend. `nausea` is `None`
    /// without the effect, else whether it is past its blend-out point
    /// (`!endsWithin(60)`, `MobEffects.NAUSEA`).
pub fn tick_spinning(self: *Self, nausea: ?bool) void {
}
    // rust: self.o_nausea = self.nausea;
    // rust: match nausea {
            // BlendState.tick: fades in over 150 ticks and out over 20.
    // rust: Some(active) => {
    // rust: let (target, duration) = if active { (1.0, 150.0) } else { (0.0, 20.0) };
    // rust: self.nausea += (target - self.nausea).clamp(-1.0 / duration, 1.0 / duration);
}
            // The blend state belongs to the instance, so a new one starts at 0.
    // rust: None => self.nausea = 0.0,
}
    // rust: if self.portal > 0.0 || self.nausea > 0.0 {
    // rust: self.spinning_speed =
    // rust: (self.portal * 20.0 + self.nausea * 7.0) / (self.portal + self.nausea);
    // rust: self.spinning_time += self.spinning_speed;
    // rust: } else {
    // rust: self.spinning_speed = 0.0;
}
}
pub fn build(self: *Self, input: *ScreenInputs) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let sprite = |name: &str| input.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
        // Standalone textures (`ReloadableTexture.setSampler`) follow their
        // metadata; atlas sprites (block overlay, fire, portal) sample
        // nearest with repeat.
    // rust: let texture_sampling = |name: &str| input.flags.get(name).copied().map_or(0, sampling);
    // rust: let scale = hand_scale(input.aspect);
        // Screen-effect quads live at view depth 0.5 in the hand projection.
    // rust: let hand_quad = |corners: [[f32; 2]; 4],
    // rust: uv: [[f32; 2]; 4],
    // rust: rect: [f32; 4],
    // rust: color: [f32; 4],
    // rust: sampling: u32| ScreenQuad {
    // rust: vertices: std::array::from_fn(|i| ScreenVertex {
    // rust: pos: [corners[i][0] * scale[0], corners[i][1] * scale[1]],
    // rust: uv: uv[i],
    // rust: rect,
    // rust: color,
    // rust: }),
    // rust: blend: Blend::Alpha,
    // rust: sampling,
    // rust: world_tint: false,
}
    // rust: let full = [[-1.0, -1.0], [1.0, -1.0], [1.0, 1.0], [-1.0, 1.0]];
        // ScreenEffectRenderer.submitBlockSprite: u1/v1 at (-1, -1), colour 0xFF191919.
    // rust: if let Some(name) = &input.block_overlay
    // rust: && let Some(rect) = sprite(name)
    // rust: {
    // rust: let c = 0x19 as f32 / 255.0;
    // rust: out.push(hand_quad(
    // rust: full,
    // rust: [[1.0, 1.0], [0.0, 1.0], [0.0, 0.0], [1.0, 0.0]],
    // rust: rect,
    // rust: [c, c, c, 1.0],
    // rust: 0,
    // rust: ));
}
    // rust: if let Some((brightness, yaw, pitch)) = input.water
    // rust: && let Some(rect) = sprite("misc/underwater")
    // rust: {
    // rust: let (u, v) = (-yaw / 64.0, pitch / 64.0);
    // rust: let uv = [[u + 4.0, v + 4.0], [u, v + 4.0], [u, v], [u + 4.0, v]];
    // rust: out.push(ScreenQuad {
    // rust: world_tint: true,
    // rust: ..hand_quad(
    // rust: full,
    // rust: uv,
    // rust: rect,
    // rust: [brightness, brightness, brightness, 0.1],
    // rust: texture_sampling("misc/underwater"),
    // rust: )
    // rust: });
}
    // rust: if input.on_fire
    // rust: && let Some(rect) = sprite("block/fire_1")
    // rust: {
    // rust: for (dx, angle) in [(0.24f32, -10.0f32), (-0.24, 10.0)] {
    // rust: let (s, c) = angle.to_radians().sin_cos();
                // rotateY about the quad then translate; z = -0.5 feeds into x.
    // rust: let corner = |x: f32, y: f32| [x * c + -0.5 * s + dx, y - 0.3 - input.fire_lower];
    // rust: let corners = [
    // rust: corner(-0.5, -0.5),
    // rust: corner(0.5, -0.5),
    // rust: corner(0.5, 0.5),
    // rust: corner(-0.5, 0.5),
    // rust: ];
    // rust: let alpha = 0xE5 as f32 / 255.0;
    // rust: out.push(hand_quad(
    // rust: corners,
    // rust: [[1.0, 1.0], [0.0, 1.0], [0.0, 0.0], [1.0, 0.0]],
    // rust: rect,
    // rust: [1.0, 1.0, 1.0, alpha],
    // rust: 0,
    // rust: ));
}
}
        // Hud camera overlays: GUI-space full-screen blits (v grows downwards).
    // rust: let gui = |rect: [f32; 4], color: [f32; 4], blend: Blend, sampling: u32| ScreenQuad {
    // rust: vertices: std::array::from_fn(|i| {
    // rust: let p = [[-1.0f32, 1.0], [1.0, 1.0], [1.0, -1.0], [-1.0, -1.0]][i];
    // rust: ScreenVertex {
    // rust: pos: p,
    // rust: uv: [[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0]][i],
    // rust: rect,
    // rust: color,
}
    // rust: }),
    // rust: blend,
    // rust: sampling,
    // rust: world_tint: false,
}
    // rust: let rgba = |c: u32| {
    // rust: let [a, r, g, b] = c.to_be_bytes();
    // rust: [r, g, b, a].map(|v| f32::from(v) / 255.0)
}
    // rust: for d in input.gui_overlays {
    // rust: match d {
    // rust: GuiDraw::Blit {
    // rust: texture,
    // rust: blend,
    // rust: x: 0,
    // rust: y: 0,
    // rust: color,
    // rust: ..
    // rust: } if *blend != crate::hud_layout::Blend::Nausea
    // rust: && texture != "misc/spyglass_scope" =>
    // rust: {
    // rust: let blend = if *blend == crate::hud_layout::Blend::Vignette {
    // rust: Blend::Vignette
    // rust: } else {
    // rust: Blend::Alpha
}
                    // The vignette darkens by texture × colour: black (in
                    // daylight its brightness fades to 0 within half a
                    // minute) leaves every pixel as it was.
    // rust: if blend == Blend::Vignette && color & 0x00ff_ffff == 0 {
    // rust: continue;
}
    // rust: if let Some(rect) = sprite(texture) {
    // rust: out.push(gui(rect, rgba(*color), blend, texture_sampling(texture)));
}
}
    // rust: GuiDraw::AtlasSprite {
    // rust: sprite: name,
    // rust: color,
    // rust: ..
    // rust: } => {
    // rust: if let Some(rect) = sprite(name) {
    // rust: out.push(gui(rect, rgba(*color), Blend::Alpha, 0));
}
}
    // rust: _ => {}
}
}
    // rust: out
}
}

/// The nausea effect's blend-out advance: over its last `NAUSEA_BLEND_OUT`
/// ticks it has no effect (`MobEffects.NAUSEA`, `endsWithin(60)`).
pub const NAUSEA_BLEND_OUT: i32 = 60;

/// `MobEffectInstance.BlendState.hasEffect`: still past the blend-out point,
/// so the effect counts as on (`!endsWithin(60)` for `MobEffects.NAUSEA`).
pub fn nausea_has_effect(e: *EffectInstance) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !e.ends_within(NAUSEA_BLEND_OUT)
}

/// A new nausea instance's `BlendState`: from nothing, or, when the server
/// asked for no blending, at once (`MobEffectInstance.skipBlending`'s
/// `BlendState.setImmediate`).
pub fn nausea_blend_added(e: *EffectInstance, blend: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let factor = if blend || !nausea_has_effect(e) {
    // rust: 0.0
    // rust: } else {
    // rust: 1.0
}
    // rust: (factor, factor)
}

    // rust: mod tests {
//     use super::*;
pub fn lightmap_brightness_curve() void {
}
    // rust: assert_eq!(lightmap_brightness(0.0, 15), 1.0);
    // rust: assert_eq!(lightmap_brightness(0.0, 0), 0.0);
    // rust: assert!((lightmap_brightness(0.1, 0) - 0.1).abs() < 1e-6);
}
pub fn portal_intensity_ramps() void {
}
    // rust: let mut e = ScreenEffects::default();
    // rust: for _ in 0..80 {
    // rust: e.tick(1.0, true);
}
    // rust: assert!((e.portal - 1.0).abs() < 1e-5);
    // rust: e.tick(1.0, false);
    // rust: assert!((e.portal - 0.95).abs() < 1e-5);
        // Vignette fades towards 1 - brightness at 1% per tick.
    // rust: assert!(e.vignette_brightness < 1.0);
}
pub fn overlays_need_their_sprites() void {
}
    // rust: let mut sprites = HashMap::new();
    // rust: sprites.insert(
    // rust: "misc/vignette".to_owned(),
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 256,
    // rust: h: 256,
    // rust: },
    // rust: );
    // rust: let e = ScreenEffects::default();
    // rust: let flags = HashMap::new();
    // rust: let input = ScreenInputs {
    // rust: sprites: &sprites,
    // rust: flags: &flags,
    // rust: aspect: 1.6,
    // rust: partial: 0.0,
    // rust: block_overlay: None,
    // rust: water: Some((1.0, 0.0, 0.0)),
    // rust: on_fire: false,
    // rust: fire_lower: 0.0,
    // rust: gui_overlays: &[crate::hud_overlays::vignette(320, 240, 1.0, 0.0)],
}
    // rust: let quads = e.build(&input);
    // rust: assert_eq!(quads.len(), 1);
    // rust: assert_eq!(quads[0].blend, Blend::Vignette);
    // rust: assert_eq!(quads[0].sampling, 0);
        // A black vignette (faded out in daylight) changes no pixel: no quad.
        // Below 1/255 the colour's channels are 0; a border warning tints it.
    // rust: for (brightness, warning, drawn) in [(0.003, 0.0, 0), (0.004, 0.0, 1), (0.0, 0.5, 1)] {
    // rust: let overlays = [crate::hud_overlays::vignette(320, 240, brightness, warning)];
    // rust: let input = ScreenInputs {
    // rust: block_overlay: None,
    // rust: gui_overlays: &overlays,
    // rust: ..input
}
    // rust: assert_eq!(e.build(&input).len(), drawn, "{brightness} {warning}");
}
}
pub fn standalone_textures_sample_by_their_metadata() void {
}
    // rust: let rect = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: let sprites: HashMap<_, _> = ["misc/vignette", "misc/underwater", "block/stone"]
    // rust: .map(|name| (name.to_owned(), rect))
    // rust: .into();
    // rust: let blur = TextureFlags {
    // rust: blur: true,
    // rust: clamp: false,
}
    // rust: let clamp = TextureFlags {
    // rust: blur: false,
    // rust: clamp: true,
}
    // rust: let flags: HashMap<_, _> = [
    // rust: ("misc/vignette".to_owned(), blur),
    // rust: ("misc/underwater".to_owned(), clamp),
            // Atlas sprites ignore the texture section.
    // rust: ("block/stone".to_owned(), blur),
    // rust: ]
    // rust: .into();
    // rust: let quads = ScreenEffects::default().build(&ScreenInputs {
    // rust: sprites: &sprites,
    // rust: flags: &flags,
    // rust: aspect: 1.6,
    // rust: partial: 0.0,
    // rust: block_overlay: Some("block/stone".to_owned()),
    // rust: water: Some((1.0, 0.0, 0.0)),
    // rust: on_fire: false,
    // rust: fire_lower: 0.0,
    // rust: gui_overlays: &[crate::hud_overlays::vignette(320, 240, 1.0, 0.0)],
    // rust: });
    // rust: let sampling: Vec<_> = quads.iter().map(|q| q.sampling).collect();
    // rust: assert_eq!(sampling, [0, SAMPLE_CLAMP, SAMPLE_BLUR]);
        // Only the underwater overlay tints the world; the block in the way covers it.
    // rust: let tints: Vec<_> = quads.iter().map(|q| q.world_tint).collect();
    // rust: assert_eq!(tints, [false, true, false]);
}
pub fn mcmeta_texture_section() void {
}
    // rust: let parse = TextureFlags::from_mcmeta;
    // rust: assert_eq!(
    // rust: parse(r#"{"texture":{"blur":true}}"#),
    // rust: Some(TextureFlags {
    // rust: blur: true,
    // rust: clamp: false
    // rust: })
    // rust: );
    // rust: assert_eq!(
    // rust: parse(r#"{"texture":{"clamp":true,"mipmap_strategy":"mean"}}"#),
    // rust: Some(TextureFlags {
    // rust: blur: false,
    // rust: clamp: true
    // rust: })
    // rust: );
        // Defaults (false, false) or no section: the default sampler.
    // rust: assert_eq!(parse(r#"{"texture":{"blur":false}}"#), None);
    // rust: assert_eq!(parse(r#"{"animation":{}}"#), None);
    // rust: assert_eq!(parse("not json"), None);
}
}
