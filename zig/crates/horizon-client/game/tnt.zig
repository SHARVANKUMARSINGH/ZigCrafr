//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tnt
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Primed TNT (`PrimedTnt`): 80-tick fuse, gravity and drag, explosion of
//! power 4, `TntRenderer` swell and white flash, and `TntBlock.useItemOn`
//! (flint and steel / fire charge).
// use super::{Game, entity::Entity};
// use horizon_client::entity_rules::EntityRules;
// use horizon_client::{
    // rust: Result, collisions::SceneCollisions, items::ItemStack, mesher::Vertex, mobs::Who, text::Text,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::level::flags as level_flags;

    // rust: pub(super) struct PrimedTnt {
    /// `Entity.yRot` and `xRot` (`/tp`, `/data get ... Rotation`).
    // rust: pub rotation: [f32; 2],
    /// When it joined its list (`horizon_client::join_seq`); set by the list.
    // rust: pub(super) join: horizon_client::join_seq::JoinSeq,
    /// The entity id a server tracks it by (0 until it is tracked).
    // rust: pub id: u32,
    // rust: pub position: Vec3,
    // rust: pub previous: Vec3,
    // rust: pub velocity: Vec3,
    // rust: pub fuse: i32,
    // rust: pub on_ground: bool,
    // rust: pub owner: Option<Who>,
    // rust: pub guest: Option<u32>,
    /// `Entity.noGravity` (`NoGravity` in its save).
    // rust: pub no_gravity: bool,
    /// `PrimedTnt.explosionPower`: 4 by default, saved as `explosion_power`
    /// and clamped to 0..128 when read back.
    // rust: pub power: f32,
    /// PrimedTnt.DATA_BLOCK_STATE_ID; None is the default TNT state.
    // rust: pub block_state: Option<horizon_world::registry::BlockStateId>,
}
    // rust: impl PrimedTnt {
    /// The live state encoded for each existing save view.
    // rust: pub(super) fn block_state_nbt(
    // rust: &self,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: ) -> horizon_world::nbt::Tag {
    // rust: self.block_state.map_or_else(
    // rust: || horizon_world::nbt::Tag::String("minecraft:tnt".into()),
    // rust: |state| horizon_client::entity_nbt::state_to_nbt(registry, state),
    // rust: )
}

    // rust: pub(super) const SIZE: f64 = 0.98;
    // rust: pub(super) fn bounds(&self) -> Aabb {
    // rust: let h = Self::SIZE / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(self.position.x - h, self.position.y, self.position.z - h),
    // rust: Vec3::new(
    // rust: self.position.x + h,
    // rust: self.position.y + Self::SIZE,
    // rust: self.position.z + h,
    // rust: ),
    // rust: )
}
    // rust: pub(super) fn tick(
    // rust: &mut self,
    // rust: world: &horizon_client::world::World,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: assets: &horizon_client::assets::Assets,
    // rust: facts: &horizon_client::blocks::BlockFacts,
    // rust: fluids: &horizon_client::motion::FluidResources,
    // rust: border: Option<&horizon_core::geometry::border::BorderGeometry>,
    // rust: blocks: Option<&horizon_world::movement_properties::BoundMovementProperties>,
    // rust: ) -> Result<Vec<BlockPos>> {
    // rust: self.previous = self.position;
    // rust: self.velocity.y -= self.get_gravity();
    // rust: let scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let wanted = self.velocity;
        // Entity.collide: the world border's walls stop it too.
    // rust: let border = border.map(|b| (b, [self.position.x, self.position.z]));
    // rust: let moved = scene
    // rust: .resolve_in_border(self.bounds(), wanted, 0.0, self.on_ground, border)
    // rust: .unwrap_or(Vec3::ZERO);
    // rust: if horizon_client::entities::move_applies(wanted, moved) {
    // rust: self.position = Vec3::new(
    // rust: self.position.x + moved.x,
    // rust: self.position.y + moved.y,
    // rust: self.position.z + moved.z,
    // rust: );
}
    // rust: self.on_ground = wanted.y < 0.0 && moved.y != wanted.y;
    // rust: if moved.x != wanted.x {
    // rust: self.velocity.x = 0.0;
}
    // rust: if moved.z != wanted.z {
    // rust: self.velocity.z = 0.0;
}
    // rust: if moved.y != wanted.y {
            // Entity.restituteMovementAfterCollisions: slime bounces it.
    // rust: let below = world.block(
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - f64::from(1.0e-5_f32)).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: self.velocity.y = horizon_client::entities::vertical_collision_velocity(
    // rust: wanted.y,
    // rust: moved.y,
    // rust: 0.04,
    // rust: wanted.y < 0.0,
    // rust: &*facts.get(below).name == "minecraft:slime_block",
    // rust: );
}
        // Entity.move's last step: soul sand and honey slow the TNT's
        // horizontal speed. `blocks` is None only for the isolated unit tests.
    // rust: if let Some(blocks) = blocks {
    // rust: let factor =
    // rust: horizon_client::motion::block_speed_factor_at(world, blocks, self.position, None);
    // rust: self.velocity = horizon_world::entity_move::scale_by_block_speed(self.velocity, factor);
}
        // Entity.applyEffectsFromBlocks: a bubble column lifts or drags it, and the
        // columns it is at the top of send their surface particles.
    // rust: let mut tops = Vec::new();
    // rust: self.push_by_bubble_column_over(world, assets.registry, facts, collision, |pos| {
    // rust: tops.push(pos)
    // rust: });
    // rust: if self.on_ground {
            // Entity.applyEffectsFromBlocks -> SlimeBlock.stepOn.
    // rust: let under = world.block(
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - f64::from(0.2_f32)).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: if &*facts.get(under).name == "minecraft:slime_block"
    // rust: && let Some(scale) = horizon_client::entities::slime_step_on_scale(self.velocity.y)
    // rust: {
    // rust: self.velocity.x *= scale;
    // rust: self.velocity.z *= scale;
}
}
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.98,
    // rust: self.velocity.y * 0.98,
    // rust: self.velocity.z * 0.98,
    // rust: );
    // rust: if self.on_ground {
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.7,
    // rust: self.velocity.y * -0.5,
    // rust: self.velocity.z * 0.7,
    // rust: );
}
    // rust: self.fuse -= 1;
    // rust: if self.fuse > 0 {
            // PrimedTnt updates immersion after moving and decrementing its fuse.
    // rust: self.push_by_fluid(world, fluids);
}
    // rust: Ok(tops)
}
}

    // rust: impl Game<'_> {
    /// Asks the mods whether the TNT at `pos` may be primed
    /// (`native_tnt_primed`); the acting guest, if any, is its player.
    // rust: pub(super) fn tnt_prime_allowed(&mut self, pos: BlockPos) -> bool {
    // rust: let mut cancel = false;
    // rust: self.native_tnt_primed(self.lan_acting_uuid, [pos.x, pos.y, pos.z], &mut cancel);
        // `TntBlock.prime` leaves the block alone with `tnt_explodes` off, for
        // redstone, fire and an unstable block breaking alike.
    // rust: !cancel && self.ui.rules.bool("tnt_explodes")
}
    /// Primes TNT a level event announced, or, when the mods refuse, puts
    /// back the block the fire or signal had already taken out.
    // rust: pub(super) fn prime_tnt_event(&mut self, pos: BlockPos, rot: f64) {
    // rust: if self.tnt_prime_allowed(pos) {
    // rust: self.add_primed_tnt(pos, rot, 80, None, None);
    // rust: return;
}
        // Refused: the level queued the fuse sound and the game event right
        // after the prime; they are dropped as they come up.
    // rust: self.tnt_refused = Some(pos);
    // rust: let Some(tnt) = self.pack.assets.registry.default_state("minecraft:tnt") else {
    // rust: return;
}
    // rust: if self.world.block(pos.x, pos.y, pos.z) == self.world.air {
    // rust: let flags = level_flags::UPDATE_CLIENTS | level_flags::UPDATE_SKIP_ON_PLACE;
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, pos, tnt, flags));
}
}
    /// `new PrimedTnt(level, x + 0.5, y, z + 0.5, owner)`; `short` applies
    /// `wasExploded`'s random short fuse. Plays `entity.tnt.primed` for primes.
    // rust: pub(super) fn spawn_primed_tnt(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: short: bool,
    // rust: owner: Option<Who>,
    // rust: guest: Option<u32>,
    // rust: ) {
        // PrimedTnt: the fuse is lit.
    // rust: let who = self.sculk_actor();
    // rust: self.post_block_game_event("minecraft:prime_fuse", [pos.x, pos.y, pos.z], who, None);
    // rust: let r = &mut self.world.random;
    // rust: let rot = r.next_double() * f64::from(std::f32::consts::TAU);
    // rust: let fuse = if short {
            // PrimedTnt.getRandomShortFuse
    // rust: r.next_int_bound(20).unwrap_or(0) + 10
    // rust: } else {
    // rust: self.audio.play(
    // rust: "minecraft:entity.tnt.primed",
    // rust: Some([
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y),
    // rust: f64::from(pos.z) + 0.5,
    // rust: ]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: 80
}
    // rust: self.add_primed_tnt(pos, rot, fuse, owner, guest);
}
    /// Adds primed TNT at the block's bottom centre, pushed along `rot`.
    // rust: pub(super) fn add_primed_tnt(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: rot: f64,
    // rust: fuse: i32,
    // rust: owner: Option<Who>,
    // rust: guest: Option<u32>,
    // rust: ) {
    // rust: let position = Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y),
    // rust: f64::from(pos.z) + 0.5,
    // rust: );
        // An id from the entity counter at once, so a command can name it.
    // rust: self.next_entity += 1;
    // rust: self.tnts.push(PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: self.next_entity,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::new(-rot.sin() * 0.02, f64::from(0.2f32), -rot.cos() * 0.02),
    // rust: fuse,
    // rust: on_ground: false,
    // rust: owner,
    // rust: guest,
            // PrimedTnt's constructor: 4 when nothing sets it.
    // rust: power: 4.0,
    // rust: block_state: None,
    // rust: });
}
    /// `PrimedTnt.tick` for every primed TNT, in order; an expired fuse
    /// explodes immediately (later TNT in the list feel its knockback this
    /// tick). TNT primed by an explosion starts ticking next tick.
    /// One primed TNT's `tick`: it moves, and explodes when its fuse is out.
    /// `i` is its place in the list; the caller has checked it is ticking.
    // rust: pub(super) fn tick_one_tnt(&mut self, i: usize) -> Result<()> {
    // rust: let t = &mut self.tnts[i];
    // rust: let tops = t.tick(
    // rust: &self.world,
    // rust: self.collision,
    // rust: &self.pack.assets,
    // rust: self.res.facts(),
    // rust: &self.res.motion().fluids,
    // rust: Some(self.border.geometry()),
    // rust: Some(&self.res.motion().blocks),
    // rust: )?;
    // rust: let snow = (t.previous, t.position, t.bounds(), t.velocity);
    // rust: self.entity_powder_snow_particles(snow.0, snow.1, snow.2, snow.3, false);
    // rust: for pos in tops {
    // rust: self.bubble_column_particles(pos);
}
    // rust: let t = &mut self.tnts[i];
    // rust: if t.fuse <= 0 {
    // rust: let center = [
    // rust: t.position.x,
    // rust: t.position.y + PrimedTnt::SIZE * 0.0625,
    // rust: t.position.z,
    // rust: ];
    // rust: let bounds = t.bounds();
    // rust: let (owner, guest, power) = (t.owner, t.guest, t.power);
    // rust: let in_water = self.bounds_in_water(bounds);
    // rust: self.tnts.remove(i);
            // PrimedTnt.tick: with `tnt_explodes` off it goes away without exploding.
    // rust: if !self.ui.rules.bool("tnt_explodes") {
    // rust: return Ok(());
}
            // ExplosionInteraction.TNT: the tnt_explosion_drop_decay rule.
    // rust: let interaction = self.destroy_type("tnt_explosion_drop_decay");
    // rust: self.combat.explosion_in_water = in_water;
            // `Explosion.getIndirectSourceEntity`: a player-lit TNT names
            // its igniter, which `blast_attacker` and the damage type read.
    // rust: self.combat.blast_guest = guest;
    // rust: self.combat.blast_owner = tnt_blast_owner(
    // rust: owner,
    // rust: || {
    // rust: self.lan
    // rust: .as_ref()
    // rust: .and_then(|host| self.player_attacker(host, guest))
    // rust: },
    // rust: |id| self.mob_display_name(id),
    // rust: );
    // rust: let result = self
    // rust: .with_hive_emptying_blast(|g| g.server_explode(center, power, interaction, false));
    // rust: self.combat.blast_owner = None;
    // rust: self.combat.blast_guest = None;
    // rust: self.combat.explosion_in_water = false;
    // rust: result?;
}
    // rust: Ok(())
}
    /// `TntBlock.useItemOn`: flint and steel or a fire charge primes TNT.
    // rust: pub(super) fn ignite_tnt(&mut self, stack: &ItemStack) -> Result<bool> {
    // rust: let item = &*stack.item;
    // rust: if item != "minecraft:flint_and_steel" && item != "minecraft:fire_charge" {
    // rust: return Ok(false);
}
    // rust: let Some(hit) = self.pick() else {
    // rust: return Ok(false);
}
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: if &*self.res.facts().get(state).name != "minecraft:tnt" {
    // rust: return Ok(false);
}
    // rust: let pos = BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: if !self.ui.rules.bool("tnt_explodes") {
            // TntBlock.useItemOn: the rule is off, the acting player's overlay
            // says so, and PASS lets the item's own useOn light a fire there.
    // rust: let message = Text::translate("block.minecraft.tnt.disabled", &[]);
    // rust: self.send_overlay_message(message);
    // rust: return Ok(false);
}
    // rust: if !self.tnt_prime_allowed(pos) {
    // rust: return Ok(true);
}
    // rust: let guest = self.lan_acting;
    // rust: self.spawn_primed_tnt(pos, false, Some(Who::Player), guest);
    // rust: let air = self.world.air;
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, pos, air, level_flags::UPDATE_ALL_IMMEDIATE)
    // rust: });
    // rust: self.process_level_events()?;
    // rust: self.swing_arm();
    // rust: if item == "minecraft:flint_and_steel" {
    // rust: self.damage_held(1);
    // rust: } else {
    // rust: self.consume_held();
}
    // rust: self.award_stat("used", item, 1);
    // rust: Ok(true)
}
    /// `TntRenderer`: the block centred on the entity, swelling over the last
    /// 10 ticks and flashing white every 5 ticks.
    // rust: pub(super) fn tnt_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: if self.tnts.is_empty() {
    // rust: return;
}
    // rust: let Some(state) = self.pack.assets.registry.default_state("minecraft:tnt") else {
    // rust: return;
}
        // Face sprites from the block model: up, down, north, south, west, east.
    // rust: let Ok(models) = self
    // rust: .pack
    // rust: .render
    // rust: .model_catalog
    // rust: .collect(state, BlockPos::new(0, 0, 0))
    // rust: else {
    // rust: return;
}
    // rust: let mut sprites = [None; 6];
    // rust: for face in models.iter().flat_map(|(_, m)| m.faces.iter()) {
