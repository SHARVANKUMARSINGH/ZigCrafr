//! Transpiled from Horizon Rust crate
package horizon_world_block_landing

import "core:fmt"
import "core:mem"
import "core:math"

// Registered block landing/bounce reactions and their ordered world effects.
// use crate::{
    // rust: block_entity_push::{BlockPushError, BlockPushWorld, push_entities_up},
    // rust: compression::invalid,
    // rust: movement_properties::MovementProperties,
    // rust: registry::BlockStateId,
}
// use horizon_core::position::BlockPos;
// use std::{collections::BTreeMap, fmt, io};
FallDefinition :: enum {
    Default,
    Hay,
    Honey { volume: f32, pitch: f32 },
    Slime,
    PowderSnow,
    PointedDripstone,
    Farmland { base_block: String },
    TurtleEgg,
}
LandingDefinition :: struct {
    fall: FallDefinition,
    shelf_mushroom_bounce: bool,
}
Rule :: enum {
    Default,
    Hay,
    Honey { volume: f32, pitch: f32 },
    Slime,
    PowderSnow,
    DripstoneTip,
    Farmland { base: BlockStateId },
    TurtleEgg { remaining: Option<BlockStateId> },
}
State :: struct {
    rule: Rule,
    reduction: f32,
    shelf_mushroom_bounce: bool,
}
LandingEntityKind :: enum {
    Other,
    Living,
    Player,
    Zombie,
    Turtle,
    Bat,
    Item,
    PrimedTnt,
}
    // rust: impl LandingEntityKind {
living :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: Self::Living | Self::Player | Self::Zombie | Self::Turtle | Self::Bat
    // rust: )
}
}
LandingSound :: enum {
    HoneySlide,
    HoneyFall,
    TurtleEggBreak,
    ShelfMushroomBounce,
}
LandingDamage :: enum {
    Fall,
    Stalagmite,
}
DamageSourceOwner :: enum {
    Entity,
    Level,
}
LandingEvent :: enum {
    BlockChange,
    BlockDestroy,
}

    // rust: pub trait BlockLandingWorld: BlockPushWorld {
    // rust: type DamageSource: Copy;
    // rust: type Sound: Copy;
