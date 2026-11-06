//! Transpiled from Horizon Rust crate
package horizon_world_enhanced_terrain

import "core:fmt"
import "core:mem"
import "core:math"

// Structure libraries' enhanced terrain adaptation: YUNG's API's and
// MoogsStructureLib's, which their Beardifier mixins add to vanilla's
// density. Carried as `"horizon:enhanced_terrain_adaptation"` on a structure
// and on its pool elements (docs/mods.md); the kernel itself is
// [`TerrainKernel`].
// use super::{
    // rust: BoundingBox, Rotation,
    // rust: jigsaw::Projection,
    // rust: start::{Piece, StructureStart},
}
// use crate::worldgen::DecodeError;
// use horizon_core::{
    // rust: density::{KernelJunction, KernelPiece, StructureBounds, TerrainKernel},
    // rust: position::ChunkPos,
}
// use serde_json::Value;
// use std::sync::Arc;

// One adaptation: the kernel, and how a piece's box is moved, padded or
// cut to a band before the kernel measures from it.
Adaptation :: struct {
    kernel: ^TerrainKernel,
    // `bottom_offset`, cast to whole blocks as the libraries do.
    offset: i32,
    // `padding`: x, top, bottom, z.
    padding: [i32,
    band: Maybe(Band),
}
// MoogsStructureLib's band: the kernel measures from `bottom..=top` above
// the piece's floor instead of its whole height, for pieces as tall as one
// of `heights` (any piece without it), and junctions add nothing.
Band :: struct {
    bottom: i32,
    top: i32,
    heights: Maybe([dynamic]i32),
}
    // rust: impl Adaptation {
decode :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let int = |v: &Value, key: &'static str| -> Result<i32, DecodeError> {
    // rust: v[key]
    // rust: .as_i64()
    // rust: .and_then(|n| i32::try_from(n).ok())
    // rust: .ok_or(DecodeError::Field(key))
}
    // rust: let optional = |v: &Value, key: &str| v[key].as_i64().map_or(0, |n| n as i32);
    // rust: let action = |key: &'static str| match v[key].as_str() {
    // rust: Some("bury") => Ok(1),
    // rust: Some("carve") => Ok(-1),
    // rust: Some("none") => Ok(0),
    // rust: _ => Err(DecodeError::Field(key)),
}
    // rust: let size = int(v, "kernel_size")?;
    // rust: let distance = int(v, "kernel_distance")?;
    // rust: if size < 0 || distance < 0 {
    // rust: return Err(DecodeError::Field("kernel_size"));
}
    // rust: let padding = &v["padding"];
    // rust: let band = match v.get("band") {
    // rust: Some(b) => Some(Band {
    // rust: bottom: int(b, "bottom")?,
    // rust: top: int(b, "top")?,
    // rust: heights: b["piece_heights"].as_array().map(|h| {
    // rust: h.iter()
    // rust: .filter_map(Value::as_i64)
    // rust: .map(|n| n as i32)
    // rust: .collect()
    // rust: }),
    // rust: }),
    // rust: None => None,
}
    // rust: Ok(Self {
    // rust: kernel: Arc::new(TerrainKernel::new(
    // rust: size,
    // rust: distance,
    // rust: action("top")?,
    // rust: action("bottom")?,
    // rust: )),
    // rust: offset: v["bottom_offset"].as_f64().unwrap_or(0.) as i32,
    // rust: padding: ["x", "top", "bottom", "z"].map(|k| optional(padding, k)),
    // rust: band,
    // rust: })
}
radius :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.kernel.radius()
}
    // The box the kernel measures from for a piece with this box and
    // rotation; `None` for a band piece of another height.
piece_box :: proc(self: ^Self, original: BoundingBox, rotation: Rotation) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [x, top, bottom, z] = self.padding;
        // The x padding runs along the axis the piece's east turned to.
    // rust: let (px, pz) = match rotation {
    // rust: Rotation::None | Rotation::Clockwise180 => (x, z),
    // rust: Rotation::Clockwise90 | Rotation::Counterclockwise90 => (z, x),
}
    // rust: let mut b = original.moved([0, self.offset, 0]);
    // rust: b.min[0] -= px;
    // rust: b.max[0] += px;
    // rust: b.min[2] -= pz;
    // rust: b.max[2] += pz;
    // rust: match &self.band {
    // rust: Some(band) => {
    // rust: let height = original.max[1] - original.min[1] + 1;
    // rust: if band.heights.as_ref().is_some_and(|h| !h.contains(&height)) {
    // rust: return None;
}
    // rust: let floor = original.min[1] + self.offset;
    // rust: b.min[1] = floor + band.bottom;
    // rust: b.max[1] = floor + band.top;
}
    // rust: None => {
    // rust: b.max[1] += top;
    // rust: b.min[1] -= bottom;
}
}
    // rust: Some(b)
}
}

// A structure's adaptation and its library's rules.
StructureAdaptation :: struct {
    adaptation: ^Adaptation,
    // YUNG's API adds rigid pieces' junctions too; MoogsStructureLib only
    // terrain-matching pieces'.
    rigid_junctions: bool,
    // YUNG's API grows the start's box by the kernel radius, so chunks that
    // far out reference the start.
    inflate: bool,
}
    // rust: impl StructureAdaptation {
