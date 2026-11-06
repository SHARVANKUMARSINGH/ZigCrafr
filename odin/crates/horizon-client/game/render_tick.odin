//! Transpiled from Horizon Rust crate
package horizon_client_render_tick

import "core:fmt"
import "core:mem"
import "core:math"

// Per-tick client visuals: the particle engine, `ClientLevel.animateTick`,
// campfire smoke and rain splashes (`ClientLevel.tickWeatherEffects`).
// use super::{Dim, Game};
// use horizon_client::assets::Properties;
// use horizon_client::camera::NearPlane;
// use horizon_client::fog::{FogData, FogInputs, FogType, fog_type, update_rain_fog};
// use horizon_client::{
    // rust: animate_tick::{AnimateContext, animate_tick, campfire_particles, marker_particle_target},
    // rust: biome::Biomes,
    // rust: blocks::{BlockFacts, Fluid},
    // rust: containers::BlockEntity,
    // rust: particles::{ParticleLevel, ParticleOptions, ParticleType},
    // rust: world::World,
}
// use horizon_client::{
    // rust: hud_overlays,
    // rust: screen_effects::{ScreenInputs, ScreenQuad, lightmap_brightness, nausea_has_effect},
}
// use horizon_core::random::{LegacyRandom, RandomSource};
// use horizon_world::{heightmap::HeightmapType, worldgen::terrain::TerrainBlockStates};