//             use horizon_assets::model::Direction as D;
    // rust: let index = match face.quad.facing {
    // rust: D::Up => 0,
    // rust: D::Down => 1,
    // rust: D::North => 2,
    // rust: D::South => 3,
    // rust: D::West => 4,
    // rust: D::East => 5,
}
    // rust: if sprites[index].is_none() {
    // rust: sprites[index] = self
    // rust: .pack
    // rust: .layer_names
    // rust: .get(&face.layer)
    // rust: .and_then(|name| self.gui.atlas.sprites.get(name).copied());
}
}
    // rust: let range = super::entity_culling::default_range(
    // rust: glam::DVec3::splat(PrimedTnt::SIZE),
    // rust: self.view_scale(),
    // rust: );
    // rust: for t in &self.tnts {
            // EntityRenderer.shouldRender.
    // rust: if !self.standing_entity_in_view(
    // rust: camera,
    // rust: super::entity_culling::at(t.previous),
    // rust: super::entity_culling::at(t.position),
    // rust: alpha,
    // rust: PrimedTnt::SIZE,
    // rust: PrimedTnt::SIZE,
    // rust: range,
    // rust: 0.0,
    // rust: ) {
    // rust: continue;
}
    // rust: let fuse = t.fuse as f32 - alpha as f32 + 1.0;
    // rust: let scale = if fuse < 10.0 {
    // rust: let g = (1.0 - fuse / 10.0).clamp(0.0, 1.0);
    // rust: 1.0 + g * g * g * g * 0.3
    // rust: } else {
    // rust: 1.0
}
    // rust: let lit = fuse >= 0.0 && (fuse / 5.0) as i32 % 2 == 0;
    // rust: let base = glam::DVec3::new(
    // rust: t.previous.x + (t.position.x - t.previous.x) * alpha,
    // rust: t.previous.y + (t.position.y - t.previous.y) * alpha + 0.5,
    // rust: t.previous.z + (t.position.z - t.previous.z) * alpha,
    // rust: ) - camera;
    // rust: let o = base.as_vec3();
    // rust: let light = self.world.light(
    // rust: t.position.x.floor() as i32,
    // rust: (t.position.y + 0.5).floor() as i32,
    // rust: t.position.z.floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let v = |x: f32, y: f32, z: f32| o + glam::Vec3::new(x - 0.5, y - 0.5, z - 0.5) * scale;
    // rust: let faces = [
    // rust: (
    // rust: [v(0., 1., 1.), v(1., 1., 1.), v(1., 1., 0.), v(0., 1., 0.)],
    // rust: 1.0,
    // rust: ),
    // rust: (
    // rust: [v(0., 0., 0.), v(1., 0., 0.), v(1., 0., 1.), v(0., 0., 1.)],
    // rust: 0.5,
    // rust: ),
    // rust: (
    // rust: [v(1., 0., 0.), v(0., 0., 0.), v(0., 1., 0.), v(1., 1., 0.)],
    // rust: 0.8,
    // rust: ),
    // rust: (
    // rust: [v(0., 0., 1.), v(1., 0., 1.), v(1., 1., 1.), v(0., 1., 1.)],
    // rust: 0.8,
    // rust: ),
    // rust: (
    // rust: [v(0., 0., 0.), v(0., 0., 1.), v(0., 1., 1.), v(0., 1., 0.)],
    // rust: 0.6,
    // rust: ),
    // rust: (
    // rust: [v(1., 0., 1.), v(1., 0., 0.), v(1., 1., 0.), v(1., 1., 1.)],
    // rust: 0.6,
    // rust: ),
    // rust: ];
    // rust: for ((corners, shade), sprite) in faces.into_iter().zip(sprites) {
    // rust: let Some(r) = sprite else { continue };
    // rust: let c = (255.0 * shade) as u32;
    // rust: let color = 0xFF00_0000 | c << 16 | c << 8 | c;
    // rust: for (p, uv) in
    // rust: corners
    // rust: .iter()
    // rust: .zip([[r.u0, r.v1], [r.u1, r.v1], [r.u1, r.v0], [r.u0, r.v0]])
    // rust: {
                    // Overlay 5: OverlayTexture white flash.
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.to_array(),
    // rust: uv,
    // rust: layer: if lit { 5 } else { 0 },
    // rust: color,
    // rust: light: packed,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
}

    // rust: impl Game<'_> {
    /// `positionRider` for the mobs riding primed TNT: the passenger attachment
    /// (the top of its 0.98 box), less the rider's own vehicle attachment.
    // rust: pub(super) fn seat_tnt_mobs(&mut self, riders: &super::passengers::Riders) {
    // rust: for i in 0..self.tnts.len() {
    // rust: let (id, pos, prev) = (
    // rust: self.tnts[i].id,
    // rust: self.tnts[i].position,
    // rust: self.tnts[i].previous,
    // rust: );
    // rust: let Some(js) = riders.get(&id).filter(|_| id != 0) else {
    // rust: continue;
}
    // rust: for &j in js {
    // rust: let m = &mut self.mobs[j];
                // Primed TNT's box is 0.98 wide.
    // rust: let offset = horizon_client::mobs::riders::vehicle_attachment(m, 0.98);
    // rust: m.position = tnt_seat(pos, offset);
    // rust: m.previous = tnt_seat(prev, offset);
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.fall_distance = 0.0;
    // rust: m.on_ground = false;
    // rust: m.extra.passenger = true;
    // rust: m.ai.nav.stop();
}
}
}
}