decode :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self {
    // rust: adaptation: Arc::new(Adaptation::decode(v)?),
    // rust: rigid_junctions: v["rigid_junctions"].as_bool().unwrap_or(false),
    // rust: inflate: v["inflate"].as_bool().unwrap_or(false),
    // rust: })
}
radius :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.adaptation.radius()
}
    // EnhancedBeardifierHelper.forStructuresInChunk for one start: its
    // kernel pieces and junctions near `chunk`, and the box they reach.
    // rust: pub fn collect(
    // rust: &self,
    // rust: start: &StructureStart,
    // rust: chunk: ChunkPos,
    // rust: pieces: &mut Vec<KernelPiece>,
    // rust: junctions: &mut Vec<KernelJunction>,
    // rust: ) -> Option<BoundingBox> {
    // rust: let reach = start
    // rust: .pieces
    // rust: .iter()
    // rust: .filter_map(|piece| match piece {
    // rust: Piece::Pool(p) => p.element.enhanced_terrain().map(Adaptation::radius),
    // rust: Piece::Legacy(_) => None,
    // rust: })
    // rust: .fold(self.radius(), i32::max);
    // rust: if reach <= 0 {
    // rust: return None;
}
    // rust: let (bx, bz) = (chunk.x * 16, chunk.z * 16);
    // rust: let mut affected: Option<BoundingBox> = None;
    // rust: let mut include = |b: BoundingBox, radius: i32| {
    // rust: let b = b.inflated(radius, radius);
    // rust: match &mut affected {
    // rust: Some(a) => a.encapsulate(&b),
    // rust: None => affected = Some(b),
}
}
    // rust: for piece in &start.pieces {
    // rust: let b = piece.bounding_box();
            // StructurePiece.isCloseToChunk.
    // rust: if !(b.max[0] >= bx - reach
    // rust: && b.min[0] <= bx + 15 + reach
    // rust: && b.max[2] >= bz - reach
    // rust: && b.min[2] <= bz + 15 + reach)
    // rust: {
    // rust: continue;
}
    // rust: let Piece::Pool(pool) = piece else {
    // rust: if let Some(b) = self
    // rust: .adaptation
    // rust: .piece_box(b, Rotation::None)
    // rust: .filter(|_| !self.adaptation.kernel.is_none())
    // rust: {
    // rust: push_piece(pieces, &self.adaptation, b, &mut include);
}
    // rust: continue;
}
    // rust: let adaptation = pool.element.enhanced_terrain().unwrap_or(&self.adaptation);
    // rust: if adaptation.kernel.is_none() {
    // rust: continue;
}
    // rust: let rigid = pool.element.projection() == Projection::Rigid;
    // rust: if rigid {
    // rust: if let Some(b) = adaptation.piece_box(b, pool.rotation) {
    // rust: push_piece(pieces, adaptation, b, &mut include);
}
}
    // rust: if (rigid && !self.rigid_junctions) || adaptation.band.is_some() {
    // rust: continue;
}
    // rust: let radius = adaptation.radius();
    // rust: for j in &pool.junctions {
    // rust: if j.source_x > bx - radius
    // rust: && j.source_z > bz - radius
    // rust: && j.source_x < bx + 15 + radius
    // rust: && j.source_z < bz + 15 + radius
    // rust: {
    // rust: let source = [
    // rust: j.source_x,
    // rust: j.source_ground_y + adaptation.offset,
    // rust: j.source_z,
    // rust: ];
    // rust: junctions.push(KernelJunction {
    // rust: source,
    // rust: kernel: adaptation.kernel.clone(),
    // rust: });
    // rust: include(BoundingBox::new(source, source), radius);
}
}
}
    // rust: affected
}
}

    // rust: fn push_piece(
    // rust: pieces: &mut Vec<KernelPiece>,
    // rust: adaptation: &Adaptation,
    // rust: b: BoundingBox,
    // rust: include: &mut impl FnMut(BoundingBox, i32),
    // rust: ) {
    // Java's BoundingBox puts inverted bounds (a padding below zero) in order.
    // rust: let b = BoundingBox::from_corners(b.min, b.max);
    // rust: let Some(bounds) = StructureBounds::new(b.min, b.max) else {
    // rust: return;
}
    // rust: pieces.push(KernelPiece {
    // rust: bounds,
    // rust: kernel: adaptation.kernel.clone(),
    // rust: });
    // rust: include(b, adaptation.radius());
}

    // rust: mod tests {
//     use super::*;
//     use crate::worldgen::structure::{
    // rust: StructureTemplate,
    // rust: jigsaw::{Junction, PoolElement, PoolPiece},
}
//     use serde_json::json;

adaptation :: proc(v: Value) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Adaptation::decode(&v).unwrap()
}

