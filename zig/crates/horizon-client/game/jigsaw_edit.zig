//! Transpiled from Horizon Rust crate
//! Module: horizon-client_jigsaw_edit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `JigsawBlockEditScreen`: the jigsaw block's pool, name, target, final
//! state, priorities and joint, with the Generate button and its levels.
// use super::{
    // rust: Game,
    // rust: block_editor::{Editor, Item, Outcome, Pos, cycle, footer_action, on_off},
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: jigsaw_block::{JigsawBlock, JointType, is_vertical_front},
    // rust: structure_block::parse_identifier,
    // rust: text::Text,
    // rust: ui::EditBox,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};

pub const POOL: usize = 0;
pub const NAME: usize = 1;
pub const TARGET: usize = 2;
pub const FINAL_STATE: usize = 3;
pub const SELECTION_PRIORITY: usize = 4;
pub const PLACEMENT_PRIORITY: usize = 5;

pub const DONE: u8 = 0;
pub const CANCEL: u8 = 1;
pub const JOINT: u8 = 2;
pub const LEVELS: u8 = 3;
pub const KEEP_JIGSAWS: u8 = 4;
pub const GENERATE: u8 = 5;

/// `JigsawBlockEditScreen.levels`' range: `clampedLerp(value, 0, 20)`.
pub const MAX_LEVELS: f32 = 20.0;

    // rust: pub(super) struct JigsawEditor {
    // rust: edits: Vec<EditBox>,
    // rust: joint: JointType,
    /// The block faces up or down: only then is the joint chosen.
    // rust: vertical: bool,
    // rust: levels: i32,
    /// The slider's position (0..1), as the player left it.
    // rust: slider: f32,
    // rust: keep_jigsaws: bool,
}

    // rust: impl JigsawEditor {
    // rust: pub(super) fn new(b: &JigsawBlock, vertical: bool) -> Self {
    // rust: let edit = |max: usize, value: String| {
    // rust: let mut e = EditBox::new(0.0, 0.0, 98.0, 20.0);
    // rust: e.max_length = max;
    // rust: e.set_value(&value);
    // rust: e.focused = false;
    // rust: e
}
    // rust: Self {
    // rust: edits: vec![
    // rust: edit(128, b.pool.clone()),
    // rust: edit(128, b.name.clone()),
    // rust: edit(128, b.target.clone()),
    // rust: edit(256, b.final_state.clone()),
    // rust: edit(3, b.selection_priority.to_string()),
    // rust: edit(3, b.placement_priority.to_string()),
    // rust: ],
    // rust: joint: b.joint,
    // rust: vertical,
    // rust: levels: 0,
    // rust: slider: 0.0,
    // rust: keep_jigsaws: false,
}
}

pub fn value(self: *Self, i: usize) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.edits[i].value
}

    /// `updateValidity`: Done and Generate need three legal identifiers.
pub fn valid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [NAME, TARGET, POOL]
    // rust: .into_iter()
    // rust: .all(|i| parse_identifier(self.value(i)).is_some())
}

    /// `parseAsInt`.
pub fn int(self: *Self, i: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(i).parse().unwrap_or(0)
}

    /// `sendToServer`.
pub fn set_packet(self: *Self, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = |i: usize| parse_identifier(self.value(i));
    // rust: Some(S::SetJigsawBlock(play::SetJigsawBlock {
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: name: id(NAME)?,
    // rust: target: id(TARGET)?,
    // rust: pool: id(POOL)?,
    // rust: final_state: self.value(FINAL_STATE).to_owned(),
    // rust: joint: self.joint.serialized_name().to_owned(),
    // rust: selection_priority: self.int(SELECTION_PRIORITY),
    // rust: placement_priority: self.int(PLACEMENT_PRIORITY),
    // rust: }))
}

