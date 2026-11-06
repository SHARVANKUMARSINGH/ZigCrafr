//! Transpiled from Horizon Rust crate
package horizon_client_block_entity_anims

import "core:fmt"
import "core:mem"
import "core:math"

// The client side of animated block entities (`horizon_client::block_entity_anim`):
// their client tickers (`Level.tickBlockEntities` on the client level) and
// the block events that drive them (`ClientboundBlockEventPacket` reaching
// `BlockEntity.triggerEvent`). The renderer reads the resulting state through
// [`Game::block_anim`] and [`Game::chest_lid`].
// use super::Game;
// use horizon_client::{
    // rust: block_entity_anim::{
    // rust: BellEntity, ConduitServer, ConduitTarget, EndGateway, Shulker, ShulkerStatus, Ticker,
    // rust: closer_to_center_than,
    // rust: },
    // rust: block_entity_render::BlockAnim,
    // rust: collisions::{SceneCollisions, no_collision_empty},
    // rust: containers::BlockEntity,
    // rust: effects::EffectInstance,
    // rust: mobs::{Damage, DamageKind},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: save::number,
    // rust: skins,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::nbt::Tag;

// The handle of the local player among a bell's gathered entities.
PLAYER :: u64::MAX

// `ContainerOpenersCounter.getEntitiesWithContainerOpen` as Horizon can
// answer it: of the containers players have open at this moment, the ones at
// `key` (`ChestBlockEntity$1.isOwnContainer` compares the menu's container
// with the block entity, and a double chest counts for both halves).
    // rust: pub(super) fn openers_at(open: &[(i32, i32, i32)], key: (i32, i32, i32)) -> i32 {
    // rust: open.iter().filter(|&&at| at == key).count() as i32
}

// `ContainerOpenersCounter.recheckOpeners`: the opener count a recount finds
// at `key`, and the count it replaces. The entry is dropped at zero, as
// `Game::count_opener` does when the last opener leaves, so the next opener to
// arrive counts from zero.
    // rust: pub(super) fn recheck_opener_count(
    // rust: counts: &mut std::collections::HashMap<(i32, i32, i32), i32>,
    // rust: open: &[(i32, i32, i32)],
    // rust: key: (i32, i32, i32),
    // rust: ) -> (i32, i32) {
    // rust: let previous = counts.get(&key).copied().unwrap_or(0);
    // rust: let count = openers_at(open, key);
    // rust: if count == 0 {
    // rust: counts.remove(&key);
    // rust: } else if count != previous {
    // rust: counts.insert(key, count);
}
    // rust: (previous, count)
}

    // rust: impl Game<'_> {
    // `BlockEntity.triggerEvent(a, b)` on the client copy of the block entity at `pos`.
    // rust: pub(super) fn block_entity_event(&mut self, pos: [i32; 3], a: i32, b: i32) {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0;
    // rust: let time = self.world.game_time;
        // PotentSulfurBlock.triggerEvent.
    // rust: if self.potent_sulfur_eruption_event((pos[0], pos[1], pos[2])) {
    // rust: return;
}
    // rust: match self.be_anims.ticker(state) {
    // rust: Some(Ticker::Lid) => {
    // rust: self.be_anims
    // rust: .chests
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .trigger_event(a, b);
}
    // rust: Some(Ticker::Shulker { .. }) => {
    // rust: self.be_anims
    // rust: .shulkers
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .trigger_event(a, b);
}
    // rust: Some(Ticker::Bell) => {
    // rust: let gathered = self.bell_gather(pos);
    // rust: let rung =
    // rust: self.be_anims
    // rust: .bells
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .trigger_event(a, b, time, || gathered);
                // The server's copy tells the living entities within 32 blocks.
    // rust: if rung && self.remote.is_none() {
    // rust: self.bell_heard(pos, time);
}
}
    // rust: Some(Ticker::Gateway) => {
    // rust: let initial = self.gateway_loaded(pos);
    // rust: self.be_anims
    // rust: .gateways
    // rust: .entry(pos)
    // rust: .or_insert(initial)
    // rust: .trigger_event(a, b);
}
    // rust: Some(Ticker::Pot) => {
    // rust: self.be_anims
    // rust: .pots
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .trigger_event(a, b, time);
}
    // rust: _ => {}
}
}
    // A player opened (`open`) or closed the container at `key`: the opener
    // count block event (`ContainerOpenersCounter` / `ShulkerBoxBlockEntity`
    // `startOpen`/`stopOpen`) for chests, ender chests and shulker boxes,
    // on both halves of a double chest (`CompoundContainer`). True when the
    // count went from 0 to 1 or back to 0: the only moments the container
    // plays its open or close sound.
    // rust: pub(super) fn container_opener_event(&mut self, key: (i32, i32, i32), open: bool) -> bool {
        // Spectators never count as openers.
    // rust: !self.spectator() && self.container_openers_changed(key, open)
}
    // `container_opener_event` for a player who is not a spectator (a guest).
    // rust: pub(super) fn container_openers_changed(&mut self, key: (i32, i32, i32), open: bool) -> bool {
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0;
    // rust: match self.be_anims.ticker(state) {
    // rust: Some(Ticker::Lid) => {
    // rust: let edge = self.lid_openers_changed(key, open);
    // rust: if let Some(other) = self.chest_other_half(key) {
    // rust: self.lid_openers_changed(other, open);
}
    // rust: edge
}
    // rust: _ if self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: .as_ref()
    // rust: == "minecraft:barrel" =>
    // rust: {
    // rust: self.barrel_openers_changed(key, open)
}
    // rust: Some(Ticker::Shulker { .. }) => {
    // rust: let shulker = self.be_anims.shulkers.entry(pos).or_default();
    // rust: let (count, edge) = if open {
    // rust: shulker.start_open()
    // rust: } else {
    // rust: shulker.stop_open()
}
    // rust: self.block_entity_event(pos, 1, count);
    // rust: self.lan_block_event(pos, 1, count);
    // rust: edge
}
    // rust: _ => false,
}
}
    // `ContainerOpenersCounter.incrementOpeners` / `decrementOpeners` of the
    // chest at `key` (the host and the guests are counted), then
    // `ChestBlockEntity.signalOpenCount`: block event 1 with the count, here
    // and for the guests. True when the count crossed zero.