/// `PrimedTnt.getOwner` as the blast's causing entity: the player, or a mob
/// that is still in the level (null once it is gone).
    // rust: fn tnt_blast_owner(
    // rust: owner: Option<Who>,
    // rust: player: impl FnOnce() -> Option<(u32, Text)>,
    // rust: mob_name: impl Fn(u32) -> Option<Text>,
    // rust: ) -> Option<(u32, Text)> {
    // rust: match owner? {
    // rust: Who::Player => player(),
    // rust: Who::Mob(id) => mob_name(id).map(|name| (id, name)),
}
}

pub fn tnt_seat(tnt: Vec3, rider_offset: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(tnt.x, tnt.y + PrimedTnt::SIZE - rider_offset, tnt.z)
}

    // rust: mod tests {
//     use super::*;

pub fn saved_block_state_follows_the_model_instead_of_raw_input() void {
}
//         use horizon_world::{
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
    // rust: let unstable = Tag::compound([
    // rust: ("id", Tag::String("minecraft:tnt".into())),
    // rust: (
    // rust: "properties",
    // rust: Tag::compound([("unstable", Tag::String("true".into()))]),
    // rust: ),
    // rust: ]);
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![
    // rust: Tag::String("minecraft:tnt".into()),
    // rust: Tag::String("minecraft:stone".into()),
    // rust: unstable.clone(),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:tnt", Tag::Int(0)),
    // rust: ("minecraft:stone", Tag::Int(1)),
    // rust: ]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap();
    // rust: let mut tnt = PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id: 1,
    // rust: position: Vec3::ZERO,
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::ZERO,
    // rust: fuse: 400,
    // rust: on_ground: false,
    // rust: owner: None,
    // rust: guest: None,
    // rust: no_gravity: true,
    // rust: power: 4.0,
    // rust: block_state: Some(BlockStateId(1)),
}
    // rust: let raw = Tag::compound([("block_state", Tag::String("audit_missing:block".into()))]);
    // rust: for (state, expected) in [
    // rust: (Some(BlockStateId(1)), Tag::String("minecraft:stone".into())),
    // rust: (Some(BlockStateId(2)), unstable),
    // rust: (None, Tag::String("minecraft:tnt".into())),
    // rust: ] {
    // rust: tnt.block_state = state;
    // rust: let saved = horizon_client::entity_nbt::tnt_to_nbt(
    // rust: tnt.position,
    // rust: tnt.velocity,
    // rust: tnt.on_ground,
    // rust: tnt.fuse,
    // rust: tnt.power,
    // rust: tnt.block_state_nbt(&registry),
    // rust: [0.0, 0.0],
    // rust: [221, 0, 0, 1],
    // rust: Some(&raw),
    // rust: );
    // rust: assert_eq!(saved.get("block_state"), Some(&expected));
}
}

