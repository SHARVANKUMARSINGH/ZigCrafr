//! Transpiled from Horizon Rust crate
//! Module: horizon-client_end
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The End: End portal frames filled with eyes of ender, End portal and End
//! gateway travel, the obsidian arrival platform, the exit portal and the End
//! sky. The dragon fight itself lives in game/dragon.rs: the podium is
//! inactive until the dragon dies.
// use super::{Dim, Game};
// use horizon_client::nether_portal::ENTITY_DELAY;
// use horizon_client::{
    // rust: Result,
    // rust: containers::BlockEntity,
    // rust: environment::Environment,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::Who,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: projectiles::{Projectile, ProjectileKind},
    // rust: vanillagen::VanillaTerrain,
    // rust: world_spawn::PlayerSpawnFinder,
}
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::nbt::Tag;

// use std::{collections::HashMap, sync::Arc};

/// A list of doubles, as an NBT list of them.
pub fn doubles(values: [f64; 3]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(values.iter().map(|v| Tag::Double(v.to_bits())).collect())
}

/// `TicketType.PORTAL`'s timeout, in ticks.
pub const PORTAL_TICKET: u32 = 300;

/// ServerLevel.END_SPAWN_POINT.
    // rust: pub(super) const END_SPAWN: [i32; 3] = [100, 50, 0];
/// EnderDragonFight gateway ring radius and height.
pub const GATEWAY_RADIUS: f64 = 96.0;
pub const GATEWAY_Y: i32 = 75;

/// A gateway teleport waiting for its destination chunks.
    // rust: pub(super) enum GatewayJob {
    /// TheEndGatewayBlockEntity.findOrCreateValidTeleportPos from this gateway.
    /// `exact` is the gateway's own `ExactTeleport`, read while its chunk is loaded.
    // rust: Find { gateway: [i32; 3], exact: bool },
    /// A known exit (exact, or findExitPosition around it).
    // rust: Known { exit: [i32; 3], exact: bool },
}

/// An entity travelling through an End gateway: the entity and the job that
/// finds where it lands (`TheEndGatewayBlockEntity.getPortalPosition`).
pub const GatewayArrival = struct {
    /// The entity, as it waits for the exit's chunks.
    traveller: Arriving,
    /// The gateway's exit, or the search for one.
    job: GatewayJob,
    /// The spot to load before the job is resolved.
    target: Vec3,
};

/// What waits at a gateway's exit.
pub const Arriving = enum {
    /// An item or a mob, as its saved compound.
    Saved(Tag),
    /// A thrown ender pearl (projectiles are not saved).
    Pearl(Box<Projectile>),
    /// A vehicle remains in this level while its destination loads.
    Vehicle(u32),
};

    // rust: impl GatewayJob {
    /// The source of a new exit must stay loaded until its block entity is updated.
    // rust: pub(super) fn source_chunk(self) -> Option<(i32, i32)> {
    // rust: match self {
    // rust: Self::Find { gateway, .. } => Some((gateway[0] >> 4, gateway[2] >> 4)),
    // rust: Self::Known { .. } => None,
}
}

    /// TheEndGatewayBlockEntity.getPortalPosition, using the gateway block entity.
pub fn for_gateway(gateway: [i32; 3], entity: ?*BlockEntity) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let configured = match entity {
    // rust: Some(BlockEntity::EndGateway(g)) => g.exit_portal.map(|exit| (exit, g.exact_teleport)),
    // rust: _ => None,
}
    // rust: match configured {
    // rust: Some((exit, exact)) => Self::Known { exit, exact },
            // Worldgen return gateways (end_gateway_return) lead exactly to the End spawn.
    // rust: None if f64::from(gateway[0]).hypot(f64::from(gateway[2])) > 512.0 => Self::Known {
    // rust: exit: END_SPAWN,
    // rust: exact: true,
    // rust: },
    // rust: None => Self::Find {
    // rust: gateway,
    // rust: exact: exact_teleport(entity),
    // rust: },
}
}
}

/// `TheEndGatewayBlockEntity.exactTeleport` of the block entity at a gateway
/// (false without one).
pub fn exact_teleport(entity: ?*BlockEntity) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(entity, Some(BlockEntity::EndGateway(g)) if g.exact_teleport)
}

/// The end of `getPortalPosition`: the exit itself when the teleport is exact,
/// else the spot [`Game::resolve_gateway`] finds around it (`findExitPosition`).
pub fn exit_target(exit: [i32; 3], exact: bool, find: impl FnOnce([i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if exact { exit } else { find(exit) }
}

pub fn fallback_spawn(own: ?Vec3, world: ?[i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = own.unwrap_or_else(|| {
    // rust: let [x, y, z] = world.unwrap_or([0, 64, 0]);
    // rust: Vec3::new(f64::from(x), f64::from(y), f64::from(z))
    // rust: });
    // rust: Vec3::new(s.x.floor() + 0.5, s.y, s.z.floor() + 0.5)
}

    // rust: pub(super) struct EndState {
    /// Ticks until the player can use a gateway again (TheEndGatewayBlockEntity cooldown).
    // rust: gateway_cooldown: u32,
    // rust: gateways: HashMap<u32, horizon_client::end_gateway::Traveller>,
    /// The entities that went through a gateway, waiting for its exit.
    // rust: arrivals: Vec<GatewayArrival>,
    /// The chunks kept loaded for those arrivals.
    // rust: areas: Vec<(i32, i32)>,
    /// `Entity.placePortalTicket` of the pearls that came out of a gateway:
    /// the chunk each landed in, kept loaded for the ticks left of its
    /// `TicketType.PORTAL`, so that it can come down and take its owner there.
    // rust: tickets: Vec<((i32, i32), u32)>,
    /// The Overworld generator, for stronghold positions (ServerLevel.findNearestMapStructure).
    // rust: locator: std::sync::Mutex<Option<Arc<VanillaTerrain>>>,
    /// Thrown eyes of ender in flight.
    // rust: eyes: Vec<EyeOfEnder>,
    // rust: flash: EndFlash,
}

/// EndFlashState: a purple flash in the End sky every 600 ticks that also
/// lights the world (the lightmap's sky factor).
pub const EndFlash = struct {
    seed: ?i64,
    offset: i32,
    duration: i32,
    intensity: f32,
    old_intensity: f32,
    x_angle: f32,
    y_angle: f32,
    /// Ticks until the delayed weather.end_flash sound.
    sound_in: ?u32,
};
    // rust: impl EndFlash {
pub fn tick(self: *Self, clock: i64) void {
}
    // rust: let seed = clock.div_euclid(600);
    // rust: if self.seed != Some(seed) {
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: random.next_float();
    // rust: let between = |r: &mut LegacyRandom, lo: i32, hi: i32| {
    // rust: r.next_int_bound(hi - lo + 1).unwrap_or(0) + lo
}
    // rust: self.offset = between(&mut random, 0, 200);
    // rust: self.duration = between(&mut random, 100, 380.min(600 - self.offset));
    // rust: self.x_angle = random.next_float() * 70.0 - 60.0;
    // rust: self.y_angle = random.next_float() * 360.0 - 180.0;
    // rust: self.seed = Some(seed);
}
    // rust: self.old_intensity = self.intensity;
    // rust: let t = clock.rem_euclid(600) as i32;
    // rust: self.intensity = if t >= self.offset && t <= self.offset + self.duration {
    // rust: ((t - self.offset) as f32 * std::f32::consts::PI / self.duration as f32).sin()
    // rust: } else {
    // rust: 0.0
}
    // rust: if self.intensity > 0.0 && self.old_intensity <= 0.0 {
    // rust: self.sound_in = Some(30);
}
}
pub fn intensity(self: *Self, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.old_intensity + (self.intensity - self.old_intensity) * partial
}
    /// SkyRenderer.renderEndFlash's pose: the sprite at height 100 turned to the flash.
pub fn pose(self: *Self) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: flash_pose(self.x_angle, self.y_angle)
}
}

