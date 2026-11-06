//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_fog
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `FogRenderer` and its fog environments (atmospheric with rain fog, water
//! with water vision, lava, powder snow, blindness), the camera fog type
//! (`Camera.getFluidInCamera`) and the fog colour (`computeFogColor`: sunrise
//! tint, sky-colour mix, void darkness, water-vision brightening).
// use crate::{
    // rust: biome::Biomes,
    // rust: blocks::{BlockFacts, Fluid},
    // rust: camera::NearPlane,
    // rust: environment::Sky,
    // rust: world::World,
}
// use std::path::Path;

/// `FogType` of the camera position.
pub const FogType = enum {
    Atmospheric,
    Water,
    Lava,
    PowderSnow,
};

/// The fog uniform (`FogData`).
pub const FogData = struct {
    color: [f32,
    environmental_start: f32,
    environmental_end: f32,
    render_distance_start: f32,
    render_distance_end: f32,
    sky_end: f32,
    cloud_end: f32,
};

/// Per-biome water fog end multipliers (`visual/water_fog_end_distance`).
pub const FogTables = struct {
    water_fog_end: std.ArrayList(f32),
};
    // rust: impl FogTables {
pub fn load(root: *Path, biomes: *Biomes) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut water_fog_end = vec![1.0; biomes.list.len()];
    // rust: for (name, &id) in &biomes.index {
    // rust: let path = root.join(format!(
    // rust: "data/minecraft/worldgen/biome/{}.json",
    // rust: name.trim_start_matches("minecraft:")
    // rust: ));
    // rust: let Ok(bytes) = std::fs::read(path) else {
    // rust: continue;
}
    // rust: let Ok(json) = serde_json::from_slice::<serde_json::Value>(&bytes) else {
    // rust: continue;
}
    // rust: let v = &json["attributes"]["minecraft:visual/water_fog_end_distance"];
    // rust: if v["modifier"].as_str() == Some("multiply")
    // rust: && let (Some(f), Some(slot)) =
    // rust: (v["argument"].as_f64(), water_fog_end.get_mut(id as usize))
    // rust: {
    // rust: *slot = f as f32;
}
}
    // rust: Self { water_fog_end }
}
}

/// Fog state that evolves over time.
pub const FogState = struct {
    /// `LocalPlayer.waterVisionTime` (0..600).
    water_vision_time: i32,
    /// `AtmosphericFogEnvironment.rainFogMultiplier`.
    rain_fog_multiplier: f32,
    /// `LightmapRenderStateExtractor.blockLightFlicker`.
    block_light_flicker: f32,
    flicker_seed: u64,
};
    // rust: impl FogState {
pub fn next_float(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
        // splitmix64: the vanilla source is unseeded `RandomSource.create()`.
    // rust: self.flicker_seed = self.flicker_seed.wrapping_add(0x9E37_79B9_7F4A_7C15);
    // rust: let mut z = self.flicker_seed;
    // rust: z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
    // rust: z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
    // rust: ((z ^ (z >> 31)) >> 40) as f32 / (1u32 << 24) as f32
}
    /// `LightmapRenderStateExtractor.tick`: the torch light flickers.
pub fn tick_flicker(self: *Self) void {
}
    // rust: let (a, b, c, d) = (
    // rust: self.next_float(),
    // rust: self.next_float(),
    // rust: self.next_float(),
    // rust: self.next_float(),
    // rust: );
    // rust: self.block_light_flicker += (a - b) * c * d * 0.1;
    // rust: self.block_light_flicker *= 0.9;
}
    /// `LocalPlayer.aiStep`: water vision ramps up while the eye is in water.
pub fn tick(self: *Self, eye_in_water: bool) void {
}
    // rust: self.water_vision_time = if eye_in_water {
    // rust: (self.water_vision_time + 1).min(600)
    // rust: } else {
    // rust: (self.water_vision_time - 10).max(0)
}
}
    /// `LocalPlayer.getWaterVision`.
pub fn water_vision(self: *Self, eye_in_water: bool) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !eye_in_water {
    // rust: return 0.0;
}
    // rust: let t = self.water_vision_time as f32;
    // rust: if t >= 600.0 {
    // rust: return 1.0;
}
    // rust: let a = (t / 100.0).clamp(0.0, 1.0);
    // rust: let b = if t < 100.0 {
    // rust: 0.0
    // rust: } else {
    // rust: ((t - 100.0) / 500.0).clamp(0.0, 1.0)
}
    // rust: a * 0.6 + b * 0.399_999_98
}
}

