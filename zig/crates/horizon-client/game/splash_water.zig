//! Transpiled from Horizon Rust crate
//! Module: horizon-client_splash_water
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `AbstractThrownPotion`: what a splash or lingering potion does around where
//! it lands besides its effects. A potion in `#minecraft:douses_fire` puts out
//! the fire, candles and campfires next to the block it hit; one in
//! `#minecraft:hurts_water_sensitive_entities` hurts the water-sensitive mobs
//! near it and one in `#minecraft:extinguishes_entities` puts out burning
//! entities. Only plain water is in those tags in vanilla.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{Damage, Species, Who},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
}
// use horizon_world::{chunk::BlockState, registry::BlockStateId};

/// The block a thrown potion hit and the face it hit it on, as the
/// `BlockHitResult` of `ProjectileUtil.getHitResultOnMoveVector`: `end` is a
/// point of the path inside the block, `start` where the step began. The face
/// is the one the path enters the block cube through, or, when the step began
/// inside the block, the one facing back along the motion.
    // rust: pub(super) fn thrown_block_hit(start: Vec3, end: Vec3, velocity: Vec3) -> ([i32; 3], Direction) {
    // rust: let cell = [end.x, end.y, end.z].map(|v| v.floor() as i32);
    // rust: let face = Aabb::clip_boxes(
    // rust: [Aabb::unit_cube(Vec3::ZERO)],
    // rust: start,
    // rust: end,
    // rust: BlockPos::new(cell[0], cell[1], cell[2]),
    // rust: )
    // rust: .map_or_else(
    // rust: || Direction::approximate_nearest(velocity.reverse()),
    // rust: |hit| hit.direction,
    // rust: );
    // rust: (cell, face)
}

    // rust: impl Game<'_> {
    /// `PotionContents.is`: the potion of `stack` is in the potion tag `tag`
    /// (`minecraft:douses_fire` and the others, read from the data pack's
    /// `tags/potion`). A stack with no potion is in no tag.
    // rust: pub(super) fn potion_in_tag(&self, stack: &ItemStack, tag: &str) -> bool {
    // rust: stack.potion().is_some_and(|potion| {
    // rust: self.res
    // rust: .stations()
    // rust: .trades
    // rust: .potion_tags
    // rust: .get(tag)
    // rust: .is_some_and(|members| members.iter().any(|m| m.as_str() == potion))
    // rust: })
}

    /// `AbstractThrownPotion.onHitBlock` on the server: a potion (the stack's
    /// `potion_contents`) in `#douses_fire` douses the cell in front of the
    /// face it hit, the cell behind that (the block it hit) and the four
    /// horizontal neighbours of the cell in front. `hit` is the block and
    /// `face` the face it was hit on.
    // rust: pub(super) fn potion_hit_block(&mut self, stack: &ItemStack, hit: [i32; 3], face: Direction) {
        // `PotionContents.is(PotionTags.DOUSES_FIRE)` on the stack's `potion_contents`.
    // rust: if !self.potion_in_tag(stack, "minecraft:douses_fire") {
    // rust: return;
}
    // rust: let relative = |pos: [i32; 3], direction: Direction| {
    // rust: let n = direction.normal();
    // rust: [pos[0] + n[0], pos[1] + n[1], pos[2] + n[2]]
}
    // rust: let effect = relative(hit, face);
    // rust: self.douse_fire(effect);
    // rust: self.douse_fire(relative(effect, face.opposite()));
        // Direction.Plane.HORIZONTAL.
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: self.douse_fire(relative(effect, direction));
}
}

    /// `AbstractThrownPotion.douseFire`: a fire block is destroyed without
    /// drops, a lit candle or candle cake goes out, and a lit campfire goes
    /// out after level event 1009 and its block-change game event.
pub fn douse_fire(self: *Self, pos: [i32; 3]) void {
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: let fire = self.block_in_tag("minecraft:fire", &name);
    // rust: if fire {
            // Level.destroyBlock(pos, false, this).
    // rust: self.with_level(|b, level, ticks| b.destroy_block(level, ticks, at, false));
}
    // rust: let candle =
    // rust: !fire && self.with_level(|b, level, ticks| b.extinguish_candle(level, ticks, at));
    // rust: if !fire
    // rust: && !candle
    // rust: && let Some(mut lit) = self.lit_campfire(state, &name)
    // rust: {
    // rust: self.level_event_at(1009, pos, 0);
            // CampfireBlock.douse: the block-change game event, whose source
            // is the potion's owner (not tracked here).
    // rust: self.post_block_game_event("minecraft:block_change", pos, None, None);
    // rust: lit.properties.insert("lit".into(), "false".into());
    // rust: if let Ok(unlit) = self.pack.assets.registry.resolve(&lit) {
    // rust: let _ = self.level_set(pos, unlit);
}
}
    // rust: let _ = self.process_level_events();
}

    /// `CampfireBlock.isLitCampfire`: the state of a lit block in
    /// `#minecraft:campfires`.
