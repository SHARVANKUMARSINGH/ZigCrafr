//! Transpiled from Horizon Rust crate
package horizon_client_copper_golems

import "core:fmt"
import "core:mem"
import "core:math"

// Copper golems on the game side: what their brain (`mobs::transport_items`)
// does to chests (opener counts, the lid block events, slots), the openers
// recheck, turning into statues, and the hand-over, waxing, scraping and
// shearing interactions.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{
    // rust: Mob, Species,
    // rust: transport_items::{held, set_held},
    // rust: },
}
// use horizon_core::random::RandomSource;
// use horizon_world::chunk::BlockState;

// `ContainerOpenersCounter.CHECK_TICK_DELAY`.
RECHECK_TICKS :: 5

    // rust: impl Game<'_> {
    // A copper golem opened or closed a chest half: the counter changes and
    // the clients see the block event (`openerCountChanged`).
    // rust: pub(super) fn golem_chest_open(&mut self, chest: [i32; 3], open: bool) {
    // rust: let key = (chest[0], chest[1], chest[2]);
    // rust: let entry = self.world.chest_openers.entry(key).or_insert((0, 0.0));
    // rust: if open {
    // rust: entry.0 += 1;
    // rust: entry.1 = entry.1.max(3.0);
    // rust: } else {
    // rust: entry.0 -= 1;
    // rust: if entry.0 == 0 {
    // rust: entry.1 = 0.0;
}
}
    // rust: let count = entry.0;
    // rust: if count <= 0 {
    // rust: self.world.chest_openers.remove(&key);
}
    // rust: self.block_entity_event(chest, 1, count.max(0));
        // The guests get the same `ClientboundBlockEventPacket` (the lid).
    // rust: self.lan_block_event(chest, 1, count.max(0));
}
    // A copper golem took from or filled a chest slot.
    // rust: pub(super) fn golem_chest_slot(
    // rust: &mut self,
    // rust: chest: [i32; 3],
    // rust: slot: usize,
    // rust: stack: Option<ItemStack>,
    // rust: ) {
    // rust: let key = (chest[0], chest[1], chest[2]);
    // rust: if let Some(e) = self.world.block_entities.get_mut(&key)
    // rust: && let Some(s) = e.slots_mut().get_mut(slot)
    // rust: {
    // rust: *s = stack;
            // TransportItemsBetweenContainers calls Container.setChanged.
    // rust: self.container_changed(key);
}
}
    // `ContainerOpenersCounter.recheckOpeners` every five ticks: the golems
    // whose opened chest is this one, within its range plus 4; when none
    // is left the chest closes (a double chest the golem left open).
    // rust: pub(super) fn recheck_golem_openers(&mut self) {
    // rust: if self.world.game_time % RECHECK_TICKS != 0 {
    // rust: return;
}
    // rust: let open: Vec<(i32, i32, i32)> = self.world.chest_openers.keys().copied().collect();
    // rust: for key in open {
    // rust: let p = [key.0, key.1, key.2];
    // rust: let other = self.chest_other_half(key).map(|o| [o.0, o.1, o.2]);
    // rust: let range = self.world.chest_openers.get(&key).map_or(0.0, |o| o.1) + 4.0;
    // rust: let area = horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(
    // rust: f64::from(p[0]) - range,
    // rust: f64::from(p[1]) - range,
    // rust: f64::from(p[2]) - range,
    // rust: ),
    // rust: horizon_core::geometry::Vec3::new(
    // rust: f64::from(p[0]) + 1.0 + range,
    // rust: f64::from(p[1]) + 1.0 + range,
    // rust: f64::from(p[2]) + 1.0 + range,
    // rust: ),
    // rust: );
    // rust: let count = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: m.species() == Species::CopperGolem
    // rust: && !m.removed
    // rust: && m.extra
    // rust: .opened_chest
    // rust: .is_some_and(|o| o == p || Some(o) == other)
    // rust: && m.bounds().intersects(area)
    // rust: })
    // rust: .count() as i32;
    // rust: let before = self.world.chest_openers.get(&key).map_or(0, |o| o.0);
    // rust: if count == before {
    // rust: continue;
}
    // rust: if count == 0 {
    // rust: self.world.chest_openers.remove(&key);
    // rust: self.golem_chest_sound(p, false);
    // rust: } else if let Some(o) = self.world.chest_openers.get_mut(&key) {
    // rust: o.0 = count;
}
    // rust: self.block_entity_event(p, 1, count);
    // rust: self.lan_block_event(p, 1, count);
}
}
    // `ChestBlockEntity.playSound` for a chest the recheck closed.
