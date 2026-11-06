//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sign_edit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The sign editing screen (`SignEditScreen` / `HangingSignEditScreen`):
//! opened when a sign is placed, four lines limited to the sign's line
//! width, Up/Down/Enter move between lines, Escape or Done closes.
// use super::{
    // rust: Game,
    // rust: commands::{Target, execute::Source},
    // rust: lan::LanHost,
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: signs::{ClickAction, DYE_TEXT, click_action, editor_sprite},
    // rust: ui::EditBox,
}
// use horizon_protocol::packets::play::{self, Clientbound as C, Serverbound as S};
// use winit::{
    // rust: event::{ElementState, KeyEvent},
    // rust: keyboard::{KeyCode, PhysicalKey},
}

    // rust: pub(super) struct SignEditor {
    // rust: pub pos: (i32, i32, i32),
    // rust: pub front: bool,
    // rust: pub line: usize,
    /// The line being edited (`AbstractSignEditScreen`'s text field).
    // rust: edit: EditBox,
    /// `AbstractSignEditScreen.messages`: the side's lines as edited, sent
    /// when the editor closes, even if the sign is gone by then.
    // rust: lines: [String; 4],
}

pub fn sign_box() E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut edit = EditBox::new(0.0, 0.0, 90.0, 9.0);
    // rust: edit.bordered = false;
    // rust: edit.max_length = 384;
    // rust: edit.focused = true;
    // rust: edit
}

/// The Done button's text, `CommonComponents.GUI_DONE`, in the selected language.
pub fn done_label() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::screen_info::tr("gui.done", &[])
}
/// AbstractSignEditScreen.init's Done button: `width / 2 - 100`,
/// `height / 4 + 144`, int GUI pixels.
pub fn done_button(w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: (w.ceil() / 2.0).floor() - 100.0,
    // rust: (h.ceil() / 4.0).floor() + 144.0,
    // rust: )
}

    // rust: impl Game<'_> {
    /// `SignBlockEntity.getSlotPlayerIsFacing`: whether the player stands in
    /// front of the sign's text (within 90 degrees of its facing).
pub fn facing_sign_front(self: *Self, pos: (i32) void {
}
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return true;
}
    // rust: let id = self.world.block(pos.0, pos.1, pos.2);
    // rust: let Some(state) = self.pack.assets.registry.state(id) else {
    // rust: return true;
}
    // rust: let form = self.res.facts().get(id).sign_form();
    // rust: let prop = |key: &str| state.properties.get(key).map(String::as_str);
        // getYRotationDegrees: a wall sign's `Direction.toYRot`, a standing or
        // ceiling sign's rotation segment.
    // rust: let y_rot = if form.is_some_and(|f| f.wall) {
    // rust: match prop("facing") {
    // rust: Some("west") => 90.0,
    // rust: Some("north") => 180.0,
    // rust: Some("east") => 270.0,
    // rust: _ => 0.0,
}
    // rust: } else {
    // rust: prop("rotation")
    // rust: .and_then(|r| r.parse::<f32>().ok())
    // rust: .unwrap_or(0.0)
    // rust: * 22.5
}
        // getSignHitboxCenterPosition: only a wall sign's board is off-centre,
        // against the wall it hangs on.
    // rust: let centre = if form.is_some_and(|f| f.wall && !f.hanging) {
    // rust: match y_rot as i32 {
    // rust: 90 => (0.9375, 0.5),
    // rust: 180 => (0.5, 0.9375),
    // rust: 270 => (0.0625, 0.5),
    // rust: _ => (0.5, 0.0625),
}
    // rust: } else {
    // rust: (0.5, 0.5)
}
    // rust: let xd = player.position.x - (f64::from(pos.0) + centre.0);
    // rust: let zd = player.position.z - (f64::from(pos.2) + centre.1);
    // rust: let player_y_rot = (zd.atan2(xd).to_degrees() - 90.0) as f32;
        // Mth.degreesDifferenceAbs.
    // rust: let diff = (player_y_rot - y_rot).rem_euclid(360.0);
    // rust: let diff = if diff >= 180.0 { 360.0 - diff } else { diff };
    // rust: diff <= 90.0
}
    /// `SignBlockEntity.canExecuteClickCommands` for the side the acting
    /// player faces: a waxed sign with a `run_command` click event on it.
    // rust: pub(super) fn sign_can_execute_click_commands(&self, pos: (i32, i32, i32)) -> bool {
        // Only a waxed sign can; skip the facing maths for everything else.
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get(&pos) else {
    // rust: return false;
}
    // rust: sign.waxed && sign.can_execute_click_commands(self.facing_sign_front(pos))
}
    /// `SignBlockEntity.createCommandSourceStack`: the acting player runs the
    /// command from the middle of the sign's block, rotation zero, at the
    /// game master level, with `CommandSource.NULL` (no feedback, no failure
    /// messages).
