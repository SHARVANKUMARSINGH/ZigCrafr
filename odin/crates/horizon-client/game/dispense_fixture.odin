//! Transpiled from Horizon Rust crate
package horizon_client_dispense_fixture

import "core:fmt"
import "core:mem"
import "core:math"

// The Rust side of tools/test_dispenser_parity.py: with
// `HORIZON_DISPENSE_FIXTURE=CASES,OUTPUT` the game loads its resources, runs
// every case (a dispenser or dropper with items, blocks and target entities
// around it) through `dispense_from` on a fresh headless world and prints what
// changed in the format of `VanillaDispenserOracle`.
// use super::{
    // rust: Game,
    // rust: dispenser::{Slot, mob_set_slot, mob_slot_item},
}
// use horizon_client::{
    // rust: Result,
    // rust: chunk::Chunk,
    // rust: command::args::GameMode,
    // rust: containers::BlockEntity,
    // rust: gamerules::Value as RuleValue,
    // rust: item_data::{canon_stack, parse_stack},
    // rust: items::ItemStack,
    // rust: mobs::{
    // rust: Mob, Species,
    // rust: spawner::{SpawnDataExt, SpawnerExt},
    // rust: },
    // rust: motion::PlayerMotion,
    // rust: projectiles::ProjectileKind,
    // rust: world::World,
}
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::{level::Ticks, registry::BlockStateId};
// use serde_json::Value;
// use std::{cell::RefCell, collections::HashMap, fmt::Write as _, io::Write as _, sync::Arc};
// use winit::keyboard::KeyCode;

    // rust: thread_local! {
    // Level and game events recorded while a fixture case runs.
LOG :: const { RefCell::new(None) }
}

// Record a line if a fixture case is running.
    // rust: pub(super) fn record(line: impl FnOnce() -> String) {
    // rust: LOG.with(|log| {
    // rust: if let Some(lines) = log.borrow_mut().as_mut() {
    // rust: lines.push(line());
}
    // rust: });
}
// Start recording level and game event lines (another fixture's case).
    // rust: pub(super) fn start_recording() {
    // rust: LOG.with(|log| *log.borrow_mut() = Some(Vec::new()));
}
// The lines recorded since `start_recording`; recording stops.
    // rust: pub(super) fn stop_recording() -> Vec<String> {
    // rust: LOG.with(|log| log.borrow_mut().take()).unwrap_or_default()
}
// `Level.levelEvent` lines for the level events the behaviour library reported.
    // rust: pub(super) fn record_events(events: &[horizon_world::level::LevelEvent]) {
    // rust: for event in events {
    // rust: if let horizon_world::level::LevelEvent::LevelEvent { id, pos, data } = event {
    // rust: record(|| format!("L {id} {},{},{} {data}", pos.x, pos.y, pos.z));
}
}
}

// The `S` line for a level event whose sound `LevelEventHandler` plays on the
// client (`playLocalSound`), so Horizon plays it unshared and never captures
// it: the lava fizz (1501, #7652) and `ComposterBlock.handleFill` (1500,
// `data > 0` = success, #9069).
event_sound :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = line.strip_prefix("L ")?.split(' ');
    // rust: let (id, pos, data) = (parts.next()?, parts.next()?, parts.next()?);
    // rust: let sound = match id {
    // rust: "1501" => "minecraft:block.lava.extinguish",
    // rust: "1500" if data.parse::<i32>().ok()? > 0 => "minecraft:block.composter.fill_success",
    // rust: "1500" => "minecraft:block.composter.fill",
    // rust: _ => return None,
}
    // rust: Some(format!("S {pos} {sound}"))
}

// Java's `String.format("%.6f")`: the exact value rounded half up (away
// from zero) where Rust rounds a tie to even.
num :: proc(v: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let exact = format!("{:.40}", v.abs());
    // rust: let tie = exact
    // rust: .split_once('.')
    // rust: .is_some_and(|(_, f)| f[6..].starts_with('5') && f[7..].bytes().all(|b| b == b'0'));
    // rust: if tie {
    // rust: format!("{:.6}", v + 0.5e-6_f64.copysign(v))
    // rust: } else {
    // rust: format!("{v:.6}")
}
}
floor_pos :: proc(p: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{},{},{}",
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32
    // rust: )
}

// The targets a case put in front of the dispenser.
Target :: enum {
    Mob(u32),
    Stand(u32),
}

    // rust: impl Game<'_> {
    // Run every case of `spec` ("CASES,OUTPUT") and write the results.
    // rust: pub(super) fn dispense_fixture(&mut self, spec: &str) -> Result<()> {
    // rust: assert!(
    // rust: !self.options.execution_role.is_client(),
    // rust: "fixture requires a server Game"
    // rust: );
    // rust: let (input, output) = spec
    // rust: .split_once(',')
    // rust: .ok_or("HORIZON_DISPENSE_FIXTURE=CASES,OUTPUT")?;
        // Saplings and feature placers grow from the live feature registry.
    // rust: self.install_live_features();
    // rust: let text = std::fs::read_to_string(input)?;
    // rust: let mut out = std::io::BufWriter::new(std::fs::File::create(output)?);
    // rust: for (index, line) in text.lines().enumerate() {
    // rust: let case: Value = serde_json::from_str(line)?;
    // rust: writeln!(out, "case {index}")?;
    // rust: match self.dispense_case(&case) {
    // rust: Ok(lines) => {
    // rust: for l in lines {
    // rust: writeln!(out, "{l}")?;
}
}
    // rust: Err(e) => writeln!(out, "failed {e}")?,
}
}
    // rust: LOG.with(|log| *log.borrow_mut() = None);
    // rust: Ok(())
}

fixture_reset :: proc(self: ^Self, seed: i64) {
}
    // rust: self.world = World::new(self.res.facts().air, seed);
        // The oracle level is plains everywhere (bone meal's flowers, freezing).
    // rust: let plains = u32::from(world_biomes!(self).id("minecraft:plains"));
    // rust: for cx in -2..=2 {
    // rust: for cz in -2..=2 {
    // rust: let mut chunk = Chunk::empty(cx, cz);
    // rust: for section in &mut chunk.sections {
    // rust: Arc::make_mut(section).biomes = horizon_core::paletted::PalettedContainer::new(
    // rust: horizon_client::chunk::BIOME_STRATEGY,
    // rust: plains,
    // rust: );
}
    // rust: self.world.chunks.insert((cx, cz), Arc::new(chunk));
}
}
    // rust: self.block_ticks = Ticks::new(0);
    // rust: self.tick_chunks.clear();
    // rust: self.sync_tick_chunks();
    // rust: self.mobs.clear();
    // rust: self.dragon = None;
    // rust: self.dropped.clear();
    // rust: self.creatures.projectiles.clear();
    // rust: self.tnts.clear();
    // rust: self.boats.clear();
    // rust: self.carts.clear();
    // rust: self.armor_stands.clear();
    // rust: self.crystals.clear();
    // rust: self.paintings.clear();
    // rust: self.item_frames.clear();
    // rust: self.rockets.clear();
    // rust: self.potions.clear_thrown();
    // rust: self.level_events.clear();
    // rust: self.orbs.clear();
    // rust: self.falling.clear();
        // Hopper cooldowns of an earlier case.
    // rust: self.hoppers.clear();
    // rust: self.ui.rules = Default::default();
    // rust: self.dim = super::Dim::Overworld;
    // rust: self.respawn_config = None;
        // The oracle level plays on normal difficulty.
    // rust: self.ui.difficulty = 2;
        // The oracle level has world seed 0 and fresh random sequences.
    // rust: self.level.seed = 0;
    // rust: self.rand_sequences = Default::default();
}