/// `FluidState.getHeightForCamera`.
pub fn camera_fluid_height(world: *World, facts: *BlockFacts, b: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = facts.get(world.block(b[0], b[1], b[2]));
    // rust: if s.fluid == Fluid::None {
    // rust: return None;
}
    // rust: let above = facts.get(world.block(b[0], b[1] + 1, b[2]));
    // rust: let source = s.fluid_level >= 8 && !s.fluid_falling;
    // rust: let height = if (source && above.full_collision) || above.fluid == s.fluid {
    // rust: 1.0
    // rust: } else {
    // rust: f64::from(s.fluid_level) / 9.0
}
    // rust: Some((s.fluid, height))
}
/// `Camera.getFluidInCamera`: water at the camera, then lava or powder snow
/// at the near plane's centre and corners.
pub fn fog_type(world: *World, facts: *BlockFacts, camera: [f64; 3], near: *NearPlane) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: camera_fog_type(
    // rust: camera,
    // rust: near,
    // rust: |b| camera_fluid_height(world, facts, b),
    // rust: |b| &*facts.get(world.block(b[0], b[1], b[2])).name == "minecraft:powder_snow",
    // rust: )
}
/// `fog_type` over a block lookup: the fluid and its camera height, and
/// whether the block is powder snow.
    // rust: fn camera_fog_type(
    // rust: camera: [f64; 3],
    // rust: near: &NearPlane,
    // rust: fluid: impl Fn([i32; 3]) -> Option<(Fluid, f64)>,
    // rust: powder_snow: impl Fn([i32; 3]) -> bool,
    // rust: ) -> FogType {
    // rust: let block = |p: [f64; 3]| {
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]
}
    // rust: let b = block(camera);
    // rust: if let Some((Fluid::Water, h)) = fluid(b)
    // rust: && camera[1] < f64::from(b[1]) + h
    // rust: {
    // rust: return FogType::Water;
}
    // rust: for point in near.points() {
    // rust: let p: [f64; 3] = std::array::from_fn(|i| camera[i] + point[i]);
    // rust: let b = block(p);
    // rust: match fluid(b) {
    // rust: Some((Fluid::Lava, h)) if p[1] <= f64::from(b[1]) + h => return FogType::Lava,
    // rust: Some((Fluid::Lava, _)) => {}
    // rust: _ if powder_snow(b) => return FogType::PowderSnow,
    // rust: _ => {}
}
}
    // rust: FogType::Atmospheric
}

