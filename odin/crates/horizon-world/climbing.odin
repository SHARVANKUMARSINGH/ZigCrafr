//! Transpiled from Horizon Rust crate
package horizon_world_climbing

import "core:fmt"
import "core:mem"
import "core:math"

// Registered climbing tags and trapdoor/ladder support with entity state order.
// use crate::{
    // rust: compression::invalid,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::position::BlockPos;
// use std::{collections::BTreeSet, fmt, io};
State :: struct {
    climbable: bool,
    glide_through: bool,
    open_trapdoor: Maybe(u8),
    ladder: Maybe(u8),
}
horizontal_facing :: proc(value: Maybe(string)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match value {
    // rust: Some("north") => Some(0),
    // rust: Some("south") => Some(1),
    // rust: Some("west") => Some(2),
    // rust: Some("east") => Some(3),
    // rust: _ => None,
}
}
ClimbingRegistry :: struct {
    registry: ^'r BlockRegistry,
    states: [dynamic]State,
}
    // rust: impl<'r> ClimbingRegistry<'r> {
    // Trapdoor names are imported class identities, not inferred from spelling. A tagged
    // state without a valid `facing` and `open` is not a trapdoor and is skipped, not an error.
    // Rebuild this immutable snapshot when either resolved block tag reloads.
    // rust: pub fn new(
    // rust: registry: &'r BlockRegistry,
    // rust: trapdoors: &BTreeSet<String>,
    // rust: climbable: &BTreeSet<String>,
    // rust: glide_through: &BTreeSet<String>,
    // rust: ) -> io::Result<Self> {
    // rust: for names in [trapdoors, climbable, glide_through] {
    // rust: if names.iter().any(|n| registry.default_state(n).is_none()) {
    // rust: return Err(invalid("unknown climbing block member"));
}
}
    // rust: let mut states = Vec::with_capacity(registry.len());
    // rust: for i in 0..registry.len() {
    // rust: let s = registry.state(BlockStateId(i as u32)).unwrap();
    // rust: let facing = horizontal_facing(s.properties.get("facing").map(String::as_str));
            // Vanilla tests `instanceof TrapDoorBlock`; the tag only stands in for it. A mod can
            // list blocks that are not trapdoors (no `open` or `facing`): those never climb.
    // rust: let open_trapdoor = if trapdoors.contains(&s.name) {
    // rust: match (facing, s.properties.get("open").map(String::as_str)) {
    // rust: (Some(f), Some("true")) => Some(f),
    // rust: _ => None,
}
    // rust: } else {
    // rust: None
}
    // rust: states.push(State {
    // rust: climbable: climbable.contains(&s.name),
    // rust: glide_through: glide_through.contains(&s.name),
    // rust: open_trapdoor,
    // rust: ladder: if s.name == "minecraft:ladder" {
    // rust: Some(facing.ok_or_else(|| invalid("invalid climbing facing"))?)
    // rust: } else {
    // rust: None
    // rust: },
    // rust: });
}
    // rust: Ok(Self { registry, states })
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
state :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("climbing state outside registry"))
}
is_climbable_tag :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.state(id)?.climbable)
}
}
    // rust: pub trait ClimbingWorld {
    // rust: type Error;
is_spectator :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
in_block_state :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_fall_flying :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_state :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
set_last_climbable_position :: proc(self: ^Self, position: BlockPos) {
}
}
ClimbingError :: enum {
    Data(io::Error),
    World(E),
}
    // rust: impl<E: fmt::Display> fmt::Display for ClimbingError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for ClimbingError<E> {}
// Failed/negative queries retain the existing last-climbable position. Only a
// positive result overwrites it, using the position captured before state reads.
    // rust: pub fn on_climbable<W: ClimbingWorld>(
    // rust: world: &mut W,
    // rust: registry: &ClimbingRegistry<'_>,
    // rust: ) -> Result<bool, ClimbingError<W::Error>> {
//     use ClimbingError::{Data, World};
    // rust: if world.is_spectator().map_err(World)? {
    // rust: return Ok(false);
}
    // rust: let position = world.block_position().map_err(World)?;
    // rust: let state = registry
    // rust: .state(world.in_block_state().map_err(World)?)
    // rust: .map_err(Data)?;
    // rust: if world.is_fall_flying().map_err(World)? && state.glide_through {
    // rust: return Ok(false);
}
    // rust: let climbable = if state.climbable {
    // rust: true
    // rust: } else if let Some(facing) = state.open_trapdoor {
    // rust: let below = BlockPos::new(position.x, position.y.wrapping_sub(1), position.z);
    // rust: registry
    // rust: .state(world.block_state(below).map_err(World)?)
    // rust: .map_err(Data)?
    // rust: .ladder
    // rust: == Some(facing)
    // rust: } else {
    // rust: false
}
    // rust: if climbable {
    // rust: world.set_last_climbable_position(position);
}
    // rust: Ok(climbable)
}
    // rust: mod tests {
//     use super::*;
//     use std::convert::Infallible;