pub fn a_tnt_lit_by_a_skeletons_arrow_names_the_skeleton_as_its_cause() void {
}
    // rust: let name = || Text::translate("entity.minecraft.skeleton", &[]);
    // rust: let by_mob = tnt_blast_owner(Some(Who::Mob(7)), || None, |id| (id == 7).then(name));
    // rust: assert_eq!(by_mob, Some((7, name())));
        // The skeleton died before the blast: `getOwner` is null.
    // rust: assert_eq!(tnt_blast_owner(Some(Who::Mob(7)), || None, |_| None), None);
    // rust: let player = Text::literal("Steve");
    // rust: let by_player = tnt_blast_owner(Some(Who::Player), || Some((1, player.clone())), |_| None);
    // rust: assert_eq!(by_player, Some((1, player)));
    // rust: assert_eq!(tnt_blast_owner(None, || None, |_| None), None);
}

pub fn a_rider_sits_on_top_of_the_tnt_less_its_own_attachment() void {
}
        // 64 + 0.98 (the box's top) - 0.14 (a rider's vehicle attachment).
    // rust: let seat = tnt_seat(Vec3::new(1.5, 64.0, -2.5), 0.14);
    // rust: assert_eq!((seat.x, seat.z), (1.5, -2.5));
    // rust: assert!((seat.y - 64.84).abs() < 1e-9);
}