dispense_case :: proc(self: ^Self, case: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let seed = case["seed"].as_i64().unwrap_or(0);
    // rust: self.fixture_reset(seed);
        // The oracle level answers one sky and one block light everywhere.
    // rust: let light = case["light"].as_array();
    // rust: let level = |i: usize, default: i64| {
    // rust: light
    // rust: .and_then(|l| l.get(i))
    // rust: .and_then(Value::as_i64)
    // rust: .unwrap_or(default) as u8
}
    // rust: let packed = (level(0, 15) << 4) | level(1, 0);
    // rust: for chunk in self.world.chunks.values_mut() {
    // rust: for section in &mut Arc::make_mut(chunk).sections {
    // rust: Arc::make_mut(section).light = horizon_client::chunk::Light::Uniform(packed);
}
}
    // rust: self.world.game_time = case["time"].as_i64().unwrap_or(0);
    // rust: match case["dim"].as_str() {
    // rust: Some("nether") => self.dim = super::Dim::Nether,
    // rust: Some("end") => self.dim = super::Dim::End,
    // rust: _ => {}
}
        // The level's build range follows its dimension, as `enter_dimension` sets it.
    // rust: self.world.shape = self.dim.shape();
        // The oracle level's clock stands at day time 6000.
    // rust: self.world.day_time = 6000;
    // rust: if let Some(rules) = case["rules"].as_object() {
    // rust: for (name, value) in rules {
    // rust: if let Some(b) = value.as_bool() {
    // rust: self.ui.rules.set(name, RuleValue::Bool(b));
}
}
}
    // rust: let mut before: HashMap<(i32, i32, i32), u32> = HashMap::new();
    // rust: for cell in case["cells"].as_array().into_iter().flatten() {
    // rust: let p = (
    // rust: cell[0].as_i64().unwrap_or(0) as i32,
    // rust: cell[1].as_i64().unwrap_or(0) as i32,
    // rust: cell[2].as_i64().unwrap_or(0) as i32,
    // rust: );
    // rust: let state = BlockStateId(cell[3].as_u64().unwrap_or(0) as u32);
    // rust: self.world.set(p.0, p.1, p.2, state)?;
    // rust: before.insert(p, state.0);
    // rust: if let Some(entity) = BlockEntity::for_block(&self.res.facts().get(state).name) {
    // rust: self.world.block_entities.insert(p, entity);
}
}
    // rust: for item in case["items"].as_array().into_iter().flatten() {
    // rust: let p = (
    // rust: item[0].as_i64().unwrap_or(0) as i32,
    // rust: item[1].as_i64().unwrap_or(0) as i32,
    // rust: item[2].as_i64().unwrap_or(0) as i32,
    // rust: );
    // rust: let slot = item[3].as_u64().unwrap_or(0) as usize;
    // rust: let stack = parse_stack(item[4].as_str().unwrap_or("-"))?;
    // rust: self.fixture_fill(p, slot, stack);
}
        // CrafterBlock.newBlockEntity copies the state's triggered flag;
        // CrafterBlockEntity.setSlotState disables only empty slots.
    // rust: let crafter_positions: Vec<(i32, i32, i32)> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter(|(_, e)| matches!(e, BlockEntity::Crafter(_)))
    // rust: .map(|(p, _)| *p)
    // rust: .collect();
    // rust: for p in crafter_positions {
    // rust: let state = self.world.block(p.0, p.1, p.2);
    // rust: let triggered = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("triggered"))
    // rust: .is_some_and(|v| v == "true");
    // rust: if let Some(BlockEntity::Crafter(c)) = self.world.block_entities.get_mut(&p) {
    // rust: c.triggered = triggered;
    // rust: c.state_triggered = Some(triggered);
}
}
    // rust: for d in case["disabled"].as_array().into_iter().flatten() {
    // rust: let p = (
    // rust: d[0].as_i64().unwrap_or(0) as i32,
    // rust: d[1].as_i64().unwrap_or(0) as i32,
    // rust: d[2].as_i64().unwrap_or(0) as i32,
    // rust: );
    // rust: if let Some(BlockEntity::Crafter(c)) = self.world.block_entities.get_mut(&p) {
    // rust: c.set_slot_state(d[3].as_u64().unwrap_or(0) as usize, false);
}
}
    // rust: let mut targets = Vec::new();
    // rust: for e in case["entities"].as_array().into_iter().flatten() {
    // rust: targets.push(self.fixture_target(e)?);
}
        // Leashable.setLeashedTo: a lead from a target to an earlier one.
    // rust: for (e, t) in case["entities"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .zip(&targets)
    // rust: {
    // rust: let (Some(holder), Target::Mob(id)) = (e["leash"].as_u64(), t) else {
    // rust: continue;
}
    // rust: let holder = match targets.get(holder as usize) {
    // rust: Some(Target::Mob(h)) => horizon_client::mobs::leash::Holder::Mob(*h),
    // rust: _ => continue,
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == *id) {
    // rust: m.extra.leash = Some(holder);
}
}
        // Creating the targets must not move the stream the dispenser draws from.
    // rust: self.world.random = LegacyRandom::new(seed);
    // rust: self.world.block_log = Some(Vec::new());
    // rust: self.audio.capture = Some(Vec::new());
    // rust: LOG.with(|log| *log.borrow_mut() = Some(Vec::new()));
    // rust: let old_mobs: Vec<u32> = self.mobs.iter().map(|m| m.id).collect();
    // rust: let old_stands: Vec<u32> = self.armor_stands.iter().map(|s| s.id).collect();

    // rust: let pos = &case["pos"];
    // rust: let origin = BlockPos::new(
    // rust: pos[0].as_i64().unwrap_or(0) as i32,
    // rust: pos[1].as_i64().unwrap_or(0) as i32,
    // rust: pos[2].as_i64().unwrap_or(0) as i32,
    // rust: );
    // rust: let state = self.world.block(origin.x, origin.y, origin.z);
    // rust: let mut used = Vec::new();
    // rust: if let Some(op) = case.get("remove") {
    // rust: used = self.fixture_remove(origin, op)?;
    // rust: } else if let Some(op) = case.get("use") {
    // rust: used = self.fixture_use(origin, op)?;
    // rust: } else if let Some(op) = case.get("use_item") {
    // rust: used = self.fixture_use_item(origin, op)?;
    // rust: } else if let Some(op) = case.get("respawn_at") {
            // ServerPlayer.findRespawnAndUseSpawnBlock for a respawn point at the origin.
    // rust: let config = super::respawn_anchor::RespawnConfig::wrapped(
    // rust: self.dim,
    // rust: [origin.x, origin.y, origin.z],
    // rust: op["yaw"].as_f64().map_or(0.0, |v| v as f32),
    // rust: op["forced"].as_bool().unwrap_or(false),
    // rust: );
    // rust: let found =
    // rust: self.find_respawn_and_use(config, op["consume"].as_bool().unwrap_or(true))?;
    // rust: used.push(match found {
    // rust: Some((p, yaw)) => format!(
    // rust: "respawn {} {} {} {}",
    // rust: num(p.x),
    // rust: num(p.y),
    // rust: num(p.z),
    // rust: yaw.to_bits() as i32
    // rust: ),
    // rust: None => "respawn none".to_owned(),
    // rust: });
    // rust: } else if let Some(op) = case.get("wake") {
    // rust: used.push(self.fixture_wake(origin, op)?);
    // rust: } else if let Some(op) = case.get("attack") {
    // rust: used = self.fixture_attack(op, &targets)?;
    // rust: } else if case.get("hopper").is_some() {
            // HopperBlockEntity.pushItemsTick, once.
    // rust: self.hopper_try_move_items((origin.x, origin.y, origin.z));
    // rust: self.process_level_events()?;
    // rust: } else {
    // rust: self.dispense_from(origin, state)?;
            // CrafterBlockEntity.serverTick, the crafting animation running down.
    // rust: let mut crafters: Vec<(i32, i32, i32)> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter(|(_, e)| matches!(e, BlockEntity::Crafter(_)))
    // rust: .map(|(p, _)| *p)
    // rust: .collect();
    // rust: crafters.sort_unstable();
    // rust: for _ in 0..case["ticks"].as_u64().unwrap_or(0) {
    // rust: for &p in &crafters {
    // rust: self.tick_crafter(p);
}
}
}

    // rust: let mut out = Vec::new();
    // rust: let mut changed: Vec<(i32, i32, i32)> = self.world.block_log.take().unwrap_or_default();
    // rust: changed.sort_unstable();
    // rust: changed.dedup();
    // rust: for p in changed {
    // rust: let now = self.world.block(p.0, p.1, p.2).0;
    // rust: if before.get(&p).copied().unwrap_or(self.res.facts().air.0) != now {
    // rust: out.push(format!("set {},{},{} {now}", p.0, p.1, p.2));
}
}
    // rust: let mut containers: Vec<_> = self.world.block_entities.keys().copied().collect();
    // rust: containers.sort_unstable();
    // rust: for p in containers {
    // rust: let entity = &self.world.block_entities[&p];
    // rust: let single = match entity {
    // rust: BlockEntity::Jukebox(j) => &j.items,
    // rust: _ => entity.slots(),
}
    // rust: for (i, slot) in single.iter().enumerate() {
    // rust: if let Some(stack) = slot {
    // rust: out.push(format!(
    // rust: "inv {},{},{} {i} {}",
    // rust: p.0,
    // rust: p.1,
    // rust: p.2,
    // rust: canon_stack(Some(stack))
    // rust: ));
}
}
}
    // rust: let mut crafters: Vec<_> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter_map(|(p, e)| match e {
    // rust: BlockEntity::Crafter(c) => Some((*p, c)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: crafters.sort_unstable_by_key(|c| c.0);
    // rust: for (p, c) in crafters {
    // rust: let disabled: Vec<String> = (0..9)
    // rust: .filter(|&i| c.disabled[i])
    // rust: .map(|i| i.to_string())
    // rust: .collect();
    // rust: out.push(format!(
    // rust: "crafter {},{},{} ticks={} triggered={} signal={} disabled={}",
    // rust: p.0,
    // rust: p.1,
    // rust: p.2,
    // rust: c.crafting_ticks,
    // rust: c.triggered,
    // rust: c.redstone_signal(),
    // rust: disabled.join(",")
    // rust: ));
}
        // A spawner's next spawn data (its id and number of keys), potentials and delay.
    // rust: let mut spawners: Vec<_> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter_map(|(p, e)| match e {
    // rust: BlockEntity::Spawner(s) => Some((*p, s)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: spawners.sort_unstable_by_key(|s| s.0);
    // rust: for (p, s) in spawners {
    // rust: let next = s.next_data().map_or("-".to_owned(), |d| {
    // rust: format!(
    // rust: "{}/{}",
    // rust: d.id().unwrap_or_else(|| "?".into()),
    // rust: d.entity.len()
    // rust: )
    // rust: });
    // rust: out.push(format!(
    // rust: "spawner {},{},{} next={next} potentials={} delay={}",
    // rust: p.0,
    // rust: p.1,
    // rust: p.2,
    // rust: s.potentials.len(),
    // rust: s.spawn_delay as i16
    // rust: ));
}
    // rust: self.fixture_entities(&old_mobs, &old_stands, &mut out);
    // rust: for (i, t) in targets.iter().enumerate() {
    // rust: out.push(self.fixture_describe(i, t));
}
    // rust: let log = LOG.with(|log| log.borrow_mut().take()).unwrap_or_default();
    // rust: let event_sounds: Vec<String> = log.iter().filter_map(|l| event_sound(l)).collect();
    // rust: out.extend(log);
    // rust: out.extend(event_sounds);
    // rust: for sound in self.audio.capture.take().unwrap_or_default() {
    // rust: out.push(format!("S {} {}", floor_pos(sound.position), sound.event));
}
    // rust: out.extend(used);
    // rust: out.push(format!("rng {}", self.world.random.next_long()));
    // rust: Ok(out)
}

    // A player holding the case's item right-clicks the block at `pos`
    // (`use_item_as_player`'s block steps): the statistics, the result
    // and the held stack, as `VanillaDispenserOracle.use` prints them.