// `getHeight(Heightmap.Types.MOTION_BLOCKING, x, z)` from the chunk's
// heightmap: one above the highest block in `blocks_motion_in_heightmap` or
// holding a fluid, however far above the camera it is.
    // rust: pub(super) fn motion_blocking_height(
    // rust: world: &World,
    // rust: properties: &Properties,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> i32 {
    // rust: world.motion_blocking(x, z, |s| {
    // rust: HeightmapType::MotionBlocking.is_opaque(properties.heightmap_state(s))
    // rust: })
}
// `ClientLevel.tickWeatherEffects`: the MOTION_BLOCKING height of the column
// `x`, `z` when a rain splash may land on it for a camera in block row `y`,
// that is above the world's bottom and within 10 blocks of the camera.
splash_height :: proc(world: ^World, properties: ^Properties, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let top = motion_blocking_height(world, properties, x, z);
    // rust: (top > world.bottom_y() && (y - 10..=y + 10).contains(&top)).then_some(top)
}
// The first block at or below `from` that blocks motion (leaves only when
// `leaves`, as MOTION_BLOCKING_NO_LEAVES skips them) or holds a fluid, plus one.
    // rust: fn motion_blocking_leaves(
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: x: i32,
    // rust: z: i32,
    // rust: from: i32,
    // rust: leaves: bool,
    // rust: ) -> i32 {
    // rust: let mut y = from.min(world.top_y() - 1);
    // rust: while y > world.bottom_y() {
    // rust: let f = facts.get(world.block(x, y, z));
        // #minecraft:leaves block motion, but MOTION_BLOCKING_NO_LEAVES skips them
        // (their water still counts).
    // rust: let blocks = if f.name.ends_with("_leaves") {
    // rust: leaves
    // rust: } else {
    // rust: f.full_collision
}
    // rust: if blocks || f.fluid != Fluid::None {
    // rust: return y + 1;
}
    // rust: y -= 1;
}
    // rust: world.bottom_y()
}
// `Biome.getPrecipitationAt` is rain (not snow) at this position.
rains_at :: proc(world: ^World, biomes: ^Biomes, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(chunk) = world.chunks.get(&(x >> 4, z >> 4)) else {
    // rust: return false;
}
    // rust: biomes.get(chunk.biome(x, y, z)).snows_at(x, y, z) == Some(false)
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn forward(&self) -> [f64; 3] {
    // rust: let (yaw, pitch) = (
    // rust: f64::from(self.yaw).to_radians(),
    // rust: f64::from(self.pitch).to_radians(),
    // rust: );
    // rust: [
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: ]
}
    // `Camera.getNearPlane` at the FOV option, as `getFluidInCamera` asks for it.
    // rust: pub(super) fn near_plane(&self) -> NearPlane {
    // rust: let [width, height] = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: self.view.near_plane(
    // rust: self.settings.fov as i32 as f32,
    // rust: width as f32,
    // rust: height.max(1) as f32,
    // rust: )
}
    // `FogRenderer.setupFog` for the frame's camera, and Horizon's Fog option.
    // rust: pub(super) fn frame_fog(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: sky: &horizon_client::environment::Sky,
    // rust: biome: u16,
    // rust: water_fog_color: [f32; 3],
    // rust: ) -> FogData {
    // rust: let forward = self.forward();
    // rust: let at = [camera.x, camera.y, camera.z];
    // rust: let fog_type = fog_type(&self.world, self.res.facts(), at, &self.near_plane());
    // rust: let (rain, thunder) = self.view_weather(self.clock.fraction() as f32);
    // rust: let title_fog = horizon_client::fog::FogTables::default();
    // rust: let tables = if self.title.is_some() {
    // rust: &title_fog
    // rust: } else {
    // rust: self.res.fog()
}
    // rust: let input = FogInputs {
    // rust: fog_type,
    // rust: sky,
    // rust: water_fog_color,
    // rust: biome,
    // rust: render_distance_chunks: self.terrain_distance(),
    // rust: distant_terrain: self.lod.is_some(),
    // rust: cloud_range_chunks: self.settings.cloud_range,
    // rust: camera_y: camera.y,
    // rust: min_y: self.level_min_y(),
    // rust: flat: self.level_flat(),
    // rust: forward: forward.map(|c| c as f32),
    // rust: rain,
    // rust: thunder,
    // rust: skybox: self.dim == Dim::Overworld,
    // rust: blindness: self
    // rust: .potions
    // rust: .effects
    // rust: .get("blindness")
    // rust: .map(|effect| (effect.duration, effect.duration == -1)),
    // rust: darkness: self.darkness_fog(),
    // rust: darken_world: self
    // rust: .boss_overlay
    // rust: .darken_amount(self.clock.fraction() as f32),
    // rust: boss_world_fog: self.boss_overlay.should_create_world_fog(),
    // rust: spectator: self.spectator(),
    // rust: fire_resistance: self.potions.effects.get("fire_resistance").is_some()
    // rust: || self.settings.extras.pvp.tweaks.clear_lava,
    // rust: full_water_vision: self.settings.extras.pvp.tweaks.clear_water,
    // rust: night_vision: self.fog_night_vision(),
}
    // rust: let mut fog = horizon_client::fog::setup_fog(tables, &self.fog, &input);
    // rust: if !self.settings.horizon.fog {
    // rust: horizon_client::fog::clear_distance_fog(&mut fog, &input);
}
    // rust: if self.title.is_none() {
    // rust: fog.color =
    // rust: self.native_fog_color_now(self.clock.fraction() as f32, at, fog_type, fog.color);
    // rust: fog = self.native_fog_now(self.clock.fraction() as f32, at, fog_type, fog);
}
    // rust: fog
}
    // rust: fn native_fog_color_now(
    // rust: &self,
    // rust: partial: f32,
    // rust: camera: [f64; 3],
    // rust: fog_type: FogType,
    // rust: color: [f32; 4],
    // rust: ) -> [f32; 4] {
    // rust: let mut rgb = [color[0], color[1], color[2]];
    // rust: self.native_compute_fog_color(partial, camera, fog_type, &mut rgb);
    // rust: if rgb.iter().all(|v| v.is_finite() && (0.0..=1.0).contains(v)) {
    // rust: [rgb[0], rgb[1], rgb[2], color[3]]
    // rust: } else {
    // rust: color
}
}
    // rust: fn native_fog_now(
    // rust: &self,
    // rust: partial: f32,
    // rust: camera: [f64; 3],
    // rust: fog_type: FogType,
    // rust: original: FogData,
    // rust: ) -> FogData {
    // rust: let mut fog = original;
    // rust: self.native_render_fog(partial, camera, fog_type, &mut fog);
    // rust: let distances = [
    // rust: fog.environmental_start,
    // rust: fog.environmental_end,
    // rust: fog.render_distance_start,
    // rust: fog.render_distance_end,
    // rust: fog.sky_end,
    // rust: fog.cloud_end,
    // rust: ];
    // rust: if fog
    // rust: .color
    // rust: .iter()
    // rust: .all(|v| v.is_finite() && (0.0..=1.0).contains(v))
    // rust: && distances.iter().all(|v| v.is_finite())
    // rust: && fog.environmental_end > fog.environmental_start
    // rust: && fog.render_distance_end > fog.render_distance_start
    // rust: && fog.sky_end >= 0.0
    // rust: && fog.cloud_end >= 0.0
    // rust: {
    // rust: fog
    // rust: } else {
    // rust: original
}
}
    // `FogRenderer.computeFogColor`'s night vision brightenFactor:
    // `GameRenderer.nightVisionScale`, but not while Darkness is on.