pub fn lit_campfire(self: *Self, state: BlockStateId, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.block_in_tag("minecraft:campfires", name) {
    // rust: return None;
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| s.properties.get("lit").map(String::as_str) == Some("true"))
    // rust: .cloned()
}

    /// `AbstractThrownPotion.affectEntitiesAround`: the living entities whose
    /// box meets the potion's box grown by (4, 2, 4) and that are less than 4
    /// blocks from it. A potion in `#hurts_water_sensitive_entities` hurts
    /// the water-sensitive ones for 1 (`indirectMagic`, the owner being a
    /// player when `by_player`), an Enderman then trying to teleport
    /// (`Enderman.hurtServer`); one in `#extinguishes_entities` puts out
    /// those that burn; one in `#rehydrates_axolotls` refills the air of
    /// the axolotls in the box.
    // rust: pub(super) fn affect_entities_around(&mut self, stack: &ItemStack, at: Vec3, by_player: bool) {
    // rust: let hurts = self.potion_in_tag(stack, "minecraft:hurts_water_sensitive_entities");
    // rust: let extinguishes = self.potion_in_tag(stack, "minecraft:extinguishes_entities");
        // The potion's box is 0.25 wide and high.
    // rust: let reach = Aabb::new(
    // rust: Vec3::new(at.x - 0.125, at.y, at.z - 0.125),
    // rust: Vec3::new(at.x + 0.125, at.y + 0.25, at.z + 0.125),
    // rust: )
    // rust: .inflate(Vec3::new(4.0, 2.0, 4.0));
    // rust: let near = |p: Vec3| {
    // rust: let (dx, dy, dz) = (p.x - at.x, p.y - at.y, p.z - at.z);
    // rust: dx * dx + dy * dy + dz * dz < 16.0
}
    // rust: if hurts || extinguishes {
    // rust: let source =
    // rust: Damage::indirect_magic(by_player.then_some(Who::Player), [at.x, at.y, at.z]);
    // rust: for m in self.mobs.iter_mut().filter(|m| !m.removed) {
                // WATER_SENSITIVE_OR_ON_FIRE.
    // rust: let sensitive = m.kind.flags.water_sensitive;
    // rust: if !(sensitive || m.is_on_fire())
    // rust: || !reach.intersects(m.bounds())
    // rust: || !near(m.position)
    // rust: {
    // rust: continue;
}
    // rust: if hurts && sensitive {
    // rust: let invulnerable = m.invulnerable_flag;
    // rust: m.damage(1.0, source);
                    // `Enderman.hurtServer` for a thrown potion: the hit is
                    // `Enderman.hurtWithCleanWater`, then
                    // `Enderman.repeatedlyTryToTeleport`, which does nothing
                    // while it rides or once it is dead (`teleport` needs
                    // `isAlive`) and which the AI step runs.
    // rust: if m.species() == Species::Enderman
    // rust: && !invulnerable
    // rust: && m.alive()
    // rust: && !m.extra.passenger
    // rust: {
    // rust: m.extra.counter2 = 64;
}
}
    // rust: if extinguishes && m.is_on_fire() && m.alive() {
    // rust: m.extinguish_fire();
}
}
}
    // rust: if extinguishes {
    // rust: self.for_each_player(|g| g.extinguish_player_in_splash(reach, at));
            // Armor stands are living entities too.
    // rust: let mut put_out = Vec::new();
    // rust: for stand in self.armor_stands.iter_mut() {
    // rust: if stand.fire_ticks > 0
    // rust: && stand.health > 0.5
    // rust: && reach.intersects(stand.bounds())
    // rust: && near(stand.position)
    // rust: {
    // rust: stand.fire_ticks = 0;
    // rust: put_out.push([stand.position.x, stand.position.y, stand.position.z]);
}
}
    // rust: for stand_at in put_out {
    // rust: self.extinguish_sound(stand_at);
}
}
    // rust: if self.potion_in_tag(stack, "minecraft:rehydrates_axolotls") {
            // Axolotl.rehydrate: 1800 more air, up to the maximum.
    // rust: let (lo, hi) = (
    // rust: [at.x - 0.125 - 4.0, at.y - 2.0, at.z - 0.125 - 4.0],
    // rust: [at.x + 0.125 + 4.0, at.y + 0.25 + 2.0, at.z + 0.125 + 4.0],
    // rust: );
    // rust: for m in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.species() == Species::Axolotl && !m.removed)
    // rust: {
    // rust: let (w, h, _) = m.dims();
    // rust: let half = w / 2.0;
    // rust: let (x, y, z) = (m.position.x, m.position.y, m.position.z);
    // rust: if x - half < hi[0]
    // rust: && x + half > lo[0]
    // rust: && y < hi[1]
    // rust: && y + h > lo[1]
    // rust: && z - half < hi[2]
    // rust: && z + half > lo[2]
    // rust: {
    // rust: m.air = (m.air + 1800).min(horizon_client::mobs::axolotl::MAX_AIR);
}
}
}
}

    /// `Entity.extinguishFire` for the player in place (the host's or a
    /// guest's) when it burns, is alive and is in a splash's reach: the
    /// extinguish sound, then the fire out.
pub fn extinguish_player_in_splash(self: *Self, reach: Aabb, at: Vec3) void {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(p.position.x - w, p.position.y, p.position.z - w),
    // rust: Vec3::new(
    // rust: p.position.x + w,
    // rust: p.position.y + f64::from(p.dimensions.height),
    // rust: p.position.z + w,
    // rust: ),
    // rust: );
    // rust: let (dx, dy, dz) = (
    // rust: p.position.x - at.x,
    // rust: p.position.y - at.y,
    // rust: p.position.z - at.z,
    // rust: );
    // rust: if p.fire_ticks <= 0
    // rust: || p.health.dead_or_dying()
    // rust: || !reach.intersects(bounds)
    // rust: || dx * dx + dy * dy + dz * dz >= 16.0
    // rust: {
    // rust: return;
}
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: self.extinguish_sound(feet);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: let ticks = p.fire_ticks.min(0);
    // rust: p.set_remaining_fire_ticks(ticks);
}
}
}