fixture_use :: proc(self: ^Self, pos: BlockPos, op: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let stack = parse_stack(op["item"].as_str().unwrap_or("-"))?;
    // rust: self.creative = op["creative"].as_bool().unwrap_or(false);
    // rust: self.inventory[self.selected] = stack.clone();
    // rust: let used_before = stack
    // rust: .as_ref()
    // rust: .map_or(0, |s| self.stats.get("used", &s.item));
    // rust: let at = [pos.x, pos.y, pos.z];
    // rust: let mut consumed = self.use_composter(at, stack.as_ref());
    // rust: if !consumed {
    // rust: let player = horizon_world::level::PlayerContext {
    // rust: yaw: 0.0,
    // rust: pitch: 90.0,
    // rust: may_build: true,
    // rust: can_eat: self.creative,
    // rust: game_master: false,
}
    // rust: let hit = horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 1.0,
    // rust: f64::from(pos.z) + 0.5,
    // rust: );
    // rust: let result = self.with_level(|b, level, ticks| {
    // rust: b.use_without_item(
    // rust: level,
    // rust: ticks,
    // rust: pos,
    // rust: horizon_core::geometry::Direction::Up,
    // rust: hit,
    // rust: player,
    // rust: )
    // rust: });
    // rust: consumed = result.consumes_action();
}
    // rust: self.process_level_events()?;
    // rust: let mut out = Vec::new();
    // rust: if let Some(s) = &stack {
    // rust: let used = self.stats.get("used", &s.item) - used_before;
    // rust: if used != 0 {
    // rust: out.push(format!("stat {} minecraft:used {used}", s.item));
}
}
    // rust: out.push(format!(
    // rust: "use {} held {}",
    // rust: if consumed { "consumed" } else { "pass" },
    // rust: canon_stack(self.inventory[self.selected].as_ref())
    // rust: ));
    // rust: Ok(out)
}

    // A player three blocks south of `pos`, turned to the case's `yaw`,
    // right-clicks its top face (or the case's `face`) holding
    // the case's item (`use_item_as_player` on that hit): the statistics,
    // the held stack and the item it started using, as
    // `VanillaDispenserOracle.useItem` prints them.
