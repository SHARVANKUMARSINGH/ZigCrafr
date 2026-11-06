//! Transpiled from Horizon Rust crate
package horizon_client_sulfur_cubes

import "core:fmt"
import "core:mem"
import "core:math"

// Sulfur cubes on the game side (`SulfurCube.mobInteract`, `pickUpItem`,
// `remove`): feeding babies, swallowing a held block, shearing it back
// out, lighting an explosive one, swallowing blocks from the ground and
// splitting into two babies.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{Mob, Species, Who, sulfur_cube},
    // rust: projectiles::Projectile,
    // rust: text::Text,
}
// use horizon_core::{position::BlockPos, random::RandomSource};

block_transform :: proc(base: glam::Mat4, baby: bool) -> g {
    // Ported from Horizon
    return {}
}
    // rust: base * glam::Mat4::from_scale(glam::Vec3::new(1.0, -1.0, -1.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(if baby { 0.5 } else { 1.0 }))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(-0.5, -0.518, -0.5))
}

block_overlay :: proc(fuse_ticks: i32, alpha: f32, hurt: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let fuse = if fuse_ticks >= 0 {
    // rust: fuse_ticks as f32 - alpha + 1.0
    // rust: } else {
    // rust: 0.0
}
    // rust: if fuse > 0.0 && (fuse / 5.0) as i32 % 2 == 0 {
    // rust: horizon_client::overlay::living(1.0, false)
    // rust: } else {
    // rust: horizon_client::overlay::living(0.0, hurt)
}
}

block_light :: proc(light: u32, emission: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let block = (light >> 8 & 0xFF).max(u32::from(emission) * 16);
    // rust: (light & 0xFF) | block << 8
}

    // rust: impl Game<'_> {
    // The swallowed block replaces the opaque core and precedes the shell.
    // rust: pub(super) fn sulfur_cube_body_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: alpha: f32,
    // rust: base: glam::Mat4,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(item) = mob.extra.body.as_deref() else {
    // rust: return;
}
    // rust: if super::armor_stands::skull_kind(item).is_some() {
    // rust: return;
}
        // shortcut: the body slot retains only an item id; preserve the stack
        // before supporting its block-state components here.
    // rust: let Some(state) = self.items().get(item).and_then(|item| item.block) else {
    // rust: return;
}
    // rust: let start = out.len();
    // rust: self.block_model_vertices(
    // rust: state,
    // rust: 42,
    // rust: block_transform(base, mob.is_baby()),
    // rust: block_light(light, self.res.facts().get(state).emission),
    // rust: true,
    // rust: out,
    // rust: );
    // rust: let overlay = block_overlay(
    // rust: sulfur_cube::fuse(mob),
    // rust: alpha,
    // rust: mob.hurt_time > 0 || mob.death_time > 0,
    // rust: );
    // rust: if overlay != 0 {
    // rust: for vertex in &mut out[start..] {
    // rust: vertex.layer = overlay;
}
}
}

sulfur_sound :: proc(self: ^Self, index: uint, sound: string) {
}
    // rust: let at = self.mobs[index].center();
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), 1.0, 1.0);
}
    // Spit the swallowed block out on top (`EntityAttachment.PASSENGER`).