fog_night_vision :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let partial = self.clock.fraction() as f32;
    // rust: match self.potions.effects.get("night_vision") {
    // rust: Some(e) if self.potions.effects.get("darkness").is_none() => {
                // MobEffectInstance.endsWithin(200); -1 is infinite.
    // rust: if e.duration < 0 || e.duration > 200 {
    // rust: 1.0
    // rust: } else {
    // rust: 0.7 + ((e.duration as f32 - partial) * std::f32::consts::PI * 0.2).sin() * 0.3
}
}
    // rust: _ => 0.0,
}
}
    // `ClientLevelData.isFlat`: on the server thread, the world-wide flag.
level_flat :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.remote.as_ref() {
    // rust: Some(r) => r.flat,
    // rust: None => self.world_flat,
}
}
    // `Level.getMinY`: the current dimension type's minimum y.
level_min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self.remote.as_ref() {
    // rust: Some(r) => r.dimension.min_y,
    // rust: None => self.world.shape.min_y,
}
}
    // `SkyRenderer.shouldRenderDarkDisc`: eye below the horizon and not under
    // water. `ClientLevelData.getHorizonHeight`: the bottom of a flat world,
    // otherwise y 63.
    // rust: pub(super) fn dark_disc(&self, camera: glam::DVec3) -> bool {
    // rust: let horizon = if self.level_flat() {
    // rust: f64::from(self.level_min_y())
    // rust: } else {
    // rust: 63.0
}
    // rust: self.dim == Dim::Overworld
    // rust: && camera.y < horizon
    // rust: && fog_type(
    // rust: &self.world,
    // rust: self.res.facts(),
    // rust: [camera.x, camera.y, camera.z],
    // rust: &self.near_plane(),
    // rust: ) != FogType::Water
}
    // `ScreenEffectRenderer` + `Hud` camera overlays for this frame.
    // `scale` is the player's `LivingEntity.getScale`.
    // rust: pub(super) fn screen_quads(&self, partial: f32, size: [u32; 2], scale: f32) -> Vec<ScreenQuad> {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return Vec::new();
}
    // rust: let eye = [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.eye_height),
    // rust: p.position.z,
    // rust: ];
        // `LevelExtractor.getViewBlockingState`: 8 points around the eye, each
        // tested with `BlockState.isViewBlocking` against the near plane.
        // ScreenEffectRenderer: none of it for a spectator (noPhysics).
    // rust: let spectator = self.spectator();
    // rust: let mut block_overlay = None;
    // rust: if !spectator {
            // Frustum.getNearPlaneBounds, moved to the eye.
    // rust: let (near_min, near_max) = horizon_client::camera::near_plane_bounds(
    // rust: self.fov_degrees(partial, eye),
    // rust: size[0] as f32,
    // rust: size[1] as f32,
    // rust: self.yaw,
    // rust: self.pitch,
    // rust: horizon_client::camera::depth_far(
    // rust: self.terrain_distance(),
    // rust: self.settings.cloud_range,
    // rust: ),
    // rust: );
    // rust: let near_plane = horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(
    // rust: near_min[0] + eye[0],
    // rust: near_min[1] + eye[1],
    // rust: near_min[2] + eye[2],
    // rust: ),
    // rust: horizon_core::geometry::Vec3::new(
    // rust: near_max[0] + eye[0],
    // rust: near_max[1] + eye[1],
    // rust: near_max[2] + eye[2],
    // rust: ),
    // rust: );
            // The test points use float maths: `(i % 2 - 0.5F) * width * 0.8F`.
            // The height spread is `0.1F * getScale()`: a tiny player's eye is
            // closer to the ground than 0.05.
    // rust: let width = p.dimensions.width;
    // rust: for i in 0..8 {
    // rust: let t = [
    // rust: p.position.x + f64::from(((i & 1) as f32 - 0.5) * width * 0.8),
    // rust: p.position.y
    // rust: + f64::from(p.dimensions.eye_height)
    // rust: + f64::from((((i >> 1) & 1) as f32 - 0.5) * 0.1 * scale),
    // rust: p.position.z + f64::from((((i >> 2) & 1) as f32 - 0.5) * width * 0.8),
    // rust: ];
    // rust: let pos = [
    // rust: t[0].floor() as i32,
    // rust: t[1].floor() as i32,
    // rust: t[2].floor() as i32,
    // rust: ];
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.res.facts().get(state).render_shape
    // rust: != horizon_client::blocks::RenderShape::Invisible
    // rust: && self.state_view_blocking(state, pos, near_plane)
    // rust: {
                    // ScreenEffectRenderer: the block's particle material.
    // rust: block_overlay = Self::block_particle_sprite(&self.pack, state);
    // rust: break;
}
}
}
    // rust: let in_water =
    // rust: fog_type(&self.world, self.res.facts(), eye, &self.near_plane()) == FogType::Water;
    // rust: let water =
    // rust: (in_water && !spectator).then(|| (self.eye_brightness(eye), self.yaw, self.pitch));
        // Hud.extractCameraOverlays; the spyglass scope (and its easing) is
        // drawn on the HUD by draw_spyglass.
    // rust: let fx = &self.screen_fx;
    // rust: let overlays = hud_overlays::CameraOverlays {
    // rust: vignette: self.vignette_shown().then_some((
    // rust: fx.vignette_brightness,
    // rust: self.border.warning_strength(p.position.x, p.position.z),
    // rust: )),
    // rust: first_person: self.camera_type.first_person(),
    // rust: scoping: self.scoping(),
    // rust: game_time_delta: 0.0,
    // rust: equipment: match &self.armor[0] {
    // rust: Some(stack) if &*stack.item == "minecraft:carved_pumpkin" => {
    // rust: vec!["misc/pumpkinblur".to_owned()]
}
    // rust: _ => Vec::new(),
    // rust: },
    // rust: ticks_frozen: p.ticks_frozen,
    // rust: percent_frozen: p.percent_frozen(),
    // rust: partial,
    // rust: portal: [fx.o_portal, fx.portal],
    // rust: nausea: self.nausea_blend(partial),
    // rust: screen_effect_scale: self.screen_effect_scale(),
}
    // rust: let mut scope = self.scope_scale;
    // rust: let gui_overlays =
    // rust: hud_overlays::camera_overlays(size[0] as i32, size[1] as i32, &overlays, &mut scope);
    // rust: self.screen_fx.build(&ScreenInputs {
    // rust: sprites: &self.gui.atlas.sprites,
    // rust: flags: &self.gui.atlas.flags,
    // rust: aspect: size[0] as f32 / size[1].max(1) as f32,
    // rust: partial,
    // rust: block_overlay,
    // rust: water,
    // rust: on_fire: self.camera_type.first_person()
    // rust: && !self.spectator()
    // rust: && self.player.as_ref().is_some_and(|p| p.fire_ticks > 0),
    // rust: fire_lower: f32::from(self.settings.extras.pvp.tweaks.fire_lower) / 100.0,
    // rust: gui_overlays: &gui_overlays,
    // rust: })
}
    // `Lightmap.getBrightness(getMaxLocalRawBrightness(eye))`.