pub fn sign_command_source(self: *Self, pos: [i32; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Source {
    // rust: entity: self.player.is_some().then_some(Target::Player),
    // rust: pos: pos.map(|v| f64::from(v) + 0.5),
    // rust: rot: [0.0, 0.0],
    // rust: eyes: false,
    // rust: silent: true,
    // rust: store: None,
    // rust: dimension: self.dim,
    // rust: level: None,
    // rust: block: None,
    // rust: cart: None,
}
}
    /// Run a sign's `run_command` line as the prefixed command vanilla runs
    /// it as: a leading slash is allowed, errors are not reported (the NULL
    /// source).
pub fn run_sign_command(self: *Self, pos: [i32; 3], command: []const u8) void {
}
    // rust: let source = self.sign_command_source(pos);
    // rust: let line = command.strip_prefix('/').unwrap_or(command);
    // rust: self.exec = Default::default();
    // rust: let permission = std::mem::replace(&mut self.ui.registries.permission, 2);
    // rust: let _ = self.execute_line(line, source);
    // rust: self.ui.registries.permission = permission;
        // InventoryChangeTrigger fires as slots change, not on the next tick.
    // rust: if self.player.is_some() {
    // rust: self.check_inventory_trigger();
}
}
    /// `SignBlockEntity.executeClickCommandsIfPresent`: every line of the
    /// side whose style has a `run_command`, `show_dialog` or `custom` click
    /// event runs it as the acting player when the sign allows op features;
    /// otherwise the player is told click actions are disabled. Whether any
    /// line had one.
pub fn execute_sign_click_commands(self: *Self, pos: [i32; 3], front: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get(&key) else {
    // rust: return false;
}
    // rust: let allow_op_features = sign.allow_op_features;
    // rust: let side = if front { &sign.front } else { &sign.back };
        // The side as it was when the loop began: a command may change it.
    // rust: let events: Vec<_> = side.click.iter().flatten().cloned().collect();
    // rust: let mut any_click_command = false;
    // rust: for event in &events {
    // rust: match click_action(event) {
    // rust: Some(ClickAction::RunCommand(command)) => {
    // rust: if allow_op_features {
    // rust: self.run_sign_command(pos, &command);
}
    // rust: any_click_command = true;
}
    // rust: Some(ClickAction::ShowDialog(dialog)) => {
    // rust: if allow_op_features {
    // rust: self.show_click_dialog(dialog);
}
    // rust: any_click_command = true;
}
                // MinecraftServer.handleCustomClickAction only logs it.
    // rust: Some(ClickAction::Custom { id, payload }) => {
    // rust: if allow_op_features {
    // rust: log::debug!("Received custom click action {id} with payload {payload:?}");
}
    // rust: any_click_command = true;
}
    // rust: None => {}
}
}
    // rust: if !allow_op_features && any_click_command {
    // rust: self.sign_click_actions_disabled();
}
    // rust: any_click_command
}
    /// `Player.sendOverlayMessage(CLICK_ACTIONS_DISABLED)`: red text on the
    /// action bar. A guest gets a packet, so its own client translates it.