AIR :: BlockStateId(0)
LADDER_NORTH :: BlockStateId(1)
OPEN_TRAPDOOR_NORTH :: BlockStateId(2)
CLOSED_TRAPDOOR_NORTH :: BlockStateId(3)
BRIDGE_NO_OPEN :: BlockStateId(4)
PIER_NO_PROPERTIES :: BlockStateId(5)
OPEN_NO_FACING :: BlockStateId(6)

    // A trapdoor with `facing` and `open`, and three blocks a mod put in the trapdoor tag that
    // are not trapdoors: no `open` (Macaw's rail bridge), no properties (its pier), and no
    // `facing`.
registry :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let json = br#"{"defaults": {"minecraft:air": 0, "minecraft:ladder": 1,
    // rust: "minecraft:oak_trapdoor": 3, "mod:bridge": 4, "mod:pier": 5, "mod:odd": 6},
    // rust: "states": [
    // rust: ["minecraft:air", true, false, "x", "minecraft:air"],
    // rust: ["minecraft:ladder", false, false, "x", {"id": "minecraft:ladder", "properties": {"facing": "north"}}],
    // rust: ["minecraft:oak_trapdoor", false, false, "x", {"id": "minecraft:oak_trapdoor", "properties": {"facing": "north", "open": "true"}}],
    // rust: ["minecraft:oak_trapdoor", false, false, "x", {"id": "minecraft:oak_trapdoor", "properties": {"facing": "north", "open": "false"}}],
    // rust: ["mod:bridge", false, false, "x", {"id": "mod:bridge", "properties": {"facing": "north", "powered": "false"}}],
    // rust: ["mod:pier", false, false, "x", "mod:pier"],
    // rust: ["mod:odd", false, false, "x", {"id": "mod:odd", "properties": {"open": "true"}}]
    // rust: ]}"#;
    // rust: BlockRegistry::from_facts_json_with_flags(&json[..])
    // rust: .unwrap()
    // rust: .0
}

names :: proc(list: ^[string]) -> B {
    // Ported from Horizon
    return {}
}
    // rust: list.iter().map(|n| (*n).to_owned()).collect()
}

    // The entity stands in `inside`, with `below` under its block.
World :: struct {
    inside: BlockStateId,
    below: BlockStateId,
    last: Maybe(BlockPos),
}
    // rust: impl ClimbingWorld for World {
    // rust: type Error = Infallible;
is_spectator :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(BlockPos::new(1, 2, 3))
}
in_block_state :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.inside)
}
is_fall_flying :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
block_state :: proc(self: ^Self, _: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.below)
}
set_last_climbable_position :: proc(self: ^Self, position: BlockPos) {
}
    // rust: self.last = Some(position);
}
}

climbs :: proc(registry: ^ClimbingRegistry<'_>, inside: BlockStateId, below: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut world = World {
    // rust: inside,
    // rust: below,
    // rust: last: None,
}
    // rust: let result = on_climbable(&mut world, registry).unwrap();
    // rust: assert_eq!(result, world.last.is_some());
    // rust: result
}

tagged_blocks_without_trapdoor_properties_do_not_fail_the_binding :: proc() {
}
    // rust: let registry = registry();
    // rust: let tagged = names(&[
    // rust: "minecraft:oak_trapdoor",
    // rust: "mod:bridge",
    // rust: "mod:pier",
    // rust: "mod:odd",
    // rust: ]);
    // rust: let empty = BTreeSet::new();
    // rust: let climbing = ClimbingRegistry::new(&registry, &tagged, &empty, &empty)
    // rust: .expect("a tag member that is not a trapdoor must not stop the start");

        // The real trapdoor still climbs, and only open over a ladder facing the same way.
    // rust: assert!(climbs(&climbing, OPEN_TRAPDOOR_NORTH, LADDER_NORTH));
    // rust: assert!(!climbs(&climbing, CLOSED_TRAPDOOR_NORTH, LADDER_NORTH));
    // rust: assert!(!climbs(&climbing, OPEN_TRAPDOOR_NORTH, AIR));
        // Vanilla's `instanceof TrapDoorBlock` is false for these, so they never climb.
    // rust: for id in [BRIDGE_NO_OPEN, PIER_NO_PROPERTIES, OPEN_NO_FACING] {
    // rust: assert!(!climbs(&climbing, id, LADDER_NORTH));
}
}

a_missing_open_property_and_a_missing_facing_each_count_as_not_a_trapdoor :: proc() {
}
    // rust: let registry = registry();
    // rust: let empty = BTreeSet::new();
        // Alone, so each case is tested without the other: `mod:bridge` has `facing` but no
        // `open`; `mod:odd` has `open` but no `facing`; `mod:pier` has neither.
    // rust: for name in ["mod:bridge", "mod:odd", "mod:pier"] {
    // rust: let tagged = names(&[name]);
    // rust: assert!(ClimbingRegistry::new(&registry, &tagged, &empty, &empty).is_ok());
}
}
}
