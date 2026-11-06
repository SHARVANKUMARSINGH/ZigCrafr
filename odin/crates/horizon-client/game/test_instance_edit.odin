//! Transpiled from Horizon Rust crate
package horizon_client_test_instance_edit

import "core:fmt"
import "core:mem"
import "core:math"

// `TestInstanceBlockEditScreen`: the test's id, the size of the area, its
// rotation and entity handling, and the reset, save and run actions.
// use super::{
    // rust: Game,
    // rust: block_editor::{Editor, Item, Outcome, Pos, cycle, footer_action, on_off},
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: structure_block::rotation_ordinal,
    // rust: test_instance_block::TestInstanceBlock,
    // rust: text::{self, Text},
    // rust: ui::EditBox,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};
// use horizon_world::worldgen::structure::Rotation;

ID :: 0
SIZE :: 1

RESET :: 0
SAVE :: 1
RUN :: 2
DONE :: 3
CANCEL :: 4
ROTATION :: 5
ENTITIES :: 6

// `ServerboundTestInstanceBlockActionPacket.Action`.
ACTION_INIT :: 0
ACTION_QUERY :: 1
ACTION_SET :: 2
ACTION_RESET :: 3
ACTION_SAVE :: 4
ACTION_RUN :: 6

// The screen's width, and the gap between its buttons.
WIDTH :: 316.0
PADDING :: 8.0

    // rust: pub(super) struct TestInstanceEditor {
    // rust: edits: Vec<EditBox>,
    // rust: rotation: Rotation,
    // rust: include_entities: bool,
    // The description shown, or the invalid-id message.
    // rust: info: Text,
    // `TestInstanceBlockEntity.errorMessage`, as `setStatus` needs it.
    // rust: error: Option<Text>,
}

exact_size :: proc(count: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (WIDTH - (count as f32 - 1.0) * PADDING) / count as f32
}

widget_size :: proc(count: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: exact_size(count).trunc()
}

// `widgetX`.
widget_x :: proc(mid: f32, index: uint, count: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (mid - 158.0 + index as f32 * (PADDING + exact_size(count))).trunc()
}

// `parseSize`: clamped to 1..=48, 1 when it is not a number.
parse_size :: proc(value: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: value.parse::<i32>().map_or(1, |v| v.clamp(1, 48))
}

// `Identifier.tryParse`.
parse_id :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::structure_block::parse_identifier(value)
}

rotation_display :: proc(rotation: Rotation) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(match rotation {
    // rust: Rotation::None => "0",
    // rust: Rotation::Clockwise90 => "90",
    // rust: Rotation::Clockwise180 => "180",
    // rust: Rotation::Counterclockwise90 => "270",
    // rust: })
}

    // rust: impl TestInstanceEditor {
    // rust: pub(super) fn new(b: &TestInstanceBlock, rotation: Rotation) -> Self {
    // rust: let edit = |max: usize, value: String| {
    // rust: let mut e = EditBox::new(0.0, 0.0, 80.0, 20.0);
    // rust: e.max_length = max;
    // rust: e.set_value(&value);
    // rust: e.focused = false;
    // rust: e
}
    // rust: let mut edits = vec![edit(128, b.data.test.clone().unwrap_or_default())];
    // rust: edits.extend(b.data.size.map(|v| edit(15, v.to_string())));
    // rust: Self {
    // rust: edits,
    // rust: rotation,
    // rust: include_entities: !b.data.ignore_entities,
    // rust: info: Text::empty(),
    // rust: error: None,
}
}

size :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [0, 1, 2].map(|i| parse_size(&self.edits[SIZE + i].value))
}

save_allowed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.rotation == Rotation::None && parse_id(&self.edits[ID].value).is_some()
}

    // `sendToServer`: the packet, and whether the id was a valid one.
packet :: proc(self: ^Self, pos: Pos, action: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let id = parse_id(&self.edits[ID].value);
    // rust: let valid = id.is_some();
    // rust: (
    // rust: S::TestInstanceBlockAction(play::TestInstanceBlockAction {
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: action,
    // rust: data: play::TestInstanceData {
    // rust: test: id,
    // rust: size: self.size(),
    // rust: rotation: rotation_ordinal(self.rotation),
    // rust: ignore_entities: !self.include_entities,
    // rust: status: 0,
    // rust: error_message: None,
    // rust: },
    // rust: }),
    // rust: valid,
    // rust: )
}

    // `updateTestInfo`: ask the server, or say the id is wrong.
update_info :: proc(self: ^Self, pos: Pos, init: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (packet, valid) = self.packet(pos, if init { ACTION_INIT } else { ACTION_QUERY });
    // rust: if !valid {
    // rust: self.info =
    // rust: Text::translate("test_instance.description.invalid_id", &[]).with_color(text::RED);
}
    // rust: vec![packet]
}
}

    // rust: impl Editor for TestInstanceEditor {