pub fn sign_click_actions_disabled(self: *Self) void {
}
pub const KEY: []const u8 = "sign.click_actions_disabled";
    // rust: if self.lan_acting.is_some() {
    // rust: let message = horizon_client::text::Text::translate(KEY, &[])
    // rust: .with_color(horizon_client::text::RED);
    // rust: self.guest_packets.push(C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&message.component()),
    // rust: overlay: true,
    // rust: }));
    // rust: } else {
    // rust: self.message = Some((
    // rust: self.translate(KEY, "Click actions are disabled for this sign"),
    // rust: std::time::Instant::now(),
    // rust: ));
}
}
    /// `SignBlock.useWithoutItem` (the block's `OpenMenu` effect): the side
    /// the player faces runs its click commands first; then a waxed sign
    /// plays the failed-interaction sound, a sign that ran one does nothing
    /// more, and otherwise a player who may build edits the side they face.
    // rust: pub(super) fn use_sign_empty_hand(&mut self, pos: [i32; 3]) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if !matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Sign(_))
    // rust: ) {
    // rust: return;
}
    // rust: let front = self.facing_sign_front(key);
    // rust: let executed = self.execute_sign_click_commands(pos, front);
        // The commands may have changed the sign, or removed it.
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: if sign.waxed {
            // `getSignInteractionFailedSoundEvent`: a hanging sign has its own.
    // rust: let sound = if sign.hanging {
    // rust: "minecraft:block.hanging_sign.waxed_interact_fail"
    // rust: } else {
    // rust: "minecraft:block.sign.waxed_interact_fail"
}
    // rust: self.audio
    // rust: .play(sound, Some(pos.map(|v| f64::from(v) + 0.5)), 1.0, 1.0);
    // rust: } else if !executed && self.may_build() {
    // rust: self.open_sign_editor(key, front);
}
}
    /// `SignBlock.useItemOn` with a `SignApplicator` in hand (dyes, ink sacs,
    /// honeycomb): the item changes the side the player faces and is used up.
    /// Whether it did; a sign it does not apply to goes on to the empty hand.
    // rust: pub(super) fn use_sign_applicator(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: let Some(stack) = held else {
    // rust: return false;
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get(&key) else {
    // rust: return false;
}
    // rust: if sign.waxed || !self.may_build() {
    // rust: return false;
}
    // rust: let item = &*stack.item;
    // rust: let dye = if item.ends_with("_dye") {
    // rust: self.res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.dye.clone())
    // rust: } else {
    // rust: None
}
    // rust: let colour = dye.and_then(|d| DYE_TEXT.iter().position(|(n, _)| *n == d));
    // rust: if !matches!(
    // rust: item,
    // rust: "minecraft:honeycomb" | "minecraft:glow_ink_sac" | "minecraft:ink_sac"
    // rust: ) && colour.is_none()
    // rust: {
    // rust: return false;
}
    // rust: let front = self.facing_sign_front(key);
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get_mut(&key) else {
    // rust: return false;
}
    // rust: let centre = pos.map(|v| f64::from(v) + 0.5);
    // rust: let sound = if item == "minecraft:honeycomb" {
            // HoneycombItem.tryApplyToSign: waxes any sign, empty or not.
    // rust: sign.waxed = true;
    // rust: "minecraft:item.honeycomb.wax_on"
    // rust: } else {
    // rust: let side = if front {
    // rust: &mut sign.front
    // rust: } else {
    // rust: &mut sign.back
}
            // SignApplicator.canApplyToSign: the side must have text.
    // rust: if side.is_empty() {
    // rust: return false;
}
    // rust: match colour {
    // rust: Some(c) if side.color != c as u8 => {
    // rust: side.color = c as u8;
    // rust: "minecraft:item.dye.use"
}
    // rust: None if item == "minecraft:glow_ink_sac" && !side.glowing => {
    // rust: side.glowing = true;
    // rust: "minecraft:item.glow_ink_sac.use"
}
    // rust: None if item == "minecraft:ink_sac" && side.glowing => {
    // rust: side.glowing = false;
    // rust: "minecraft:item.ink_sac.use"
}
    // rust: _ => return false,
}
}
    // rust: if item == "minecraft:honeycomb" {
    // rust: self.level_event_at(3003, pos, 0);
}
    // rust: self.audio.play(sound, Some(centre), 1.0, 1.0);
    // rust: self.mark_block_entity_updated(key);
    // rust: self.execute_sign_click_commands(pos, front);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: pos,
    // rust: self.sculk_actor(),
    // rust: Some(state),
    // rust: );
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.consume_held();
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, stack);
    // rust: true
}
    /// `SignBlock.openTextEdit` for the front side after placement.
    // rust: pub(super) fn open_sign_editor(&mut self, pos: (i32, i32, i32), front: bool) {
        // Minecraft.setScreen: the editor already open is removed first.
    // rust: self.close_sign_editor();
    // rust: let lines = match self.world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::Sign(sign)) if front => sign.front.lines.clone(),
    // rust: Some(BlockEntity::Sign(sign)) => sign.back.lines.clone(),
    // rust: _ => Default::default(),
}
    // rust: self.sign_edit = Some(SignEditor {
    // rust: pos,
    // rust: front,
    // rust: line: 0,
    // rust: edit: sign_box(),
    // rust: lines,
    // rust: });
    // rust: self.sign_load();
    // rust: self.keys.clear();
    // rust: self.right = false;
    // rust: self.capture(false);
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_open_sign(player, &name, [pos.0, pos.1, pos.2], front);
}
}
    /// `AbstractSignEditScreen.tick`: the editor closes (and `removed` sends
    /// the text) once its sign is removed or the player's eyes are further
    /// than 4 blocks beyond the block interaction range
    /// (`SignBlockEntity.playerIsTooFarAwayToEdit`).
    // rust: pub(super) fn tick_sign_editor(&mut self) {
    // rust: let Some(edit) = &self.sign_edit else {
    // rust: return;
}
    // rust: let (x, y, z) = edit.pos;
    // rust: let near = self.eye_position().is_some_and(|eye| {
    // rust: horizon_client::lan::guest::within_block_range(eye, self.reach() + 4.0, [x, y, z])
    // rust: });
    // rust: let sign = matches!(
    // rust: self.world.block_entities.get(&edit.pos),
    // rust: Some(BlockEntity::Sign(_))
    // rust: );
    // rust: if !sign || !near {
    // rust: self.close_sign_editor();
}
}
    /// `AbstractSignEditScreen.removed`: a server's client sends what it
    /// wrote (ServerboundSignUpdatePacket); the window's own world keeps it
    /// and sends it to its guests (`sendBlockUpdated`).
    // rust: pub(super) fn close_sign_editor(&mut self) {
    // rust: if let Some(edit) = self.sign_edit.take() {
    // rust: if self.remote.is_some() {
    // rust: self.send(S::SignUpdate(play::SignUpdate {
    // rust: pos: [edit.pos.0, edit.pos.1, edit.pos.2],
    // rust: lines: edit.lines,
    // rust: front: edit.front,
    // rust: }));
    // rust: } else {
    // rust: self.mark_block_entity_updated(edit.pos);
}
}
    // rust: self.capture(true);
}
    /// `ServerPlayer.openTextEdit` for the guest whose action opened a sign:
    /// the block, then the editor, on its client, and the guest may write on it.
    // rust: pub(super) fn lan_open_sign_editor(&mut self, host: &mut LanHost, conn: u32, edit: SignEditor) {
    // rust: let pos = [edit.pos.0, edit.pos.1, edit.pos.2];
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0 as i32;
    // rust: host.hub
    // rust: .send_to(conn, &C::BlockUpdate(play::BlockUpdate { pos, state }));
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::OpenSignEditor(play::OpenSignEditor {
    // rust: pos,
    // rust: front: edit.front,
    // rust: }),
    // rust: );
    // rust: host.play.entry(conn).or_default().sign_editing = Some(pos);
}
    /// `ServerGamePacketListenerImpl.handleSignUpdate`: the lines, formatting
    /// codes stripped, go on the sign the guest may write on unless it is
    /// waxed (`SignBlockEntity.updateSignText`); a guest gone out of reach
    /// may no longer write (`playerIsTooFarAwayToEdit`).
    // rust: pub(super) fn lan_sign_update(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: mut p: play::SignUpdate,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let near = g.within_block_range(p.pos, 4.0);
    // rust: let Some(play) = host.play.get_mut(&conn) else {
    // rust: return;
}
    // rust: if !near {
    // rust: play.sign_editing = None;
}
    // rust: if play.sign_editing != Some(p.pos) {
    // rust: log::warn!("{} just tried to change non-editable sign", g.name);
    // rust: return;
}
    // rust: let key = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: let lines = p.lines.join(" ");
    // rust: if !self.chat_filter_text(
    // rust: host,
    // rust: conn,
    // rust: &[&lines],
    // rust: horizon_client::lan::hub::chat_filter::Place::Sign,
    // rust: ) {
            // The sign stays as it was: the editor closes, as after a sign the server refused.
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.sign_editing = None;
}
            // The player's client shows the text it sent: the sign as it is, again.
    // rust: self.mark_block_entity_updated(key);
    // rust: return;
}
    // rust: if !matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Sign(sign)) if !sign.waxed
    // rust: ) {
    // rust: return;
}
        // Everything vanilla checks has passed: the mods hear what is about to
        // go on the sign, with the player's state swapped in, and may rewrite
        // or refuse it.
    // rust: if let Some((uuid, name, dimension)) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .map(|g| (g.uuid, g.name.clone(), g.dimension.clone()))
    // rust: {
    // rust: let mut lines = p.lines.to_vec();
    // rust: let mut cancel = false;
    // rust: self.as_guest_messaged(host, conn, |game| {
    // rust: game.native_sign_changed(
    // rust: uuid,
    // rust: &name,
    // rust: &dimension,
    // rust: p.pos,
    // rust: p.front,
    // rust: &mut lines,
    // rust: &mut cancel,
    // rust: );
    // rust: });
    // rust: if cancel {
                // The sign keeps its text: the editor closes, and the player's
                // client, which shows what it sent, gets the sign as it is.
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.sign_editing = None;
}
    // rust: self.mark_block_entity_updated(key);
    // rust: return;
}
    // rust: lines.resize(4, String::new());
    // rust: for (line, new) in p.lines.iter_mut().zip(lines) {
    // rust: *line = new;
}
}
    // rust: let Some(play) = host.play.get_mut(&conn) else {
    // rust: return;
}
        // A hook may have broken the sign.
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get_mut(&key) else {
    // rust: return;
}
    // rust: if sign.waxed {
    // rust: return;
}
    // rust: let side = if p.front {
    // rust: &mut sign.front
    // rust: } else {
    // rust: &mut sign.back
}
    // rust: for (line, new) in side.lines.iter_mut().zip(&p.lines) {
    // rust: *line = horizon_client::clipboard::strip_formatting(new);
}
    // rust: play.sign_editing = None;
    // rust: self.mark_block_entity_updated(key);
}
    /// `ClientPacketListener.handleOpenSignEditor`: the editor on a sign this
    /// client has.
    // rust: pub(super) fn remote_open_sign_editor(&mut self, p: play::OpenSignEditor) {
    // rust: let key = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: if matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Sign(_))
    // rust: ) {
    // rust: self.open_sign_editor(key, p.front);
    // rust: } else {
    // rust: log::warn!(
    // rust: "ignoring openTextEdit on a block that is no sign at {:?}",
    // rust: p.pos
    // rust: );
}
}
    // rust: pub(super) fn sign_edit_key(&mut self, event: &KeyEvent) {
    // rust: if event.state != ElementState::Pressed {
    // rust: return;
}
    // rust: if let Some(shortcut) = self.edit_shortcut(event) {
    // rust: self.sign_shortcut(shortcut);
    // rust: return;
}
    // rust: let key = match event.physical_key {
    // rust: PhysicalKey::Code(k) => Some(k),
    // rust: _ => None,
}
    // rust: self.sign_input(key, event.text.as_deref());
}
    /// A key and the text it typed on the sign being edited (the keyboard,
    /// or a controller's on-screen keyboard).
    // rust: pub(super) fn sign_input(&mut self, key: Option<KeyCode>, typed: Option<&str>) {
    // rust: if self.sign_edit.is_none() {
    // rust: return;
}
    // rust: match key {
    // rust: Some(KeyCode::Escape) => self.close_sign_editor(),
    // rust: Some(KeyCode::ArrowUp) => self.sign_move_line(3),
    // rust: Some(KeyCode::ArrowDown | KeyCode::Enter | KeyCode::NumpadEnter) => {
    // rust: self.sign_move_line(1)
}
    // rust: Some(
    // rust: key @ (KeyCode::ArrowLeft
    // rust: | KeyCode::ArrowRight
    // rust: | KeyCode::Home
    // rust: | KeyCode::End
    // rust: | KeyCode::Backspace
    // rust: | KeyCode::Delete),
    // rust: ) => {
    // rust: let (ctrl, shift) = (self.has_control_down(), self.has_shift_down());
    // rust: self.sign_change(|edit| {
    // rust: edit.key(key, ctrl, shift);
    // rust: });
}
    // rust: _ => {
    // rust: let Some(typed) = typed else {
    // rust: return;
}
    // rust: self.sign_change(|edit| edit.insert_text(typed));
}
}
}
    /// Up or down a line: the box writes the line it leaves and loads the next.
