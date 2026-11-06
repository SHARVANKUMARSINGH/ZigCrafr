//! Transpiled from Horizon Rust crate
package horizon_client_trial_visuals

import "core:fmt"
import "core:mem"
import "core:math"

// The client side of trial spawners and vaults: `LevelEventHandler` 3011 to
// 3021, `TrialSpawner.tickClient` (the state's particles, the spinning mob,
// the ambient sound) and `VaultBlockEntity.Client.tick` (idle smoke and
// flames, the connection particles towards the player, the ambient sound).
// Every draw comes from the client level's random.
// use super::Game;
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: mobs::trial_spawner::TrialState,
    // rust: particles::{ParticleOptions, ParticleType as T},
}
// use horizon_core::random::{LegacyRandom, RandomSource};

    // rust: type Pos = (i32, i32, i32);

// `Mth.nextDouble`.
next_double :: proc(random: ^LegacyRandom, min: f64, max: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: random.next_double() * (max - min) + min
}
}
// `Vec3.offsetRandom`.
offset_random :: proc(v: [f64; 3], random: ^LegacyRandom, amount: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: v.map(|c| c + f64::from((random.next_float() - 0.5) * amount))
}
// The pitch of `playLocalSound`'s block event sounds.
event_pitch :: proc(random: ^LegacyRandom) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (random.next_float() - random.next_float()) * 0.2 + 1.0
}
center :: proc(pos: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: pos.map(|v| f64::from(v) + 0.5)
}
flame :: proc(ominous: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if ominous {
    // rust: T::SoulFireFlame
    // rust: } else {
    // rust: T::SmallFlame
}
}

    // rust: impl Game<'_> {
