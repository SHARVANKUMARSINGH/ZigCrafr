//! Transpiled from Horizon Rust crate
package horizon_client_sculk_fixture

import "core:fmt"
import "core:mem"
import "core:math"

// The Rust side of tools/test_sculk_parity.py: with
// `HORIZON_SCULK_FIXTURE=SCENARIOS,OUTPUT` the game loads its resources and
// runs every scenario (sculk blocks, the player with a warning level, scripted
// game events and block changes) through its own sculk code on a fresh
// headless world, ticking in `ServerLevel.tick`'s order, and prints what
// changed after every tick in the format of `VanillaSculkOracle`.
// use super::{Game, dispense_fixture};
// use horizon_client::{
    // rust: Result,
    // rust: chunk::{Chunk, MIN_Y},
    // rust: command::args::GameMode,
    // rust: containers::BlockEntity,
    // rust: mobs::{Mob, Who},
    // rust: motion::PlayerMotion,
    // rust: sculk::{Info, SculkKind, WardenSpawnTracker},
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::LegacyRandom,
}
// use horizon_world::{chunk::BlockState, level::Ticks, registry::BlockStateId};
// use std::{
    // rust: collections::{BTreeMap, HashMap, HashSet},
    // rust: fmt::Write as _,
    // rust: io::Write as _,
    // rust: sync::Arc,
}
// use winit::keyboard::KeyCode;

MobSpec :: struct {
    kind: string,
    pos: [f64,
    yaw: f32,
    seed: i64,
    flags: [dynamic]string,
}
Scenario :: struct {
    name: string,
    ticks: i32,
    trace_events: bool,
    origin: [i32,
    level_seed: i64,
    difficulty: string,
    wardens: bool,
    blocks: [dynamic]Vec<string>,
    player: Option<[f64,
    mode: string,
    sneak: bool,
    warning: Maybe(i32),
    mobs: [dynamic]MobSpec,
    watch: Vec<[i32,
    regions: Vec<[i32,
    actions: Vec<(i32,
}

parse :: proc(text: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut cur: Option<Scenario> = None;
    // rust: for line in text.lines() {
    // rust: let f: Vec<&str> = line.split_whitespace().collect();
    // rust: if f.is_empty() || f[0].starts_with('#') {
    // rust: continue;
}
    // rust: let s = cur.get_or_insert_with(Scenario::default);
    // rust: match f[0] {
    // rust: "scenario" => {
    // rust: s.name = f[1].to_owned();
    // rust: s.difficulty = "normal".into();
    // rust: s.wardens = true;
    // rust: s.mode = "survival".into();
    // rust: for kv in &f[2..] {
    // rust: let (k, v) = kv.split_once('=').unwrap_or((kv, ""));
    // rust: match k {
    // rust: "traceevents" => s.trace_events = true,
    // rust: "ticks" => s.ticks = v.parse().unwrap_or(0),
    // rust: "levelseed" => s.level_seed = v.parse().unwrap_or(0),
    // rust: "difficulty" => s.difficulty = v.to_owned(),
    // rust: "nowardens" => s.wardens = false,
    // rust: _ => {}
}
}
}
    // rust: "origin" => s.origin = [f[1].parse().unwrap_or(0), f[2].parse().unwrap_or(0)],
    // rust: "fill" | "block" => s.blocks.push(f.iter().map(|x| (*x).to_owned()).collect()),
    // rust: "player" => {
    // rust: s.player = Some([
    // rust: f[1].parse().unwrap_or(0.0),
    // rust: f[2].parse().unwrap_or(0.0),
    // rust: f[3].parse().unwrap_or(0.0),
    // rust: ]);
    // rust: for w in &f[4..] {
    // rust: if *w == "sneak" {
    // rust: s.sneak = true;
    // rust: } else if let Some(level) = w.strip_prefix("warn=") {
    // rust: s.warning = level.parse().ok();
    // rust: } else {
    // rust: s.mode = (*w).to_owned();
}
}
}
    // rust: "mob" => s.mobs.push(MobSpec {
    // rust: kind: f[1].to_owned(),
    // rust: pos: [
    // rust: f[2].parse().unwrap_or(0.0),
    // rust: f[3].parse().unwrap_or(0.0),
    // rust: f[4].parse().unwrap_or(0.0),
    // rust: ],
    // rust: yaw: f[5].parse().unwrap_or(0.0),
    // rust: seed: f[6].parse().unwrap_or(0),
    // rust: flags: f[7..].iter().map(|x| (*x).to_owned()).collect(),
    // rust: }),
    // rust: "watch" => s.watch.push([
    // rust: f[1].parse().unwrap_or(0),
    // rust: f[2].parse().unwrap_or(0),
    // rust: f[3].parse().unwrap_or(0),
    // rust: ]),
    // rust: "region" => {
    // rust: let n = |i: usize| f[i].parse::<i32>().unwrap_or(0);
    // rust: s.regions.push([n(1), n(2), n(3), n(4), n(5), n(6)]);
}
    // rust: "at" => s.actions.push((
    // rust: f[1].parse().unwrap_or(0),
    // rust: f[2..].iter().map(|x| (*x).to_owned()).collect(),
    // rust: )),
    // rust: "end" => out.extend(cur.take()),
    // rust: _ => {}
}
}
    // rust: out
}

