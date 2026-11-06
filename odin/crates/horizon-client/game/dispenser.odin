//! Transpiled from Horizon Rust crate
package horizon_client_dispenser

import "core:fmt"
import "core:mem"
import "core:math"

// Dispenser behaviours: `DispenserBlock.getDispenseMethod(..).dispense` with
// every `DispenseItemBehavior` registration of vanilla that Horizon has the
// entities for. A behaviour returns what is left in the slot and the level
// event it plays (`DefaultDispenseItemBehavior.dispense` then plays that
// event and the smoke animation, event 2000).
// use super::Game;
// use horizon_client::{
    // rust: Result,
    // rust: collisions::SceneCollisions,
    // rust: containers::BlockEntity,
    // rust: items::ItemStack,
    // rust: mobs::{Mob, Species, sulfur_cube},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: projectiles::{Projectile, ProjectileKind},
}
// Its old home, for mixin code that names it here.
    // rust: pub(super) use horizon_client::mod_api::NativeDispensed;
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::{
    // rust: fluid::FluidKind,
    // rust: level::{BucketContent, PlaceContext, PlaceOutcome},
    // rust: registry::BlockStateId,
}
// use std::sync::Arc;

    // rust: type Pos = (i32, i32, i32);

// The sound event of a plain click, a failed dispense and a launched projectile.
CLICK :: 1000
FAIL :: 1001
LAUNCH :: 1002

step :: proc(d: Direction) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::Down => [0, -1, 0],
    // rust: Direction::Up => [0, 1, 0],
    // rust: Direction::North => [0, 0, -1],
    // rust: Direction::South => [0, 0, 1],
    // rust: Direction::West => [-1, 0, 0],
    // rust: Direction::East => [1, 0, 0],
}
}
offset :: proc(p: Pos, d: Direction) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let s = step(d);
    // rust: (p.0 + s[0], p.1 + s[1], p.2 + s[2])
}
// `Direction.get3DDataValue`.
data_value :: proc(d: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::Down => 0,
    // rust: Direction::Up => 1,
    // rust: Direction::North => 2,
    // rust: Direction::South => 3,
    // rust: Direction::West => 4,
    // rust: Direction::East => 5,
}
}
// `Direction.toYRot` (vertical directions give 270 through `data2d = -1`).
y_rot :: proc(d: Direction) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::South => 0.0,
    // rust: Direction::West => 90.0,
    // rust: Direction::North => 180.0,
    // rust: Direction::East => 270.0,
    // rust: _ => 270.0,
}
}
// `DirectionalPlaceContext.getRotation`: `get2DDataValue() * 90`, so a
// vertical direction (`data2d = -1`) gives -90 where `toYRot` gives 270: the
// same horizontal facing, but the raw value a mod's placement hook reads.
place_rotation :: proc(d: Direction) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::Up | Direction::Down => -90.0,
    // rust: _ => y_rot(d),
}
}
block_box :: proc(p: Pos) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Aabb::new(
    // rust: Vec3::new(f64::from(p.0), f64::from(p.1), f64::from(p.2)),
    // rust: Vec3::new(f64::from(p.0 + 1), f64::from(p.1 + 1), f64::from(p.2 + 1)),
    // rust: )
}
overlaps :: proc(a: Aabb, b: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (a0, a1, b0, b1) = (
    // rust: a.min_position(),
    // rust: a.max_position(),
    // rust: b.min_position(),
    // rust: b.max_position(),
    // rust: );
    // rust: a0.x < b1.x && b0.x < a1.x && a0.y < b1.y && b0.y < a1.y && a0.z < b1.z && b0.z < a1.z
}
// `ItemStack.shrink(1)`; the slot is empty at zero.
shrink :: proc(mut stack: ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: stack.count -= 1;
    // rust: (stack.count > 0).then_some(stack)
}
// A dispenser's answer: the slot's new content and the level event played.
    // rust: type Dispensed = (Option<ItemStack>, i32);

// None keeps vanilla's behaviour; an explicit empty remainder consumes the stack.
mod_dispensed :: proc(answer: Maybe(NativeDispensed)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: answer.map(|(left, event)| (left.filter(|stack| stack.count > 0), event))
}

    // rust: thread_local! {
    // `OptionalDispenseItemBehavior.success` of the registered behaviours
    // that leave it unset on some paths (brush, TNT, honeycomb, chest).
    // Vanilla keeps one behaviour instance per item for the whole run, so
    // there the flag carries over from that item's previous dispense.
    // rust: static SUCCESS: std::cell::RefCell<std::collections::HashMap<&'static str, bool>> =
    // rust: std::cell::RefCell::new(std::collections::HashMap::new());
}
set_success :: proc(behaviour: ^'static str, success: bool) {
}
    // rust: SUCCESS.with(|s| s.borrow_mut().insert(behaviour, success));
}
// The level event `OptionalDispenseItemBehavior.playSound` plays for the flag.
optional_event :: proc(behaviour: ^'static str) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if SUCCESS.with(|s| s.borrow().get(behaviour).copied().unwrap_or(true)) {
    // rust: CLICK
    // rust: } else {
    // rust: FAIL
}
}

// Entities `getEntitiesOfClass(.., AABB(pos))` can find.
Target :: enum {
    Player,
    Mob(usize),
    Stand(usize),
}

// `RandomSource.create()`: the unseeded random an entity owns
// (`RandomSupport.generateUniqueSeed`). Draws of an entity's own random never
// touch the level's stream.
    // rust: pub(super) fn entity_random() -> LegacyRandom {
//     use std::sync::atomic::{AtomicI64, Ordering};
UNIQUIFIER :: AtomicI64::new(8_682_522_807_148_012)
STEP :: 1_181_783_497_276_652_981
    // seedUniquifier.updateAndGet(s -> s * STEP)
    // rust: let mut current = UNIQUIFIER.load(Ordering::Relaxed);
    // rust: let seed = loop {
    // rust: let next = current.wrapping_mul(STEP);
    // rust: match UNIQUIFIER.compare_exchange_weak(current, next, Ordering::Relaxed, Ordering::Relaxed)
    // rust: {
    // rust: Ok(_) => break next,
    // rust: Err(actual) => current = actual,
}
}
    // rust: let nanos = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as i64);
    // rust: LegacyRandom::new(seed ^ nanos)
}
// `new ItemEntity(level, x, y, z, stack)`'s motion, from the item's own random.
    // rust: pub(super) fn new_item_motion() -> [f64; 3] {
    // rust: let mut r = entity_random();
    // rust: let x = r.next_double() * 0.2 - 0.1;
    // rust: let z = r.next_double() * 0.2 - 0.1;
    // rust: [x, 0.2, z]
}

// `EquipmentSlot`.
    // rust: pub(super) enum Slot {
    // rust: MainHand,
    // rust: OffHand,
    // rust: Feet,
    // rust: Legs,
    // rust: Chest,
    // rust: Head,
    // rust: Body,
    // rust: Saddle,
}
    // rust: impl Slot {
    // rust: pub(super) fn from_name(name: &str) -> Option<Self> {
    // rust: Some(match name {
    // rust: "mainhand" => Self::MainHand,
    // rust: "offhand" => Self::OffHand,
    // rust: "feet" => Self::Feet,
    // rust: "legs" => Self::Legs,
    // rust: "chest" => Self::Chest,
    // rust: "head" => Self::Head,
    // rust: "body" => Self::Body,
    // rust: "saddle" => Self::Saddle,
    // rust: _ => return None,
    // rust: })
}
    // The player's armour array index (head, chest, legs, feet).
armor_index :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Head => Some(0),
    // rust: Self::Chest => Some(1),
    // rust: Self::Legs => Some(2),
    // rust: Self::Feet => Some(3),
    // rust: _ => None,
}
}
    // `ArmorStand` equipment index (mainhand, offhand, feet, legs, chest, head).
stand_index :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MainHand => Some(0),
    // rust: Self::OffHand => Some(1),
    // rust: Self::Feet => Some(2),
    // rust: Self::Legs => Some(3),
    // rust: Self::Chest => Some(4),
    // rust: Self::Head => Some(5),
    // rust: _ => None,
}
}
}

equine :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Horse
    // rust: | Species::Donkey
    // rust: | Species::Mule
    // rust: | Species::SkeletonHorse
    // rust: | Species::ZombieHorse
    // rust: | Species::Camel
    // rust: | Species::CamelHusk
    // rust: | Species::Llama
    // rust: | Species::TraderLlama
    // rust: )
}
// What a mob holds in a slot.
    // rust: pub(super) fn mob_slot_item(m: &Mob, slot: Slot) -> Option<Arc<str>> {
    // rust: let x = &m.extra;
    // rust: match slot {
    // rust: Slot::MainHand => x.main_hand.clone(),
    // rust: Slot::OffHand => x.off_hand.clone(),
    // rust: Slot::Feet => x.feet.clone(),
    // rust: Slot::Legs => x.legs.clone(),
    // rust: Slot::Chest => x.chest.clone(),
    // rust: Slot::Head => x.head.clone(),
    // rust: Slot::Body => x.body.clone(),
    // rust: Slot::Saddle => m.saddle_item().map(|s| s.item),
}
}
// `LivingEntity.canUseSlot` and its overrides.
mob_can_use_slot :: proc(m: ^Mob, slot: Slot) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let s = m.species();
    // rust: let grown = m.alive() && !m.is_baby();
    // rust: match s {
    // rust: Species::Pig | Species::Strider if slot == Slot::Saddle => grown,
    // rust: Species::Horse
    // rust: | Species::SkeletonHorse
    // rust: | Species::ZombieHorse
    // rust: | Species::Llama
    // rust: | Species::TraderLlama => true,
    // rust: _ if equine(s) && slot == Slot::Saddle => grown && m.extra.tame,
    // rust: _ if horizon_client::mobs::nautilus::is_nautilus(s)
    // rust: && matches!(slot, Slot::Saddle | Slot::Body) =>
    // rust: {
    // rust: grown && m.extra.tame
}
    // rust: Species::SulfurCube | Species::HappyGhast if slot == Slot::Body => grown,
    // rust: _ => true,
}
}
// `Mob.canDispenserEquipIntoSlot` and its overrides.
mob_can_dispenser_equip :: proc(m: ^Mob, slot: Slot) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let s = m.species();
    // rust: let loot = m.extra.pick_up_loot;
    // rust: match s {
    // rust: Species::Pig | Species::Strider => slot == Slot::Saddle || loot,
    // rust: _ if equine(s) => matches!(slot, Slot::Body | Slot::Saddle) && m.extra.tame || loot,
    // rust: _ if horizon_client::mobs::nautilus::is_nautilus(s) => {
    // rust: matches!(slot, Slot::Body | Slot::Saddle) || loot
}
    // rust: Species::SulfurCube | Species::HappyGhast => slot == Slot::Body,
    // rust: Species::Dolphin | Species::Panda | Species::Fox => slot == Slot::MainHand && loot,
    // rust: Species::Allay => false,
    // rust: _ => loot,
}
}
// `getEquipSound`: the saddle overrides of pigs, striders, horses, camels and nautili.
equip_sound :: proc(m: ^Mob, slot: Slot, default: Maybe(string)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if slot != Slot::Saddle {
    // rust: return default;
}
    // rust: let s = m.species();
    // rust: Some(match s {
    // rust: Species::Pig => "minecraft:entity.pig.saddle".into(),
    // rust: Species::Strider => "minecraft:entity.strider.saddle".into(),
    // rust: Species::Camel => "minecraft:entity.camel.saddle".into(),
    // rust: Species::CamelHusk => "minecraft:entity.camel_husk.saddle".into(),
    // rust: _ if equine(s) => "minecraft:entity.horse.saddle".into(),
    // rust: _ if horizon_client::mobs::nautilus::is_nautilus(s) => {
    // rust: if m.fluids.eye_in_water {
    // rust: "minecraft:item.nautilus_saddle_underwater_equip".into()
    // rust: } else {
    // rust: "minecraft:item.nautilus_saddle_equip".into()
}
}
    // rust: _ => return default,
    // rust: })
}
    // rust: pub(super) fn mob_set_slot(m: &mut Mob, slot: Slot, stack: ItemStack) {
    // rust: let item: Arc<str> = stack.item.clone();
    // rust: let x = &mut m.extra;
    // rust: match slot {
    // rust: Slot::MainHand => x.set_main_hand(Some(item)),
    // rust: Slot::OffHand => x.off_hand = Some(item),
    // rust: Slot::Feet => x.feet = Some(item),
    // rust: Slot::Legs => x.legs = Some(item),
    // rust: Slot::Chest => x.chest = Some(item),
    // rust: Slot::Head => x.head = Some(item),
    // rust: Slot::Body => x.body = Some(item),
    // rust: Slot::Saddle => m.set_saddle(Some(stack)),
}
}

    // rust: impl Game<'_> {
