//! Transpiled from Horizon Rust crate
package horizon_client_beehive

import "core:fmt"
import "core:mem"
import "core:math"

// Beehives and bee nests (`BeehiveBlockEntity`): up to three bees stored as
// entity tags, let out when their time inside is up (never at night or in
// the rain, nor through a blocked front, unless the hive is emptied in an
// emergency), honey for every bee coming home with nectar. The host (the game
// or the mob AI probe) loads and adds the bees through [`HiveHost`].
    // rust: pub use crate::chunk::block_entity::{Beehive, Occupant};
// use crate::mobs::{Mob, Species, bee};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use horizon_world::nbt::{Compound, Tag};

MAX_OCCUPANTS :: 3
// `BeehiveBlockEntity.IGNORED_BEE_TAGS`: dropped from a bee going in, and
// again from the tag it comes out with.
    // rust: const IGNORED_BEE_TAGS: [&str; 25] = [
    // rust: "Air",
    // rust: "drop_chances",
    // rust: "equipment",
    // rust: "Brain",
    // rust: "CanPickUpLoot",
    // rust: "DeathTime",
    // rust: "fall_distance",
    // rust: "FallFlying",
    // rust: "Fire",
    // rust: "HurtTime",
    // rust: "LeftHanded",
    // rust: "Motion",
    // rust: "NoGravity",
    // rust: "OnGround",
    // rust: "PortalCooldown",
    // rust: "Pos",
    // rust: "Rotation",
    // rust: "sleeping_pos",
    // rust: "CannotEnterHiveTicks",
    // rust: "TicksSincePollination",
    // rust: "CropsGrownSincePollination",
    // rust: "hive_pos",
    // rust: "Passengers",
    // rust: "leash",
    // rust: "UUID",
    // rust: ];

// `BeehiveBlockEntity.BeeReleaseStatus`.
Release :: enum {
    HoneyDelivered,
    BeeReleased,
    Emergency,
}

// What a hive needs from the level it is in.
    // rust: pub trait HiveHost {
    // `level.getRandom()`.
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // `EnvironmentAttributes.BEES_STAY_IN_HIVE` at a position.
bees_stay_in_hive :: proc(self: ^Self, at: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // A non-empty collision shape at a block.
blocked :: proc(self: ^Self, at: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // `BlockState.setValue(HONEY_LEVEL, level)` on the hive.
set_honey_level :: proc(self: ^Self, at: [i32; 3], level: i32) {
}
    // `EntityType.loadEntityRecursive` (the tag has its `id` and a `Pos`):
    // a new entity, or `None` for anything but a `#beehive_inhabitors`.
load :: proc(self: ^Self, tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // `Level.addFreshEntity`.
add :: proc(self: ^Self, m: Mob) -> b {
    // Ported from Horizon
    return {}
}
sound :: proc(self: ^Self, name: ^'static str, at: [f64; 3]) {
}
}

strip_ignored :: proc(c: ^Compound) {
}
    // rust: for key in IGNORED_BEE_TAGS {
    // rust: c.remove(&key.into());
}
}
int :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
}
pos :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::IntArray(p)) if p.len() == 3 => Some([p[0], p[1], p[2]]),
    // rust: _ => None,
}
}

// The bee occupant's codec and constructors, over the data in `chunk::block_entity`.
    // rust: pub trait OccupantExt: Sized {
    // `Occupant.of`: the bee's saved tag without the ignored tags, staying
    // 2400 ticks with nectar, else 600.
of :: proc(tag: Tag) -> S {
    // Ported from Horizon
    return {}
}
    // `Occupant.create`: a worldgen nest's bee, a bare bee tag.
create :: proc(ticks_in_hive: i32) -> S {
    // Ported from Horizon
    return {}
}
has_nectar :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
to_nbt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
}
    // rust: impl OccupantExt for Occupant {