// An entity's own random is unseeded in vanilla, and so are its sensors'
// first delays and its brain's `RunOne` shuffles: the oracle seeds what
// appeared, and so does this.
seed_fresh :: proc(m: ^Mob, seed: i64) {
}
    // rust: m.random = LegacyRandom::new(seed);
    // rust: horizon_client::mobs::warden::init_brain(m, seed);
}
d :: proc(v: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{:x}", v.to_bits())
}
f :: proc(v: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{:x}", v.to_bits())
}

// Sounds the client plays for level events (3006 sculk charge, 3007
// shriek) and for itself (the warden's heartbeat): vanilla's server never
// sends them.
    // rust: const CLIENT_SOUNDS: &[&str] = &[
    // rust: "minecraft:block.sculk_shrieker.shriek",
    // rust: "minecraft:block.sculk.charge",
    // rust: "minecraft:entity.warden.heartbeat",
    // rust: ];

    // rust: impl Game<'_> {
    // Run every scenario of `spec` ("SCENARIOS,OUTPUT") and write the results.
    // rust: pub(super) fn sculk_fixture(&mut self, spec: &str) -> Result<()> {
    // rust: assert!(
    // rust: !self.options.execution_role.is_client(),
    // rust: "fixture requires a server Game"
    // rust: );
    // rust: let (input, output) = spec
    // rust: .split_once(',')
    // rust: .ok_or("HORIZON_SCULK_FIXTURE=SCENARIOS,OUTPUT")?;
    // rust: let text = std::fs::read_to_string(input)?;
    // rust: let mut out = std::io::BufWriter::new(std::fs::File::create(output)?);
    // rust: for s in parse(&text) {
    // rust: writeln!(out, "== {}", s.name)?;
    // rust: match self.sculk_scenario(&s) {
    // rust: Ok(lines) => out.write_all(lines.as_bytes())?,
    // rust: Err(e) => writeln!(out, "0 failed {e}")?,
}
}
    // rust: Ok(())
}

    // `minecraft:name[key=value,...]` to a state.
fixture_state :: proc(self: ^Self, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (name, props) = match text.split_once('[') {
    // rust: Some((n, rest)) => (n, rest.trim_end_matches(']')),
    // rust: None => (text, ""),
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let base = registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| format!("unknown block {name}"))?;
    // rust: let mut properties: BTreeMap<String, String> = registry
    // rust: .state(base)
    // rust: .map(|s| s.properties.clone().into_iter().collect())
    // rust: .unwrap_or_default();
    // rust: for kv in props.split(',').filter(|s| !s.is_empty()) {
    // rust: let (k, v) = kv.split_once('=').ok_or("property")?;
    // rust: properties.insert(k.to_owned(), v.to_owned());
}
    // rust: Ok(registry.resolve(&BlockState {
    // rust: name: name.to_owned(),
    // rust: properties: properties.into(),
    // rust: })?)
}

    // `BlockStateParser.serialize`.