prop :: proc(self: ^Self, state: BlockStateId, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get(key)
    // rust: .cloned()
}
    // The same block with other properties (`withProperty`).
    // rust: pub(super) fn with_props(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: props: &[(&str, &str)],
    // rust: ) -> Option<BlockStateId> {
    // rust: let mut s = self.pack.assets.registry.state(state)?.clone();
    // rust: for (k, v) in props {
    // rust: s.properties.insert((*k).to_owned(), (*v).to_owned());
}
    // rust: self.pack.assets.registry.resolve(&s).ok()
}
block_at :: proc(self: ^Self, p: Pos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.world.block(p.0, p.1, p.2)
}
dispenser_block_name :: proc(self: ^Self, p: Pos) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.res.facts().get(self.block_at(p)).name.clone()
}
in_block_tag :: proc(self: ^Self, tag: string, block: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get(tag)
    // rust: .is_some_and(|s| s.contains(block))
}
water_at :: proc(self: ^Self, p: Pos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self.res.behaviours().fluid_kind(self.block_at(p)),
    // rust: FluidKind::Water | FluidKind::FlowingWater
    // rust: )
}
center :: proc(p: Pos) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: f64::from(p.0) + 0.5,
    // rust: f64::from(p.1) + 0.5,
    // rust: f64::from(p.2) + 0.5,
    // rust: ]
}
pos_of :: proc(p: Pos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BlockPos::new(p.0, p.1, p.2)
}

    // ---- level events (LevelEventHandler) ----

    // The dispenser level events: 1000 click, 1001 fail, 1002 launch, 1004
    // firework shoot, 1018 blaze shoot and 2000 smoke shot out of the front.
    // rust: pub(super) fn dispenser_event(&mut self, id: i32, pos: Pos, data: i32) {
    // rust: super::dispense_fixture::record(|| format!("L {id} {},{},{} {data}", pos.0, pos.1, pos.2));
    // rust: let c = Self::center(pos);
    // rust: match id {
    // rust: 1000 => self
    // rust: .audio
    // rust: .play("minecraft:block.dispenser.dispense", Some(c), 1.0, 1.0),
    // rust: 1001 => self
    // rust: .audio
    // rust: .play("minecraft:block.dispenser.fail", Some(c), 1.0, 1.2),
    // rust: 1002 => self
    // rust: .audio
    // rust: .play("minecraft:block.dispenser.launch", Some(c), 1.0, 1.2),
    // rust: 1004 => self
    // rust: .audio
    // rust: .play("minecraft:entity.firework_rocket.shoot", Some(c), 1.0, 1.2),
            // LevelEventHandler runs on the client: its pitch draws come from
            // the client level's random, never the server stream.
    // rust: 1018 => {
    // rust: let r = self.particles.random();
    // rust: let pitch = (r.next_float() - r.next_float()) * 0.2 + 1.0;
    // rust: self.audio
    // rust: .play("minecraft:entity.blaze.shoot", Some(c), 2.0, pitch);
}
    // rust: 1051 => {
    // rust: let pitch = 0.4 / (self.particles.random().next_float() * 0.4 + 0.8);
    // rust: self.audio
    // rust: .play("minecraft:entity.wind_charge.throw", Some(c), 0.5, pitch);
}
    // rust: 1049 => self
    // rust: .audio
    // rust: .play("minecraft:block.crafter.craft", Some(c), 1.0, 1.0),
    // rust: 1050 => self
    // rust: .audio
    // rust: .play("minecraft:block.crafter.fail", Some(c), 1.0, 1.0),
            // LevelEventHandler.shootParticles: smoke for dispensers, white
            // smoke out of a crafter's front.
    // rust: 2000 | 2010 => {
    // rust: let particle = if id == 2010 {
    // rust: ParticleType::WhiteSmoke
    // rust: } else {
    // rust: ParticleType::Smoke
}
    // rust: let s = match data {
    // rust: 0 => [0, -1, 0],
    // rust: 1 => [0, 1, 0],
    // rust: 2 => [0, 0, -1],
    // rust: 3 => [0, 0, 1],
    // rust: 4 => [-1, 0, 0],
    // rust: _ => [1, 0, 0],
}
    // rust: for _ in 0..10 {
    // rust: let r = self.particles.random();
    // rust: let pow = r.next_double() * 0.2 + 0.01;
    // rust: let (sx, sy, sz) = (f64::from(s[0]), f64::from(s[1]), f64::from(s[2]));
    // rust: let p = [
    // rust: f64::from(pos.0)
    // rust: + sx * 0.6
    // rust: + 0.5
    // rust: + sx * 0.01
    // rust: + (r.next_double() - 0.5) * sz * 0.5,
    // rust: f64::from(pos.1)
    // rust: + sy * 0.6
    // rust: + 0.5
    // rust: + sy * 0.01
    // rust: + (r.next_double() - 0.5) * sy * 0.5,
    // rust: f64::from(pos.2)
    // rust: + sz * 0.6
    // rust: + 0.5
    // rust: + sz * 0.01
    // rust: + (r.next_double() - 0.5) * sx * 0.5,
    // rust: ];
    // rust: let v = [
    // rust: sx * pow + r.next_gaussian() * 0.01,
    // rust: sy * pow + r.next_gaussian() * 0.01,
    // rust: sz * pow + r.next_gaussian() * 0.01,
    // rust: ];
    // rust: self.particles.add(&ParticleOptions::simple(particle), p, v);
}
}
    // rust: _ => {}
}
}

    // ---- DefaultDispenseItemBehavior ----

    // `DispenserBlock.getDispensePosition(source, scale, offset)`.
dispense_position :: proc(pos: Pos, facing: Direction, scale: f64, offset: [f64; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let s = step(facing);
    // rust: let c = Self::center(pos);
    // rust: Vec3::new(
    // rust: c[0] + scale * f64::from(s[0]) + offset[0],
    // rust: c[1] + scale * f64::from(s[1]) + offset[1],
    // rust: c[2] + scale * f64::from(s[2]) + offset[2],
    // rust: )
}
    // `DefaultDispenseItemBehavior.spawnItem` at `getDispensePosition`.
    // rust: pub(super) fn spawn_dispensed(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: accuracy: i32,
    // rust: ) {
    // rust: let s = step(facing);
    // rust: let p = Self::dispense_position(pos, facing, 0.7, [0.0; 3]);
    // rust: let mut at = [p.x, p.y, p.z];
    // rust: at[1] -= if s[1] != 0 { 0.125 } else { 0.156_25 };
    // rust: let r = &mut self.world.random;
    // rust: let pow = r.next_double() * 0.1 + 0.2;
    // rust: let spread = 0.017_227_5 * f64::from(accuracy);
    // rust: let v = [
    // rust: r.triangle(f64::from(s[0]) * pow, spread),
    // rust: r.triangle(0.2, spread),
    // rust: r.triangle(f64::from(s[2]) * pow, spread),
    // rust: ];
    // rust: self.spawn_item(stack, at, v, 0);
}
    // `DefaultDispenseItemBehavior.execute`: drop one item.
    // rust: fn default_execute(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: mut stack: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: stack.count -= 1;
    // rust: self.spawn_dispensed(pos, facing, one, 6);
    // rust: (stack.count > 0).then_some(stack)
}
    // Drop one item as DefaultDispenseItemBehavior does. For a dispenser hook:
    // return this remainder in its answer with `CLICK`; the caller plays the
    // answer's event and smoke once. A client, another dimension or an unloaded
    // chunk keeps the input stack unchanged. API 67.
    // rust: pub(super) fn native_dispense_default(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: if !(self.serving.is_some() || self.options.dedicated.is_some())
    // rust: || dimension != self.dim.id()
    // rust: || !self.world.chunks.contains_key(&(pos[0] >> 4, pos[2] >> 4))
    // rust: {
    // rust: return Some(stack);
}
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: self.default_execute((pos[0], pos[1], pos[2]), facing, stack)
}
    // `new DefaultDispenseItemBehavior().dispense(..)` including its events.
    // rust: pub(super) fn dispense_default(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: let left = self.default_execute(pos, facing, stack);
    // rust: self.dispenser_event(CLICK, pos, 0);
    // rust: self.dispenser_event(2000, pos, data_value(facing));
    // rust: left
}
    // `DefaultDispenseItemBehavior.consumeWithRemainder`: the remainder goes
    // into the dispenser (`insertItem`) or is dropped.
    // rust: fn consume_with_remainder(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: mut stack: ItemStack,
    // rust: remainder: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: stack.count -= 1;
    // rust: if stack.count == 0 {
    // rust: return Some(remainder);
}
    // rust: let mut rest = remainder;
    // rust: if let Some(entity) = self.world.block_entities.get_mut(&pos) {
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&rest.item)
    // rust: .map_or(64, |i| i.max_stack)
    // rust: .max(1);
    // rust: for cell in entity.slots_mut() {
    // rust: match cell {
    // rust: None => {
    // rust: let n = rest.count.min(max);
    // rust: *cell = Some(ItemStack {
    // rust: count: n,
    // rust: ..rest.clone()
    // rust: });
    // rust: rest.count -= n;
}
    // rust: Some(e) if e.same_item_same_components(&rest) => {
    // rust: let n = rest.count.min(max.saturating_sub(e.count));
    // rust: e.count += n;
    // rust: rest.count -= n;
}
    // rust: Some(_) => {}
}
    // rust: if rest.count == 0 {
    // rust: break;
}
}
}
    // rust: if rest.count > 0 {
    // rust: self.spawn_dispensed(pos, facing, rest, 6);
    // rust: self.dispenser_event(CLICK, pos, 0);
    // rust: self.dispenser_event(2000, pos, data_value(facing));
}
    // rust: Some(stack)
}
    // `ItemStack.hurtAndBreak(amount)` without an entity.