pub fn flash_pose(x_angle: f32, y_angle: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: glam::Mat4::from_rotation_y((180.0 - y_angle).to_radians())
    // rust: * glam::Mat4::from_rotation_x((-90.0 - x_angle).to_radians())
}
    // rust: impl EndState {
    // rust: pub(super) fn locator(&self) -> Option<Arc<VanillaTerrain>> {
    // rust: self.locator.lock().unwrap().clone()
}
    // rust: pub(super) fn set_locator(&self, terrain: Option<Arc<VanillaTerrain>>) {
    // rust: *self.locator.lock().unwrap() = terrain;
}
}

    // rust: impl EndState {
    /// The eyes' entity ids, for a server to number them.
    // rust: pub(super) fn eye_ids(&mut self) -> impl Iterator<Item = &mut u32> {
    // rust: self.eyes.iter_mut().map(|e| &mut e.id)
}
    /// The numbered eyes as a server's clients track them: (id, position, motion).
    // rust: pub(super) fn eyes_tracked(&self) -> impl Iterator<Item = (u32, [f64; 3], [f64; 3])> {
    // rust: self.eyes
    // rust: .iter()
    // rust: .filter(|e| e.id != 0)
    // rust: .map(|e| (e.id, e.position.to_array(), e.velocity.to_array()))
}
    /// `handleAddEntity` for an eye of ender on a server's client: it flies
    /// where the server says.
    // rust: pub(super) fn add_remote_eye(&mut self, id: u32, at: [f64; 3], velocity: [f64; 3]) {
    // rust: self.eyes.retain(|e| e.id != id);
    // rust: let at = glam::DVec3::from_array(at);
    // rust: self.eyes.push(EyeOfEnder {
    // rust: id,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: glam::DVec3::from_array(velocity),
    // rust: target: at,
    // rust: life: 0,
    // rust: survive: false,
    // rust: });
}
    /// Where each eye in flight was last tick and is now (the hitbox view).
    // rust: pub(super) fn eye_motions(&self) -> impl Iterator<Item = (glam::DVec3, glam::DVec3)> + '_ {
    // rust: self.eyes.iter().map(|e| (e.previous, e.position))
}
    /// `EyeOfEnder.tick` on a server's client: it moves by its last known
    /// motion; only the server steers it.
    // rust: pub(super) fn step_remote_eyes(&mut self) {
    // rust: for e in &mut self.eyes {
    // rust: e.previous = e.position;
    // rust: e.life += 1;
    // rust: e.position += e.velocity;
}
}
    /// A server's move: an eye has no interpolation handler, so
    /// `moveOrInterpolateTo` puts it there at once. False when `id` isn't one.
    // rust: pub(super) fn move_remote_eye(&mut self, id: u32, at: [f64; 3]) -> bool {
    // rust: let Some(e) = self.eyes.iter_mut().find(|e| e.id == id) else {
    // rust: return false;
}
    // rust: e.position = glam::DVec3::from_array(at);
    // rust: true
}
    /// `handleSetEntityMotion` for an eye. False when `id` isn't one.
    // rust: pub(super) fn remote_eye_motion(&mut self, id: u32, velocity: [f64; 3]) -> bool {
    // rust: let Some(e) = self.eyes.iter_mut().find(|e| e.id == id) else {
    // rust: return false;
}
    // rust: e.velocity = glam::DVec3::from_array(velocity);
    // rust: true
}
    // rust: pub(super) fn remove_remote_eye(&mut self, id: u32) {
    // rust: self.eyes.retain(|e| e.id != id);
}
    // rust: pub(super) fn clear_remote_eyes(&mut self) {
    // rust: self.eyes.clear();
}
    /// Where each eye is, for `status`.
    // rust: pub(super) fn eye_positions(&self) -> impl Iterator<Item = (u32, [f64; 3])> {
    // rust: self.eyes.iter().map(|e| (e.id, e.position.to_array()))
}
}

/// The EyeOfEnder entity.
pub const EyeOfEnder = struct {
    /// Its entity id once a server's clients track it (0 until then).
    id: u32,
    position: glam::DVec3,
    previous: glam::DVec3,
    velocity: glam::DVec3,
    target: glam::DVec3,
    life: u32,
    survive: bool,
};
    // rust: impl EyeOfEnder {
    /// EyeOfEnder.updateDeltaMovement.
pub fn update_delta(old: glam::DVec3, position: glam::DVec3, target: glam::DVec3) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let horizontal = glam::DVec3::new(target.x - position.x, 0.0, target.z - position.z);
    // rust: let length = horizontal.length();
    // rust: let old_horizontal = old.x.hypot(old.z);
    // rust: let mut wanted_speed = old_horizontal + 0.0025 * (length - old_horizontal);
    // rust: let mut y = old.y;
    // rust: if length < 1.0 {
    // rust: wanted_speed *= 0.8;
    // rust: y *= 0.8;
}
    // rust: let wanted_y = if position.y - old.y < target.y {
    // rust: 1.0
    // rust: } else {
    // rust: -1.0
}
    // rust: horizontal * (wanted_speed / length)
    // rust: + glam::DVec3::new(0.0, y + (wanted_y - y) * 0.015, 0.0)
}
}

    // rust: impl Game<'_> {
    /// The environment attributes of the current dimension.
    // rust: pub(super) fn dim_environment(&self) -> &Environment {
    // rust: match self.dim {
    // rust: Dim::Overworld => self.res.environment(),
    // rust: Dim::Nether => self.res.nether_environment(),
    // rust: Dim::End => self.res.end_environment(),
}
}

    /// SkyRenderer.renderEndFlash, drawn after the renderer's resident sky mesh.
    // rust: pub(super) fn end_flash_geometry(&self) -> Vec<Vertex> {
    // rust: let mut out = Vec::new();
        // The old combined sky/flash draw also skipped the flash without a sky sprite.
    // rust: if !self.gui.atlas.sprites.contains_key("environment/end_sky") {
    // rust: return out;
}
        // SkyRenderer.renderEndFlash: the end_flash sprite at height 100, scale 60.
    // rust: let intensity = self.end.flash.intensity(self.clock.fraction() as f32);
    // rust: if intensity > 1e-5
    // rust: && let Some(r) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("environment/celestial/end_flash")
    // rust: .copied()
    // rust: {
    // rust: let pose = self.end.flash.pose();
    // rust: let level = (intensity.clamp(0.0, 1.0) * 255.0) as u32;
    // rust: let color = level << 24 | level << 16 | level << 8 | level;
    // rust: let corners = [
    // rust: (-1.0, -1.0, [r.u0, r.v0]),
    // rust: (1.0, -1.0, [r.u1, r.v0]),
    // rust: (1.0, 1.0, [r.u1, r.v1]),
    // rust: (-1.0, 1.0, [r.u0, r.v1]),
    // rust: ];
    // rust: for (x, z, uv) in corners {
    // rust: let p = pose.transform_point3(glam::Vec3::new(x * 60.0, 100.0, z * 60.0));
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.to_array(),
    // rust: uv,
    // rust: layer: 2,
    // rust: color,
    // rust: light: 0,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: out
}

    /// Iris's `endFlashIntensity` and the flash's direction (camera-relative, length 100: the
    /// sprite's centre), for shader packs; no flash outside the End.
    // rust: pub(super) fn end_flash_for_pack(&self, partial: f32) -> (f32, glam::Vec3) {
    // rust: if self.dim != Dim::End {
    // rust: return (0.0, glam::Vec3::ZERO);
}
    // rust: let flash = &self.end.flash;
    // rust: (
    // rust: flash.intensity(partial).clamp(0.0, 1.0),
    // rust: flash
    // rust: .pose()
    // rust: .transform_point3(glam::Vec3::new(0.0, 100.0, 0.0)),
    // rust: )
}

    /// LightmapRenderStateExtractor: End flashes add to the sky light factor
    /// unless Hide Lightning Flashes is on (the sky sprite is not gated), a
    /// third of it under a boss bar's world fog.
    // rust: pub(super) fn end_flash_sky(&self, sky: &mut horizon_client::environment::Sky, partial: f64) {
    // rust: if self.dim == Dim::End && !self.settings.file.bool("hideLightningFlashes") {
    // rust: let intensity = self.end.flash.intensity(partial as f32);
    // rust: sky.sky_light_factor += if self.boss_overlay.should_create_world_fog() {
    // rust: intensity / 3.0
    // rust: } else {
    // rust: intensity
}
}
}

    // rust: pub(super) fn block_name(&self, p: [i32; 3]) -> std::sync::Arc<str> {
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name
    // rust: .clone()
}

    /// EnderEyeItem.use's `getPlayerPOVHitResult`: whether the block aimed
    /// at is an End portal frame (the use passes there).
    // rust: pub(super) fn aims_at_end_portal_frame(&self) -> bool {
    // rust: self.pick()
    // rust: .is_some_and(|hit| &*self.block_name(hit.pos) == "minecraft:end_portal_frame")
}

    /// EnderEyeItem.useOn: fill an empty End portal frame, then light the
    /// portal when the ring of twelve filled frames is complete.
    // rust: pub(super) fn use_ender_eye(&mut self, stack: &ItemStack, use_on_block: bool) -> Result<bool> {
    // rust: if &*stack.item != "minecraft:ender_eye" {
    // rust: return Ok(false);
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let target = self.pick().and_then(|hit| {
    // rust: let state = registry.state(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]))?;
    // rust: (state.name == "minecraft:end_portal_frame").then(|| (hit, state.clone()))
    // rust: });
    // rust: let Some((hit, state)) = target else {
            // EnderEyeItem.useOn passes off a frame: a guest's UseItem throws it.
    // rust: if matches!(self.guest_use, Some(super::GuestUse::OnBlock(_))) {
    // rust: return Ok(false);
}
            // EnderEyeItem.use: startUsingItem (getUseDuration 0, so the use
            // lasts until the button lets go), then the eye is thrown towards
            // the nearest stronghold if there is one (CONSUME without).
    // rust: self.start_using_item();
    // rust: self.throw_ender_eye();
    // rust: return Ok(true);
}
    // rust: if !use_on_block {
            // EnderEyeItem.use passes on a frame; only useOn can insert an eye.
    // rust: return Ok(false);
}
    // rust: if state.properties.get("eye").map(String::as_str) == Some("true") {
            // Both useOn and use pass on a filled frame.
    // rust: return Ok(true);
}
    // rust: let mut filled = state;
    // rust: filled.properties.insert("eye".into(), "true".into());
    // rust: let id = registry.resolve(&filled)?;
    // rust: self.level_set(hit.pos, id)?;
        // Block.pushEntitiesUp: the eye raises the frame's top from 13/16 to a full block.
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: let top = f64::from(hit.pos[1]) + 1.0;
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let over = |c: f64, b: i32| c + w > f64::from(b) && c - w < f64::from(b) + 1.0;
    // rust: if over(p.position.x, hit.pos[0])
    // rust: && over(p.position.z, hit.pos[2])
    // rust: && p.position.y >= top - 0.25
    // rust: && p.position.y < top
    // rust: {
    // rust: p.position.y = top;
}
}
    // rust: self.award_stat("used", "minecraft:ender_eye", 1);
    // rust: self.consume_held();
    // rust: self.swing_arm();
        // EnderEyeItem.useOn emits this event for all nearby players.
    // rust: self.level_event_at(1503, hit.pos, 0);
    // rust: if let Some(c) = self.portal_ring_center(hit.pos) {
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: let p = [c[0] + dx, c[1], c[2] + dz];
    // rust: let at = BlockPos::new(p[0], p[1], p[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.destroy_block(level, ticks, at, true);
    // rust: });
    // rust: self.set_state_named(p, "minecraft:end_portal", &[])?;
}
}
    // rust: self.process_level_events()?;
            // EnderEyeItem.useOn: global level event 1038 (END_PORTAL_SPAWN),
            // heard by every player (vanilla places it at the frame's corner
            // + (1, 0, 1); only its direction matters).
    // rust: self.global_level_event(1038, c, 0);
}
    // rust: Ok(true)
}

    /// EndPortalFrameBlock.getOrCreatePortalShape matched around `frame`: a 5×5
    /// ring (corners free) of filled frames, all facing the centre or all
    /// facing away from it. Returns the centre of the 3×3 opening.