lid_openers_changed :: proc(self: ^Self, key: (i32) {
}
    // rust: let (before, count) = self.count_opener(key, open);
    // rust: let pos = [key.0, key.1, key.2];
    // rust: self.block_entity_event(pos, 1, count);
    // rust: self.lan_block_event(pos, 1, count);
        // TrappedChestBlockEntity.signalOpenCount: its signal is the count
        // (`TrappedChestBlock.getSignal`), so the blocks around it and
        // below it hear of a change.
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if before != count && self.res.facts().get(state).name.as_ref() == "minecraft:trapped_chest"
    // rust: {
    // rust: let p = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.trapped_chest_update_neighbors(level, ticks, p, state);
    // rust: });
}
    // rust: (before == 0) != (count == 0)
}
    // `BarrelBlockEntity.openersCounter`: the first opener opens the barrel
    // (`open=true`), the last one to leave closes it (`updateBlockState`).
    // True when the count crossed zero.
barrel_openers_changed :: proc(self: ^Self, key: (i32) {
}
    // rust: let (before, count) = self.count_opener(key, open);
    // rust: let edge = (before == 0) != (count == 0);
    // rust: if edge {
    // rust: self.set_bool_prop(
    // rust: key,
    // rust: "open",
    // rust: count > 0,
    // rust: horizon_world::level::flags::UPDATE_ALL,
    // rust: );
}
    // rust: edge
}
    // One opener more (`open`) or less at `key`: the count before and after
    // (`ContainerOpenersCounter.incrementOpeners` / `decrementOpeners`).
count_opener :: proc(self: ^Self, key: (i32) {
}
    // rust: let count = self.lid_openers.entry(key).or_default();
    // rust: let before = *count;
    // rust: *count = (before + if open { 1 } else { -1 }).max(0);
    // rust: let after = *count;
    // rust: if after == 0 {
    // rust: self.lid_openers.remove(&key);
}
        // `ContainerOpenersCounter.incrementOpeners`: the first opener
        // schedules the five-tick recheck of who still has the container open
        // (`scheduleRecheck`, `CHECK_TICK_DELAY`).
    // rust: if open && before == 0 {
    // rust: let pos = BlockPos::new(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| b.schedule_tick(level, ticks, pos, 5));
}
    // rust: (before, after)
}
    // `BellBlockEntity.updateEntities`: the living entities whose bounding
    // box meets the bell's block box inflated by 48.
bell_gather :: proc(self: ^Self, pos: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let area = Aabb::new(
    // rust: Vec3::new(
    // rust: f64::from(pos[0]) - 48.0,
    // rust: f64::from(pos[1]) - 48.0,
    // rust: f64::from(pos[2]) - 48.0,
    // rust: ),
    // rust: Vec3::new(
    // rust: f64::from(pos[0]) + 49.0,
    // rust: f64::from(pos[1]) + 49.0,
    // rust: f64::from(pos[2]) + 49.0,
    // rust: ),
    // rust: );
    // rust: let mut out = Vec::new();
    // rust: if self
    // rust: .player_view()
    // rust: .is_some_and(|p| p.bounds.intersects(area))
    // rust: {
    // rust: out.push(PLAYER);
}
    // rust: for m in &self.mobs {
    // rust: if !m.removed && m.bounds().intersects(area) {
    // rust: out.push(u64::from(m.id));
}
}
    // rust: out
}
    // `BellBlockEntity.updateEntities`: every gathered entity alive within 32
    // blocks of the bell's centre gets `HEARD_BELL_TIME` (only villagers
    // have a brain that reads it).