hurt_and_break :: proc(self: ^Self, mut stack: ItemStack, amount: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage);
    // rust: if max == 0 {
    // rust: return Some(stack);
}
    // rust: stack.damage += self.durability_loss(&stack, amount);
    // rust: if stack.damage >= max {
    // rust: return shrink(ItemStack { damage: 0, ..stack });
}
    // rust: Some(stack)
}

    // ---- the registry ----

    // `DispenserBlock.getDispenseMethod(..).dispense(source, stack)`: what the
    // slot holds afterwards.
    // rust: pub(super) fn dispense_item(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Option<ItemStack>> {
    // rust: let mut answer = None;
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: self.native_dispense_item(
    // rust: self.dim.id(),
    // rust: [pos.0, pos.1, pos.2],
    // rust: facing,
    // rust: &stack,
    // rust: &mut answer,
    // rust: );
}
    // rust: if let Some((left, event)) = mod_dispensed(answer) {
    // rust: if event == FAIL {
    // rust: self.native_block_failed_dispense(
    // rust: self.dim.id(),
    // rust: [pos.0, pos.1, pos.2],
    // rust: &stack.item,
    // rust: );
}
            // DefaultDispenseItemBehavior.dispense: playSound, then playAnimation;
            // a NOOP behaviour (event 0) plays neither.
    // rust: if event != 0 {
    // rust: self.dispenser_event(event, pos, 0);
    // rust: self.dispenser_event(2000, pos, data_value(facing));
}
    // rust: return Ok(left);
}
    // rust: let item = stack.item.to_string();
    // rust: let (left, event) = match item.as_str() {
    // rust: "minecraft:arrow"
    // rust: | "minecraft:tipped_arrow"
    // rust: | "minecraft:spectral_arrow"
    // rust: | "minecraft:egg"
    // rust: | "minecraft:blue_egg"
    // rust: | "minecraft:brown_egg"
    // rust: | "minecraft:snowball"
    // rust: | "minecraft:experience_bottle"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:firework_rocket"
    // rust: | "minecraft:fire_charge"
    // rust: | "minecraft:wind_charge" => self.dispense_projectile(pos, facing, stack),
    // rust: "minecraft:armor_stand" => self.dispense_armor_stand(pos, facing, stack),
    // rust: "minecraft:chest" => self.dispense_chest(pos, facing, stack),
    // rust: "minecraft:lava_bucket"
    // rust: | "minecraft:water_bucket"
    // rust: | "minecraft:powder_snow_bucket"
    // rust: | "minecraft:salmon_bucket"
    // rust: | "minecraft:cod_bucket"
    // rust: | "minecraft:pufferfish_bucket"
    // rust: | "minecraft:tropical_fish_bucket"
    // rust: | "minecraft:axolotl_bucket"
    // rust: | "minecraft:tadpole_bucket"
    // rust: | "minecraft:sulfur_cube_bucket" => self.dispense_filled_bucket(pos, facing, stack)?,
    // rust: "minecraft:bucket" => self.dispense_empty_bucket(pos, facing, stack)?,
    // rust: "minecraft:flint_and_steel" => self.dispense_flint_and_steel(pos, facing, stack)?,
    // rust: "minecraft:bone_meal" => self.dispense_bone_meal(pos, facing, stack)?,
    // rust: "minecraft:tnt" => self.dispense_tnt(pos, facing, stack),
    // rust: "minecraft:wither_skeleton_skull" => self.dispense_wither_skull(pos, facing, stack)?,
    // rust: "minecraft:carved_pumpkin" => self.dispense_carved_pumpkin(pos, facing, stack)?,
    // rust: "minecraft:glass_bottle" => self.dispense_glass_bottle(pos, facing, stack)?,
    // rust: "minecraft:glowstone" => self.dispense_glowstone(pos, facing, stack)?,
    // rust: "minecraft:shears" => self.dispense_shears(pos, facing, stack)?,
    // rust: "minecraft:brush" => self.dispense_brush(pos, facing, stack),
    // rust: "minecraft:honeycomb" => self.dispense_honeycomb(pos, facing, stack)?,
    // rust: "minecraft:potion" => self.dispense_potion(pos, facing, stack)?,
    // rust: _ if item.ends_with("shulker_box") => self.dispense_shulker_box(pos, facing, stack)?,
    // rust: _ if super::boats::any_boat_wood(&item).is_some() => {
    // rust: self.dispense_boat(pos, facing, stack)
}
    // rust: _ if super::minecarts::CartKind::from_id(&item).is_some() => {
    // rust: self.dispense_minecart(pos, facing, stack)
}
    // rust: _ => self.dispense_default_method(pos, facing, stack)?,
}
    // rust: if event == FAIL {
    // rust: self.native_block_failed_dispense(self.dim.id(), [pos.0, pos.1, pos.2], &item);
}
    // rust: self.dispenser_event(event, pos, 0);
    // rust: self.dispenser_event(2000, pos, data_value(facing));
    // rust: Ok(left)
}
    // `DispenserBlock.getDefaultDispenseMethod`: equipment, spawn eggs, or a drop.
    // rust: fn dispense_default_method(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let equippable = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.equip_slot.is_some());
    // rust: if equippable {
    // rust: let mut stack = stack;
    // rust: if self.dispense_equipment(pos, facing, &mut stack) {
    // rust: return Ok((Some(stack).filter(|s| s.count > 0), CLICK));
}
    // rust: return Ok((self.default_execute(pos, facing, stack), CLICK));
}
    // rust: let swallowable = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:sulfur_cube_swallowable")
    // rust: .is_some_and(|t| t.contains(&*stack.item));
    // rust: if swallowable {
    // rust: let front = offset(pos, facing);
    // rust: if self.sulfur_cube_swallow(front, &stack) {
    // rust: return Ok((shrink(stack), CLICK));
}
    // rust: return Ok((self.default_execute(pos, facing, stack), CLICK));
}
    // rust: if stack.item.ends_with("_spawn_egg") {
    // rust: return self.dispense_spawn_egg(pos, facing, stack);
}
    // rust: Ok((self.default_execute(pos, facing, stack), CLICK))
}

    // ---- entities ----

    // Entities whose box overlaps the block at `p`, in the order the level
    // added them (an entity section keeps insertion order; ids grow with it).
targets_at :: proc(self: ^Self, p: Pos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let block = block_box(p);
    // rust: let mut found: Vec<(u32, Target)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| !m.removed && overlaps(m.bounds(), block))
    // rust: .map(|(i, m)| (m.id, Target::Mob(i)))
    // rust: .collect();
    // rust: found.extend(
    // rust: self.armor_stands
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| overlaps(s.bounds(), block))
    // rust: .map(|(i, s)| (s.id, Target::Stand(i))),
    // rust: );
    // rust: found.sort_by_key(|(id, _)| *id);
    // rust: let mut out: Vec<Target> = found.into_iter().map(|(_, t)| t).collect();
    // rust: if let Some(v) = self.player_view()
    // rust: && v.alive
    // rust: && !self.spectator()
    // rust: && overlaps(v.bounds, block)
    // rust: {
    // rust: out.push(Target::Player);
}
    // rust: out
}
    // `EntityType.getYOffset(level, pos, false, box)`: [`Self::drop_offset_from`] without
    // `movedUp`.
    // rust: pub(super) fn drop_offset(&self, width: f64, height: f64, p: Pos) -> f64 {
    // rust: self.drop_offset_from(width, height, p, false)
}
    // `EntityType.getYOffset(level, pos, movedUp, box)`: the entity box set on
    // top of the block (`setPos(x + 0.5, y + 1, z + 0.5)`) falls one block
    // against the collision shapes overlapping that block, or, `moved_up`, two
    // blocks against those of the block and the one under it.
    // rust: pub(super) fn drop_offset_from(&self, width: f64, height: f64, p: Pos, moved_up: bool) -> f64 {
//         use horizon_world::{
    // rust: block_collision_scan::BlockCollisionScan, collision_context::CollisionContext,
}
    // rust: let h = width / 2.0;
    // rust: let (x, z) = (f64::from(p.0) + 0.5, f64::from(p.2) + 0.5);
    // rust: let y = f64::from(p.1) + 1.0;
    // rust: let entity = Aabb::new(
    // rust: Vec3::new(x - h, y, z - h),
    // rust: Vec3::new(x + h, y + height, z + h),
    // rust: );
    // rust: let cell = Aabb::new(
    // rust: Vec3::new(
    // rust: f64::from(p.0),
    // rust: f64::from(p.1) - if moved_up { 1.0 } else { 0.0 },
    // rust: f64::from(p.2),
    // rust: ),
    // rust: Vec3::new(
    // rust: f64::from(p.0) + 1.0,
    // rust: f64::from(p.1) + 1.0,
    // rust: f64::from(p.2) + 1.0,
    // rust: ),
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let mut amount = if moved_up { -2.0 } else { -1.0 };
        // Level.getCollisions(null, aabb): CollisionContext.empty().
    // rust: if let Ok(scan) = BlockCollisionScan::new(
    // rust: &mut scene,
    // rust: CollisionContext::empty(false),
    // rust: cell,
    // rust: false,
    // rust: 1_000_000,
    // rust: ) {
    // rust: for hit in scan.flatten() {
    // rust: amount = hit
    // rust: .shape
    // rust: .collide(horizon_core::geometry::Axis::Y, entity, amount);
}
}
    // rust: 1.0 + amount
}
    // `EntityType.spawn(.., pos, reason, tryMoveDown, false)` for a mob.
    // rust: pub(super) fn spawn_mob_at(&mut self, kind: &str, p: Pos, try_move_down: bool) -> Option<u32> {
    // rust: let name = if kind.contains(':') {
    // rust: kind.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{kind}")
}
        // Ender Dragons are simulated separately from `Mob` and therefore do
        // not have a mob-type registry entry for the generic dispenser path.
    // rust: if name == "minecraft:ender_dragon" {
            // `EntityType.getYOffset` uses the created entity's full 16 by 8
            // bounding box when the dispenser asks to move it down.
    // rust: let y_off = if try_move_down {
    // rust: self.drop_offset(16.0, 8.0, p)
    // rust: } else {
    // rust: 0.0
}
    // rust: let at = [
    // rust: f64::from(p.0) + 0.5,
    // rust: f64::from(p.1) + y_off,
    // rust: f64::from(p.2) + 0.5,
    // rust: ];
    // rust: return self.spawn_dragon_spawned(at);
}
    // rust: let t = self.res.mob_types().get(&name)?.clone();
    // rust: let y_off = if try_move_down {
    // rust: self.drop_offset(t.width, t.height, p)
    // rust: } else {
    // rust: 0.0
}
    // rust: let at = [
    // rust: f64::from(p.0) + 0.5,
    // rust: f64::from(p.1) + y_off,
    // rust: f64::from(p.2) + 0.5,
    // rust: ];
    // rust: let id = self.spawn_mob(&name, at, true)?;
        // finalizeSpawn's riders (chicken jockeys, spider jockeys...) come
        // with a dispensed mob as with any spawn that is not natural.
    // rust: self.spawn_jockeys(id, false);
    // rust: Some(id)
}
    // `EquipmentDispenseItemBehavior.dispenseEquipment`: the first living
    // entity in front that `canEquipWithDispenser` gets one of the item.