pub fn portal_ring_center(self: *Self, frame: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = self.pack.assets.registry;
        // (offset from the centre, facing when the frames face the centre)
    // rust: let mut ring = Vec::with_capacity(12);
    // rust: for i in -1..=1 {
    // rust: ring.push(([i, -2], "south"));
    // rust: ring.push(([i, 2], "north"));
    // rust: ring.push(([-2, i], "east"));
    // rust: ring.push(([2, i], "west"));
}
    // rust: let opposite = |f: &str| match f {
    // rust: "south" => "north",
    // rust: "north" => "south",
    // rust: "east" => "west",
    // rust: _ => "east",
}
    // rust: for &([ox, oz], _) in &ring {
    // rust: let c = [frame[0] - ox, frame[1], frame[2] - oz];
    // rust: for inward in [true, false] {
    // rust: let ok = ring.iter().all(|&([dx, dz], facing)| {
    // rust: let id = self.world.block(c[0] + dx, c[1], c[2] + dz);
    // rust: let Some(s) = registry.state(id) else {
    // rust: return false;
}
    // rust: let want = if inward { facing } else { opposite(facing) };
    // rust: s.name == "minecraft:end_portal_frame"
    // rust: && s.properties.get("eye").map(String::as_str) == Some("true")
    // rust: && s.properties.get("facing").map(String::as_str) == Some(want)
    // rust: });
    // rust: if ok {
    // rust: return Some(c);
}
}
}
    // rust: None
}

    /// End portals, End gateways and the exit portal, once per tick.
    // rust: pub(super) fn tick_end(&mut self) -> Result<()> {
    // rust: self.end.gateway_cooldown = self.end.gateway_cooldown.saturating_sub(1);
    // rust: if self.dim == Dim::End {
    // rust: self.tick_fight();
    // rust: self.tick_dragon_fireballs();
    // rust: } else {
            // `/summon ender_dragon` outside the End: no fight, but the dragon flies.
    // rust: self.tick_fight();
}
        // The spikes' crystals (placed above) join before they light a fire:
        // a mod that cancels one keeps its fire out too.
    // rust: self.native_joins_flush(false, 0);
    // rust: self.tick_crystals();
    // rust: self.tick_eyes();
    // rust: if self.dim == Dim::End {
    // rust: self.end.flash.tick(self.world.game_time);
    // rust: if let Some(n) = self.end.flash.sound_in.as_mut() {
    // rust: *n = n.saturating_sub(1);
    // rust: if *n == 0 {
    // rust: self.end.flash.sound_in = None;
    // rust: self.audio
    // rust: .play("minecraft:weather.end_flash", None, 1.0, 1.0);
}
}
}
    // rust: if self.dim == Dim::End {
    // rust: self.ensure_exit_portal()?;
}
    // rust: Ok(())
}

    /// Whether a `width` by `height` box at `position` is inside an End
    /// portal (its entity-inside shape), and the End gateway it touches.
    // rust: pub(super) fn inside_end_portals(
    // rust: &self,
    // rust: position: Vec3,
    // rust: width: f64,
    // rust: height: f64,
    // rust: ) -> (bool, Option<[i32; 3]>) {
    // rust: let w = width / 2.0;
    // rust: let lo = [position.x - w, position.y, position.z - w];
    // rust: let hi = [position.x + w, position.y + height, position.z + w];
    // rust: let mut portal = false;
    // rust: let mut gateway = None;
    // rust: for x in lo[0].floor() as i32..=hi[0].floor() as i32 {
    // rust: for y in lo[1].floor() as i32..=hi[1].floor() as i32 {
    // rust: for z in lo[2].floor() as i32..=hi[2].floor() as i32 {
    // rust: let name = self.block_name([x, y, z]);
                    // EndPortalBlock entity-inside shape: y 6/16..12/16.
    // rust: if &*name == "minecraft:end_portal"
    // rust: && lo[1] < f64::from(y) + 0.75
    // rust: && hi[1] > f64::from(y) + 0.375
    // rust: {
    // rust: portal = true;
    // rust: } else if &*name == "minecraft:end_gateway" && self.dim == Dim::End {
    // rust: gateway = Some([x, y, z]);
}
}
}
}
    // rust: (portal, gateway)
}

    /// EndPortalBlock.getPortalDestination for the pending enter_dimension.
    // rust: pub(super) fn end_destination(&self, target: Dim) -> Option<Vec3> {
    // rust: if !self.end_portal_travel {
    // rust: return None;
}
    // rust: if target == Dim::End {
            // Vec3.atBottomCenterOf(END_SPAWN_POINT), one block lower for players.
    // rust: return Some(Vec3::new(
    // rust: f64::from(END_SPAWN[0]) + 0.5,
    // rust: f64::from(END_SPAWN[1] - 1),
    // rust: f64::from(END_SPAWN[2]) + 0.5,
    // rust: ));
}
        // Leaving the End: the respawn position, a bed's found once it has
        // loaded (findRespawnPositionAndUseSpawnBlock, not using it up).
    // rust: if let Some(c) = self.respawn_config.filter(|c| c.dim == target) {
    // rust: return Some(Vec3::new(
    // rust: f64::from(c.pos[0]) + 0.5,
    // rust: f64::from(c.pos[1]),
    // rust: f64::from(c.pos[2]) + 0.5,
    // rust: ));
}
    // rust: Some(fallback_spawn(self.spawn, self.level.world_spawn))
}

    /// Where an End portal's traveller lands once `target` has loaded, and
    /// the yaw it faces there: the platform below the End's spawn point,
    /// facing west, or the top of the Overworld's spawn column.
    /// None while a candidate of the world spawn's search loads (`finder`
    /// keeps it, see `search_spawn`).
    // rust: pub(super) fn end_arrival(
    // rust: &mut self,
    // rust: target: Vec3,
    // rust: finder: &mut Option<PlayerSpawnFinder>,
    // rust: ) -> Result<Option<(Vec3, Option<f32>)>> {
    // rust: if self.dim == Dim::End {
            // EndPlatformFeature.createEndPlatform below the spawn point.
    // rust: let origin = [END_SPAWN[0], END_SPAWN[1] - 1, END_SPAWN[2]];
    // rust: for dz in -2..=2 {
    // rust: for dx in -2..=2 {
    // rust: for dy in -1..3 {
    // rust: let p = [origin[0] + dx, origin[1] + dy, origin[2] + dz];
    // rust: let name = if dy == -1 {
    // rust: "minecraft:obsidian"
    // rust: } else {
    // rust: "minecraft:air"
}
    // rust: if &*self.block_name(p) != name {
                            // Portal arrivals rebuild the platform with drops enabled.
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.destroy_block(
    // rust: level,
    // rust: ticks,
    // rust: BlockPos::new(p[0], p[1], p[2]),
    // rust: true,
    // rust: );
    // rust: });
    // rust: self.set_state_named(p, name, &[])?;
}
}
}
}
    // rust: self.native_portal_create("minecraft:the_end", origin);
            // Direction.WEST.toYRot().
    // rust: return Ok(Some((target, Some(90.0))));
}
        // ServerPlayer.findRespawnPositionAndUseSpawnBlock: where the bed or
        // anchor puts the player, facing it; else onto the spawn column.
    // rust: let mut target = target;
    // rust: if let Some(c) = self.respawn_config.filter(|c| c.dim == self.dim) {
    // rust: if let Some((at, yaw)) = self.find_respawn_and_use(c, false)? {
    // rust: return Ok(Some((at, Some(yaw))));
}
    // rust: target = fallback_spawn(self.spawn, self.level.world_spawn);
}
    // rust: let (x, z) = (target.x.floor() as i32, target.z.floor() as i32);
        // TeleportTransition.missingRespawnBlock: PlayerSpawnFinder around
        // the world spawn.
    // rust: if let Some(world) = self.level.world_spawn.filter(|w| w[0] == x && w[2] == z) {
    // rust: return Ok(match self.search_spawn(world, finder) {
    // rust: Ok(at) => Some((at, None)),
    // rust: Err(chunk) => {
    // rust: self.spawn_wait.push(chunk);
    // rust: None
}
    // rust: });
}
    // rust: let y = self.land_column(x, z).map_or(target.y, f64::from);
    // rust: Ok(Some((Vec3::new(target.x, y, target.z), None)))
}

    /// EnderDragonFight without a dragon: once the centre of the main island
    /// is loaded, place the active exit portal (EndPodiumFeature) and the
    /// first gateway (spawnNewGateway) if the portal is not there yet. Like
    /// scanState and spawnExitPortal, only while the fight has no exit portal
    /// location: a podium that is later broken stays broken.