fixture_use_item :: proc(self: ^Self, pos: BlockPos, op: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let stack = parse_stack(op["item"].as_str().unwrap_or("-"))?;
    // rust: self.mode = if op["creative"].as_bool().unwrap_or(false) {
    // rust: GameMode::Creative
    // rust: } else {
    // rust: GameMode::Survival
}
    // rust: self.creative = self.mode == GameMode::Creative;
    // rust: let distance = op["distance"].as_f64().unwrap_or(3.0);
    // rust: let mut player = PlayerMotion::new(
    // rust: self.motion,
    // rust: horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 1.0,
    // rust: f64::from(pos.z) + 0.5 + distance,
    // rust: ),
    // rust: )?;
    // rust: if let Some(r) = op["respawn"].as_array() {
    // rust: let p = |i: usize| r.get(i).and_then(Value::as_i64).unwrap_or(0) as i32;
    // rust: self.respawn_config = Some(super::respawn_anchor::RespawnConfig {
    // rust: dim: self.dim,
    // rust: pos: [p(0), p(1), p(2)],
    // rust: yaw: 0.0,
    // rust: forced: false,
    // rust: });
}
    // rust: player.health.food.food = op["food"].as_i64().unwrap_or(20) as i32;
    // rust: self.player = Some(player);
    // rust: self.yaw = op["yaw"].as_f64().unwrap_or(0.0) as f32;
    // rust: self.pitch = 90.0;
    // rust: self.keys.clear();
    // rust: if op["sneaking"].as_bool().unwrap_or(false) {
    // rust: self.keys.insert(KeyCode::ShiftLeft);
}
    // rust: self.using = None;
        // The oracle's player wears nothing: no armor left on from an earlier case.
    // rust: self.armor = Default::default();
    // rust: self.inventory[self.selected] = stack.clone();
    // rust: self.offhand = parse_stack(op["offhand"].as_str().unwrap_or("-"))?;
        // The used statistic of each item held, once.
    // rust: let mut items: Vec<_> = [stack.as_ref(), self.offhand.as_ref()]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|s| s.item.clone())
    // rust: .collect();
    // rust: items.dedup();
    // rust: let used_before: Vec<_> = items.iter().map(|i| self.stats.get("used", i)).collect();
        // The top face, or the case's `face`, clicked at its centre.
    // rust: let face = match op["face"].as_str() {
    // rust: Some("down") => [0, -1, 0],
    // rust: Some("north") => [0, 0, -1],
    // rust: Some("south") => [0, 0, 1],
    // rust: Some("west") => [-1, 0, 0],
    // rust: Some("east") => [1, 0, 0],
    // rust: _ => [0, 1, 0],
}
    // rust: let centre = |c: i32, f: i32| f64::from(c) + 0.5 + f64::from(f) * 0.5;
    // rust: self.forced_hit = Some(super::Hit {
    // rust: pos: [pos.x, pos.y, pos.z],
    // rust: face,
    // rust: point: [
    // rust: centre(pos.x, face[0]),
    // rust: centre(pos.y, face[1]),
    // rust: centre(pos.z, face[2]),
    // rust: ],
    // rust: });
    // rust: self.chat_capture = Some(Vec::new());
    // rust: let used = self.use_item_as_player();
    // rust: self.forced_hit = None;
    // rust: let messages = self.chat_capture.take().unwrap_or_default();
    // rust: used?;
    // rust: self.process_level_events()?;
    // rust: let mut out = Vec::new();
    // rust: for m in messages {
    // rust: let key = m.component()["translate"]
    // rust: .as_str()
    // rust: .map_or_else(|| m.plain(), str::to_owned);
            // The oracle player's advancements are not tracked.
    // rust: if !key.starts_with("chat.type.advancement") {
    // rust: out.push(format!("msg {key}"));
}
}
    // rust: for (item, before) in items.iter().zip(used_before) {
    // rust: let used = self.stats.get("used", item) - before;
    // rust: if used != 0 {
    // rust: out.push(format!("stat {item} minecraft:used {used}"));
}
}
    // rust: let using = self
    // rust: .using
    // rust: .and_then(|(slot, _)| self.stack_in(slot))
    // rust: .map_or("-".to_owned(), |s| s.item.to_string());
    // rust: out.push(format!(
    // rust: "held {} offhand {} using {using}",
    // rust: canon_stack(self.inventory[self.selected].as_ref()),
    // rust: canon_stack(self.offhand.as_ref())
    // rust: ));
    // rust: out.push(match self.respawn_config {
    // rust: Some(c) => format!(
    // rust: "respawn {} {},{},{}",
    // rust: c.dim.id(),
    // rust: c.pos[0],
    // rust: c.pos[1],
    // rust: c.pos[2]
    // rust: ),
    // rust: None => "respawn -".to_owned(),
    // rust: });
    // rust: self.player = None;
    // rust: self.using = None;
    // rust: self.offhand = None;
    // rust: Ok(out)
}

    // The player's hit on the first target with the case's item, from the
    // attack strength's scaled `base` damage on: the item's damage bonus and
    // source, the hurt with the weapon's armor effects, then `weapon_hit`
    // (the mace's smash, post-attack enchantments, the wear), as
    // `VanillaDispenserOracle.attack` prints them.