dispense_equipment :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(info) = self.items().get(&stack.item) else {
    // rust: return false;
}
    // rust: let (Some(slot), true) = (
    // rust: info.equip_slot.as_deref().and_then(Slot::from_name),
    // rust: info.equip_dispensable,
    // rust: ) else {
    // rust: return false;
}
    // rust: let allowed = info.equip_allowed.clone();
        // Equippable.equipSound defaults to the generic armour sound.
    // rust: let sound = info
    // rust: .equip_sound
    // rust: .clone()
    // rust: .or_else(|| Some("minecraft:item.armor.equip_generic".into()));
    // rust: let front = offset(pos, facing);
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: let allows = |id: &str| allowed.as_ref().is_none_or(|a| a.contains(id));
        // LivingEntity.canEquipWithDispenser: alive, the slot usable, the
        // item's allowed entities, the slot empty and the dispenser rule.
    // rust: let target = self.targets_at(front).into_iter().find(|t| match *t {
            // Player.canUseSlot: every slot; the armour and the off hand are
            // the ones an equippable item can reach.
    // rust: Target::Player => {
    // rust: allows("minecraft:player")
    // rust: && match slot {
    // rust: Slot::OffHand => self.offhand.is_none(),
    // rust: _ => slot.armor_index().is_some_and(|i| self.armor[i].is_none()),
}
}
    // rust: Target::Stand(i) => slot.stand_index().is_some_and(|s| {
    // rust: allows("minecraft:armor_stand") && self.armor_stands[i].equipment[s].is_none()
    // rust: }),
    // rust: Target::Mob(i) => {
    // rust: let m = &self.mobs[i];
    // rust: m.alive()
    // rust: && mob_can_use_slot(m, slot)
    // rust: && allows(&m.kind.id)
    // rust: && mob_slot_item(m, slot).is_none()
    // rust: && mob_can_dispenser_equip(m, slot)
}
    // rust: });
    // rust: let Some(target) = target else {
    // rust: return false;
}
    // rust: stack.count -= 1;
        // setItemSlot: onEquipItem plays the equip sound and the equip event.
    // rust: let (at, sound) = match target {
    // rust: Target::Player => {
                // Player.setItemSlot: onEquipItem plays the sound and the event.
    // rust: let name = match slot.armor_index() {
    // rust: Some(i) => {
    // rust: self.armor[i] = Some(one.clone());
    // rust: ["head", "chest", "legs", "feet"][i]
}
    // rust: None => {
    // rust: self.offhand = Some(one.clone());
    // rust: "offhand"
}
}
    // rust: self.player_equipped(name, Some(&one));
    // rust: self.apply_equipment();
    // rust: self.native_block_dispense_armor(
    // rust: self.dim.id(),
    // rust: [pos.0, pos.1, pos.2],
    // rust: &stack.item,
    // rust: "player",
    // rust: );
    // rust: return true;
}
    // rust: Target::Stand(i) => {
    // rust: let stand = &mut self.armor_stands[i];
    // rust: if let Some(s) = slot.stand_index() {
    // rust: stand.equipment[s] = Some(one);
}
    // rust: (Some(stand.position), sound)
}
    // rust: Target::Mob(i) => {
    // rust: let m = &mut self.mobs[i];
    // rust: mob_set_slot(m, slot, one);
                // setGuaranteedDrop / setPersistenceRequired.
    // rust: m.persistent = true;
    // rust: let sound = if m.silent {
    // rust: None
    // rust: } else {
    // rust: equip_sound(m, slot, sound)
}
    // rust: (Some(m.position), sound)
}
}
    // rust: if let Some(at) = at {
    // rust: if let Some(sound) = sound {
    // rust: self.audio.play(&sound, Some([at.x, at.y, at.z]), 1.0, 1.0);
}
    // rust: let who = match target {
    // rust: Target::Mob(i) => Some(horizon_client::mobs::Who::Mob(self.mobs[i].id)),
    // rust: Target::Player | Target::Stand(_) => None,
}
    // rust: let ctx = self.who_context(who, None);
    // rust: self.post_game_event("minecraft:equip", [at.x, at.y, at.z], ctx);
}
    // rust: self.native_block_dispense_armor(
    // rust: self.dim.id(),
    // rust: [pos.0, pos.1, pos.2],
    // rust: &stack.item,
    // rust: match target {
    // rust: Target::Stand(_) => "armor_stand",
    // rust: Target::Mob(_) => "mob",
    // rust: Target::Player => "player",
    // rust: },
    // rust: );
    // rust: true
}
    // After `EntityType.spawn` / `MobBucketItem.spawn`: `mob.playAmbientSound()`.
mob_ambient :: proc(self: ^Self, id: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.dragon_spawn_ambient(id) {
    // rust: return Ok(());
}
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: return Ok(());
}
    // rust: let mut m = self.mobs.remove(i);
    // rust: let mut events = Vec::new();
    // rust: {
    // rust: let w = self.mob_world_base(&[]);
    // rust: horizon_client::mobs::ai::ambient_sound(&mut m, &w, &mut events);
}
    // rust: self.mobs.insert(i, m);
    // rust: self.handle_mob_events(events)
}
    // A mob a bucket emptied: `setFromBucket` keeps it, then it calls out.
    // Fish and axolotls carry the flag itself (saved as `FromBucket`, read by
    // `requiresCustomPersistence`); the others stay persistent instead.
    // rust: pub(super) fn mob_placed(&mut self, id: u32) -> Result<()> {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: if matches!(
    // rust: m.species(),
    // rust: Species::Cod
    // rust: | Species::Salmon
    // rust: | Species::Pufferfish
    // rust: | Species::TropicalFish
    // rust: | Species::Axolotl
    // rust: ) {
    // rust: m.extra.from_bucket = true;
    // rust: } else {
    // rust: m.persistent = true;
}
}
    // rust: self.mob_ambient(id)
}
    // rust: fn dispense_spawn_egg(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let kind = stack.item.trim_end_matches("_spawn_egg").to_owned();
    // rust: let front = offset(pos, facing);
    // rust: let Some(id) = self.spawn_mob_at(&kind, front, facing != Direction::Up) else {
    // rust: return Ok((Some(stack), CLICK));
}
        // EntityType.create: `finalizeSpawn` first, the egg's components after.
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: horizon_client::entity_nbt::apply_item_components(m, &stack);
}
        // EntityType.updateCustomEntityTag: a configured egg
        // (`/give @s pig_spawn_egg[minecraft:entity_data={…}]`) spawns the mob
        // it describes from a dispenser too, not only from a player's hand.
    // rust: self.apply_spawn_egg_entity_data(id, &stack);
    // rust: self.mob_ambient(id)?;
        // SpawnEggItemBehavior: the entity was placed by the dispenser.
    // rust: self.post_block_game_event("minecraft:entity_place", [pos.0, pos.1, pos.2], None, None);
    // rust: Ok((shrink(stack), CLICK))
}

    // ---- ProjectileDispenseBehavior ----

dispense_projectile :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let item = stack.item.to_string();
    // rust: let s = step(facing);
    // rust: let dir = [f64::from(s[0]), f64::from(s[1]), f64::from(s[2])];
        // ProjectileItem.DispenseConfig per item: position, uncertainty, power, event.
    // rust: let (at, uncertainty, power, event) = match item.as_str() {
    // rust: "minecraft:firework_rocket" => (
    // rust: Self::dispense_position(pos, facing, 0.500_009_999_999_747_4, [0.0; 3]),
    // rust: 1.0,
    // rust: 0.5,
    // rust: 1004,
    // rust: ),
    // rust: "minecraft:fire_charge" => (
    // rust: Self::dispense_position(pos, facing, 1.0, [0.0; 3]),
    // rust: 6.666_666_5,
    // rust: 1.0,
    // rust: 1018,
    // rust: ),
    // rust: "minecraft:wind_charge" => (
    // rust: Self::dispense_position(pos, facing, 1.0, [0.0; 3]),
    // rust: 6.666_666_5,
    // rust: 1.0,
    // rust: 1051,
    // rust: ),
    // rust: "minecraft:experience_bottle"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion" => (
    // rust: Self::dispense_position(pos, facing, 0.7, [0.0, 0.1, 0.0]),
    // rust: 3.0,
    // rust: 1.375,
    // rust: LAUNCH,
    // rust: ),
    // rust: _ => (
    // rust: Self::dispense_position(pos, facing, 0.7, [0.0, 0.1, 0.0]),
    // rust: 6.0,
    // rust: 1.1,
    // rust: LAUNCH,
    // rust: ),
}
    // rust: self.shoot_projectile_item(at, dir, &stack, power, uncertainty);
    // rust: (shrink(stack), event)
}

    // `ProjectileItem.asProjectile` and `Projectile.spawnProjectileUsingShoot`:
    // one of `stack` fired from `at` along `dir`.
    // rust: pub(super) fn shoot_projectile_item(
    // rust: &mut self,
    // rust: at: Vec3,
    // rust: dir: [f64; 3],
    // rust: stack: &ItemStack,
    // rust: power: f32,
    // rust: uncertainty: f32,
    // rust: ) {
    // rust: let item = stack.item.to_string();
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
        // Projectile.shoot spreads the shot with the projectile's own random.
    // rust: let mut own = entity_random();
    // rust: match item.as_str() {
    // rust: "minecraft:experience_bottle"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion" => {
    // rust: let mut shot = Projectile::new(ProjectileKind::Snowball, at, None);
    // rust: shot.shoot(&mut own, dir, power, uncertainty);
    // rust: self.launch_thrown(one, at, shot.velocity, None);
}
    // rust: "minecraft:firework_rocket" => {
    // rust: let mut shot = Projectile::new(ProjectileKind::Snowball, at, None);
    // rust: shot.shoot(&mut own, dir, power, uncertainty);
    // rust: self.launch_angled_rocket(at, shot.velocity, &one, None);
}
    // rust: _ => {
    // rust: let kind = match item.as_str() {
    // rust: "minecraft:arrow" => ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: "minecraft:spectral_arrow" => ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: Some(("minecraft:glowing", 200)),
    // rust: },
    // rust: "minecraft:tipped_arrow" => ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: tipped_effect(stack),
    // rust: },
    // rust: "minecraft:fire_charge" | "minecraft:wind_charge" => {
                        // asProjectile aims with the level's random first; the
                        // shot along the facing then replaces that motion.
    // rust: let r = &mut self.world.random;
    // rust: let _ = (
    // rust: r.triangle(dir[0], 0.114_85),
    // rust: r.triangle(dir[1], 0.114_85),
    // rust: r.triangle(dir[2], 0.114_85),
    // rust: );
    // rust: if item == "minecraft:wind_charge" {
    // rust: ProjectileKind::WindCharge
    // rust: } else {
    // rust: ProjectileKind::SmallFireball
}
}
    // rust: "minecraft:egg" | "minecraft:blue_egg" | "minecraft:brown_egg" => {
    // rust: ProjectileKind::Egg
}
    // rust: _ => ProjectileKind::Snowball,
}
    // rust: let mut shot = Projectile::new(kind, at, None);
                // ArrowItem/SpectralArrowItem.asProjectile: dispensed arrows
                // may be picked up.
    // rust: if let Some(a) = shot.arrow.as_mut() {
    // rust: a.set_item(&one);
    // rust: a.pickup = horizon_client::arrows::Pickup::Allowed;
}
    // rust: shot.shoot(&mut own, dir, power, uncertainty);
    // rust: self.add_projectile(shot);
}
}
}

    // ---- entities placed by items ----