of :: proc(mut tag: Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: strip_ignored(c);
}
    // rust: let nectar = matches!(tag.get("HasNectar"), Some(Tag::Byte(v)) if *v != 0);
    // rust: Self {
    // rust: entity_data: tag,
    // rust: ticks_in_hive: 0,
    // rust: min_ticks_in_hive: if nectar { 2400 } else { 600 },
}
}
create :: proc(ticks_in_hive: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: entity_data: Tag::compound([("id", Tag::String("minecraft:bee".into()))]),
    // rust: ticks_in_hive,
    // rust: min_ticks_in_hive: 600,
}
}
has_nectar :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.entity_data.get("HasNectar"), Some(Tag::Byte(v)) if *v != 0)
}
from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let data = tag.get("entity_data")?;
    // rust: if !matches!(data, Tag::Compound(c) if c.contains_key(&"id".into())) {
    // rust: return None;
}
    // rust: Some(Self {
    // rust: entity_data: data.clone(),
    // rust: ticks_in_hive: int(tag.get("ticks_in_hive"))?,
    // rust: min_ticks_in_hive: int(tag.get("min_ticks_in_hive"))?,
    // rust: })
}
to_nbt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([
    // rust: ("entity_data", self.entity_data.clone()),
    // rust: ("ticks_in_hive", Tag::Int(self.ticks_in_hive)),
    // rust: ("min_ticks_in_hive", Tag::Int(self.min_ticks_in_hive)),
    // rust: ])
}
}

// `BeehiveBlockEntity`'s behaviour, over the data in `chunk::block_entity`.
    // rust: pub trait BeehiveExt: Sized {
full :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `loadAdditional`: `bees` (all or none, as the list codec reads them)
    // and `flower_pos`.
from_nbt :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // `saveAdditional`.
to_nbt :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // `addOccupant` (the bee's own tag, saved by the host): the hive keeps
    // the bee's flower, or now and then swaps its own for it. The host then
    // discards the bee.
    // rust: fn add_occupant(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: tag: Tag,
    // rust: bee_flower: Option<[i32; 3]>,
    // rust: host: &mut impl HiveHost,
    // rust: ) -> bool;
    // `serverTick`: the bees whose time is up come out, then the hive
    // hums now and then while it holds any. `honey` is the hive state's
    // honey level as the tick starts (`None` without the property);
    // `facing` its front.
    // rust: fn server_tick(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: facing: [i32; 2],
    // rust: honey: Option<i32>,
    // rust: host: &mut impl HiveHost,
    // rust: );
    // `releaseAllOccupants`: the ids of the bees let out.
    // rust: fn release_all(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: facing: [i32; 2],
    // rust: honey: Option<i32>,
    // rust: status: Release,
    // rust: host: &mut impl HiveHost,
    // rust: ) -> Vec<u32>;
}
    // rust: impl BeehiveExt for Beehive {
full :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.bees.len() == MAX_OCCUPANTS
}
from_nbt :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let bees = match tag.get("bees") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .map(Occupant::from_nbt)
    // rust: .collect::<Option<Vec<_>>>()
    // rust: .unwrap_or_default(),
    // rust: _ => Vec::new(),
}
    // rust: Self {
    // rust: bees,
    // rust: flower: pos(tag.get("flower_pos")),
}
}
to_nbt :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![(
    // rust: "bees",
    // rust: Tag::List(self.bees.iter().map(Occupant::to_nbt).collect()),
    // rust: )];
    // rust: if let Some(f) = self.flower {
    // rust: out.push(("flower_pos", Tag::IntArray(f.to_vec())));
}
    // rust: out
}
    // rust: fn add_occupant(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: tag: Tag,
    // rust: bee_flower: Option<[i32; 3]>,
    // rust: host: &mut impl HiveHost,
    // rust: ) -> bool {
    // rust: if self.bees.len() >= MAX_OCCUPANTS {
    // rust: return false;
}
    // rust: self.bees.push(Occupant::of(tag));
    // rust: if let Some(f) = bee_flower
    // rust: && (self.flower.is_none() || host.random().next_boolean())
    // rust: {
    // rust: self.flower = Some(f);
}
    // rust: let corner = at.map(f64::from);
    // rust: host.sound("block.beehive.enter", corner);
    // rust: true
}
    // rust: fn server_tick(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: facing: [i32; 2],
    // rust: honey: Option<i32>,
    // rust: host: &mut impl HiveHost,
    // rust: ) {
    // rust: let flower = self.flower;
    // rust: let mut i = 0;
    // rust: while i < self.bees.len() {
            // BeeData.tick: ticksInHive++ > minTicksInHive.
    // rust: let b = &mut self.bees[i];
    // rust: let up = b.ticks_in_hive > b.min_ticks_in_hive;
    // rust: b.ticks_in_hive += 1;
    // rust: if up {
    // rust: let status = if b.has_nectar() {
    // rust: Release::HoneyDelivered
    // rust: } else {
    // rust: Release::BeeReleased
}
    // rust: let occupant = b.clone();
    // rust: if release(host, at, facing, honey, &occupant, status, flower).is_some() {
    // rust: self.bees.remove(i);
    // rust: continue;
}
}
    // rust: i += 1;
}
    // rust: if !self.bees.is_empty() && host.random().next_double() < 0.005 {
    // rust: let hum = [
    // rust: f64::from(at[0]) + 0.5,
    // rust: f64::from(at[1]),
    // rust: f64::from(at[2]) + 0.5,
    // rust: ];
    // rust: host.sound("block.beehive.work", hum);
}
}
    // rust: fn release_all(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: facing: [i32; 2],
    // rust: honey: Option<i32>,
    // rust: status: Release,
    // rust: host: &mut impl HiveHost,
    // rust: ) -> Vec<u32> {
    // rust: let flower = self.flower;
    // rust: let mut out = Vec::new();
    // rust: self.bees.retain(
    // rust: |b| match release(host, at, facing, honey, b, status, flower) {
    // rust: Some(id) => {
    // rust: out.extend(id);
    // rust: false
}
    // rust: None => true,
    // rust: },
    // rust: );
    // rust: out
}
}

