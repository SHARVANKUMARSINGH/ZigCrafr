//! Transpiled from Horizon Rust crate
//! Module: horizon-world_features
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The `template` and `fossil` configured features.
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate,
    // rust: processor::{PlaceSettings, ProcessorList, place_in_world},
}
// use crate::{
    // rust: heightmap::HeightmapType,
    // rust: worldgen::{
    // rust: DecodeError,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: weighted::WeightedList,
    // rust: },
}
// use horizon_core::random::RandomSource;
// use serde_json::{Value, value::RawValue};
// use std::sync::Arc;

pub fn resources(bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bindings
    // rust: .structures
    // rust: .clone()
    // rust: .ok_or(DecodeError::Field("structure template bindings"))
}
    // rust: fn template(
    // rust: resources: &StructureResources,
    // rust: id: &str,
    // rust: ) -> Result<Arc<StructureTemplate>, DecodeError> {
    // rust: resources
    // rust: .template(id)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("missing structure template {id}")))
}

pub const TemplateFeature = struct {
    templates: WeightedList<(*StructureTemplate,
    processors: ProcessorList,
    resources: *StructureResources,
};
    // rust: impl TemplateFeature {
pub fn decode(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let resources = resources(bindings)?;
    // rust: let value: Value = serde_json::from_str(json)?;
    // rust: let raw: Box<RawValue> = serde_json::from_str(&value["templates"].to_string())?;
    // rust: let templates = WeightedList::decode(&raw, |entry| {
    // rust: let entry: Value = serde_json::from_str(entry.get())?;
    // rust: let id = entry["id"]
    // rust: .as_str()
    // rust: .ok_or(DecodeError::Field("template id"))?;
    // rust: let rotations = match entry.get("rotations").and_then(Value::as_array) {
    // rust: Some(list) => list
    // rust: .iter()
    // rust: .map(|r| {
    // rust: r.as_str()
    // rust: .and_then(Rotation::from_name)
    // rust: .ok_or(DecodeError::Field("rotation"))
    // rust: })
    // rust: .collect::<Result<Vec<_>, _>>()?,
    // rust: None => Rotation::ALL.to_vec(),
}
    // rust: Ok((template(&resources, id)?, rotations))
    // rust: })?;
    // rust: let processors = match value.get("processors") {
    // rust: Some(p) => ProcessorList::decode(&p.to_string(), &resources, bindings)?,
    // rust: None => ProcessorList::default(),
}
    // rust: Ok(Self {
    // rust: templates,
    // rust: processors,
    // rust: resources,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let invalid = |_| PlacementQueryError::Failed("template weights".into());
    // rust: let (template, rotations) = self.templates.sample(random).map_err(invalid)?;
    // rust: let rotation = rotations[random
    // rust: .next_int_bound(rotations.len() as i32)
    // rust: .map_err(invalid)? as usize];
        // rotation.rotate(axis.getNegative()) * (size along axis / 2), for X then Z.
    // rust: let mut pos = origin;
    // rust: for (axis, negative) in [
    // rust: (0, horizon_core::geometry::Direction::West),
    // rust: (2, horizon_core::geometry::Direction::North),
    // rust: ] {
    // rust: let step = rotation.rotate_direction(negative).normal();
    // rust: let length = template.size[axis] / 2;
    // rust: for i in 0..3 {
    // rust: pos[i] += step[i] * length;
}
}
    // rust: let mut settings = PlaceSettings::new(rotation).with_processors(&self.processors);
    // rust: settings.random = Some(random);
    // rust: place_in_world(
    // rust: world,
    // rust: &self.resources,
    // rust: template,
    // rust: pos,
    // rust: pos,
    // rust: &mut settings,
    // rust: None,
    // rust: 3,
    // rust: )
}
}

