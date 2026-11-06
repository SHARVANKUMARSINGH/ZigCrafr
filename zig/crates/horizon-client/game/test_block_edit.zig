//! Transpiled from Horizon Rust crate
//! Module: horizon-client_test_block_edit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `TestBlockEditScreen`: the test block's mode and message.
// use super::{
    // rust: Game,
    // rust: block_editor::{Editor, Item, Outcome, Pos, cycle, footer_action},
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: test_block::{TestBlock, TestBlockMode},
    // rust: text::Text,
    // rust: ui::EditBox,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};

pub const DONE: u8 = 0;
pub const CANCEL: u8 = 1;
pub const MODE: u8 = 2;

    // rust: pub(super) struct TestBlockEditor {
    // rust: edits: Vec<EditBox>,
    // rust: mode: TestBlockMode,
}

    // rust: impl TestBlockEditor {
    // rust: pub(super) fn new(b: &TestBlock) -> Self {
    // rust: let mut message = EditBox::new(0.0, 0.0, 240.0, 20.0);
    // rust: message.max_length = 128;
    // rust: message.set_value(&b.message);
    // rust: message.focused = false;
    // rust: Self {
    // rust: edits: vec![message],
    // rust: mode: b.mode,
}
}
}

    // rust: impl Editor for TestBlockEditor {
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
    // rust: let button = |id: u8, x: f32, bw: f32, y: f32, text: Text| Item::Button {
    // rust: id,
    // rust: x,
    // rust: y,
    // rust: w: bw,
    // rust: label: text,
    // rust: active: true,
    // rust: action: footer_action(id, DONE, CANCEL),
}
    // rust: let mut items = Vec::new();
        // The message box shows unless the block starts tests.
    // rust: if self.mode != TestBlockMode::Start {
    // rust: items.push(Item::Edit {
    // rust: index: 0,
    // rust: x: mid - 152.0,
    // rust: y: 80.0,
    // rust: w: 240.0,
    // rust: });
}
    // rust: items.push(button(
    // rust: MODE,
    // rust: mid - 4.0 - 150.0,
    // rust: 50.0,
    // rust: 185.0,
    // rust: tr(&self.mode.label_key()),
    // rust: ));
    // rust: items.push(button(
    // rust: DONE,
    // rust: mid - 4.0 - 150.0,
    // rust: 150.0,
    // rust: 210.0,
    // rust: tr("gui.done"),
    // rust: ));
    // rust: items.push(button(CANCEL, mid + 4.0, 150.0, 210.0, tr("gui.cancel")));
    // rust: items.push(Item::Title {
    // rust: text: tr("block.minecraft.test_block"),
    // rust: y: 10.0,
    // rust: });
    // rust: if self.mode != TestBlockMode::Start {
    // rust: items.push(Item::Label {
    // rust: text: tr("test_block.message"),
    // rust: x: mid - 153.0,
    // rust: y: 70.0,
    // rust: right: false,
    // rust: });
}
    // rust: items.push(Item::Label {
    // rust: text: tr(&self.mode.info_key()),
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
    // rust: _alt: bool,
    // rust: ) -> Outcome {
    // rust: match id {
    // rust: DONE => return self.done(entity, pos),
    // rust: CANCEL => return Outcome::Cancel,
    // rust: MODE => {
    // rust: self.mode = cycle(&TestBlockMode::ALL, self.mode, if shift { -1 } else { 1 });
}
    // rust: _ => {}
}
    // rust: Outcome::Stay
}

    /// `onDone`: the mode and message, as the screen has them.
pub fn done(self: *Self, _entity: *mut BlockEntity, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Outcome::Send(S::SetTestBlock(play::SetTestBlock {
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: mode: self.mode.id(),
    // rust: message: self.edits[0].value.clone(),
    // rust: }))
}

pub fn cancel(self: *Self, _entity: *mut BlockEntity) void {
}

    /// The screen has no confirm key of its own.
pub fn enter_confirms(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
}

    // rust: impl Game<'_> {
    /// `LocalPlayer.openTestBlock`.
    // rust: pub(super) fn open_test_block(&mut self, pos: Pos) {
    // rust: let Some(BlockEntity::TestBlock(b)) = self.world.block_entities.get(&pos) else {
    // rust: return;
}
    // rust: let editor = TestBlockEditor::new(b);
    // rust: self.open_block_editor(pos, Box::new(editor));
}
}

    // rust: mod tests {
//     use super::*;

pub fn done_sends_the_mode_and_message() void {
}
    // rust: let block = TestBlock {
    // rust: mode: TestBlockMode::Log,
    // rust: message: "hello".into(),
    // rust: powered: false,
    // rust: triggered: false,
}
    // rust: let mut e = TestBlockEditor::new(&block);
    // rust: let mut entity = BlockEntity::TestBlock(Box::new(block));
    // rust: e.press(&mut entity, (0, 0, 0), MODE, false, false);
    // rust: let Outcome::Send(S::SetTestBlock(p)) = e.done(&mut entity, (4, 5, 6)) else {
    // rust: panic!("done sends the block");
}
    // rust: assert_eq!((p.pos, p.mode, p.message.as_str()), ([4, 5, 6], 2, "hello"));
        // Shift steps back, wrapping from the first mode to the last.
    // rust: e.mode = TestBlockMode::Start;
    // rust: e.press(&mut entity, (0, 0, 0), MODE, true, false);
    // rust: assert_eq!(e.mode, TestBlockMode::Accept);
    // rust: assert!(!e.enter_confirms());
}

pub fn the_message_box_hides_for_start() void {
}
    // rust: let mut e = TestBlockEditor::new(&TestBlock::new(TestBlockMode::Start));
    // rust: let entity = BlockEntity::TestBlock(Box::new(TestBlock::new(TestBlockMode::Start)));
    // rust: let boxes = |e: &TestBlockEditor| {
    // rust: e.items(&entity, 320.0, 240.0)
    // rust: .iter()
    // rust: .filter(|i| matches!(i, Item::Edit { .. }))
    // rust: .count()
}
    // rust: assert_eq!(boxes(&e), 0);
    // rust: e.mode = TestBlockMode::Log;
    // rust: assert_eq!(boxes(&e), 1);
}
}
