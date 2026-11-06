//! Transpiled from Horizon Rust crate
package horizon_client_native_structures

import "core:fmt"
import "core:mem"
import "core:math"

// Structure templates read for server mods (vanilla's
// `StructureTemplateManager.get`, and what `StructureTemplate.placeInWorld`
// would place) without placing them: a builder reads a template once, then
// places its blocks one at a time (docs/native-mods.md, "Structure
// templates").
// use super::Game;
// use horizon_client::structure_block::parse_identifier;
// use horizon_core::position::BlockPos;
// use horizon_core::random::{LegacyRandom, RandomSource, position_seed};
// use horizon_world::nbt::Compound;
// use horizon_world::registry::BlockStateId;
// use horizon_world::worldgen::structure::{Mirror, Rotation, StateTransforms, StructureTemplate};

// What `native_structure_template` read: the template's size after the
// rotation (`StructureTemplate.getSize`), and the blocks it places, in the
// order `StructureTemplate.placeInWorld` places them.
NativeStructureTemplate :: struct {
    size: [i32,
    blocks: [dynamic]NativeStructureBlock,
}

// One block a template places: its position in the level, its state after
// the mirror and the rotation (as `native_set_block` takes it), and the
// block entity data the template saved with it (a chest's items, a sign's
// text), without its position.
NativeStructureBlock :: struct {
    pos: [i32,
    state: BlockStateId,
    nbt: Maybe(Compound),
}

// Native mods use this; nothing in Horizon does.
    // rust: impl Game<'_> {
    // For a server mod: structure template `id` (`mymod:hut`, found as
    // `StructureTemplateManager.get` finds it: the world's saved structures,
    // then the game's and the mods' own) as `/place template id` would place
    // it at `at` with `rotation` and `mirror`, without placing anything. The
    // blocks come in vanilla's placement order (full blocks, the others, then
    // those with a block entity, each by y, x, z), from the palette
    // `/place template` picks at `at`; no processor runs, and the template's
    // entities are left out. None for an id that doesn't parse or has a `.`
    // or `..` part, a template the game doesn't have, and on a client.
    // API @API:structure_template@.
    // rust: pub(super) fn native_structure_template(
    // rust: &mut self,
    // rust: id: &str,
    // rust: at: [i32; 3],
    // rust: rotation: Rotation,
    // rust: mirror: Mirror,
    // rust: ) -> Option<NativeStructureTemplate> {
    // rust: if !self.native_authoritative() {
    // rust: return None;
}
    // rust: let id = template_id(id)?;
    // rust: let entry = self.template_entry(&id)?;
    // rust: let transforms = self.state_transforms()?;
    // rust: let template =
    // rust: StructureTemplate::from_nbt(&entry.tag, self.pack.assets.registry, transforms);
    // rust: Some(placements(&template, transforms, at, rotation, mirror))
}
}

// `Identifier.tryParse`, less the paths the world's `generated` folder
// refuses (`FileUtil.isPathNormalized`): one with a `.` or `..` part.
template_id :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = parse_identifier(id)?;
    // rust: let (_, path) = id.split_once(':')?;
    // rust: path.split('/')
    // rust: .all(|part| part != "." && part != "..")
    // rust: .then_some(id)
}

// The blocks `StructureTemplate.placeInWorld` places for `template` at `at`
// with the pivot at its origin and no processors, as `/place template` and
// the structure block place it: the palette `getRandomPalette` draws from a
// random seeded with `at`, each position transformed and moved to `at`, each
// state mirrored, then rotated. A template with no palette or a side below 1
// places nothing.
    // rust: fn placements(
    // rust: template: &StructureTemplate,
    // rust: transforms: &StateTransforms,
    // rust: at: [i32; 3],
    // rust: rotation: Rotation,
    // rust: mirror: Mirror,
    // rust: ) -> NativeStructureTemplate {
    // rust: let size = template.size(rotation);
    // rust: let palettes = template.palettes();
    // rust: if palettes.is_empty() || template.size.iter().any(|side| *side < 1) {
    // rust: return NativeStructureTemplate {
    // rust: size,
    // rust: blocks: Vec::new(),
}
}
    // rust: let palette = LegacyRandom::new(position_seed(BlockPos::new(at[0], at[1], at[2])))
    // rust: .next_int_bound(palettes.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: let blocks = palettes[palette]
    // rust: .blocks()
    // rust: .iter()
    // rust: .map(|block| {
    // rust: let relative = StructureTemplate::transform(block.pos, mirror, rotation, [0; 3]);
    // rust: NativeStructureBlock {
    // rust: pos: std::array::from_fn(|i| relative[i] + at[i]),
    // rust: state: transforms.rotate(transforms.mirror(block.state, mirror), rotation),
    // rust: nbt: block.nbt.clone(),
}
    // rust: })
    // rust: .collect();
    // rust: NativeStructureTemplate { size, blocks }
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::version::DATA_VERSION;
//     use horizon_world::nbt::Tag;
//     use horizon_world::registry::BlockRegistry;

    // Air, stone, then a block facing north, east, south and west.
    // rust: const NAMES: [&str; 6] = [
    // rust: "minecraft:air",
    // rust: "minecraft:stone",
    // rust: "test:north",
    // rust: "test:east",
    // rust: "test:south",
    // rust: "test:west",
    // rust: ];

