//! Transpiled from Horizon Rust crate
package horizon_client_place

import "core:fmt"
import "core:mem"
import "core:math"

// `/place template` (PlaceCommand): a saved structure template placed with
// rotation, mirroring and integrity.
// use super::{Arg, Context, Game, R, err};
// use crate::game::structure_blocks::{load_settings, template_size};
// use horizon_client::text::Text;
// use horizon_core::position::BlockPos;
// use horizon_world::{
    // rust: compression::Compression,
    // rust: nbt::{self, Limits, Tag},
    // rust: worldgen::structure::{Mirror, Rotation, StateTransforms},
}
// use std::sync::OnceLock;

num :: proc(n: impl std::fmt::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(n.to_string())
}

    // rust: impl Game<'_> {
    // rust: pub(in crate::game) fn state_transforms(&self) -> Option<&'static StateTransforms> {
TRANSFORMS :: OnceLock::new()
    // rust: TRANSFORMS
    // rust: .get_or_init(|| {
    // rust: let json = std::fs::read_to_string(
    // rust: self.options
    // rust: .resources
    // rust: .join("worldgen/blocks/structure-blocks.json"),
    // rust: )
    // rust: .ok()?;
    // rust: StateTransforms::from_json(&json, self.pack.assets.registry.len()).ok()
    // rust: })
    // rust: .as_ref()
}
    // A template's tree by id, as `StructureTemplateManager` reads it from
    // disk.
    // rust: pub(in crate::game) fn read_template_tag(&self, id: &str) -> Option<Tag> {
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let candidates = [
    // rust: self.world_root
    // rust: .join("generated")
    // rust: .join(ns)
    // rust: .join("structures")
    // rust: .join(format!("{path}.nbt")),
    // rust: self.options
    // rust: .resources
    // rust: .join("worldgen/structure")
    // rust: .join(ns)
    // rust: .join(format!("{path}.nbt")),
    // rust: ];
    // rust: for file in candidates {
    // rust: let Ok(bytes) = std::fs::read(&file) else {
    // rust: continue;
}
    // rust: let Ok(raw) = Compression::Gzip.decode(&bytes, 1 << 28) else {
    // rust: continue;
}
    // rust: let Ok((named, _)) = nbt::read_named(&raw, Limits::templates()) else {
    // rust: continue;
}
    // rust: return Some(named.tag);
}
    // rust: None
}
    // `BlockPosArgument.getLoadedBlockPos(pos)`, or the source's block.
place_pos :: proc(self: ^Self, ctx: ^Context, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if ctx.get(name).is_some() {
    // rust: return self.block_pos_arg(ctx, name);
}
    // rust: Ok(self.source_position().map(|v| v.floor() as i32))
}
    // `PlaceCommand.checkLoaded`: every chunk of the inclusive range.