dispense_armor_stand :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let front = offset(pos, facing);
    // rust: let foot = Vec3::new(
    // rust: f64::from(front.0) + 0.5,
    // rust: f64::from(front.1),
    // rust: f64::from(front.2) + 0.5,
    // rust: );
        // EntityType.create rolls a yaw from the level random before the stack config turns it.
    // rust: let _ = self.world.random.next_float();
    // rust: self.next_entity += 1;
    // rust: let mut stand =
    // rust: horizon_client::entities::ArmorStand::new(self.next_entity, foot, y_rot(facing));
        // Entity.applyImplicitComponents: a name from an anvil names the stand.
    // rust: if let Some(name) = stack.custom_name() {
    // rust: stand.custom_name = Some(horizon_client::text::Text::literal(name));
}
    // rust: self.world.modified.insert((front.0 >> 4, front.2 >> 4));
    // rust: self.armor_stands.push(stand);
    // rust: (shrink(stack), CLICK)
}
    // A tame donkey, mule or llama in front without a chest gets it.
dispense_chest :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let front = offset(pos, facing);
    // rust: for target in self.targets_at(front) {
    // rust: let Target::Mob(i) = target else { continue };
    // rust: let m = &mut self.mobs[i];
    // rust: if matches!(
    // rust: m.species(),
    // rust: Species::Donkey | Species::Mule | Species::Llama | Species::TraderLlama
    // rust: ) && m.alive()
    // rust: && m.extra.tame
    // rust: && !m.extra.chested
    // rust: {
    // rust: m.extra.chested = true;
    // rust: set_success("chest", true);
    // rust: return (shrink(stack), CLICK);
}
}
    // rust: (
    // rust: self.default_execute(pos, facing, stack),
    // rust: optional_event("chest"),
    // rust: )
}
    // `BoatDispenseItemBehavior`.
dispense_boat :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let Some((wood, chest)) =
    // rust: super::boats::any_boat_wood(&stack.item).map(|(w, c)| (w.to_owned(), c))
    // rust: else {
    // rust: return (self.dispense_default(pos, facing, stack), CLICK);
}
    // rust: let front = offset(pos, facing);
    // rust: let s = step(facing);
    // rust: let c = Self::center(pos);
        // Boat width 1.375.
    // rust: let outside = 0.5625 + 1.375 / 2.0;
    // rust: let (x, y, z) = (
    // rust: c[0] + f64::from(s[0]) * outside,
    // rust: c[1] + f64::from(s[1]) * f64::from(1.125f32),
    // rust: c[2] + f64::from(s[2]) * outside,
    // rust: );
    // rust: let below = (front.0, front.1 - 1, front.2);
    // rust: let y_offset = if self.water_at(front) {
    // rust: 1.0
    // rust: } else if self.res.facts().is_air(self.block_at(front)) && self.water_at(below) {
    // rust: 0.0
    // rust: } else {
    // rust: return (self.dispense_default(pos, facing, stack), CLICK);
}
    // rust: if !self.boat_models.has(&wood, chest) {
    // rust: return (self.dispense_default(pos, facing, stack), CLICK);
}
    // rust: self.next_entity += 1;
    // rust: let mut boat = super::boats::Boat::new(
    // rust: self.next_entity,
    // rust: wood.as_str().into(),
    // rust: Vec3::new(x, y + y_offset, z),
    // rust: y_rot(facing),
    // rust: );
    // rust: if chest {
    // rust: boat = boat.with_chest();
}
    // rust: self.world.modified.insert((front.0 >> 4, front.2 >> 4));
    // rust: self.boats.push(boat);
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: let boat = self.boats.last().unwrap();
    // rust: self.native_vehicle_create(
    // rust: boat.entity_type().as_str(),
    // rust: [boat.position.x, boat.position.y, boat.position.z],
    // rust: );
}
    // rust: (shrink(stack), CLICK)
}
    // `MinecartDispenseItemBehavior`.
dispense_minecart :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let Some(kind) = super::minecarts::CartKind::from_id(&stack.item) else {
    // rust: return (self.dispense_default(pos, facing, stack), CLICK);
}
    // rust: let s = step(facing);
    // rust: let c = Self::center(pos);
    // rust: let (x, base_y, z) = (
    // rust: c[0] + f64::from(s[0]) * 1.125,
    // rust: c[1].floor() + f64::from(s[1]),
    // rust: c[2] + f64::from(s[2]) * 1.125,
    // rust: );
    // rust: let front = offset(pos, facing);
    // rust: let y_offset = if let Some(rail) = self.rail(front.0, front.1, front.2) {
    // rust: if rail.shape.is_slope() { 0.6 } else { 0.1 }
    // rust: } else {
    // rust: if !self.res.facts().is_air(self.block_at(front)) {
    // rust: return (self.dispense_default(pos, facing, stack), CLICK);
}
    // rust: let below = (front.0, front.1 - 1, front.2);
    // rust: let Some(rail) = self.rail(below.0, below.1, below.2) else {
    // rust: return (self.dispense_default(pos, facing, stack), CLICK);
}
    // rust: if facing != Direction::Down && rail.shape.is_slope() {
    // rust: -0.4
    // rust: } else {
    // rust: -0.9
}
}
    // rust: self.next_entity += 1;
    // rust: let cart = super::minecarts::Minecart::new(
    // rust: self.next_entity,
    // rust: kind,
    // rust: Vec3::new(x, base_y + y_offset, z),
    // rust: );
    // rust: self.world.modified.insert((front.0 >> 4, front.2 >> 4));
    // rust: self.carts.push(cart);
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: let cart = self.carts.last().unwrap();
    // rust: self.native_vehicle_create(
    // rust: cart.kind.id(),
    // rust: [cart.position.x, cart.position.y, cart.position.z],
    // rust: );
}
    // rust: (shrink(stack), CLICK)
}

    // ---- buckets ----

    // The filled bucket behaviour: `DispensibleContainerItem.emptyContents`.
    // rust: fn dispense_filled_bucket(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let item = stack.item.to_string();
    // rust: let target = offset(pos, facing);
    // rust: let (content, sound, mob) =
    // rust: horizon_client::items::bucket_contents(&item).expect("filled bucket dispatcher");
    // rust: let target_pos = Self::pos_of(target);
    // rust: let emptied = self.with_level(|b, level, ticks| {
    // rust: b.bucket_empty(level, ticks, target_pos, None, content, sound, false, false)
    // rust: });
    // rust: self.process_level_events()?;
    // rust: if emptied.is_none() {
    // rust: return Ok((self.dispense_default(pos, facing, stack), CLICK));
}
    // rust: if self.dim == super::Dim::Nether
    // rust: && matches!(
    // rust: content,
    // rust: BucketContent::Fluid(FluidKind::Water) | BucketContent::MobWater
    // rust: )
    // rust: {
    // rust: self.evaporation_smoke([target.0, target.1, target.2]);
}
    // rust: if let Some(kind) = mob {
            // MobBucketItem.checkExtraContent: the mob (from the bucket, so
            // persistent) calls out, then ENTITY_PLACE.
    // rust: if let Some(id) = self.spawn_mob_at(kind, target, true) {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: horizon_client::entity_nbt::apply_item_components(m, &stack);
}
    // rust: self.mob_placed(id)?;
}
    // rust: self.post_block_game_event(
    // rust: "minecraft:entity_place",
    // rust: [target.0, target.1, target.2],
    // rust: None,
    // rust: None,
    // rust: );
}
    // rust: let bucket = ItemStack::new("minecraft:bucket", 1);
    // rust: Ok((
    // rust: self.consume_with_remainder(pos, facing, stack, bucket),
    // rust: CLICK,
    // rust: ))
}
    // The empty bucket: `BucketPickup.pickupBlock`.
    // rust: fn dispense_empty_bucket(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = Self::pos_of(offset(pos, facing));
    // rust: let picked =
    // rust: self.with_level(|b, level, ticks| b.bucket_pickup(level, ticks, target, false));
    // rust: self.process_level_events()?;
    // rust: match picked {
    // rust: Some(filled) => {
    // rust: self.post_block_game_event(
    // rust: "minecraft:fluid_pickup",
    // rust: [target.x, target.y, target.z],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: let filled = ItemStack::new(filled, 1);
    // rust: Ok((
    // rust: self.consume_with_remainder(pos, facing, stack, filled),
    // rust: CLICK,
    // rust: ))
}
    // rust: None => Ok((self.default_execute(pos, facing, stack), CLICK)),
}
}

    // ---- fire, bone meal and TNT ----

    // rust: fn dispense_flint_and_steel(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let target_pos = Self::pos_of(target);
    // rust: let state = self.block_at(target);
    // rust: let name = self.dispenser_block_name(target);
    // rust: let mut success = true;
        // tryIgniteExplosiveEntities: the first sulfur cube that can explode is primed.
    // rust: let cube = self.targets_at(target).into_iter().find_map(|t| match t {
    // rust: Target::Mob(i) => {
    // rust: let m = &self.mobs[i];
    // rust: (m.species() == Species::SulfurCube
    // rust: && m.alive()
    // rust: && !sulfur_cube::primed(m)
    // rust: && sulfur_cube::archetype(m).is_some_and(|a| a.explosion.is_some()))
    // rust: .then_some(i)
}
    // rust: _ => None,
    // rust: });
    // rust: if let Some(i) = cube {
            // primeTime(false): the fuse is lit only while TNT explodes; the
            // ignition counts either way.
    // rust: if self.ui.rules.bool("tnt_explodes") && sulfur_cube::prime(&mut self.mobs[i], false) {
    // rust: let m = &mut self.mobs[i];
    // rust: let (at, id) = (m.position, m.id);
    // rust: let mut events = Vec::new();
    // rust: m.voice("entity.tnt.primed", &mut events);
    // rust: self.handle_mob_events(events)?;
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:prime_fuse", [at.x, at.y, at.z], ctx);
}
    // rust: return Ok((self.hurt_and_break(stack, 1), CLICK));
}
    // rust: if self
    // rust: .with_level(|b, level, ticks| b.fire_can_be_placed_at(level, ticks, target_pos, facing))
    // rust: {
    // rust: if !self.native_block_ignite_allowed(target_pos, "flint_and_steel") {
    // rust: return Ok((Some(stack), CLICK));
}
    // rust: let fire =
    // rust: self.with_level(|b, level, ticks| b.fire_state_for(level, ticks, target_pos));
    // rust: self.level_set([target.0, target.1, target.2], fire)?;
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_place",
    // rust: [target.0, target.1, target.2],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: } else if self.can_light(state, &name) {
    // rust: if let Some(lit) = self.with_props(state, &[("lit", "true")]) {
    // rust: self.level_set([target.0, target.1, target.2], lit)?;
}
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: [target.0, target.1, target.2],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: } else if &*name == "minecraft:tnt" {
    // rust: if self.ui.rules.bool("tnt_explodes") && self.tnt_prime_allowed(target_pos) {
    // rust: self.spawn_primed_tnt(target_pos, false, None, None);
    // rust: self.with_level(|b, level, ticks| b.remove_block(level, ticks, target_pos, false));
    // rust: self.process_level_events()?;
    // rust: } else {
    // rust: success = false;
}
}
    // rust: let event = if success { CLICK } else { FAIL };
    // rust: if success {
    // rust: return Ok((self.hurt_and_break(stack, 1), event));
}
    // rust: Ok((Some(stack), event))
}
    // `CampfireBlock.canLight || CandleBlock.canLight || CandleCakeBlock.canLight`.
    // rust: pub(super) fn can_light(&self, state: BlockStateId, name: &str) -> bool {
    // rust: let lit = self.prop(state, "lit");
    // rust: let waterlogged = self.prop(state, "waterlogged");
    // rust: let dry_unlit = lit.as_deref() == Some("false") && waterlogged.as_deref() == Some("false");
    // rust: ((self.in_block_tag("minecraft:campfires", name)
    // rust: || self.in_block_tag("minecraft:candles", name))
    // rust: && dry_unlit)
    // rust: || (self.in_block_tag("minecraft:candle_cakes", name)
    // rust: && lit.as_deref() == Some("false"))
}
    // rust: fn dispense_bone_meal(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let target_pos = Self::pos_of(target);
    // rust: let grown = self.with_level(|b, level, ticks| {
    // rust: b.grow_crop(level, ticks, target_pos)
    // rust: || b.grow_water_plant(level, ticks, target_pos, None)
    // rust: });
    // rust: if grown {
    // rust: self.level_events
    // rust: .push(horizon_world::level::LevelEvent::LevelEvent {
    // rust: id: 1505,
    // rust: pos: target_pos,
    // rust: data: 15,
    // rust: });
}
    // rust: self.process_level_events()?;
    // rust: if grown {
    // rust: Ok((shrink(stack), CLICK))
    // rust: } else {
    // rust: Ok((Some(stack), FAIL))
}
}
dispense_tnt :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: if !self.ui.rules.bool("tnt_explodes") {
    // rust: set_success("tnt", false);
    // rust: return (Some(stack), FAIL);
}
    // rust: let front = offset(pos, facing);
    // rust: if self.sulfur_cube_swallow(front, &stack) {
    // rust: return (shrink(stack), optional_event("tnt"));
}
    // rust: let target = Self::pos_of(front);
    // rust: if !self.tnt_prime_allowed(target) {
    // rust: set_success("tnt", false);
    // rust: return (Some(stack), FAIL);
}
    // rust: set_success("tnt", true);
        // new PrimedTnt(level, x + 0.5, y, z + 0.5, null), its sound and ENTITY_PLACE.
    // rust: let rot = self.world.random.next_double() * f64::from(std::f32::consts::TAU);
    // rust: self.add_primed_tnt(target, rot, 80, None, None);
    // rust: self.audio.play(
    // rust: "minecraft:entity.tnt.primed",
    // rust: Some([
    // rust: f64::from(target.x) + 0.5,
    // rust: f64::from(target.y),
    // rust: f64::from(target.z) + 0.5,
    // rust: ]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.post_block_game_event(
    // rust: "minecraft:entity_place",
    // rust: [front.0, front.1, front.2],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: (shrink(stack), CLICK)
}

    // ---- blocks placed by dispensers ----

    // rust: fn dispense_wither_skull(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let free = self.res.facts().is_air(self.block_at(target))
    // rust: && target.1 >= self.world.bottom_y() + 2
    // rust: && self.ui.difficulty != 0
    // rust: && self.can_build_wither(target);
    // rust: if free {
    // rust: let rotation = match facing {
    // rust: Direction::Up | Direction::Down => 0,
    // rust: other => {
                    // RotationSegment.convertToSegment: the 2D data value * 4.
    // rust: (match other {
    // rust: Direction::South => 0,
    // rust: Direction::West => 1,
    // rust: Direction::North => 2,
    // rust: _ => 3,
    // rust: }) * 4
}
}
    // rust: let skull = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:wither_skeleton_skull")
    // rust: .and_then(|s| self.with_props(s, &[("rotation", &rotation.to_string())]));
    // rust: if let Some(skull) = skull {
    // rust: self.level_set([target.0, target.1, target.2], skull)?;
    // rust: if let Some(entity) = BlockEntity::for_block("minecraft:wither_skeleton_skull") {
    // rust: self.world.block_entities.insert(target, entity);
}
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_place",
    // rust: [target.0, target.1, target.2],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: self.check_wither_spawn([target.0, target.1, target.2])?;
    // rust: return Ok((shrink(stack), CLICK));
}
}
    // rust: let mut stack = stack;
    // rust: let equipped = self.dispense_equipment(pos, facing, &mut stack);
    // rust: Ok((
    // rust: Some(stack).filter(|s| s.count > 0),
    // rust: if equipped { CLICK } else { FAIL },
    // rust: ))
}
    // `WitherSkullBlock.getOrCreateWitherBase().find(level, pos)`: a soul
    // sand T for the skull row, in any orientation.