/// Everything `FogRenderer.setupFog` reads for one frame.
pub const FogInputs = struct {
    fog_type: FogType,
    sky: *'a Sky,
    /// Biome water fog colour (`visual/water_fog_color`).
    water_fog_color: [f32,
    biome: u16,
    render_distance_chunks: i32,
    /// Extend ordinary Overworld atmosphere for terrain beyond vanilla's range.
    distant_terrain: bool,
    /// The Cloud Distance option, in chunks.
    cloud_range_chunks: i32,
    camera_y: f64,
    min_y: i32,
    /// Flat worlds use a 1-block void darkness range.
    flat: bool,
    forward: [f32,
    rain: f32,
    thunder: f32,
    /// Dimensions with a sky disc (overworld): sunrise tint and sky mix apply.
    skybox: bool,
    /// Blindness: (remaining duration ticks, infinite).
    blindness: Option<(i32,
    /// The darkness effect's blend factor, while the effect is on.
    darkness: ?f32,
    /// `GameRenderer.bossOverlayWorldDarkening`: a wither's bar dims the fog.
    darken_world: f32,
    /// `BossHealthOverlay.shouldCreateWorldFog`: a boss bar with
    /// `createWorldFog` is shown (the Ender Dragon's).
    boss_world_fog: bool,
    /// The camera entity is a spectator (`LavaFogEnvironment`).
    spectator: bool,
    /// The camera entity has Fire Resistance (`LavaFogEnvironment`), or PvP & HUD's clear lava
    /// asks for its fog.
    fire_resistance: bool,
    /// PvP & HUD's clear water: the water vision `FogState` reaches after 600 ticks under water.
    full_water_vision: bool,
    /// `GameRenderer.nightVisionScale` while Night Vision is on without
    /// Darkness, else 0 (`FogRenderer.computeFogColor`'s brightenFactor).
    night_vision: f32,
};

/// `FogRenderer.setupFog` + `computeFogColor`.
pub fn setup_fog(tables: *FogTables, state: *FogState, input: *FogInputs) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rd = input.render_distance_chunks as f32 * 16.0;
    // rust: let sky = input.sky;
    // rust: let eye_in_water = input.fog_type == FogType::Water;
    // rust: let water_vision = if input.full_water_vision && eye_in_water {
    // rust: 1.0
    // rust: } else {
    // rust: state.water_vision(eye_in_water)
}
    // Base colour of the applicable environment.
    // rust: let mut color = match input.fog_type {
    // rust: FogType::Lava => rgb(0x99_1A00),
    // rust: FogType::PowderSnow => rgb(0x9F_BACC),
    // rust: FogType::Water => input.water_fog_color,
    // rust: FogType::Atmospheric => {
    // rust: let mut fog = sky.fog_color;
    // rust: if input.skybox && input.render_distance_chunks >= 4 {
    // rust: let sun_x = if sky.sun_angle.to_radians().sin() > 0.0 {
    // rust: -1.0
    // rust: } else {
    // rust: 1.0
}
    // rust: let looking = input.forward[0] * sun_x;
    // rust: let alpha = sky.sunrise_color[3];
    // rust: if looking > 0.0 && alpha > 0.0 {
    // rust: let t = looking * alpha;
    // rust: fog = std::array::from_fn(|i| fog[i] + (sky.sunrise_color[i] - fog[i]) * t);
}
}
    // rust: let mut sky_color = sky.sky_color;
    // rust: if input.rain > 0.0 {
    // rust: let m = 1.0 - input.rain * 0.5;
    // rust: let mb = 1.0 - input.rain * 0.4;
    // rust: sky_color = [sky_color[0] * m, sky_color[1] * m, sky_color[2] * mb];
}
    // rust: if input.thunder > 0.0 {
    // rust: let m = 1.0 - input.thunder * 0.5;
    // rust: sky_color = sky_color.map(|c| c * m);
}
    // rust: let sky_fog_end = (512.0f32 / 16.0).min(input.render_distance_chunks as f32);
    // rust: let mix = (sky_fog_end / 32.0).clamp(0.0, 1.0).mul_add(0.75, 0.25);
    // rust: let mix = 1.0 - mix.powf(0.25);
    // rust: std::array::from_fn(|i| fog[i] + (sky_color[i] - fog[i]) * mix)
}
}
    // Void darkness and blindness.
    // rust: let range = if input.flat { 1.0 } else { 32.0 };
    // rust: let mut darkness =
    // rust: ((range + input.min_y as f32 - input.camera_y as f32) / range).clamp(0.0, 1.0);
    // rust: if let Some((duration, infinite)) = input.blindness {
    // rust: darkness = if !infinite && duration < 20 {
    // rust: darkness.max(duration as f32 / 20.0)
    // rust: } else {
    // rust: 1.0
}
    // rust: } else if let Some(blend) = input.darkness {
        // DarknessFogEnvironment.getModifiedDarkness.
    // rust: darkness = darkness.max(blend);
}
    // rust: if darkness > 0.0 && !matches!(input.fog_type, FogType::Lava | FogType::PowderSnow) {
    // rust: let brightness = (1.0 - darkness) * (1.0 - darkness);
    // rust: color = color.map(|c| c * brightness);
}
    // FogRenderer.computeFogColor: a boss bar's world darkening.
    // rust: if input.darken_world > 0.0 {
    // rust: let t = input.darken_world;
    // rust: color[0] += (color[0] * 0.7 - color[0]) * t;
    // rust: color[1] += (color[1] * 0.6 - color[1]) * t;
    // rust: color[2] += (color[2] * 0.6 - color[2]) * t;
}
    // rust: let brighten = if eye_in_water {
    // rust: water_vision
    // rust: } else {
    // rust: input.night_vision
}
    // rust: if color.iter().all(|&c| c != 0.0) {
    // rust: let scale = 1.0 / color[0].max(color[1]).max(color[2]);
    // rust: color = color.map(|c| c + (c * scale - c) * brighten);
}
    // rust: let mut fog = FogData {
    // rust: color: [color[0], color[1], color[2], 1.0],
    // rust: environmental_start: 0.0,
    // rust: environmental_end: 1024.0,
    // rust: render_distance_start: 0.0,
    // rust: render_distance_end: rd,
    // rust: sky_end: rd.min(512.0),
    // rust: cloud_end: 2048.0,
}
    // rust: match input.fog_type {
    // rust: FogType::Lava => {
            // LavaFogEnvironment.setupFog.
    // rust: (fog.environmental_start, fog.environmental_end) = if input.spectator {
    // rust: (-8.0, rd * 0.5)
    // rust: } else if input.fire_resistance {
    // rust: (0.0, 5.0)
    // rust: } else {
    // rust: (0.25, 1.0)
}
    // rust: fog.sky_end = fog.environmental_end;
    // rust: fog.cloud_end = fog.environmental_end;
}
    // rust: FogType::PowderSnow => {
            // PowderedSnowFogEnvironment.setupFog.
    // rust: (fog.environmental_start, fog.environmental_end) = if input.spectator {
    // rust: (-8.0, rd * 0.5)
    // rust: } else {
    // rust: (0.0, 2.0)
}
    // rust: fog.sky_end = fog.environmental_end;
    // rust: fog.cloud_end = fog.environmental_end;
}
    // rust: _ if input.blindness.is_some() => {
    // rust: let (duration, infinite) = input.blindness.unwrap_or((0, true));
    // rust: let distance = if infinite {
    // rust: 5.0
    // rust: } else {
    // rust: rd + (5.0 - rd) * (duration as f32 / 20.0).min(1.0)
}
    // rust: fog.environmental_start = distance * 0.25;
    // rust: fog.environmental_end = distance;
    // rust: fog.sky_end = distance * 0.8;
    // rust: fog.cloud_end = distance * 0.8;
}
    // rust: _ if input.darkness.is_some() => {
            // DarknessFogEnvironment.setupFog: closing in to 15 blocks.
    // rust: let blend = input.darkness.unwrap_or(0.0);
    // rust: let distance = rd + (15.0 - rd) * blend;
    // rust: fog.environmental_start = distance * 0.75;
    // rust: fog.environmental_end = distance;
    // rust: fog.sky_end = distance;
    // rust: fog.cloud_end = distance;
}
    // rust: FogType::Water => {
    // rust: fog.environmental_start = -8.0;
    // rust: let factor = tables
    // rust: .water_fog_end
    // rust: .get(input.biome as usize)
    // rust: .copied()
    // rust: .unwrap_or(1.0);
    // rust: fog.environmental_end = 96.0 * factor * water_vision.max(0.25);
    // rust: fog.sky_end = fog.environmental_end;
    // rust: fog.cloud_end = fog.environmental_end;
}
    // rust: FogType::Atmospheric => {
    // rust: fog.environmental_start = sky.fog_start + -160.0 * state.rain_fog_multiplier;
    // rust: let min_end = sky.fog_end.min(96.0);
    // rust: fog.environmental_end = min_end.max(sky.fog_end + -256.0 * state.rain_fog_multiplier);
    // rust: fog.sky_end = rd.min(512.0);
    // rust: fog.cloud_end = ((input.cloud_range_chunks * 16) as f32).min(sky.cloud_fog_end);
    // rust: if input.boss_world_fog {
    // rust: fog.environmental_start = fog.environmental_start.min(10.0);
    // rust: fog.environmental_end = fog.environmental_end.min(96.0);
    // rust: fog.sky_end = fog.environmental_end;
    // rust: fog.cloud_end = fog.environmental_end;
}
}
}
    // rust: let span = (rd / 10.0).clamp(4.0, 64.0);
    // rust: fog.render_distance_start = rd - span;
    // rust: fog.render_distance_end = rd;
    // rust: if input.distant_terrain
    // rust: && input.skybox
    // rust: && input.fog_type == FogType::Atmospheric
    // rust: && input.blindness.is_none()
    // rust: && input.darkness.is_none()
    // rust: && !input.boss_world_fog
    // rust: && sky.fog_end >= 1024.0
    // rust: {
    // rust: let scale = (rd / 1024.0).max(1.0);
    // rust: fog.environmental_start *= scale;
    // rust: fog.environmental_end *= scale;
}
    // rust: fog
}
/// Horizon's Fog option turned off (`horizon-graphics.txt` `fog:false`):
/// no distance fog, in any dimension: the dimension's and biome's own fog
/// (`visual/fog_start_distance`, `fog_end_distance`: the Nether's ends at 96
/// blocks) and the render-distance fog. The fog of the fluid or powder snow
/// the camera is in, blindness, darkness and a boss's world fog keep their
/// limits. Vanilla has no such option.
pub fn clear_distance_fog(fog: *mut FogData, input: *FogInputs) void {
}
    // rust: if input.fog_type == FogType::Atmospheric
    // rust: && input.darkness.is_none()
    // rust: && !input.boss_world_fog
    // rust: && input.blindness.is_none()
    // rust: {
    // rust: (fog.render_distance_start, fog.render_distance_end) = (1e9, 2e9);
    // rust: (fog.environmental_start, fog.environmental_end) = (1e9, 2e9);
}
}
/// `AtmosphericFogEnvironment.updateRainFogState`.
    // rust: pub fn update_rain_fog(
    // rust: state: &mut FogState,
    // rust: rain: f32,
    // rust: sky_light: u8,
    // rust: biome_rains: bool,
    // rust: delta_ticks: f32,
    // rust: ) {
    // rust: let sky = ((f32::from(sky_light) - 8.0) / 7.0).clamp(0.0, 1.0);
    // rust: let target = rain * sky * if biome_rains { 1.0 } else { 0.5 };
    // rust: state.rain_fog_multiplier += (target - state.rain_fog_multiplier) * delta_ticks * 0.2;
}
pub fn rgb(c: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: (c >> 16 & 255) as f32 / 255.0,
    // rust: (c >> 8 & 255) as f32 / 255.0,
    // rust: (c & 255) as f32 / 255.0,
    // rust: ]
}

    // rust: mod tests {
