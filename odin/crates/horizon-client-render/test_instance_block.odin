//! Transpiled from Horizon Rust crate
package horizon_client_render_test_instance_block

import "core:fmt"
import "core:mem"
import "core:math"

// `TestInstanceBlockEntity`: the test instance block's test, size, rotation
// and status, its error markers, and the boxes derived from them.
// use horizon_client_core::nbt_value::{number, string, text};
// use horizon_world::{
    // rust: nbt::Tag,
    // rust: worldgen::structure::{BoundingBox, Rotation},
}

// `STRUCTURE_OFFSET`: where the structure starts from the block.
STRUCTURE_OFFSET :: [0, 1, 1]

// `TestInstanceBlockEntity.Status`.
Status :: enum {
    Cleared,
    Running,
    Finished,
}

    // rust: impl Status {
serialized_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Cleared => "cleared",
    // rust: Self::Running => "running",
    // rust: Self::Finished => "finished",
}
}
of_serialized_name :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: [Self::Cleared, Self::Running, Self::Finished]
    // rust: .into_iter()
    // rust: .find(|s| s.serialized_name() == name)
}
index :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self as i32
}
    // `Status.byIndex`: out of range is CLEARED.
by_index :: proc(index: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match index {
    // rust: 1 => Self::Running,
    // rust: 2 => Self::Finished,
    // rust: _ => Self::Cleared,
}
}
}

// `TestInstanceBlockEntity.Data`. Components are kept as the NBT they are
// sent and saved as.
Data :: struct {
    // The test's registry id.
    test: Maybe(string),
    size: [i32,
    rotation: Rotation,
    ignore_entities: bool,
    status: Status,
    error_message: Maybe(Tag),
}

    // rust: impl Default for Data {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: test: None,
    // rust: size: [0; 3],
    // rust: rotation: Rotation::None,
    // rust: ignore_entities: false,
    // rust: status: Status::Cleared,
    // rust: error_message: None,
}
}
}

    // rust: impl Data {
    // `Data.CODEC` encoded.
save :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = Vec::new();
    // rust: if let Some(test) = &self.test {
    // rust: entries.push(("test", string(test)));
}
    // rust: entries.push(("size", Tag::IntArray(self.size.to_vec())));
    // rust: entries.push(("rotation", string(self.rotation.serialized_name())));
    // rust: entries.push(("ignore_entities", Tag::Byte(i8::from(self.ignore_entities))));
    // rust: entries.push(("status", string(self.status.serialized_name())));
    // rust: if let Some(error) = &self.error_message {
    // rust: entries.push(("error_message", error.clone()));
}
    // rust: Tag::compound(entries)
}

    // `Data.CODEC` decoded: size, rotation, ignore_entities and status are
    // required, or the whole value is dropped.
load :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let size = match tag.get("size")? {
    // rust: Tag::IntArray(v) if v.len() == 3 => [v[0], v[1], v[2]],
    // rust: _ => return None,
}
    // rust: Some(Self {
    // rust: test: text(tag.get("test")),
    // rust: size,
    // rust: rotation: Rotation::from_name(&text(tag.get("rotation"))?)?,
    // rust: ignore_entities: number(tag.get("ignore_entities")).map(|v| v != 0)?,
    // rust: status: Status::of_serialized_name(&text(tag.get("status"))?)?,
    // rust: error_message: tag.get("error_message").cloned(),
    // rust: })
}
}

// `TestInstanceBlockEntity.ErrorMarker`.
ErrorMarker :: struct {
    pos: [i32,
    text: Tag,
}

TestInstanceBlock :: struct {
    data: Data,
    error_markers: [dynamic]ErrorMarker,
}

    // rust: impl TestInstanceBlock {
    // `saveAdditional` (also `getUpdateTag`, which is `saveCustomOnly`).
save :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = vec![("data", self.data.save())];
    // rust: if !self.error_markers.is_empty() {
    // rust: let markers = self
    // rust: .error_markers
    // rust: .iter()
    // rust: .map(|m| {
    // rust: Tag::compound([
    // rust: ("pos", Tag::IntArray(m.pos.to_vec())),
    // rust: ("text", m.text.clone()),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: entries.push(("errors", Tag::List(markers)));
}
    // rust: entries
}

    // `loadAdditional`: the data is replaced only when it decodes, and the
    // markers are always replaced.
load :: proc(self: ^Self, tag: ^Tag) {
}
    // rust: if let Some(data) = tag.get("data").and_then(Data::load) {
    // rust: self.data = data;
}
    // rust: self.error_markers.clear();
    // rust: if let Some(Tag::List(markers)) = tag.get("errors") {
    // rust: for m in markers {
    // rust: if let (Some(Tag::IntArray(p)), Some(text)) = (m.get("pos"), m.get("text"))
    // rust: && p.len() == 3
    // rust: {
    // rust: self.error_markers.push(ErrorMarker {
    // rust: pos: [p[0], p[1], p[2]],
    // rust: text: text.clone(),
    // rust: });
}
}
}
}

    // `getStructurePos(blockPos)`.
