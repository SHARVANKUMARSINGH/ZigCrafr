//! Transpiled from Horizon Rust crate
package horizon_world_ruined_portal

import "core:fmt"
import "core:mem"
import "core:math"

// Ruined portals (RuinedPortalStructure, RuinedPortalPiece).
// use super::{
    // rust: Mirror, Rotation, StructureResources,
    // rust: legacy::{
    // rust: HORIZONTAL, PieceContext, Result, TemplateHandler, TemplatePiece, direction_name, offset,
    // rust: opposite,
    // rust: },
    // rust: processor::ProcessorList,
    // rust: start::StartContext,
}
// use crate::{
    // rust: heightmap::HeightmapType, registry::BlockStateId, worldgen::block_feature::FeatureBlockBindings,
}
// use horizon_core::{geometry::Direction, position::ChunkPos, random::RandomSource};
// use serde_json::{Value, json};
// use std::sync::Arc;

Vertical :: enum {
    OnLandSurface,
    PartlyBuried,
    OnOceanFloor,
    InMountain,
    Underground,
    InNether,
}
    // rust: impl Vertical {
    // `RuinedPortalPiece.VerticalPlacement.getSerializedName`.
saved_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::OnLandSurface => "on_land_surface",
    // rust: Self::PartlyBuried => "partly_buried",
    // rust: Self::OnOceanFloor => "on_ocean_floor",
    // rust: Self::InMountain => "in_mountain",
    // rust: Self::Underground => "underground",
    // rust: Self::InNether => "in_nether",
}
}
heightmap :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: if self == Self::OnOceanFloor {
    // rust: HeightmapType::OceanFloorWg
    // rust: } else {
    // rust: HeightmapType::WorldSurfaceWg
}
}
}
Setup :: struct {
    placement: Vertical,
    air_pocket: f32,
    mossiness: f32,
    overgrown: bool,
    vines: bool,
    can_be_cold: bool,
    blackstone: bool,
    weight: f32,
}
    // rust: impl Setup {
decode :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let float = |k: &str| v[k].as_f64().unwrap_or(0.) as f32;
    // rust: let flag = |k: &str| v[k].as_bool().unwrap_or(false);
    // rust: Self {
    // rust: placement: match v["placement"].as_str().unwrap_or_default() {
    // rust: "partly_buried" => Vertical::PartlyBuried,
    // rust: "on_ocean_floor" => Vertical::OnOceanFloor,
    // rust: "in_mountain" => Vertical::InMountain,
    // rust: "underground" => Vertical::Underground,
    // rust: "in_nether" => Vertical::InNether,
    // rust: _ => Vertical::OnLandSurface,
    // rust: },
    // rust: air_pocket: float("air_pocket_probability"),
    // rust: mossiness: float("mossiness"),
    // rust: overgrown: flag("overgrown"),
    // rust: vines: flag("vines"),
    // rust: can_be_cold: flag("can_be_cold"),
    // rust: blackstone: flag("replace_with_blackstone"),
    // rust: weight: float("weight"),
}
}
}
PortalProps :: struct {
    placement: Vertical,
    mossiness: f32,
    air_pocket: bool,
    blackstone: bool,
    cold: bool,
    overgrown: bool,
    vines: bool,
}

between :: proc(random: ^impl RandomSource, min: i32, max: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: random.next_int_bound(max - min + 1).unwrap_or(0) + min
}
within :: proc(random: ^impl RandomSource, min: i32, max: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if min < max {
    // rust: between(random, min, max)
    // rust: } else {
    // rust: max
}
}

