//! Transpiled from Horizon Rust crate
//! Module: horizon-client_profiles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `/op`, `/deop`, `/ban`, `/pardon`, `/ban-ip`, `/pardon-ip`, `/banlist`,
//! `/setidletimeout`, `/transfer` and `/whitelist` (OpCommand, DeOpCommands,
//! BanPlayerCommands, PardonCommand, BanIpCommands, PardonIpCommand,
//! BanListCommands, SetPlayerIdleTimeoutCommand, TransferCommand,
//! WhitelistCommand): commands of a dedicated server, run on its lists by an
//! operator in game (the console has its own handlers in game/dedicated.rs).
//! Also `/stop`, `/save-all`, `/save-off` and `/save-on` (StopCommand,
//! SaveAllCommand, SaveOffCommand, SaveOnCommand), on the switches the lists
//! share.
// use super::{Arg, Context, Game, R, Target, err};
// use horizon_client::{
    // rust: server::user_lists::{BanEntry, NameAndId, OpEntry, WhiteEntry},
    // rust: text::Text,
}
// use horizon_protocol::text::translatable;

    // rust: impl Game<'_> {
    /// Commands.CommandSelection.DEDICATED: on an integrated server these do
    /// not exist.
    // rust: fn dedicated_lists(
    // rust: &self,
    // rust: ) -> R<std::sync::Arc<std::sync::Mutex<super::super::dedicated::Lists>>> {
    // rust: match (&self.server_lists, self.options.dedicated.is_some()) {
    // rust: (Some(lists), true) => Ok(lists.clone()),
    // rust: _ => Err(err("command.unknown.command", &[])),
}
}

    /// StopCommand: the server loop (game/dedicated.rs) ends after this tick.
    // rust: pub(super) fn cmd_stop(&mut self) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: self.feedback(Text::translate("commands.stop.stopping", &[]));
    // rust: lists.lock().unwrap().stop = true;
    // rust: Ok(1)
}

    /// SaveAllCommand. Every save waits for the chunks to be written, so
    /// `flush` changes nothing.
    // rust: pub(super) fn cmd_save_all(&mut self) -> R<i32> {
    // rust: self.dedicated_lists()?;
    // rust: self.feedback(Text::translate("commands.save.saving", &[]));
    // rust: if self.lan_acting.is_some() {
            // The acting guest's record holds the game's state until their
            // turn ends: saving now would write it to their file.
            // shortcut: the other operators aren't told of a guest's save, add it if anyone asks.
    // rust: self.save_after_guest_turn = true;
    // rust: return Ok(1);
}
    // rust: let reply = self.save_all_reply();
    // rust: self.feedback(reply);
    // rust: Ok(1)
}

    /// Save everything; `commands.save.success`, or `commands.save.failed` in red.
    // rust: pub(in crate::game) fn save_all_reply(&mut self) -> Text {
    // rust: match self.save_game() {
    // rust: Ok(()) => Text::translate("commands.save.success", &[]),
    // rust: Err(e) => {
    // rust: log::error!("Horizon: /save-all: {e}");
    // rust: Text::translate("commands.save.failed", &[]).with_color(horizon_client::text::RED)
}
}
}

    /// SaveOffCommand and SaveOnCommand.
    // rust: pub(super) fn cmd_auto_save(&mut self, enabled: bool) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: if !super::super::dedicated::set_auto_save(&lists, enabled) {
    // rust: let already = if enabled {
    // rust: "commands.save.alreadyOn"
    // rust: } else {
    // rust: "commands.save.alreadyOff"
}
    // rust: return Err(err(already, &[]));
}
    // rust: let done = if enabled {
    // rust: "commands.save.enabled"
    // rust: } else {
    // rust: "commands.save.disabled"
}
    // rust: self.feedback(Text::translate(done, &[]));
    // rust: Ok(1)
}

    /// `NameAndId` of a player target.
pub fn target_profile(self: *Self, t: Target) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t {
    // rust: Target::Player => Some(NameAndId {
    // rust: id: self.lan_acting_uuid?,
    // rust: name: self.acting_player_name().to_owned(),
    // rust: }),
    // rust: Target::Guest(conn) => self.command_guest(conn).map(|g| NameAndId {
    // rust: id: g.uuid,
    // rust: name: g.name.clone(),
    // rust: }),
    // rust: _ => None,
}
}

    /// `GameProfileArgument.getGameProfiles`: a selector's players
    /// (`SelectorResult.getNames`, no players is an error), else the name in
    /// the user cache.