fixture_state_text :: proc(self: ^Self, state: BlockStateId) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = self.pack.assets.registry.state(state) else {
    // rust: return "?".into();
}
    // rust: if s.properties.is_empty() {
    // rust: return s.name.clone();
}
    // rust: let mut sorted: Vec<(&String, &String)> = s.properties.iter().collect();
    // rust: sorted.sort();
    // rust: let props: Vec<String> = sorted.iter().map(|(k, v)| format!("{k}={v}")).collect();
    // rust: format!("{}[{}]", s.name, props.join(","))
}

fixture_who :: proc(self: ^Self, who: Maybe(Who), names: ^HashMap<u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match who {
    // rust: None => "none".into(),
    // rust: Some(Who::Player) => "player".into(),
    // rust: Some(Who::Mob(id)) => names.get(&id).cloned().unwrap_or_else(|| format!("e{id}")),
}
}

fixture_info :: proc(self: ^Self, info: Maybe(^Info), names: ^HashMap<u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(i) = info else {
    // rust: return "-".into();
}
        // A source entity that is gone reads as none (VibrationInfo.getEntity).
    // rust: let alive = |w: Option<Who>| match w {
    // rust: Some(Who::Mob(id)) if !self.mobs.iter().any(|m| m.id == id && !m.removed) => None,
    // rust: other => other,
}
    // rust: format!(
    // rust: "{}/{}/{},{},{}/{}/{}",
    // rust: i.event.trim_start_matches("minecraft:"),
    // rust: f(i.distance),
    // rust: d(i.pos[0]),
    // rust: d(i.pos[1]),
    // rust: d(i.pos[2]),
    // rust: self.fixture_who(alive(i.source), names),
    // rust: self.fixture_who(alive(i.owner), names)
    // rust: )
}

sculk_describe :: proc(self: ^Self, p: [i32; 3], names: ^HashMap<u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let mut line = self.fixture_state_text(state);
    // rust: if let Some(BlockEntity::Sculk(e)) = self.world.block_entities.get(&(p[0], p[1], p[2])) {
    // rust: let vibration = |line: &mut String| {
    // rust: let v = &e.vibration;
    // rust: let _ = write!(
    // rust: line,
    // rust: " cur={} travel={}",
    // rust: self.fixture_info(v.current.as_ref(), names),
    // rust: v.travel
    // rust: );
    // rust: match v.selector.current() {
    // rust: None => line.push_str(" sel=-"),
    // rust: Some((info, tick)) => {
    // rust: let _ = write!(
    // rust: line,
    // rust: " sel={}@{tick}",
    // rust: self.fixture_info(Some(&info), names)
    // rust: );
}
}
}
    // rust: match e.kind {
    // rust: SculkKind::Sensor | SculkKind::Calibrated => {
    // rust: let _ = write!(line, " freq={}", e.last_frequency);
    // rust: vibration(&mut line);
}
    // rust: SculkKind::Shrieker => {
    // rust: let _ = write!(line, " warn={}", e.warning_level);
    // rust: vibration(&mut line);
}
    // rust: SculkKind::Catalyst => {
    // rust: let _ = write!(line, " cursors={}", e.spreader.cursors.len());
    // rust: for c in &e.spreader.cursors {
    // rust: let _ = write!(
    // rust: line,
    // rust: " {},{},{}:{}:{}:{}:",
    // rust: c.pos.x, c.pos.y, c.pos.z, c.charge, c.update_delay, c.decay_delay
    // rust: );
    // rust: match &c.facings {
    // rust: None => line.push('-'),
    // rust: Some(faces) => {
    // rust: let mut faces = faces.clone();
    // rust: faces.sort_by_key(|d| *d as u8);
    // rust: for d in faces {
    // rust: line.push(match d {
    // rust: Direction::Down => 'd',
    // rust: Direction::Up => 'u',
    // rust: Direction::North => 'n',
    // rust: Direction::South => 's',
    // rust: Direction::West => 'w',
    // rust: Direction::East => 'e',
    // rust: });
}
}
}
}
}
}
}
    // rust: line
}