pub fn a_piston_slime_bounce_launches_primed_tnt() void {
}
//         use horizon_core::geometry::Direction;
//         use horizon_world::piston_push::bounce_velocity;
    // rust: let mut tnt = PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: Vec3::new(0.5, 1.0, 0.5),
    // rust: previous: Vec3::new(0.5, 1.0, 0.5),
    // rust: velocity: Vec3::ZERO,
    // rust: fuse: 80,
    // rust: on_ground: true,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
}
    // rust: tnt.velocity = bounce_velocity(Direction::Up, tnt.velocity);
    // rust: tnt.on_ground = false;
    // rust: assert_eq!(tnt.velocity.y, 1.0);
    // rust: assert!(!tnt.on_ground);
}

    /// `Entity.collectColliders` (#7080): the world border's wall stops primed
    /// TNT. A border of size 10 around (20, 20) has its east wall at x = 25;
    /// the TNT starts at x = 24 on the test scene's flat ground, 1.5 east.
pub fn the_world_border_stops_primed_tnt() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = horizon_client::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = horizon_client::collisions::load(&root, assets.registry).unwrap();
    // rust: let world = horizon_client::world::World::test_scene(&assets, &render, 3).unwrap();
    // rust: let border =
    // rust: horizon_core::geometry::border::BorderGeometry::new([20.0, 20.0], 10.0, 29_999_984)
    // rust: .unwrap();
    // rust: for bordered in [false, true] {
    // rust: let at = Vec3::new(24.0, 4.0, 20.5);
    // rust: let mut tnt = PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::new(1.5, 0.0, 0.0),
    // rust: fuse: 80,
    // rust: on_ground: true,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
}
    // rust: let border = bordered.then_some(&border);
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, border, None)
    // rust: .unwrap();
    // rust: let east = tnt.bounds().max_position().x;
    // rust: if bordered {
    // rust: assert!(
    // rust: (east - 25.0).abs() < 1.0e-7,
    // rust: "stops on the wall, got {east}"
    // rust: );
    // rust: } else {
    // rust: assert!(east > 25.0, "no border: goes on, got {east}");
}
}
}

    /// `Entity.move`'s last step, `getBlockSpeedFactor`: primed TNT sliding
    /// over soul sand or honey keeps 40% of the horizontal speed it keeps over
    /// stone. Skips quietly without the vanilla data (CI has none).