pub const FossilFeature = struct {
    fossils: std.ArrayList((Arc<StructureTemplate),
    fossil_processors: ProcessorList,
    overlay_processors: ProcessorList,
    max_empty_corners: i32,
    resources: *StructureResources,
};
    // rust: impl FossilFeature {
pub fn decode(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let resources = resources(bindings)?;
    // rust: let value: Value = serde_json::from_str(json)?;
    // rust: let list = |key: &'static str| -> Result<Vec<Arc<StructureTemplate>>, DecodeError> {
    // rust: value[key]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field(key))?
    // rust: .iter()
    // rust: .map(|id| template(&resources, id.as_str().unwrap_or_default()))
    // rust: .collect()
}
    // rust: let (base, overlay) = (list("fossil_structures")?, list("overlay_structures")?);
    // rust: if base.is_empty() || base.len() != overlay.len() {
    // rust: return Err(DecodeError::Field("fossil structure lists"));
}
    // rust: Ok(Self {
    // rust: fossils: base.into_iter().zip(overlay).collect(),
    // rust: fossil_processors: ProcessorList::decode(
    // rust: &value["fossil_processors"].to_string(),
    // rust: &resources,
    // rust: bindings,
    // rust: )?,
    // rust: overlay_processors: ProcessorList::decode(
    // rust: &value["overlay_processors"].to_string(),
    // rust: &resources,
    // rust: bindings,
    // rust: )?,
    // rust: max_empty_corners: value["max_empty_corners_allowed"].as_i64().unwrap_or(0) as i32,
    // rust: resources,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let invalid = |_| PlacementQueryError::Failed("fossil bounds".into());
    // rust: let rotation = Rotation::random(random);
    // rust: let index = random
    // rust: .next_int_bound(self.fossils.len() as i32)
    // rust: .map_err(invalid)? as usize;
    // rust: let (base, overlay) = &self.fossils[index];
    // rust: let (cx, cz) = (origin[0] >> 4, origin[2] >> 4);
    // rust: let bounds = BoundingBox::new(
    // rust: [cx * 16 - 16, world.min_y()?, cz * 16 - 16],
    // rust: [cx * 16 + 15 + 16, world.max_y()?, cz * 16 + 15 + 16],
    // rust: );
    // rust: let size = base.size(rotation);
    // rust: let low = [origin[0] - size[0] / 2, 0, origin[2] - size[2] / 2];
    // rust: let mut lowest = origin[1];
    // rust: for x in 0..size[0] {
    // rust: for z in 0..size[2] {
    // rust: lowest = lowest.min(world.height(
    // rust: HeightmapType::OceanFloorWg,
    // rust: low[0] + x,
    // rust: low[2] + z,
    // rust: )?);
}
}
    // rust: let y =
    // rust: (lowest - 15 - random.next_int_bound(10).map_err(invalid)?).max(world.min_y()? + 10);
    // rust: let target = StructureTemplate::zero_position_with_transform(
    // rust: [low[0], y, low[2]],
    // rust: Mirror::None,
    // rust: rotation,
    // rust: base.size[0],
    // rust: base.size[2],
    // rust: );
    // rust: let mut empty = 0;
    // rust: for corner in base
    // rust: .bounding_box(target, rotation, [0; 3], Mirror::None)
    // rust: .corners()
    // rust: {
    // rust: let state = world.block_state(corner)?;
    // rust: let name = &self.resources.registry.state(state).unwrap().name;
    // rust: if matches!(
    // rust: name.as_str(),
    // rust: "minecraft:air"
    // rust: | "minecraft:cave_air"
    // rust: | "minecraft:void_air"
    // rust: | "minecraft:lava"
    // rust: | "minecraft:water"
    // rust: ) {
    // rust: empty += 1;
}
}
    // rust: if empty > self.max_empty_corners {
    // rust: return Ok(false);
}
    // rust: for (template, processors) in [
    // rust: (base, &self.fossil_processors),
    // rust: (overlay, &self.overlay_processors),
    // rust: ] {
    // rust: let mut settings = PlaceSettings::new(rotation).with_processors(processors);
    // rust: settings.bounding_box = Some(bounds);
    // rust: settings.random = Some(&mut *random);
    // rust: place_in_world(
    // rust: world,
    // rust: &self.resources,
    // rust: template,
    // rust: target,
    // rust: target,
    // rust: &mut settings,
    // rust: None,
    // rust: 260,
    // rust: )?;
}
    // rust: Ok(true)
}
}
