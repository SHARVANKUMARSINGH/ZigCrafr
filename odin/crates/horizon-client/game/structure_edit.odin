//! Transpiled from Horizon Rust crate
package horizon_client_structure_edit

import "core:fmt"
import "core:mem"
import "core:math"

// `StructureBlockEditScreen`: the structure block's name, position, size,
// mode and options, with its buttons laid out as vanilla's.
// use super::{
    // rust: Game,
    // rust: block_editor::{
    // rust: Editor, Item, Outcome, Pos, cycle, footer_action, on_off, valid_character_for_name,
    // rust: },
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: structure_block::{
    // rust: self, StructureBlock, StructureMode, UpdateType, mirror_ordinal, rotation_ordinal,
    // rust: },
    // rust: text::Text,
    // rust: ui::EditBox,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};
// use horizon_world::worldgen::structure::{Mirror, Rotation};

NAME :: 0
POS :: 1
SIZE :: 4
INTEGRITY :: 7
SEED :: 8
DATA :: 9

DONE :: 0
CANCEL :: 1
SAVE :: 2
LOAD :: 3
MODE :: 4
DETECT :: 5
ENTITIES :: 6
STRICT :: 7
MIRROR :: 8
SHOW_AIR :: 9
SHOW_BOX :: 10
// The four rotation buttons, 11 to 14, in `Rotation` order.
ROTATION :: 11

// `StructureBlockEditScreen.DEFAULT_MODES`: every mode but DATA.
    // rust: const DEFAULT_MODES: [StructureMode; 3] = [
    // rust: StructureMode::Save,
    // rust: StructureMode::Load,
    // rust: StructureMode::Corner,
    // rust: ];

// The values the screen restores on Cancel.
Initial :: struct {
    mirror: Mirror,
    rotation: Rotation,
    mode: StructureMode,
    ignore_entities: bool,
    strict: bool,
    show_air: bool,
    show_bounding_box: bool,
}

    // rust: pub(super) struct StructureEditor {
    // rust: edits: Vec<EditBox>,
    // rust: initial: Initial,
}

// `DecimalFormat("0.0###")` of the integrity.
format_integrity :: proc(value: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let text = format!("{:.4}", f64::from(value));
    // rust: let trimmed = text.trim_end_matches('0');
    // rust: if trimmed.ends_with('.') {
    // rust: format!("{trimmed}0")
    // rust: } else {
    // rust: trimmed.to_owned()
}
}

    // rust: impl StructureEditor {
    // rust: pub(super) fn new(b: &StructureBlock) -> Self {
    // rust: let edit = |max: usize, value: String| {
    // rust: let mut e = EditBox::new(0.0, 0.0, 80.0, 20.0);
    // rust: e.max_length = max;
    // rust: e.set_value(&value);
    // rust: e.focused = false;
    // rust: e
}
    // rust: let mut edits = vec![edit(128, b.structure_name().to_owned())];
    // rust: edits.extend(b.pos.map(|v| edit(15, v.to_string())));
    // rust: edits.extend(b.size.map(|v| edit(15, v.to_string())));
    // rust: edits.push(edit(15, format_integrity(b.integrity)));
    // rust: edits.push(edit(31, b.seed.to_string()));
    // rust: edits.push(edit(128, b.metadata.clone()));
    // rust: Self {
    // rust: edits,
    // rust: initial: Initial {
    // rust: mirror: b.mirror,
    // rust: rotation: b.rotation,
    // rust: mode: b.mode,
    // rust: ignore_entities: b.ignore_entities,
    // rust: strict: b.strict,
    // rust: show_air: b.show_air,
    // rust: show_bounding_box: b.show_bounding_box,
    // rust: },
}
}

value :: proc(self: ^Self, i: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.edits[i].value
}
coordinate :: proc(self: ^Self, i: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.value(i).parse().unwrap_or(0)
}

    // `sendToServer`.