can_build_wither :: proc(self: ^Self, head: Pos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.find_wither_pattern(
    // rust: horizon_client::block_pattern::WITHER_BASE,
    // rust: [head.0, head.1, head.2],
    // rust: )
    // rust: .is_some()
}
    // rust: fn dispense_carved_pumpkin(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: if self.res.facts().is_air(self.block_at(target))
    // rust: && self.can_spawn_golem([target.0, target.1, target.2])
    // rust: {
    // rust: if let Some(pumpkin) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:carved_pumpkin")
    // rust: {
    // rust: let head = [target.0, target.1, target.2];
    // rust: self.set_golem_head(head, pumpkin)?;
    // rust: self.post_block_game_event("minecraft:block_place", head, None, None);
}
    // rust: return Ok((shrink(stack), CLICK));
}
    // rust: let mut stack = stack;
    // rust: let equipped = self.dispense_equipment(pos, facing, &mut stack);
    // rust: Ok((
    // rust: Some(stack).filter(|s| s.count > 0),
    // rust: if equipped { CLICK } else { FAIL },
    // rust: ))
}
    // `ShulkerBoxDispenseBehavior`: place it like a `DirectionalPlaceContext`.
    // rust: fn dispense_shulker_box(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let front = offset(pos, facing);
    // rust: let below_empty = self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.block_at((front.0, front.1 - 1, front.2)));
    // rust: let clicked_face = if below_empty { facing } else { Direction::Up };
    // rust: let ctx = PlaceContext {
    // rust: clicked_pos: Self::pos_of(front),
    // rust: face: clicked_face,
    // rust: hit: Vec3::new(
    // rust: f64::from(front.0) + 0.5,
    // rust: f64::from(front.1),
    // rust: f64::from(front.2) + 0.5,
    // rust: ),
    // rust: inside: false,
    // rust: yaw: place_rotation(facing),
    // rust: pitch: 0.0,
    // rust: sneaking: false,
    // rust: item: stack.item.to_string(),
    // rust: can_use_game_master_blocks: false,
}
        // DirectionalPlaceContext places at the front block or nowhere.
    // rust: if !self.with_level(|b, level, ticks| b.directional_can_place(level, ticks, &ctx)) {
    // rust: return Ok((Some(stack), FAIL));
}
    // rust: let outcome = self.with_level(|b, level, ticks| b.place_block(level, ticks, &ctx));
    // rust: let PlaceOutcome::Placed { pos: placed, state } = outcome else {
    // rust: self.process_level_events()?;
    // rust: return Ok((Some(stack), FAIL));
}
    // rust: let target = (placed.x, placed.y, placed.z);
    // rust: let state = self.apply_item_block_state([target.0, target.1, target.2], state, &stack)?;
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: if let Some(entity) = self.new_block_entity(&name) {
    // rust: self.world.block_entities.insert(target, entity);
    // rust: self.apply_placed_item([target.0, target.1, target.2], &stack, false);
}
    // rust: self.process_level_events()?;
    // rust: Ok((shrink(stack), CLICK))
}

    // ---- bottles, glowstone, shears, brush, honeycomb ----

    // rust: fn dispense_glass_bottle(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let state = self.block_at(target);
    // rust: let name = self.dispenser_block_name(target);
    // rust: let honey = self
    // rust: .prop(state, "honey_level")
    // rust: .and_then(|v| v.parse::<i32>().ok());
    // rust: if self.in_block_tag("minecraft:beehives", &name)
    // rust: && let Some(level) = honey
    // rust: && level >= 5
    // rust: {
            // releaseBeesAndResetHoneyLevel.
    // rust: if let Some(reset) = self.with_props(state, &[("honey_level", "0")]) {
    // rust: self.level_set([target.0, target.1, target.2], reset)?;
}
    // rust: self.dispenser_empty_hive(target, state);
    // rust: let bottle = ItemStack::new("minecraft:honey_bottle", 1);
    // rust: self.post_block_game_event("minecraft:fluid_pickup", [pos.0, pos.1, pos.2], None, None);
    // rust: return Ok((
    // rust: self.consume_with_remainder(pos, facing, stack, bottle),
    // rust: CLICK,
    // rust: ));
}
    // rust: if self.water_at(target) {
    // rust: let water = ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water");
    // rust: self.post_block_game_event("minecraft:fluid_pickup", [pos.0, pos.1, pos.2], None, None);
    // rust: return Ok((
    // rust: self.consume_with_remainder(pos, facing, stack, water),
    // rust: CLICK,
    // rust: ));
}
    // rust: Ok((self.default_execute(pos, facing, stack), FAIL))
}
    // rust: fn dispense_glowstone(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let state = self.block_at(target);
    // rust: if &*self.dispenser_block_name(target) == "minecraft:respawn_anchor" {
    // rust: let charge = self
    // rust: .prop(state, "charges")
    // rust: .and_then(|v| v.parse::<i32>().ok())
    // rust: .unwrap_or(0);
    // rust: if charge != 4 {
    // rust: if let Some(next) =
    // rust: self.with_props(state, &[("charges", &(charge + 1).to_string())])
    // rust: {
    // rust: self.level_set([target.0, target.1, target.2], next)?;
                    // RespawnAnchorBlock.charge: Context.of(null, newState).
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: [target.0, target.1, target.2],
    // rust: None,
    // rust: Some(next),
    // rust: );
}
    // rust: self.audio.play(
    // rust: "minecraft:block.respawn_anchor.charge",
    // rust: Some(Self::center(target)),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: return Ok((shrink(stack), CLICK));
}
    // rust: return Ok((Some(stack), FAIL));
}
    // rust: Ok((self.default_execute(pos, facing, stack), CLICK))
}
    // rust: fn dispense_shears(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let sheared = self.shear_beehive(target)? || self.shear_entity(target)?;
    // rust: if sheared {
    // rust: return Ok((self.hurt_and_break(stack, 1), CLICK));
}
    // rust: Ok((Some(stack), FAIL))
}
    // The bees of a hive a dispenser harvested come out (`BEE_RELEASED`:
    // not at night nor in the rain), through the front of its old state.
