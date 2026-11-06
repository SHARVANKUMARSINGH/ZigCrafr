//! Transpiled from Horizon Rust crate
//! Module: horizon-client_zombie_villager
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Zombie villagers (`ZombieVillager`): the cure started by a golden apple on
//! a weakened one, the conversion clock that iron bars and beds speed up, and
//! the saved fields. Turning villagers into zombie villagers and back is done
//! by the game (`game/zombie_villagers.rs`), which owns entity creation.
// use super::{Mob, MobEvent, MobWorld, Species, goals::Cx, villager};
// use horizon_core::random::RandomSource;
// use horizon_world::nbt::{Compound, Tag};

/// `VILLAGER_CONVERSION_WAIT_MIN` and the width of the random range.
pub const WAIT_MIN: i32 = 3600;
pub const WAIT_SPREAD: i32 = 2401;
/// `MAX_SPECIAL_BLOCKS_COUNT` and `SPECIAL_BLOCK_RADIUS`.
pub const MAX_SPECIAL_BLOCKS: i32 = 14;
pub const RADIUS: i32 = 4;
pub const SPEEDS_UP_CURING: []const u8 = "minecraft:speeds_up_zombie_villager_curing";

/// A cure under way: ticks left and the player who started it.
pub const Cure = struct {
    time: i32,
    starter: Option<[i32,
};

pub fn cure(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: villager::ext(m).and_then(|e| e.cure.as_ref())
}
/// `ZombieVillager.handleEntityEvent(16)`: the client's cure sound.
pub fn cure_sound(m: *mut Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.species() != Species::ZombieVillager || m.silent {
    // rust: return None;
}
    // rust: let volume = 1.0 + m.random.next_float();
    // rust: let pitch = m.random.next_float() * 0.7 + 0.3;
    // rust: Some(MobEvent::Sound(
    // rust: "entity.zombie_villager.cure",
    // rust: [m.position.x, m.eye_y(), m.position.z],
    // rust: volume,
    // rust: pitch,
    // rust: ))
}
/// `ZombieVillager.DATA_CONVERTING_ID` on a client: only `is_converting`
/// (the cure's shaking) reads the cure, so its time does not matter.
pub fn set_converting(m: *mut Mob, on: bool) void {
}
    // rust: villager::ext_mut(m).cure = on.then_some(Cure {
    // rust: time: 0,
    // rust: starter: None,
    // rust: });
}
pub fn is_converting(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::ZombieVillager && cure(m).is_some()
}
/// `removeWhenFarAway`: curing ones and those with experience stay.
pub fn keeps_alive(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::ZombieVillager
    // rust: && (is_converting(m) || m.extra.trade.as_ref().is_some_and(|t| t.xp != 0))
}

/// `ZombieVillager.startConverting`: weakness gives way to strength for the
/// length of the cure and the cure sound plays (entity event 16).
    // rust: pub fn start_converting(
    // rust: m: &mut Mob,
    // rust: starter: Option<[i32; 4]>,
    // rust: time: i32,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: villager::ext_mut(m).cure = Some(Cure { time, starter });
    // rust: m.extra.effects.retain(|e| e.0 != "minecraft:weakness");
    // Strength amplifier: min(difficulty id - 1, 0), always 0 with monsters.
    // rust: m.add_effect("minecraft:strength", time, 0);
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 16,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}

/// `getConversionProgress`: 1 per tick, plus a chance per nearby iron bars or
/// bed (up to 14 of them) found on one tick in a hundred.
pub fn progress(m: *mut Mob, w: *MobWorld) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut amount = 1;
    // rust: if m.random.next_float() < 0.01 {
    // rust: let mut special = 0;
        // `(int) getX()` truncates toward zero.
    // rust: let (bx, by, bz) = (
    // rust: m.position.x as i32,
    // rust: m.position.y as i32,
    // rust: m.position.z as i32,
    // rust: );
    // rust: 'scan: for x in bx - RADIUS..bx + RADIUS {
    // rust: for y in by - RADIUS..by + RADIUS {
    // rust: for z in bz - RADIUS..bz + RADIUS {
    // rust: if special >= MAX_SPECIAL_BLOCKS {
    // rust: break 'scan;
}
    // rust: if w.has_tag(SPEEDS_UP_CURING, w.block_name(x, y, z)) {
    // rust: if m.random.next_float() < 0.3 {
    // rust: amount += 1;
}
    // rust: special += 1;
}
}
}
}
}
    // rust: amount
}