bell_heard :: proc(self: ^Self, pos: [i32; 3], now: i64) {
}
    // rust: let nearby = self
    // rust: .be_anims
    // rust: .bells
    // rust: .get(&pos)
    // rust: .and_then(|b| b.nearby.clone())
    // rust: .unwrap_or_default();
    // rust: for m in &mut self.mobs {
    // rust: if m.alive()
    // rust: && !m.removed
    // rust: && nearby.contains(&u64::from(m.id))
    // rust: && closer_to_center_than(pos, [m.position.x, m.position.y, m.position.z], 32.0)
    // rust: {
    // rust: horizon_client::mobs::villager_brain::heard_bell(m, now);
}
}
}
    // `ShulkerBoxBlock.canOpen`: a closed box opens only when its lid has
    // room to rise (`level.noCollision` of the half-open lid box).
    // rust: pub(super) fn shulker_can_open(&self, pos: [i32; 3]) -> bool {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0;
    // rust: let Some(Ticker::Shulker { facing }) = self.be_anims.ticker(state) else {
    // rust: return true;
}
    // rust: let closed = self
    // rust: .be_anims
    // rust: .shulkers
    // rust: .get(&pos)
    // rust: .is_none_or(|s| s.status == ShulkerStatus::Closed);
    // rust: if !closed {
    // rust: return true;
}
    // rust: let b = Shulker::lid_box(pos, facing);
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: no_collision_empty(
    // rust: &mut scene,
    // rust: Aabb::new(Vec3::new(b[0], b[1], b[2]), Vec3::new(b[3], b[4], b[5])),
    // rust: )
}
    // `BellBlockEntity.serverTick`: ringing server bells belong to the world,
    // including when no renderer is attached.
tick_bell_servers :: proc(self: ^Self) {
}
    // rust: if self.be_anims.bells.is_empty() {
    // rust: return;
}
    // rust: let mut positions: Vec<_> = self.be_anims.bells.keys().copied().collect();
    // rust: positions.sort_unstable();
    // rust: let raiders = self
    // rust: .res
    // rust: .stations()
    // rust: .enchantments
    // rust: .entity_tags
    // rust: .get("minecraft:raiders")
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: for pos in positions {
    // rust: if self
    // rust: .be_anims
    // rust: .ticker(self.world.block(pos[0], pos[1], pos[2]).0)
    // rust: != Some(Ticker::Bell)
    // rust: {
    // rust: self.be_anims.bells.remove(&pos);
    // rust: } else if self.tickets.levels().block_ticking_at(pos[0], pos[2]) {
    // rust: self.tick_bell(pos, &raiders);
}
}
}

    // `BellBlockEntity.tick` and `makeRaidersGlow`, using live entity/tag state.