edits :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.edits
}

items :: proc(self: ^Self, _entity: ^BlockEntity, w: f32, _h: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mid = (w / 2.0).floor();
    // rust: let left = mid - 158.0;
    // rust: let tr = |key: &str| Text::translate(key, &[]);
    // rust: let button = |id: u8, x: f32, bw: f32, y: f32, text: Text, active: bool| Item::Button {
    // rust: id,
    // rust: x,
    // rust: y,
    // rust: w: bw,
    // rust: label: text,
    // rust: active,
    // rust: action: footer_action(id, DONE, CANCEL),
}
    // rust: let label = |key: &str, x: f32| Item::Label {
    // rust: text: tr(key),
    // rust: x,
    // rust: y: if key == "test_instance_block.test_id" {
    // rust: 30.0
    // rust: } else {
    // rust: 150.0
    // rust: },
    // rust: right: false,
}
    // rust: let mut items = vec![
    // rust: Item::Edit {
    // rust: index: ID,
    // rust: x: left,
    // rust: y: 40.0,
    // rust: w: WIDTH,
    // rust: },
    // rust: Item::Info {
    // rust: text: self.info.clone(),
    // rust: x: left,
    // rust: y: 70.0,
    // rust: w: WIDTH,
    // rust: h: 72.0,
    // rust: },
    // rust: ];
    // rust: for i in 0..3 {
    // rust: items.push(Item::Edit {
    // rust: index: SIZE + i,
    // rust: x: widget_x(mid, i, 5),
    // rust: y: 160.0,
    // rust: w: widget_size(5),
    // rust: });
}
    // rust: items.push(button(
    // rust: ROTATION,
    // rust: widget_x(mid, 3, 5),
    // rust: widget_size(5),
    // rust: 160.0,
    // rust: rotation_display(self.rotation),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: ENTITIES,
    // rust: widget_x(mid, 4, 5),
    // rust: widget_size(5),
    // rust: 160.0,
    // rust: on_off(self.include_entities),
    // rust: true,
    // rust: ));
        // The export button is for development builds only.
    // rust: let save_ok = self.save_allowed();
    // rust: items.push(button(
    // rust: RESET,
    // rust: widget_x(mid, 0, 2),
    // rust: widget_size(2),
    // rust: 185.0,
    // rust: tr("test_instance.action.reset"),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: SAVE,
    // rust: widget_x(mid, 1, 2),
    // rust: widget_size(2),
    // rust: 185.0,
    // rust: tr("test_instance.action.save"),
    // rust: save_ok,
    // rust: ));
    // rust: items.push(button(
    // rust: RUN,
    // rust: widget_x(mid, 0, 3),
    // rust: widget_size(3),
    // rust: 210.0,
    // rust: tr("test_instance.action.run"),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: DONE,
    // rust: widget_x(mid, 1, 3),
    // rust: widget_size(3),
    // rust: 210.0,
    // rust: tr("gui.done"),
    // rust: true,
    // rust: ));
    // rust: items.push(button(
    // rust: CANCEL,
    // rust: widget_x(mid, 2, 3),
    // rust: widget_size(3),
    // rust: 210.0,
    // rust: tr("gui.cancel"),
    // rust: true,
    // rust: ));
    // rust: items.push(Item::Title {
    // rust: text: tr("block.minecraft.test_instance_block"),
    // rust: y: 10.0,
    // rust: });
    // rust: items.push(label("test_instance_block.test_id", left));
    // rust: items.push(label("test_instance_block.size", left));
    // rust: items.push(label("test_instance_block.rotation", widget_x(mid, 3, 5)));
    // rust: items.push(label("test_instance_block.entities", widget_x(mid, 4, 5)));
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
    // rust: let send = |editor: &Self, action: i32| Outcome::Send(editor.packet(pos, action).0);
    // rust: match id {
    // rust: RESET => return send(self, ACTION_RESET),
    // rust: SAVE if self.save_allowed() => return send(self, ACTION_SAVE),
    // rust: RUN => return send(self, ACTION_RUN),
    // rust: DONE => return self.done(entity, pos),
    // rust: CANCEL => return Outcome::Cancel,
    // rust: ROTATION => self.rotation = cycle(&Rotation::ALL, self.rotation, delta),
    // rust: ENTITIES => self.include_entities = !self.include_entities,
    // rust: _ => {}
}
    // rust: Outcome::Stay
}

    // `onDone`: the SET action.
done :: proc(self: ^Self, _entity: ^BlockEntity, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Outcome::Send(self.packet(pos, ACTION_SET).0)
}

cancel :: proc(self: ^Self, _entity: ^BlockEntity) {
}

    // The screen has no confirm key of its own.
