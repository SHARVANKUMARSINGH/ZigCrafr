//! Transpiled from Horizon Rust crate
package horizon_client_command_blocks

import "core:fmt"
import "core:mem"
import "core:math"

// Command blocks: `CommandBlock`'s placement (`setPlacedBy`), its scheduled
// tick (`execute`, `executeChain`), `BaseCommandBlock.performCommand`
// through the command system with the block's output, and
// `CommandBlockEditScreen` with what `handleSetCommandBlock` does with it.
// use super::{Game, Screen, commands::execute::Source, lan::LanHost};
// use horizon_client::{
    // rust: chat::{ChatScreen, Commands},
    // rust: command_block::{self, CommandBlock, Mode},
    // rust: containers::BlockEntity,
    // rust: hud::{HudBatch, rgba},
    // rust: screen_draw::Measure,
    // rust: text::Text,
    // rust: ui::{self, EditBox},
    // rust: world::World,
}
// use horizon_core::position::BlockPos;
// use horizon_protocol::packets::play::{self, Clientbound as C, Serverbound as S};
// use horizon_world::{
    // rust: chunk::BlockState,
    // rust: level::flags,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use winit::{
    // rust: event::{ElementState, KeyEvent},
    // rust: keyboard::{KeyCode, PhysicalKey},
}

    // rust: type Pos = (i32, i32, i32);

// The open `CommandBlockEditScreen`.
    // rust: pub(super) struct CommandBlockScreen {
    // rust: pos: Pos,
    // The command block minecart being edited (`MinecartCommandBlockEditScreen`);
    // `pos` is unused then.
    // rust: cart: Option<u32>,
    // The command box with its `CommandSuggestions`.
    // rust: pub(super) command: ChatScreen,
    // When the command box was focused, for its cursor's blink.
    // rust: opened: std::time::Instant,
    // rust: previous: EditBox,
    // rust: pub(super) track_output: bool,
    // rust: mode: Mode,
    // rust: conditional: bool,
    // rust: auto: bool,
}

// What `ServerboundSetCommandBlockPacket` carries.
CommandBlockEdit :: struct {
    pos: Pos,
    command: string,
    track_output: bool,
    mode: Mode,
    conditional: bool,
    auto: bool,
}

Button :: enum {
    Output,
    Mode,
    Conditional,
    Auto,
    Done,
    Cancel,
}

// `AbstractCommandBlockEditScreen.getPreviousY`.
previous_y :: proc(cart: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cart { 150.0 } else { 135.0 }
}

// `EditBox.textColorUneditable`.
UNEDITABLE :: 0xFF70_7070

    // rust: impl CommandBlockScreen {
    // `AbstractCommandBlockEditScreen.init` and `CommandBlockEditScreen`'s
    // buttons, in GUI pixels of a `w`×`h` screen.
    // A minecart's screen has no mode buttons (`getPreviousY` 150).
buttons :: proc(w: f32, h: f32, cart: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mid = (w / 2.0).floor();
    // rust: let low = (h / 4.0).floor() + 132.0;
    // rust: let mut out = vec![(Button::Output, mid + 130.0, previous_y(cart), 20.0)];
    // rust: if !cart {
    // rust: out.extend([
    // rust: (Button::Mode, mid - 154.0, 165.0, 100.0),
    // rust: (Button::Conditional, mid - 50.0, 165.0, 100.0),
    // rust: (Button::Auto, mid + 54.0, 165.0, 100.0),
    // rust: ]);
}
    // rust: out.extend([
    // rust: (Button::Done, mid - 154.0, low, 150.0),
    // rust: (Button::Cancel, mid + 4.0, low, 150.0),
    // rust: ]);
    // rust: out
}
    // What button `b` narrates: the switches are `CycleButton`s that show
    // only their value (`displayOnlyValue`), "<name>: <value> button" and
    // the value a click moves to.
    // rust: fn narration(
    // rust: &self,
    // rust: b: Button,
    // rust: rect: [f32; 4],
    // rust: tr: super::screen_info::Tr<'_>,
    // rust: ) -> horizon_client::widgets::Narratable {
    // rust: let state = (self.track_output, self.mode, self.conditional, self.auto);
    // rust: button_narration(b, state, rect, tr)
}
label :: proc(self: ^Self, b: Button) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let tr = |key: &str| Text::translate(key, &[]);
    // rust: match b {
    // rust: Button::Output => Text::literal(if self.track_output { "O" } else { "X" }),
    // rust: Button::Mode => tr(self.mode.label()),
    // rust: Button::Conditional => tr(if self.conditional {
    // rust: "advMode.mode.conditional"
    // rust: } else {
    // rust: "advMode.mode.unconditional"
    // rust: }),
    // rust: Button::Auto => tr(if self.auto {
    // rust: "advMode.mode.autoexec.bat"
    // rust: } else {
    // rust: "advMode.mode.redstoneTriggered"
    // rust: }),
    // rust: Button::Done => tr("gui.done"),
    // rust: Button::Cancel => tr("gui.cancel"),
}
}
    // rust: pub(super) fn pos(&self) -> Pos {
    // rust: self.pos
}
    // `updatePreviousOutput`.
show_previous :: proc(self: ^Self, block: ^CommandBlock) {
}
    // rust: let shown = if self.track_output {
    // rust: block.last_output_string()
    // rust: } else {
    // rust: "-".to_owned()
}
    // rust: self.previous.set_value(&shown);
}
}