place_check_loaded :: proc(self: ^Self, min: [i32; 2], max: [i32; 2]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let dimension = self.command_source.map_or(self.dim, |s| s.dimension);
    // rust: for cx in min[0]..=max[0] {
    // rust: for cz in min[1]..=max[1] {
    // rust: if dimension != self.dim || !self.world.chunks.contains_key(&(cx, cz)) {
    // rust: return Err(err("argument.pos.unloaded", &[]));
}
}
}
    // rust: Ok(())
}
    // `PlaceCommand.placeFeature`, `placeJigsaw` and `placeStructure`.
    // rust: pub(super) fn cmd_place_generated(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: match id {
    // rust: "place.feature" => {
    // rust: let raw = match ctx.get("feature") {
    // rust: Some(Arg::Resource(s) | Arg::Str(s)) => s.clone(),
    // rust: _ => return Ok(0),
}
    // rust: let pos = self.place_pos(ctx, "pos")?;
    // rust: let (cx, cz) = (pos[0] >> 4, pos[2] >> 4);
    // rust: self.place_check_loaded([cx - 1, cz - 1], [cx + 1, cz + 1])?;
                // Inline features are not built by the live feature registry.
    // rust: if raw.starts_with('{') {
    // rust: return Err(err("command.failed", &[]));
}
    // rust: let name = if raw.contains(':') {
    // rust: raw
    // rust: } else {
    // rust: format!("minecraft:{raw}")
}
    // rust: let at = horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let placed = self
    // rust: .with_level(|b, level, ticks| b.place_feature(level, ticks, &name, at))
    // rust: .ok_or_else(|| err("command.failed", &[]))?;
    // rust: self.process_level_events()
    // rust: .map_err(|_| err("command.failed", &[]))?;
    // rust: if !placed {
    // rust: return Err(err("commands.place.feature.failed", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.place.feature.success",
    // rust: &[Text::literal(name), num(pos[0]), num(pos[1]), num(pos[2])],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "place.jigsaw" => {
    // rust: let Some(Arg::Resource(pool)) = ctx.get("pool").cloned() else {
    // rust: return Ok(0);
}
    // rust: if !self
    // rust: .ui
    // rust: .registries
    // rust: .ids("minecraft:worldgen/template_pool")
    // rust: .contains(&pool)
    // rust: {
    // rust: return Err(err("commands.place.jigsaw.invalid", &[&pool]));
}
    // rust: let target = match ctx.get("target") {
    // rust: Some(Arg::Resource(s) | Arg::Str(s)) => s.clone(),
    // rust: _ => return Ok(0),
}
    // rust: let max_depth = match ctx.get("max_depth") {
    // rust: Some(Arg::Int(n)) => *n,
    // rust: _ => return Ok(0),
}
    // rust: let pos = self.place_pos(ctx, "position")?;
    // rust: self.place_check_loaded([pos[0] >> 4, pos[2] >> 4], [pos[0] >> 4, pos[2] >> 4])?;
    // rust: let terrain = self
    // rust: .end
    // rust: .locator()
    // rust: .ok_or_else(|| err("command.failed", &[]))?;
    // rust: let query = horizon_world::worldgen::generator::JigsawQuery {
    // rust: pool: &pool,
    // rust: target: &target,
    // rust: max_depth,
    // rust: position: pos,
}
    // rust: let (placed, entities) = self.with_level(|b, level, ticks| {
    // rust: b.place_jigsaw(level, ticks, pos, false, || terrain.jigsaw_pieces(&query))
    // rust: });
    // rust: for entity in entities {
    // rust: self.spawn_entity_from_nbt(Tag::Compound(entity));
}
    // rust: self.process_level_events()
    // rust: .map_err(|_| err("command.failed", &[]))?;
    // rust: if !placed {
    // rust: return Err(err("commands.place.jigsaw.failed", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.place.jigsaw.success",
    // rust: &[num(pos[0]), num(pos[1]), num(pos[2])],
    // rust: ));
    // rust: Ok(1)
}
    // rust: _ => {
    // rust: let Some(Arg::Resource(structure)) = ctx.get("structure").cloned() else {
    // rust: return Ok(0);
}
    // rust: if !self
    // rust: .ui
    // rust: .registries
    // rust: .ids("minecraft:worldgen/structure")
    // rust: .contains(&structure)
    // rust: {
    // rust: return Err(err("commands.place.structure.invalid", &[&structure]));
}
    // rust: let pos = self.place_pos(ctx, "pos")?;
                // PlaceCommand.placeStructure: Structure.generate for the
                // position's chunk with its `biome -> true` predicate, then
                // placeInChunk for every chunk of the start's box.
    // rust: let terrain = self
    // rust: .end
    // rust: .locator()
    // rust: .ok_or_else(|| err("command.failed", &[]))?;
    // rust: let start = terrain
    // rust: .structure_start(&structure, pos[0] >> 4, pos[2] >> 4)
    // rust: .ok_or_else(|| err("commands.place.structure.failed", &[]))?;
    // rust: let (min, max) = (start.bounding_box.min, start.bounding_box.max);
    // rust: self.place_check_loaded([min[0] >> 4, min[2] >> 4], [max[0] >> 4, max[2] >> 4])?;
    // rust: let (placed, entities) =
    // rust: self.with_level(|b, level, ticks| b.place_structure(level, ticks, &start));
    // rust: for entity in entities {
    // rust: self.spawn_entity_from_nbt(Tag::Compound(entity));
}
    // rust: if !placed {
    // rust: return Err(err("commands.place.structure.failed", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.place.structure.success",
    // rust: &[
    // rust: Text::literal(structure),
    // rust: num(pos[0]),
    // rust: num(pos[1]),
    // rust: num(pos[2]),
    // rust: ],
    // rust: ));
    // rust: Ok(1)
}
}
}
    // rust: pub(super) fn cmd_place(&mut self, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Resource(id)) = ctx.get("template").cloned() else {
    // rust: return Ok(0);
}
    // rust: let pos = self.place_pos(ctx, "pos")?;
    // rust: let rotation = match ctx.get("rotation") {
    // rust: Some(Arg::Str(r)) => Rotation::from_name(r).unwrap_or(Rotation::None),
    // rust: _ => Rotation::None,
}
    // rust: let mirror = match ctx.get("mirror") {
    // rust: Some(Arg::Str(m)) => match m.as_str() {
    // rust: "left_right" => Mirror::LeftRight,
    // rust: "front_back" => Mirror::FrontBack,
    // rust: _ => Mirror::None,
    // rust: },
    // rust: _ => Mirror::None,
}
    // rust: let integrity = match ctx.get("integrity") {
    // rust: Some(Arg::Float(f)) => *f,
    // rust: _ => 1.0,
}
    // rust: let seed = match ctx.get("seed") {
    // rust: Some(Arg::Int(s)) => *s,
    // rust: _ => 0,
}
    // rust: let strict = ctx.has("strict");
    // rust: let entry = self
    // rust: .template_entry(&id)
    // rust: .ok_or_else(|| err("commands.place.template.invalid", &[&id]))?;
    // rust: let size = template_size(&entry.tag);
    // rust: let end = [pos[0] + size[0], pos[2] + size[2]];
    // rust: self.place_check_loaded([pos[0] >> 4, pos[2] >> 4], [end[0] >> 4, end[1] >> 4])?;
        // `placeInWorld(level, pos, pos, settings, createRandom(seed), flags)`.
    // rust: let settings = load_settings(mirror, rotation, integrity, i64::from(seed), strict);
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: if !self.place_template_entry(&entry, at, settings, mirror, rotation) {
    // rust: return Err(err("commands.place.template.failed", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.place.template.success",
    // rust: &[Text::literal(id), num(pos[0]), num(pos[1]), num(pos[2])],
    // rust: ));
    // rust: Ok(1)
}
}
