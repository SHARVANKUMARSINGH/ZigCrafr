//! Transpiled from Horizon Rust crate
//! Module: horizon-client_random_textures
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! OptiFine random entity textures: each mob's variants, chosen when this window first sees it
//! and checked again once a second, counted in this window's ticks so a frozen world still
//! checks (`horizon_client::mobs::random_textures`).

// use super::Game;
// use horizon_client::mobs::random_textures::{Seen, choose, seed};
// use horizon_core::geometry::Vec3;
// use horizon_optifine::random::Weather;

    // rust: impl Game<'_> {
    // rust: pub(super) fn tick_random_textures(&mut self) {
    // rust: let res = self.res.clone();
    // rust: let textures = res
    // rust: .mob_data()
    // rust: .random_textures
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: if textures.is_empty() {
    // rust: return;
}
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &mut self.mobs[i];
    // rust: let id = m.id;
    // rust: if !m.random_textures.due(&textures, id) {
    // rust: continue;
}
    // rust: let m = &self.mobs[i];
    // rust: let seed = seed(m, self.persist.uuids.get(&id).copied());
    // rust: let seen = (!m.random_textures.has_seen()).then(|| self.seen_at(m.position));
    // rust: choose(&mut self.mobs[i], &textures, res.mob_data(), seen, seed);
}
}

    /// What OptiFine reads of a mob's surroundings when it first appears.
pub fn seen_at(self: *Self, at: Vec3) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, z) = (
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: );
    // rust: let block = |y| {
    // rust: let state = self.pack.assets.registry.state(self.world.block(x, y, z))?;
    // rust: let properties = state
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), v.clone()))
    // rust: .collect();
    // rust: Some((state.name.clone(), properties))
}
    // rust: let weather = &self.world.weather;
    // rust: Seen {
    // rust: biome: self.biome_name_at(at),
    // rust: y,
    // rust: blocks: [block(y - 1), block(y)].into_iter().flatten().collect(),
    // rust: moon_phase: self.world.day_time.div_euclid(24_000).rem_euclid(8) as i32,
    // rust: day_time: self.world.day_time.rem_euclid(24_000) as i32,
    // rust: weather: if weather.thundering {
    // rust: Weather::Thunder
    // rust: } else if weather.raining {
    // rust: Weather::Rain
    // rust: } else {
    // rust: Weather::Clear
    // rust: },
}
}
}