// `releaseOccupant`: `None` while the bee stays in, else the id of the bee
// let out (`Some(None)` when the level refused it).
    // rust: fn release(
    // rust: host: &mut impl HiveHost,
    // rust: at: [i32; 3],
    // rust: facing: [i32; 2],
    // rust: honey: Option<i32>,
    // rust: occupant: &Occupant,
    // rust: status: Release,
    // rust: flower: Option<[i32; 3]>,
    // rust: ) -> Option<Option<u32>> {
    // rust: let emergency = status == Release::Emergency;
    // rust: if host.bees_stay_in_hive(at) && !emergency {
    // rust: return None;
}
    // rust: let blocked = host.blocked([at[0] + facing[0], at[1], at[2] + facing[1]]);
    // rust: if blocked && !emergency {
    // rust: return None;
}
    // Occupant.createEntity: the tag without the ignored tags.
    // rust: let mut tag = occupant.entity_data.clone();
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: strip_ignored(c);
    // rust: let center = [at[0], at[1], at[2]].map(|v| Tag::Double((f64::from(v) + 0.5).to_bits()));
    // rust: c.insert("Pos".into(), Tag::List(center.to_vec()));
}
    // rust: let mut m = host.load(&tag)?;
    // rust: m.no_gravity = true;
    // rust: if m.species() == Species::Bee {
    // rust: bee::set_hive(&mut m, Some(at));
        // setBeeReleaseData: the time inside counts towards growing up and
        // away from love.
    // rust: let ticks = occupant.ticks_in_hive;
    // rust: if !m.extra.age_locked {
    // rust: let age = m.extra.age;
    // rust: m.extra.age = if age < 0 {
    // rust: (age + ticks).min(0)
    // rust: } else if age > 0 {
    // rust: (age - ticks).max(0)
    // rust: } else {
    // rust: age
}
}
    // rust: m.extra.in_love = (m.extra.in_love - ticks).max(0);
    // rust: if let Some(f) = flower
    // rust: && bee::get(&m).is_none_or(|b| b.flower.is_none())
    // rust: && host.random().next_float() < 0.9
    // rust: {
    // rust: bee::set_flower(&mut m, Some(f));
}
    // rust: if status == Release::HoneyDelivered {
    // rust: bee::drop_off_nectar(&mut m);
    // rust: if let Some(level) = honey.filter(|&l| l < 5) {
    // rust: let mut increase = if host.random().next_int_bound(100).unwrap_or(1) == 0 {
    // rust: 2
    // rust: } else {
    // rust: 1
}
    // rust: if level + increase > 5 {
    // rust: increase -= 1;
}
    // rust: host.set_honey_level(at, level + increase);
}
}
    // rust: let delta = if blocked {
    // rust: 0.0
    // rust: } else {
    // rust: 0.55 + f64::from(m.width() / 2.0)
}
    // rust: let p = horizon_core::geometry::Vec3::new(
    // rust: f64::from(at[0]) + 0.5 + delta * f64::from(facing[0]),
    // rust: f64::from(at[1]) + 0.5 - f64::from(m.height() / 2.0),
    // rust: f64::from(at[2]) + 0.5 + delta * f64::from(facing[1]),
    // rust: );
    // rust: m.position = p;
    // rust: m.previous = p;
}
    // rust: host.sound(
    // rust: "block.beehive.exit",
    // rust: [
    // rust: f64::from(at[0]) + 0.5,
    // rust: f64::from(at[1]) + 0.5,
    // rust: f64::from(at[2]) + 0.5,
    // rust: ],
    // rust: );
    // rust: let id = m.id;
    // rust: Some(host.add(m).then_some(id))
}