packet :: proc(self: ^Self, b: ^StructureBlock, pos: Pos, update: UpdateType) -> S {
    // Ported from Horizon
    return {}
}
    // rust: S::SetStructureBlock(play::SetStructureBlock {
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: update_type: update.ordinal(),
    // rust: mode: b.mode.ordinal(),
    // rust: name: self.value(NAME).to_owned(),
    // rust: offset: [0, 1, 2].map(|i| self.coordinate(POS + i)),
    // rust: size: [0, 1, 2].map(|i| self.coordinate(SIZE + i)),
    // rust: mirror: mirror_ordinal(b.mirror),
    // rust: rotation: rotation_ordinal(b.rotation),
    // rust: data: self.value(DATA).to_owned(),
    // rust: ignore_entities: b.ignore_entities,
    // rust: strict: b.strict,
    // rust: show_air: b.show_air,
    // rust: show_bounding_box: b.show_bounding_box,
    // rust: integrity: self.value(INTEGRITY).trim().parse().unwrap_or(1.0),
    // rust: seed: self.value(SEED).parse().unwrap_or(0),
    // rust: })
}
}

mirror_key :: proc(mirror: Mirror) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match mirror {
    // rust: Mirror::None => "mirror.none",
    // rust: Mirror::LeftRight => "mirror.left_right",
    // rust: Mirror::FrontBack => "mirror.front_back",
}
}

    // rust: impl Editor for StructureEditor {
edits :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.edits
}