// [`CommandBlockScreen::narration`] of the switches' state (track output,
// mode, conditional, automatic).
    // rust: fn button_narration(
    // rust: b: Button,
    // rust: (track_output, mode, conditional_on, auto_on): (bool, Mode, bool, bool),
    // rust: rect: [f32; 4],
    // rust: tr: super::screen_info::Tr<'_>,
    // rust: ) -> horizon_client::widgets::Narratable {
//     use horizon_client::widgets::Narratable;
    // rust: let full_tr = tr;
    // rust: let tr = |key: &str| full_tr(key, &[]);
    // rust: let o_x = |on: bool| if on { "O" } else { "X" }.to_owned();
    // rust: let conditional = |on: bool| {
    // rust: tr(if on {
    // rust: "advMode.mode.conditional"
    // rust: } else {
    // rust: "advMode.mode.unconditional"
    // rust: })
}
    // rust: let auto = |on: bool| {
    // rust: tr(if on {
    // rust: "advMode.mode.autoexec.bat"
    // rust: } else {
    // rust: "advMode.mode.redstoneTriggered"
    // rust: })
}
    // rust: let (name, value, next) = match b {
    // rust: Button::Output => ("advMode.trackOutput", o_x(track_output), o_x(!track_output)),
    // rust: Button::Mode => ("advMode.mode", tr(mode.label()), tr(mode.next().label())),
    // rust: Button::Conditional => (
    // rust: "advMode.type",
    // rust: conditional(conditional_on),
    // rust: conditional(!conditional_on),
    // rust: ),
    // rust: Button::Auto => ("advMode.triggering", auto(auto_on), auto(!auto_on)),
    // rust: Button::Done => return Narratable::button(tr("gui.done"), rect, true),
    // rust: Button::Cancel => return Narratable::button(tr("gui.cancel"), rect, true),
}
    // rust: let full = full_tr("options.generic_value", &[&tr(name), &value]);
    // rust: Narratable::cycle(full, next, rect, true)
}

state_of :: proc(registry: ^BlockRegistry, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: registry.state(state)
}
facing_step :: proc(state: ^BlockState) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match state.properties.get("facing").map(String::as_str) {
    // rust: Some("down") => [0, -1, 0],
    // rust: Some("up") => [0, 1, 0],
    // rust: Some("south") => [0, 0, 1],
    // rust: Some("west") => [-1, 0, 0],
    // rust: Some("east") => [1, 0, 0],
    // rust: _ => [0, 0, -1],
}
}
// `Direction.toYRot`: south 0, west 90, north 180, east (and up/down) 270.
facing_yaw :: proc(state: ^BlockState) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match state.properties.get("facing").map(String::as_str) {
    // rust: Some("south") => 0.0,
    // rust: Some("west") => 90.0,
    // rust: Some("north") => 180.0,
    // rust: _ => 270.0,
}
}
conditional :: proc(state: ^BlockState) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state
    // rust: .properties
    // rust: .get("conditional")
    // rust: .is_some_and(|c| c == "true")
}
offset :: proc(pos: Pos, step: [i32; 3]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: (pos.0 + step[0], pos.1 + step[1], pos.2 + step[2])
}
command_block_mut :: proc(world: ^World, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match world.block_entities.get_mut(&pos)? {
    // rust: BlockEntity::CommandBlock(c) => Some(c),
    // rust: _ => None,
}
}

// `CommandBlockEntity.markConditionMet`: a conditional block needs the
// command block behind it to have succeeded.
    // rust: pub(super) fn mark_condition_met(world: &mut World, registry: &BlockRegistry, pos: Pos) -> bool {
    // rust: let Some(state) = state_of(registry, world.block(pos.0, pos.1, pos.2)) else {
    // rust: return false;
}
    // rust: let mut met = true;
    // rust: if conditional(state) {
    // rust: let back = facing_step(state).map(|v| -v);
    // rust: let behind = offset(pos, back);
    // rust: let behind_block = state_of(registry, world.block(behind.0, behind.1, behind.2))
    // rust: .is_some_and(|s| Mode::of_block(&s.name).is_some());
    // rust: met = behind_block
    // rust: && matches!(world.block_entities.get(&behind),
    // rust: Some(BlockEntity::CommandBlock(c)) if c.success_count > 0);
}
    // rust: if let Some(c) = command_block_mut(world, pos) {
    // rust: c.condition_met = met;
}
    // rust: met
}

// `CommandBlockEntity.setPowered` from `CommandBlock.setPoweredAndUpdate`
// (the level's neighbour hook): the previous flag and `isAutomatic`; a
// rising signal that will tick the block checks its condition.
    // rust: pub(super) fn set_powered(
    // rust: world: &mut World,
    // rust: registry: &BlockRegistry,
    // rust: pos: Pos,
    // rust: powered: bool,
    // rust: ) -> Option<(bool, bool)> {
    // rust: let mode = state_of(registry, world.block(pos.0, pos.1, pos.2))
    // rust: .and_then(|s| Mode::of_block(&s.name))?;
    // rust: let c = command_block_mut(world, pos)?;
    // rust: let (was, auto) = (c.powered, c.auto);
    // rust: c.powered = powered;
    // rust: if command_block::power_schedules(mode, was, powered, auto) {
    // rust: mark_condition_met(world, registry, pos);
}
    // rust: Some((was, auto))
}

