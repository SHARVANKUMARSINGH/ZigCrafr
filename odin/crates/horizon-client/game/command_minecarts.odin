//! Transpiled from Horizon Rust crate
package horizon_client_command_minecarts

import "core:fmt"
import "core:mem"
import "core:math"

// `MinecartCommandBlock`: its `BaseCommandBlock` run by a powered activator
// rail (`performCommand`, `CloseableCommandBlockSource`), the entity data
// that carries its command and last output to clients, and the edit screen's
// `ServerboundSetCommandMinecartPacket` with `handleSetCommandMinecart`.
// use super::{
    // rust: Game,
    // rust: command_blocks::CommandBlockScreen,
    // rust: commands::{Target, execute::Source},
    // rust: lan::LanHost,
    // rust: minecarts::{CartKind, Minecart},
}
// use horizon_client::{command_block::Mode, text::Text};
// use horizon_protocol::packets::play::{self, Serverbound as S};

    // rust: impl Game<'_> {
command_cart_mut :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.carts
    // rust: .iter_mut()
    // rust: .find(|c| c.id == id && c.kind == CartKind::CommandBlock)
}
    // `MinecartCommandBase.onUpdated`: the cart's command and last output go
    // into its synched data (`DATA_ID_COMMAND_NAME`, `DATA_ID_LAST_OUTPUT`).