pub fn sign_move_line(self: *Self, by: usize) void {
}
    // rust: self.sign_write();
    // rust: if let Some(edit) = self.sign_edit.as_mut() {
    // rust: edit.line = (edit.line + by) & 3;
}
    // rust: self.sign_load();
}
    /// The edited line's text.
pub fn sign_current(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let edit = self.sign_edit.as_ref()?;
    // rust: let BlockEntity::Sign(sign) = self.world.block_entities.get(&edit.pos)? else {
    // rust: return None;
}
    // rust: let side = if edit.front { &sign.front } else { &sign.back };
    // rust: Some(side.lines[edit.line].clone())
}
    /// `EditBox.setValue` from the line now being edited.
pub fn sign_load(self: *Self) void {
}
    // rust: let Some(text) = self.sign_current() else {
    // rust: return;
}
    // rust: if let Some(edit) = self.sign_edit.as_mut() {
    // rust: edit.edit.set_value(&text);
}
}
    /// The box's text onto the editor's lines and the sign
    /// (`AbstractSignEditScreen.setMessage`), when it still fits the line.
pub fn sign_write(self: *Self) void {
}
    // rust: let Some(edit) = self.sign_edit.as_ref() else {
    // rust: return;
}
    // rust: let (pos, front, line, value) = (edit.pos, edit.front, edit.line, edit.edit.value.clone());
    // rust: if !self.sign_fits(&value) {
    // rust: return;
}
    // rust: if let Some(edit) = self.sign_edit.as_mut() {
    // rust: edit.lines[line].clone_from(&value);
}
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return;
}
    // rust: let side = if front {
    // rust: &mut sign.front
    // rust: } else {
    // rust: &mut sign.back
}
    // rust: side.lines[line] = value;
}
    /// TextFieldHelper: `font.width(s) <= maxTextLineWidth`.