registry :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let state = |name: &str| Tag::compound([("id", Tag::String(name.into()))]);
    // rust: BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(NAMES.iter().map(|n| state(n)).collect()),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound(NAMES.iter().zip(0..).map(|(n, i)| (*n, Tag::Int(i)))),
    // rust: ),
    // rust: ]))
    // rust: .unwrap()
}

    // Vanilla's turns of a facing: clockwise 90, 180 and counterclockwise 90
    // (north, east, south, west), and its mirrors: left-right swaps north
    // and south, front-back east and west.
transforms :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: StateTransforms::from_json(
    // rust: r#"{"rotate":[[0,0,0],[1,1,1],[3,4,5],[4,5,2],[5,2,3],[2,3,4]],
    // rust: "mirror":[[0,0],[1,1],[4,2],[3,5],[2,4],[5,3]],
    // rust: "full_block":[false,true,false,false,false,false],
    // rust: "loot_containers":[],"block_entities":{}}"#,
    // rust: NAMES.len(),
    // rust: )
    // rust: .unwrap()
}

named :: proc(name: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([("Name", Tag::String(name.into()))])
}

block :: proc(pos: [i32; 3], state: i32, nbt: Maybe(Compound)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let pos = Tag::List(pos.iter().map(|v| Tag::Int(*v)).collect());
    // rust: let mut fields = vec![("pos", pos), ("state", Tag::Int(state))];
    // rust: if let Some(nbt) = nbt {
    // rust: fields.push(("nbt", Tag::Compound(nbt)));
}
    // rust: Tag::compound(fields)
}

template :: proc(size: [i32; 3], palettes: [dynamic]Vec<Tag>, blocks: [dynamic]Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let size = Tag::List(size.iter().map(|v| Tag::Int(*v)).collect());
    // rust: let palettes = Tag::List(palettes.into_iter().map(Tag::List).collect());
    // rust: let tag = Tag::compound([
    // rust: ("size", size),
    // rust: ("palettes", palettes),
    // rust: ("blocks", Tag::List(blocks)),
    // rust: ]);
    // rust: StructureTemplate::from_nbt(&tag, &registry(), &transforms())
}

a_template_reads_as_place_template_turns_mirrors_and_orders_it :: proc() {
}
    // rust: let mut chest = Compound::new();
    // rust: chest.insert("id".into(), Tag::String("minecraft:chest".into()));
    // rust: let template = template(
    // rust: [2, 1, 3],
    // rust: vec![vec![
    // rust: named("minecraft:stone"),
    // rust: named("test:north"),
    // rust: named("test:east"),
    // rust: ]],
    // rust: vec![
    // rust: block([0, 0, 1], 2, Some(chest.clone())),
    // rust: block([1, 0, 2], 1, None),
    // rust: block([0, 0, 0], 0, None),
    // rust: ],
    // rust: );
    // rust: let read = placements(
    // rust: &template,
    // rust: &transforms(),
    // rust: [10, 64, 20],
    // rust: Rotation::Clockwise90,
    // rust: Mirror::FrontBack,
    // rust: );
        // A quarter turn swaps the sides along x and z.
    // rust: assert_eq!(read.size, [3, 1, 2]);
        // StructureTemplate.transform: front-back negates x, then a clockwise
        // quarter turn about the origin takes (x, y, z) to (-z, y, x). Each
        // state is mirrored, then turned: north stays north, then faces east;
        // east faces west, then north. The full block comes first, the block
        // entity last.
    // rust: let at = |pos: [i32; 3], name: &str, nbt: Option<Compound>| NativeStructureBlock {
    // rust: pos,
    // rust: state: BlockStateId(NAMES.iter().position(|n| *n == name).unwrap() as u32),
    // rust: nbt,
}
    // rust: assert_eq!(
    // rust: read.blocks,
    // rust: [
    // rust: at([10, 64, 20], "minecraft:stone", None),
    // rust: at([8, 64, 19], "test:east", None),
    // rust: at([9, 64, 20], "test:north", Some(chest)),
    // rust: ]
    // rust: );
}

a_template_with_palettes_gives_the_one_place_template_picks_there :: proc() {
}
    // rust: let template = template(
    // rust: [1, 1, 1],
    // rust: vec![vec![named("minecraft:stone")], vec![named("test:west")]],
    // rust: vec![block([0, 0, 0], 0, None)],
    // rust: );
        // Mth.getSeed(0, 0, 0) is 0, and `new Random(0).nextInt(2)` is 1
        // (its first `nextInt()` is -1155484576): the second palette.
    // rust: let read = placements(
    // rust: &template,
    // rust: &transforms(),
    // rust: [0, 0, 0],
    // rust: Rotation::None,
    // rust: Mirror::None,
    // rust: );
    // rust: assert_eq!(read.blocks.len(), 1);
    // rust: assert_eq!(read.blocks[0].state, BlockStateId(5));
}

template_ids_parse_as_identifiers_without_dot_parts :: proc() {
}
    // rust: assert_eq!(template_id("hut").as_deref(), Some("minecraft:hut"));
    // rust: assert_eq!(
    // rust: template_id("mymod:houses/hut").as_deref(),
    // rust: Some("mymod:houses/hut")
    // rust: );
    // rust: assert_eq!(template_id("mymod:../saves/hut"), None);
    // rust: assert_eq!(template_id("mymod:houses/./hut"), None);
}
}