eject_sulfur_block :: proc(self: ^Self, index: uint) {
}
    // rust: let m = &mut self.mobs[index];
    // rust: let Some(item) = m.extra.body.take() else {
    // rust: return;
}
    // rust: let at = [
    // rust: m.position.x,
    // rust: m.position.y + f64::from(m.height()),
    // rust: m.position.z,
    // rust: ];
    // rust: self.spawn_item(ItemStack::new(&item, 1), at, [0.0, 0.2, 0.0], 10);
}
    // `SulfurCube.mobInteract`. Returns whether the click was used.
    // rust: pub(super) fn interact_sulfur_cube(&mut self, index: usize, item: &str) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if m.species() != Species::SulfurCube || !m.alive() {
    // rust: return false;
}
    // rust: if m.is_baby() {
            // Slime balls grow a baby up by a tenth (`canAgeUp`: not while an
            // age lock holds it).
    // rust: if !m.kind.food.iter().any(|f| f == item) || !horizon_client::mobs::ai::can_age_up(m) {
    // rust: return false;
}
    // rust: let m = &mut self.mobs[index];
    // rust: let secs = (-m.extra.age / 20) as f32 * 0.1;
            // AgeableMob.ageUp: a grown cube is size 2 (SulfurCube.ageBoundaryReached).
    // rust: horizon_client::mobs::ai::age_up(m, secs as i32, false);
    // rust: self.consume_held();
    // rust: self.sulfur_sound(index, "entity.small_sulfur_cube.eat");
    // rust: return true;
}
    // rust: if sulfur_cube::primed(m) {
    // rust: return false;
}
    // rust: let explosive = sulfur_cube::archetype(m).is_some_and(|a| a.explosion.is_some());
    // rust: if explosive && matches!(item, "minecraft:flint_and_steel" | "minecraft:fire_charge") {
    // rust: if !self.ui.rules.bool("tnt_explodes") {
    // rust: let message = Text::translate("block.minecraft.tnt.disabled", &[]);
    // rust: self.send_overlay_message(message);
    // rust: return false;
}
    // rust: sulfur_cube::prime(&mut self.mobs[index], false);
    // rust: if item == "minecraft:flint_and_steel" {
    // rust: self.damage_held_tool();
    // rust: } else {
    // rust: self.consume_held();
}
    // rust: self.award_stat("used", item, 1);
    // rust: return true;
}
    // rust: if item == "minecraft:shears" && sulfur_cube::has_body(m) {
            // shear: out comes the block, and nothing is swallowed for 5 s.
    // rust: let sheared = self.mobs[index].extra.body.clone();
    // rust: self.eject_sulfur_block(index);
    // rust: self.mobs[index].extra.ints[3] = sulfur_cube::PICKUP_TIMER;
    // rust: self.sulfur_sound(index, "entity.sulfur_cube.eject");
    // rust: self.damage_held_tool();
            // gameEvent(SHEAR, player).
    // rust: let at = self.mobs[index].position;
    // rust: let ctx = self.who_context(Some(Who::Player), None);
    // rust: self.post_game_event("minecraft:shear", [at.x, at.y, at.z], ctx);
            // CriteriaTriggers.PLAYER_SHEARED_EQUIPMENT with the body block.
    // rust: if let Some(body) = sheared {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity(
    // rust: "minecraft:player_sheared_equipment",
    // rust: &ItemStack::new(&body, 1),
    // rust: &target,
    // rust: );
}
    // rust: return true;
}
    // rust: if sulfur_cube::swallowable(m, item) {
            // equipItem: not the same block again; the old one comes out.
    // rust: if m.extra.body.as_deref() == Some(item) {
    // rust: return false;
}
    // rust: self.eject_sulfur_block(index);
    // rust: self.mobs[index].extra.body = Some(item.into());
    // rust: self.consume_held();
    // rust: self.sulfur_sound(index, "entity.sulfur_cube.absorb");
            // Entity.gameEvent(ENTITY_INTERACT): the cube is the source.
    // rust: let (id, at) = (self.mobs[index].id, self.mobs[index].position);
    // rust: let ctx = self.who_context(Some(Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:entity_interact", [at.x, at.y, at.z], ctx);
    // rust: return true;
}
    // rust: false
}
    // `SulfurCube.primeWhenOnPoweredPosition`: an explosive cube standing in
    // or next to redstone power lights its fuse (`getBestOwnOrNeighbourSignal`;
    // no block has an own signal, so the neighbour signal is all there is).
    // rust: pub(super) fn sulfur_cube_power_priming(&mut self) {
    // rust: if !self.ui.rules.bool("tnt_explodes") {
    // rust: return;
}
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::SulfurCube
    // rust: || !sulfur_cube::archetype(m).is_some_and(|a| a.explosion.is_some())
    // rust: || !m.alive()
    // rust: || sulfur_cube::primed(m)
    // rust: {
    // rust: continue;
}
    // rust: let at = BlockPos::new(
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let signal =
    // rust: self.with_level(|b, level, ticks| b.best_neighbor_signal(level, ticks, at));
    // rust: if signal != 0 {
    // rust: sulfur_cube::prime(&mut self.mobs[i], false);
}
}
}
    // `SulfurCube.hurtServer`: an arrow or a trident on fire that hits an
    // explosive cube with a block lights its fuse (with `tnt_explodes`, as
    // `primeTime` asks), called after the hit's hurt, which the priming
    // leaves as it is, so its knock and the fuse both go ahead.
    // rust: pub(super) fn burning_arrow_primes(&mut self, p: &Projectile, who: Who) {
    // rust: if !p.arrow.as_ref().is_some_and(|a| a.on_fire()) || !self.ui.rules.bool("tnt_explodes") {
    // rust: return;
}
    // rust: if let Who::Mob(id) = who
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: && m.species() == Species::SulfurCube
    // rust: {
    // rust: sulfur_cube::burning_arrow_hit(m);
}
}
    // `SulfurCubeSearchForItemsGoal` and `pickUpItem`: an adult with nothing
    // inside hops to a block it can swallow within 8 and takes it in.
    // rust: pub(super) fn sulfur_cube_pickups(&mut self) {
    // rust: let griefing = self.ui.rules.bool("mob_griefing");
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::SulfurCube || !self.creatures.ticked.contains(&m.id) {
    // rust: continue;
}
    // rust: if !m.alive() || m.is_baby() || sulfur_cube::has_body(m) || m.extra.ints[3] > 0 {
    // rust: self.mobs[i].extra.point = None;
    // rust: continue;
}
    // rust: let reach = m
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(8.0, 8.0, 8.0));
    // rust: let pos = m.position;
    // rust: let best = self
    // rust: .dropped
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, e)| {
    // rust: e.pickup_delay == 0
    // rust: && reach.contains(e.position)
    // rust: && sulfur_cube::swallowable(m, &e.stack.item)
    // rust: })
    // rust: .map(|(j, e)| (j, e.position.distance_squared(pos)))
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1));
    // rust: let Some((j, _)) = best else {
    // rust: self.mobs[i].extra.point = None;
    // rust: continue;
}
            // Mob.aiStep: items within the box grown by (1, 0, 1).
    // rust: let touch = m
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(1.0, 0.0, 1.0));
    // rust: let e = &self.dropped[j];
    // rust: let close = touch.contains(e.position);
    // rust: self.mobs[i].extra.point = Some([e.position.x, e.position.y, e.position.z]);
    // rust: if !griefing || !close {
    // rust: continue;
}
    // rust: let item = e.stack.item.clone();
    // rust: let thrown_by_player = e
    // rust: .thrower
    // rust: .is_some_and(|uuid| Some(uuid) == self.level.player_uuid);
    // rust: let mut swallowed = e.stack.clone();
    // rust: swallowed.count = 1;
    // rust: let (taken_item, id) = (e.clone(), self.mobs[i].id);
    // rust: self.add_pickup(
    // rust: super::pickups::Taken::Item(Box::new(taken_item)),
    // rust: super::pickups::Collector::Mob(id),
    // rust: );
    // rust: let e = &mut self.dropped[j];
    // rust: e.stack.count -= 1;
    // rust: if e.stack.count == 0 {
    // rust: self.remove_dropped(j);
}
    // rust: let m = &mut self.mobs[i];
    // rust: m.extra.body = Some(item);
    // rust: m.extra.point = None;
    // rust: self.sulfur_sound(i, "entity.sulfur_cube.absorb");
    // rust: if thrown_by_player {
    // rust: let target = self.mob_entity(&self.mobs[i]);
    // rust: self.trigger_item_entity(
    // rust: "minecraft:thrown_item_picked_up_by_entity",
    // rust: &swallowed,
    // rust: &target,
    // rust: );
}
}
}
    // `AbstractCubeMob.remove`: a dead adult splits into two babies (none
    // when it was primed).
    // rust: pub(super) fn split_sulfur_cube(&mut self, m: &Mob) {
    // rust: let size = m.extra.size;
    // rust: if size <= 1 {
    // rust: return;
}
    // rust: let offset = f64::from(m.width()) / 2.0;
    // rust: for i in 0..sulfur_cube::split_count(m) {
    // rust: let xd = (f64::from(i % 2) - 0.5) * offset;
    // rust: let zd = (f64::from(i / 2) - 0.5) * offset;
    // rust: let at = [m.position.x + xd, m.position.y + 0.5, m.position.z + zd];
    // rust: let yaw = self.world.random.next_float() * 360.0;
    // rust: if let Some(id) = self.spawn_mob(&m.kind.id, at, m.persistent)
    // rust: && let Some(c) = self.mobs.iter_mut().find(|c| c.id == id)
    // rust: {
    // rust: c.extra.age = -24000;
    // rust: sulfur_cube::set_size(c, size / 2, true);
    // rust: c.yaw = yaw;
    // rust: c.body_yaw = yaw;
    // rust: c.head_yaw = yaw;
}
}
}
}

    // rust: mod tests {