// `getAnalogOutputSignal`: the success count.
    // rust: pub(super) fn analog_signal(world: &World, pos: Pos) -> Option<i32> {
    // rust: match world.block_entities.get(&pos)? {
    // rust: BlockEntity::CommandBlock(c) => Some(c.success_count),
    // rust: _ => None,
}
}

    // rust: impl Game<'_> {
    // `Player.canUseGameMasterBlocks`: creative with game master commands.
    // rust: pub(super) fn can_use_game_master_blocks(&self) -> bool {
    // rust: self.creative && self.ui.registries.permission >= 2
}
    // `CommandBlock.useWithoutItem` on a server's client, which opens the
    // screen itself (`Player.openCommandBlock`) while the server only
    // answers the click: the block at `pos`, when it is a command block the
    // player may edit.
    // rust: pub(super) fn open_command_block_if_editable(&mut self, pos: Pos) {
    // rust: let is_command_block = self
    // rust: .block_state_at(pos)
    // rust: .is_some_and(|state| Mode::of_block(&state.name).is_some());
    // rust: if is_command_block && self.can_use_game_master_blocks() {
    // rust: self.open_command_block(pos);
}
}
command_block :: proc(self: ^Self, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.world.block_entities.get(&pos)? {
    // rust: BlockEntity::CommandBlock(c) => Some(c),
    // rust: _ => None,
}
}
    // The `BaseCommandBlock` an edit screen shows: the block entity's or the
    // minecart's.
edit_base :: proc(self: ^Self, s: ^CommandBlockScreen) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match s.cart {
    // rust: Some(id) => self.carts.iter().find(|c| c.id == id).map(|c| &c.command),
    // rust: None => self.command_block(s.pos),
}
}
block_state_at :: proc(self: ^Self, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let registry = self.pack.assets.registry;
    // rust: state_of(registry, self.world.block(pos.0, pos.1, pos.2))
}
schedule_command_block :: proc(self: ^Self, pos: Pos) {
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| b.schedule_tick(level, ticks, at, 1));
}
    // `CommandBlockEntity.scheduleTick`.
schedule_command_block_tick :: proc(self: ^Self, pos: Pos) {
}
    // rust: mark_condition_met(&mut self.world, self.pack.assets.registry, pos);
    // rust: self.schedule_command_block(pos);
}
update_output_signal :: proc(self: ^Self, pos: Pos) {
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| b.update_neighbour_for_output_signal(level, ticks, at));
}
    // `ClientPacketListener.handleBlockEntityData` then
    // `CommandBlockEditScreen.updateGui`: new data for the command block the
    // edit screen shows refreshes its fields. The mode and conditional live in
    // the block state here (vanilla's `CommandBlockEntity.Mode`).
    // rust: pub(super) fn command_block_data_arrived(&mut self, pos: Pos) {
    // rust: if self
    // rust: .command_block_screen
    // rust: .as_ref()
    // rust: .is_none_or(|s| s.cart.is_some() || s.pos != pos)
    // rust: {
    // rust: return;
}
    // rust: let state = self.block_state_at(pos).map(|s| {
    // rust: (
    // rust: Mode::of_block(&s.name).unwrap_or(Mode::Redstone),
    // rust: conditional(s),
    // rust: )
    // rust: });
    // rust: let block = self.command_block(pos).cloned();
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: let Some(screen) = self.command_block_screen.as_mut() else {
    // rust: return;
}
    // rust: if let Some((mode, conditional)) = state {
    // rust: screen.mode = mode;
    // rust: screen.conditional = conditional;
}
    // rust: if let Some(block) = block {
    // rust: screen.command.suggest_command(&m, &c, &block.command);
    // rust: screen.track_output = block.track_output;
    // rust: screen.auto = block.auto;
    // rust: screen.show_previous(&block);
}
}

    // `CommandBlock.setPlacedBy`: unless the item carried block entity data
    // (`defaults` false), output tracking follows `send_command_feedback` and
    // the block's own automatic flag; then the block takes the signal around it.
    // rust: pub(super) fn command_block_placed(&mut self, pos: Pos, defaults: bool) {
    // rust: let feedback = self.ui.rules.bool("send_command_feedback");
    // rust: let Some(name) = self.block_state_at(pos).map(|s| s.name.as_str()) else {
    // rust: return;
}
    // rust: let auto = command_block::automatic_block(name);
    // rust: if defaults && let Some(c) = command_block_mut(&mut self.world, pos) {
    // rust: c.track_output = feedback;
    // rust: c.auto = auto;
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: let signal = self.with_level(|b, level, ticks| b.has_neighbor_signal(level, ticks, at));
    // rust: let registry = self.pack.assets.registry;
    // rust: if let Some((was, auto)) = set_powered(&mut self.world, registry, pos, signal)
    // rust: && signal
    // rust: && !was
    // rust: && !auto
    // rust: && !command_block::automatic_block(name)
    // rust: {
    // rust: self.schedule_command_block(pos);
}
}

    // `CommandBlock.tick`.
    // rust: pub(super) fn command_block_tick(&mut self, pos: BlockPos) {
    // rust: let key = (pos.x, pos.y, pos.z);
    // rust: let Some(state) = self.block_state_at(key) else {
    // rust: return;
}
    // rust: let Some(mode) = Mode::of_block(&state.name) else {
    // rust: return;
}
    // rust: let Some(was_met) = self.command_block(key).map(|c| c.condition_met) else {
    // rust: return;
}
    // rust: if mode == Mode::Auto {
    // rust: mark_condition_met(&mut self.world, self.pack.assets.registry, key);
}
    // rust: match command_block::tick_action(mode, was_met, conditional(state)) {
    // rust: Some(true) => self.command_block_execute(key, state),
    // rust: Some(false) => {
    // rust: if let Some(c) = command_block_mut(&mut self.world, key) {
    // rust: c.success_count = 0;
}
}
    // rust: None => {}
}
    // rust: if let Some(c) = self.command_block(key)
    // rust: && command_block::repeats(mode, c.powered, c.auto)
    // rust: {
    // rust: self.schedule_command_block(key);
}
    // rust: self.update_output_signal(key);
}
    // `CommandBlock.execute`: the command (or no successes without one),
    // then the chain in front.