cart_command_updated :: proc(self: ^Self, id: u32) {
}
    // rust: if let Some(c) = self.command_cart_mut(id) {
    // rust: c.synced_command = c.command.command.clone();
    // rust: c.synced_output = c.command.last_output_string();
}
}
    // `BaseCommandBlock.performCommand` for the cart: false when it already
    // ran this game tick.
    // rust: pub(super) fn perform_cart_command(&mut self, id: u32) -> bool {
    // rust: let game_time = self.world.game_time;
    // rust: let rules_work = self.ui.rules.bool("command_blocks_work");
    // rust: let Some(c) = self.command_cart_mut(id) else {
    // rust: return false;
}
    // rust: if c.command.last_execution == game_time {
    // rust: return false;
}
    // rust: if c.command.command.eq_ignore_ascii_case("Searge") {
    // rust: c.command.last_output = Some(Text::literal("#itzlipofutzli"));
    // rust: c.command.success_count = 1;
    // rust: return true;
}
    // rust: c.command.success_count = 0;
    // rust: let command = c.command.command.clone();
    // rust: if rules_work && !command.is_empty() {
    // rust: c.command.last_output = None;
            // MinecartCommandBase.createCommandSourceStack: the cart's
            // position and rotation at game master level.
    // rust: let source = Source {
    // rust: entity: Some(Target::Cart(id)),
    // rust: pos: [c.position.x, c.position.y, c.position.z],
    // rust: rot: [c.yaw, 0.0],
    // rust: eyes: false,
    // rust: silent: false,
    // rust: store: None,
    // rust: dimension: self.dim,
    // rust: level: None,
    // rust: block: None,
    // rust: cart: Some(id),
}
    // rust: let successes = self.run_as_game_master(&command, source);
    // rust: if let Some(c) = self.command_cart_mut(id) {
    // rust: c.command.success_count = successes;
}
}
    // rust: if let Some(c) = self.command_cart_mut(id) {
    // rust: c.command.last_execution = if c.command.update_last_execution {
    // rust: game_time
    // rust: } else {
    // rust: -1
}
}
    // rust: true
}
    // `CloseableCommandBlockSource.sendSystemMessage` for the cart: its last
    // output stamped with the time, then `onUpdated`. Nothing when it does
    // not track output (`CommandSource.NULL`).
    // rust: pub(super) fn cart_command_output(&mut self, id: u32, message: Text) {
    // rust: let Some(c) = self.command_cart_mut(id) else {
    // rust: return;
}
    // rust: if c.command.track_output {
    // rust: let time = chrono::Local::now().format("[%H:%M:%S] ").to_string();
    // rust: c.command.last_output = Some(Text::literal(time).append(message));
    // rust: self.cart_command_updated(id);
}
}
    // `CommandSourceStack.sendSuccess` from a command minecart: its output
    // when `send_command_feedback`, and `broadcastToAdmins` when
    // `command_block_output`.
    // rust: pub(super) fn cart_command_success(&mut self, id: u32, message: Text, broadcast: bool) {
    // rust: let Some(name) = self
    // rust: .command_cart_mut(id)
    // rust: .filter(|c| c.command.track_output)
    // rust: .map(|c| c.command.name())
    // rust: else {
    // rust: return;
}
    // rust: let feedback = self.ui.rules.bool("send_command_feedback");
    // rust: if feedback {
    // rust: self.cart_command_output(id, message.clone());
}
    // rust: if broadcast && feedback && self.ui.rules.bool("command_block_output") {
    // rust: self.broadcast_source_to_admins(name, message);
}
}

    // `LocalPlayer.openMinecartCommandBlock`: the editor over the cart's
    // command (`MinecartCommandBlockEditScreen`).
    // rust: pub(super) fn open_cart_command_block(&mut self, id: u32) {
    // rust: let Some(block) = self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == id && c.kind == CartKind::CommandBlock)
    // rust: .map(|c| c.command.clone())
    // rust: else {
    // rust: return;
}
    // rust: self.open_edit_screen((0, 0, 0), Some(id), block, Mode::Redstone, false);
}
    // The edit screen's Done for a cart (`populateAndSendPacket`, then
    // `onDone` clears the last output of a cart that no longer tracks it): a
    // server's client sends the packet, the window's own world applies it.
    // rust: pub(super) fn set_command_minecart(&mut self, id: u32, s: &CommandBlockScreen) {
    // rust: if !self.can_use_game_master_blocks() {
    // rust: self.system_message(Text::translate("advMode.notAllowed", &[]));
    // rust: return;
}
    // rust: let command = s.command.value().to_owned();
    // rust: let track_output = s.track_output;
        // The output button set the cart's own flag as it was pressed.
    // rust: if let Some(c) = self.command_cart_mut(id) {
    // rust: c.command.track_output = track_output;
}
    // rust: if self.remote.is_some() {
    // rust: self.send(S::SetCommandMinecart(play::SetCommandMinecart {
    // rust: entity: id as i32,
    // rust: command,
    // rust: track_output,
    // rust: }));
    // rust: } else {
    // rust: self.apply_cart_command(id, command, track_output);
}
    // rust: if !track_output && let Some(c) = self.command_cart_mut(id) {
    // rust: c.command.last_output = None;
}
}
    // `ServerGamePacketListenerImpl.handleSetCommandMinecart` for a guest.
    // rust: pub(super) fn lan_set_command_minecart(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::SetCommandMinecart,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: self.as_guest_messaged(host, conn, |game| {
    // rust: if allowed {
    // rust: game.apply_cart_command(p.entity as u32, p.command, p.track_output);
    // rust: } else {
    // rust: game.system_message(Text::translate("advMode.notAllowed", &[]));
}
    // rust: });
}
    // What `handleSetCommandMinecart` does once the player may edit: the
    // command (which resets the success count), output tracking, the cleared
    // last output, `onUpdated` while command blocks work, and the chat note.
    // rust: pub(super) fn apply_cart_command(&mut self, id: u32, command: String, track_output: bool) {
    // rust: let enabled = self.ui.rules.bool("command_blocks_work");
    // rust: let Some(c) = self.command_cart_mut(id) else {
    // rust: return;
}
    // rust: c.command.set_command(&command);
    // rust: c.command.track_output = track_output;
    // rust: if !track_output {
    // rust: c.command.last_output = None;
}
    // rust: if enabled {
    // rust: self.cart_command_updated(id);
}
    // rust: if !command.is_empty() {
    // rust: let key = if enabled {
    // rust: "advMode.setCommand.success"
    // rust: } else {
    // rust: "advMode.setCommand.disabled"
}
    // rust: self.system_message(Text::translate(key, &[Text::literal(command)]));
}
}
}