particle :: proc(self: ^Self, ty: T, p: [f64; 3], v: [f64; 3]) {
}
    // rust: self.particles.add(&ParticleOptions::simple(ty), p, v);
}
local_sound :: proc(self: ^Self, name: string, pos: [i32; 3], volume: f32, pitch: f32) {
}
    // rust: self.audio.play(
    // rust: &format!("minecraft:{name}"),
    // rust: Some(center(pos)),
    // rust: volume,
    // rust: pitch,
    // rust: );
}
    // `LevelEventHandler.levelEvent` 3011 to 3021.
    // rust: pub(super) fn trial_level_event(&mut self, id: i32, pos: [i32; 3], data: i32) {
        // TrialSpawner.FlameParticle.decode.
    // rust: let spawn_flame = if data == 1 {
    // rust: T::SoulFireFlame
    // rust: } else {
    // rust: T::Flame
}
    // rust: let sound = |s: &mut Self, name: &str, volume: f32| {
    // rust: let pitch = event_pitch(s.particles.level_random());
    // rust: s.local_sound(name, pos, volume, pitch);
}
    // rust: match id {
    // rust: 3011 => self.trial_spawn_particles(pos, spawn_flame),
    // rust: 3012 => {
    // rust: sound(self, "block.trial_spawner.spawn_mob", 1.0);
    // rust: self.trial_spawn_particles(pos, spawn_flame);
}
    // rust: 3013 | 3019 => {
    // rust: sound(self, "block.trial_spawner.detect_player", 1.0);
    // rust: let ty = if id == 3013 {
    // rust: T::TrialSpawnerDetection
    // rust: } else {
    // rust: T::TrialSpawnerDetectionOminous
}
    // rust: self.detect_player_particles(pos, data, ty);
}
    // rust: 3014 => {
    // rust: sound(self, "block.trial_spawner.eject_item", 1.0);
    // rust: self.eject_item_particles(pos);
}
    // rust: 3015 => {
    // rust: if matches!(
    // rust: self.world.block_entities.get(&(pos[0], pos[1], pos[2])),
    // rust: Some(BlockEntity::Vault(_))
    // rust: ) {
    // rust: self.vault_activation_particles(pos, data != 0);
    // rust: sound(self, "block.vault.activate", 1.0);
}
}
    // rust: 3016 => {
                // emitDeactivationParticles.
    // rust: let ty = flame(data != 0);
    // rust: for _ in 0..20 {
    // rust: let random = self.particles.level_random();
    // rust: let p = [0.4, 0.4, 0.4].map(|lo| next_double(random, lo, 0.6));
    // rust: let v = [0; 3].map(|_| random.next_gaussian() * 0.02);
    // rust: let at = std::array::from_fn(|i| f64::from(pos[i]) + p[i]);
    // rust: self.particle(ty, at, v);
}
    // rust: sound(self, "block.vault.deactivate", 1.0);
}
    // rust: 3017 => self.eject_item_particles(pos),
    // rust: 3018 => {
    // rust: for _ in 0..10 {
    // rust: let random = self.particles.level_random();
    // rust: let v = [0; 3].map(|_| random.next_gaussian() * 0.02);
    // rust: let at = pos.map(|c| f64::from(c) + random.next_double());
    // rust: self.particle(T::Poof, at, v);
}
    // rust: sound(self, "block.cobweb.place", 1.0);
}
    // rust: 3020 => {
    // rust: sound(
    // rust: self,
    // rust: "block.trial_spawner.ominous_activate",
    // rust: if data == 0 { 0.3 } else { 1.0 },
    // rust: );
    // rust: self.detect_player_particles(pos, 0, T::TrialSpawnerDetectionOminous);
                // addBecomeOminousParticles.
    // rust: for _ in 0..20 {
    // rust: let random = self.particles.level_random();
    // rust: let at = pos.map(|c| f64::from(c) + 0.5 + (random.next_double() - 0.5) * 2.0);
    // rust: let v = [0; 3].map(|_| random.next_gaussian() * 0.02);
    // rust: self.particle(T::TrialOmen, at, v);
    // rust: self.particle(T::SoulFireFlame, at, v);
}
}
    // rust: 3021 => {
    // rust: sound(self, "block.trial_spawner.spawn_item", 1.0);
    // rust: self.trial_spawn_particles(pos, spawn_flame);
}
    // rust: _ => {}
}
}
    // `TrialSpawner.addSpawnParticles`.
trial_spawn_particles :: proc(self: ^Self, pos: [i32; 3], ty: T) {
}
    // rust: for _ in 0..20 {
    // rust: let random = self.particles.level_random();
    // rust: let at = pos.map(|c| f64::from(c) + 0.5 + (random.next_double() - 0.5) * 2.0);
    // rust: self.particle(T::Smoke, at, [0.0; 3]);
    // rust: self.particle(ty, at, [0.0; 3]);
}
}
    // `TrialSpawner.addDetectPlayerParticles`.
detect_player_particles :: proc(self: ^Self, pos: [i32; 3], data: i32, ty: T) {
}
    // rust: for _ in 0..30 + data.min(10) * 5 {
    // rust: let random = self.particles.level_random();
    // rust: let x = f64::from(2.0 * random.next_float() - 1.0) * 0.65;
    // rust: let z = f64::from(2.0 * random.next_float() - 1.0) * 0.65;
    // rust: let y = f64::from(pos[1]) + 0.1 + f64::from(random.next_float()) * 0.8;
    // rust: let at = [f64::from(pos[0]) + 0.5 + x, y, f64::from(pos[2]) + 0.5 + z];
    // rust: self.particle(ty, at, [0.0; 3]);
}
}
    // `TrialSpawner.addEjectItemParticles`.