// `CampfireBlock.isSmokeyPos`: a lit campfire up to five blocks below,
// unless a block whose collision crosses the smoke's centre post comes
// first (a lit campfire right under that block still counts).
smokey :: proc(w: ^crate::mobs::MobWorld, at: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let lit = |y: i32| {
    // rust: w.has_tag("minecraft:campfires", w.block_name(at[0], y, at[2]))
    // rust: && w.prop(at[0], y, at[2], "lit") == Some("true")
}
    // rust: for i in 1..=5 {
    // rust: let y = at[1] - i;
    // rust: if lit(y) {
    // rust: return true;
}
        // SHAPE_VIRTUAL_POST: Block.column(4, 0, 16), the middle quarter.
    // rust: let (x0, z0) = (f64::from(at[0]), f64::from(at[2]));
    // rust: let blocked = w.block_collision_boxes(at[0], y, at[2]).iter().any(|b| {
    // rust: let (min, max) = (b.min_position(), b.max_position());
    // rust: min.x < x0 + 0.625 && max.x > x0 + 0.375 && min.z < z0 + 0.625 && max.z > z0 + 0.375
    // rust: });
    // rust: if blocked {
    // rust: return lit(y - 1);
}
}
    // rust: false
}

// `HorizontalDirectionalBlock.FACING` as an x/z step.
facing_step :: proc(facing: Maybe(string)) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match facing {
    // rust: Some("south") => [0, 1],
    // rust: Some("west") => [-1, 0],
    // rust: Some("east") => [1, 0],
    // rust: _ => [0, -1],
}
}

    // rust: mod tests {
//     use super::*;

nbt_round_trips_in_vanilla_order :: proc() {
}
    // rust: let tag = Tag::compound([
    // rust: (
    // rust: "bees",
    // rust: Tag::List(vec![
    // rust: Occupant::create(37).to_nbt(),
    // rust: Occupant::create(0).to_nbt(),
    // rust: ]),
    // rust: ),
    // rust: ("flower_pos", Tag::IntArray(vec![1, -60, 3])),
    // rust: ]);
    // rust: let hive = Beehive::from_nbt(&tag);
    // rust: assert_eq!(hive.bees.len(), 2);
    // rust: assert_eq!(hive.bees[0].ticks_in_hive, 37);
    // rust: assert_eq!(hive.flower, Some([1, -60, 3]));
    // rust: assert_eq!(Tag::compound(hive.to_nbt()), tag);
}

a_bad_bee_drops_the_whole_list :: proc() {
}
    // rust: let tag = Tag::compound([(
    // rust: "bees",
    // rust: Tag::List(vec![
    // rust: Occupant::create(1).to_nbt(),
    // rust: Tag::compound([("ticks_in_hive", Tag::Int(3))]),
    // rust: ]),
    // rust: )]);
    // rust: assert!(Beehive::from_nbt(&tag).bees.is_empty());
}

going_in_strips_the_ignored_tags :: proc() {
}
    // rust: let tag = Tag::compound([
    // rust: ("id", Tag::String("minecraft:bee".into())),
    // rust: ("UUID", Tag::IntArray(vec![1, 2, 3, 4])),
    // rust: ("Health", Tag::Float(10.0_f32.to_bits())),
    // rust: ("HasNectar", Tag::Byte(1)),
    // rust: ("hive_pos", Tag::IntArray(vec![0, 0, 0])),
    // rust: ]);
    // rust: let o = Occupant::of(tag);
    // rust: assert_eq!(o.min_ticks_in_hive, 2400);
    // rust: assert!(o.entity_data.get("UUID").is_none());
    // rust: assert!(o.entity_data.get("hive_pos").is_none());
    // rust: assert!(o.entity_data.get("Health").is_some());
}
}