fixture_attack :: proc(self: ^Self, op: ^Value, targets: ^[Target]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let stack = parse_stack(op["item"].as_str().unwrap_or("-"))?;
    // rust: self.mode = if op["creative"].as_bool().unwrap_or(false) {
    // rust: GameMode::Creative
    // rust: } else {
    // rust: GameMode::Survival
}
    // rust: self.creative = self.mode == GameMode::Creative;
    // rust: let v3 = |v: &Value| {
    // rust: horizon_core::geometry::Vec3::new(
    // rust: v[0].as_f64().unwrap_or(0.0),
    // rust: v[1].as_f64().unwrap_or(0.0),
    // rust: v[2].as_f64().unwrap_or(0.0),
    // rust: )
}
    // rust: let mut player = PlayerMotion::new(self.motion, v3(&op["player"]))?;
    // rust: player.velocity = v3(&op["motion"]);
    // rust: player.fall_distance = op["fall"].as_f64().unwrap_or(0.0);
    // rust: player.fall_flying = op["fall_flying"].as_bool().unwrap_or(false);
    // rust: player.flying = op["flying"].as_bool().unwrap_or(false);
    // rust: player.may_fly = self.creative;
    // rust: if !op["impact"].is_null() {
    // rust: player.impulse.impact_position = Some(v3(&op["impact"]));
}
    // rust: let feet = [player.position.x, player.position.y, player.position.z];
    // rust: self.player = Some(player);
    // rust: self.inventory[self.selected] = stack.clone();
    // rust: let used_before = stack
    // rust: .as_ref()
    // rust: .map_or(0, |s| self.stats.get("used", &s.item));
    // rust: let base = op["base"].as_f64().unwrap_or(0.0) as f32;
    // rust: let source = self.attack_source(feet);
    // rust: let (bonus, hurt) = match targets.first() {
    // rust: Some(&Target::Mob(id)) => {
    // rust: let index = self
    // rust: .mobs
    // rust: .iter()
    // rust: .position(|m| m.id == id)
    // rust: .ok_or("the target is gone")?;
    // rust: let kind = self.mobs[index].kind.id.clone();
    // rust: let bonus = self.smash_damage_bonus(&kind);
    // rust: let hurt = self.hurt_by_player(index, base + bonus, source);
                // The hurt sound the mob raised, where it stands.
    // rust: for event in std::mem::take(&mut self.mobs[index].outbox) {
    // rust: if let horizon_client::mobs::MobEvent::Sound(s, at, volume, pitch) = event {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{s}"), Some(at), volume, pitch);
}
}
    // rust: if hurt {
    // rust: self.weapon_hit(index);
}
    // rust: (bonus, hurt)
}
    // rust: Some(&Target::Stand(id)) => {
    // rust: let index = self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .position(|s| s.id == id)
    // rust: .ok_or("the target is gone")?;
    // rust: let bonus = self.smash_damage_bonus("minecraft:armor_stand");
    // rust: (bonus, self.hit_armor_stand(index, |_, _, _| {}))
}
    // rust: None => return Err("an attack case has a target".into()),
}
    // rust: self.process_level_events()?;
    // rust: let mut out = Vec::new();
    // rust: if let Some(s) = &stack {
    // rust: let used = self.stats.get("used", &s.item) - used_before;
    // rust: if used != 0 {
    // rust: out.push(format!("stat {} minecraft:used {used}", s.item));
}
}
    // rust: let source = match source.kind {
    // rust: horizon_client::mobs::DamageKind::MaceSmash => "minecraft:mace_smash",
    // rust: horizon_client::mobs::DamageKind::Spear => "minecraft:spear",
    // rust: _ => "minecraft:player_attack",
}
    // rust: out.push(format!(
    // rust: "attack bonus={} source={source} hurt={hurt}",
    // rust: num(f64::from(bonus))
    // rust: ));
    // rust: for (i, t) in targets.iter().enumerate() {
    // rust: let (health, v) = match *t {
    // rust: Target::Mob(id) => match self.mobs.iter().find(|m| m.id == id) {
    // rust: Some(m) => (num(f64::from(m.health)), m.velocity),
    // rust: None => continue,
    // rust: },
    // rust: Target::Stand(id) => match self.armor_stands.iter().find(|s| s.id == id) {
    // rust: Some(s) => ("-".to_owned(), s.velocity),
    // rust: None => {
    // rust: out.push(format!("V {i} gone"));
    // rust: continue;
}
    // rust: },
}
    // rust: out.push(format!(
    // rust: "V {i} {health} {} {} {}",
    // rust: num(v.x),
    // rust: num(v.y),
    // rust: num(v.z)
    // rust: ));
}
    // rust: if let Some(p) = self.player.take() {
    // rust: let impact = p.impulse.impact_position.map_or("-".to_owned(), |i| {
    // rust: format!("{},{},{}", num(i.x), num(i.y), num(i.z))
    // rust: });
    // rust: out.push(format!(
    // rust: "P {} {} {} fall={} impact={impact} grace={} extra={}",
    // rust: num(p.velocity.x),
    // rust: num(p.velocity.y),
    // rust: num(p.velocity.z),
    // rust: num(p.fall_distance),
    // rust: p.impulse.reset_grace_time,
    // rust: p.spawn_extra_particles_on_fall
    // rust: ));
}
    // rust: out.push(format!(
    // rust: "held {}",
    // rust: canon_stack(self.inventory[self.selected].as_ref())
    // rust: ));
    // rust: Ok(out)
}

    // A stack in a block entity's slot: a container's, a jukebox's record, a
    // lectern's book, or the items of a block entity Horizon keeps as saved.
