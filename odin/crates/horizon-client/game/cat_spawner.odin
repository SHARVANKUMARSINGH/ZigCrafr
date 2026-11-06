//! Transpiled from Horizon Rust crate
package horizon_client_cat_spawner

import "core:fmt"
import "core:mem"
import "core:math"

// `CatSpawner`: every 1200 ticks a cat may appear near a random player,
// in a village with enough occupied beds or inside a swamp hut.
// use super::{
    // rust: Dim, Game,
    // rust: raids::{section, sections_to_village},
}
// use horizon_client::mobs::{Species, spawn_rules};
// use horizon_core::{geometry::Vec3, random::RandomSource};

TICK_DELAY :: 1200

    // rust: impl Game<'_> {
    // `CatSpawner.tick` (the overworld's custom spawner).
    // rust: pub(super) fn tick_cat_spawner(&mut self) {
    // rust: if self.dim != Dim::Overworld {
    // rust: return;
}
    // rust: self.creatures.cat_tick -= 1;
    // rust: if self.creatures.cat_tick > 0 {
    // rust: return;
}
    // rust: self.creatures.cat_tick = TICK_DELAY;
        // ServerLevel.getRandomPlayer: one of the living players.
    // rust: let alive: Vec<Vec3> = self
    // rust: .level_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive)
    // rust: .map(|p| p.position)
    // rust: .collect();
    // rust: if alive.is_empty() {
    // rust: return;
}
    // rust: let pick = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(alive.len() as i32)
    // rust: .unwrap_or(0);
    // rust: let p = alive[pick as usize];
    // rust: let mut offset = || {
    // rust: let n = 8 + self.world.random.next_int_bound(24).unwrap_or(0);
    // rust: if self.world.random.next_boolean() {
    // rust: -n
    // rust: } else {
    // rust: n
}
}
    // rust: let x = offset();
    // rust: let z = offset();
    // rust: let pos = [
    // rust: p.x.floor() as i32 + x,
    // rust: p.y.floor() as i32,
    // rust: p.z.floor() as i32 + z,
    // rust: ];
        // hasChunksAt(pos +- 10)
    // rust: let loaded = ((pos[0] - 10) >> 4..=(pos[0] + 10) >> 4).all(|cx| {
    // rust: ((pos[2] - 10) >> 4..=(pos[2] + 10) >> 4)
    // rust: .all(|cz| self.world.chunks.contains_key(&(cx, cz)))
    // rust: });
    // rust: if !loaded {
    // rust: return;
}
    // rust: let ok = spawn_rules::is_spawn_position_ok(
    // rust: Species::Cat,
    // rust: &self.mob_world_base(&[]),
    // rust: pos[0],
    // rust: pos[1],
    // rust: pos[2],
    // rust: );
    // rust: if !ok {
    // rust: return;
}
    // rust: if sections_to_village(&self.village_centers(), section(pos)) <= 2 {
    // rust: self.spawn_cat_in_village(pos);
    // rust: } else {
    // rust: let hut = self.structure_tag("minecraft:cats_spawn_in");
    // rust: if self.structures_at(pos).iter().any(|s| hut.contains(s)) {
    // rust: self.spawn_cat_in_hut(pos);
}
}
}
    // `spawnInVillage`: more than four occupied beds within 48 blocks and
    // fewer than five cats around.
spawn_cat_in_village :: proc(self: ^Self, pos: [i32; 3]) {
}
        // PoiManager.getCountInRange(HOME, IS_OCCUPIED): beds villagers have claimed.
    // rust: let mut beds: Vec<[i32; 3]> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.species() == Species::Villager && m.alive())
    // rust: .filter_map(|m| m.extra.bed)
    // rust: .filter(|b| {
    // rust: let d = |i: usize| i64::from(b[i] - pos[i]);
    // rust: d(0).abs() <= 48
    // rust: && d(2).abs() <= 48
    // rust: && d(0).pow(2) + d(1).pow(2) + d(2).pow(2) <= 48 * 48
    // rust: })
    // rust: .collect();
    // rust: beds.sort_unstable();
    // rust: beds.dedup();
    // rust: if beds.len() > 4 && self.cats_near(pos, 48.0) < 5 {
    // rust: self.spawn_cat(pos, false);
}
}
    // `spawnInHut`: no cat within 16 blocks; the cat stays.
spawn_cat_in_hut :: proc(self: ^Self, pos: [i32; 3]) {
}
    // rust: if self.cats_near(pos, 16.0) == 0 {
    // rust: self.spawn_cat(pos, true);
}
}
    // Cats in `AABB(pos).inflate(radius, 8, radius)`.
cats_near :: proc(self: ^Self, pos: [i32; 3], radius: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = pos.map(f64::from);
    // rust: let min = Vec3::new(x - radius, y - 8.0, z - radius);
    // rust: let max = Vec3::new(x + 1.0 + radius, y + 9.0, z + 1.0 + radius);
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: m.species() == Species::Cat && m.alive() && m.bounds().intersects_corners(min, max)
    // rust: })
    // rust: .count()
}
    // `spawnCat`: finalized for a natural spawn, black inside
    // `#cats_spawn_as_black` structures (`Cat.finalizeSpawn`).
spawn_cat :: proc(self: ^Self, pos: [i32; 3], persistent: bool) {
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let Some(id) = self.spawn_mob("minecraft:cat", at, persistent) else {
    // rust: return;
}
    // rust: let black = self.structure_tag("minecraft:cats_spawn_as_black");
    // rust: let in_black = self.structures_at(pos).iter().any(|s| black.contains(s));
    // rust: if in_black && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.extra.variant = 10;
}
}
}