// RuinedPortalStructure.findGenerationPoint: the start position and piece.
    // rust: pub fn start(
    // rust: context: &mut impl StartContext,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: chunk: ChunkPos,
    // rust: setups: &[Setup],
    // rust: ) -> Option<([i32; 3], TemplatePiece)> {
    // rust: let setup = if setups.len() > 1 {
    // rust: let total: f32 = setups.iter().map(|s| s.weight).sum();
    // rust: let mut pick = random.next_float();
    // rust: setups.iter().find(|s| {
    // rust: pick -= s.weight / total;
    // rust: pick < 0.
    // rust: })?
    // rust: } else {
    // rust: setups.first()?
}
    // rust: let air_pocket = match setup.air_pocket {
    // rust: 0. => false,
    // rust: 1. => true,
    // rust: p => random.next_float() < p,
}
    // rust: let name = if random.next_float() < 0.05 {
    // rust: format!(
    // rust: "minecraft:ruined_portal/giant_portal_{}",
    // rust: random.next_int_bound(3).ok()? + 1
    // rust: )
    // rust: } else {
    // rust: format!(
    // rust: "minecraft:ruined_portal/portal_{}",
    // rust: random.next_int_bound(10).ok()? + 1
    // rust: )
}
    // rust: let template = resources.template(&name)?;
    // rust: let rotation = Rotation::random(random);
    // rust: let mirror = if random.next_float() < 0.5 {
    // rust: Mirror::None
    // rust: } else {
    // rust: Mirror::FrontBack
}
    // rust: let pivot = [template.size[0] / 2, 0, template.size[2] / 2];
    // rust: let base = [chunk.x * 16, 0, chunk.z * 16];
    // rust: let b = template.bounding_box(base, rotation, pivot, mirror);
    // rust: let center = b.center();
    // rust: let surface = context.base_height(center[0], center[2], setup.placement.heightmap()) - 1;
    // rust: let span = b.span()[1];
    // rust: let min_y = context.min_y() + 15;
    // rust: let new_y = match setup.placement {
    // rust: Vertical::InNether => {
    // rust: if air_pocket {
    // rust: between(random, 32, 100)
    // rust: } else if random.next_float() < 0.5 {
    // rust: between(random, 27, 29)
    // rust: } else {
    // rust: between(random, 29, 100)
}
}
    // rust: Vertical::InMountain => within(random, 70, surface - span),
    // rust: Vertical::Underground => within(random, min_y, surface - span),
    // rust: Vertical::PartlyBuried => surface - span + between(random, 2, 8),
    // rust: _ => surface,
}
    // rust: let kind = setup.placement.heightmap();
    // rust: let columns: Vec<Vec<bool>> = [
    // rust: [b.min[0], b.min[2]],
    // rust: [b.max[0], b.min[2]],
    // rust: [b.min[0], b.max[2]],
    // rust: [b.max[0], b.max[2]],
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|[x, z]| context.base_column(x, z, kind))
    // rust: .collect();
    // rust: let world_min = context.min_y();
    // rust: let mut y = new_y;
    // rust: 'search: while y > min_y {
    // rust: let mut solid = 0;
    // rust: for column in &columns {
    // rust: let index = y - world_min;
    // rust: if index >= 0 && column.get(index as usize).copied().unwrap_or(false) {
    // rust: solid += 1;
    // rust: if solid == 3 {
    // rust: break 'search;
}
}
}
    // rust: y -= 1;
}
    // rust: let origin = [base[0], y, base[2]];
    // rust: let cold = setup.can_be_cold && {
    // rust: let biome = context.noise_biome(origin.map(|v| v >> 2));
    // rust: context.cold_enough_to_snow(biome, origin)
}
    // rust: let props = PortalProps {
    // rust: placement: setup.placement,
    // rust: mossiness: setup.mossiness,
    // rust: air_pocket,
    // rust: blackstone: setup.blackstone,
    // rust: cold,
    // rust: overgrown: setup.overgrown,
    // rust: vines: setup.vines,
}
    // rust: let rule = |source: &str, probability: Option<f32>, target: &str| {
    // rust: let input = match probability {
    // rust: Some(p) => {
    // rust: json!({"predicate_type": "minecraft:random_block_match", "block": source, "probability": p})
}
    // rust: None => json!({"predicate_type": "minecraft:block_match", "block": source}),
}
    // rust: json!({"input_predicate": input, "location_predicate": {"predicate_type": "minecraft:always_true"}, "output_state": target})
}
    // rust: let mut rules = vec![rule("minecraft:gold_block", Some(0.3), "minecraft:air")];
    // rust: rules.push(if setup.placement == Vertical::OnOceanFloor {
    // rust: rule("minecraft:lava", None, "minecraft:magma_block")
    // rust: } else if cold {
    // rust: rule("minecraft:lava", None, "minecraft:netherrack")
    // rust: } else {
    // rust: rule("minecraft:lava", Some(0.2), "minecraft:magma_block")
    // rust: });
    // rust: if !cold {
    // rust: rules.push(rule(
    // rust: "minecraft:netherrack",
    // rust: Some(0.07),
    // rust: "minecraft:magma_block",
    // rust: ));
}
    // rust: let mut list = vec![
    // rust: json!({"processor_type": "minecraft:rule", "rules": rules}),
    // rust: json!({"processor_type": "minecraft:block_age", "mossiness": setup.mossiness}),
    // rust: json!({"processor_type": "minecraft:protected_blocks", "value": "#minecraft:features_cannot_replace"}),
    // rust: json!({"processor_type": "minecraft:lava_submerged_block"}),
    // rust: ];
    // rust: if setup.blackstone {
    // rust: list.push(json!({"processor_type": "minecraft:blackstone_replace"}));
}
    // rust: let processors = ProcessorList::decode(
    // rust: &json!({ "processors": list }).to_string(),
    // rust: resources,
    // rust: bindings,
    // rust: )
    // rust: .ok()?;
    // rust: let mut ignore = vec!["minecraft:structure_block".to_owned()];
    // rust: if !air_pocket {
    // rust: ignore.push("minecraft:air".into());
}
    // rust: let piece = TemplatePiece::new(
    // rust: "minecraft:rupo",
    // rust: &name,
    // rust: template,
    // rust: origin,
    // rust: rotation,
    // rust: mirror,
    // rust: pivot,
    // rust: Arc::new(processors),
    // rust: true,
    // rust: ignore,
    // rust: TemplateHandler::RuinedPortal(props),
    // rust: );
    // rust: Some((origin, piece))
}

    // rust: const NETHERRACK_BY_DISTANCE: [f32; 14] = [
    // rust: 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.9, 0.9, 0.8, 0.7, 0.6, 0.4, 0.2,
    // rust: ];