fixture_fill :: proc(self: ^Self, p: (i32) {
}
    // rust: let jukebox =
    // rust: &*self.res.facts().get(self.world.block(p.0, p.1, p.2)).name == "minecraft:jukebox";
    // rust: match self.world.block_entities.get_mut(&p) {
    // rust: Some(BlockEntity::Jukebox(j)) => j.items[0] = stack,
    // rust: Some(BlockEntity::Lectern(l)) => l.book = stack,
    // rust: Some(BlockEntity::Campfire(c)) => {
    // rust: if let Some(cell) = c.items.get_mut(slot) {
    // rust: *cell = stack;
}
}
    // rust: Some(e) => {
    // rust: if let Some(cell) = e.slots_mut().get_mut(slot) {
    // rust: *cell = stack;
}
}
    // rust: None if jukebox => {
                // JukeboxBlockEntity holding its record (setSongItemWithoutPlaying).
    // rust: self.world.block_entities.insert(
    // rust: p,
    // rust: BlockEntity::Jukebox(horizon_client::containers::Jukebox {
    // rust: items: [stack],
    // rust: ticks: 0,
    // rust: playing: false,
    // rust: }),
    // rust: );
}
    // rust: None => self.fixture_fill_saved(p, slot, stack),
}
}
    // The saved block entity of a campfire, decorated pot, chiseled
    // bookshelf or shelf, as a loaded world keeps it.
fixture_fill_saved :: proc(self: ^Self, p: (i32) {
}
//         use horizon_world::nbt::Tag;
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(p.0, p.1, p.2))
    // rust: .name
    // rust: .clone();
    // rust: let id = match name.strip_prefix("minecraft:").unwrap_or(&name) {
    // rust: "campfire" | "soul_campfire" => "minecraft:campfire",
    // rust: "decorated_pot" => "minecraft:decorated_pot",
    // rust: "chiseled_bookshelf" => "minecraft:chiseled_bookshelf",
    // rust: n if n.ends_with("_shelf") => "minecraft:shelf",
    // rust: _ => return,
}
    // rust: let Some(chunk) = self.world.chunks.get_mut(&(p.0 >> 4, p.2 >> 4)) else {
    // rust: return;
}
    // rust: let chunk = Arc::make_mut(chunk);
    // rust: let saved = Arc::make_mut(chunk.saved.get_or_insert_with(Default::default));
    // rust: let at = |t: &Tag| {
    // rust: t.get("x") == Some(&Tag::Int(p.0))
    // rust: && t.get("y") == Some(&Tag::Int(p.1))
    // rust: && t.get("z") == Some(&Tag::Int(p.2))
}
    // rust: let index = match saved.block_entities.iter().position(at) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: saved.block_entities.push(Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("x", Tag::Int(p.0)),
    // rust: ("y", Tag::Int(p.1)),
    // rust: ("z", Tag::Int(p.2)),
    // rust: ]));
    // rust: saved.block_entities.len() - 1
}
}
    // rust: let Tag::Compound(map) = &mut saved.block_entities[index] else {
    // rust: return;
}
    // rust: let Some(stack) = stack else { return };
    // rust: if id == "minecraft:decorated_pot" {
    // rust: map.insert("item".into(), horizon_client::save::item_to_nbt(&stack));
    // rust: return;
}
    // rust: let mut item = horizon_client::save::item_to_nbt(&stack);
    // rust: if let Tag::Compound(c) = &mut item {
    // rust: c.insert("Slot".into(), Tag::Byte(slot as i8));
}
    // rust: match map
    // rust: .entry("Items".into())
    // rust: .or_insert_with(|| Tag::List(Vec::new()))
    // rust: {
    // rust: Tag::List(list) => list.push(item),
    // rust: other => *other = Tag::List(vec![item]),
}
}
    // `Level.setBlock`, `destroyBlock` or `removeBlock` on the case's block, or
    // a player mining it (`fixture_mine`).
fixture_remove :: proc(self: ^Self, origin: BlockPos, op: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match op["op"].as_str().unwrap_or("") {
    // rust: "set" => {
    // rust: let state = BlockStateId(op["state"].as_u64().unwrap_or(0) as u32);
    // rust: let flags = op["flags"].as_i64().unwrap_or(3) as i32;
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, origin, state, flags));
}
    // rust: "destroy" => {
    // rust: let drop = op["drop"].as_bool().unwrap_or(true);
    // rust: self.with_level(|b, level, ticks| b.destroy_block(level, ticks, origin, drop));
}
    // rust: "remove" => {
    // rust: self.with_level(|b, level, ticks| b.remove_block(level, ticks, origin, false));
}
    // rust: "mine" => return self.fixture_mine(origin, op),
    // rust: other => return Err(format!("unknown removal {other}").into()),
}
    // rust: self.process_level_events()?;
    // rust: Ok(Vec::new())
}

    // A survival player three blocks south of `pos` mines it holding the
    // case's item (`break_block`, which every player's mining goes through):
    // the statistics and the held stack, as `VanillaDispenserOracle.mine`
    // prints them.
fixture_mine :: proc(self: ^Self, pos: BlockPos, op: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let stack = parse_stack(op["item"].as_str().unwrap_or("-"))?;
    // rust: self.mode = GameMode::Survival;
    // rust: self.creative = false;
    // rust: self.player = Some(PlayerMotion::new(
    // rust: self.motion,
    // rust: horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 1.0,
    // rust: f64::from(pos.z) + 3.5,
    // rust: ),
    // rust: )?);
    // rust: self.yaw = 0.0;
    // rust: self.pitch = 90.0;
    // rust: self.keys.clear();
    // rust: self.inventory[self.selected] = stack.clone();
    // rust: self.offhand = None;
    // rust: let state = self.world.block(pos.x, pos.y, pos.z);
    // rust: let block = self.res.facts().get(state).name.clone();
    // rust: let item = stack.as_ref().map(|s| s.item.clone());
    // rust: let before = |game: &Self| {
    // rust: let used = item.as_ref().map_or(0, |i| game.stats.get("used", i));
    // rust: (used, game.stats.get("mined", &block))
}
    // rust: let (used, mined) = before(self);
    // rust: self.break_block([pos.x, pos.y, pos.z])?;
    // rust: let (used_after, mined_after) = before(self);
    // rust: let mut out = Vec::new();
    // rust: if let Some(item) = &item
    // rust: && used_after != used
    // rust: {
    // rust: out.push(format!("stat {item} minecraft:used {}", used_after - used));
}
    // rust: if mined_after != mined {
    // rust: out.push(format!(
    // rust: "stat {block} minecraft:mined {}",
    // rust: mined_after - mined
    // rust: ));
}
    // rust: out.push(format!(
    // rust: "mine held {}",
    // rust: canon_stack(self.inventory[self.selected].as_ref())
    // rust: ));
    // rust: Ok(out)
}

    // A villager lying in the bed at `origin` with `yaw` wakes up
    // (`Villager.stopSleeping`): where it stands and the yaw it turns to.