dispenser_empty_hive :: proc(self: ^Self, target: Pos, old: BlockStateId) {
}
    // rust: let facing = self.prop(old, "facing");
    // rust: self.empty_hive(
    // rust: [target.0, target.1, target.2],
    // rust: horizon_client::beehive::facing_step(facing.as_deref()),
    // rust: horizon_client::beehive::Release::BeeReleased,
    // rust: );
}
shear_beehive :: proc(self: ^Self, target: Pos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.block_at(target);
    // rust: let name = self.dispenser_block_name(target);
    // rust: let level = self
    // rust: .prop(state, "honey_level")
    // rust: .and_then(|v| v.parse::<i32>().ok());
    // rust: if !self.in_block_tag("minecraft:beehives", &name) || level.is_none_or(|l| l < 5) {
    // rust: return Ok(false);
}
    // rust: self.audio.play(
    // rust: "minecraft:block.beehive.shear",
    // rust: Some(Self::center(target)),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
        // BeehiveBlock.dropHoneycomb (harvest/beehive), then
        // releaseBeesAndResetHoneyLevel and the shear event.
    // rust: let p = [target.0, target.1, target.2];
    // rust: for stack in self.sequence_loot(
    // rust: "minecraft:harvest/beehive",
    // rust: "minecraft:harvest/beehive",
    // rust: None,
    // rust: ) {
    // rust: self.pop_resource(p, stack);
}
    // rust: if let Some(reset) = self.with_props(state, &[("honey_level", "0")]) {
    // rust: self.level_set(p, reset)?;
}
    // rust: self.dispenser_empty_hive(target, state);
    // rust: self.post_block_game_event("minecraft:shear", p, None, None);
    // rust: Ok(true)
}
    // `LootTable.getRandomItems` of `table` in the context of `parent`: the
    // draws come from `parent`'s server random sequence when it names one (a
    // nested `loot_table` entry shares its parent's context), else the level's.
    // rust: pub(super) fn sequence_loot(
    // rust: &mut self,
    // rust: parent: &str,
    // rust: table: &str,
    // rust: held: Option<&ItemStack>,
    // rust: ) -> Vec<ItemStack> {
    // rust: match world_items!(self).loot_sequence(parent) {
    // rust: Some(sequence) => {
    // rust: let random = self.rand_sequences.get(&sequence, self.level.seed);
    // rust: world_items!(self).loot_table_from(table, false, held, random)
}
    // rust: None => world_items!(self).loot_table(table, false, held, &mut self.world.random),
}
}
    // `Entity.spawnAtLocation(level, stack, offset)`: an item at the entity's
    // feet plus the offset, moving as `new ItemEntity` makes it.
    // rust: pub(super) fn spawn_at_location(
    // rust: &mut self,
    // rust: at: Vec3,
    // rust: y_offset: f64,
    // rust: stack: ItemStack,
    // rust: ) -> [f64; 3] {
    // rust: let v = new_item_motion();
    // rust: self.spawn_item(stack, [at.x, at.y + y_offset, at.z], v, 10);
    // rust: v
}
    // `Mob.convertTo(type, ConversionParams.single(this, false, false))`: a
    // new mob of `kind` in the same place (no spawn finalization, so no
    // random draws) keeps the name, flags, persistence and age; the old one
    // is discarded.
    // rust: pub(super) fn convert_mob(&mut self, index: usize, kind: &str) -> Option<u32> {
    // rust: let t = self.res.mob_types().get(kind).cloned()?;
    // rust: let (old_id, old_kind) = (
    // rust: self.mobs[index].id,
    // rust: super::native_hooks::mob_kind(&self.mobs[index]),
    // rust: );
        // LivingConversionEvent.Pre: a canceled conversion leaves the mob.
    // rust: let mut cancel = false;
    // rust: self.native_living_conversion_pre(old_id, &old_kind, kind, &mut cancel);
    // rust: if cancel {
    // rust: return None;
}
    // rust: let old = &self.mobs[index];
    // rust: self.next_entity += 1;
    // rust: let mut mob = Mob::new(self.next_entity, t, old.position, old.yaw);
    // rust: mob.previous = old.previous;
    // rust: mob.head_yaw = old.head_yaw;
    // rust: mob.body_yaw = old.body_yaw;
    // rust: mob.head_pitch = old.head_pitch;
    // rust: mob.persistent = old.persistent;
    // rust: mob.custom_name = old.custom_name.clone();
    // rust: mob.custom_name_text = old.custom_name_text.clone();
    // rust: mob.name_visible = old.name_visible;
    // rust: mob.invisible = old.invisible;
    // rust: mob.no_ai = old.no_ai;
    // rust: mob.silent = old.silent;
    // rust: mob.no_gravity = old.no_gravity;
    // rust: mob.invulnerable_flag = old.invulnerable_flag;
    // rust: mob.extra.age = if old.is_baby() { old.extra.age } else { 0 };
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
    // rust: let id = mob.id;
    // rust: self.mobs[index].removed = true;
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: self.native_entity_transform(old_id, &old_kind, id, kind);
    // rust: self.native_living_conversion_post(old_id, &old_kind, id, kind);
    // rust: Some(id)
}
    // `ShearsDispenseItemBehavior.tryShearEntity`: the first live, ready
    // `Shearable` in the block is sheared.
shear_entity :: proc(self: ^Self, target: Pos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let shears = ItemStack::new("minecraft:shears", 1);
    // rust: for t in self.targets_at(target) {
            // Entity.shearOffAllLeashConnections comes first, for any entity.
    // rust: if self.shear_off_leashes(t) {
    // rust: return Ok(true);
}
    // rust: let Target::Mob(i) = t else { continue };
    // rust: let m = &self.mobs[i];
    // rust: if !m.alive() {
    // rust: continue;
}
    // rust: let at = m.position;
    // rust: let entity_id = m.id;
    // rust: let kind = m.kind.id.clone();
    // rust: let sound_at = Some([at.x, at.y, at.z]);
    // rust: match m.species() {
    // rust: Species::SulfurCube if sulfur_cube::has_body(m) => {
                    // SulfurCube.shear: the swallowed block comes out at the
                    // passenger attachment, and nothing is swallowed for 5 s.
    // rust: let height = f64::from(m.height());
    // rust: let id = m.id;
    // rust: if let Some(body) = self.mobs[i].extra.body.take() {
    // rust: self.spawn_at_location(at, height, ItemStack::new(&body, 1));
}
                    // setItemSlot(BODY, EMPTY): an unequip.
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:unequip", [at.x, at.y, at.z], ctx);
    // rust: self.mobs[i].extra.ints[3] = sulfur_cube::PICKUP_TIMER;
    // rust: self.audio
    // rust: .play("minecraft:entity.sulfur_cube.eject", sound_at, 1.0, 1.0);
}
    // rust: Species::Sheep if !m.extra.sheared && !m.is_baby() => {
    // rust: let color =
    // rust: horizon_client::mobs::render::DYE_NAMES[m.extra.color as usize & 15];
    // rust: self.audio
    // rust: .play("minecraft:entity.sheep.shear", sound_at, 1.0, 1.0);
    // rust: let drops = self.sequence_loot(
    // rust: "minecraft:shearing/sheep",
    // rust: &format!("minecraft:shearing/sheep/{color}"),
    // rust: Some(&shears),
    // rust: );
    // rust: for stack in drops {
    // rust: for _ in 0..stack.count {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: self.spawn_at_location(at, 1.0, one);
                            // Sheep.shear nudges each item with the sheep's own random.
    // rust: let r = &mut self.mobs[i].random;
    // rust: let push = [
    // rust: f64::from((r.next_float() - r.next_float()) * 0.1),
    // rust: f64::from(r.next_float() * 0.05),
    // rust: f64::from((r.next_float() - r.next_float()) * 0.1),
    // rust: ];
    // rust: if let Some(item) = self.just_spawned_item() {
    // rust: item.velocity = Vec3::new(
    // rust: item.velocity.x + push[0],
    // rust: item.velocity.y + push[1],
    // rust: item.velocity.z + push[2],
    // rust: );
}
}
}
    // rust: self.mobs[i].extra.sheared = true;
}
    // rust: Species::Bogged if !m.extra.sheared => {
    // rust: let height = f64::from(m.height());
    // rust: self.audio
    // rust: .play("minecraft:entity.bogged.shear", sound_at, 1.0, 1.0);
    // rust: let drops = self.sequence_loot(
    // rust: "minecraft:shearing/bogged",
    // rust: "minecraft:shearing/bogged",
    // rust: Some(&shears),
    // rust: );
    // rust: for stack in drops {
    // rust: self.spawn_at_location(at, height, stack);
}
    // rust: self.mobs[i].extra.sheared = true;
}
    // rust: Species::SnowGolem if !m.extra.sheared => {
    // rust: let eye = m.eye_height();
    // rust: self.audio
    // rust: .play("minecraft:entity.snow_golem.shear", sound_at, 1.0, 1.0);
    // rust: self.mobs[i].extra.sheared = true;
    // rust: let drops = self.sequence_loot(
    // rust: "minecraft:shearing/snow_golem",
    // rust: "minecraft:shearing/snow_golem",
    // rust: Some(&shears),
    // rust: );
    // rust: for stack in drops {
    // rust: self.spawn_at_location(at, eye, stack);
}
}
                // CopperGolem.shear: the antenna's flower drops 1.5 up.
    // rust: Species::CopperGolem if self.golem_shearable(i) => {
    // rust: self.audio
    // rust: .play("minecraft:entity.copper_golem.shear", sound_at, 1.0, 1.0);
    // rust: let antenna = self.mobs[i].saddle_item();
    // rust: let id = self.mobs[i].id;
                    // setItemSlot(EQUIPMENT_SLOT_ANTENNA, EMPTY): an unequip.
    // rust: self.mobs[i].set_saddle(None);
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:unequip", [at.x, at.y, at.z], ctx);
    // rust: if let Some(antenna) = antenna {
    // rust: self.spawn_at_location(at, 1.5, antenna);
}
}
    // rust: Species::Mooshroom if !m.is_baby() => {
    // rust: let variant = if m.extra.variant == 1 { "brown" } else { "red" };
    // rust: let height = f64::from(m.height());
    // rust: self.audio
    // rust: .play("minecraft:entity.mooshroom.shear", sound_at, 1.0, 1.0);
                    // convertTo(COW): the cow takes its place, then the mushrooms drop.
                    // A canceled conversion (LivingConversionEvent.Pre) drops nothing.
    // rust: if self.convert_mob(i, "minecraft:cow").is_some() {
    // rust: self.mooshroom_shear_puff([at.x, at.y, at.z], height);
    // rust: let drops = self.sequence_loot(
    // rust: "minecraft:shearing/mooshroom",
    // rust: &format!("minecraft:shearing/mooshroom/{variant}"),
    // rust: Some(&shears),
    // rust: );
    // rust: for stack in drops {
    // rust: for _ in 0..stack.count {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: self.spawn_at_location(at, height, one);
}
}
}
}
    // rust: _ => continue,
}
    // rust: self.native_block_shear_entity(
    // rust: self.dim.id(),
    // rust: [target.0, target.1, target.2],
    // rust: entity_id,
    // rust: &kind,
    // rust: );
    // rust: self.post_block_game_event(
    // rust: "minecraft:shear",
    // rust: [target.0, target.1, target.2],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: return Ok(true);
}
    // rust: Ok(false)
}
    // `Entity.shearOffAllLeashConnections(null)`: the entity's own lead and
    // every lead held by it (within a 32 block box around its centre) drop;
    // a shear game event at the entity and a snip at its block follow.