eye_brightness :: proc(self: ^Self, eye: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let b = [
    // rust: eye[0].floor() as i32,
    // rust: eye[1].floor() as i32,
    // rust: eye[2].floor() as i32,
    // rust: ];
    // rust: let packed = self.world.light(b[0], b[1], b[2]);
    // rust: let sky = i32::from(packed >> 4) - self.sky_darken();
    // rust: let raw = sky.max(i32::from(packed & 15)).clamp(0, 15) as u8;
    // rust: lightmap_brightness(if self.dim == Dim::Nether { 0.1 } else { 0.0 }, raw)
}
    // What `Minecraft` ticks outside the level's own tick: `GameRenderer.tick` runs the light
    // flicker whenever the game is not paused, frozen or not, while `TextureManager.tick`
    // needs the level running normally. `HORIZON_STILL` keeps both with the world.
    // rust: pub(super) fn tick_frame_visuals(&mut self, running: bool) {
    // rust: if running || !self.clock.still() {
    // rust: self.fog.tick_flicker();
}
    // rust: if running {
    // rust: self.texture_ticks += 1;
}
}
    // rust: pub(super) fn tick_particles(&mut self) {
    // rust: let eye = self.eye_position();
    // rust: if let Some(e) = eye {
    // rust: let brightness = self.eye_brightness(e);
    // rust: let inside_portal = self.client_portal_effect();
    // rust: self.screen_fx.tick(brightness, inside_portal);
            // LocalPlayer.aiStep: processPortalCooldown after the transition
            // effect (a local world's player counts down in handlePortal).
    // rust: if self.remote.is_some() && self.portals.player.cooldown > 0 {
    // rust: self.portals.player.cooldown -= 1;
}
    // rust: let nausea = self.potions.effects.get("nausea").map(nausea_has_effect);
    // rust: self.screen_fx.tick_spinning(nausea);
            // LocalPlayer water vision and AtmosphericFogEnvironment rain fog.
    // rust: let in_water =
    // rust: fog_type(&self.world, self.res.facts(), e, &self.near_plane()) == FogType::Water;
    // rust: self.fog.tick(in_water);
    // rust: let b = [
    // rust: e[0].floor() as i32,
    // rust: e[1].floor() as i32,
    // rust: e[2].floor() as i32,
    // rust: ];
    // rust: let rain = self.view_weather(1.0).0;
    // rust: let biome = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(b[0] >> 4, b[2] >> 4))
    // rust: .map_or(0, |c| c.biome(b[0], b[1], b[2]));
    // rust: let rains = world_biomes!(self).get(biome).precipitation;
    // rust: update_rain_fog(
    // rust: &mut self.fog,
    // rust: rain,
    // rust: self.world.light(b[0], b[1], b[2]) >> 4,
    // rust: rains,
    // rust: 1.0,
    // rust: );
}
    // rust: self.particles.particle_level = self.settings.particles;
    // rust: if let Some(e) = eye {
    // rust: self.particles.camera = e;
}
    // rust: let (rain, _) = self.weather_levels(1.0);
    // rust: let marker = marker_particle_target(self.mode, self.stack_in(self.selected));
    // rust: let marker_options = |state| {
            // BlockMarker: the particle sprite, untinted.
    // rust: let sprite = Self::block_particle_sprite(&self.pack, state)?;
    // rust: Some(ParticleOptions::block(
    // rust: ParticleType::BlockMarker,
    // rust: sprite,
    // rust: 0xFFFFFF,
    // rust: ))
}
    // rust: let world = &self.world;
    // rust: let facts = self.res.facts();
    // rust: let biomes = world_biomes!(self);
    // rust: let properties = &self.pack.assets.properties;
    // rust: let raining = rain > 0.2;
    // rust: let raining_at = |p: [i32; 3]| {
    // rust: raining
    // rust: && motion_blocking_height(world, properties, p[0], p[2]) <= p[1]
    // rust: && rains_at(world, biomes, p[0], p[1], p[2])
}
    // rust: let height_no_leaves =
    // rust: |p: [i32; 3]| motion_blocking_leaves(world, facts, p[0], p[2], i32::MAX, false);
        // The day timeline: firefly bush sounds from 12600 to 23400.
    // rust: let firefly_bush_sounds = self.dim == Dim::Overworld
    // rust: && (12600..23401).contains(&self.world.day_time.rem_euclid(24000));
        // EnvironmentAttributes.CREAKING_ACTIVE: the same overworld night.
    // rust: let creaking_active = self.dim == Dim::Overworld
    // rust: && (12600..23401).contains(&self.world.day_time.rem_euclid(24000));
    // rust: let tables = &self.pack.context.tables;
    // rust: let model_offset = |state, x, z| tables.offset(state, x, z);
    // rust: let gateway_particles = |state, p| {
    // rust: self.res
    // rust: .block_entity_render()
    // rust: .gateway_faces(world, state, p)
    // rust: .len()
}
        // Level.isThundering: a thunder level above 0.9 where the sky is open.
    // rust: let thundering = self.can_have_weather() && world.weather.levels(1.0).1 > 0.9;
    // rust: let ctx = AnimateContext {
    // rust: world,
    // rust: facts,
    // rust: collision: self.collision,
    // rust: biomes,
    // rust: registry: self.pack.assets.registry,
    // rust: raining_at: &raining_at,
    // rust: height_no_leaves: &height_no_leaves,
    // rust: firefly_bush_sounds,
    // rust: creaking_active,
    // rust: sky_darken: self.sky_darken(),
    // rust: marker: marker.map(|name| (name, &marker_options as &dyn Fn(_) -> _)),
    // rust: model_offset: &model_offset,
    // rust: gateway_particles: &gateway_particles,
    // rust: thundering,
    // rust: ultrawarm: self.dim == Dim::Nether,
}
    // rust: if let Some(e) = eye {
    // rust: let block = [
    // rust: e[0].floor() as i32,
    // rust: e[1].floor() as i32,
    // rust: e[2].floor() as i32,
    // rust: ];
    // rust: animate_tick(self.res.animate(), &mut self.particles, &ctx, block);
            // The Horizon Weather option off means no rain visuals or sounds at all.
    // rust: if rain > 0.0 && self.settings.horizon.weather {
                // ClientLevel.tickWeatherEffects: rain splashes within the weather
                // radius, and the rain sound.
    // rust: let mut random = LegacyRandom::new(self.world.game_time.wrapping_mul(312_987_231));
    // rust: let radius = self.settings.weather_radius;
    // rust: let diameter = 2 * radius + 1;
    // rust: let count = (0.225 * (diameter * diameter) as f32 * rain * rain) as i32
    // rust: / if self.settings.particles == 1 { 2 } else { 1 };
    // rust: let mut rain_position = None;
    // rust: for _ in 0..count {
    // rust: let x = block[0] + random.next_int_bound(diameter).unwrap_or(0) - radius;
    // rust: let z = block[2] + random.next_int_bound(diameter).unwrap_or(0) - radius;
    // rust: let Some(top) = splash_height(world, properties, x, block[1], z) else {
    // rust: continue;
}
    // rust: if !rains_at(world, biomes, x, top, z) {
    // rust: continue;
}
    // rust: let below = top - 1;
    // rust: rain_position = Some([x, below, z]);
                    // The Minimal option stops at the first spot that rains (the
                    // rain sound still plays there).
    // rust: if self.settings.particles >= 2 {
    // rust: break;
}
    // rust: let (bx, bz) = (random.next_double(), random.next_double());
    // rust: let state = world.block(x, below, z);
    // rust: let f = facts.get(state);
    // rust: let block_top = match self.collision.cached_shapes().cached_shape(state) {
    // rust: Ok(Some(shape)) if !shape.is_empty() => {
    // rust: shape.max_at(horizon_core::geometry::Axis::Y, bx, bz)
}
    // rust: _ => 0.0,
}
    // rust: let fluid_top = if f.fluid == Fluid::None {
    // rust: 0.0
    // rust: } else {
    // rust: f64::from(f.fluid_level) / 9.0
}
    // rust: let smoke = f.fluid == Fluid::Lava
    // rust: || &*f.name == "minecraft:magma_block"
    // rust: || (f.name.ends_with("campfire")
    // rust: && self.res.animate().is_lit_campfire(state.0));
    // rust: let ty = if smoke {
    // rust: ParticleType::Smoke
    // rust: } else {
    // rust: ParticleType::Rain
}
    // rust: let p = [
    // rust: f64::from(x) + bx,
    // rust: f64::from(below) + block_top.max(fluid_top),
    // rust: f64::from(z) + bz,
    // rust: ];
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ty), p, [0.0; 3]);
}
                // The last rain column of the tick makes the sound, more often the
                // longer it has been quiet; indoors it is the quieter one.
    // rust: if let Some(at) = rain_position {
    // rust: let waited = self.rain_sound_time;
    // rust: self.rain_sound_time += 1;
    // rust: if random.next_int_bound(3).unwrap_or(0) < waited {
    // rust: self.rain_sound_time = 0;
    // rust: let roof = motion_blocking_height(world, properties, block[0], block[2]);
    // rust: let (name, volume, pitch) = if at[1] > block[1] + 1 && roof > block[1] {
    // rust: ("minecraft:weather.rain.above", 0.1, 0.5)
    // rust: } else {
    // rust: ("minecraft:weather.rain", 0.2, 1.0)
}
    // rust: let p = at.map(|c| f64::from(c) + 0.5);
                        // playLocalSound: guests make their own rain, so a host
                        // must not capture it for them.
    // rust: self.audio.play_unshared(name, Some(p), volume, pitch);
}
}
}
}
    // rust: if let Some(r) = &self.renderer {
    // rust: campfire_particles(
    // rust: self.res.animate(),
    // rust: &mut self.particles,
    // rust: &ctx,
    // rust: r.block_entities(),
    // rust: &|pos| match self.world.block_entities.get(&(pos[0], pos[1], pos[2])) {
    // rust: Some(BlockEntity::Campfire(c)) => c.items.each_ref().map(Option::is_some),
    // rust: _ => [false; 4],
    // rust: },
    // rust: );
}
        // SpellParticle.isCloseToScopingPlayer: the eye of a local player looking
        // through a spyglass in first person.
    // rust: let scope_eye = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|_| self.camera_type.first_person() && self.scoping())
    // rust: .map(|p| {
    // rust: [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.eye_height),
    // rust: p.position.z,
    // rust: ]
    // rust: });
    // rust: self.particles.set_scope_eye(scope_eye);
    // rust: let level = ParticleLevel {
    // rust: world,
    // rust: facts,
    // rust: collision: self.collision,
    // rust: player: self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| ([p.position.x, p.position.y, p.position.z], p.velocity.y)),
}
    // rust: self.particles.tick(&level);
    // rust: self.tick_pickups();
    // rust: let camera = self.particles.camera;
    // rust: for (name, at, volume, pitch, delayed) in std::mem::take(&mut self.particles.sounds) {
    // rust: if delayed {
    // rust: self.audio
    // rust: .play_distance_delayed(name, at, volume, pitch, camera);
    // rust: } else {
    // rust: self.audio.play(name, Some(at), volume, pitch);
}
}
}
}
    // rust: mod tests {