fixture_wake :: proc(self: ^Self, origin: BlockPos, op: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let kind = self
    // rust: .res
    // rust: .mob_types()
    // rust: .get("minecraft:villager")
    // rust: .cloned()
    // rust: .ok_or("no mob type minecraft:villager")?;
    // rust: let bed = [origin.x, origin.y, origin.z];
    // rust: let lying = horizon_core::geometry::Vec3::new(
    // rust: f64::from(bed[0]) + 0.5,
    // rust: f64::from(bed[1]) + 0.6875,
    // rust: f64::from(bed[2]) + 0.5,
    // rust: );
    // rust: let yaw = op["yaw"].as_f64().unwrap_or(0.0) as f32;
    // rust: let mut villager = Mob::new(1, kind, lying, yaw);
    // rust: horizon_client::mobs::villager::ext_mut(&mut villager).sleeping_pos = Some(bed);
    // rust: let mut events = Vec::new();
    // rust: let w = self.mob_world_base(&[]);
    // rust: horizon_client::mobs::villager::stop_sleeping(&mut villager, &w, &mut events);
    // rust: let p = villager.position;
    // rust: Ok(format!(
    // rust: "wake {} {} {} {}",
    // rust: num(p.x),
    // rust: num(p.y),
    // rust: num(p.z),
    // rust: villager.yaw.to_bits() as i32
    // rust: ))
}

    // `EntityType.create` and `snapTo` for one target: no spawn finalization.
fixture_target :: proc(self: ^Self, e: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let kind = e["type"].as_str().unwrap_or("minecraft:pig");
    // rust: let p = &e["pos"];
    // rust: let at = horizon_core::geometry::Vec3::new(
    // rust: p[0].as_f64().unwrap_or(0.0),
    // rust: p[1].as_f64().unwrap_or(0.0),
    // rust: p[2].as_f64().unwrap_or(0.0),
    // rust: );
    // rust: let yaw = e["yaw"].as_f64().unwrap_or(0.0) as f32;
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: if kind == "minecraft:armor_stand" {
    // rust: let mut stand = horizon_client::entities::ArmorStand::new(id, at, yaw);
    // rust: stand.marker = e["marker"].as_bool().unwrap_or(false);
    // rust: stand.on_ground = e["ground"].as_bool().unwrap_or(false);
    // rust: if let Some(last_hit) = e["last_hit"].as_i64() {
    // rust: stand.last_hit = last_hit;
}
    // rust: self.armor_stands.push(stand);
    // rust: return Ok(Target::Stand(id));
}
    // rust: let t = self
    // rust: .res
    // rust: .mob_types()
    // rust: .get(kind)
    // rust: .cloned()
    // rust: .ok_or_else(|| format!("no mob type {kind}"))?;
    // rust: let mut mob = Mob::new(id, t, at, yaw);
        // EntityType.create equips nothing (that is finalizeSpawn's job).
    // rust: for slot in [
    // rust: &mut mob.extra.main_hand,
    // rust: &mut mob.extra.off_hand,
    // rust: &mut mob.extra.head,
    // rust: &mut mob.extra.body,
    // rust: &mut mob.extra.chest,
    // rust: &mut mob.extra.legs,
    // rust: &mut mob.extra.feet,
    // rust: ] {
    // rust: *slot = None;
}
    // rust: let s = mob.species();
    // rust: let flag = |name: &str| e[name].as_bool().unwrap_or(false);
    // rust: let ageable = !matches!(
    // rust: s,
    // rust: Species::Zombie | Species::Skeleton | Species::Bogged | Species::SnowGolem
    // rust: );
    // rust: if flag("baby") && ageable {
    // rust: mob.extra.age = -24000;
}
    // rust: let tamable = horizon_client::mobs::drops::body_slot_species(s)
    // rust: || matches!(s, Species::Cat | Species::Parrot | Species::Ocelot);
    // rust: if flag("tame") && tamable {
    // rust: mob.extra.tame = true;
}
    // rust: if flag("sheared") && matches!(s, Species::Sheep | Species::Bogged | Species::SnowGolem) {
    // rust: mob.extra.sheared = true;
}
    // rust: if flag("chest")
    // rust: && matches!(
    // rust: s,
    // rust: Species::Donkey | Species::Mule | Species::Llama | Species::TraderLlama
    // rust: )
    // rust: {
    // rust: mob.extra.chested = true;
}
    // rust: if flag("loot") {
    // rust: mob.extra.pick_up_loot = true;
}
    // rust: mob.on_ground = flag("ground");
    // rust: if let Some(health) = e["health"].as_f64() {
    // rust: mob.attrs.max_health = health as f32;
    // rust: mob.health = health as f32;
}
    // rust: if let Some(resistance) = e["knockback_resistance"].as_f64() {
    // rust: mob.attrs.knockback_resistance = resistance;
}
    // rust: if flag("brown") && s == Species::Mooshroom {
    // rust: mob.extra.variant = 1;
}
    // rust: for (slot, snbt) in e["equip"].as_object().into_iter().flatten() {
    // rust: if let (Some(slot), Some(stack)) = (
    // rust: Slot::from_name(slot),
    // rust: parse_stack(snbt.as_str().unwrap_or("-"))?,
    // rust: ) {
    // rust: mob_set_slot(&mut mob, slot, stack);
}
}
    // rust: self.mobs.push(mob);
    // rust: Ok(Target::Mob(id))
}

    // `T` lines: removal, equipment by `EquipmentSlot`, shearing readiness, chests.
fixture_describe :: proc(self: ^Self, index: uint, target: ^Target) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut line = format!("T {index} ");
    // rust: match *target {
    // rust: Target::Stand(id) => {
    // rust: line.push_str("minecraft:armor_stand");
    // rust: let Some(stand) = self.armor_stands.iter().find(|s| s.id == id) else {
    // rust: line.push_str(" removed");
    // rust: return line;
}
    // rust: for (slot, name) in [
    // rust: (0, "mainhand"),
    // rust: (1, "offhand"),
    // rust: (2, "feet"),
    // rust: (3, "legs"),
    // rust: (4, "chest"),
    // rust: (5, "head"),
    // rust: ] {
    // rust: if let Some(s) = &stand.equipment[slot] {
    // rust: let _ = write!(line, " {name}={}x{}", s.item, s.count);
}
}
}
    // rust: Target::Mob(id) => {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return line + "removed";
}
    // rust: line.push_str(&m.kind.id);
    // rust: if m.removed || !m.alive() {
    // rust: line.push_str(" removed");
}
    // rust: let s = m.species();
    // rust: let x = &m.extra;
    // rust: for (slot, name) in [
    // rust: (Slot::MainHand, "mainhand"),
    // rust: (Slot::OffHand, "offhand"),
    // rust: (Slot::Feet, "feet"),
    // rust: (Slot::Legs, "legs"),
    // rust: (Slot::Chest, "chest"),
    // rust: (Slot::Head, "head"),
    // rust: (Slot::Body, "body"),
    // rust: (Slot::Saddle, "saddle"),
    // rust: ] {
    // rust: if let Some(item) = mob_slot_item(m, slot) {
    // rust: let _ = write!(line, " {name}={item}x1");
}
}
    // rust: let ready =
    // rust: match s {
    // rust: Species::Sheep => Some(!x.sheared && !m.is_baby()),
    // rust: Species::Mooshroom => Some(!m.is_baby()),
    // rust: Species::Bogged => Some(!x.sheared),
    // rust: Species::SnowGolem => Some(!x.sheared),
    // rust: Species::CopperGolem => Some(self.golem_shearable(
    // rust: self.mobs.iter().position(|o| o.id == id).unwrap_or(0),
    // rust: )),
    // rust: _ => None,
}
    // rust: if let Some(r) = ready {
    // rust: line.push_str(if r { " ready" } else { " unready" });
}
    // rust: if x.chested
    // rust: && matches!(
    // rust: s,
    // rust: Species::Donkey | Species::Mule | Species::Llama | Species::TraderLlama
    // rust: )
    // rust: {
    // rust: line.push_str(" chest");
}
    // rust: if x.leash.is_some() {
    // rust: line.push_str(" leashed");
}
}
}
    // rust: line
}

    // `N` lines for every entity the dispenser added.