/// `ZombieVillager.tick`: count the cure down, finishing it at zero.
pub fn step(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if !m.alive() || !is_converting(m) {
    // rust: return;
}
    // rust: let amount = progress(m, cx.w);
    // rust: let Some(c) = villager::ext_mut(m).cure.as_mut() else {
    // rust: return;
}
    // rust: c.time -= amount;
    // rust: if c.time <= 0 {
    // rust: cx.events.push(MobEvent::CureZombieVillager { mob: m.id });
}
}

/// `ConversionTime` (-1: not converting) and `ConversionPlayer`.
pub fn put_cure(map: *mut Compound, cure: ?Cure) void {
}
    // rust: map.insert(
    // rust: "ConversionTime".into(),
    // rust: Tag::Int(cure.map_or(-1, |c| c.time)),
    // rust: );
    // rust: if let Some(starter) = cure.and_then(|c| c.starter) {
    // rust: map.insert("ConversionPlayer".into(), Tag::IntArray(starter.to_vec()));
}
}
pub fn parse_cure(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let time = match tag.get("ConversionTime") {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => -1,
}
    // rust: (time != -1).then(|| Cure {
    // rust: time,
    // rust: starter: crate::save::uuid_from_tag(tag.get("ConversionPlayer")),
    // rust: })
}
/// The saved fields: the cure and the gossip.
pub fn write_nbt(m: *Mob, map: *mut Compound) void {
}
    // rust: put_cure(map, cure(m).copied());
    // rust: if let Some(e) = villager::ext(m)
    // rust: && !e.gossips.is_empty()
    // rust: {
    // rust: map.insert("Gossips".into(), e.gossips.to_nbt());
}
}
pub fn read_nbt(m: *mut Mob, tag: *Tag) void {
}
    // rust: let cure = parse_cure(tag);
    // rust: let e = villager::ext_mut(m);
    // rust: e.cure = cure;
    // rust: e.gossips = tag
    // rust: .get("Gossips")
    // rust: .map(crate::gossip::Gossips::from_nbt)
    // rust: .unwrap_or_default();
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::{geometry::Vec3, random::LegacyRandom};

pub fn zombie_villager() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = super::super::sensor_scan_tests::kind();
    // rust: let data = std::sync::Arc::make_mut(&mut kind);
    // rust: data.id = "minecraft:zombie_villager".into();
    // rust: data.species = Species::ZombieVillager;
    // rust: data.eye_height = 1.5;
    // rust: let mut m = Mob::new(42, kind, Vec3::new(1.25, 2.0, 3.75), 0.0);
    // rust: m.random = LegacyRandom::new(0);
    // rust: m
}

pub fn a_cure_round_trips_through_nbt() void {
}
    // rust: let cure = Cure {
    // rust: time: 4200,
    // rust: starter: Some([1, 2, 3, 4]),
}
    // rust: let mut map = Compound::new();
    // rust: put_cure(&mut map, Some(cure));
    // rust: assert_eq!(parse_cure(&Tag::Compound(map)), Some(cure));
}
    /// `ZombieVillager.tick` counts the cure down before `Zombie.tick`,
    /// whatever the AI: a `NoAI` zombie villager finishes curing too (#3429).