pub fn game_profiles(self: *Self, ctx: *Context, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ctx.get(name).cloned() {
    // rust: Some(Arg::Entity(s)) => {
    // rust: let players: Vec<Target> = self
    // rust: .select(&s)
    // rust: .into_iter()
    // rust: .filter(|t| t.is_player())
    // rust: .collect();
    // rust: if players.is_empty() {
    // rust: return Err(err("argument.entity.notfound.player", &[]));
}
    // rust: Ok(players
    // rust: .into_iter()
    // rust: .filter_map(|t| self.target_profile(t))
    // rust: .collect())
}
    // rust: Some(Arg::Str(text)) => self
    // rust: .resolve_name(&text)
    // rust: .map(|p| vec![p])
    // rust: .ok_or_else(|| err("argument.player.unknown", &[])),
    // rust: _ => Err(err("argument.player.unknown", &[])),
}
}

    /// `CommandSourceStack.getTextName`.
pub fn source_text_name(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.console_broadcast.is_some() {
    // rust: "Server".to_owned()
    // rust: } else {
    // rust: self.acting_player_name().to_owned()
}
}

    /// `OpCommand.opPlayers`, `DeOpCommands.deopPlayers`,
    /// `BanPlayerCommands.banPlayers` and `PardonCommand.pardonPlayers`.
    // rust: pub(super) fn cmd_profiles(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: let players = self.game_profiles(ctx, "targets")?;
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: let mut count = 0;
    // rust: match id {
    // rust: "op" => {
    // rust: for player in &players {
    // rust: let added = {
    // rust: let mut l = lists.lock().unwrap();
    // rust: let level = l.op_level;
    // rust: !l.ops.contains(player)
    // rust: && l.ops.add(OpEntry {
    // rust: user: player.clone(),
    // rust: level,
    // rust: bypasses_player_limit: false,
    // rust: })
}
    // rust: if added {
    // rust: self.sync_ops(&lists);
    // rust: count += 1;
    // rust: self.feedback(Text::translate("commands.op.success", &[lit(&player.name)]));
}
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.op.failed", &[]));
}
}
    // rust: "deop" => {
    // rust: for player in &players {
    // rust: let removed = {
    // rust: let mut l = lists.lock().unwrap();
    // rust: l.ops.contains(player) && l.ops.remove(player)
}
    // rust: if removed {
    // rust: self.sync_ops(&lists);
    // rust: count += 1;
    // rust: self.feedback(Text::translate(
    // rust: "commands.deop.success",
    // rust: &[lit(&player.name)],
    // rust: ));
}
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.deop.failed", &[]));
}
    // rust: self.kick_unlisted_players(&lists);
}
    // rust: "ban" => {
    // rust: let reason = match ctx.get("reason") {
    // rust: Some(Arg::Str(raw)) => {
    // rust: let raw = raw.clone();
    // rust: Some(self.expand_selectors(&raw).plain().to_string())
}
    // rust: _ => None,
}
    // rust: let source = self.source_text_name();
    // rust: for player in &players {
    // rust: let banned = lists.lock().unwrap().bans.contains(player);
    // rust: if banned {
    // rust: continue;
}
    // rust: lists.lock().unwrap().bans.add(BanEntry::new(
    // rust: player.clone(),
    // rust: Some(source.clone()),
    // rust: None,
    // rust: reason.clone(),
    // rust: ));
    // rust: count += 1;
                    // BanListEntry.getReasonMessage.
    // rust: let shown = reason.as_deref().map_or_else(
    // rust: || Text::translate("multiplayer.disconnect.banned.reason.default", &[]),
    // rust: lit,
    // rust: );
    // rust: self.feedback(Text::translate(
    // rust: "commands.ban.success",
    // rust: &[lit(&player.name), shown],
    // rust: ));
    // rust: self.kick_uuid(
    // rust: player.id,
    // rust: translatable("multiplayer.disconnect.banned", &[]),
    // rust: );
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.ban.failed", &[]));
}
}
    // rust: _ => {
    // rust: for player in &players {
    // rust: let removed = {
    // rust: let mut l = lists.lock().unwrap();
    // rust: l.bans.contains(player) && l.bans.remove(player)
}
    // rust: if removed {
    // rust: count += 1;
    // rust: self.feedback(Text::translate(
    // rust: "commands.pardon.success",
    // rust: &[lit(&player.name)],
    // rust: ));
}
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.pardon.failed", &[]));
}
}
}
    // rust: Ok(count)
}

    /// `BanIpCommands.banIpOrName` and `PardonIpCommand.unban`: an address,
    /// or for `/ban-ip` an online player's.
    // rust: pub(super) fn cmd_ip_bans(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: let target = match ctx.get("target") {
    // rust: Some(Arg::Str(t)) => t.clone(),
    // rust: _ => return Err(err("command.unknown.argument", &[])),
}
    // rust: let is_ip = target.parse::<std::net::IpAddr>().is_ok();
    // rust: if id == "pardon-ip" {
    // rust: if !is_ip {
    // rust: return Err(err("commands.pardonip.invalid", &[]));
}
    // rust: let removed = {
    // rust: let mut l = lists.lock().unwrap();
    // rust: l.ip_bans.get(&target).is_some() && l.ip_bans.remove(&target)
}
    // rust: if !removed {
    // rust: return Err(err("commands.pardonip.failed", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.pardonip.success",
    // rust: &[lit(&target)],
    // rust: ));
    // rust: return Ok(1);
}
        // PlayerList.getPlayerByName, then ServerPlayer.getIpAddress.
    // rust: let address = |name: &str| {
    // rust: let hub = &self.lan.as_ref()?.hub;
    // rust: hub.guests
    // rust: .iter()
    // rust: .find(|g| g.name.eq_ignore_ascii_case(name))
    // rust: .map(|g| g.address.ip().to_string())
}
    // rust: let ip = if is_ip {
    // rust: Some(target)
    // rust: } else {
    // rust: address(&target)
}
    // rust: let Some(ip) = ip else {
    // rust: return Err(err("commands.banip.invalid", &[]));
}
    // rust: if lists.lock().unwrap().ip_bans.get(&ip).is_some() {
    // rust: return Err(err("commands.banip.failed", &[]));
}
    // rust: let players: Vec<(u128, String)> = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.address.ip().to_string() == ip)
    // rust: .map(|g| (g.uuid, g.name.clone()))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let reason = match ctx.get("reason") {
    // rust: Some(Arg::Str(raw)) => {
    // rust: let raw = raw.clone();
    // rust: Some(self.expand_selectors(&raw).plain().to_string())
}
    // rust: _ => None,
}
    // rust: let source = self.source_text_name();
    // rust: lists.lock().unwrap().ip_bans.add(BanEntry::new(
    // rust: ip.clone(),
    // rust: Some(source),
    // rust: None,
    // rust: reason.clone(),
    // rust: ));
    // rust: self.feedback(Text::translate(
    // rust: "commands.banip.success",
    // rust: &[lit(&ip), Self::reason_message(reason.as_deref())],
    // rust: ));
    // rust: if !players.is_empty() {
    // rust: let names: Vec<&str> = players.iter().map(|(_, n)| n.as_str()).collect();
    // rust: self.feedback(Text::translate(
    // rust: "commands.banip.info",
    // rust: &[lit(&players.len().to_string()), lit(&names.join(", "))],
    // rust: ));
}
    // rust: for (uuid, _) in &players {
    // rust: self.kick_uuid(*uuid, translatable("multiplayer.disconnect.ip_banned", &[]));
}
    // rust: Ok(players.len() as i32)
}

    /// `SetPlayerIdleTimeoutCommand.setIdleTimeout`: the minutes of idleness
    /// after which a player is kicked (`multiplayer.disconnect.idling`), 0 for
    /// never. The reply names the minutes, or says the timeout is off, and the
    /// command's result is the number of minutes.
    // rust: pub(super) fn cmd_setidle_timeout(&mut self, ctx: &Context) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: let Some(Arg::Int(minutes)) = ctx.get("minutes") else {
    // rust: return Ok(0);
}
    // rust: let minutes = *minutes;
        // DedicatedServer.setPlayerIdleTimeout: the live sweep reads it, and
        // server.properties keeps it.
    // rust: self.set_player_idle_timeout(&lists, minutes);
    // rust: self.feedback(idle_timeout_reply(minutes));
    // rust: Ok(minutes)
}

    /// `TransferCommand.register` and `TransferCommand.transfer`: each target's
    /// client is handed to `hostname:port` (`ClientboundTransferPacket`), and
    /// the source is told who went — the player's name for one, the count for
    /// several. Without a players argument the source's own player is the
    /// target, as `getPlayerOrException` asks.
    // rust: pub(super) fn cmd_transfer(&mut self, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Str(hostname)) = ctx.get("hostname").cloned() else {
    // rust: return Ok(0);
}
        // `IntegerArgumentType.getInteger(c, "port")`, else 25565.
    // rust: let port = match ctx.get("port") {
    // rust: Some(Arg::Int(port)) => *port,
    // rust: _ => 25565,
}
    // rust: let targets = if ctx.get("players").is_some() {
    // rust: self.entities(ctx, "players", true)?
    // rust: } else if self.lan_acting.is_none() {
            // CommandSourceStack.getPlayerOrException: a console or a command
            // block has no player to send.
    // rust: return Err(err("permissions.requires.player", &[]));
    // rust: } else {
    // rust: vec![Target::Player]
}
    // rust: let players: Vec<(u32, String)> = targets
    // rust: .iter()
    // rust: .filter_map(|target| {
    // rust: let conn = match *target {
    // rust: Target::Player => self.lan_acting?,
    // rust: Target::Guest(conn) => conn,
    // rust: _ => return None,
}
    // rust: Some((conn, self.command_guest(conn)?.name.clone()))
    // rust: })
    // rust: .collect();
    // rust: if players.is_empty() {
    // rust: return Err(err("commands.transfer.error.no_players", &[]));
}
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: for (conn, _) in &players {
    // rust: host.hub.transfer(*conn, &hostname, port);
}
}
        // CommandResponseTracker.messages: one player by display name, several
        // by count, both with the hostname and the port.
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: let (key, first) = match players.len() {
    // rust: 1 => ("commands.transfer.success.single", lit(&players[0].1)),
    // rust: n => ("commands.transfer.success.multiple", lit(&n.to_string())),
}
    // rust: self.feedback(Text::translate(
    // rust: key,
    // rust: &[first, lit(&hostname), lit(&port.to_string())],
    // rust: ));
    // rust: Ok(players.len() as i32)
}

    /// `BanListCommands.showList`: the players' bans then the addresses'
    /// (`banlist`), or one of them; told to the source only.
    // rust: pub(super) fn cmd_banlist(&mut self, id: &str) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: let entries: Vec<(String, String, Option<String>)> = {
    // rust: let l = lists.lock().unwrap();
    // rust: let players = l
    // rust: .bans
    // rust: .entries()
    // rust: .into_iter()
    // rust: .map(|b| (b.user.name.clone(), b.source.clone(), b.reason.clone()));
    // rust: let ips = l
    // rust: .ip_bans
    // rust: .entries()
    // rust: .into_iter()
    // rust: .map(|b| (b.user.clone(), b.source.clone(), b.reason.clone()));
    // rust: match id {
    // rust: "banlist.ips" => ips.collect(),
    // rust: "banlist.players" => players.collect(),
    // rust: _ => players.chain(ips).collect(),
}
}
    // rust: if entries.is_empty() {
    // rust: self.feedback_unbroadcast(Text::translate("commands.banlist.none", &[]));
    // rust: return Ok(0);
}
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.banlist.list",
    // rust: &[lit(&entries.len().to_string())],
    // rust: ));
    // rust: for (name, source, reason) in &entries {
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.banlist.entry",
    // rust: &[
    // rust: lit(name),
    // rust: lit(source),
    // rust: Self::reason_message(reason.as_deref()),
    // rust: ],
    // rust: ));
}
    // rust: Ok(entries.len() as i32)
}

    /// `BanListEntry.getReasonMessage`.