eject_item_particles :: proc(self: ^Self, pos: [i32; 3]) {
}
    // rust: for _ in 0..20 {
    // rust: let random = self.particles.level_random();
    // rust: let at = pos.map(|c| f64::from(c) + 0.4 + random.next_double() * 0.2);
    // rust: let v = [0; 3].map(|_| random.next_gaussian() * 0.02);
    // rust: self.particle(T::SmallFlame, at, [v[0], v[1], v[2] * 0.25]);
    // rust: self.particle(T::Smoke, at, v);
}
}
    // `TrialSpawner.tickClient`: the state's particles, the spin of the
    // mob shown inside and the ambient sound.
    // rust: pub(super) fn client_tick_trial_spawner(&mut self, key: Pos) {
    // rust: let Some((state, ominous)) = self.trial_spawner_block(key) else {
    // rust: return;
}
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let time = self.world.game_time;
    // rust: let c = center(pos);
    // rust: let random = self.particles.level_random();
        // TrialSpawnerState.ParticleEmission.
    // rust: let mut emitted: Vec<(T, [f64; 3])> = Vec::new();
    // rust: match state {
    // rust: TrialState::WaitingForPlayers
    // rust: | TrialState::WaitingForRewardEjection
    // rust: | TrialState::EjectingReward => {
    // rust: if random.next_int_bound(2) == Ok(0) {
    // rust: emitted.push((flame(ominous), offset_random(c, random, 0.9)));
}
}
    // rust: TrialState::Active => {
    // rust: let at = offset_random(c, random, 1.0);
    // rust: let ty = if ominous { T::SoulFireFlame } else { T::Flame };
    // rust: emitted.extend([(T::Smoke, at), (ty, at)]);
}
    // rust: TrialState::Cooldown => {
    // rust: let at = offset_random(c, random, 0.9);
    // rust: if random.next_int_bound(3) == Ok(0) {
    // rust: emitted.push((T::Smoke, at));
}
    // rust: if time % 20 == 0 {
    // rust: let top = [c[0], c[1] + 0.5, c[2]];
    // rust: let count = random.next_int_bound(4).unwrap_or(0) + 20;
    // rust: emitted.extend((0..count).map(|_| (T::Smoke, top)));
}
}
    // rust: TrialState::Inactive => {}
}
    // rust: let ambient = state.capable_of_spawning() && random.next_float() <= 0.02;
    // rust: let ambient =
    // rust: ambient.then(|| (random.next_float() * 0.25 + 0.75, random.next_float() + 0.5));
    // rust: for (ty, at) in emitted {
    // rust: self.particle(ty, at, [0.0; 3]);
}
    // rust: if let Some(BlockEntity::TrialSpawner(s)) = self.world.block_entities.get_mut(&key)
    // rust: && let Some(speed) = state.spinning_mob_speed()
    // rust: {
    // rust: let delay = (s.next_mob_spawns_at - time).max(0) as f64;
    // rust: s.o_spin = s.spin;
    // rust: s.spin = (s.spin + speed / (delay + 200.0)) % 360.0;
}
    // rust: if let Some((volume, pitch)) = ambient {
    // rust: let name = if ominous {
    // rust: "block.trial_spawner.ambient_ominous"
    // rust: } else {
    // rust: "block.trial_spawner.ambient"
}
    // rust: self.local_sound(name, pos, volume, pitch);
}
    // rust: self.update_spawner_display(key);
}
    // `VaultBlockEntity.Client.tick`.
    // rust: pub(super) fn client_tick_vault(&mut self, key: Pos) {
    // rust: let Some((mut vault, _, ominous)) = self.take_vault(key) else {
    // rust: return;
}
    // rust: vault.update_display_item_spin();
    // rust: let shows = vault.display_item.is_some();
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Vault(vault));
    // rust: let pos = [key.0, key.1, key.2];
    // rust: if self.world.game_time % 20 == 0 {
    // rust: self.vault_connection_particles(pos);
}
        // emitIdleParticles.
    // rust: let random = self.particles.level_random();
    // rust: if random.next_float() <= 0.5 {
    // rust: let at = cage_point(pos, random);
    // rust: self.particle(T::Smoke, at, [0.0; 3]);
    // rust: if shows {
    // rust: self.particle(flame(ominous), at, [0.0; 3]);
}
}
        // playIdleSounds.
    // rust: if shows {
    // rust: let random = self.particles.level_random();
    // rust: if random.next_float() <= 0.02 {
    // rust: let volume = random.next_float() * 0.25 + 0.75;
    // rust: let pitch = random.next_float() + 0.5;
    // rust: self.local_sound("block.vault.ambient", pos, volume, pitch);
}
}
}
    // `VaultBlockEntity.Client.emitActivationParticles`.