sculk_fixture_reset :: proc(self: ^Self, s: ^Scenario) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world = World::new(self.res.facts().air, 0);
    // rust: let plains = u32::from(world_biomes!(self).id("minecraft:plains"));
    // rust: let layers = [
    // rust: self.fixture_state("minecraft:bedrock")?,
    // rust: self.fixture_state("minecraft:dirt")?,
    // rust: self.fixture_state("minecraft:dirt")?,
    // rust: self.fixture_state("minecraft:grass_block")?,
    // rust: ];
    // rust: let (ocx, ocz) = (s.origin[0] >> 4, s.origin[1] >> 4);
    // rust: for cx in ocx - 4..=ocx + 4 {
    // rust: for cz in ocz - 4..=ocz + 4 {
    // rust: let mut chunk = Chunk::empty(cx, cz);
    // rust: for section in &mut chunk.sections {
    // rust: Arc::make_mut(section).biomes = horizon_core::paletted::PalettedContainer::new(
    // rust: horizon_client::chunk::BIOME_STRATEGY,
    // rust: plains,
    // rust: );
}
    // rust: chunk.lit = true;
    // rust: self.world.chunks.insert((cx, cz), Arc::new(chunk));
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
    // rust: for (y, layer) in layers.iter().enumerate() {
    // rust: self.world
    // rust: .set(cx * 16 + x, MIN_Y + y as i32, cz * 16 + z, *layer)?;
}
}
}
}
}
    // rust: self.block_ticks = Ticks::new(0);
    // rust: self.tick_chunks.clear();
    // rust: self.sync_tick_chunks();
    // rust: self.mobs.clear();
    // rust: if s.trace_events {
    // rust: self.creatures.projectiles.clear();
}
    // rust: self.dropped.clear();
    // rust: self.orbs.clear();
    // rust: self.level_events.clear();
    // rust: self.ui.rules = Default::default();
    // rust: for (rule, value) in [
    // rust: ("spawn_mobs", false),
    // rust: ("spawn_monsters", false),
    // rust: ("spawn_patrols", false),
    // rust: ("spawn_phantoms", false),
    // rust: ("spawn_wandering_traders", false),
    // rust: ("advance_time", false),
    // rust: ("advance_weather", false),
    // rust: ("raids", false),
    // rust: ("spawn_wardens", s.wardens),
    // rust: ] {
    // rust: self.ui
    // rust: .rules
    // rust: .set(rule, horizon_client::gamerules::Value::Bool(value));
}
    // rust: self.ui.rules.set(
    // rust: "random_tick_speed",
    // rust: horizon_client::gamerules::Value::Int(0),
    // rust: );
//         use horizon_world::food::Difficulty;
    // rust: let difficulty = match s.difficulty.as_str() {
    // rust: "peaceful" => Difficulty::Peaceful,
    // rust: "easy" => Difficulty::Easy,
    // rust: "hard" => Difficulty::Hard,
    // rust: _ => Difficulty::Normal,
}
    // rust: self.world.health_rules.difficulty = difficulty;
    // rust: self.ui.difficulty = match difficulty {
    // rust: Difficulty::Peaceful => 0,
    // rust: Difficulty::Easy => 1,
    // rust: Difficulty::Normal => 2,
    // rust: Difficulty::Hard => 3,
}
    // rust: self.level.seed = 0;
    // rust: self.potions.effects = Default::default();
    // rust: self.sculk = Default::default();
    // rust: self.sculk.tracker_loaded = true;
    // rust: self.sculk_prepare();
    // rust: Ok(())
}