tick_bell :: proc(self: ^Self, pos: [i32; 3], raiders: ^std::collections::map[string]struct{}) {
}
    // rust: let player = self.player_view().map(|p| BellEntity {
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: alive: p.alive,
    // rust: raider: false,
    // rust: });
    // rust: let mobs = &self.mobs;
    // rust: let entity = |h: u64| {
    // rust: if h == PLAYER {
    // rust: return player;
}
    // rust: let m = mobs.iter().find(|m| u64::from(m.id) == h)?;
    // rust: Some(BellEntity {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: alive: m.alive() && !m.removed,
    // rust: raider: raiders.contains(&m.kind.id),
    // rust: })
}
    // rust: let tick = self
    // rust: .be_anims
    // rust: .bells
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .tick(pos, entity);
    // rust: let centre = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
        // On a server its own copy does this and sends the sound.
    // rust: if tick.resonate && self.remote.is_none() {
            // The server's copy plays the resonance for everyone.
    // rust: self.audio
    // rust: .play("minecraft:block.bell.resonate", Some(centre), 1.0, 1.0);
}
    // rust: if let Some((particles, glow)) = tick.ended {
    // rust: for (p, color) in particles.into_iter().filter(|_| self.renderer.is_some()) {
                // ColorParticleOption.create(ENTITY_EFFECT, color): ARGB.
    // rust: let c = color as u32;
    // rust: let channel = |shift: u32| ((c >> shift) & 255) as f32 / 255.0;
    // rust: let options = ParticleOptions {
    // rust: color: [channel(16), channel(8), channel(0), channel(24)],
    // rust: ..ParticleOptions::simple(ParticleType::EntityEffect)
}
    // rust: self.particles.add(&options, p, [0.0; 3]);
}
            // makeRaidersGlow (the server's effect).
    // rust: for m in self.mobs.iter_mut().filter(|_| self.remote.is_none()) {
    // rust: if glow.contains(&u64::from(m.id)) {
    // rust: m.add_effect("minecraft:glowing", 60, 0);
}
}
}
}

    // The client tickers of the loaded animated block entities, once per
    // client tick (`ClientLevel.tickBlockEntities`).
    // rust: pub(super) fn tick_block_entity_anims(&mut self) {
        // A server has no window, but its bells, gateways and conduits still run
        // their server tickers; a client of one only animates what it is sent.
    // rust: if self.remote.is_none() {
    // rust: self.tick_conduit_servers();
    // rust: self.tick_bell_servers();
}
    // rust: let Some(r) = &self.renderer else {
    // rust: if self.remote.is_none() {
    // rust: self.tick_gateway_servers();
}
    // rust: return;
}
        // Sorted by position: the order they tick in, and a quick lookup.
        // Read again only when the drawn block entities changed.
    // rust: let revision = r.block_entity_revision();
    // rust: if self.be_anims.present_revision != Some(revision) {
    // rust: let mut present: Vec<([i32; 3], Ticker)> = r
    // rust: .block_entities()
    // rust: .filter_map(|(p, s)| Some((*p, self.be_anims.ticker(*s)?)))
    // rust: .collect();
    // rust: present.sort_unstable_by_key(|(p, _)| *p);
    // rust: if self.remote.is_none() {
    // rust: self.be_anims.retain_present_preserving_bells(&present);
    // rust: } else {
    // rust: self.be_anims.retain_present(&present);
}
    // rust: self.be_anims.present = present;
    // rust: self.be_anims.present_revision = Some(revision);
}
    // rust: let positions = std::mem::take(&mut self.be_anims.present);
    // rust: let players: Vec<[f64; 3]> = match &self.player {
    // rust: Some(p) if !self.spectator() => vec![[p.position.x, p.position.y, p.position.z]],
    // rust: _ => Vec::new(),
}
    // rust: let raiders = self
    // rust: .res
    // rust: .stations()
    // rust: .enchantments
    // rust: .entity_tags
    // rust: .get("minecraft:raiders")
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: let frames = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:conduit_effect_block")
    // rust: .cloned()
    // rust: .unwrap_or_default();
        // The lids this tick swept (`moveCollidedEntities`), for the player
        // this client moves itself.
    // rust: let mut shulker_pushes = Vec::new();
    // rust: for &(pos, ticker) in &positions {
    // rust: match ticker {
    // rust: Ticker::Lid => self.be_anims.chests.entry(pos).or_default().tick(),
    // rust: Ticker::Book => {
    // rust: let anims = &mut self.be_anims;
    // rust: anims
    // rust: .books
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .tick(pos, &players, &mut anims.book_random);
}
    // rust: Ticker::Shulker { facing } => {
                    // `ShulkerBoxBlockEntity.tick` runs on both sides: the
                    // client moves its own player, including with a menu open.
                    // The server ticks its boxes in `tick_block_entities`.
    // rust: if self.remote.is_some() {
    // rust: let tick = self
    // rust: .be_anims
    // rust: .shulkers
    // rust: .entry(pos)
    // rust: .or_default()
    // rust: .tick(pos, facing);
    // rust: if let Some(push) = tick.push {
    // rust: shulker_pushes.push((pos, facing, push));
}
}
}
    // rust: Ticker::Skull { powered } => {
    // rust: self.be_anims.skulls.entry(pos).or_default().tick(powered);
}
    // rust: Ticker::Bell => {
                    // Integrated servers already ticked this state above, independently
                    // of drawn block entities. Remote clients only animate their copy.
    // rust: if self.remote.is_some() {
    // rust: self.tick_bell(pos, &raiders);
}
}
    // rust: Ticker::Conduit => {
    // rust: let target = self.conduit_target(pos);
    // rust: let world = &self.world;
    // rust: let facts = self.res.facts();
    // rust: let registry = self.pack.assets.registry;
    // rust: let is_water = |p: [i32; 3]| {
    // rust: facts.get(world.block(p[0], p[1], p[2])).fluid
    // rust: == horizon_client::blocks::Fluid::Water
}
    // rust: let is_frame = |p: [i32; 3]| {
    // rust: registry
    // rust: .state(world.block(p[0], p[1], p[2]))
    // rust: .is_some_and(|s| frames.contains(&s.name))
}
    // rust: let time = world.game_time;
    // rust: let anims = &mut self.be_anims;
    // rust: let particles = anims.conduits.entry(pos).or_default().client_tick(
    // rust: pos,
    // rust: time,
    // rust: is_water,
    // rust: is_frame,
    // rust: target,
    // rust: self.particles.random(),
    // rust: );
    // rust: let nautilus = ParticleOptions::simple(ParticleType::Nautilus);
    // rust: for (p, v) in particles {
    // rust: self.particles.add(&nautilus, p, v);
}
}
    // rust: Ticker::Pot => {}
    // rust: Ticker::Gateway => {
                    // The server copy's portalTick runs first; its block event
                    // reaches the client copy before the client ticks it.
    // rust: let initial = self.gateway_loaded(pos);
    // rust: let anims = &mut self.be_anims;
    // rust: let server = anims.gateway_servers.entry(pos).or_insert(initial);
                    // A server sends its copy's block event instead.
    // rust: let triggered = self.remote.is_none() && server.portal_tick();
    // rust: let client = anims.gateways.entry(pos).or_insert(initial);
    // rust: if triggered {
    // rust: client.trigger_event(1, 0);
}
    // rust: client.tick();
}
}
}
    // rust: self.be_anims.present = positions;
        // The lid's grown box collides and pushes here too: a client of a
        // server owns its own player's position, so the server's
        // `moveCollidedEntities` alone would be undone by the client's next
        // move, and a lid the client cannot collide with never holds it up.
        // Only the player: `tick_block_entities` has already pushed the mobs
        // and the guests, and a second push would double the lift.
    // rust: if self.remote.is_some() {
    // rust: self.sync_shulkers();
    // rust: self.push_shulker_local(shulker_pushes);
}
}
    // `ConduitBlockEntity.serverTick` of every conduit in the chunks that
    // tick blocks, with or without a renderer. The conduits are looked for
    // when the shape is checked, every 40 ticks (they have no block entity
    // of their own here).