pub fn ensure_exit_portal(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !(-1..=0).all(|cz| (-1..=0).all(|cx| self.streaming.is_lit(cx, cz)))
    // rust: || !self.fight_ready()
    // rust: {
    // rust: return Ok(());
}
    // rust: let won = self.fight.previously_killed;
    // rust: let gateway = self.first_gateway();
    // rust: if self.exit_portal().is_none() {
            // findExitPortal remembers the location of a podium that is already there.
    // rust: if let Some(level) = self.podium_level() {
    // rust: self.set_exit_portal([0, level, 0]);
}
}
    // rust: if self.exit_portal().is_some() {
            // The gateway may have been out of range when it was placed.
    // rust: if won
    // rust: && self.world.loaded(gateway[0], gateway[2])
    // rust: && &*self.block_name(gateway) != "minecraft:end_gateway"
    // rust: && &*self.block_name([gateway[0], gateway[1] + 2, gateway[2]])
    // rust: != "minecraft:bedrock"
    // rust: {
    // rust: self.place_gateway(gateway)?;
}
    // rust: return Ok(());
}
        // getHeightmapPos(MOTION_BLOCKING_NO_LEAVES, podium location).below()
    // rust: let mut y = (0..256)
    // rust: .rev()
    // rust: .find(|&y| {
    // rust: let f = self.res.facts().get(self.world.block(0, y, 0));
    // rust: (f.full_collision || f.fluid != horizon_client::blocks::Fluid::None)
    // rust: && !f.name.ends_with("_leaves")
    // rust: })
    // rust: .unwrap_or(0);
    // rust: while &*self.block_name([0, y, 0]) == "minecraft:bedrock" && y > 63 {
    // rust: y -= 1;
}
    // rust: let origin = [0, y.max(1), 0];
    // rust: self.set_exit_portal(origin);
    // rust: self.place_podium(origin, won)?;
    // rust: if won && self.world.loaded(gateway[0], gateway[2]) {
    // rust: self.place_gateway(gateway)?;
}
    // rust: Ok(())
}
    /// The portal level of the podium around the centre column, read from the
    /// bedrock that EndPodiumFeature places (rim at the portal level, disc
    /// below it, the torch column) so a broken column does not hide it.
pub fn podium_level(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut offsets: Vec<[i32; 3]> = (0..4).map(|dy| [0, dy, 0]).collect();
    // rust: for z in -4..=4i32 {
    // rust: for x in -4..=4i32 {
    // rust: let flat = f64::from(x * x + z * z);
    // rust: if (6.25..12.25).contains(&flat) {
    // rust: offsets.push([x, 0, z]);
    // rust: } else if flat + 1.0 < 6.25 {
    // rust: offsets.push([x, -1, z]);
}
}
}
    // rust: (1..253)
    // rust: .map(|y| {
    // rust: let score = offsets
    // rust: .iter()
    // rust: .filter(|o| &*self.block_name([o[0], y + o[1], o[2]]) == "minecraft:bedrock")
    // rust: .count();
    // rust: (score, y)
    // rust: })
    // rust: .filter(|&(score, _)| score >= 3)
    // rust: .max()
    // rust: .map(|(_, y)| y)
}
    /// `spawnExitPortal(true)` after the dragon dies.
    // rust: pub(super) fn activate_exit_portal(&mut self) -> Result<()> {
    // rust: let origin = match self.exit_portal() {
    // rust: Some(o) => o,
    // rust: None => {
                // The rim's level, found without assuming the centre column is intact.
    // rust: [0, self.podium_level().unwrap_or(61), 0]
}
}
    // rust: self.place_podium(origin, true)
}
    // rust: pub(super) fn place_gateway_at(&mut self, pos: [i32; 3]) -> Result<()> {
    // rust: self.place_gateway(pos)
}

    /// The first gateway of the shuffled ring (EnderDragonFight constructor
    /// and spawnNewGateway).
pub fn first_gateway(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut gateways: Vec<i32> = (0..20).collect();
    // rust: let mut random = LegacyRandom::new(self.level.seed);
    // rust: for i in (2..=gateways.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: gateways.swap(i - 1, j);
}
    // rust: let index = f64::from(gateways[gateways.len() - 1]);
    // rust: let angle = 2.0 * (-std::f64::consts::PI + std::f64::consts::PI / 20.0 * index);
    // rust: [
    // rust: (GATEWAY_RADIUS * angle.cos()).floor() as i32,
    // rust: GATEWAY_Y,
    // rust: (GATEWAY_RADIUS * angle.sin()).floor() as i32,
    // rust: ]
}

    /// EndPodiumFeature(active).place at `origin` (the portal level).
    // rust: pub(super) fn place_podium(&mut self, origin: [i32; 3], active: bool) -> Result<()> {
    // rust: for y in origin[1] - 1..=origin[1] + 32 {
    // rust: for z in origin[2] - 4..=origin[2] + 4 {
    // rust: for x in origin[0] - 4..=origin[0] + 4 {
    // rust: let d =
    // rust: (x - origin[0]).pow(2) + (y - origin[1]).pow(2) + (z - origin[2]).pow(2);
    // rust: let d = f64::from(d);
    // rust: let inside_rim = d < 2.5 * 2.5;
    // rust: if !(inside_rim || d < 3.5 * 3.5) {
    // rust: continue;
}
    // rust: let name = if y < origin[1] {
    // rust: if inside_rim {
    // rust: "minecraft:bedrock"
    // rust: } else {
    // rust: "minecraft:end_stone"
}
    // rust: } else if y > origin[1] {
    // rust: "minecraft:air"
    // rust: } else if !inside_rim {
    // rust: "minecraft:bedrock"
    // rust: } else if active {
    // rust: "minecraft:end_portal"
    // rust: } else {
    // rust: "minecraft:air"
}
    // rust: self.set_state_named([x, y, z], name, &[])?;
}
}
}
    // rust: for dy in 0..4 {
    // rust: self.set_state_named(
    // rust: [origin[0], origin[1] + dy, origin[2]],
    // rust: "minecraft:bedrock",
    // rust: &[],
    // rust: )?;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: for (facing, d) in [
    // rust: ("north", [0, -1]),
    // rust: ("south", [0, 1]),
    // rust: ("west", [-1, 0]),
    // rust: ("east", [1, 0]),
    // rust: ] {
    // rust: let Some(default) = registry.default_state("minecraft:wall_torch") else {
    // rust: continue;
}
    // rust: let mut state = registry.state(default).cloned().ok_or("wall torch")?;
    // rust: state.properties.insert("facing".into(), facing.into());
    // rust: let id = registry.resolve(&state)?;
    // rust: self.level_set([origin[0] + d[0], origin[1] + 2, origin[2] + d[1]], id)?;
}
    // rust: Ok(())
}

    /// EndGatewayFeature.place: the gateway block in a bedrock cross.
pub fn place_gateway(self: *Self, origin: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for y in -2i32..=2 {
    // rust: for z in -1..=1 {
    // rust: for x in -1..=1 {
    // rust: let (same_x, same_y, same_z) = (x == 0, y == 0, z == 0);
    // rust: let end = y.abs() == 2;
    // rust: let name = if same_x && same_y && same_z {
    // rust: "minecraft:end_gateway"
    // rust: } else if same_y {
    // rust: "minecraft:air"
    // rust: } else if end && same_x && same_z || (same_x || same_z) && !end {
    // rust: "minecraft:bedrock"
    // rust: } else {
    // rust: "minecraft:air"
}
    // rust: self.set_state_named([origin[0] + x, origin[1] + y, origin[2] + z], name, &[])?;
}
}
}
    // rust: self.world
    // rust: .block_entities
    // rust: .get_or_insert_with((origin[0], origin[1], origin[2]), || {
    // rust: BlockEntity::EndGateway(Default::default())
    // rust: });
    // rust: Ok(())
}

    /// `TheEndGatewayBlockEntity.setExitPosition`: the block entity alone owns the exit.
pub fn set_gateway_exit(self: *Self, gateway: [i32; 3], exit: [i32; 3], exact: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = (gateway[0] >> 4, gateway[2] >> 4);
    // rust: if !self.world.chunks.contains_key(&chunk) {
    // rust: return Err("gateway source chunk is not loaded".into());
}
        // A gateway removed while an entity waits for the destination stays removed.
    // rust: if &*self.block_name(gateway) != "minecraft:end_gateway" {
    // rust: return Ok(());
}
    // rust: if let BlockEntity::EndGateway(g) = self
    // rust: .world
    // rust: .block_entities
    // rust: .get_or_insert_with((gateway[0], gateway[1], gateway[2]), || {
    // rust: BlockEntity::EndGateway(Default::default())
    // rust: })
    // rust: {
    // rust: g.exit_portal = Some(exit);
    // rust: g.exact_teleport = exact;
    // rust: self.world.modified.insert(chunk);
}
    // rust: Ok(())
}

pub fn known_gateway_exit(self: *Self, gateway: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&(gateway[0], gateway[1], gateway[2]))
    // rust: {
    // rust: Some(BlockEntity::EndGateway(g)) => g.exit_portal.map(|e| (e, g.exact_teleport)),
    // rust: _ => None,
}
}

    /// Where `gateway` leads (TheEndGatewayBlockEntity.getPortalPosition):
    /// its exit, or the search for one, and the spot to load before either
    /// is resolved ([`Game::resolve_gateway`]).
    // rust: pub(super) fn gateway_job(&mut self, gateway: [i32; 3]) -> (GatewayJob, Vec3) {
    // rust: let job = GatewayJob::for_gateway(
    // rust: gateway,
    // rust: self.world
    // rust: .block_entities
    // rust: .get(&(gateway[0], gateway[1], gateway[2])),
    // rust: );
    // rust: if let Some(c) = job.source_chunk()
    // rust: && !self.end.areas.contains(&c)
    // rust: {
    // rust: self.end.areas.push(c);
    // rust: self.streaming.extra.push((c, 1));
}
    // rust: let destination = match job {
    // rust: GatewayJob::Known { exit, .. } => Vec3::new(
    // rust: f64::from(exit[0]) + 0.5,
    // rust: f64::from(exit[1]),
    // rust: f64::from(exit[2]) + 0.5,
    // rust: ),
    // rust: GatewayJob::Find { gateway, .. } => {
    // rust: let d = glam::DVec2::new(f64::from(gateway[0]), f64::from(gateway[2]))
    // rust: .normalize_or_zero()
    // rust: * 1024.0;
    // rust: Vec3::new(d.x, 75.0, d.y)
}
}
    // rust: (job, destination)
}