replaceable :: proc(c: ^PieceContext<'_>, props: PortalProps, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let name = c.name(state);
    // rust: name != "minecraft:air"
    // rust: && name != "minecraft:obsidian"
    // rust: && !c
    // rust: .resources
    // rust: .block_tags
    // rust: .get("minecraft:features_cannot_replace")
    // rust: .is_some_and(|t| t.contains(name))
    // rust: && (props.placement == Vertical::InNether || name != "minecraft:lava")
}
netherrack_or_magma :: proc(c: ^PieceContext<'_>, props: PortalProps, pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = c.world.block(pos)?;
    // rust: if replaceable(c, props, state) {
    // rust: let block = if !props.cold && c.random.float() < 0.07 {
    // rust: "magma_block"
    // rust: } else {
    // rust: "netherrack"
}
    // rust: c.world.set(pos, c.state(block), 3)?;
}
    // rust: Ok(())
}
drip_column :: proc(c: ^PieceContext<'_>, props: PortalProps, mut pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: netherrack_or_magma(c, props, pos)?;
    // rust: let mut remaining = 8;
    // rust: while remaining > 0 && c.random.float() < 0.5 {
    // rust: pos[1] -= 1;
    // rust: remaining -= 1;
    // rust: netherrack_or_magma(c, props, pos)?;
}
    // rust: Ok(())
}
leaves_above :: proc(c: ^PieceContext<'_>, pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if c.random.float() < 0.5 && c.is_block(pos, "minecraft:netherrack")? {
    // rust: let above = [pos[0], pos[1] + 1, pos[2]];
    // rust: let state = c.world.block(above)?;
    // rust: if c.is_air(state) {
    // rust: let leaves = c.state_with("jungle_leaves", &[("persistent", "true")]);
    // rust: c.world.set(above, leaves, 3)?;
}
}
    // rust: Ok(())
}
vines :: proc(c: ^PieceContext<'_>, pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = c.world.block(pos)?;
    // rust: if c.is_air(state) || c.name(state) == "minecraft:vine" {
    // rust: return Ok(());
}
    // rust: let direction = random_horizontal_dyn(c);
    // rust: let neighbour = offset(pos, direction, 1);
    // rust: let n = c.world.block(neighbour)?;
    // rust: if c.is_air(n) && c.world.face_full(pos, direction)? {
    // rust: let vine = c.state_with("vine", &[(direction_name(opposite(direction)), "true")]);
    // rust: c.world.set(neighbour, vine, 3)?;
}
    // rust: Ok(())
}
random_horizontal_dyn :: proc(c: ^PieceContext<'_>) -> D {
    // Ported from Horizon
    return {}
}
    // rust: HORIZONTAL[c.random.int(4) as usize]
}
// RuinedPortalPiece.postProcess.
post_process :: proc(piece: ^TemplatePiece, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let TemplateHandler::RuinedPortal(props) = piece.handler else {
    // rust: return Ok(());
}
    // rust: let b = piece.bounding_box;
    // rust: if !c.chunk_box.is_inside(b.center()) {
    // rust: return Ok(());
}
    // rust: c.chunk_box.encapsulate(&b);
    // rust: piece.place_at(c, piece.position, &[])?;
    // spreadNetherrack
    // rust: let follow = matches!(
    // rust: props.placement,
    // rust: Vertical::OnLandSurface | Vertical::OnOceanFloor
    // rust: );
    // rust: let [cx, _, cz] = b.center();
    // rust: let max = NETHERRACK_BY_DISTANCE.len() as i32;
    // rust: let [sx, _, sz] = b.span();
    // rust: let adjustment = c.random.int((8 - (sx + sz) / 2 / 2).max(1));
    // rust: for x in cx - max..=cx + max {
    // rust: for z in cz - max..=cz + max {
    // rust: let distance = (x - cx).abs() + (z - cz).abs();
    // rust: let adjusted = (distance + adjustment).max(0);
    // rust: if adjusted >= max {
    // rust: continue;
}
    // rust: if c.random.double() < f64::from(NETHERRACK_BY_DISTANCE[adjusted as usize]) {
    // rust: let surface = c.world.height(props.placement.heightmap(), x, z)? - 1;
    // rust: let y = if follow {
    // rust: surface
    // rust: } else {
    // rust: b.min[1].min(surface)
}
    // rust: let pos = [x, y, z];
    // rust: let state = c.world.block(pos)?;
    // rust: if (y - b.min[1]).abs() <= 3 && replaceable(c, props, state) {
    // rust: netherrack_or_magma(c, props, pos)?;
    // rust: if props.overgrown {
    // rust: leaves_above(c, pos)?;
}
    // rust: drip_column(c, props, [x, y - 1, z])?;
}
}
}
}
    // addNetherrackDripColumnsBelowPortal
    // rust: for x in b.min[0] + 1..b.max[0] {
    // rust: for z in b.min[2] + 1..b.max[2] {
    // rust: if c.is_block([x, b.min[1], z], "minecraft:netherrack")? {
    // rust: drip_column(c, props, [x, b.min[1] - 1, z])?;
}
}
}
    // rust: if props.vines || props.overgrown {
    // rust: for z in b.min[2]..=b.max[2] {
    // rust: for y in b.min[1]..=b.max[1] {
    // rust: for x in b.min[0]..=b.max[0] {
    // rust: if props.vines {
    // rust: vines(c, [x, y, z])?;
}
    // rust: if props.overgrown {
    // rust: leaves_above(c, [x, y, z])?;
}
}
}
}
}
    // rust: Ok(())
}

    // rust: impl PortalProps {
    // `RuinedPortalPiece`'s `VerticalPlacement` and `Properties` tags.
save :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
//         use crate::nbt::Tag;
    // rust: let flag = |b: bool| Tag::Byte(i8::from(b));
    // rust: [
    // rust: (
    // rust: "VerticalPlacement",
    // rust: Tag::String(self.placement.saved_name().into()),
    // rust: ),
    // rust: (
    // rust: "Properties",
    // rust: Tag::compound([
    // rust: ("cold", flag(self.cold)),
    // rust: ("mossiness", Tag::Float(self.mossiness.to_bits())),
    // rust: ("air_pocket", flag(self.air_pocket)),
    // rust: ("overgrown", flag(self.overgrown)),
    // rust: ("vines", flag(self.vines)),
    // rust: ("replace_with_blackstone", flag(self.blackstone)),
    // rust: ]),
    // rust: ),
    // rust: ]
}
}