fixture_entities :: proc(self: ^Self, old_mobs: ^[u32], old_stands: ^[u32], out: ^[dynamic]string) {
}
    // rust: let line = |kind: &str, p: [f64; 3], v: [f64; 3], extra: &str| {
    // rust: let mut l = format!(
    // rust: "N {kind} {} {} {} {} {} {}",
    // rust: num(p[0]),
    // rust: num(p[1]),
    // rust: num(p[2]),
    // rust: num(v[0]),
    // rust: num(v[1]),
    // rust: num(v[2])
    // rust: );
    // rust: if !extra.is_empty() {
    // rust: l.push(' ');
    // rust: l.push_str(extra);
}
    // rust: l
}
    // rust: for m in self.mobs.iter().filter(|m| !old_mobs.contains(&m.id)) {
    // rust: let (p, v) = (m.position, m.velocity);
    // rust: out.push(line(&m.kind.id, [p.x, p.y, p.z], [v.x, v.y, v.z], ""));
}
    // rust: if let Some(d) = &self.dragon {
    // rust: let p = d.position;
    // rust: out.push(line(
    // rust: "minecraft:ender_dragon",
    // rust: [p.x, p.y, p.z],
    // rust: [0.0; 3],
    // rust: "",
    // rust: ));
}
    // rust: for s in self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .filter(|s| !old_stands.contains(&s.id))
    // rust: {
    // rust: let (p, v) = (s.position, s.velocity);
    // rust: out.push(line(
    // rust: "minecraft:armor_stand",
    // rust: [p.x, p.y, p.z],
    // rust: [v.x, v.y, v.z],
    // rust: "",
    // rust: ));
}
    // rust: for d in &self.dropped {
    // rust: let (p, v) = (d.position, d.velocity);
    // rust: out.push(line(
    // rust: "minecraft:item",
    // rust: [p.x, p.y, p.z],
    // rust: [v.x, v.y, v.z],
    // rust: &canon_stack(Some(&d.stack)),
    // rust: ));
}
    // rust: for shot in &self.creatures.projectiles {
    // rust: let kind = match &shot.kind {
    // rust: ProjectileKind::Arrow {
    // rust: effect: Some(("minecraft:glowing", 200)),
    // rust: ..
    // rust: } => "minecraft:spectral_arrow",
    // rust: ProjectileKind::Arrow { .. } => "minecraft:arrow",
    // rust: ProjectileKind::Snowball => "minecraft:snowball",
    // rust: ProjectileKind::Egg => "minecraft:egg",
    // rust: ProjectileKind::SmallFireball => "minecraft:small_fireball",
    // rust: ProjectileKind::WindCharge => "minecraft:wind_charge",
    // rust: _ => "minecraft:unknown_projectile",
}
    // rust: let (p, v) = (shot.position, shot.velocity);
    // rust: out.push(line(kind, [p.x, p.y, p.z], [v.x, v.y, v.z], ""));
}
    // rust: for (kind, p, v) in self.potions.thrown_entities() {
    // rust: out.push(line(kind, [p.x, p.y, p.z], [v.x, v.y, v.z], ""));
}
    // rust: for (p, v) in self.rockets.iter().map(|r| r.motion()) {
    // rust: out.push(line(
    // rust: "minecraft:firework_rocket",
    // rust: [p.x, p.y, p.z],
    // rust: [v.x, v.y, v.z],
    // rust: "",
    // rust: ));
}
    // rust: for t in &self.tnts {
    // rust: let (p, v) = (t.position, t.velocity);
    // rust: out.push(line(
    // rust: "minecraft:tnt",
    // rust: [p.x, p.y, p.z],
    // rust: [v.x, v.y, v.z],
    // rust: &format!("fuse={}", t.fuse),
    // rust: ));
}
    // rust: for b in &self.boats {
    // rust: let kind = b.entity_type();
    // rust: let (p, v) = (b.position, b.velocity);
    // rust: out.push(line(&kind, [p.x, p.y, p.z], [v.x, v.y, v.z], ""));
}
        // A merged orb prints once per count, as the oracle does: whether orbs
        // merge depends on entity ids, which differ from vanilla's.
    // rust: for o in &self.orbs {
    // rust: let (p, v) = (o.position, o.velocity);
    // rust: for _ in 0..o.count.max(1) {
    // rust: out.push(line(
    // rust: "minecraft:experience_orb",
    // rust: [p.x, p.y, p.z],
    // rust: [v.x, v.y, v.z],
    // rust: "",
    // rust: ));
}
}
    // rust: for c in &self.carts {
    // rust: let (p, v) = (c.position, c.velocity);
    // rust: out.push(line(c.kind.id(), [p.x, p.y, p.z], [v.x, v.y, v.z], ""));
}
    // rust: for c in &self.crystals {
    // rust: let p = c.position;
    // rust: out.push(line("minecraft:end_crystal", [p.x, p.y, p.z], [0.0; 3], ""));
}
        // A hanging entity's position is its box's centre (HangingEntity.recalculateBoundingBox).
    // rust: let centre =
    // rust: |(lo, hi): ([f64; 3], [f64; 3])| std::array::from_fn(|i| (lo[i] + hi[i]) / 2.0);
    // rust: for p in &self.paintings {
    // rust: out.push(line("minecraft:painting", centre(p.bounds()), [0.0; 3], ""));
}
    // rust: for f in &self.item_frames {
    // rust: let kind = if f.glow {
    // rust: "minecraft:glow_item_frame"
    // rust: } else {
    // rust: "minecraft:item_frame"
}
    // rust: out.push(line(kind, centre(f.bounds()), [0.0; 3], ""));
}
}
}