items :: proc(self: ^Self, entity: ^BlockEntity, w: f32, _h: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let BlockEntity::StructureBlock(b) = entity else {
    // rust: return Vec::new();
}
    // rust: let mid = (w / 2.0).floor();
    // rust: let tr = |key: &str| Text::translate(key, &[]);
    // rust: let label = |key: &str, x: f32, y: f32, right: bool| Item::Label {
    // rust: text: tr(key),
    // rust: x,
    // rust: y,
    // rust: right,
}
    // rust: let button = |id: u8, x: f32, bw: f32, y: f32, text: Text, active: bool| Item::Button {
    // rust: id,
    // rust: x,
    // rust: y,
    // rust: w: bw,
    // rust: label: text,
    // rust: active,
    // rust: action: footer_action(id, DONE, CANCEL),
}
    // rust: let edit = |index: usize, x: f32, y: f32, ew: f32| Item::Edit { index, x, y, w: ew };
    // rust: let mode = b.mode;
    // rust: let mut items = vec![
    // rust: button(DONE, mid - 4.0 - 150.0, 150.0, 210.0, tr("gui.done"), true),
    // rust: button(CANCEL, mid + 4.0, 150.0, 210.0, tr("gui.cancel"), true),
    // rust: button(
    // rust: MODE,
    // rust: mid - 4.0 - 150.0,
    // rust: 50.0,
    // rust: 185.0,
    // rust: tr(&mode.label_key()),
    // rust: true,
    // rust: ),
    // rust: ];
    // rust: let right = mid + 4.0 + 100.0;
    // rust: let saving = mode == StructureMode::Save;
    // rust: let loading = mode == StructureMode::Load;
    // rust: if saving {
    // rust: items.push(button(
    // rust: SAVE,
    // rust: right,
    // rust: 50.0,
    // rust: 185.0,
    // rust: tr("structure_block.button.save"),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: DETECT,
    // rust: right,
    // rust: 50.0,
    // rust: 120.0,
    // rust: tr("structure_block.button.detect_size"),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: SHOW_AIR,
    // rust: right,
    // rust: 50.0,
    // rust: 80.0,
    // rust: on_off(b.show_air),
    // rust: true,
    // rust: ));
}
    // rust: if loading {
    // rust: items.push(button(
    // rust: LOAD,
    // rust: right,
    // rust: 50.0,
    // rust: 185.0,
    // rust: tr("structure_block.button.load"),
    // rust: true,
    // rust: ));
    // rust: items.push(button(STRICT, right, 50.0, 120.0, on_off(b.strict), true));
    // rust: items.push(button(
    // rust: MIRROR,
    // rust: mid - 20.0,
    // rust: 40.0,
    // rust: 185.0,
    // rust: tr(mirror_key(b.mirror)),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: SHOW_BOX,
    // rust: right,
    // rust: 50.0,
    // rust: 80.0,
    // rust: on_off(b.show_bounding_box),
    // rust: true,
    // rust: ));
    // rust: for (i, (x, name)) in [
    // rust: (mid - 1.0 - 40.0 - 1.0 - 40.0 - 20.0, "0"),
    // rust: (mid - 1.0 - 40.0 - 20.0, "90"),
    // rust: (mid + 1.0 + 20.0, "180"),
    // rust: (mid + 1.0 + 40.0 + 1.0 + 20.0, "270"),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: items.push(button(
    // rust: ROTATION + i as u8,
    // rust: x,
    // rust: 40.0,
    // rust: 185.0,
    // rust: Text::literal(name),
    // rust: rotation_ordinal(b.rotation) != i as i32,
    // rust: ));
}
}
    // rust: if saving || loading {
    // rust: items.push(button(
    // rust: ENTITIES,
    // rust: right,
    // rust: 50.0,
    // rust: 160.0,
    // rust: on_off(!b.ignore_entities),
    // rust: true,
    // rust: ));
}
    // rust: items.push(Item::Title {
    // rust: text: tr("block.minecraft.structure_block"),
    // rust: y: 10.0,
    // rust: });
    // rust: if mode != StructureMode::Data {
    // rust: items.push(label(
    // rust: "structure_block.structure_name",
    // rust: mid - 153.0,
    // rust: 30.0,
    // rust: false,
    // rust: ));
    // rust: items.push(edit(NAME, mid - 152.0, 40.0, 300.0));
}
    // rust: if saving || loading {
    // rust: items.push(label("structure_block.position", mid - 153.0, 70.0, false));
    // rust: for (i, x) in [-152.0, -72.0, 8.0].into_iter().enumerate() {
    // rust: items.push(edit(POS + i, mid + x, 80.0, 80.0));
}
    // rust: items.push(label(
    // rust: "structure_block.include_entities",
    // rust: mid + 154.0,
    // rust: 150.0,
    // rust: true,
    // rust: ));
}
    // rust: if saving {
    // rust: items.push(label("structure_block.size", mid - 153.0, 110.0, false));
    // rust: for (i, x) in [-152.0, -72.0, 8.0].into_iter().enumerate() {
    // rust: items.push(edit(SIZE + i, mid + x, 120.0, 80.0));
}
    // rust: items.push(label(
    // rust: "structure_block.detect_size",
    // rust: mid + 154.0,
    // rust: 110.0,
    // rust: true,
    // rust: ));
    // rust: items.push(label("structure_block.show_air", mid + 154.0, 70.0, true));
}
    // rust: if loading {
    // rust: items.push(label(
    // rust: "structure_block.integrity",
    // rust: mid - 153.0,
    // rust: 110.0,
    // rust: false,
    // rust: ));
    // rust: items.push(edit(INTEGRITY, mid - 152.0, 120.0, 80.0));
    // rust: items.push(edit(SEED, mid - 72.0, 120.0, 80.0));
    // rust: items.push(label("structure_block.strict", mid + 154.0, 110.0, true));
    // rust: items.push(label(
    // rust: "structure_block.show_boundingbox",
    // rust: mid + 154.0,
    // rust: 70.0,
    // rust: true,
    // rust: ));
}
    // rust: if mode == StructureMode::Data {
    // rust: items.push(label(
    // rust: "structure_block.custom_data",
    // rust: mid - 153.0,
    // rust: 110.0,
    // rust: false,
    // rust: ));
    // rust: items.push(edit(DATA, mid - 152.0, 120.0, 240.0));
}
    // rust: items.push(Item::Label {
    // rust: text: tr(&mode.info_key()),
    // rust: x: mid - 153.0,
    // rust: y: 174.0,
    // rust: right: false,
    // rust: });
    // rust: items
}

    // rust: fn press(
    // rust: &mut self,
    // rust: entity: &mut BlockEntity,
    // rust: pos: Pos,
    // rust: id: u8,
    // rust: shift: bool,
    // rust: alt: bool,
    // rust: ) -> Outcome {
    // rust: let BlockEntity::StructureBlock(b) = entity else {
    // rust: return Outcome::Cancel;
}
    // rust: let delta = if shift { -1 } else { 1 };
    // rust: match id {
    // rust: DONE => return self.done(entity, pos),
    // rust: CANCEL => {
    // rust: self.cancel(entity);
    // rust: return Outcome::Cancel;
}
    // rust: SAVE if b.mode == StructureMode::Save => {
    // rust: return Outcome::Send(self.packet(b, pos, UpdateType::SaveArea));
}
    // rust: LOAD if b.mode == StructureMode::Load => {
    // rust: return Outcome::Send(self.packet(b, pos, UpdateType::LoadArea));
}
    // rust: DETECT if b.mode == StructureMode::Save => {
    // rust: return Outcome::Send(self.packet(b, pos, UpdateType::ScanArea));
}
    // rust: MODE => {
                // Alt cycles through DATA too.
    // rust: b.mode = if alt {
    // rust: cycle(&StructureMode::ALL, b.mode, delta)
    // rust: } else {
    // rust: cycle(&DEFAULT_MODES, b.mode, delta)
}
}
    // rust: ENTITIES => b.ignore_entities = !b.ignore_entities,
    // rust: STRICT => b.strict = !b.strict,
    // rust: MIRROR => {
    // rust: let all = [Mirror::None, Mirror::LeftRight, Mirror::FrontBack];
    // rust: b.mirror = cycle(&all, b.mirror, delta);
}
    // rust: SHOW_AIR => b.show_air = !b.show_air,
    // rust: SHOW_BOX => b.show_bounding_box = !b.show_bounding_box,
    // rust: ROTATION..=14 => {
    // rust: if let Some(r) = structure_block::rotation_from_ordinal(i32::from(id - ROTATION)) {
    // rust: b.rotation = r;
}
}
    // rust: _ => {}
}
    // rust: Outcome::Stay
}