pub fn primed_tnt_on_soul_sand_or_honey_is_slowed_by_the_move() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = horizon_client::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = horizon_client::collisions::load(&root, assets.registry).unwrap();
    // rust: let motion = horizon_client::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut after = Vec::new();
        // The tops of the blocks: stone 1, soul sand 7/8, honey 15/16.
    // rust: for (block, top) in [
    // rust: ("minecraft:stone", 4.0),
    // rust: ("minecraft:soul_sand", 3.875),
    // rust: ("minecraft:honey_block", 3.9375),
    // rust: ] {
    // rust: let mut world = horizon_client::world::World::test_scene(&assets, &render, 3).unwrap();
    // rust: let id = assets.registry.default_state(block).unwrap();
    // rust: for x in 18..=23 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, id).unwrap();
}
}
    // rust: let at = Vec3::new(19.5, top, 20.5);
    // rust: let mut tnt = PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::new(0.2, 0.0, 0.0),
    // rust: fuse: 80,
    // rust: on_ground: true,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
}
    // rust: tnt.tick(
    // rust: &world,
    // rust: &collision,
    // rust: &assets,
    // rust: &facts,
    // rust: &fluids,
    // rust: None,
    // rust: Some(&motion.blocks),
    // rust: )
    // rust: .unwrap();
    // rust: after.push(tnt.velocity.x);
}
    // rust: let (stone, soul, honey) = (after[0], after[1], after[2]);
    // rust: assert!(stone > 0.0);
    // rust: assert!(
    // rust: (soul - stone * f64::from(0.4_f32)).abs() < 1.0e-9,
    // rust: "soul sand {soul} vs stone {stone}"
    // rust: );
    // rust: assert!(
    // rust: (honey - stone * f64::from(0.4_f32)).abs() < 1.0e-9,
    // rust: "honey {honey} vs stone {stone}"
    // rust: );
}