pub fn chunk_empty(self: *Self, x: f64, z: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&((x / 16.0).floor() as i32, (z / 16.0).floor() as i32))?;
    // rust: Some(chunk.sections.iter().all(|s| s.is_uniform(0)))
}

    /// TheEndGatewayBlockEntity.findTallestBlock.
pub fn tallest_block(self: *Self, around: [i32; 3], dist: i32, allow_bedrock: bool) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tallest: Option<[i32; 3]> = None;
    // rust: for xd in -dist..=dist {
    // rust: for zd in -dist..=dist {
    // rust: if xd == 0 && zd == 0 && !allow_bedrock {
    // rust: continue;
}
    // rust: let floor = tallest.map_or(0, |t| t[1]);
    // rust: let mut y = 255;
    // rust: while y > floor {
    // rust: let p = [around[0] + xd, y, around[2] + zd];
    // rust: let f = self.res.facts().get(self.world.block(p[0], p[1], p[2]));
    // rust: if f.full_collision && (allow_bedrock || &*f.name != "minecraft:bedrock") {
    // rust: tallest = Some(p);
    // rust: break;
}
    // rust: y -= 1;
}
}
}
    // rust: tallest.unwrap_or(around)
}

    /// The teleport position of a gateway job, creating the exit gateway (and
    /// an island when the chunk has no landing spot) for new destinations.
    // rust: pub(super) fn resolve_gateway(&mut self, job: GatewayJob, target: Vec3) -> Result<Vec3> {
    // rust: let bottom_center = horizon_client::end_gateway::bottom_center;
    // rust: let find_exit = |game: &Self, exit: [i32; 3]| {
    // rust: let p = game.tallest_block([exit[0], exit[1] + 2, exit[2]], 5, false);
    // rust: [p[0], p[1] + 1, p[2]]
}
    // rust: match job {
    // rust: GatewayJob::Known { exit, exact } => Ok(bottom_center(exit_target(exit, exact, |e| {
    // rust: find_exit(self, e)
    // rust: }))),
    // rust: GatewayJob::Find { gateway, exact } => {
    // rust: if !self
    // rust: .world
    // rust: .chunks
    // rust: .contains_key(&(gateway[0] >> 4, gateway[2] >> 4))
    // rust: {
    // rust: return Err("gateway source chunk is not loaded".into());
}
                // The player and the entities may resolve the same gateway: the
                // first one to arrive finds the exit, the others use it.
    // rust: let known = self.known_gateway_exit(gateway);
    // rust: if let Some((exit, exact)) = known {
    // rust: return Ok(bottom_center(exit_target(exit, exact, |e| {
    // rust: find_exit(self, e)
    // rust: })));
}
                // findExitPortalXZPosTentative over the loaded chunks.
    // rust: let dir = glam::DVec2::new(f64::from(gateway[0]), f64::from(gateway[2]))
    // rust: .normalize_or_zero();
    // rust: let mut pos = glam::DVec2::new(target.x, target.z);
    // rust: let mut limit = 16;
    // rust: while self.chunk_empty(pos.x, pos.y) == Some(false) && limit > 0 {
    // rust: limit -= 1;
    // rust: pos -= dir * 16.0;
}
    // rust: let mut limit = 16;
    // rust: while self.chunk_empty(pos.x, pos.y) == Some(true) && limit > 0 {
    // rust: limit -= 1;
    // rust: pos += dir * 16.0;
}
    // rust: let (cx, cz) = ((pos.x / 16.0).floor() as i32, (pos.y / 16.0).floor() as i32);
                // findValidSpawnInChunk: end stone with two non-full blocks above, closest to 0,0,0.
    // rust: let mut closest: Option<([i32; 3], f64)> = None;
    // rust: for y in 30..256 {
    // rust: for z in cz * 16..cz * 16 + 16 {
    // rust: for x in cx * 16..cx * 16 + 16 {
    // rust: if &*self.block_name([x, y, z]) != "minecraft:end_stone"
    // rust: || self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(x, y + 1, z))
    // rust: .full_collision
    // rust: || self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(x, y + 2, z))
    // rust: .full_collision
    // rust: {
    // rust: continue;
}
    // rust: let d = (f64::from(x) + 0.5).powi(2)
    // rust: + (f64::from(y) + 0.5).powi(2)
    // rust: + (f64::from(z) + 0.5).powi(2);
    // rust: if closest.is_none_or(|c| d < c.1) {
    // rust: closest = Some(([x, y, z], d));
}
}
}
}
    // rust: let spot = match closest {
    // rust: Some((p, _)) => p,
    // rust: None => {
    // rust: let p = [
    // rust: (pos.x + 0.5).floor() as i32,
    // rust: 75,
    // rust: (pos.y + 0.5).floor() as i32,
    // rust: ];
    // rust: self.place_end_island(p)?;
    // rust: p
}
}
    // rust: let tallest = self.tallest_block(spot, 16, true);
    // rust: let exit = [tallest[0], tallest[1] + 10, tallest[2]];
    // rust: self.place_gateway(exit)?;
    // rust: self.set_gateway_exit(exit, gateway, false)?;
                // setExitPosition keeps the gateway's own exactTeleport.
    // rust: self.set_gateway_exit(gateway, exit, exact)?;
    // rust: Ok(bottom_center(exit_target(exit, exact, |e| {
    // rust: find_exit(self, e)
    // rust: })))
}
}
}

    /// EndIslandFeature with RandomSource.create(pos.asLong()).
pub fn place_end_island(self: *Self, origin: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let packed = ((i64::from(origin[0]) & 0x3FF_FFFF) << 38)
    // rust: | ((i64::from(origin[2]) & 0x3FF_FFFF) << 12)
    // rust: | (i64::from(origin[1]) & 0xFFF);
    // rust: let mut random = LegacyRandom::new(packed);
    // rust: let mut size = random.next_int_bound(3).unwrap_or(0) as f32 + 4.0;
    // rust: let mut y = 0;
    // rust: while size > 0.5 {
    // rust: for x in (-size).floor() as i32..=size.ceil() as i32 {
    // rust: for z in (-size).floor() as i32..=size.ceil() as i32 {
    // rust: if (x * x + z * z) as f32 <= (size + 1.0) * (size + 1.0) {
    // rust: self.set_state_named(
    // rust: [origin[0] + x, origin[1] + y, origin[2] + z],
    // rust: "minecraft:end_stone",
    // rust: &[],
    // rust: )?;
}
}
}
    // rust: size -= random.next_int_bound(2).unwrap_or(0) as f32 + 0.5;
    // rust: y -= 1;
}
    // rust: Ok(())
}

    /// End crystals (on the spikes, or placed in any dimension) and thrown
    /// eyes of ender, as camera-relative entity geometry (End portals and
    /// gateways are block entities).
    // rust: pub(super) fn end_geometry(&self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: self.end_crystal_geometry(camera, out);
    // rust: self.eye_geometry(camera, out);
}

    /// EndCrystalRenderer and EndCrystalModel for the end crystals, and the
    /// beam to a crystal's target (the spikes being summoned back).
pub fn end_crystal_geometry(self: *Self, camera: glam::DVec3, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: let (Some(model), Some(r)) = (
    // rust: self.crystal_model.as_ref(),
    // rust: self.gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/end_crystal/end_crystal")
    // rust: .copied(),
    // rust: ) else {
    // rust: return;
}
    // rust: let uv = [r.u0, r.v0, r.u1, r.v1];
    // rust: let partial = self.clock.fraction() as f32;
    // rust: for crystal in &self.crystals {
    // rust: let feet = glam::DVec3::new(crystal.position.x, crystal.position.y, crystal.position.z);
    // rust: let rel = feet - camera;
    // rust: if rel.length_squared() > 256.0 * 256.0 {
    // rust: continue;
}
    // rust: let age = crystal.time as f32 + partial;
    // rust: let light = self.world.light(
    // rust: feet.x.floor() as i32,
    // rust: feet.y.floor() as i32,
    // rust: feet.z.floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let poses = horizon_client::end_crystal::poses(model, age, crystal.show_bottom);
            // poseStack.scale(2) then translate(0, -0.5, 0), not flipped.
    // rust: let base = glam::Mat4::from_translation(rel.as_vec3())
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(2.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.5, 0.0));
    // rust: let start = out.len();
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
            // HDR output: the crystal shines; its tier's window leaves the dark base alone
            // (entity.wgsl fs_hdr_mark).
    // rust: for v in &mut out[start..] {
    // rust: v.layer |= u32::from(horizon_client::mesher::BRIGHT) << 16;
}
    // rust: if let Some(target) = crystal.beam {
                // The beam from the target's centre up to the bobbing crystal.
    // rust: let from = glam::DVec3::new(
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]) + 0.5,
    // rust: f64::from(target[2]) + 0.5,
    // rust: );
    // rust: let delta = feet - from
    // rust: + glam::DVec3::new(0.0, f64::from(horizon_client::end_crystal::y(age)), 0.0);
    // rust: self.crystal_beam(from, delta, age, camera, out);
}
}
}

    /// EnderEyeItem.use: findNearestMapStructure over the stronghold rings,
    /// then an EyeOfEnder signalled towards it. Without a stronghold (other
    /// dimensions) nothing is thrown.