shear_off_leashes :: proc(self: ^Self, t: Target) -> b {
    // Ported from Horizon
    return {}
}
//         use horizon_client::mobs::{Who, leash::Holder};
    // rust: let (holder, centre, own) = match t {
    // rust: Target::Mob(i) => {
    // rust: let m = &self.mobs[i];
    // rust: let b = m.bounds();
    // rust: (Holder::Mob(m.id), b.center(), Some(i))
}
    // rust: Target::Player => {
    // rust: let Some(v) = self.player_view() else {
    // rust: return false;
}
    // rust: (Holder::Player, v.bounds.center(), None)
}
    // rust: Target::Stand(_) => return false,
}
    // rust: let area = Aabb::new(centre, centre).inflate(Vec3::new(16.0, 16.0, 16.0));
    // rust: let mut leashed: Vec<(u32, usize)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| {
    // rust: !m.removed && m.extra.leash == Some(holder) && overlaps(m.bounds(), area)
    // rust: })
    // rust: .map(|(j, m)| (m.id, j))
    // rust: .collect();
    // rust: leashed.sort_unstable();
    // rust: let own_leashed = own.is_some_and(|i| self.mobs[i].extra.leash.is_some());
    // rust: if leashed.is_empty() && !own_leashed {
    // rust: return false;
}
        // Leashable.dropLeash: a lead item at the leashed entity's feet.
    // rust: let drop = |game: &mut Self, j: usize| {
    // rust: if horizon_client::mobs::leash::remove(&mut game.mobs[j]).is_some() {
    // rust: let at = game.mobs[j].position;
    // rust: game.spawn_at_location(at, 0.0, ItemStack::new("minecraft:lead", 1));
}
}
    // rust: if let Some(i) = own.filter(|_| own_leashed) {
    // rust: drop(self, i);
}
    // rust: for (_, j) in leashed {
    // rust: drop(self, j);
}
    // rust: let (at, who) = match t {
    // rust: Target::Mob(i) => {
    // rust: let m = &self.mobs[i];
    // rust: (m.position, Who::Mob(m.id))
}
    // rust: _ => (
    // rust: self.player.as_ref().map_or(Vec3::ZERO, |p| p.position),
    // rust: Who::Player,
    // rust: ),
}
    // rust: let ctx = self.who_context(Some(who), None);
    // rust: self.post_game_event("minecraft:shear", [at.x, at.y, at.z], ctx);
    // rust: let block = [at.x.floor() + 0.5, at.y.floor() + 0.5, at.z.floor() + 0.5];
    // rust: self.audio
    // rust: .play("minecraft:item.shears.snip", Some(block), 1.0, 1.0);
    // rust: true
}
    // The brush behaviour: the first armadillo in front that `brushOffScute`s.
dispense_brush :: proc(self: ^Self, pos: Pos, facing: Direction, stack: ItemStack) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let target = offset(pos, facing);
    // rust: let armadillos: Vec<usize> = self
    // rust: .targets_at(target)
    // rust: .into_iter()
    // rust: .filter_map(|t| match t {
    // rust: Target::Mob(i) if self.mobs[i].species() == Species::Armadillo => Some(i),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: for i in armadillos {
    // rust: if self.mobs[i].is_baby() {
    // rust: continue;
}
    // rust: let at = self.mobs[i].position;
    // rust: let drops = self.sequence_loot(
    // rust: "minecraft:brush/armadillo",
    // rust: "minecraft:brush/armadillo",
    // rust: Some(&stack),
    // rust: );
    // rust: for d in drops {
    // rust: self.spawn_at_location(at, 0.0, d);
}
    // rust: self.audio.play(
    // rust: "minecraft:entity.armadillo.brush",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: let who = horizon_client::mobs::Who::Mob(self.mobs[i].id);
    // rust: let ctx = self.who_context(Some(who), None);
    // rust: self.post_game_event("minecraft:entity_interact", [at.x, at.y, at.z], ctx);
    // rust: return (self.hurt_and_break(stack, 16), optional_event("brush"));
}
    // rust: set_success("brush", false);
    // rust: (Some(stack), FAIL)
}
    // `SulfurCubeBlockDispenseItemBehavior.dispenseBlock`: the first sulfur
    // cube in the block that `equipItem`s the stack swallows one.
sulfur_cube_swallow :: proc(self: ^Self, target: Pos, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let cubes: Vec<usize> = self
    // rust: .targets_at(target)
    // rust: .into_iter()
    // rust: .filter_map(|t| match t {
    // rust: Target::Mob(i) if self.mobs[i].species() == Species::SulfurCube => Some(i),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: for i in cubes {
    // rust: let m = &self.mobs[i];
    // rust: if m.is_baby() || m.extra.body.as_deref() == Some(&*stack.item) {
    // rust: continue;
}
    // rust: let (at, height) = (m.position, f64::from(m.height()));
            // The swallowed block comes out on top (the passenger attachment).
    // rust: if let Some(old) = self.mobs[i].extra.body.take() {
    // rust: self.spawn_at_location(at, height, ItemStack::new(&old, 1));
}
    // rust: let m = &mut self.mobs[i];
    // rust: m.extra.body = Some(stack.item.clone());
    // rust: m.persistent = true;
    // rust: let (at, id) = (m.position, m.id);
            // setItemSlot: a body item without `equippable` posts UNEQUIP.
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:unequip", [at.x, at.y, at.z], ctx);
    // rust: self.audio.play(
    // rust: "minecraft:entity.sulfur_cube.absorb",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: return true;
}
    // rust: false
}
    // rust: fn dispense_honeycomb(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let state = self.block_at(target);
    // rust: let name = self.dispenser_block_name(target);
        // HoneycombItem.WAXABLES: each copper block has a waxed twin.
    // rust: let waxed = name.strip_prefix("minecraft:").and_then(|n| {
    // rust: if n.starts_with("waxed_") {
    // rust: return None;
}
    // rust: let twin = format!("minecraft:waxed_{n}");
    // rust: let mut s = self.pack.assets.registry.state(state)?.clone();
    // rust: self.pack.assets.registry.default_state(&twin)?;
    // rust: s.name = twin;
    // rust: self.pack.assets.registry.resolve(&s).ok()
    // rust: });
    // rust: let Some(waxed) =
    // rust: waxed.filter(|_| name.contains("copper") || name.contains("lightning_rod"))
    // rust: else {
    // rust: return Ok((
    // rust: self.default_execute(pos, facing, stack),
    // rust: optional_event("honeycomb"),
    // rust: ));
}
    // rust: set_success("honeycomb", true);
    // rust: self.level_set([target.0, target.1, target.2], waxed)?;
    // rust: self.level_events
    // rust: .push(horizon_world::level::LevelEvent::LevelEvent {
    // rust: id: 3003,
    // rust: pos: Self::pos_of(target),
    // rust: data: 0,
    // rust: });
    // rust: self.process_level_events()?;
    // rust: self.audio.play(
    // rust: "minecraft:item.honeycomb.wax_on",
    // rust: Some(Self::center(target)),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: Ok((shrink(stack), CLICK))
}
    // rust: fn dispense_potion(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: facing: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Result<Dispensed> {
    // rust: let target = offset(pos, facing);
    // rust: let water = stack.potion() == Some("minecraft:water");
    // rust: let name = self.dispenser_block_name(target);
    // rust: if !water || !self.in_block_tag("minecraft:convertible_to_mud", &name) {
            // The inner default behaviour dispenses, then the potion's own
            // events play on top.
    // rust: return Ok((self.dispense_default(pos, facing, stack), CLICK));
}
        // The server picks the splash positions with the level random.
    // rust: for _ in 0..5 {
    // rust: let r = &mut self.world.random;
    // rust: let p = [
    // rust: f64::from(pos.0) + r.next_double(),
    // rust: f64::from(pos.1 + 1),
    // rust: f64::from(pos.2) + r.next_double(),
    // rust: ];
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ParticleType::Splash), p, [0.0; 3]);
}
    // rust: self.audio.play(
    // rust: "minecraft:item.bottle.empty",
    // rust: Some(Self::center(pos)),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.post_block_game_event("minecraft:fluid_place", [pos.0, pos.1, pos.2], None, None);
    // rust: if let Some(mud) = self.pack.assets.registry.default_state("minecraft:mud") {
    // rust: self.level_set([target.0, target.1, target.2], mud)?;
}
    // rust: let bottle = ItemStack::new("minecraft:glass_bottle", 1);
    // rust: Ok((
    // rust: self.consume_with_remainder(pos, facing, stack, bottle),
    // rust: CLICK,
    // rust: ))
}
}
// A tipped arrow's lasting effect at an eighth of the potion's duration
// (`Arrow.doPostHurtEffects`).
    // rust: pub(super) fn tipped_effect(stack: &ItemStack) -> Option<(&'static str, i32)> {
    // rust: stack
    // rust: .potion()
    // rust: .and_then(horizon_client::brewing::potion)
    // rust: .and_then(|def| {
    // rust: def.effects
    // rust: .iter()
    // rust: .find(|(id, _, _)| !horizon_client::brewing::effect(id).is_some_and(|e| e.instant))
    // rust: .map(|(id, duration, _)| {
    // rust: (
    // rust: horizon_client::brewing::namespaced(id),
    // rust: (duration / 8).max(1),
    // rust: )
    // rust: })
    // rust: })
}

    // rust: mod tests {
//     use super::*;

mod_dispenser_answers_preserve_fallback_and_own_consumption :: proc() {
}
    // rust: assert!(
    // rust: mod_dispensed(None).is_none(),
    // rust: "no registered behaviour keeps vanilla"
    // rust: );
    // rust: assert_eq!(mod_dispensed(Some((None, CLICK))), Some((None, CLICK)));
    // rust: let stack = ItemStack::new("minecraft:stone", 7);
    // rust: let Some((Some(left), event)) = mod_dispensed(Some((Some(stack.clone()), FAIL))) else {
    // rust: panic!("handled stack")
}
    // rust: assert_eq!(left, stack, "the returned remainder is not consumed again");
    // rust: assert_eq!(event, FAIL, "the answer chooses its sound");
    // rust: assert_eq!(
    // rust: mod_dispensed(Some((Some(ItemStack { count: 0, ..stack }), 0))),
    // rust: Some((None, 0))
    // rust: );
}
}