//     use super::{Properties, World, splash_height};
//     use horizon_client::chunk::Chunk;
//     use horizon_world::registry::BlockStateId;
//     use std::sync::Arc;

    // #3810: under a stone roof more than 64 blocks above the camera, as in a
    // deep excavation, MOTION_BLOCKING is the roof, so no rain splash lands on
    // the floor; with the roof gone, it does.
no_rain_splash_under_a_high_roof :: proc() {
}
        // State 0 is air, 1 is stone.
    // rust: let properties =
    // rust: Properties::for_tests(&[(true, false, false, false), (false, false, true, true)]);
    // rust: let stone = BlockStateId(1);
    // rust: let mut world = World::new(BlockStateId(0), 0);
    // rust: world.chunks.insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
    // rust: world.set(x, 0, z, stone).unwrap();
}
}
        // The camera stands on the floor, its block at y 1.
    // rust: assert_eq!(splash_height(&world, &properties, 3, 1, 3), Some(1));
    // rust: for roof in [70, 80, 200] {
    // rust: world.set(3, roof, 3, stone).unwrap();
    // rust: assert_eq!(
    // rust: splash_height(&world, &properties, 3, 1, 3),
    // rust: None,
    // rust: "roof at {roof}"
    // rust: );
    // rust: world.set(3, roof, 3, BlockStateId(0)).unwrap();
}
    // rust: assert_eq!(splash_height(&world, &properties, 3, 1, 3), Some(1));
        // A roof within 10 blocks is where the splash lands.
    // rust: world.set(3, 8, 3, stone).unwrap();
    // rust: assert_eq!(splash_height(&world, &properties, 3, 1, 3), Some(9));
}
}