//     use super::*;

swallowed_block_uses_vanilla_lift_and_baby_scale :: proc() {
}
    // rust: let base = glam::Mat4::from_translation(glam::Vec3::new(3.0, 4.0, -2.0))
    // rust: * glam::Mat4::from_rotation_y(0.7)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0));
    // rust: for baby in [false, true] {
    // rust: let size = if baby { 0.5 } else { 1.0 };
    // rust: let block = block_transform(base, baby);
    // rust: for (point, expected) in [
    // rust: (glam::Vec3::ZERO, glam::Vec3::new(-0.5, 0.518, 0.5)),
    // rust: (glam::Vec3::ONE, glam::Vec3::new(0.5, -0.482, -0.5)),
    // rust: ] {
    // rust: let actual = block.transform_point3(point);
    // rust: let expected = base.transform_point3(expected * size);
    // rust: assert!(actual.abs_diff_eq(expected, 1e-5), "baby={baby}");
}
    // rust: assert!(block.transform_vector3(glam::Vec3::Y).y > 0.0);
}
}

swallowed_tnt_flashes_white_over_hurt_using_the_interpolated_fuse :: proc() {
}
    // rust: let white = horizon_client::overlay::WHITE + 15;
    // rust: assert_eq!(block_overlay(-1, 0.0, false), 0);
    // rust: assert_eq!(block_overlay(-1, 0.0, true), 1);
    // rust: assert_eq!(block_overlay(9, 0.0, true), white);
    // rust: assert_eq!(block_overlay(9, 0.5, false), 0);
    // rust: assert_eq!(block_overlay(9, 0.5, true), 1);
    // rust: assert_eq!(block_overlay(0, 0.5, false), white);
}

contained_block_emission_preserves_brighter_light_and_the_sky_channel :: proc() {
}
    // rust: assert_eq!(block_light(0x2050, 1), 0x2050);
    // rust: assert_eq!(block_light(0x2050, 7), 0x7050);
    // rust: assert_eq!(block_light(0x0070, 0), 0x0070);
}
}