command_block_execute :: proc(self: ^Self, pos: Pos, state: ^BlockState) {
}
    // rust: let has_command = self
    // rust: .command_block(pos)
    // rust: .is_some_and(|c| !c.command.is_empty());
    // rust: if has_command {
    // rust: self.perform_command_block(pos);
    // rust: } else if let Some(c) = command_block_mut(&mut self.world, pos) {
    // rust: c.success_count = 0;
}
    // rust: self.execute_chain(pos, facing_step(state));
}
    // `CommandBlock.executeChain`: the chain command blocks in front, each
    // facing on to the next, up to `max_command_sequence_length`.
execute_chain :: proc(self: ^Self, start: Pos, mut step: [i32; 3]) {
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let limit = self.ui.rules.int("max_command_sequence_length");
    // rust: let mut remaining = limit;
    // rust: let mut pos = start;
    // rust: while remaining > 0 {
    // rust: remaining -= 1;
    // rust: pos = offset(pos, step);
    // rust: let Some(state) = self.block_state_at(pos) else {
    // rust: break;
}
    // rust: if Mode::of_block(&state.name) != Some(Mode::Sequence) {
    // rust: break;
}
    // rust: let Some(c) = self.command_block(pos) else {
    // rust: break;
}
    // rust: if c.powered || c.auto {
    // rust: if mark_condition_met(&mut self.world, registry, pos) {
    // rust: if !self.perform_command_block(pos) {
    // rust: break;
}
    // rust: self.update_output_signal(pos);
    // rust: } else if conditional(state)
    // rust: && let Some(c) = command_block_mut(&mut self.world, pos)
    // rust: {
    // rust: c.success_count = 0;
}
}
    // rust: step = facing_step(state);
}
    // rust: if remaining <= 0 {
    // rust: log::warn!(
    // rust: "Command Block chain tried to execute more than {} steps!",
    // rust: limit.max(0)
    // rust: );
}
}
    // `BaseCommandBlock.performCommand`: runs the command as the block, at
    // game master level, counting the successful results. False when it
    // already ran this game tick.