pub fn primed_tnt_follows_water_currents_after_moving() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = horizon_client::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = horizon_client::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = horizon_client::world::World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let mut state = assets.registry.state(water).unwrap().clone();
    // rust: state.properties.insert("level".into(), "1".into());
    // rust: let flowing = assets.registry.resolve(&state).unwrap();
    // rust: for x in 19..=22 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, stone).unwrap();
}
}
    // rust: world.set(20, 4, 20, water).unwrap();
    // rust: world.set(21, 4, 20, flowing).unwrap();
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let mut tnt = PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: fuse: 80,
    // rust: on_ground: false,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
}
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: tnt.position.x, at.x,
    // rust: "current is applied after motion, not before"
    // rust: );
    // rust: assert!(
    // rust: (tnt.velocity.x - 0.014).abs() < 1e-12,
    // rust: "water must push primed TNT east: {:?}",
    // rust: tnt.velocity
    // rust: );
    // rust: assert_eq!(tnt.fuse, 79);
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
    // rust: assert!((tnt.position.x - at.x - 0.014).abs() < 1e-12);
    // rust: assert!(tnt.on_ground);
    // rust: tnt.position = at;
    // rust: tnt.velocity = Vec3::ZERO;
    // rust: tnt.fuse = 1;
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
    // rust: assert_eq!(tnt.fuse, 0);
    // rust: assert_eq!(
    // rust: tnt.velocity.x, 0.0,
    // rust: "expired TNT must not receive a current"
    // rust: );
    // rust: world.set(21, 4, 20, water).unwrap();
    // rust: tnt.position = at;
    // rust: tnt.velocity = Vec3::ZERO;
    // rust: tnt.fuse = 80;
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: tnt.velocity.x, 0.0,
    // rust: "still water must not add horizontal motion"
    // rust: );
    // rust: world
    // rust: .set(
    // rust: 20,
    // rust: 3,
    // rust: 20,
    // rust: assets.registry.default_state("minecraft:air").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: tnt.on_ground = false;
    // rust: tnt.velocity = Vec3::ZERO;
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
    // rust: assert!(
    // rust: tnt.position.y < at.y && tnt.velocity.y < 0.0,
    // rust: "TNT sinks; water does not add buoyancy"
    // rust: );
}