enter_confirms :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}

opened :: proc(self: ^Self, entity: ^BlockEntity, pos: Pos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if let BlockEntity::TestInstanceBlock(b) = entity {
    // rust: self.error = b
    // rust: .data
    // rust: .error_message
    // rust: .as_ref()
    // rust: .map(super::remote::remote_text);
}
    // rust: self.update_info(pos, true)
}

edited :: proc(self: ^Self, edit: uint, pos: Pos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if edit == ID {
    // rust: self.update_info(pos, false)
    // rust: } else {
    // rust: Vec::new()
}
}

    // `setStatus`: a failure's message, then the description; a size fills
    // the boxes.
status :: proc(self: ^Self, entity: ^BlockEntity, status: Text, size: Maybe([i32; 3])) {
}
    // rust: let mut description = Text::empty();
    // rust: if let BlockEntity::TestInstanceBlock(b) = entity
    // rust: && let Some(error) = &b.data.error_message
    // rust: {
    // rust: let message = Text::empty()
    // rust: .with_color(text::RED)
    // rust: .append(super::remote::remote_text(error));
    // rust: description = description
    // rust: .append(Text::translate(
    // rust: "test_instance.description.failed",
    // rust: &[message],
    // rust: ))
    // rust: .append(Text::literal("\n\n"));
}
    // rust: self.info = description.append(status);
    // rust: if let Some(size) = size {
    // rust: for (i, v) in size.into_iter().enumerate() {
    // rust: self.edits[SIZE + i].set_value(&v.to_string());
}
}
}
}

    // rust: impl Game<'_> {
    // `LocalPlayer.openTestInstanceBlock`.
    // rust: pub(super) fn open_test_instance_block(&mut self, pos: Pos) {
    // rust: let Some(BlockEntity::TestInstanceBlock(b)) = self.world.block_entities.get(&pos) else {
    // rust: return;
}
    // rust: let editor = TestInstanceEditor::new(b, self.test_rotation(pos));
    // rust: self.open_block_editor(pos, Box::new(editor));
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::structure_block::rotation_from_ordinal;

editor :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = TestInstanceBlock::default();
    // rust: b.data.test = Some("minecraft:always_pass".into());
    // rust: b.data.size = [3, 4, 5];
    // rust: TestInstanceEditor::new(&b, Rotation::None)
}

widgets_are_laid_out_like_the_screen :: proc() {
}
        // 316 wide, 8 apart: two buttons of 154, three of 100, five of 56.
    // rust: assert_eq!(widget_size(2), 154.0);
    // rust: assert_eq!(widget_size(3), 100.0);
    // rust: assert_eq!(widget_size(5), 56.0);
    // rust: assert_eq!(widget_x(160.0, 1, 3), 2.0 + 108.0);
}

sizes_clamp_and_ids_gate_saving :: proc() {
}
    // rust: assert_eq!(parse_size("99"), 48);
    // rust: assert_eq!(parse_size("0"), 1);
    // rust: assert_eq!(parse_size("x"), 1);
    // rust: let mut e = editor();
    // rust: assert!(e.save_allowed());
    // rust: e.rotation = Rotation::Clockwise90;
    // rust: assert!(!e.save_allowed());
    // rust: e.rotation = Rotation::None;
    // rust: e.edits[ID].set_value("Bad Id");
    // rust: assert!(!e.save_allowed());
        // An invalid id still asks, and says so.
    // rust: let packets = e.update_info((0, 0, 0), false);
    // rust: assert_eq!(packets.len(), 1);
    // rust: assert!(!e.info.plain().is_empty());
}

actions_carry_the_screens_values :: proc() {
}
    // rust: let mut e = editor();
    // rust: let mut entity = BlockEntity::TestInstanceBlock(Box::default());
    // rust: e.press(&mut entity, (0, 0, 0), ENTITIES, false, false);
    // rust: e.press(&mut entity, (0, 0, 0), ROTATION, false, false);
    // rust: e.edits[SIZE].set_value("60");
    // rust: let Outcome::Send(S::TestInstanceBlockAction(p)) =
    // rust: e.press(&mut entity, (1, 2, 3), RESET, false, false)
    // rust: else {
    // rust: panic!("reset sends the action");
}
    // rust: assert_eq!((p.pos, p.action), ([1, 2, 3], ACTION_RESET));
    // rust: assert_eq!(p.data.test.as_deref(), Some("minecraft:always_pass"));
    // rust: assert_eq!(p.data.size, [48, 4, 5]);
    // rust: assert!(p.data.ignore_entities);
    // rust: assert_eq!(
    // rust: rotation_from_ordinal(p.data.rotation),
    // rust: Some(Rotation::Clockwise90)
    // rust: );
}
}