perform_command_block :: proc(self: ^Self, pos: Pos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let game_time = self.world.game_time;
    // rust: let Some(c) = command_block_mut(&mut self.world, pos) else {
    // rust: return false;
}
    // rust: if c.last_execution == game_time {
    // rust: return false;
}
    // rust: if c.command.eq_ignore_ascii_case("Searge") {
    // rust: c.last_output = Some(Text::literal("#itzlipofutzli"));
    // rust: c.success_count = 1;
    // rust: return true;
}
    // rust: c.success_count = 0;
    // rust: let command = c.command.clone();
    // rust: if self.ui.rules.bool("command_blocks_work") && !command.is_empty() {
    // rust: if let Some(c) = command_block_mut(&mut self.world, pos) {
    // rust: c.last_output = None;
}
    // rust: let Some(state) = self.block_state_at(pos) else {
    // rust: return false;
}
    // rust: let source = Source {
    // rust: entity: None,
    // rust: pos: [
    // rust: f64::from(pos.0) + 0.5,
    // rust: f64::from(pos.1) + 0.5,
    // rust: f64::from(pos.2) + 0.5,
    // rust: ],
    // rust: rot: [facing_yaw(state), 0.0],
    // rust: eyes: false,
    // rust: silent: false,
    // rust: store: None,
    // rust: dimension: self.dim,
    // rust: level: None,
    // rust: block: Some(pos),
    // rust: cart: None,
}
    // rust: let successes = self.run_as_game_master(&command, source);
    // rust: if let Some(c) = command_block_mut(&mut self.world, pos) {
    // rust: c.success_count = successes;
}
}
    // rust: if let Some(c) = command_block_mut(&mut self.world, pos) {
    // rust: c.last_execution = if c.update_last_execution {
    // rust: game_time
    // rust: } else {
    // rust: -1
}
}
    // rust: true
}
    // `Commands.performPrefixedCommand` for a `BaseCommandBlock`: `command`
    // from `source` at game master level, and how many of its results
    // succeeded.
    // rust: pub(super) fn run_as_game_master(&mut self, command: &str, source: Source) -> i32 {
        // performPrefixedCommand: a leading slash is allowed.
    // rust: let line = command.strip_prefix('/').unwrap_or(command).to_owned();
    // rust: let outer = self.cmds.results.replace(Vec::new());
    // rust: let level = std::mem::replace(&mut self.ui.registries.permission, 2);
    // rust: self.with_source(source, |g| g.run_command(&line));
    // rust: self.ui.registries.permission = level;
    // rust: let results = std::mem::replace(&mut self.cmds.results, outer).unwrap_or_default();
    // rust: results.iter().filter(|(success, _)| *success).count() as i32
}
    // `CloseableCommandBlockSource.sendSystemMessage`: the block's last
    // output, stamped with the time. Nothing when it doesn't track output
    // (`CommandSource.NULL`).
    // rust: pub(super) fn command_block_output(&mut self, pos: Pos, message: Text) {
    // rust: if let Some(c) = command_block_mut(&mut self.world, pos)
    // rust: && c.track_output
    // rust: {
    // rust: let time = chrono::Local::now().format("[%H:%M:%S] ").to_string();
    // rust: c.last_output = Some(Text::literal(time).append(message));
}
}
    // `CommandSourceStack.sendSuccess` from a command block: its output when
    // `send_command_feedback`, and `broadcastToAdmins` when `broadcast` and
    // `command_block_output`.
    // rust: pub(super) fn command_block_success(&mut self, pos: Pos, message: Text, broadcast: bool) {
    // rust: let Some(name) = self
    // rust: .command_block(pos)
    // rust: .filter(|c| c.track_output)
    // rust: .map(CommandBlock::name)
    // rust: else {
    // rust: return;
}
    // rust: let feedback = self.ui.rules.bool("send_command_feedback");
    // rust: if feedback {
    // rust: self.command_block_output(pos, message.clone());
}
    // rust: if broadcast && feedback && self.ui.rules.bool("command_block_output") {
    // rust: self.broadcast_source_to_admins(name, message);
}
}

    // `LocalPlayer.openCommandBlock`.
    // rust: pub(super) fn open_command_block(&mut self, pos: Pos) {
    // rust: let Some(block) = self.command_block(pos).cloned() else {
    // rust: return;
}
    // rust: let Some(state) = self.block_state_at(pos) else {
    // rust: return;
}
    // rust: let mode = Mode::of_block(&state.name).unwrap_or(Mode::Redstone);
    // rust: self.open_edit_screen(pos, None, block, mode, conditional(state));
}
    // The screen over `block`: a command block's at `pos`, or a minecart's.
    // rust: pub(super) fn open_edit_screen(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: cart: Option<u32>,
    // rust: block: CommandBlock,
    // rust: mode: Mode,
    // rust: conditional: bool,
    // rust: ) {
    // rust: let (w, h) = self.gui_size();
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: let mut command = ChatScreen::command_block(&m, &c, &block.command, w as i32, h as i32);
    // rust: command.auto_suggestions = self.settings.auto_suggestions;
    // rust: command.input.message = super::screen_info::tr("advMode.command", &[]);
    // rust: let mut previous = EditBox::new(0.0, previous_y(cart.is_some()), 276.0, 20.0);
    // rust: previous.message = super::screen_info::tr("advMode.previousOutput", &[]);
    // rust: previous.max_length = 32500;
    // rust: previous.text_color = UNEDITABLE;
    // rust: previous.focused = false;
    // rust: let mut screen = CommandBlockScreen {
    // rust: pos,
    // rust: cart,
    // rust: command,
    // rust: opened: std::time::Instant::now(),
    // rust: previous,
    // rust: track_output: block.track_output,
    // rust: mode,
    // rust: conditional,
    // rust: auto: block.auto,
}
    // rust: screen.show_previous(&block);
    // rust: self.command_block_screen = Some(screen);
    // rust: self.screen = Screen::CommandBlock;
    // rust: self.capture(false);
}
    // rust: pub(super) fn close_command_block(&mut self) {
    // rust: self.command_block_screen = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
    // rust: pub(super) fn draw_command_block(&mut self, batch: &mut HudBatch) {
    // rust: let Some(mut s) = self.command_block_screen.take() else {
    // rust: return;
}
        // AbstractCommandBlockEditScreen.tick: the block (or the cart) is gone.
    // rust: if self.edit_base(&s).is_none() {
    // rust: self.close_command_block();
    // rust: return;
}
        // AbstractCommandBlockEditScreen: `GameNarrator.NO_TITLE`; its usage
        // is the suggestions' while they show (`getUsageNarration`).
    // rust: let usage = s.command.suggestions_usage();
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: let info = horizon_client::widgets::ScreenInfo::new("command_block", "");
    // rust: match usage {
    // rust: Some(key) => info.usage(super::screen_info::tr(key, &[])),
    // rust: None => info,
}
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let mid = (w / 2.0).floor();
        // Screen.extractBackground of an isInGameUi screen: the dimmed world,
        // with no blur and no menu background.
    // rust: batch.fill_gradient(
    // rust: atlas,
    // rust: (0.0, 0.0, w, h),
    // rust: rgba(0x10, 0x10, 0x10, 0xC0),
    // rust: rgba(0x10, 0x10, 0x10, 0xD0),
    // rust: );
    // rust: let title = Text::translate("advMode.setCommand", &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: (mid - tw / 2.0).floor(),
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let grey = rgba(160, 160, 160, 255);
    // rust: let label = Text::translate("advMode.command", &[]);
    // rust: batch.text_styled(atlas, &label, mid - 149.0, 40.0, grey, true);
    // rust: if !s.previous.value.is_empty() {
    // rust: let label = Text::translate("advMode.previousOutput", &[]);
            // 75 + 5 * 9 + 1 + getPreviousY() - 135, then the label's 4.
    // rust: let y = 125.0 + previous_y(s.cart.is_some()) - 135.0;
    // rust: batch.text_styled(atlas, &label, mid - 149.0, y, grey, true);
    // rust: s.previous.x = mid - 150.0;
    // rust: s.previous.draw(batch, atlas, None);
}
    // rust: for (b, x, y, bw) in CommandBlockScreen::buttons(w, h, s.cart.is_some()) {
    // rust: let hover = ui::hovered(self.cursor, x, y, bw, 20.0);
    // rust: let action = match b {
    // rust: Button::Done => Some(horizon_client::widgets::Action::Done),
    // rust: Button::Cancel => Some(horizon_client::widgets::Action::Cancel),
    // rust: _ => None,
}
    // rust: if let Some(action) = action {
    // rust: horizon_client::widgets::declare_action(action, [x, y, bw, 20.0], true);
}
    // rust: ui::button_as(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: bw,
    // rust: 20.0,
    // rust: &s.label(b),
    // rust: true,
    // rust: hover,
    // rust: |rect| s.narration(b, rect, &super::screen_info::tr),
    // rust: );
}
        // The command box, then its suggestions over the widgets.
    // rust: let m = Measure(&atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: s.command.resize(&m, &c, w as i32, h as i32);
    // rust: let mouse = (self.cursor.0.floor() as i32, self.cursor.1.floor() as i32);
    // rust: let blink = s.opened.elapsed().as_millis() as u64;
        // The command box is added first.
    // rust: let mark = horizon_client::widgets::narratables_mark();
    // rust: let draws = s.command.draw(&m, mouse, blink, 0);
    // rust: horizon_client::widgets::move_narratables(mark, 0);
    // rust: horizon_client::screen_draw::paint(batch, atlas, &draws);
    // rust: self.command_block_screen = Some(s);
}
    // The wheel over the suggestion list (`CommandSuggestions.mouseScrolled`).
    // rust: pub(super) fn command_block_scroll(&mut self, amount: f32) {
    // rust: let mouse = (self.cursor.0.floor() as i32, self.cursor.1.floor() as i32);
    // rust: if let Some(s) = self.command_block_screen.as_mut() {
    // rust: s.command.scroll(mouse, f64::from(amount));
}
}
    // The command box's completion request for an `ask_server` node.
    // rust: pub(super) fn command_block_suggestion_request(&mut self) -> Option<(i32, String)> {
    // rust: self.command_block_screen.as_mut()?.command.take_request()
}
    // The server's completions for the command box's `ask_server` request.
    // rust: pub(super) fn command_block_server_suggestions(
    // rust: &mut self,
    // rust: id: i32,
    // rust: range: (usize, usize),
    // rust: list: Vec<(String, Option<String>)>,
    // rust: ) {
    // rust: let Some(mut s) = self.command_block_screen.take() else {
    // rust: return;
}
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: s.command.server_suggestions(&m, &c, id, range, list);
    // rust: self.command_block_screen = Some(s);
}
    // rust: pub(super) fn command_block_click(&mut self) {
    // rust: let Some(mut s) = self.command_block_screen.take() else {
    // rust: return;
}
        // CommandSuggestions.mouseClicked first, then the command box.
    // rust: {
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: let (x, y) = (f64::from(self.cursor.0), f64::from(self.cursor.1));
    // rust: if s.command.click(&m, &c, x, y) {
    // rust: self.command_block_screen = Some(s);
    // rust: return;
}
}
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: let hit = CommandBlockScreen::buttons(b.width, b.height, s.cart.is_some())
    // rust: .into_iter()
    // rust: .find(|(_, x, y, bw)| ui::hovered(self.cursor, *x, *y, *bw, 20.0))
    // rust: .map(|b| b.0);
    // rust: if hit.is_some() {
    // rust: self.audio.play_button_click();
}
    // rust: match hit {
    // rust: Some(Button::Output) => {
    // rust: s.track_output = !s.track_output;
    // rust: if let Some(block) = self.edit_base(&s) {
    // rust: s.show_previous(block);
}
}
    // rust: Some(Button::Mode) => s.mode = s.mode.next(),
    // rust: Some(Button::Conditional) => s.conditional = !s.conditional,
    // rust: Some(Button::Auto) => s.auto = !s.auto,
    // rust: Some(Button::Done) => {
    // rust: self.set_command_block(&s);
    // rust: self.close_command_block();
    // rust: return;
}
    // rust: Some(Button::Cancel) => {
    // rust: self.close_command_block();
    // rust: return;
}
    // rust: None => {}
}
    // rust: self.command_block_screen = Some(s);
}
    // `AbstractCommandBlockEditScreen.keyPressed`: the suggestions first,
    // then Enter is Done, Escape cancels, the rest edits the command.
    // rust: pub(super) fn command_block_key(&mut self, event: &KeyEvent) {
    // rust: if event.state != ElementState::Pressed {
    // rust: return;
}
    // rust: let PhysicalKey::Code(key) = event.physical_key else {
    // rust: return;
}
    // rust: let shortcut = self.edit_shortcut(event);
    // rust: self.command_block_key_code(key, shortcut, event.text.as_deref());
}
    // A key pressed on the command block screen, with the edit shortcut it
    // makes and the text it types.
    // rust: pub(super) fn command_block_key_code(
    // rust: &mut self,
    // rust: key: KeyCode,
    // rust: shortcut: Option<horizon_client::clipboard::EditShortcut>,
    // rust: text: Option<&str>,
    // rust: ) {
    // rust: let ctrl = self.has_control_down_with_quirk();
    // rust: let shift = self.has_shift_down();
        // Windows' AltGr is Ctrl+Alt, and its characters still type.
    // rust: let types_text = self.types_text();
    // rust: let Some(mut s) = self.command_block_screen.take() else {
    // rust: return;
}
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if s.command.suggestions_key(&m, &c, key, shift) {
    // rust: self.command_block_screen = Some(s);
    // rust: return;
}
    // rust: let typed = match key {
    // rust: KeyCode::Escape | KeyCode::Enter | KeyCode::NumpadEnter => false,
    // rust: _ => {
    // rust: if let Some(shortcut) = shortcut {
    // rust: s.command.shortcut(&m, &c, shortcut, &mut self.clipboard);
    // rust: false
    // rust: } else {
    // rust: !s.command.field_key(&m, &c, key, shift, ctrl) && types_text
}
}
}
    // rust: self.command_block_screen = Some(s);
    // rust: if typed {
    // rust: self.command_block_type(text.unwrap_or(""));
}
    // rust: match key {
    // rust: KeyCode::Escape => self.close_command_block(),
    // rust: KeyCode::Enter | KeyCode::NumpadEnter => {
    // rust: if let Some(s) = self.command_block_screen.take() {
    // rust: self.set_command_block(&s);
}
    // rust: self.close_command_block();
}
    // rust: _ => {}
}
}
    // Characters typed into the command box (`StringUtil.isAllowedChatCharacter`).
    // rust: pub(super) fn command_block_type(&mut self, typed: &str) {
    // rust: let allowed: String = typed
    // rust: .chars()
    // rust: .filter(|&c| c != '\u{a7}' && c >= ' ' && c != '\u{7f}')
    // rust: .collect();
    // rust: if allowed.is_empty() {
    // rust: return;
}
    // rust: let Some(mut s) = self.command_block_screen.take() else {
    // rust: return;
}
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: s.command.type_text(&m, &c, &allowed);
    // rust: self.command_block_screen = Some(s);
}
    // The edit screen's Done: a server's client sends the packet, the
    // window's own world applies it (`handleSetCommandBlock`).