tick_conduit_servers :: proc(self: ^Self) {
}
    // rust: if self.world.game_time % 40 == 0 {
    // rust: self.find_conduits();
}
    // rust: let mut positions: Vec<[i32; 3]> = self.be_anims.conduit_servers.keys().copied().collect();
    // rust: positions.sort_unstable();
    // rust: for pos in positions {
    // rust: self.tick_conduit_server(pos);
}
}
    // Sets `be_anims.conduit_servers` to the conduits in the
    // chunks that tick blocks, keeping the state of those already known.
find_conduits :: proc(self: ^Self) {
}
    // rust: let levels = self.tickets.levels();
    // rust: let kinds = &self.be_anims.kinds;
    // rust: let is_conduit = |id: u32| matches!(kinds.get(id as usize), Some(Some(Ticker::Conduit)));
    // rust: let mut found = Vec::new();
    // rust: for (&(cx, cz), chunk) in &self.world.chunks {
    // rust: if !levels.block_ticking_at(cx * 16, cz * 16) {
    // rust: continue;
}
    // rust: for (si, section) in chunk.sections.iter().enumerate() {
    // rust: if !section.blocks.maybe_has(is_conduit) {
    // rust: continue;
}
    // rust: for i in 0..4096 {
    // rust: if is_conduit(section.get(i)) {
    // rust: found.push([
    // rust: cx * 16 + (i & 15) as i32,
    // rust: self.world.bottom_y() + si as i32 * 16 + (i >> 8) as i32,
    // rust: cz * 16 + ((i >> 4) & 15) as i32,
    // rust: ]);
}
}
}
}
    // rust: let mut old = std::mem::take(&mut self.be_anims.conduit_servers);
    // rust: for pos in found {
    // rust: let known = old.remove(&pos).unwrap_or_default();
    // rust: self.be_anims.conduit_servers.insert(pos, known);
}
}
    // `ConduitBlockEntity.serverTick` of the conduit at `pos`, in a chunk
    // that ticks blocks: the shape check every 40 ticks with its sounds, the
    // power for players in range, the hurt for an enemy, then the ambient
    // sounds.
tick_conduit_server :: proc(self: ^Self, pos: [i32; 3]) {
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0;
    // rust: if self.be_anims.ticker(state) != Some(Ticker::Conduit) {
            // Broken since the chunks were searched.
    // rust: self.be_anims.conduit_servers.remove(&pos);
    // rust: return;
}
    // rust: if !self.tickets.levels().block_ticking_at(pos[0], pos[2])
    // rust: || !self.border.contains(f64::from(pos[0]), f64::from(pos[2]))
    // rust: {
    // rust: return;
}
    // rust: let time = self.world.game_time;
    // rust: let mut conduit = self
    // rust: .be_anims
    // rust: .conduit_servers
    // rust: .remove(&pos)
    // rust: .unwrap_or_default();
    // rust: let check = {
    // rust: let world = &self.world;
    // rust: let facts = self.res.facts();
    // rust: let registry = self.pack.assets.registry;
    // rust: let frames = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:conduit_effect_block");
            // Level.isWaterAt: the fluid at the position is water.
    // rust: let is_water = |p: [i32; 3]| {
    // rust: facts.get(world.block(p[0], p[1], p[2])).fluid
    // rust: == horizon_client::blocks::Fluid::Water
}
    // rust: let is_frame = |p: [i32; 3]| {
    // rust: registry
    // rust: .state(world.block(p[0], p[1], p[2]))
    // rust: .is_some_and(|s| frames.is_some_and(|f| f.contains(&s.name)))
}
    // rust: conduit.check(pos, time, is_water, is_frame)
}
    // rust: let centre = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: if let Some(check) = check {
    // rust: if let Some(active) = check.toggled {
    // rust: let sound = if active {
    // rust: "minecraft:block.conduit.activate"
    // rust: } else {
    // rust: "minecraft:block.conduit.deactivate"
}
    // rust: self.audio.play(sound, Some(centre), 1.0, 1.0);
}
    // rust: if let Some(frames) = check.frames {
    // rust: self.conduit_apply_effects(pos, frames);
    // rust: self.conduit_attack(&mut conduit, pos, frames >= 42);
}
}
    // rust: let (ambient, short) = conduit.ambient(time, &mut self.world.random);
    // rust: if ambient {
    // rust: self.audio
    // rust: .play("minecraft:block.conduit.ambient", Some(centre), 1.0, 1.0);
}
    // rust: if short {
    // rust: self.audio.play(
    // rust: "minecraft:block.conduit.ambient.short",
    // rust: Some(centre),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: self.be_anims.conduit_servers.insert(pos, conduit);
}
    // `ConduitBlockEntity.applyEffects`: conduit power for every player
    // in water or rain within `frames / 7 * 16` blocks.