sculk_scenario :: proc(self: ^Self, s: ^Scenario) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.sculk_fixture_reset(s)?;
    // rust: let at = s.player.unwrap_or([
    // rust: f64::from(s.origin[0]) + 0.5,
    // rust: 100.0,
    // rust: f64::from(s.origin[1]) + 0.5,
    // rust: ]);
    // rust: self.mode = match s.mode.as_str() {
    // rust: "creative" => GameMode::Creative,
    // rust: "spectator" => GameMode::Spectator,
    // rust: "adventure" => GameMode::Adventure,
    // rust: _ => GameMode::Survival,
}
    // rust: self.creative = self.mode == GameMode::Creative;
    // rust: let mut player = PlayerMotion::new(self.motion, Vec3::new(at[0], at[1], at[2]))?;
    // rust: player.spectator = self.mode == GameMode::Spectator;
    // rust: self.player = Some(player);
    // rust: if s.trace_events {
    // rust: self.previous_position = Vec3::new(at[0], at[1], at[2]);
}
    // rust: self.keys.clear();
    // rust: if s.sneak {
    // rust: self.keys.insert(KeyCode::ShiftLeft);
}
    // rust: self.sculk.tracker = WardenSpawnTracker::default();
    // rust: if let Some(level) = s.warning {
    // rust: self.sculk.tracker.set_warning_level(level);
}
        // The blocks, in order (sculk block entities tick in the order they
        // were placed), with `Level.setBlock(pos, state, 2 | 16)` at game time 1000.
    // rust: self.world.game_time = 1000;
    // rust: let mut cells = Vec::new();
    // rust: for b in &s.blocks {
    // rust: let n = |i: usize| b[i].parse::<i32>().unwrap_or(0);
    // rust: if b[0] == "block" {
    // rust: cells.push((BlockPos::new(n(1), n(2), n(3)), self.fixture_state(&b[4])?));
    // rust: } else {
    // rust: let state = self.fixture_state(&b[7])?;
    // rust: for x in n(1).min(n(4))..=n(1).max(n(4)) {
    // rust: for y in n(2).min(n(5))..=n(2).max(n(5)) {
    // rust: for z in n(3).min(n(6))..=n(3).max(n(6)) {
    // rust: cells.push((BlockPos::new(x, y, z), state));
}
}
}
}
}
    // rust: self.with_level(|b, level, ticks| {
    // rust: for (pos, state) in cells {
    // rust: b.set_block(level, ticks, pos, state, 2 | 16);
}
    // rust: });
    // rust: self.level_events.clear();
    // rust: self.sculk.known = self.world.chunks.keys().copied().collect();
    // rust: self.sculk.known_revision = Some(self.world.chunks.membership_revision());
    // rust: self.sculk_sync_index();
    // rust: let mut names: HashMap<u32, String> = HashMap::new();
    // rust: let mut sources: Vec<u32> = Vec::new();
    // rust: for spec in &s.mobs {
    // rust: let kind = self
    // rust: .res
    // rust: .mob_types()
    // rust: .get(&spec.kind)
    // rust: .cloned()
    // rust: .ok_or_else(|| format!("unknown mob {}", spec.kind))?;
    // rust: let id = 100_000 + sources.len() as u32;
    // rust: let mut m = Mob::new(
    // rust: id,
    // rust: kind,
    // rust: Vec3::new(spec.pos[0], spec.pos[1], spec.pos[2]),
    // rust: spec.yaw,
    // rust: );
    // rust: for flag in &spec.flags {
    // rust: match flag.as_str() {
    // rust: "persistent" => m.persistent = true,
    // rust: "noai" => m.no_ai = true,
    // rust: _ => {}
}
}
    // rust: m.random = LegacyRandom::new(spec.seed);
            // EntityType.create equips nothing (that is finalizeSpawn's job).
    // rust: for slot in [
    // rust: &mut m.extra.main_hand,
    // rust: &mut m.extra.off_hand,
    // rust: &mut m.extra.head,
    // rust: &mut m.extra.chest,
    // rust: &mut m.extra.legs,
    // rust: &mut m.extra.feet,
    // rust: ] {
    // rust: *slot = None;
}
    // rust: if s.trace_events {
    // rust: horizon_client::mobs::warden::finalize(&mut m, false, &mut Vec::new());
}
    // rust: names.insert(id, format!("m{}", sources.len()));
    // rust: sources.push(id);
    // rust: self.mobs.push(m);
}
    // rust: self.next_entity = self.next_entity.max(200_000);
    // rust: self.world.day_time = 6000;
    // rust: self.world.random = LegacyRandom::new(s.level_seed);
    // rust: self.audio.capture = Some(Vec::new());
    // rust: let mut known: HashSet<u32> = self.mobs.iter().map(|m| m.id).collect();
    // rust: let mut seeded: HashSet<u32> = HashSet::new();
    // rust: let mut known_items = self.dropped.len();
    // rust: let mut known_orbs = self.orbs.len();
    // rust: let mut last: HashMap<[i32; 3], String> = HashMap::new();
    // rust: let mut region_last: HashMap<[i32; 3], String> = HashMap::new();
    // rust: let (mut last_player, mut last_rng) = (String::new(), String::new());
    // rust: let mut out = String::new();
    // rust: self.lan_entity_events.clear();
    // rust: for t in 0..=s.ticks {
    // rust: dispense_fixture::start_recording();
    // rust: if t > 0 {
    // rust: self.sculk_fixture_tick(t, s, &sources, &known, names.len(), &mut seeded)?;
}
    // rust: let mut lines: Vec<String> = Vec::new();
    // rust: for p in &s.watch {
    // rust: let line = self.sculk_describe(*p, &names);
    // rust: if last.get(p) != Some(&line) {
    // rust: last.insert(*p, line.clone());
    // rust: lines.push(format!("blk {},{},{} {line}", p[0], p[1], p[2]));
}
}
            // Regions: every block whose state changed.
    // rust: for r in &s.regions {
    // rust: for x in r[0]..=r[3] {
    // rust: for y in r[1]..=r[4] {
    // rust: for z in r[2]..=r[5] {
    // rust: let state = self.fixture_state_text(self.world.block(x, y, z));
    // rust: let before = region_last.insert([x, y, z], state.clone());
    // rust: if t > 0 && before.as_ref() != Some(&state) {
    // rust: lines.push(format!("set {x},{y},{z} {state}"));
}
}
}
}
}
    // rust: let tr = self.sculk.tracker;
    // rust: let dark = self
    // rust: .potions
    // rust: .effects
    // rust: .get("darkness")
    // rust: .map_or("-".to_owned(), |e| e.duration.to_string());
    // rust: let now = format!(
    // rust: "warn {} {} dark {dark}",
    // rust: tr.warning_level, tr.cooldown_ticks
    // rust: );
    // rust: if now != last_player {
    // rust: last_player = now.clone();
    // rust: lines.push(now);
}
    // rust: let mut fresh: Vec<&Mob> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| !known.contains(&m.id))
    // rust: .collect();
    // rust: fresh.sort_by_key(|m| m.id);
    // rust: let fresh: Vec<(u32, String)> = fresh
    // rust: .iter()
    // rust: .map(|m| {
    // rust: (
    // rust: m.id,
    // rust: format!(
    // rust: "new {} {},{},{}",
    // rust: m.kind.id,
    // rust: d(m.position.x),
    // rust: d(m.position.y),
    // rust: d(m.position.z)
    // rust: ),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (id, line) in fresh {
    // rust: known.insert(id);
    // rust: names.insert(id, format!("n{}", names.len()));
    // rust: let seed = 0x5eed + names.len() as i64;
    // rust: if seeded.insert(id)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: seed_fresh(m, seed);
}
    // rust: lines.push(line);
}
    // rust: for i in known_items..self.dropped.len() {
    // rust: let d = &self.dropped[i];
    // rust: names.insert(u32::MAX - i as u32, format!("n{}", names.len()));
    // rust: lines.push(format!(
    // rust: "new minecraft:item {},{},{}",
    // rust: self::d(d.position.x),
    // rust: self::d(d.position.y),
    // rust: self::d(d.position.z)
    // rust: ));
}
    // rust: known_items = self.dropped.len();
            // Where an orb flies comes from its own random: its value only.
    // rust: for orb in &self.orbs[known_orbs.min(self.orbs.len())..] {
    // rust: lines.push(format!("new minecraft:experience_orb value={}", orb.value));
}
    // rust: known_orbs = self.orbs.len();
    // rust: if s.trace_events {
    // rust: for m in &self.mobs {
    // rust: if let Some(st) = &m.extra.warden {
    // rust: let selected = st.vibration.selector.current().map(|(i, _)| {
    // rust: serde_json::json!({"event": i.event, "pos": i.pos, "distance": i.distance})
    // rust: });
    // rust: lines.push(format!(
    // rust: "listener {}",
    // rust: serde_json::json!({"selector": selected})
    // rust: ));
}
}
    // rust: for p in &self.creatures.projectiles {
    // rust: lines.push(format!(
    // rust: "projectile {}",
    // rust: serde_json::json!({"kind": p.kind.id(),
    // rust: "pos": [p.position.x, p.position.y, p.position.z]})
    // rust: ));
}
    // rust: for (_, event, _) in self.lan_entity_events.drain(..) {
    // rust: lines.push(format!("entity_event {event}"));
}
}
    // rust: for line in dispense_fixture::stop_recording() {
    // rust: if let Some(rest) = line.strip_prefix("L ") {
    // rust: lines.push(format!("level {rest}"));
    // rust: } else if s.trace_events
    // rust: && let Some(rest) = line.strip_prefix("G ")
    // rust: {
    // rust: lines.push(format!("game {rest}"));
}
}
    // rust: for sound in self.audio.capture.replace(Vec::new()).unwrap_or_default() {
    // rust: let horizon_client::audio::CapturedSound {
    // rust: event: sound,
    // rust: position: at,
    // rust: volume,
    // rust: pitch,
    // rust: ..
    // rust: } = sound;
    // rust: if CLIENT_SOUNDS.contains(&sound.as_str()) {
    // rust: continue;
}
    // rust: lines.push(format!(
    // rust: "sound {sound} {},{},{} {} {}",
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: f(volume),
    // rust: f(pitch)
    // rust: ));
}
    // rust: let rng = format!("rng {:x}", self.world.random.state());
    // rust: if rng != last_rng {
    // rust: last_rng = rng.clone();
    // rust: lines.push(rng);
}
    // rust: for line in lines {
    // rust: let _ = writeln!(out, "{t} {line}");
}
}
    // rust: self.audio.capture = None;
    // rust: Ok(out)
}

    // One `ServerLevel.tick` of a scenario.
    // rust: fn sculk_fixture_tick(
    // rust: &mut self,
    // rust: t: i32,
    // rust: s: &Scenario,
    // rust: sources: &[u32],
    // rust: known: &HashSet<u32>,
    // rust: named: usize,
    // rust: seeded: &mut HashSet<u32>,
    // rust: ) -> Result<()> {
    // rust: self.world.game_time += 1;
        // Scheduled block and fluid ticks, then block events.
    // rust: self.tick_scheduled()?;
    // rust: self.with_level(|b, level, ticks| b.run_block_events(level, ticks));
    // rust: self.process_level_events()?;
        // The scenario's actions happen among the entities.
    // rust: for (tick, words) in &s.actions {
    // rust: if *tick != t {
    // rust: continue;
}
    // rust: match words[0].as_str() {
    // rust: "summon_snowball" => {
    // rust: let owner = self
    // rust: .acting_player_uuid()
    // rust: .iter()
    // rust: .map(i32::to_string)
    // rust: .collect::<Vec<_>>()
    // rust: .join(",");
    // rust: let nbt = words[1..]
    // rust: .join(" ")
    // rust: .replace("$owner", &format!("[I;{owner}]"));
    // rust: let before = self.creatures.projectiles.len();
    // rust: self.summon_with_nbt("minecraft:snowball", [30.5, 205.0, 10.5], &nbt)
    // rust: .map_err(|_| "fixture summon failed")?;
    // rust: if self.creatures.projectiles.len() != before + 1 {
    // rust: return Err("fixture summon created no projectile".into());
}
}
    // rust: "throw_snowball" => {
    // rust: self.throw_item(&horizon_client::items::ItemStack::new(
    // rust: "minecraft:snowball",
    // rust: 1,
    // rust: ))?;
}
    // rust: "mob_snowball" => {
    // rust: let owner = *sources.first().ok_or("mob_snowball needs a mob")?;
    // rust: let mut p = horizon_client::projectiles::Projectile::new(
    // rust: horizon_client::projectiles::ProjectileKind::Snowball,
    // rust: Vec3::new(4.5, 201.5, 10.5),
    // rust: Some(Who::Mob(owner)),
    // rust: );
    // rust: p.velocity = Vec3::new(0.0, 0.0, 1.5);
    // rust: self.handle_mob_events(vec![horizon_client::mobs::MobEvent::Projectile(p)])?;
}
    // rust: "event" => {
    // rust: let event = horizon_client::sculk::intern(&words[1])
    // rust: .ok_or_else(|| format!("unknown game event {}", words[1]))?;
    // rust: let num = |i: usize| words[i].parse::<f64>().unwrap_or(0.0);
    // rust: let pos = [num(2), num(3), num(4)];
    // rust: let who = match words[5].as_str() {
    // rust: "none" => None,
    // rust: "player" => Some(Who::Player),
    // rust: m => sources
    // rust: .get(m[1..].parse::<usize>().unwrap_or(usize::MAX))
    // rust: .map(|id| Who::Mob(*id)),
}
    // rust: let state = match words.get(6) {
    // rust: Some(text) => Some(self.fixture_state(text)?),
    // rust: None => None,
}
    // rust: let ctx = self.who_context(who, state);
    // rust: self.post_game_event(event, pos, ctx);
}
    // rust: "kill" => {
                    // LivingEntity.hurtServer with a player attack.
    // rust: let id = sources
    // rust: .get(words[1][1..].parse::<usize>().unwrap_or(usize::MAX))
    // rust: .copied()
    // rust: .ok_or("kill: no such mob")?;
    // rust: let amount = words
    // rust: .get(2)
    // rust: .and_then(|a| a.parse::<f32>().ok())
    // rust: .unwrap_or(1000.0);
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z])
    // rust: .unwrap_or_default();
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.damage(amount, horizon_client::mobs::Damage::player(at));
}
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
}
                // Creeper.ignite: the next tick primes the fuse.
    // rust: "ignite" | "ate" => {
    // rust: let id = sources
    // rust: .get(words[1][1..].parse::<usize>().unwrap_or(usize::MAX))
    // rust: .copied()
    // rust: .ok_or("no such mob")?;
    // rust: let mut events = Vec::new();
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: if words[0] == "ignite" {
    // rust: m.extra.flag = true;
    // rust: } else {
                            // Mob.ate.
    // rust: horizon_client::mobs::ai::ate(m, &mut events);
}
}
    // rust: self.handle_mob_events(events)?;
}
    // rust: "set" => {
    // rust: let n = |i: usize| words[i].parse::<i32>().unwrap_or(0);
    // rust: let pos = BlockPos::new(n(1), n(2), n(3));
    // rust: let state = self.fixture_state(&words[4])?;
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, pos, state, 3);
    // rust: });
    // rust: self.process_level_events()?;
}
    // rust: other => return Err(format!("unknown action {other}").into()),
}
}
        // Mobs that appeared during the block ticks (a summoned warden) tick
        // in this tick's entity phase: seed them now, as they are seeded
        // after the tick.
    // rust: let mut born: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| m.id)
    // rust: .filter(|id| !known.contains(id))
    // rust: .collect();
    // rust: born.sort_unstable();
    // rust: for (i, id) in born.into_iter().enumerate() {
    // rust: if seeded.insert(id)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: seed_fresh(m, 0x5eed + (named + i + 1) as i64);
}
}
        // The player's tickets, as `tick_world` takes them.
    // rust: self.update_chunk_tickets();
        // Entities: the player's warden spawn tracker, then the mobs.
    // rust: self.tick_sculk_entities();
        // (ServerChunkCache.tick, natural spawning and its chunk shuffle, is not run.)
    // rust: self.tick_creature_entities()?;
    // rust: self.tick_items();
        // Block entities.
    // rust: self.tick_sculk_blocks()?;
    // rust: Ok(())
}
}