pub fn throw_ender_eye(self: *Self) void {
}
    // rust: let rings = self
    // rust: .end
    // rust: .locator
    // rust: .lock()
    // rust: .unwrap()
    // rust: .as_ref()
    // rust: .and_then(|t| t.ring_positions("minecraft:strongholds"));
    // rust: let (Some(rings), Some(p)) = (rings, self.player.as_ref()) else {
    // rust: return;
}
    // rust: let block = [
    // rust: p.position.x.floor(),
    // rust: p.position.y.floor(),
    // rust: p.position.z.floor(),
    // rust: ];
        // ChunkGenerator.getNearestGeneratedStructure: the ring chunk closest to
        // its (8, 32, 8) block, located at the chunk's corner.
    // rust: let Some(nearest) = rings.iter().min_by(|a, b| {
    // rust: let d = |c: &horizon_core::position::ChunkPos| {
    // rust: (f64::from(c.x * 16 + 8) - block[0]).powi(2)
    // rust: + (32.0 - block[1]).powi(2)
    // rust: + (f64::from(c.z * 16 + 8) - block[2]).powi(2)
}
    // rust: d(a).total_cmp(&d(b))
    // rust: }) else {
    // rust: return;
}
    // rust: let target = glam::DVec3::new(f64::from(nearest.x * 16), 0.0, f64::from(nearest.z * 16));
    // rust: let start = glam::DVec3::new(
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.height) * 0.5,
    // rust: p.position.z,
    // rust: );
        // EyeOfEnder.signalTo.
    // rust: let delta = target - start;
    // rust: let horizontal = delta.x.hypot(delta.z);
    // rust: let target = if horizontal > 12.0 {
    // rust: start
    // rust: + glam::DVec3::new(
    // rust: delta.x / horizontal * 12.0,
    // rust: 8.0,
    // rust: delta.z / horizontal * 12.0,
    // rust: )
    // rust: } else {
    // rust: target
}
    // rust: let survive = self.world.random.next_int_bound(5).unwrap_or(0) > 0;
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: let id = self.take_entity_id();
    // rust: self.end.eyes.push(EyeOfEnder {
    // rust: id,
    // rust: position: start,
    // rust: previous: start,
    // rust: velocity: glam::DVec3::ZERO,
    // rust: target,
    // rust: life: 0,
    // rust: survive,
    // rust: });
    // rust: let r = self.world.random.next_float();
    // rust: let pitch = 0.33 + r * (0.5 - 0.33);
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_eye.launch", Some(at), 1.0, pitch);
    // rust: self.consume_held();
    // rust: self.award_stat("used", "minecraft:ender_eye", 1);
    // rust: self.swing_arm();
}

    /// EyeOfEnder.tick: fly, then drop (4 in 5) or shatter after 80 ticks.
pub fn tick_eyes(self: *Self) void {
}
    // rust: let mut eyes = std::mem::take(&mut self.end.eyes);
    // rust: let mut shattered = Vec::new();
    // rust: eyes.retain_mut(|eye| {
    // rust: eye.previous = eye.position;
    // rust: let next = eye.position + eye.velocity;
    // rust: eye.velocity = EyeOfEnder::update_delta(eye.velocity, next, eye.target);
    // rust: eye.position = next;
    // rust: eye.life += 1;
    // rust: if eye.life <= 80 {
    // rust: return true;
}
    // rust: let at = eye.position.to_array();
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_eye.death", Some(at), 1.0, 1.0);
    // rust: if eye.survive {
                // new ItemEntity(level, x, y, z, item): random spread, 0.2 up.
    // rust: let vx = self.world.random.next_double() * 0.2 - 0.1;
    // rust: let vz = self.world.random.next_double() * 0.2 - 0.1;
    // rust: let stack = ItemStack {
    // rust: item: "minecraft:ender_eye".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: self.spawn_item(stack, at, [vx, 0.2, vz], 0);
    // rust: } else {
    // rust: shattered.push(at.map(|v| v.floor() as i32));
}
    // rust: false
    // rust: });
    // rust: self.end.eyes = eyes;
    // rust: for pos in shattered {
    // rust: self.level_event_at(2003, pos, 0);
}
}

    /// `LevelEventHandler` 2003: a shattered eye's item crumbs and two rings
    /// of portal particles drawn in towards it.
    // rust: pub(super) fn eye_break_particles(&mut self, pos: [i32; 3]) {
    // rust: let (x, y, z) = (
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
    // rust: let crumbs = self.item_particle(&ItemStack::new("minecraft:ender_eye", 1));
    // rust: for _ in 0..8 {
    // rust: let r = self.particles.random();
    // rust: let v = [
    // rust: r.next_gaussian() * 0.15,
    // rust: r.next_double() * 0.2,
    // rust: r.next_gaussian() * 0.15,
    // rust: ];
    // rust: self.particles.add(&crumbs, [x, y, z], v);
}
    // rust: let portal = ParticleOptions::simple(ParticleType::Portal);
    // rust: let mut angle = 0.0f64;
    // rust: while angle < std::f64::consts::PI * 2.0 {
    // rust: let (c, s) = (angle.cos(), angle.sin());
    // rust: let at = [x + c * 5.0, y - 0.4, z + s * 5.0];
    // rust: self.particles.add(&portal, at, [c * -5.0, 0.0, s * -5.0]);
    // rust: self.particles.add(&portal, at, [c * -7.0, 0.0, s * -7.0]);
    // rust: angle += std::f64::consts::PI / 20.0;
}
}

    /// `EyeOfEnder.tick` on a client: behind each eye (a quarter of its last
    /// move back), four bubbles in water, else a portal particle.
    // rust: pub(super) fn eye_particles(&mut self) {
    // rust: for i in 0..self.end.eyes.len() {
    // rust: let e = &self.end.eyes[i];
    // rust: let movement = (e.position - e.previous).to_array();
    // rust: let origin = (e.position - (e.position - e.previous) * 0.25).to_array();
    // rust: let block = origin.map(|v| v.floor() as i32);
    // rust: let water = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(block[0], block[1], block[2]))
    // rust: .fluid
    // rust: == horizon_client::blocks::Fluid::Water;
    // rust: if water {
    // rust: let bubble = ParticleOptions::simple(ParticleType::Bubble);
    // rust: for _ in 0..4 {
    // rust: self.particles.add(&bubble, origin, movement);
}
    // rust: } else {
    // rust: let r = self.particles.random();
    // rust: let x = origin[0] + r.next_double() * 0.6 - 0.3;
    // rust: let z = origin[2] + r.next_double() * 0.6 - 0.3;
    // rust: let portal = ParticleOptions::simple(ParticleType::Portal);
    // rust: self.particles
    // rust: .add(&portal, [x, origin[1] - 0.5, z], movement);
}
}
}
    /// ThrownItemRenderer: the ender eye item facing the camera.
pub fn eye_geometry(self: *Self, camera: glam::DVec3, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: let Some(r) = self.gui.atlas.sprites.get("item/ender_eye").copied() else {
    // rust: return;
}
    // rust: let alpha = self.clock.fraction();
    // rust: let (yaw, pitch) = (self.yaw.to_radians(), self.pitch.to_radians());
    // rust: let right = glam::Vec3::new(-yaw.cos(), 0.0, -yaw.sin()) * 0.25;
    // rust: let up = glam::Vec3::new(
    // rust: -yaw.sin() * pitch.sin(),
    // rust: pitch.cos(),
    // rust: yaw.cos() * pitch.sin(),
    // rust: ) * 0.25;
    // rust: for eye in &self.end.eyes {
    // rust: let p = eye.previous + (eye.position - eye.previous) * alpha - camera;
    // rust: out.extend(eye_quad(p.as_vec3(), right, up, r));
}
}

    // ---- End gateway travel for the entities ----

    /// `EndGatewayBlock.entityInside` for the items, mobs and thrown ender
    /// pearls in the End: the gateway blocks their box swept through. A
    /// gateway that is cooling down (`TheEndGatewayBlockEntity.triggerCooldown`)
    /// takes nobody in.
    // rust: pub(super) fn find_end_gateway_portals(&mut self) {
    // rust: if self.remote.is_some() || self.dim != Dim::End {
    // rust: return;
}
    // rust: let is_gateway = |game: &Self, p: BlockPos| {
    // rust: &*game.res.facts().get(game.world.block(p.x, p.y, p.z)).name == "minecraft:end_gateway"
}
    // rust: let items: Vec<(u32, Vec3, f32, f32)> = self
    // rust: .dropped
    // rust: .iter()
    // rust: .map(|e| (e.id, e.position, 0.25, 0.25))
    // rust: .collect();
    // rust: let mobs: Vec<(u32, Vec3, f32, f32)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| self.mob_can_use_portal(m))
    // rust: .map(|m| (m.id, m.position, m.width(), m.height()))
    // rust: .chain(
    // rust: self.boats
    // rust: .iter()
    // rust: .filter(|b| self.vehicle_can_use_portal(b.id))
    // rust: .map(|b| {
    // rust: (
    // rust: b.id,
    // rust: b.position,
    // rust: super::boats::WIDTH as f32,
    // rust: super::boats::HEIGHT as f32,
    // rust: )
    // rust: }),
    // rust: )
    // rust: .chain(
    // rust: self.carts
    // rust: .iter()
    // rust: .filter(|c| self.vehicle_can_use_portal(c.id))
    // rust: .map(|c| {
    // rust: (
    // rust: c.id,
    // rust: c.position,
    // rust: super::minecarts::WIDTH as f32,
    // rust: super::minecarts::HEIGHT as f32,
    // rust: )
    // rust: }),
    // rust: )
    // rust: .collect();
    // rust: let mut inside: Vec<(u32, BlockPos)> = Vec::new();
    // rust: for (id, to, width, height) in items.into_iter().chain(mobs) {
    // rust: let from = self.portals.before.get(&id).copied().unwrap_or(to);
    // rust: let found = horizon_client::end_gateway::swept_gateway(from, to, width, height, |p| {
    // rust: is_gateway(self, p)
    // rust: });
    // rust: if let Some(pos) = found {
    // rust: inside.push((id, pos));
}
}
        // A pearl's move this tick, from where it started it.
    // rust: let pearls: Vec<(u32, Option<Who>, Option<u32>, BlockPos)> = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .filter_map(|p| {
    // rust: let pos = horizon_client::end_gateway::pearl_gateway(p, |b| is_gateway(self, b))?;
    // rust: Some((p.id, p.owner, p.guest, pos))
    // rust: })
    // rust: .collect();
    // rust: for (id, owner, guest, pos) in pearls {
    // rust: if owner == Some(Who::Player) {
    // rust: self.pearl_owner_in_gateway(guest, pos);
}
    // rust: inside.push((id, pos));
}
    // rust: for (id, pos) in inside {
            // One entity at a time: the gateway cools down for 40 ticks.
    // rust: if !self.gateway_enter([pos.x, pos.y, pos.z]) {
    // rust: continue;
}
            // An entity that just came through any portal stays out of this one.
    // rust: if self.restart_portal_cooldown(id) {
    // rust: continue;
}
    // rust: self.end.gateways.entry(id).or_default().enter(pos);
}
}

    /// `ThrownEnderpearl.onInsideBlock` in an End gateway: its owner's
    /// `ServerPlayer.onInsideBlock`, the enter_block trigger, as if they had
    /// walked in. A guest's pearl triggers theirs; one whose guest has left
    /// has no owner.