structure_pos_of :: proc(block: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [0, 1, 2].map(|i| block[i] + STRUCTURE_OFFSET[i])
}

    // `getTransformedSize`: the size with the axes swapped for a quarter turn.
transformed_size :: proc(size: [i32; 3], rotation: Rotation) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(
    // rust: rotation,
    // rust: Rotation::Clockwise90 | Rotation::Counterclockwise90
    // rust: ) {
    // rust: [size[2], size[1], size[0]]
    // rust: } else {
    // rust: size
}
}

    // `getRenderableBox`: the offset from the block and the size to draw,
    // given the test's `padding` and rotation.
renderable_box :: proc(self: ^Self, padding: i32, rotation: Rotation) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let offset = STRUCTURE_OFFSET.map(|o| o + padding);
    // rust: (offset, Self::transformed_size(self.data.size, rotation))
}

    // `getStructureBoundingBox`.
structure_box :: proc(self: ^Self, block: [i32; 3], padding: i32, rotation: Rotation) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let corner = Self::structure_pos_of([0, 1, 2].map(|i| block[i] + padding));
    // rust: let size = Self::transformed_size(self.data.size, rotation);
    // rust: BoundingBox::from_corners(corner, [0, 1, 2].map(|i| corner[i] + size[i] - 1))
}

    // `getStartCorner`: the corner the template is placed from.
start_corner :: proc(self: ^Self, block: [i32; 3], padding: i32, rotation: Rotation) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [x, _, z] = self.data.size;
    // rust: let c = Self::structure_pos_of([0, 1, 2].map(|i| block[i] + padding));
    // rust: match rotation {
    // rust: Rotation::None => c,
    // rust: Rotation::Clockwise90 => [c[0] + z - 1, c[1], c[2]],
    // rust: Rotation::Clockwise180 => [c[0] + x - 1, c[1], c[2] + z - 1],
    // rust: Rotation::Counterclockwise90 => [c[0], c[1], c[2] + x - 1],
}
}
}

    // rust: mod tests {
//     use super::*;

sample :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: TestInstanceBlock {
    // rust: data: Data {
    // rust: test: Some("minecraft:always_pass".into()),
    // rust: size: [3, 4, 5],
    // rust: rotation: Rotation::Clockwise180,
    // rust: ignore_entities: true,
    // rust: status: Status::Finished,
    // rust: error_message: Some(string("boom")),
    // rust: },
    // rust: error_markers: vec![ErrorMarker {
    // rust: pos: [1, 2, 3],
    // rust: text: string("here"),
    // rust: }],
}
}

saves_and_loads_like_test_instance_block_entity :: proc() {
}
    // rust: let block = sample();
    // rust: let tag = Tag::compound(block.save());
    // rust: assert_eq!(
    // rust: text(tag.get("data").unwrap().get("rotation")).as_deref(),
    // rust: Some("180")
    // rust: );
    // rust: let mut loaded = TestInstanceBlock::default();
    // rust: loaded.load(&tag);
    // rust: assert_eq!(loaded, block);
        // No markers, no `errors` key; a bad `data` leaves the old one.
    // rust: let mut plain = block.clone();
    // rust: plain.error_markers.clear();
    // rust: assert!(Tag::compound(plain.save()).get("errors").is_none());
    // rust: let mut kept = block;
    // rust: kept.load(&Tag::compound([(
    // rust: "data",
    // rust: Tag::compound(Vec::<(&str, Tag)>::new()),
    // rust: )]));
    // rust: assert_eq!(kept.data.test.as_deref(), Some("minecraft:always_pass"));
    // rust: assert!(kept.error_markers.is_empty());
}

boxes_follow_padding_and_rotation :: proc() {
}
    // rust: let block = sample();
        // A quarter turn swaps the horizontal sizes.
    // rust: let (offset, size) = block.renderable_box(2, Rotation::Clockwise90);
    // rust: assert_eq!((offset, size), ([2, 3, 3], [5, 4, 3]));
    // rust: let bounds = block.structure_box([10, 64, 10], 2, Rotation::None);
    // rust: assert_eq!(bounds.min, [12, 67, 13]);
    // rust: assert_eq!(bounds.max, [14, 70, 17]);
    // rust: assert_eq!(
    // rust: block.start_corner([10, 64, 10], 2, Rotation::Counterclockwise90),
    // rust: [12, 67, 15]
    // rust: );
    // rust: assert_eq!(Status::by_index(7), Status::Cleared);
}
}