conduit_apply_effects :: proc(self: ^Self, pos: [i32; 3], frames: uint) {
}
    // rust: let range = (frames / 7 * 16) as i64;
    // rust: self.for_each_player(|g| {
    // rust: let Some(p) = g.player.as_ref().filter(|p| !p.health.dead_or_dying()) else {
    // rust: return;
}
    // rust: if g.spectator() {
    // rust: return;
}
    // rust: let at = p.position;
    // rust: let in_water = p.fluids.was_touching_water;
    // rust: let top = at.y + f64::from(p.dimensions.height);
            // BlockPos.closerThan: the squared distance under range squared.
    // rust: let d = [at.x, at.y, at.z]
    // rust: .map(|v| v.floor() as i64)
    // rust: .iter()
    // rust: .zip(pos)
    // rust: .map(|(a, b)| (a - i64::from(b)).pow(2))
    // rust: .sum::<i64>();
    // rust: if d >= range * range || !(in_water || g.in_rain(at, top)) {
    // rust: return;
}
    // rust: let power = EffectInstance {
    // rust: ambient: true,
    // rust: ..EffectInstance::new("conduit_power", 260, 0)
}
    // rust: g.potions.effects.add(power);
    // rust: });
}
    // `Entity.isInRain`: rain at the block position or at the top of the box.
    // rust: pub(super) fn in_rain(&mut self, at: Vec3, top: f64) -> bool {
    // rust: let p = BlockPos::new(
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: );
    // rust: let up = BlockPos::new(p.x, top.floor() as i32, p.z);
        // A server's client has no live biome features to ask: it answers from
        // the chunks and the weather it was sent.
    // rust: if self.remote.is_some() {
    // rust: return self.raining_at(p) || self.raining_at(up);
}
    // rust: self.with_level(|b, level, _| b.is_raining_at(level, p) || b.is_raining_at(level, up))
}
    // `ConduitBlockEntity.updateAndAttackTarget`: while the conduit hunts
    // (42 frame blocks) its target stays until it dies or leaves the 8
    // blocks, else a random enemy in water or rain is chosen; the target
    // takes 4 magic damage.
conduit_attack :: proc(self: ^Self, conduit: ^ConduitServer, pos: [i32; 3], hunting: bool) {
}
    // rust: conduit.target = match conduit.target {
    // rust: _ if !hunting => None,
    // rust: None => self.conduit_new_target(pos),
    // rust: Some(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && !m.removed)
    // rust: .filter(|m| {
    // rust: let at = [m.position.x, m.position.y, m.position.z].map(|v| v.floor() as i64);
    // rust: m.alive()
    // rust: && at
    // rust: .iter()
    // rust: .zip(pos)
    // rust: .map(|(a, b)| (a - i64::from(b)).pow(2))
    // rust: .sum::<i64>()
    // rust: < 64
    // rust: })
    // rust: .map(|m| m.id),
}
    // rust: let Some(m) = conduit
    // rust: .target
    // rust: .and_then(|id| self.mobs.iter_mut().find(|m| m.id == id))
    // rust: else {
    // rust: return;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: m.damage(4.0, Damage::of(DamageKind::Magic));
    // rust: self.audio
    // rust: .play("minecraft:block.conduit.attack.target", Some(at), 1.0, 1.0);
}
    // `ConduitBlockEntity.selectNewTarget`: one of the enemies in water or
    // rain whose box meets the conduit's block inflated by 8.
conduit_new_target :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = pos.map(f64::from);
    // rust: let area = Aabb::new(
    // rust: Vec3::new(x - 8.0, y - 8.0, z - 8.0),
    // rust: Vec3::new(x + 9.0, y + 9.0, z + 9.0),
    // rust: );
    // rust: let near: Vec<(u32, bool, Vec3, f64)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.hostile() && !m.removed && m.bounds().intersects(area))
    // rust: .map(|m| {
    // rust: let top = m.position.y + f64::from(m.height());
    // rust: (m.id, m.fluids.in_water, m.position, top)
    // rust: })
    // rust: .collect();
    // rust: let candidates: Vec<u32> = near
    // rust: .into_iter()
    // rust: .filter(|&(_, in_water, at, top)| in_water || self.in_rain(at, top))
    // rust: .map(|(id, ..)| id)
    // rust: .collect();
    // rust: if candidates.is_empty() {
    // rust: return None;
}
    // rust: let pick = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(candidates.len() as i32)
    // rust: .unwrap_or(0);
    // rust: Some(candidates[pick as usize])
}
    // The conduit's `destroyTarget` as the client draws it.
conduit_target :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.be_anims.conduit_servers.get(&pos)?.target?;
    // rust: let m = self.mobs.iter().find(|m| m.id == id && !m.removed)?;
    // rust: Some(ConduitTarget {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: eye_y: m.eye_y(),
    // rust: width: m.width(),
    // rust: height: m.height(),
    // rust: })
}
    // `TheEndGatewayBlockEntity.portalTick` (the server ticker) of the
    // gateways a server keeps a copy of, in block-ticking chunks
    // (`Level.tickBlockEntities`): the cooldown an entry started runs out,
    // and every 2400 ticks `triggerCooldown` sends its block event.