pub fn a_soul_sand_bubble_column_lifts_primed_tnt() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = horizon_client::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = horizon_client::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = horizon_client::world::World::test_scene(&assets, &render, 3).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let soul_sand = assets
    // rust: .registry
    // rust: .default_state("minecraft:soul_sand")
    // rust: .unwrap();
        // Soul sand makes an up-pushing column (`drag=false`); the block's
        // default state is the down-dragging one.
    // rust: let drag_down = assets
    // rust: .registry
    // rust: .default_state("minecraft:bubble_column")
    // rust: .unwrap();
    // rust: let mut up = assets.registry.state(drag_down).unwrap().clone();
    // rust: up.properties.insert("drag".into(), "false".into());
    // rust: let column = assets.registry.resolve(&up).unwrap();
    // rust: for y in 3..=8 {
    // rust: world.set(20, y, 20, column).unwrap();
}
    // rust: world.set(20, 2, 20, soul_sand).unwrap();
    // rust: world.set(20, 9, 20, water).unwrap();
        // BubbleColumnBlock.entityInside: the columns its box touches lift it
        // (Entity.handleOnInsideBubbleColumn / handleOnAboveBubbleColumn).
    // rust: let at = Vec3::new(20.5, 6.0, 20.5);
    // rust: let mut tnt = PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: fuse: 80,
    // rust: on_ground: false,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
}
    // rust: for _ in 0..10 {
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
}
    // rust: assert!(
    // rust: tnt.velocity.y > 0.0,
    // rust: "soul sand lifts primed TNT, got {:?}",
    // rust: tnt.velocity
    // rust: );
    // rust: assert!(
    // rust: tnt.position.y > at.y,
    // rust: "the column carries it up, got {}",
    // rust: tnt.position.y
    // rust: );
        // Without the column the same TNT only falls.
    // rust: for y in 3..=8 {
    // rust: world.set(20, y, 20, water).unwrap();
}
    // rust: tnt.position = at;
    // rust: tnt.velocity = Vec3::ZERO;
    // rust: tnt.on_ground = false;
    // rust: for _ in 0..4 {
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap();
}
    // rust: assert!(
    // rust: tnt.position.y < at.y,
    // rust: "water alone does not lift it, got {}",
    // rust: tnt.position.y
    // rust: );
}

    /// `Entity.onAboveBubbleColumn` sends the surface particles only from the top of
    /// a column: `tick` names the column block it is at the top of, and none while
    /// the column has water above it.
pub fn primed_tnt_reports_the_surface_of_a_bubble_column() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = horizon_client::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = horizon_client::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = horizon_client::world::World::test_scene(&assets, &render, 3).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let soul_sand = assets
    // rust: .registry
    // rust: .default_state("minecraft:soul_sand")
    // rust: .unwrap();
    // rust: let default = assets
    // rust: .registry
    // rust: .default_state("minecraft:bubble_column")
    // rust: .unwrap();
    // rust: let mut up = assets.registry.state(default).unwrap().clone();
    // rust: up.properties.insert("drag".into(), "false".into());
    // rust: let column = assets.registry.resolve(&up).unwrap();
    // rust: for y in 3..=8 {
    // rust: world.set(20, y, 20, column).unwrap();
}
    // rust: world.set(20, 2, 20, soul_sand).unwrap();
    // rust: let at = Vec3::new(20.5, 6.0, 20.5);
    // rust: let primed = || PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: fuse: 80,
    // rust: on_ground: false,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
}
    // rust: let mut tops = Vec::new();
    // rust: let mut tnt = primed();
    // rust: for _ in 0..30 {
    // rust: tops.extend(
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap(),
    // rust: );
}
    // rust: assert!(!tops.is_empty(), "it reaches the top of the column");
    // rust: assert!(
    // rust: tops.iter().all(|p| *p == BlockPos::new(20, 8, 20)),
    // rust: "only the surface block, got {tops:?}"
    // rust: );
        // Water above the top block: it is no longer the surface.
    // rust: world.set(20, 9, 20, water).unwrap();
    // rust: let mut tnt = primed();
    // rust: for _ in 0..10 {
    // rust: assert!(
    // rust: tnt.tick(&world, &collision, &assets, &facts, &fluids, None, None)
    // rust: .unwrap()
    // rust: .is_empty()
    // rust: );
}
}
}
    // rust: horizon_client::impl_joined!(PrimedTnt);
