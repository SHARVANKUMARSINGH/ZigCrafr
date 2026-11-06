//! Transpiled from Horizon Rust crate
package horizon_client_lan_chat

import "core:fmt"
import "core:mem"
import "core:math"

// A guest's commands that carry chat: the unsigned and signed command
// packets (ServerGamePacketListenerImpl.handleChatCommand and
// handleSignedChatCommand), and the message commands whose text they sign
// (SayCommand, EmoteCommands, MsgCommand), relayed by the hub as chat.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: command::{Arg, ParseResults, vanilla},
    // rust: lan::{
    // rust: data::component_nbt,
    // rust: hub::{HostEvent, chat::ChatMessage},
    // rust: },
    // rust: text::{self, Text},
}
// use horizon_protocol::packets::play::{self, Clientbound as C};

// The signing context of a command: each message argument as the chain
// let it through, by argument name (CommandSigningContext.SignedArguments).
    // rust: type Signed = Vec<(String, ChatMessage)>;

    // rust: impl Game<'_> {
    // CommandDispatcher.parse with the guest's permission level.
parse_as :: proc(self: ^Self, permission: u8, command: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let level = std::mem::replace(&mut self.ui.registries.permission, permission);
    // rust: let parse = vanilla::game_dispatcher_with_features(&self.level.enabled_features)
    // rust: .parse(command, &self.ui.registries);
    // rust: self.ui.registries.permission = level;
    // rust: parse
}

    // SignableCommand.of: the command's message arguments, by name, with
    // their text, not past a redirect to the root (`execute ... run`).
    // rust: pub(super) fn signable_arguments(
    // rust: &mut self,
    // rust: permission: u8,
    // rust: command: &str,
    // rust: ) -> Vec<(String, String)> {
    // rust: self.parse_as(permission, command).signable_arguments(
    // rust: vanilla::game_dispatcher_with_features(&self.level.enabled_features),
    // rust: )
}

    // ServerGamePacketListenerImpl.detectRateSpam: a chat message or command adds 20 to the
    // guest's throttler; over the threshold, a guest who is not an operator is kicked.
    // rust: pub(super) fn detect_rate_spam(&mut self, host: &mut LanHost, conn: u32, command: bool) {
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let threshold = if command {
    // rust: host.hub.command_spam_threshold
    // rust: } else {
    // rust: host.hub.chat_spam_threshold
}
    // rust: let uuid = host.hub.guests[i].uuid;
    // rust: let play = host.play.entry(conn).or_default();
    // rust: let count = if command {
    // rust: &mut play.command_spam
    // rust: } else {
    // rust: &mut play.chat_spam
}
    // rust: *count = count.saturating_add(20);
        // TickThrottler.isUnderThreshold: a threshold of 0 or less never kicks.
    // rust: let under = threshold <= 0 || i64::from(*count) < i64::from(threshold);
    // rust: if !under && !host.hub.ops.contains_key(&uuid) {
    // rust: host.hub.kick(
    // rust: conn,
    // rust: horizon_protocol::text::translatable("disconnect.spam", &[]),
    // rust: );
}
}

    // handleChatCommand (performUnsignedChatCommand): refused when the
    // server enforces secure chat and the command has a message to sign.
    // rust: pub(super) fn guest_chat_command(&mut self, host: &mut LanHost, conn: u32, command: &str) {
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: if !host.hub.try_handle_chat(i, command, true) {
    // rust: return;
}
    // rust: let permission = host.hub.guests[i].permission;
    // rust: if host.hub.enforces_secure_chat()
    // rust: && !self.signable_arguments(permission, command).is_empty()
    // rust: {
    // rust: let name = host.hub.guests[i].name.clone();
    // rust: self.lan_log_event(HostEvent::Error(format!(
    // rust: "Received unsigned command packet from {name}, but the command requires signable arguments: {command}"
    // rust: )));
    // rust: let failure = Text::translate("chat.disabled.invalid_command_signature", &[])
    // rust: .with_color(text::RED);
    // rust: host.hub.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: component_nbt(&failure.component()),
    // rust: overlay: false,
    // rust: }));
    // rust: self.detect_rate_spam(host, conn, true);
    // rust: return;
}
    // rust: if self.chat_filter_command(host, i, command) {
    // rust: self.guest_command(host, conn, command, None);
}
    // rust: self.detect_rate_spam(host, conn, true);
}

    // handleSignedChatCommand: the acknowledgements, then each message
    // argument through the sender's chain, then the command with them.
    // rust: pub(super) fn guest_signed_command(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::ChatCommandSigned,
    // rust: ) {
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let mut events = Vec::new();
    // rust: let mut signed = None;
    // rust: let mut ran = false;
    // rust: if let Some(last_seen) = host.hub.apply_last_seen(i, &p.last_seen, &mut events)
    // rust: && host.hub.try_handle_chat(i, &p.command, true)
    // rust: {
    // rust: ran = true;
    // rust: let permission = host.hub.guests[i].permission;
    // rust: let parsed = self.signable_arguments(permission, &p.command);
    // rust: match host
    // rust: .hub
    // rust: .signed_arguments(i, &p, &parsed, &last_seen, &mut events)
    // rust: {
    // rust: Ok(arguments) => signed = Some(arguments),
    // rust: Err(e) => host.hub.decode_failure(i, e, &mut events),
}
}
    // rust: for event in events {
    // rust: self.lan_log_event(event);
}
    // rust: if let Some(signed) = signed
    // rust: && self.chat_filter_command(host, i, &p.command)
    // rust: {
    // rust: self.guest_command(host, conn, &p.command, Some(signed));
}
        // The lambda counts the command even when its arguments failed to decode.
    // rust: if ran {
    // rust: self.detect_rate_spam(host, conn, true);
}
}

    // SayCommand, EmoteCommands and MsgCommand for a guest: chat to the
    // players, signed when the guest signed it (a disguised chat after an
    // unsigned command packet). False when the command is another one, or
    // one this can't run (selectors other than `@s` and `@a`), for the
    // game's dispatcher to handle.
    // rust: pub(super) fn guest_message_command(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: command: &str,
    // rust: signed: Option<&Signed>,
    // rust: ) -> bool {
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return false;
}
    // rust: let parse = self.parse_as(host.hub.guests[i].permission, command);
    // rust: let Ok((context, id)) = parse.executable() else {
    // rust: return false;
}
    // rust: let argument = if id == "me" { "action" } else { "message" };
    // rust: let (Some(Arg::Str(text)), true) =
    // rust: (context.get(argument), matches!(id, "say" | "me" | "msg"))
    // rust: else {
    // rust: return false;
}
    // rust: let message = signed.and_then(|s| {
    // rust: s.iter()
    // rust: .find(|(n, _)| n == argument)
    // rust: .map(|(_, m)| m.clone())
    // rust: });
    // rust: let mut events = Vec::new();
    // rust: if id == "msg" {
    // rust: let Some(Arg::Entity(selector)) = context.get("targets") else {
    // rust: return false;
}
    // rust: let raw = context
    // rust: .args
    // rust: .iter()
    // rust: .rev()
    // rust: .find(|a| a.name == "targets")
    // rust: .and_then(|a| command.get(a.range.0..a.range.1));
    // rust: let guests = &host.hub.guests;
    // rust: let placed = |k: &usize| guests[*k].placed;
    // rust: let targets: Vec<usize> = match (raw, &selector.player_name, selector.uuid) {
    // rust: (Some("@s"), ..) => vec![i],
    // rust: (Some("@a"), ..) => (0..guests.len()).filter(placed).collect(),
    // rust: (_, Some(name), _) => {
    // rust: let named: Vec<usize> = (0..guests.len())
    // rust: .filter(|&k| placed(&k) && guests[k].name.eq_ignore_ascii_case(name))
    // rust: .collect();
    // rust: if named.is_empty() {
                        // No player has that name: the one going by it as a nickname (`~` optional).
    // rust: let bare = |s: &str| s.strip_prefix('~').unwrap_or(s).to_ascii_lowercase();
    // rust: let wanted = bare(name);
    // rust: let nicknamed = |k: &usize| {
    // rust: host.hub
    // rust: .nicknames
    // rust: .get(&guests[*k].uuid)
    // rust: .is_some_and(|nick| bare(nick) == wanted)
}
    // rust: (0..guests.len())
    // rust: .filter(|k| placed(k) && nicknamed(k))
    // rust: .collect()
    // rust: } else {
    // rust: named
}
}
    // rust: (_, None, Some(uuid)) => (0..guests.len())
    // rust: .filter(|&k| placed(&k) && guests[k].uuid == uuid)
    // rust: .collect(),
    // rust: _ => return false,
}
    // rust: if targets.is_empty() {
    // rust: let failure = Text::empty()
    // rust: .append(Text::translate("argument.entity.notfound.player", &[]))
    // rust: .with_color(text::RED);
    // rust: host.hub.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: component_nbt(&failure.component()),
    // rust: overlay: false,
    // rust: }));
    // rust: return true;
}
    // rust: host.hub.whisper(i, &targets, message, text);
    // rust: } else {
    // rust: let chat_type = if id == "say" {
    // rust: "say_command"
    // rust: } else {
    // rust: "emote_command"
}
    // rust: host.hub
    // rust: .broadcast_command_chat(i, chat_type, message, text, &mut events);
}
    // rust: for event in events {
    // rust: self.lan_log_event(event);
}
    // rust: true
}
}