tick_gateway_servers :: proc(self: ^Self) {
}
    // rust: let levels = self.tickets.levels();
    // rust: let mut positions: Vec<[i32; 3]> = self
    // rust: .be_anims
    // rust: .gateway_servers
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|p| levels.block_ticking_at(p[0], p[2]))
    // rust: .collect();
    // rust: positions.sort_unstable();
    // rust: for pos in positions {
    // rust: let triggered = self
    // rust: .be_anims
    // rust: .gateway_servers
    // rust: .get_mut(&pos)
    // rust: .is_some_and(EndGateway::portal_tick);
    // rust: if triggered {
    // rust: self.gateway_cooldown_event(pos);
}
}
}
    // Whether the gateway at `pos` can be entered (`!isCoolingDown`).
    // rust: pub(super) fn gateway_available(&self, pos: [i32; 3]) -> bool {
    // rust: self.be_anims
    // rust: .gateway_servers
    // rust: .get(&pos)
    // rust: .copied()
    // rust: .unwrap_or_else(|| self.gateway_loaded(pos))
    // rust: .teleport_cooldown
    // rust: <= 0
}

    // `EndGatewayBlock.entityInside` on the server: whether the gateway at
    // `pos` let the entity in (`triggerCooldown`, with its block event).
    // rust: pub(super) fn gateway_enter(&mut self, pos: [i32; 3]) -> bool {
    // rust: let initial = self.gateway_loaded(pos);
    // rust: let entered = self
    // rust: .be_anims
    // rust: .gateway_servers
    // rust: .entry(pos)
    // rust: .or_insert(initial)
    // rust: .enter();
    // rust: if entered {
            // `TheEndGatewayBlockEntity.triggerCooldown`: event 1 here, and
            // `Level.blockEvent` so the window's copy starts the beam.
    // rust: self.gateway_cooldown_event(pos);
}
    // rust: entered
}
    // `triggerCooldown`'s block event 1, on this level and for the window
    // (`ClientboundBlockEventPacket` within 64 blocks).
gateway_cooldown_event :: proc(self: ^Self, pos: [i32; 3]) {
}
    // rust: self.block_entity_event(pos, 1, 0);
    // rust: self.lan_block_event(pos, 1, 0);
}
    // The End gateway at `pos` as its chunk was loaded: `Age` from the saved
    // block entity (`getUpdateTag`), or a new gateway.
gateway_loaded :: proc(self: ^Self, pos: [i32; 3]) -> E {
    // Ported from Horizon
    return {}
}
    // rust: let age = self.saved_tag(pos).and_then(|t| number(t.get("Age")));
    // rust: EndGateway {
    // rust: age: age.unwrap_or(0),
    // rust: teleport_cooldown: 0,
}
}
    // The block entity at `pos` Horizon keeps as loaded, if any.
saved_tag :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.world
    // rust: .chunks
    // rust: .get(&(pos[0] >> 4, pos[2] >> 4))
    // rust: .and_then(|c| c.saved.as_deref())
    // rust: .and_then(|saved| {
    // rust: saved.block_entities.iter().find(|t| {
    // rust: [t.get("x"), t.get("y"), t.get("z")]
    // rust: .map(number)
    // rust: .eq(&pos.map(|v| Some(i64::from(v))))
    // rust: })
    // rust: })
}
    // The renderer's view of the block entity at `pos`, with a decorated
    // pot's saved `sherds` (back, left, right, front).
    // rust: pub(super) fn block_anim(&self, pos: [i32; 3], partial: f32) -> BlockAnim {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let sherds = if &*self.res.facts().get(state).name == "minecraft:decorated_pot" {
    // rust: let sherds = self.saved_tag(pos).and_then(|t| t.get("sherds"));
    // rust: ["back", "left", "right", "front"].map(|side| match sherds.and_then(|s| s.get(side)) {
                // An item id, or the item stack the processed templates hold.
    // rust: Some(Tag::String(id)) => Some(id.to_string_lossy()),
    // rust: Some(stack) => {
    // rust: horizon_client::save::item_from_nbt(stack).map(|s| s.item.to_string())
}
    // rust: None => None,
    // rust: })
    // rust: } else {
    // rust: Default::default()
}
    // rust: self.be_anims
    // rust: .block_anim(pos, self.world.game_time, partial, sherds)
}
    // `ChestLidController.getOpenness(partial)` at `pos`.
    // rust: pub(super) fn chest_lid(&self, pos: [i32; 3], partial: f32) -> f32 {
    // rust: self.be_anims.lid(pos, partial)
}
    // `SkullBlockRenderer.getPlayerSkin`: the skin sprite of the profile of
    // the player head at `pos`. The skin download is started here; while it
    // is in flight (or when it cannot be got) the profile's default skin
    // stands in. A head with no profile answers None: `SKIN_BY_TYPE`.
    // rust: pub(super) fn skull_skin_at(&self, pos: [i32; 3]) -> Option<String> {
    // rust: let Some(BlockEntity::Skull(skull)) =
    // rust: self.world.block_entities.get(&(pos[0], pos[1], pos[2]))
    // rust: else {
    // rust: return None;
}
    // rust: let skin = skull.skin.as_ref()?;
        // PlayerSkin.Patch: a `texture` override replaces the profile's skin.
    // rust: if let Some(texture) = &skin.texture
    // rust: && let Some(sprite) =
    // rust: skins::patch_skin(texture, &mut self.skin_downloads.borrow_mut(), |location| {
    // rust: self.gui.atlas.sprites.contains_key(location)
    // rust: })
    // rust: {
    // rust: return Some(sprite);
}
        // The texture a packed or resolved `textures` property fetches: the
        // download of a static profile, or the one the services answer for a
        // `Dynamic` (name- or id-only) profile.
    // rust: let download = skin.download.clone().or_else(|| {
    // rust: let key = skin.dynamic.as_ref()?;
    // rust: let skins::Resolve::Done(Some(profile)) = self.skin_profiles.borrow_mut().state(key)
    // rust: else {
    // rust: return None;
}
    // rust: let (value, signature) = profile.textures()?;
    // rust: let url = skins::unpack(&value, signature, &skins::TEXTURE_URIS).skin?;
    // rust: let location = skins::skin_location(&skins::texture_hash(&url)?);
    // rust: Some((url, location))
    // rust: });
    // rust: if let Some((url, location)) = download {
    // rust: let mut downloads = self.skin_downloads.borrow_mut();
    // rust: if self.gui.atlas.sprites.contains_key(&location) {
    // rust: let _ = downloads.state(skins::Kind::Skin, &url);
    // rust: downloads.drawn(&location);
    // rust: return Some(location);
}
            // Its slot was evicted: offer the image again.
    // rust: if downloads.state(skins::Kind::Skin, &url) == skins::Download::Ready {
    // rust: downloads.again(&location);
}
}
    // rust: Some(skin.fallback.to_owned())
}
}

    // rust: mod tests {