set_command_block :: proc(self: ^Self, s: ^CommandBlockScreen) {
}
    // rust: if !self.can_use_game_master_blocks() {
    // rust: self.system_message(Text::translate("advMode.notAllowed", &[]));
    // rust: return;
}
    // rust: if let Some(id) = s.cart {
    // rust: self.set_command_minecart(id, s);
    // rust: return;
}
    // rust: let edit = CommandBlockEdit {
    // rust: pos: s.pos,
    // rust: command: s.command.value().to_owned(),
    // rust: track_output: s.track_output,
    // rust: mode: s.mode,
    // rust: conditional: s.conditional,
    // rust: auto: s.auto,
}
    // rust: if self.remote.is_some() {
    // rust: self.send(S::SetCommandBlock(play::SetCommandBlock {
    // rust: pos: [edit.pos.0, edit.pos.1, edit.pos.2],
    // rust: command: edit.command,
    // rust: mode: edit.mode.ordinal(),
    // rust: flags: i8::from(edit.track_output)
    // rust: | (i8::from(edit.conditional) << 1)
    // rust: | (i8::from(edit.auto) << 2),
    // rust: }));
    // rust: } else {
    // rust: self.apply_command_block(&edit);
}
}
    // `ServerGamePacketListenerImpl.handleSetCommandBlock` for a guest: the
    // block is edited only by a creative player with game master commands.
    // rust: pub(super) fn lan_set_command_block(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::SetCommandBlock,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: let edit = CommandBlockEdit {
    // rust: pos: (p.pos[0], p.pos[1], p.pos[2]),
    // rust: command: p.command,
    // rust: track_output: p.flags & 1 != 0,
    // rust: mode: Mode::from_ordinal(p.mode),
    // rust: conditional: p.flags & 2 != 0,
    // rust: auto: p.flags & 4 != 0,
}
        // The confirmation (`advMode.setCommand.success`) is the editing player's alone.
    // rust: self.as_guest_messaged(host, conn, |game| {
    // rust: if allowed {
    // rust: game.apply_command_block(&edit);
                // BaseCommandBlock.onUpdated: the clients get the new command.
    // rust: game.mark_block_entity_updated(edit.pos);
    // rust: } else {
    // rust: game.system_message(Text::translate("advMode.notAllowed", &[]));
}
    // rust: });
}
    // `ServerPlayer.openCommandBlock`: the command block's data
    // (`saveCustomOnly`) goes to the guest whose use opened it, as the
    // chunk's update tag leaves it out and the edit screen shows it.
    // rust: pub(super) fn lan_open_command_block(&mut self, host: &mut LanHost, conn: u32, pos: Pos) {
    // rust: if !host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .is_some_and(|g| g.creative() && g.permission >= 2)
    // rust: {
    // rust: return;
}
    // rust: let Some(block) = self.command_block(pos) else {
    // rust: return;
}
    // rust: let tag = Tag::compound(block.save());
    // rust: let state = self.world.block(pos.0, pos.1, pos.2).0;
    // rust: let Some(kind) = host.hub.encoder.entity_type(state) else {
    // rust: return;
}
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::BlockEntityData(play::BlockEntityData {
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: kind,
    // rust: tag,
    // rust: }),
    // rust: );
}
    // What `handleSetCommandBlock` does once the player may edit the block.
apply_command_block :: proc(self: ^Self, s: ^CommandBlockEdit) {
}
    // rust: let pos = s.pos;
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(current) = self.block_state_at(pos) else {
    // rust: return;
}
    // rust: let Some(old_mode) = Mode::of_block(&current.name) else {
    // rust: return;
}
    // rust: if self.command_block(pos).is_none() {
    // rust: return;
}
        // The mode is the block, the conditional flag its state; the block
        // entity stays.
    // rust: let mut wanted = current.clone();
    // rust: wanted.name = s.mode.block().to_owned();
    // rust: wanted
    // rust: .properties
    // rust: .insert("conditional".into(), s.conditional.to_string());
    // rust: if let Ok(id) = registry.resolve(&wanted)
    // rust: && wanted != *current
    // rust: {
    // rust: let entity = self.world.block_entities.take(&pos);
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, at, id, flags::UPDATE_CLIENTS)
    // rust: });
    // rust: if let Some(entity) = entity {
    // rust: self.world.block_entities.put(pos, entity);
}
    // rust: let _ = self.process_level_events();
}
    // rust: let command = s.command.clone();
    // rust: let Some(c) = command_block_mut(&mut self.world, pos) else {
    // rust: return;
}
    // rust: c.set_command(&command);
    // rust: c.track_output = s.track_output;
    // rust: if !s.track_output {
    // rust: c.last_output = None;
}
        // CommandBlockEntity.setAutomatic, then onModeSwitch.
    // rust: let (was_auto, powered) = (c.auto, c.powered);
    // rust: c.auto = s.auto;
    // rust: if !was_auto && s.auto && !powered && s.mode != Mode::Sequence {
    // rust: self.schedule_command_block_tick(pos);
}
    // rust: if old_mode != s.mode && s.mode == Mode::Auto && (powered || s.auto) {
    // rust: self.schedule_command_block_tick(pos);
}
    // rust: if !command.is_empty() {
    // rust: let key = if self.ui.rules.bool("command_blocks_work") {
    // rust: "advMode.setCommand.success"
    // rust: } else {
    // rust: "advMode.setCommand.disabled"
}
    // rust: self.system_message(Text::translate(key, &[Text::literal(command)]));
}
}
}

    // rust: mod tests {