pub fn sign_fits(self: *Self, value: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(edit) = self.sign_edit.as_ref() else {
    // rust: return false;
}
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get(&edit.pos) else {
    // rust: return false;
}
    // rust: HudBatch::text_width(&self.gui.atlas, value) <= sign.max_line_width()
}
    /// Edit the line, then keep the result only when it still fits.
pub fn sign_change(self: *Self, f: impl FnOnce(*mut EditBox) void {
}
    // rust: let before = self
    // rust: .sign_edit
    // rust: .as_ref()
    // rust: .map(|e| (e.edit.value.clone(), e.edit.cursor, e.edit.highlight));
    // rust: if let Some(edit) = self.sign_edit.as_mut() {
    // rust: f(&mut edit.edit);
    // rust: let clean = horizon_client::clipboard::strip_formatting(&edit.edit.value);
    // rust: if clean != edit.edit.value {
    // rust: let n = horizon_client::ui::char_len(&clean);
    // rust: edit.edit.value = clean;
    // rust: edit.edit.cursor = edit.edit.cursor.min(n);
    // rust: edit.edit.highlight = edit.edit.highlight.min(n);
}
}
    // rust: self.sign_keep(before);
}
    /// Write the box when the line still fits; otherwise put the old text back.
pub fn sign_keep(self: *Self, before: Option<([]const u8) void {
}
    // rust: let value = self
    // rust: .sign_edit
    // rust: .as_ref()
    // rust: .map(|e| e.edit.value.clone())
    // rust: .unwrap_or_default();
    // rust: if self.sign_fits(&value) {
    // rust: self.sign_write();
    // rust: } else if let (Some(edit), Some((value, cursor, highlight))) =
    // rust: (self.sign_edit.as_mut(), before)
    // rust: {
    // rust: edit.edit.value = value;
    // rust: edit.edit.cursor = cursor;
    // rust: edit.edit.highlight = highlight;
}
}
    /// `TextFieldHelper.keyPressed`'s shortcuts on the edited line. Paste
    /// reads `getClipboardContents` before `insertText`. A paste that would
    /// pass the sign's width is refused whole.