piece_boxes_move_pad_and_cut_to_bands :: proc() {
}
    // rust: let a = adaptation(
    // rust: json!({"kernel_size": 24, "kernel_distance": 24, "top": "carve",
    // rust: "bottom": "none", "bottom_offset": 2.9,
    // rust: "padding": {"x": 2, "z": 5, "top": 3, "bottom": 1}}),
    // rust: );
    // rust: let b = BoundingBox::new([0, 10, 0], [9, 19, 9]);
        // Offset 2 (truncated), then the paddings.
    // rust: let none = a.piece_box(b, Rotation::None).unwrap();
    // rust: assert_eq!((none.min, none.max), ([-2, 11, -5], [11, 24, 14]));
        // A quarter turn puts the x padding along z.
    // rust: let turned = a.piece_box(b, Rotation::Clockwise90).unwrap();
    // rust: assert_eq!((turned.min, turned.max), ([-5, 11, -2], [14, 24, 11]));
    // rust: let band = adaptation(
    // rust: json!({"kernel_size": 16, "kernel_distance": 8, "top": "carve",
    // rust: "bottom": "carve", "band": {"bottom": 17, "top": 23, "piece_heights": [24, 25]}}),
    // rust: );
    // rust: let tall = band
    // rust: .piece_box(BoundingBox::new([0, 30, 0], [9, 53, 9]), Rotation::None)
    // rust: .unwrap();
    // rust: assert_eq!((tall.min[1], tall.max[1]), (47, 53));
    // rust: assert!(band.piece_box(b, Rotation::None).is_none());
    // rust: assert!(Adaptation::decode(&json!({"kernel_size": 24})).is_err());
}

piece :: proc(element: ^^PoolElement, x: i32, junction: [i32; 3]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Piece::Pool(PoolPiece {
    // rust: element: element.clone(),
    // rust: position: [x, 64, 0],
    // rust: ground_level_delta: 1,
    // rust: rotation: Rotation::None,
    // rust: bounding_box: BoundingBox::new([x, 64, 0], [x + 9, 73, 9]),
    // rust: junctions: vec![Junction {
    // rust: source_x: junction[0],
    // rust: source_ground_y: junction[1],
    // rust: source_z: junction[2],
    // rust: delta_y: 0,
    // rust: dest_projection: Projection::Rigid,
    // rust: }],
    // rust: waterlogging: false,
    // rust: })
}

element :: proc(projection: Projection, own: Maybe(Adaptation)) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Arc::new(PoolElement::Single {
    // rust: template: Arc::new(StructureTemplate::empty()),
    // rust: processors: Default::default(),
    // rust: processors_source: serde_json::Value::Null,
    // rust: legacy: false,
    // rust: projection,
    // rust: waterlogging: None,
    // rust: enhanced_terrain: own.map(Arc::new),
    // rust: ground_level: 1,
    // rust: })
}

    // YUNG's API adds every piece's junctions, MoogsStructureLib only those
    // of pieces that follow the terrain; a piece's own NONE adds nothing,
    // and pieces beyond the kernel's reach of the chunk are left out.
collects_pieces_and_junctions_as_each_library_does :: proc() {
}
    // rust: let rigid = element(Projection::Rigid, None);
    // rust: let matching = element(Projection::TerrainMatching, None);
    // rust: let none = element(
    // rust: Projection::Rigid,
    // rust: Some(adaptation(json!({"kernel_size": 0, "kernel_distance": 0,
    // rust: "top": "none", "bottom": "none"}))),
    // rust: );
    // rust: let start = StructureStart {
    // rust: structure: 0,
    // rust: name: "test".into(),
    // rust: chunk: ChunkPos::new(0, 0),
    // rust: pieces: vec![
    // rust: piece(&rigid, 0, [5, 64, 5]),
    // rust: piece(&matching, 10, [12, 65, 5]),
    // rust: piece(&none, 20, [22, 64, 5]),
    // rust: piece(&rigid, 60, [62, 64, 5]),
    // rust: ],
    // rust: bounding_box: BoundingBox::new([0, 64, 0], [69, 73, 9]),
}
    // rust: let kernel = json!({"kernel_size": 24, "kernel_distance": 24, "top": "carve",
    // rust: "bottom": "none", "bottom_offset": -1});
    // rust: for (yung, junctions) in [(true, 2), (false, 1)] {
    // rust: let mut v = kernel.clone();
    // rust: v["rigid_junctions"] = yung.into();
    // rust: let s = StructureAdaptation::decode(&v).unwrap();
    // rust: let (mut pieces, mut found) = (Vec::new(), Vec::new());
    // rust: let affected = s
    // rust: .collect(&start, ChunkPos::new(0, 0), &mut pieces, &mut found)
    // rust: .unwrap();
    // rust: assert_eq!(pieces.len(), 1, "the rigid piece near the chunk");
    // rust: assert_eq!(pieces[0].bounds.minimum(), [0, 63, 0]);
    // rust: assert_eq!(found.len(), junctions);
    // rust: assert_eq!(found.last().unwrap().source, [12, 64, 5]);
    // rust: assert_eq!((affected.min, affected.max), ([-12, 51, -12], [24, 84, 21]));
}
}
}