is_server_level :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
is_client_side :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
random_float :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
random_int :: proc(self: ^Self, bound: i32) -> R {
    // Ported from Horizon
    return {}
}
under_spawn_protection :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
mob_griefing :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
entity_dimensions :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
suppressing_bounce :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn damage_source(
    // rust: &mut self,
    // rust: owner: DamageSourceOwner,
    // rust: kind: LandingDamage,
    // rust: ) -> Result<Self::DamageSource, Self::Error>;
    // rust: fn cause_fall_damage(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: source: Self::DamageSource,
    // rust: ) -> Result<bool, Self::Error>;
known_sound :: proc(self: ^Self, sound: LandingSound) -> S {
    // Ported from Horizon
    return {}
}
living_fall_sound :: proc(self: ^Self, big: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn entity_sound(
    // rust: &mut self,
    // rust: sound: Self::Sound,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), Self::Error>;
    // Sound source BLOCKS, with no excluded/source entity.
    // rust: fn block_sound(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: sound: Self::Sound,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), Self::Error>;
broadcast_entity_event :: proc(self: ^Self, event: u8) -> R {
    // Ported from Horizon
    return {}
}
destroy_block :: proc(self: ^Self, position: BlockPos, drops: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn set_block(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: state: BlockStateId,
    // rust: flags: u32,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn block_event(
    // rust: &mut self,
    // rust: event: LandingEvent,
    // rust: position: BlockPos,
    // rust: state: BlockStateId,
    // rust: with_entity: bool,
    // rust: ) -> Result<(), Self::Error>;
level_event :: proc(self: ^Self, event: i32, position: BlockPos, data: i32) {
}
    // rust: -> Result<(), Self::Error>;
}
LandingError :: enum {
    Data(io::Error),
    World(E),
    Push(BlockPushError<E>),
}
    // rust: impl<E: fmt::Display> fmt::Display for LandingError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Push(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for LandingError<E> {}
BlockLandingRegistry :: struct {
    states: [dynamic]State,
}
    // rust: impl BlockLandingRegistry {
    // rust: pub fn new(
    // rust: properties: &MovementProperties<'_>,
    // rust: definitions: &BTreeMap<String, LandingDefinition>,
    // rust: ) -> io::Result<Self> {
    // rust: let registry = properties.registry();
    // rust: if definitions
    // rust: .keys()
    // rust: .any(|name| registry.default_state(name).is_none())
    // rust: {
    // rust: return Err(invalid("unknown landing definition"));
}
    // rust: let mut states = Vec::with_capacity(registry.len());
    // rust: for index in 0..registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: let definition = definitions
    // rust: .get(&state.name)
    // rust: .ok_or_else(|| invalid("missing landing definition"))?;
    // rust: let rule = match &definition.fall {
    // rust: FallDefinition::Default => Rule::Default,
    // rust: FallDefinition::Hay => Rule::Hay,
    // rust: FallDefinition::Honey { volume, pitch } => Rule::Honey {
    // rust: volume: *volume,
    // rust: pitch: *pitch,
    // rust: },
    // rust: FallDefinition::Slime => Rule::Slime,
    // rust: FallDefinition::PowderSnow => Rule::PowderSnow,
    // rust: FallDefinition::PointedDripstone => {
    // rust: let direction = state
    // rust: .properties
    // rust: .get("vertical_direction")
    // rust: .map(String::as_str);
    // rust: let thickness = state.properties.get("thickness").map(String::as_str);
    // rust: if !matches!(direction, Some("up" | "down"))
    // rust: || !matches!(
    // rust: thickness,
    // rust: Some("tip" | "tip_merge" | "frustum" | "middle" | "base")
    // rust: )
    // rust: {
    // rust: return Err(invalid("invalid landing dripstone state"));
}
    // rust: if direction == Some("up") && thickness == Some("tip") {
    // rust: Rule::DripstoneTip
    // rust: } else {
    // rust: Rule::Default
}
}
    // rust: FallDefinition::Farmland { base_block } => Rule::Farmland {
    // rust: base: registry
    // rust: .default_state(base_block)
    // rust: .ok_or_else(|| invalid("unknown farmland base block"))?,
    // rust: },
    // rust: FallDefinition::TurtleEgg => {
    // rust: let eggs = state
    // rust: .properties
    // rust: .get("eggs")
    // rust: .and_then(|s| s.parse::<i32>().ok())
    // rust: .filter(|v| (1..=4).contains(v))
    // rust: .ok_or_else(|| invalid("invalid landing egg count"))?;
    // rust: let remaining = if eggs == 1 {
    // rust: None
    // rust: } else {
    // rust: let mut next = state.clone();
    // rust: next.properties
    // rust: .insert("eggs".into(), (eggs - 1).to_string());
    // rust: Some(
    // rust: registry
    // rust: .id(&next)
    // rust: .ok_or_else(|| invalid("missing decremented egg state"))?,
    // rust: )
}
    // rust: Rule::TurtleEgg { remaining }
}
}
    // rust: states.push(State {
    // rust: rule,
    // rust: reduction: properties.coefficients(id)?.fall_distance_reduction,
    // rust: shelf_mushroom_bounce: definition.shelf_mushroom_bounce,
    // rust: });
}
    // rust: Ok(Self { states })
}
    // rust: fn state<E>(&self, id: BlockStateId) -> Result<State, LandingError<E>> {
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| LandingError::Data(invalid("landing state outside registry")))
}
    // rust: pub fn bounce_on<W: BlockLandingWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: entity: LandingEntityKind,
    // rust: ) -> Result<(), LandingError<W::Error>> {
    // rust: if self.state(state)?.shelf_mushroom_bounce
    // rust: && !matches!(
    // rust: entity,
    // rust: LandingEntityKind::Item | LandingEntityKind::PrimedTnt
    // rust: )
    // rust: {
    // rust: let sound = world.known_sound(LandingSound::ShelfMushroomBounce);
    // rust: world
    // rust: .block_sound(position, sound, 1.0, 1.0)
    // rust: .map_err(LandingError::World)?;
}
    // rust: Ok(())
}
    // `TurtleEggBlock.stepOn`: a step that is not careful breaks an egg one
    // time in 100.
    // rust: pub fn step_on<W: BlockLandingWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: entity: LandingEntityKind,
    // rust: ) -> Result<(), LandingError<W::Error>> {
    // rust: if let Rule::TurtleEgg { remaining } = self.state(state)?.rule {
    // rust: self.destroy_egg(world, remaining, state, position, entity, 100)?;
}
    // rust: Ok(())
}
    // `TurtleEggBlock.destroyEgg`: one egg breaks with chance 1 in `randomness`.
    // rust: fn destroy_egg<W: BlockLandingWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: remaining: Option<BlockStateId>,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: entity: LandingEntityKind,
    // rust: randomness: i32,
    // rust: ) -> Result<(), LandingError<W::Error>> {
    // rust: if !world.is_server_level()
    // rust: || matches!(entity, LandingEntityKind::Turtle | LandingEntityKind::Bat)
    // rust: {
    // rust: return Ok(());
}
    // rust: let allowed = if entity == LandingEntityKind::Player {
    // rust: !world
    // rust: .under_spawn_protection(position)
    // rust: .map_err(LandingError::World)?
    // rust: } else {
    // rust: entity.living() && world.mob_griefing().map_err(LandingError::World)?
}
    // rust: if allowed && world.random_int(randomness).map_err(LandingError::World)? == 0 {
    // rust: let sound = world.known_sound(LandingSound::TurtleEggBreak);
    // rust: let pitch = 0.9f32 + world.random_float().map_err(LandingError::World)? * 0.2f32;
    // rust: world
    // rust: .block_sound(position, sound, 0.7, pitch)
    // rust: .map_err(LandingError::World)?;
    // rust: if let Some(next) = remaining {
    // rust: world
    // rust: .set_block(position, next, 2)
    // rust: .map_err(LandingError::World)?;
    // rust: world
    // rust: .block_event(LandingEvent::BlockDestroy, position, state, false)
    // rust: .map_err(LandingError::World)?;
    // rust: world
    // rust: .level_event(2001, position, state.0 as i32)
    // rust: .map_err(LandingError::World)?;
    // rust: } else {
    // rust: world
    // rust: .destroy_block(position, false)
    // rust: .map_err(LandingError::World)?;
}
}
    // rust: Ok(())
}
    // rust: pub fn fall_on<W: BlockLandingWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: entity: LandingEntityKind,
    // rust: distance: f64,
    // rust: ) -> Result<(), LandingError<W::Error>> {
    // rust: let data = self.state(state)?;
    // rust: match data.rule {
    // rust: Rule::Default => {}
    // rust: Rule::Hay => {
    // rust: cause(
    // rust: world,
    // rust: DamageSourceOwner::Level,
    // rust: LandingDamage::Fall,
    // rust: distance,
    // rust: 0.2,
    // rust: )?;
    // rust: return Ok(());
}
    // rust: Rule::Honey { volume, pitch } => {
    // rust: let sound = world.known_sound(LandingSound::HoneySlide);
    // rust: world
    // rust: .entity_sound(sound, 1.0, 1.0)
    // rust: .map_err(LandingError::World)?;
    // rust: if !world.is_client_side().map_err(LandingError::World)? {
    // rust: world
    // rust: .broadcast_entity_event(54)
    // rust: .map_err(LandingError::World)?;
}
    // rust: if cause(
    // rust: world,
    // rust: DamageSourceOwner::Level,
    // rust: LandingDamage::Fall,
    // rust: distance,
    // rust: 0.2,
    // rust: )? {
    // rust: let sound = world.known_sound(LandingSound::HoneyFall);
    // rust: world
    // rust: .entity_sound(sound, volume * 0.5, pitch * 0.75)
    // rust: .map_err(LandingError::World)?;
}
    // rust: return Ok(());
}
    // rust: Rule::Slime => {
    // rust: if !world.suppressing_bounce().map_err(LandingError::World)? {
    // rust: cause(
    // rust: world,
    // rust: DamageSourceOwner::Level,
    // rust: LandingDamage::Fall,
    // rust: distance,
    // rust: 0.0,
    // rust: )?;
}
    // rust: return Ok(());
}
    // rust: Rule::PowderSnow => {
    // rust: if (distance >= 4.0 || distance.is_nan()) && entity.living() {
    // rust: let sound = world
    // rust: .living_fall_sound(distance >= 7.0 || distance.is_nan())
    // rust: .map_err(LandingError::World)?;
    // rust: world
    // rust: .entity_sound(sound, 1.0, 1.0)
    // rust: .map_err(LandingError::World)?;
}
    // rust: return Ok(());
}
    // rust: Rule::DripstoneTip => {
    // rust: cause(
    // rust: world,
    // rust: DamageSourceOwner::Level,
    // rust: LandingDamage::Stalagmite,
    // rust: distance + 2.5,
    // rust: 2.0,
    // rust: )?;
    // rust: return Ok(());
}
    // rust: Rule::Farmland { base } => {
    // rust: if world.is_server_level()
    // rust: && f64::from(world.random_float().map_err(LandingError::World)?)
    // rust: < distance - 0.5
    // rust: && entity.living()
    // rust: {
    // rust: let allowed = if entity == LandingEntityKind::Player {
    // rust: !world
    // rust: .under_spawn_protection(position)
    // rust: .map_err(LandingError::World)?
    // rust: } else {
    // rust: world.mob_griefing().map_err(LandingError::World)?
}
    // rust: if allowed {
    // rust: let (width, height) = world.entity_dimensions();
    // rust: if width * width * height > 0.512f32 {
    // rust: let next = push_entities_up(world, state, base, position)
    // rust: .map_err(LandingError::Push)?;
    // rust: world
    // rust: .set_block(position, next, 3)
    // rust: .map_err(LandingError::World)?;
    // rust: world
    // rust: .block_event(LandingEvent::BlockChange, position, next, true)
    // rust: .map_err(LandingError::World)?;
}
}
}
}
    // rust: Rule::TurtleEgg { remaining } => {
    // rust: if entity != LandingEntityKind::Zombie {
    // rust: self.destroy_egg(world, remaining, state, position, entity, 3)?;
}
}
}
    // rust: cause(
    // rust: world,
    // rust: DamageSourceOwner::Entity,
    // rust: LandingDamage::Fall,
    // rust: distance * f64::from(1.0f32 - data.reduction),
    // rust: 1.0,
    // rust: )?;
    // rust: Ok(())
}
}
    // rust: fn cause<W: BlockLandingWorld>(
    // rust: world: &mut W,
    // rust: owner: DamageSourceOwner,
    // rust: kind: LandingDamage,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: ) -> Result<bool, LandingError<W::Error>> {
    // rust: let source = world
    // rust: .damage_source(owner, kind)
    // rust: .map_err(LandingError::World)?;
    // rust: world
    // rust: .cause_fall_damage(distance, multiplier, source)
    // rust: .map_err(LandingError::World)
}
