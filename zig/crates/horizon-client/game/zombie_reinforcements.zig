//! Transpiled from Horizon Rust crate
//! Module: horizon-client_zombie_reinforcements
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Zombie.hurtServer`'s reinforcements: a hurt zombie on Hard may call
//! another of its kind from 7 to 40 blocks away to fight its target.
// use super::Game;
// use horizon_client::mobs::{
    // rust: MobType, Species, Who,
    // rust: finalize::{self, Attr, Op},
    // rust: spawn_rules::{self, Reason},
    // rust: spawn_selection::{self, NaturalLevel},
    // rust: spawner::SpawnerLevel,
}
// use horizon_core::random::{LegacyRandom, RandomSource};
// use horizon_world::food::Difficulty;

/// `Zombie.REINFORCEMENT_ATTEMPTS`.
pub const ATTEMPTS: usize = 50;
/// `Zombie.REINFORCEMENT_RANGE_MIN` and `REINFORCEMENT_RANGE_MAX`.
pub const RANGE_MIN: i32 = 7;
pub const RANGE_MAX: i32 = 40;

/// One axis of the offset: `Mth.nextInt(random, 7, 40) * Mth.nextInt(random, -1, 1)`.
pub fn offset(random: *mut LegacyRandom) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let distance = random
    // rust: .next_int_between_inclusive(RANGE_MIN, RANGE_MAX)
    // rust: .unwrap_or(RANGE_MIN);
    // rust: distance * random.next_int_between_inclusive(-1, 1).unwrap_or(0)
}

    // rust: impl Game<'_> {
    /// `Zombie.hurtServer` after the hit: on Hard, with the zombie's chance
    /// and monsters spawning, a copy of it appears out of sight and takes
    /// `target`; both then call less often.
    // rust: pub(super) fn call_reinforcements(&mut self, caller: u32, target: Who) {
    // rust: let Some(index) = self.mobs.iter().position(|m| m.id == caller) else {
    // rust: return;
}
    // rust: if self.world.health_rules.difficulty != Difficulty::Hard {
    // rust: return;
}
    // rust: let zombie = &mut self.mobs[index];
    // rust: if f64::from(zombie.random.next_float()) >= zombie.attrs.spawn_reinforcements {
    // rust: return;
}
        // ServerLevel.isSpawningMonsters.
    // rust: if !self.ui.rules.bool("spawn_mobs") || !self.ui.rules.bool("spawn_monsters") {
    // rust: return;
}
    // rust: let kind = zombie.kind.clone();
    // rust: let from = [
    // rust: zombie.position.x.floor() as i32,
    // rust: zombie.position.y.floor() as i32,
    // rust: zombie.position.z.floor() as i32,
    // rust: ];
    // rust: let mut own = std::mem::replace(&mut zombie.random, LegacyRandom::new(0));
    // rust: let mut rules = std::mem::replace(&mut self.world.random, LegacyRandom::new(0));
    // rust: let spot = self.reinforcement_spot(&kind, from, &mut own, &mut rules);
    // rust: self.mobs[index].random = own;
    // rust: self.world.random = rules;
    // rust: let Some(spot) = spot else {
    // rust: return;
}
    // rust: let Some(id) = self.spawn_mob_reason(&kind.id, spot.map(f64::from), false, false, false)
    // rust: else {
    // rust: return;
}
    // rust: if let Some(reinforcement) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: reinforcement.ai.target = Some(target);
            // ZOMBIE_REINFORCEMENT_CALLEE_CHARGE.
    // rust: finalize::add_modifier(
    // rust: reinforcement,
    // rust: Attr::SpawnReinforcements,
    // rust: "minecraft:reinforcement_callee_charge",
    // rust: -f64::from(0.05f32),
    // rust: Op::AddValue,
    // rust: );
}
        // The caller's charge grows by 0.05 each time it calls.
    // rust: let caller = &mut self.mobs[index];
    // rust: let charged = finalize::modifier_amount(
    // rust: caller,
    // rust: Attr::SpawnReinforcements,
    // rust: "minecraft:reinforcement_caller_charge",
    // rust: )
    // rust: .unwrap_or(0.0);
    // rust: finalize::add_modifier(
    // rust: caller,
    // rust: Attr::SpawnReinforcements,
    // rust: "minecraft:reinforcement_caller_charge",
    // rust: charged - 0.05,
    // rust: Op::AddValue,
    // rust: );
}
    /// The block `Zombie.hurtServer` puts the reinforcement at: the first of
    /// 50 random offsets with a valid spawn surface, no alive player within
    /// 7 blocks, and room for the zombie standing on the block's corner.
    // rust: fn reinforcement_spot(
    // rust: &self,
    // rust: kind: &MobType,
    // rust: from: [i32; 3],
    // rust: own: &mut LegacyRandom,
    // rust: rules: &mut LegacyRandom,
    // rust: ) -> Option<[i32; 3]> {
    // rust: let level = self.natural_level();
    // rust: let (width, height) = (kind.width as f32, kind.height as f32);
    // rust: for _ in 0..ATTEMPTS {
    // rust: let [x, y, z] = from.map(|v| v + offset(own));
    // rust: if !spawn_rules::is_spawn_position_ok(kind.species, &level, x, y, z)
    // rust: || !spawn_rules::check_spawn_rules(
    // rust: kind.species,
    // rust: &level,
    // rust: Reason::Reinforcement,
    // rust: rules,
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: )
    // rust: {
    // rust: continue;
}
            // setPos(x, y, z): the box is centred on the block's corner.
    // rust: let bounds =
    // rust: spawn_selection::spawn_box(f64::from(x), f64::from(y), f64::from(z), width, height);
            // Drowned.canSpawnInLiquids.
    // rust: let wet_ok = kind.species == Species::Drowned
    // rust: || !spawn_selection::contains_any_liquid(&level, bounds);
    // rust: if !level.alive_player_near(f64::from(x), f64::from(y), f64::from(z), 7.0)
    // rust: && level.unobstructed(bounds)
    // rust: && level.no_collision(bounds)
    // rust: && wet_ok
    // rust: {
    // rust: return Some([x, y, z]);
}
}
    // rust: None
}
}