done :: proc(self: ^Self, entity: ^BlockEntity, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match entity {
    // rust: BlockEntity::StructureBlock(b) => {
    // rust: Outcome::Send(self.packet(b, pos, UpdateType::UpdateData))
}
    // rust: _ => Outcome::Cancel,
}
}

cancel :: proc(self: ^Self, entity: ^BlockEntity) {
}
    // rust: if let BlockEntity::StructureBlock(b) = entity {
    // rust: let i = &self.initial;
    // rust: b.mirror = i.mirror;
    // rust: b.rotation = i.rotation;
    // rust: b.mode = i.mode;
    // rust: b.ignore_entities = i.ignore_entities;
    // rust: b.strict = i.strict;
    // rust: b.show_air = i.show_air;
    // rust: b.show_bounding_box = i.show_bounding_box;
}
}

accepts :: proc(self: ^Self, edit: uint, current: string, cursor: uint, c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: edit != NAME || valid_character_for_name(current, c, cursor)
}
}

    // rust: impl Game<'_> {
    // `LocalPlayer.openStructureBlock`.
    // rust: pub(super) fn open_structure_block(&mut self, pos: Pos) {
    // rust: let Some(BlockEntity::StructureBlock(b)) = self.world.block_entities.get(&pos) else {
    // rust: return;
}
    // rust: let editor = StructureEditor::new(b);
    // rust: self.open_block_editor(pos, Box::new(editor));
}
}

    // rust: mod tests {