//     use super::*;

a_minecart_screen_has_no_mode_buttons_and_a_lower_output_row :: proc() {
}
    // rust: let cart = CommandBlockScreen::buttons(400.0, 240.0, true);
    // rust: let kinds: Vec<_> = cart.iter().map(|b| b.0).collect();
    // rust: assert!(kinds == [Button::Output, Button::Done, Button::Cancel]);
        // MinecartCommandBlockEditScreen.getPreviousY.
    // rust: assert_eq!(cart[0].2, 150.0);
    // rust: let block = CommandBlockScreen::buttons(400.0, 240.0, false);
    // rust: assert_eq!(block.len(), 6);
    // rust: assert_eq!(block[0].2, 135.0);
        // Done and Cancel sit at the same height on both.
    // rust: assert_eq!(cart[1].2, block[4].2);
}
}

    // rust: mod narration_tests {
//     use super::*;
//     use horizon_client::widgets::What;

keys :: proc(key: string, args: ^[string]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if args.is_empty() {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("{key}({})", args.join(", "))
}
}

the_switches_narrate_as_cycle_buttons_showing_their_value :: proc() {
}
    // rust: let state = (true, Mode::Redstone, false, true);
    // rust: let cycle = |b| button_narration(b, state, [0.0; 4], &keys).what;
    // rust: let expect = |message: &str, next: &str| What::Cycle {
    // rust: message: message.into(),
    // rust: next: next.into(),
    // rust: active: true,
}
    // rust: assert_eq!(
    // rust: cycle(Button::Output),
    // rust: expect("options.generic_value(advMode.trackOutput, O)", "X")
    // rust: );
    // rust: assert_eq!(
    // rust: cycle(Button::Mode),
    // rust: expect(
    // rust: "options.generic_value(advMode.mode, advMode.mode.redstone)",
    // rust: "advMode.mode.sequence"
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: cycle(Button::Conditional),
    // rust: expect(
    // rust: "options.generic_value(advMode.type, advMode.mode.unconditional)",
    // rust: "advMode.mode.conditional"
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: cycle(Button::Auto),
    // rust: expect(
    // rust: "options.generic_value(advMode.triggering, advMode.mode.autoexec.bat)",
    // rust: "advMode.mode.redstoneTriggered"
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: cycle(Button::Done),
    // rust: What::Button {
    // rust: message: "gui.done".into(),
    // rust: active: true
}
    // rust: );
}
}