pub fn a_no_ai_zombie_villager_still_cures() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists()
    // rust: || !root.join("movement-properties.nbt").exists()
    // rust: {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = crate::blocks::BlockFacts::load(&root, registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let data = super::super::MobData::load(&root, &facts);
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let items = crate::items::Items::load(
    // rust: &root,
    // rust: registry,
    // rust: &facts,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = std::sync::Arc::new(crate::collisions::load(&root, registry).unwrap());
    // rust: let suffocation =
    // rust: crate::mobs::suffocation::bind(collision.clone(), &motion.causes_suffocation).unwrap();
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let world = crate::world::World::new(air, 0);
    // rust: let lid_openers = std::collections::HashMap::new();
    // rust: let w = MobWorld {
    // rust: teams: Default::default(),
    // rust: world: &world,
    // rust: registry,
    // rust: facts: &facts,
    // rust: fluid_tables: &motion.fluids,
    // rust: movement: &motion.blocks,
    // rust: collision: &collision,
    // rust: suffocation: &suffocation,
    // rust: data: &data,
    // rust: player: None,
    // rust: controlling_player_movement: None,
    // rust: nearest_player: None,
    // rust: others: &[],
    // rust: dragon: None,
    // rust: leash_boats: &[],
    // rust: others_grid: None,
    // rust: others_index: None,
    // rust: others_villagers: None,
    // rust: daylight: true,
    // rust: monsters_burn: false,
    // rust: game_time: 1000,
    // rust: day_time: 18000,
    // rust: raining: false,
    // rust: thundering: false,
    // rust: nether: false,
    // rust: block_tags: &items.block_tags,
    // rust: landing: &motion.landing,
    // rust: biomes: &biomes,
    // rust: mob_griefing: true,
    // rust: universal_anger: false,
    // rust: mob_drops: true,
    // rust: max_entity_cramming: 24,
    // rust: difficulty: super::super::spawning::LocalDifficulty::new(2, 18000, 0, 0.0),
    // rust: end: false,
    // rust: world_seed: 0,
    // rust: sea_level: 63,
    // rust: items: Some(&items),
    // rust: lid_openers: &lid_openers,
    // rust: mod_effects: None,
    // rust: border: None,
}
    // rust: for no_ai in [false, true] {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:zombie_villager"].clone());
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.5, 0.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.persistent = true;
    // rust: m.no_ai = no_ai;
    // rust: start_converting(&mut m, None, 3, &mut Vec::new());
    // rust: let mut level_random = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut ticks = 0;
    // rust: while ticks < 10 {
    // rust: let mut events = Vec::new();
    // rust: m.tick(&w, &mut level_random, &mut events);
    // rust: ticks += 1;
    // rust: if events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::CureZombieVillager { mob: 1 }))
    // rust: {
    // rust: break;
}
}
    // rust: assert!(
    // rust: ticks <= 3,
    // rust: "no_ai={no_ai}: the cure must finish within its 3 ticks, took {ticks}"
    // rust: );
}
}
pub fn no_cure_saves_minus_one() void {
}
    // rust: let mut map = Compound::new();
    // rust: put_cure(&mut map, None);
    // rust: assert_eq!(map.get(&"ConversionTime".into()), Some(&Tag::Int(-1)));
    // rust: assert_eq!(parse_cure(&Tag::Compound(map)), None);
}

pub fn starting_a_cure_broadcasts_even_when_silent_without_drawing_sound_randomness() void {
}
    // rust: for silent in [false, true] {
    // rust: let mut m = zombie_villager();
    // rust: m.silent = silent;
    // rust: m.add_effect("minecraft:weakness", 100, 0);
    // rust: let mut random = m.random.clone();
    // rust: let starter = Some([1, 2, 3, 4]);
    // rust: let mut events = Vec::new();

    // rust: start_converting(&mut m, starter, 4000, &mut events);

    // rust: assert_eq!(
    // rust: cure(&m),
    // rust: Some(&Cure {
    // rust: time: 4000,
    // rust: starter
    // rust: })
    // rust: );
    // rust: assert!(!m.has_effect("minecraft:weakness"));
    // rust: assert!(m.extra.effects.contains(&("minecraft:strength", 4000, 0)));
    // rust: assert_eq!(events.len(), 1);
    // rust: let MobEvent::EntityEvent { mob, event, at } = events[0] else {
    // rust: panic!("Starting a cure must broadcast an entity event");
}
    // rust: assert_eq!((mob, event, at), (42, 16, [1.25, 2.0, 3.75]));
    // rust: assert_eq!(m.random.next_long(), random.next_long());
}
}

pub fn cure_sound_draws_volume_before_pitch_at_eye_height() void {
}
    // rust: let mut m = zombie_villager();
    // rust: let Some(MobEvent::Sound(name, at, volume, pitch)) = cure_sound(&mut m) else {
    // rust: panic!("A non-silent zombie villager must play the cure sound");
}
    // rust: assert_eq!(name, "entity.zombie_villager.cure");
    // rust: assert_eq!(at, [1.25, 3.5, 3.75]);
        // The first two java.util.Random(0) floats, volume before pitch.
    // rust: assert_eq!(volume.to_bits(), 0x3fdd_905a);
    // rust: assert_eq!(pitch.to_bits(), 0x3f61_cb52);
    // rust: assert_eq!(m.random.next_float().to_bits(), 0x3e76_4f2c);
}

pub fn silent_or_other_mobs_do_not_play_the_cure_sound_or_draw_randomness() void {
}
    // rust: let mut silent = zombie_villager();
    // rust: silent.silent = true;
    // rust: let other = Mob::new(43, super::super::sensor_scan_tests::kind(), Vec3::ZERO, 0.0);
    // rust: for mut m in [silent, other] {
    // rust: let mut random = m.random.clone();
    // rust: assert!(cure_sound(&mut m).is_none());
    // rust: assert_eq!(m.random.next_long(), random.next_long());
}
}
}