//     use super::*;
pub fn inputs(sky: *Sky) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FogInputs {
    // rust: fog_type: FogType::Atmospheric,
    // rust: sky,
    // rust: water_fog_color: [0.0, 0.0, 0.2],
    // rust: biome: 0,
    // rust: render_distance_chunks: 12,
    // rust: distant_terrain: false,
    // rust: cloud_range_chunks: 128,
    // rust: camera_y: 70.0,
    // rust: min_y: -64,
    // rust: flat: false,
    // rust: forward: [0.0, 0.0, 1.0],
    // rust: rain: 0.0,
    // rust: thunder: 0.0,
    // rust: skybox: true,
    // rust: blindness: None,
    // rust: darkness: None,
    // rust: darken_world: 0.0,
    // rust: boss_world_fog: false,
    // rust: spectator: false,
    // rust: fire_resistance: false,
    // rust: full_water_vision: false,
    // rust: night_vision: 0.0,
}
}
pub fn lava_fog_starts_when_a_near_plane_corner_dips_under_the_surface() void {
}
        // Flowing lava (amount 4) on y 64: the camera sees its surface at 64 + 4/9.
    // rust: let surface = 64.0 + 4.0 / 9.0;
    // rust: let fluid = |b: [i32; 3]| (b[1] == 64).then_some((Fluid::Lava, 4.0 / 9.0));
    // rust: let fog = |y: f64, pitch: f32| {
    // rust: let mut camera = crate::camera::Camera::default();
    // rust: camera.set_rotation(0.0, pitch);
    // rust: let near = camera.near_plane(70.0, 1600.0, 900.0);
    // rust: camera_fog_type([0.5, y, 0.5], &near, fluid, |_| false)
}
        // Looking level, the near plane reaches tan(35 degrees) * 0.05 = 0.035 below the eye.
    // rust: assert_eq!(fog(surface + 0.02, 0.0), FogType::Lava);
    // rust: assert_eq!(fog(surface + 0.05, 0.0), FogType::Atmospheric);
        // The eye itself is not tested: looking up, the whole plane is above it.
    // rust: assert_eq!(fog(surface - 0.01, -90.0), FogType::Atmospheric);
}
pub fn boss_world_fog_closes_in() void {
}
        // AtmosphericFogEnvironment.setupFog under a createWorldFog boss bar.
    // rust: let sky = Sky {
    // rust: fog_end: 1024.0,
    // rust: cloud_fog_end: 2048.0,
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let mut input = inputs(&sky);
    // rust: input.boss_world_fog = true;
    // rust: let fog = setup_fog(&tables, &FogState::default(), &input);
    // rust: assert_eq!(
    // rust: (fog.environmental_start, fog.environmental_end),
    // rust: (0.0, 96.0)
    // rust: );
    // rust: assert_eq!((fog.sky_end, fog.cloud_end), (96.0, 96.0));
        // Under water the water environment applies instead.
    // rust: input.fog_type = FogType::Water;
    // rust: let water = setup_fog(&tables, &FogState::default(), &input);
    // rust: assert_eq!(water.environmental_start, -8.0);
}
pub fn fog_off_clears_the_nether_fog_too() void {
}
        // The Nether's visual/fog_start_distance and fog_end_distance (10, 96)
        // end before the render distance; the Fog option still clears them.
    // rust: let nether = Sky {
    // rust: fog_start: 10.0,
    // rust: fog_end: 96.0,
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let mut input = inputs(&nether);
    // rust: input.skybox = false;
    // rust: let mut fog = setup_fog(&tables, &FogState::default(), &input);
    // rust: assert_eq!(fog.environmental_end, 96.0);
    // rust: clear_distance_fog(&mut fog, &input);
    // rust: assert!(fog.environmental_start >= 1e9 && fog.render_distance_start >= 1e9);
}
pub fn fog_off_keeps_fluid_and_effect_fog() void {
}
    // rust: let sky = Sky {
    // rust: fog_start: 10.0,
    // rust: fog_end: 96.0,
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let kept = |input: &FogInputs| {
    // rust: let mut fog = setup_fog(&tables, &FogState::default(), input);
    // rust: let before = fog;
    // rust: clear_distance_fog(&mut fog, input);
    // rust: fog == before
}
    // rust: for fog_type in [FogType::Lava, FogType::PowderSnow, FogType::Water] {
    // rust: let mut input = inputs(&sky);
    // rust: input.fog_type = fog_type;
    // rust: assert!(kept(&input), "{fog_type:?}");
}
    // rust: let mut input = inputs(&sky);
    // rust: input.blindness = Some((100, false));
    // rust: assert!(kept(&input));
    // rust: let mut input = inputs(&sky);
    // rust: input.darkness = Some(0.5);
    // rust: assert!(kept(&input));
    // rust: let mut input = inputs(&sky);
    // rust: input.boss_world_fog = true;
    // rust: assert!(kept(&input));
}
pub fn boss_darkening_dims_fog_color() void {
}
        // FogRenderer.computeFogColor: lerp toward 70/60/60% of each channel.
    // rust: let sky = Sky {
    // rust: fog_color: [1.0, 1.0, 1.0],
    // rust: sky_color: [1.0, 1.0, 1.0],
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let mut input = inputs(&sky);
    // rust: input.skybox = false;
    // rust: input.darken_world = 1.0;
    // rust: let fog = setup_fog(&tables, &FogState::default(), &input);
    // rust: assert!((fog.color[0] - 0.7).abs() < 1.0e-5);
    // rust: assert!((fog.color[1] - 0.6).abs() < 1.0e-5);
    // rust: assert!((fog.color[2] - 0.6).abs() < 1.0e-5);
}
pub fn void_darkness_starts_32_above_the_floor() void {
}
    // rust: let sky = Sky {
    // rust: fog_end: 1024.0,
    // rust: fog_color: [0.5; 3],
    // rust: sky_color: [0.5; 3],
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let mut input = inputs(&sky);
        // The End's floor is y 0: y 16 is halfway into the darkness.
    // rust: input.min_y = 0;
    // rust: input.camera_y = 16.0;
    // rust: let fog = setup_fog(&tables, &FogState::default(), &input);
    // rust: assert_eq!(fog.color[0], 0.5 * 0.25);
    // rust: input.camera_y = 32.0;
    // rust: assert_eq!(
    // rust: setup_fog(&tables, &FogState::default(), &input).color[0],
    // rust: 0.5
    // rust: );
}
pub fn render_distance_fog_span() void {
}
    // rust: let sky = Sky {
    // rust: fog_end: 1024.0,
    // rust: fog_color: [0.5; 3],
    // rust: sky_color: [0.5; 3],
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let fog = setup_fog(&tables, &FogState::default(), &inputs(&sky));
        // 12 chunks = 192 blocks, span clamp(19.2, 4, 64).
    // rust: assert!((fog.render_distance_start - (192.0 - 19.2)).abs() < 1e-4);
    // rust: assert_eq!(fog.render_distance_end, 192.0);
    // rust: assert_eq!(fog.sky_end, 192.0);
}
pub fn distant_atmosphere_extends_without_extending_environmental_overrides() void {
}
    // rust: let sky = Sky {
    // rust: fog_end: 1024.,
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.],
}
    // rust: let mut input = inputs(&sky);
    // rust: input.render_distance_chunks = 1024;
    // rust: input.distant_terrain = true;
    // rust: let fog = setup_fog(&tables, &FogState::default(), &input);
    // rust: assert_eq!(fog.environmental_end, 16384.);
    // rust: input.fog_type = FogType::Water;
    // rust: assert_eq!(
    // rust: setup_fog(&tables, &FogState::default(), &input).environmental_end,
    // rust: 24.
    // rust: );
    // rust: input.fog_type = FogType::Atmospheric;
    // rust: input.darkness = Some(1.);
    // rust: assert_eq!(
    // rust: setup_fog(&tables, &FogState::default(), &input).environmental_end,
    // rust: 15.
    // rust: );
    // rust: input.darkness = None;
    // rust: input.boss_world_fog = true;
    // rust: assert_eq!(
    // rust: setup_fog(&tables, &FogState::default(), &input).environmental_end,
    // rust: 96.
    // rust: );
}
pub fn cloud_fog_ends_at_the_cloud_distance() void {
}
    // rust: let sky = Sky {
    // rust: fog_end: 1024.0,
    // rust: cloud_fog_end: 2048.0,
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let mut input = inputs(&sky);
    // rust: input.render_distance_chunks = 2;
    // rust: input.cloud_range_chunks = 64;
    // rust: assert_eq!(
    // rust: setup_fog(&tables, &FogState::default(), &input).cloud_end,
    // rust: 1024.0
    // rust: );
    // rust: input.cloud_range_chunks = 128;
    // rust: assert_eq!(
    // rust: setup_fog(&tables, &FogState::default(), &input).cloud_end,
    // rust: 2048.0
    // rust: );
}
pub fn water_vision_ramps() void {
}
    // rust: let mut s = FogState::default();
    // rust: for _ in 0..100 {
    // rust: s.tick(true);
}
    // rust: assert!((s.water_vision(true) - 0.6).abs() < 1e-6);
    // rust: for _ in 0..500 {
    // rust: s.tick(true);
}
    // rust: assert_eq!(s.water_vision(true), 1.0);
    // rust: assert_eq!(s.water_vision(false), 0.0);
}
pub fn clear_water_sees_as_far_as_after_thirty_seconds_under_water() void {
}
    // rust: let sky = Sky::default();
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let mut input = inputs(&sky);
    // rust: input.fog_type = FogType::Water;
        // Just in: vanilla's water vision is 0, so the fog ends at a quarter of 96 blocks.
    // rust: let mut state = FogState::default();
    // rust: state.tick(true);
    // rust: let first = setup_fog(&tables, &state, &input);
    // rust: assert_eq!(first.environmental_end, 24.0);
    // rust: for _ in 0..600 {
    // rust: state.tick(true);
}
    // rust: let settled = setup_fog(&tables, &state, &input);
    // rust: assert_eq!(settled.environmental_end, 96.0);
    // rust: input.full_water_vision = true;
    // rust: let mut fresh = FogState::default();
    // rust: fresh.tick(true);
    // rust: let clear = setup_fog(&tables, &fresh, &input);
    // rust: assert_eq!(clear.environmental_end, settled.environmental_end);
    // rust: assert_eq!(clear.color, settled.color);
}
pub fn rain_fog_pulls_fog_in() void {
}
    // rust: let sky = Sky {
    // rust: fog_end: 1024.0,
    // rust: ..Sky::default()
}
    // rust: let tables = FogTables {
    // rust: water_fog_end: vec![1.0],
}
    // rust: let state = FogState {
    // rust: rain_fog_multiplier: 1.0,
    // rust: ..FogState::default()
}
    // rust: let fog = setup_fog(&tables, &state, &inputs(&sky));
    // rust: assert_eq!(fog.environmental_start, -160.0);
    // rust: assert_eq!(fog.environmental_end, 768.0);
}
}