pub fn generate_packet(self: *Self, pos: Pos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: S::JigsawGenerate(play::JigsawGenerate {
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: levels: self.levels,
    // rust: keep_jigsaws: self.keep_jigsaws,
    // rust: })
}
}

    // rust: impl Editor for JigsawEditor {
pub fn edits(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.edits
}

pub fn items(self: *Self, _entity: *BlockEntity, w: f32, _h: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mid = (w / 2.0).floor();
    // rust: let tr = |key: &str| Text::translate(key, &[]);
    // rust: let valid = self.valid();
    // rust: let button = |id: u8, x: f32, bw: f32, y: f32, text: Text, active: bool| Item::Button {
    // rust: id,
    // rust: x,
    // rust: y,
    // rust: w: bw,
    // rust: label: text,
    // rust: active,
    // rust: action: footer_action(id, DONE, CANCEL),
}
    // rust: let label = |key: &str, x: f32, y: f32| Item::Label {
    // rust: text: tr(key),
    // rust: x,
    // rust: y,
    // rust: right: false,
}
    // rust: let edit = |index: usize, x: f32, y: f32, ew: f32| Item::Edit { index, x, y, w: ew };
    // rust: let mut items = Vec::new();
    // rust: if self.vertical {
    // rust: items.push(button(
    // rust: JOINT,
    // rust: mid + 54.0,
    // rust: 100.0,
    // rust: 160.0,
    // rust: tr(&self.joint.label_key()),
    // rust: true,
    // rust: ));
}
    // rust: items.push(Item::Slider {
    // rust: id: LEVELS,
    // rust: x: mid - 154.0,
    // rust: y: 185.0,
    // rust: w: 100.0,
    // rust: label: Text::translate(
    // rust: "jigsaw_block.levels",
    // rust: &[Text::literal(self.levels.to_string())],
    // rust: ),
    // rust: value: self.slider,
    // rust: });
    // rust: items.push(button(
    // rust: KEEP_JIGSAWS,
    // rust: mid - 50.0,
    // rust: 100.0,
    // rust: 185.0,
    // rust: Text::translate(
    // rust: "options.generic_value",
    // rust: &[tr("jigsaw_block.keep_jigsaws"), on_off(self.keep_jigsaws)],
    // rust: ),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: GENERATE,
    // rust: mid + 54.0,
    // rust: 100.0,
    // rust: 185.0,
    // rust: tr("jigsaw_block.generate"),
    // rust: valid,
    // rust: ));
    // rust: items.push(button(
    // rust: DONE,
    // rust: mid - 4.0 - 150.0,
    // rust: 150.0,
    // rust: 210.0,
    // rust: tr("gui.done"),
    // rust: valid,
    // rust: ));
    // rust: items.push(button(
    // rust: CANCEL,
    // rust: mid + 4.0,
    // rust: 150.0,
    // rust: 210.0,
    // rust: tr("gui.cancel"),
    // rust: true,
    // rust: ));
        // The boxes in the order they are added; the labels are drawn with them.
    // rust: items.push(label("jigsaw_block.pool", mid - 153.0, 10.0));
    // rust: items.push(edit(POOL, mid - 153.0, 20.0, 300.0));
    // rust: items.push(label("jigsaw_block.name", mid - 153.0, 45.0));
    // rust: items.push(edit(NAME, mid - 153.0, 55.0, 300.0));
    // rust: items.push(label("jigsaw_block.target", mid - 153.0, 80.0));
    // rust: items.push(edit(TARGET, mid - 153.0, 90.0, 300.0));
    // rust: items.push(label("jigsaw_block.final_state", mid - 153.0, 115.0));
    // rust: items.push(edit(FINAL_STATE, mid - 153.0, 125.0, 300.0));
    // rust: items.push(label("jigsaw_block.selection_priority", mid - 153.0, 150.0));
    // rust: items.push(edit(PLACEMENT_PRIORITY, mid - 50.0, 160.0, 98.0));
    // rust: items.push(label("jigsaw_block.placement_priority", mid - 50.0, 150.0));
    // rust: items.push(edit(SELECTION_PRIORITY, mid - 153.0, 160.0, 98.0));
    // rust: if self.vertical {
    // rust: items.push(label("jigsaw_block.joint_label", mid + 53.0, 150.0));
}
    // rust: items
}

    // rust: fn press(
    // rust: &mut self,
    // rust: entity: &mut BlockEntity,
    // rust: pos: Pos,
    // rust: id: u8,
    // rust: shift: bool,
    // rust: _alt: bool,
    // rust: ) -> Outcome {
    // rust: let delta = if shift { -1 } else { 1 };
    // rust: match id {
    // rust: DONE => return self.done(entity, pos),
    // rust: CANCEL => return Outcome::Cancel,
    // rust: JOINT if self.vertical => self.joint = cycle(&JointType::ALL, self.joint, delta),
    // rust: KEEP_JIGSAWS => self.keep_jigsaws = !self.keep_jigsaws,
    // rust: GENERATE if self.valid() => {
                // onDone(); sendGenerate().
    // rust: if let Some(set) = self.set_packet(pos) {
    // rust: return Outcome::SendAll(vec![set, self.generate_packet(pos)]);
}
}
    // rust: _ => {}
}
    // rust: Outcome::Stay
}