pub fn sign_shortcut(self: *Self, shortcut: horizon_client::clipboard::EditShortcut) void {
}
    // rust: if shortcut == horizon_client::clipboard::EditShortcut::Paste {
    // rust: let raw = horizon_client::clipboard::Clipboard::get(&mut self.clipboard);
    // rust: let text = horizon_client::clipboard::helper_clipboard_contents(&raw);
    // rust: self.sign_change(|edit| edit.insert_text(&text));
    // rust: return;
}
    // rust: let before = self
    // rust: .sign_edit
    // rust: .as_ref()
    // rust: .map(|e| (e.edit.value.clone(), e.edit.cursor, e.edit.highlight));
    // rust: if let Some(edit) = self.sign_edit.as_mut() {
    // rust: edit.edit.shortcut(shortcut, &mut self.clipboard);
    // rust: let clean = horizon_client::clipboard::strip_formatting(&edit.edit.value);
    // rust: if clean != edit.edit.value {
    // rust: let n = horizon_client::ui::char_len(&clean);
    // rust: edit.edit.value = clean;
    // rust: edit.edit.cursor = edit.edit.cursor.min(n);
    // rust: edit.edit.highlight = edit.edit.highlight.min(n);
}
}
    // rust: self.sign_keep(before);
}
    /// Done button (`this.width / 2 - 100, this.height / 4 + 144`, 200x20),
    /// or a click on a line (`EditBox.onClick`).
    // rust: pub(super) fn sign_edit_click(&mut self, size: [u32; 2]) {
    // rust: let b = HudBatch::new(size);
    // rust: let (x, y) = done_button(b.width, b.height);
    // rust: let (mx, my) = self.cursor;
    // rust: if mx >= x && mx < x + 200.0 && my >= y && my < y + 20.0 {
    // rust: self.audio.play_button_click();
    // rust: self.close_sign_editor();
    // rust: return;
}
    // rust: let Some((cx, top, line_height, max_width, lines)) = self.sign_lines(b.width) else {
    // rust: return;
}
    // rust: let shift = self.has_shift_down();
    // rust: for i in 0..lines.len() {
    // rust: let ly = top + i as f32 * line_height;
    // rust: let left = cx - max_width / 2.0;
    // rust: if mx < left || mx >= left + max_width || my < ly || my >= ly + line_height {
    // rust: continue;
}
    // rust: let current = self.sign_edit.as_ref().map(|e| e.line);
    // rust: if current != Some(i) {
    // rust: self.sign_move_line((i + 4 - current.unwrap_or(0)) & 3);
}
    // rust: let value = self
    // rust: .sign_edit
    // rust: .as_ref()
    // rust: .map(|e| e.edit.value.clone())
    // rust: .unwrap_or_default();
    // rust: let lw = HudBatch::text_width(&self.gui.atlas, &value);
    // rust: let text_x = cx - (lw as i32 / 2) as f32;
    // rust: if let Some(edit) = self.sign_edit.as_mut() {
    // rust: edit.edit.x = text_x;
    // rust: edit.edit.y = ly;
    // rust: edit.edit.width = max_width;
    // rust: edit.edit.click(&self.gui.atlas, mx, shift, false);
}
    // rust: self.sign_write();
    // rust: return;
}
}
    /// Centre x, the first line's y, the line height, the width limit and the four lines.