//     use super::*;

integrity_formats_like_decimal_format :: proc() {
}
    // rust: assert_eq!(format_integrity(1.0), "1.0");
    // rust: assert_eq!(format_integrity(0.25), "0.25");
    // rust: assert_eq!(format_integrity(0.5), "0.5");
    // rust: assert_eq!(format_integrity(0.1), "0.1");
    // rust: assert_eq!(format_integrity(0.123_456), "0.1235");
}

done_sends_the_screens_values :: proc() {
}
    // rust: let mut block = StructureBlock::new(StructureMode::Save);
    // rust: block.set_structure_name("house");
    // rust: block.size = [3, 4, 5];
    // rust: let mut editor = StructureEditor::new(&block);
    // rust: editor.edits[POS].set_value("-2");
    // rust: editor.edits[SIZE].set_value("junk");
    // rust: editor.edits[INTEGRITY].set_value("0.5");
    // rust: let mut entity = BlockEntity::StructureBlock(Box::new(block));
    // rust: let Outcome::Send(S::SetStructureBlock(p)) = editor.done(&mut entity, (1, 2, 3)) else {
    // rust: panic!("done sends")
}
    // rust: assert_eq!(p.pos, [1, 2, 3]);
    // rust: assert_eq!(p.update_type, UpdateType::UpdateData.ordinal());
    // rust: assert_eq!(p.name, "minecraft:house");
        // An unparsable coordinate is 0, as `parseCoordinate`.
    // rust: assert_eq!((p.offset, p.size), ([-2, 1, 0], [0, 4, 5]));
    // rust: assert_eq!(p.integrity, 0.5);
}

cancel_puts_back_what_the_buttons_changed :: proc() {
}
    // rust: let block = StructureBlock::new(StructureMode::Load);
    // rust: let mut editor = StructureEditor::new(&block);
    // rust: let mut entity = BlockEntity::StructureBlock(Box::new(block));
    // rust: editor.press(&mut entity, (0, 0, 0), ROTATION + 2, false, false);
    // rust: editor.press(&mut entity, (0, 0, 0), STRICT, false, false);
    // rust: editor.press(&mut entity, (0, 0, 0), MODE, false, false);
    // rust: let BlockEntity::StructureBlock(b) = &entity else {
    // rust: unreachable!()
}
    // rust: assert_eq!(b.rotation, Rotation::Clockwise180);
    // rust: assert!(b.strict);
    // rust: assert_eq!(b.mode, StructureMode::Corner);
    // rust: editor.cancel(&mut entity);
    // rust: let BlockEntity::StructureBlock(b) = &entity else {
    // rust: unreachable!()
}
    // rust: assert_eq!(
    // rust: (b.rotation, b.strict, b.mode),
    // rust: (Rotation::None, false, StructureMode::Load)
    // rust: );
}

the_mode_button_skips_data_unless_alt_is_held :: proc() {
}
    // rust: let block = StructureBlock::new(StructureMode::Corner);
    // rust: let mut editor = StructureEditor::new(&block);
    // rust: let mut entity = BlockEntity::StructureBlock(Box::new(block));
    // rust: editor.press(&mut entity, (0, 0, 0), MODE, false, false);
    // rust: let BlockEntity::StructureBlock(b) = &entity else {
    // rust: unreachable!()
}
    // rust: assert_eq!(b.mode, StructureMode::Save);
    // rust: b_mode(&mut entity, StructureMode::Corner);
    // rust: editor.press(&mut entity, (0, 0, 0), MODE, false, true);
    // rust: let BlockEntity::StructureBlock(b) = &entity else {
    // rust: unreachable!()
}
    // rust: assert_eq!(b.mode, StructureMode::Data);
}

b_mode :: proc(entity: ^BlockEntity, mode: StructureMode) {
}
    // rust: if let BlockEntity::StructureBlock(b) = entity {
    // rust: b.mode = mode;
}
}
}