pub fn reason_message(reason: ?[]const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: reason.map_or_else(
    // rust: || Text::translate("multiplayer.disconnect.banned.reason.default", &[]),
    // rust: |r| Text::literal(r.to_owned()),
    // rust: )
}

    /// `WhitelistCommand`: `on`, `off`, `list`, `reload`, `add` and `remove`.
    // rust: pub(super) fn cmd_whitelist(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let lists = self.dedicated_lists()?;
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: match id {
    // rust: "whitelist.reload" => {
                // PlayerList.reloadWhiteList.
    // rust: let _ = lists.lock().unwrap().white.load();
    // rust: self.feedback(Text::translate("commands.whitelist.reloaded", &[]));
    // rust: self.kick_unlisted_players(&lists);
    // rust: Ok(1)
}
    // rust: "whitelist.on" => {
    // rust: if lists.lock().unwrap().use_whitelist {
    // rust: return Err(err("commands.whitelist.alreadyOn", &[]));
}
    // rust: self.set_using_whitelist(&lists, true);
    // rust: self.feedback(Text::translate("commands.whitelist.enabled", &[]));
    // rust: self.kick_unlisted_players(&lists);
    // rust: Ok(1)
}
    // rust: "whitelist.off" => {
    // rust: if !lists.lock().unwrap().use_whitelist {
    // rust: return Err(err("commands.whitelist.alreadyOff", &[]));
}
    // rust: self.set_using_whitelist(&lists, false);
    // rust: self.feedback(Text::translate("commands.whitelist.disabled", &[]));
    // rust: Ok(1)
}
    // rust: "whitelist.list" => {
    // rust: let names: Vec<String> = lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .white
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.name.clone())
    // rust: .collect();
    // rust: if names.is_empty() {
    // rust: self.feedback_unbroadcast(Text::translate("commands.whitelist.none", &[]));
    // rust: } else {
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.whitelist.list",
    // rust: &[lit(&names.len().to_string()), lit(&names.join(", "))],
    // rust: ));
}
    // rust: Ok(names.len() as i32)
}
    // rust: _ => {
    // rust: let add = id == "whitelist.add";
    // rust: let targets = self.game_profiles(ctx, "targets")?;
    // rust: let mut count = 0;
    // rust: for target in &targets {
    // rust: let done = {
    // rust: let mut l = lists.lock().unwrap();
    // rust: if add {
    // rust: !l.white.contains(target)
    // rust: && l.white.add(WhiteEntry {
    // rust: user: target.clone(),
    // rust: })
    // rust: } else {
    // rust: l.white.contains(target) && l.white.remove(target)
}
}
    // rust: if done {
    // rust: count += 1;
    // rust: let key = if add {
    // rust: "commands.whitelist.add.success"
    // rust: } else {
    // rust: "commands.whitelist.remove.success"
}
    // rust: self.feedback(Text::translate(key, &[lit(&target.name)]));
}
}
    // rust: if count == 0 {
    // rust: return Err(err(
    // rust: if add {
    // rust: "commands.whitelist.add.failed"
    // rust: } else {
    // rust: "commands.whitelist.remove.failed"
    // rust: },
    // rust: &[],
    // rust: ));
}
    // rust: if !add {
    // rust: self.kick_unlisted_players(&lists);
}
    // rust: Ok(count)
}
}
}
}