pub fn sign_lines(self: *Self, width: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let edit = self.sign_edit.as_ref()?;
    // rust: let BlockEntity::Sign(sign) = self.world.block_entities.get(&edit.pos)? else {
    // rust: return None;
}
    // rust: let text = if edit.front { &sign.front } else { &sign.back };
    // rust: let line_height = sign.line_height();
    // rust: let y = if sign.hanging { 125.0 } else { 90.0 };
    // rust: let top = y - (4.0 * line_height / 2.0).floor();
    // rust: Some((
    // rust: width / 2.0,
    // rust: top,
    // rust: line_height,
    // rust: sign.max_line_width(),
    // rust: text.lines.to_vec(),
    // rust: ))
}
    // rust: pub(super) fn draw_sign_editor(&self, batch: &mut HudBatch) {
    // rust: let Some(edit) = &self.sign_edit else { return };
    // rust: let Some(BlockEntity::Sign(sign)) = self.world.block_entities.get(&edit.pos) else {
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: batch.fill(atlas, 0.0, 0.0, w, h, rgba(16, 16, 16, 160));
    // rust: let (key, fallback) = if sign.hanging {
    // rust: ("hanging_sign.edit", "Edit Hanging Sign Message")
    // rust: } else {
    // rust: ("sign.edit", "Edit Sign Message")
}
    // rust: let title = self.translate(key, fallback);
        // SignEditScreen / HangingSignEditScreen: their title.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new("sign_edit", title.clone())
    // rust: });
    // rust: let tw = HudBatch::text_width(atlas, &title);
    // rust: batch.text(atlas, &title, (w - tw) / 2.0, 40.0, u32::MAX, true);
    // rust: let facts = self.res.facts();
    // rust: let block = facts.get(self.world.block(edit.pos.0, edit.pos.1, edit.pos.2));
    // rust: let wood = facts.wood_type(&block.name).unwrap_or("oak");
    // rust: let cx = w / 2.0;
    // rust: let y = if sign.hanging {
            // HangingSignEditScreen: 16x16 texture scaled 4.5 at (0, -13).
    // rust: let s = 4.5;
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &editor_sprite("hanging_signs", wood),
    // rust: cx - 8.0 * s,
    // rust: 125.0 - 13.0 - 8.0 * s,
    // rust: 16.0 * s,
    // rust: 16.0 * s,
    // rust: u32::MAX,
    // rust: );
    // rust: 125.0
    // rust: } else {
            // SignEditScreen: 24x26 texture scaled 3.9 at (0, 27); wall signs show 12 rows.
    // rust: let s = 3.9;
    // rust: let wall = block.sign_form().is_some_and(|f| f.wall);
    // rust: let rows = if wall { 12.0 } else { 26.0 };
    // rust: if let Some(mut r) = atlas.sprites.get(&editor_sprite("signs", wood)).copied() {
    // rust: r.v1 = r.v0 + (r.v1 - r.v0) * rows / 26.0;
    // rust: batch.rect_uv(
    // rust: cx - 12.0 * s,
    // rust: 90.0 + 27.0 - 13.0 * s,
    // rust: 24.0 * s,
    // rust: rows * s,
    // rust: r,
    // rust: u32::MAX,
    // rust: );
}
    // rust: 90.0
}
    // rust: let text = if edit.front { &sign.front } else { &sign.back };
    // rust: let color = if text.glowing {
    // rust: text.text_color()
    // rust: } else {
    // rust: text.dark_color()
}
    // rust: let color = rgba((color >> 16) as u8, (color >> 8) as u8, color as u8, 255);
    // rust: let line_height = sign.line_height();
    // rust: let midpoint = (4.0 * line_height / 2.0).floor();
    // rust: for (i, line) in text.lines.iter().enumerate() {
    // rust: let shown = if i == edit.line {
    // rust: edit.edit.value.as_str()
    // rust: } else {
    // rust: line.as_str()
}
    // rust: let lw = HudBatch::text_width(atlas, shown);
    // rust: let x = cx - (lw as i32 / 2) as f32;
    // rust: let ly = y + i as f32 * line_height - midpoint;
    // rust: batch.text(atlas, shown, x, ly, color, false);
    // rust: if i != edit.line {
    // rust: continue;
}
    // rust: let value = &edit.edit.value;
    // rust: if edit.edit.cursor != edit.edit.highlight {
    // rust: let (a, b) = (
    // rust: edit.edit.cursor.min(edit.edit.highlight),
    // rust: edit.edit.cursor.max(edit.edit.highlight),
    // rust: );
    // rust: let pre: String = value.chars().take(a).collect();
    // rust: let sel: String = value.chars().skip(a).take(b - a).collect();
    // rust: batch.text_highlight(
    // rust: atlas,
    // rust: (
    // rust: x + HudBatch::text_width(atlas, &pre),
    // rust: ly,
    // rust: HudBatch::text_width(atlas, &sel),
    // rust: line_height,
    // rust: ),
    // rust: true,
    // rust: );
}
    // rust: let pre: String = value.chars().take(edit.edit.cursor).collect();
    // rust: let caret_x = x + HudBatch::text_width(atlas, &pre);
    // rust: if edit.edit.cursor_visible() {
    // rust: batch.fill(atlas, caret_x, ly, 1.0, line_height, color);
}
    // rust: horizon_client::preedit::report_caret(caret_x, ly, line_height);
}
    // rust: let (bx, by) = done_button(w, h);
    // rust: horizon_client::widgets::declare_action(
    // rust: horizon_client::widgets::Action::Done,
    // rust: [bx, by, 200.0, 20.0],
    // rust: true,
    // rust: );
    // rust: horizon_client::widgets::narratable(|| {
    // rust: horizon_client::widgets::Narratable::button(done_label(), [bx, by, 200.0, 20.0], true)
    // rust: });
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "gui/sprites/widget/button",
    // rust: bx,
    // rust: by,
    // rust: 200.0,
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let done = done_label();
    // rust: let tw = HudBatch::text_width(atlas, &done);
    // rust: batch.text(
    // rust: atlas,
    // rust: &done,
    // rust: bx + 100.0 - (tw / 2.0).floor(),
    // rust: by + 6.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
}

    // rust: mod tests {