pub fn pearl_owner_in_gateway(self: *Self, guest: ?u32, pos: BlockPos) void {
}
    // rust: let state = self.world.block(pos.x, pos.y, pos.z);
    // rust: let Some(conn) = guest else {
    // rust: self.trigger_enter_block(state);
    // rust: return;
}
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: self.as_guest(&mut host, conn, |g| g.trigger_enter_block(state));
    // rust: self.lan = Some(host);
}
}

    /// `Entity.handlePortal` for the entities in an End gateway: they go
    /// through to the gateway's exit, where they wait for its chunks.
    // rust: pub(super) fn handle_end_gateway_portals(&mut self) {
    // rust: if self.remote.is_some() || self.dim != Dim::End {
    // rust: return;
}
    // rust: let ids: Vec<(u32, bool)> = self
    // rust: .dropped
    // rust: .iter()
    // rust: .map(|e| (e.id, true))
    // rust: .chain(self.mobs.iter().map(|m| (m.id, self.mob_can_use_portal(m))))
    // rust: .chain(
    // rust: self.boats
    // rust: .iter()
    // rust: .map(|b| (b.id, self.vehicle_can_use_portal(b.id))),
    // rust: )
    // rust: .chain(
    // rust: self.carts
    // rust: .iter()
    // rust: .map(|c| (c.id, self.vehicle_can_use_portal(c.id))),
    // rust: )
    // rust: .chain(
    // rust: self.creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .filter(|p| matches!(p.kind, ProjectileKind::EnderPearl))
    // rust: .map(|p| (p.id, true)),
    // rust: )
    // rust: .collect();
    // rust: let mut present: std::collections::HashSet<u32> = ids.iter().map(|(id, _)| *id).collect();
        // A pearl waiting for its exit keeps its portal cooldown.
    // rust: present.extend(self.end.arrivals.iter().filter_map(|a| match &a.traveller {
    // rust: Arriving::Pearl(p) => Some(p.id),
    // rust: Arriving::Vehicle(id) => Some(*id),
    // rust: Arriving::Saved(_) => None,
    // rust: }));
    // rust: self.end.gateways.retain(|id, _| present.contains(id));
    // rust: let mut leaving: Vec<(u32, BlockPos)> = Vec::new();
    // rust: for (id, allowed) in ids {
    // rust: let Some(state) = self.end.gateways.get_mut(&id) else {
    // rust: continue;
}
            // The End gateway has no transition time (Portal.getPortalTransitionTime).
    // rust: if let Some(entry) = state.travel(allowed) {
    // rust: leaving.push((id, entry));
}
    // rust: if state.is_done() {
    // rust: self.end.gateways.remove(&id);
}
}
    // rust: for (id, entry) in leaving {
    // rust: self.send_through_gateway(id, entry);
}
}

    /// `Entity.teleportToPortalDestination` for an entity that goes through an
    /// End gateway: a same-level vehicle stays live while the exit loads.
pub fn send_through_gateway(self: *Self, id: u32, gateway: BlockPos) void {
}
    // rust: if matches!(
    // rust: self.level_entity(id as i32),
    // rust: Some(
    // rust: super::commands::Target::Mob(_)
    // rust: | super::commands::Target::Boat(_)
    // rust: | super::commands::Target::Cart(_)
    // rust: )
    // rust: ) {
    // rust: let (job, target) = self.gateway_job([gateway.x, gateway.y, gateway.z]);
    // rust: let arrival = GatewayArrival {
    // rust: traveller: Arriving::Vehicle(id),
    // rust: job,
    // rust: target,
}
    // rust: if let Some(waiting) = self.arrive_through_gateway(arrival) {
    // rust: self.end.arrivals.push(waiting);
}
    // rust: return;
}
    // rust: let tag = if let Some(i) = self.dropped.iter().position(|e| e.id == id) {
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = horizon_client::entity_nbt::item_entity_to_nbt(
    // rust: &self.dropped[i],
    // rust: uuid,
    // rust: self.persist_raw(id),
    // rust: );
            // A gateway keeps the item in its level (teleportSameDimension
            // moves it): it doesn't leave, so no native_entity_leave_level.
    // rust: self.dropped.remove(i);
    // rust: self.native_leave_skip(id);
    // rust: self.detach_entity(id);
    // rust: tag
    // rust: } else if let Some(i) = self.creatures.projectiles.iter().position(|p| p.id == id) {
    // rust: let pearl = Box::new(self.creatures.projectiles.remove(i));
    // rust: self.native_leave_skip(id);
    // rust: let (job, target) = self.gateway_job([gateway.x, gateway.y, gateway.z]);
    // rust: let arrival = GatewayArrival {
    // rust: traveller: Arriving::Pearl(pearl),
    // rust: job,
    // rust: target,
}
            // It is at the exit before it moves this tick, once that has loaded.
    // rust: if let Some(waiting) = self.arrive_through_gateway(arrival) {
    // rust: self.end.arrivals.push(waiting);
}
    // rust: return;
    // rust: } else {
    // rust: return;
}
    // rust: let (job, target) = self.gateway_job([gateway.x, gateway.y, gateway.z]);
    // rust: self.end.arrivals.push(GatewayArrival {
    // rust: traveller: Arriving::Saved(tag),
    // rust: job,
    // rust: target,
    // rust: });
}

    /// The entities that reached a gateway's exit: they land where the
    /// gateway leads, once its chunks have loaded.
    // rust: pub(super) fn resolve_end_gateway_arrivals(&mut self) -> Result<()> {
    // rust: if self.remote.is_some() || self.dim != Dim::End {
    // rust: return Ok(());
}
    // rust: for arrival in std::mem::take(&mut self.end.arrivals) {
    // rust: if let Some(waiting) = self.arrive_through_gateway(arrival) {
    // rust: self.end.arrivals.push(waiting);
}
}
    // rust: Ok(())
}

    /// `Entity.teleport` of a gateway traveller once its exit's chunk has
    /// loaded: an item or a mob joins the chunk it lands in, a pearl flies
    /// on from there. The traveller comes back while it still waits.
pub fn arrive_through_gateway(self: *Self, arrival: GatewayArrival) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = |at: Vec3| ((at.x.floor() as i32) >> 4, (at.z.floor() as i32) >> 4);
    // rust: if !self.world.chunks.contains_key(&chunk(arrival.target))
    // rust: || arrival
    // rust: .job
    // rust: .source_chunk()
    // rust: .is_some_and(|c| !self.world.chunks.contains_key(&c))
    // rust: {
    // rust: return Some(arrival);
}
    // rust: let at = match self.resolve_gateway(arrival.job, arrival.target) {
    // rust: Ok(at) => at,
    // rust: Err(e) => {
                // The traveller waits for the exit: the failure is retried.
    // rust: log::warn!("End gateway: {e}");
    // rust: return Some(arrival);
}
}
    // rust: let key = chunk(at);
    // rust: match arrival.traveller {
    // rust: Arriving::Vehicle(id) => {
    // rust: if let Some(target) = self.level_entity(id as i32) {
                    // Entity.teleportSameDimension keeps the live entity and
                    // its motion, and moves every passenger in the same operation.
    // rust: self.teleport_to_in_level(target, [at.x, at.y, at.z], None, false);
    // rust: self.set_portal_cooldown(id);
    // rust: self.place_portal_ticket(key);
}
}
    // rust: Arriving::Saved(mut tag) => {
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.insert("Pos".into(), doubles([at.x, at.y, at.z]));
    // rust: c.insert("Motion".into(), doubles([0.0, 0.0, 0.0]));
                    // setPortalCooldown before the teleport.
    // rust: c.insert("PortalCooldown".into(), Tag::Int(ENTITY_DELAY));
}
                // A gateway keeps the entity in its level (teleportSameDimension
                // moves it, no addDuringTeleport): it doesn't join again.
    // rust: super::persist::mark_moved(&mut tag);
    // rust: match self
    // rust: .world
    // rust: .loaded_entities
    // rust: .iter_mut()
    // rust: .find(|(k, _)| *k == key)
    // rust: {
    // rust: Some((_, tags)) => tags.push(tag),
    // rust: None => self.world.loaded_entities.push((key, vec![tag])),
}
}
    // rust: Arriving::Pearl(mut pearl) => {
    // rust: horizon_client::end_gateway::place_pearl(&mut pearl, at);
                // ThrownEnderpearl.teleport: placePortalTicket where it came out.
    // rust: self.end.tickets.retain(|(c, _)| *c != key);
    // rust: self.end.tickets.push((key, PORTAL_TICKET));
    // rust: self.add_projectile(*pearl);
}
}
    // rust: None
}

    /// The chunks the entities waiting to arrive need, kept loaded like the
    /// areas a server keeps around its players.
    // rust: pub(super) fn keep_gateway_destinations(&mut self) {
    // rust: let areas = &self.end.areas;
    // rust: self.streaming
    // rust: .extra
    // rust: .retain(|&(c, r)| !(r == 1 && areas.contains(&c)));
        // The pearls' portal tickets hold End chunks, and run out there
        // (TicketType.PORTAL's timeout).
    // rust: let in_end = self.dim == Dim::End;
    // rust: if in_end {
    // rust: self.end.tickets.retain_mut(|(_, ticks)| {
    // rust: *ticks = ticks.saturating_sub(1);
    // rust: *ticks > 0
    // rust: });
}
    // rust: let mut areas = Vec::new();
    // rust: let arrivals = self.end.arrivals.iter().map(|a| {
    // rust: (
    // rust: (a.target.x.floor() as i32) >> 4,
    // rust: (a.target.z.floor() as i32) >> 4,
    // rust: )
    // rust: });
    // rust: let tickets = self.end.tickets.iter().filter(|_| in_end);
    // rust: let sources = self
    // rust: .end
    // rust: .arrivals
    // rust: .iter()
    // rust: .filter_map(|a| a.job.source_chunk());
    // rust: for c in arrivals
    // rust: .chain(tickets.map(|&(c, _)| c))
    // rust: .chain(sources)
    // rust: .chain(self.gateway_source_chunks())
    // rust: {
    // rust: if !areas.contains(&c) {
    // rust: areas.push(c);
    // rust: self.streaming.extra.push((c, 1));
}
}
    // rust: self.end.areas = areas;
}
}