pub fn slide(self: *Self, id: u8, value: f32) void {
}
    // rust: if id == LEVELS {
            // Mth.floor(Mth.clampedLerp(value, 0.0, 20.0)).
    // rust: self.slider = value.clamp(0.0, 1.0);
    // rust: self.levels = (self.slider * MAX_LEVELS).floor() as i32;
}
}

pub fn done(self: *Self, _entity: *mut BlockEntity, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Enter confirms only while the Done button is active.
    // rust: match self.valid().then(|| self.set_packet(pos)).flatten() {
    // rust: Some(set) => Outcome::Send(set),
    // rust: None => Outcome::Stay,
}
}

pub fn cancel(self: *Self, _entity: *mut BlockEntity) void {
}
}

    // rust: impl Game<'_> {
    /// `LocalPlayer.openJigsawBlock`.
    // rust: pub(super) fn open_jigsaw_block(&mut self, pos: Pos) {
    // rust: let Some(BlockEntity::JigsawBlock(b)) = self.world.block_entities.get(&pos) else {
    // rust: return;
}
    // rust: let vertical = self
    // rust: .jigsaw_front(pos)
    // rust: .is_some_and(|f| is_vertical_front(&f));
    // rust: let editor = JigsawEditor::new(b, vertical);
    // rust: self.open_block_editor(pos, Box::new(editor));
}
}

    // rust: mod tests {
//     use super::*;

pub fn editor() J {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = JigsawBlock {
    // rust: name: "minecraft:bottom".into(),
    // rust: target: "minecraft:top".into(),
    // rust: pool: "minecraft:village/plains/houses".into(),
    // rust: ..JigsawBlock::default()
}
    // rust: JigsawEditor::new(&b, true)
}

pub fn done_sends_the_screens_values_with_parsed_priorities() void {
}
    // rust: let mut e = editor();
    // rust: e.edits[SELECTION_PRIORITY].set_value("7");
    // rust: e.edits[PLACEMENT_PRIORITY].set_value("junk");
    // rust: e.edits[TARGET].set_value("door");
    // rust: let mut entity = BlockEntity::JigsawBlock(Box::default());
    // rust: let Outcome::Send(S::SetJigsawBlock(p)) = e.done(&mut entity, (1, 2, 3)) else {
    // rust: panic!("done sends the block");
}
    // rust: assert_eq!(p.pos, [1, 2, 3]);
    // rust: assert_eq!(p.target, "minecraft:door");
    // rust: assert_eq!((p.selection_priority, p.placement_priority), (7, 0));
    // rust: assert_eq!(p.joint, "rollable");
}

pub fn bad_identifiers_deactivate_done_and_generate() void {
}
    // rust: let mut e = editor();
    // rust: e.edits[NAME].set_value("Bad Name");
    // rust: let mut entity = BlockEntity::JigsawBlock(Box::default());
    // rust: assert!(matches!(e.done(&mut entity, (0, 0, 0)), Outcome::Stay));
    // rust: assert!(matches!(
    // rust: e.press(&mut entity, (0, 0, 0), GENERATE, false, false),
    // rust: Outcome::Stay
    // rust: ));
}

pub fn generate_sends_the_block_then_the_levels() void {
}
    // rust: let mut e = editor();
    // rust: e.slide(LEVELS, 0.5);
    // rust: let mut entity = BlockEntity::JigsawBlock(Box::default());
    // rust: e.press(&mut entity, (0, 0, 0), KEEP_JIGSAWS, false, false);
    // rust: let Outcome::SendAll(packets) = e.press(&mut entity, (5, 6, 7), GENERATE, false, false)
    // rust: else {
    // rust: panic!("generate sends two packets");
}
    // rust: assert!(matches!(packets[0], S::SetJigsawBlock(_)));
    // rust: let S::JigsawGenerate(g) = &packets[1] else {
    // rust: panic!("then the generate packet");
}
    // rust: assert_eq!((g.pos, g.levels, g.keep_jigsaws), ([5, 6, 7], 10, true));
        // The slider's top is level 20; the joint cycles only when vertical.
    // rust: e.slide(LEVELS, 1.0);
    // rust: assert_eq!(e.levels, 20);
    // rust: e.press(&mut entity, (0, 0, 0), JOINT, false, false);
    // rust: assert_eq!(e.joint, JointType::Aligned);
}
}