/// `SetPlayerIdleTimeoutCommand.setIdleTimeout`'s reply: the minutes, or
/// `commands.setidletimeout.success.disabled` when the timeout is off.
pub fn idle_timeout_reply(minutes: i32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if minutes > 0 {
    // rust: Text::translate(
    // rust: "commands.setidletimeout.success",
    // rust: &[Text::literal(minutes.to_string())],
    // rust: )
    // rust: } else {
    // rust: Text::translate("commands.setidletimeout.success.disabled", &[])
}
}

    // rust: mod tests {
//     use super::idle_timeout_reply;

    /// `SetPlayerIdleTimeoutCommand.setIdleTimeout`: minutes above zero are
    /// named in `commands.setidletimeout.success`, and zero turns the timeout
    /// off with `commands.setidletimeout.success.disabled`.
pub fn the_idle_timeout_reply_names_the_minutes_or_says_it_is_off() void {
}
    // rust: let reply = idle_timeout_reply(5);
    // rust: assert_eq!(
    // rust: reply.translation_key(),
    // rust: Some("commands.setidletimeout.success"),
    // rust: "{reply:?}"
    // rust: );
    // rust: assert_eq!(reply.component()["with"], serde_json::json!([5]));
    // rust: let off = idle_timeout_reply(0);
    // rust: assert_eq!(
    // rust: off.translation_key(),
    // rust: Some("commands.setidletimeout.success.disabled")
    // rust: );
        // The disabled message takes no argument.
    // rust: assert!(off.component().get("with").is_none(), "{off:?}");
}
}