/// item/generated's ground display `translation [0, 2, 0]` is 2/16 of a block, and
/// ThrownItemRenderer draws the eye at scale 1.0.
pub const GROUND_LIFT: f32 = 0.125;

/// `ThrownItemRenderer.submit`: the four camera-facing vertices of an eye of ender at `at` (the
/// entity's position; the quad itself is lifted above it). `right` and `up` are the camera's axes
/// times the quad's 0.25 half extent.
    // rust: fn eye_quad(
    // rust: at: glam::Vec3,
    // rust: right: glam::Vec3,
    // rust: up: glam::Vec3,
    // rust: r: horizon_client::hud::Rect,
    // rust: ) -> [Vertex; 4] {
    // The lift is along the billboard's own up axis (the camera's up, so world +Y only at pitch 0):
    // item/ender_eye parents item/generated with no display override, so its ground transform's
    // `translation [0, 2, 0]` = 0.125 blocks applies here.
    // rust: let c = at + up.normalize() * GROUND_LIFT;
    // rust: [
    // rust: (c - right - up, [r.u0, r.v1]),
    // rust: (c + right - up, [r.u1, r.v1]),
    // rust: (c + right + up, [r.u1, r.v0]),
    // rust: (c - right + up, [r.u0, r.v0]),
    // rust: ]
    // rust: .map(|(pos, uv)| Vertex {
    // rust: normal: [0; 4],
    // rust: pos: pos.to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light: (15 * 16) | ((15 * 16) << 8),
    // rust: glint_uv: [0.0, 0.0],
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::containers::EndGateway;

pub fn a_new_exit_keeps_the_gateways_exact_teleport() void {
}
    // rust: let exact = BlockEntity::EndGateway(EndGateway {
    // rust: exact_teleport: true,
    // rust: ..Default::default()
    // rust: });
    // rust: let plain = BlockEntity::EndGateway(EndGateway::default());
    // rust: assert!(exact_teleport(Some(&exact)));
    // rust: assert!(!exact_teleport(Some(&plain)));
    // rust: assert!(!exact_teleport(None));
    // rust: assert!(!exact_teleport(Some(&BlockEntity::DaylightDetector)));
    // rust: let exit = [8, 100, 0];
        // Exact: the exit itself, nothing is searched for.
    // rust: assert_eq!(exit_target(exit, true, |_| panic!("searched")), exit);
    // rust: assert_eq!(
    // rust: exit_target(exit, false, |e| [e[0], e[1] + 11, e[2]]),
    // rust: [8, 111, 0]
    // rust: );
}

pub fn leaving_the_end_without_a_point_of_its_own_goes_to_the_world_spawn() void {
}
    // rust: let world = Some([220, 63, -41]);
    // rust: assert_eq!(fallback_spawn(None, world), Vec3::new(220.5, 63.0, -40.5));
    // rust: assert_eq!(
    // rust: fallback_spawn(Some(Vec3::new(10.5, 70.0, 12.5)), world),
    // rust: Vec3::new(10.5, 70.0, 12.5)
    // rust: );
    // rust: assert_eq!(fallback_spawn(None, None), Vec3::new(0.5, 64.0, 0.5));
}

pub fn end_gateway_job_reads_the_block_entity_and_keeps_new_sources_loaded() void {
}
    // rust: let gateway = [702, 100, 0];
    // rust: let exit = [8, 100, 0];
    // rust: for exact in [true, false] {
    // rust: let entity = BlockEntity::EndGateway(EndGateway {
    // rust: exit_portal: Some(exit),
    // rust: exact_teleport: exact,
    // rust: ..Default::default()
    // rust: });
    // rust: assert_eq!(
    // rust: GatewayJob::for_gateway(gateway, Some(&entity)),
    // rust: GatewayJob::Known { exit, exact },
    // rust: );
}
    // rust: let empty = BlockEntity::EndGateway(EndGateway::default());
    // rust: for entity in [None, Some(&empty)] {
    // rust: assert_eq!(
    // rust: GatewayJob::for_gateway(gateway, entity),
    // rust: GatewayJob::Known {
    // rust: exit: END_SPAWN,
    // rust: exact: true
}
    // rust: );
    // rust: let nearby = [96, 75, 0];
    // rust: let exact = BlockEntity::EndGateway(EndGateway {
    // rust: exact_teleport: true,
    // rust: ..Default::default()
    // rust: });
    // rust: assert_eq!(
    // rust: GatewayJob::for_gateway(nearby, Some(&exact)),
    // rust: GatewayJob::Find {
    // rust: gateway: nearby,
    // rust: exact: true
}
    // rust: );
    // rust: assert_eq!(
    // rust: GatewayJob::for_gateway(nearby, entity),
    // rust: GatewayJob::Find {
    // rust: gateway: nearby,
    // rust: exact: false
}
    // rust: );
}
}

    /// The eye sprite's atlas region; only its UVs are used here.
pub fn eye_rect() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::hud::Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
}
}

pub fn a_thrown_eye_is_lifted_by_the_item_ground_transform() void {
}
    // rust: let right = glam::Vec3::X * 0.25;
    // rust: let up = glam::Vec3::Y * 0.25;
    // rust: let quad = eye_quad(glam::Vec3::new(0.0, 100.0, 0.0), right, up, eye_rect());
    // rust: let corners = quad.map(|v| glam::Vec3::from_array(v.pos));
    // rust: let centre = corners.iter().copied().sum::<glam::Vec3>() / 4.0;
    // rust: let low = corners.iter().copied().reduce(glam::Vec3::min).unwrap();
    // rust: let high = corners.iter().copied().reduce(glam::Vec3::max).unwrap();
        // The eye at y = 100 + item/generated's 0.125 lift.
    // rust: assert!(
    // rust: centre.abs_diff_eq(glam::Vec3::new(0.0, 100.125, 0.0), 1e-5),
    // rust: "{centre}"
    // rust: );
    // rust: assert_eq!((low.x, high.x), (-0.25, 0.25));
    // rust: assert_eq!((high.x - low.x) * 0.5, 0.25);
    // rust: assert_eq!((high.y - low.y) * 0.5, 0.25);
        // ThrownItemRenderer draws the eye full-bright.
    // rust: assert!(quad.iter().all(|v| v.light == 0xF0F0));
}

pub fn a_thrown_eye_is_lifted_along_the_cameras_up_axis() void {
}
        // A camera tilted down 45 degrees: its up axis is (0, 1, 1)/sqrt(2), so the lift must
        // move the quad along that axis, not straight up world Y.
    // rust: let up_dir = glam::Vec3::new(0.0, 1.0, 1.0).normalize();
    // rust: let at = glam::Vec3::new(0.0, 100.0, 0.0);
    // rust: let quad = eye_quad(at, glam::Vec3::X * 0.25, up_dir * 0.25, eye_rect());
    // rust: let corners = quad.map(|v| glam::Vec3::from_array(v.pos));
    // rust: let centre = corners.iter().copied().sum::<glam::Vec3>() / 4.0;
    // rust: assert!((centre - at).abs_diff_eq(up_dir * 0.125, 1e-5), "{centre}");
}

    /// `endFlashPosition`'s direction: the flash sprite's centre, 100 blocks away.
pub fn the_end_flash_is_where_its_sprite_is() void {
}
    // rust: let at =
    // rust: |x: f32, y: f32| flash_pose(x, y).transform_point3(glam::Vec3::new(0.0, 100.0, 0.0));
        // Straight up whatever the turn, and level toward the north at y_angle 180.
    // rust: assert!(at(-90.0, 37.0).abs_diff_eq(glam::Vec3::new(0.0, 100.0, 0.0), 1e-3));
    // rust: assert!(at(0.0, 180.0).abs_diff_eq(glam::Vec3::new(0.0, 0.0, -100.0), 1e-3));
    // rust: for (x, y) in [(-60.0, -180.0), (10.0, 95.0), (-25.0, 3.0)] {
    // rust: assert!((at(x, y).length() - 100.0).abs() < 1e-3);
}
}
}