pub fn done_button_sits_on_whole_gui_pixels() void {
}
        // `width / 2 - 100, height / 4 + 144` in ints: 334 high is 83 + 144.
    // rust: assert_eq!(super::done_button(427.0, 334.0), (113.0, 227.0));
    // rust: assert_eq!(super::done_button(320.0, 240.0), (60.0, 204.0));
}

    /// The Done button said "Done" in every language (#1927).
pub fn done_button_reads_the_selected_language() void {
}
//         use horizon_client::lang::{Language, ResourceSource, scoped};
pub const Vanilla = struct {};
    // rust: impl ResourceSource for Vanilla {
pub fn read(self: *Self, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match path {
    // rust: "assets/minecraft/lang/en_us.json" => Some(br#"{"gui.done": "Done"}"#.to_vec()),
    // rust: "assets/minecraft/lang/de_de.json" => {
    // rust: Some(br#"{"gui.done": "Fertig"}"#.to_vec())
}
    // rust: _ => None,
}
}
}
    // rust: for (code, want) in [("de_de", "Fertig"), ("en_us", "Done")] {
    // rust: let (label, missed) = scoped(Language::load(&[&Vanilla], code), super::done_label);
    // rust: assert_eq!(label, want, "{code}");
    // rust: assert!(missed.is_empty(), "{code}: {missed:?}");
}
}
}