vault_activation_particles :: proc(self: ^Self, pos: [i32; 3], ominous: bool) {
}
    // rust: self.vault_connection_particles(pos);
    // rust: for _ in 0..20 {
    // rust: let at = cage_point(pos, self.particles.level_random());
    // rust: self.particle(T::Smoke, at, [0.0; 3]);
    // rust: self.particle(flame(ominous), at, [0.0; 3]);
}
}
    // `emitConnectionParticlesForNearbyPlayers`: from the keyhole towards
    // each connected player within the particles' range.
vault_connection_particles :: proc(self: ^Self, pos: [i32; 3]) {
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Vault(vault)) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: let me = self.level.player_uuid.unwrap_or_default();
    // rust: let range = vault.connected_particles_range;
        // VaultSharedData.getConnectedPlayers, each through getPlayerByUUID: the
        // host and the guests, with their position and height.
    // rust: let mut players = Vec::new();
    // rust: for uuid in &vault.connected_players {
    // rust: if *uuid == me {
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: players.push((at, p.dimensions.height));
}
    // rust: } else if let Some(g) = self.lan_present().into_iter().find(|g| g.uuid == *uuid) {
    // rust: players.push((g.position, g.height));
}
}
    // rust: if players.is_empty() {
    // rust: return;
}
    // rust: let facing = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .and_then(|b| b.properties.get("facing").cloned());
    // rust: let step = match facing.as_deref() {
    // rust: Some("south") => [0.0, 1.0],
    // rust: Some("west") => [-1.0, 0.0],
    // rust: Some("east") => [1.0, 0.0],
    // rust: _ => [0.0, -1.0],
}
        // keyholePos: the bottom centre, 1.75 up and half a block out the front.
    // rust: let keyhole = [
    // rust: f64::from(pos[0]) + 0.5 + step[0] * 0.5,
    // rust: f64::from(pos[1]) + 1.75,
    // rust: f64::from(pos[2]) + 0.5 + step[1] * 0.5,
    // rust: ];
    // rust: for (at, height) in players {
            // isWithinConnectionRange: player.blockPosition().distSqr(vault) in range.
    // rust: let block = at.map(|v| v.floor() as i32);
    // rust: let d = [0, 1, 2].map(|i| f64::from(block[i] - pos[i]));
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] > range * range {
    // rust: continue;
}
    // rust: let target = [at[0], at[1] + f64::from(height / 2.0), at[2]];
    // rust: let direction: [f64; 3] = std::array::from_fn(|i| target[i] - keyhole[i]);
    // rust: let random = self.particles.level_random();
    // rust: let count = random.next_int_bound(4).unwrap_or(0) + 2;
    // rust: for _ in 0..count {
    // rust: let v = offset_random(direction, self.particles.level_random(), 1.0);
    // rust: self.particle(T::VaultConnection, keyhole, v);
}
}
}
}

// `randomPosInsideCage`.
cage_point :: proc(pos: [i32; 3], random: ^LegacyRandom) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let x = next_double(random, 0.1, 0.9);
    // rust: let y = next_double(random, 0.25, 0.75);
    // rust: let z = next_double(random, 0.1, 0.9);
    // rust: [
    // rust: f64::from(pos[0]) + x,
    // rust: f64::from(pos[1]) + y,
    // rust: f64::from(pos[2]) + z,
    // rust: ]
}