//     use super::*;
//     use std::collections::HashMap;

    // A chest a player opened, then closed without the close path (a death, a
    // teleport, a dropped connection): the tracked count is stale and the
    // five-tick recheck has to correct it, which is what closes the lid and
    // plays the close sound.
a_stale_opener_count_is_recounted_away :: proc() {
}
    // rust: let mut counts = HashMap::new();
    // rust: let chest = (1, 2, 3);
        // Opened: `incrementOpeners` made it one.
    // rust: assert_eq!(recheck_opener_count(&mut counts, &[chest], chest), (0, 1));
    // rust: assert_eq!(counts.get(&chest), Some(&1));
        // Nobody has it open any more.
    // rust: assert_eq!(recheck_opener_count(&mut counts, &[], chest), (1, 0));
    // rust: assert_eq!(counts.get(&chest), None, "the entry goes at zero");
        // The next opener counts from zero, so the lid still opens and the
        // sound still plays.
    // rust: assert_eq!(recheck_opener_count(&mut counts, &[chest], chest), (0, 1));
}

a_recount_that_agrees_leaves_the_count_alone :: proc() {
}
    // rust: let mut counts = HashMap::new();
    // rust: let chest = (1, 2, 3);
    // rust: recheck_opener_count(&mut counts, &[chest], chest);
    // rust: assert_eq!(
    // rust: recheck_opener_count(&mut counts, &[chest], chest),
    // rust: (1, 1),
    // rust: "no change, so no sound and no block event"
    // rust: );
    // rust: assert_eq!(counts.get(&chest), Some(&1));
}

    // A double chest answers for both halves: a player with the left half open
    // is an opener of the right half too.
both_halves_of_a_double_chest_count :: proc() {
}
    // rust: let (left, right) = ((1, 2, 3), (1, 2, 4));
    // rust: let open = [left, right];
    // rust: let mut counts = HashMap::new();
    // rust: assert_eq!(recheck_opener_count(&mut counts, &open, right), (0, 1));
    // rust: assert_eq!(counts.get(&right), Some(&1));
        // Two players on the same half, and someone on another chest.
    // rust: let elsewhere = (9, 9, 9);
    // rust: let open = [left, left, elsewhere];
    // rust: assert_eq!(recheck_opener_count(&mut counts, &open, left), (0, 2));
    // rust: assert_eq!(counts.get(&left), Some(&2));
    // rust: assert_eq!(recheck_opener_count(&mut counts, &open, elsewhere), (0, 1));
    // rust: assert_eq!(openers_at(&open, elsewhere), 1);
    // rust: assert_eq!(openers_at(&open, (0, 0, 0)), 0);
}
}

    // rust: mod bell_ownership_tests {
//     use horizon_client::block_entity_anim::{Bell, BlockEntityAnims};

server_bells_survive_visibility_changes_but_remote_bells_do_not :: proc() {
}
    // rust: let pos = [8, 200, 8];
    // rust: let mut anims = BlockEntityAnims::default();
    // rust: let mut bell = Bell::default();
    // rust: bell.trigger_event(1, 2, 100, || vec![7]);
    // rust: anims.bells.insert(pos, bell);
    // rust: anims.pots.insert(pos, Default::default());
    // rust: anims.retain_present_preserving_bells(&[]);
    // rust: assert_eq!(anims.bells[&pos].nearby.as_deref(), Some([7].as_slice()));
    // rust: assert!(anims.bells[&pos].shaking);
    // rust: assert!(anims.pots.is_empty());
    // rust: anims.retain_present(&[]);
    // rust: assert!(anims.bells.is_empty());
}
}