golem_chest_sound :: proc(self: ^Self, p: [i32; 3], open: bool) {
}
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name
    // rust: .clone();
    // rust: let base = name
    // rust: .trim_start_matches("minecraft:")
    // rust: .trim_start_matches("waxed_");
    // rust: let kind = if !base.ends_with("copper_chest") {
    // rust: "chest"
    // rust: } else if base.starts_with("weathered") {
    // rust: "copper_chest_weathered"
    // rust: } else if base.starts_with("oxidized") {
    // rust: "copper_chest_oxidized"
    // rust: } else {
    // rust: "copper_chest"
}
    // rust: let side = if open { "open" } else { "close" };
    // rust: let at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: let pitch = self.world.random.next_float() * 0.1 + 0.9;
    // rust: self.audio.play(
    // rust: &format!("minecraft:block.{kind}.{side}"),
    // rust: Some(at),
    // rust: 0.5,
    // rust: pitch,
    // rust: );
}
    // `CopperGolem.turnToStatue`, which its weathering asked for.
    // rust: pub(super) fn golem_become_statue(&mut self, id: u32) {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: return;
}
    // rust: let mut m = self.mobs[i].clone();
    // rust: self.golem_turn_to_statue(&mut m);
    // rust: if let Some(i) = self.mobs.iter().position(|x| x.id == id) {
    // rust: self.mobs[i] = m;
}
}
golem_turn_to_statue :: proc(self: ^Self, m: ^Mob) {
}
    // rust: let pos = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
        // The pose comes from the golem's own random (`this.random.nextInt(0, 4)`).
    // rust: let pose = ["standing", "sitting", "running", "star"]
    // rust: [m.random.next_int_bound(4).unwrap_or(0) as usize];
        // Direction.fromYRot.
    // rust: let facing = ["south", "west", "north", "east"]
    // rust: [((f64::from(m.yaw) / 90.0 + 0.5).floor() as i32 & 3) as usize];
    // rust: let state = BlockState {
    // rust: name: "minecraft:oxidized_copper_golem_statue".into(),
    // rust: properties: [
    // rust: ("facing".to_string(), facing.to_string()),
    // rust: ("copper_golem_pose".to_string(), pose.to_string()),
    // rust: ("waterlogged".to_string(), "false".to_string()),
    // rust: ]
    // rust: .into(),
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(id) = registry.id(&state) else {
    // rust: return;
}
    // rust: if self.level_set(pos, id).is_err() {
    // rust: return;
}
    // rust: self.golem_drop_equipment(m);
    // rust: m.extra.opened_chest = None;
    // rust: if m.extra.leash.is_some() {
    // rust: self.break_leash(m.id, true, false);
    // rust: m.extra.leash = None;
}
    // rust: m.removed = true;
    // rust: self.audio.play(
    // rust: "minecraft:entity.copper_golem_become_statue",
    // rust: Some([m.position.x, m.position.y, m.position.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // `Mob.dropPreservedEquipment`: the guaranteed drops in `EquipmentSlot`
    // order, the carried stack (main hand) then the antenna flower (saddle),
    // each `spawnAtLocation` at the golem's feet.
    // rust: pub(super) fn golem_drop_equipment(&mut self, m: &mut Mob) {
    // rust: let at = m.position;
    // rust: if let Some(stack) = held(m).cloned() {
    // rust: set_held(m, None);
    // rust: self.spawn_at_location(at, 0.0, stack);
}
    // rust: if let Some(antenna) = m.saddle_item() {
    // rust: m.set_saddle(None);
    // rust: self.spawn_at_location(at, 0.0, antenna);
}
}
    // ---- interactions -----------------------------------------------------
    // `WeatheringCopperGolemStatueBlock.useItemOn`: an axe on an unoxidized
    // statue turns it back into a golem (`CopperGolemStatueBlockEntity.removeStatue`),
    // wearing the axe. Weathered statues are scraped by the axe's own
    // transform instead.
    // rust: pub(super) fn use_golem_statue(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: if !held.is_some_and(|s| s.item.ends_with("_axe")) {
    // rust: return false;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(state) = registry.state(self.world.block(pos[0], pos[1], pos[2])) else {
    // rust: return false;
}
    // rust: if state.name != "minecraft:copper_golem_statue" {
    // rust: return false;
}
        // `Direction.toYRot` of the statue's facing.
    // rust: let yaw = match state.properties.get("facing").map(String::as_str) {
    // rust: Some("west") => 90.0,
    // rust: Some("north") => 180.0,
    // rust: Some("east") => 270.0,
    // rust: _ => 0.0,
}
    // rust: let waterlogged = state
    // rust: .properties
    // rust: .get("waterlogged")
    // rust: .is_some_and(|w| w == "true");
        // initCopperGolem: at the block's feet, facing as the statue does.
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let Some(id) = self.spawn_mob("minecraft:copper_golem", at, true) else {
    // rust: return false;
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.yaw = yaw;
    // rust: m.previous_yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: m.previous_body_yaw = yaw;
    // rust: m.head_yaw = yaw;
    // rust: m.previous_head_yaw = yaw;
}
    // rust: self.damage_held(1);
    // rust: self.audio
    // rust: .play("minecraft:entity.copper_golem.spawn", Some(at), 1.0, 1.0);
        // Level.removeBlock(pos, false): air, or the water the statue stood in.
    // rust: let replacement = registry.default_state(if waterlogged {
    // rust: "minecraft:water"
    // rust: } else {
    // rust: "minecraft:air"
    // rust: });
    // rust: if let Some(replacement) = replacement {
    // rust: let _ = self.level_set(pos, replacement);
}
    // rust: self.world.block_entities.remove(&(pos[0], pos[1], pos[2]));
    // rust: true
}
    // `CopperGolem.mobInteract`; true when handled.
    // rust: pub(super) fn interact_copper_golem(&mut self, index: usize, item: &str) -> bool {
    // rust: if self.mobs[index].species() != Species::CopperGolem || !self.mobs[index].alive() {
    // rust: return false;
}
    // rust: let at = {
    // rust: let m = &self.mobs[index];
    // rust: [m.position.x, m.position.y, m.position.z]
}
    // rust: if item.is_empty() {
            // Empty hand: the golem throws what it carries back.
    // rust: let Some(h) = held(&self.mobs[index]).cloned() else {
    // rust: return false;
}
    // rust: set_held(&mut self.mobs[index], None);
            // BehaviorUtils.throwItem: from 0.3 below the golem's eyes towards
            // the player's feet at 0.3 blocks a tick, default pickup delay.
    // rust: let p = self.player.as_ref().map(|p| p.position);
    // rust: let eye = self.mobs[index].eye_height();
    // rust: let from = [at[0], at[1] + eye - f64::from(0.3f32), at[2]];
    // rust: let v = p.map_or([0.0; 3], |p| {
    // rust: let d = [p.x - at[0], p.y - at[1], p.z - at[2]];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if len < 1.0e-5 {
    // rust: return [0.0; 3];
}
    // rust: let k = f64::from(0.3f32);
    // rust: [d[0] / len * k, d[1] / len * k, d[2] / len * k]
    // rust: });
    // rust: self.spawn_item(h, from, v, 10);
    // rust: return true;
}
    // rust: let name = item;
    // rust: let is_axe = name.ends_with("_axe");
    // rust: let waxed = self.mobs[index].extra.vector[0] as i64 == -2;
    // rust: if name == "minecraft:shears" && self.golem_shearable(index) {
            // CopperGolem.shear: the sound, the antenna slot emptied (an
            // unequip) and the flower dropped 1.5 up.
    // rust: self.play_mob_bound_sound(
    // rust: index,
    // rust: "minecraft:entity.copper_golem.shear",
    // rust: 7,
    // rust: 1.0,
    // rust: 1.0,
    // rust: false,
    // rust: );
    // rust: let antenna = self.mobs[index].saddle_item();
    // rust: self.mobs[index].set_saddle(None);
    // rust: let id = self.mobs[index].id;
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:unequip", at, ctx);
    // rust: if let Some(a) = antenna {
    // rust: let p = self.mobs[index].position;
    // rust: self.spawn_at_location(p, 1.5, a);
}
    // rust: self.damage_held_tool();
    // rust: return true;
}
    // rust: let block = {
    // rust: let p = self.mobs[index].position;
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}
    // rust: if name == "minecraft:honeycomb" && !waxed {
    // rust: self.mobs[index].extra.vector[0] = -2.0;
    // rust: self.level_event_at(3003, block, 0);
    // rust: self.audio
    // rust: .play("minecraft:item.honeycomb.wax_on", Some(at), 1.0, 1.0);
    // rust: self.consume_held();
    // rust: return true;
}
    // rust: if is_axe && waxed {
    // rust: self.mobs[index].extra.vector[0] = -1.0;
    // rust: self.play_mob_bound_sound(index, "minecraft:item.axe.scrape", 6, 1.0, 1.0, false);
    // rust: self.level_event_at(3004, block, 0);
    // rust: self.damage_held_tool();
    // rust: return true;
}
    // rust: if is_axe && self.mobs[index].extra.variant > 0 {
    // rust: let m = &mut self.mobs[index];
    // rust: m.extra.vector[0] = -1.0;
    // rust: m.extra.variant = horizon_client::mobs::copper_golem::weather_previous(m.extra.variant);
    // rust: self.play_mob_bound_sound(index, "minecraft:item.axe.scrape", 6, 1.0, 1.0, false);
    // rust: self.level_event_at(3005, block, 0);
    // rust: self.damage_held_tool();
    // rust: return true;
}
    // rust: false
}
    // `readyForShearing`: the antenna holds a flower shears take.
    // rust: pub(super) fn golem_shearable(&self, index: usize) -> bool {
    // rust: self.mobs[index].saddle_item().is_some_and(|a| {
    // rust: self.res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:shearable_from_copper_golem")
    // rust: .is_some_and(|t| t.contains(&*a.item))
    // rust: })
}
}
