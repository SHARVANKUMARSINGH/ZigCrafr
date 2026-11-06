//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_server
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Server commands and players for native mods (docs/native-mods.md,
//! "Server commands and players", API 8): the commands mods add to the
//! server's command tree (`native_register_commands`), a player's command
//! reaching them (`native_perform_command`), and the helpers a server mod
//! answers with: the players online, a line to one of them or to all, the
//! command's feedback and the world's folder; and (API 9) the acting
//! player's plain items: count, take, give. They act on the server's own
//! players (the hub's: a dedicated server's, a LAN host's, single player's
//! server thread's), never on a client's.
// use super::{Dim, Game, commands::execute, lan::LanHost};
// Their old home, for mixin code that names them here.
    // rust: pub(crate) use horizon_client::mod_api::{NativeCommand, NativeServerPlayer};
// use horizon_client::{items::ItemStack, lan::data::component_nbt, text::Text};
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use serde_json::{Map, Value, json};
// use std::{collections::HashMap, path::PathBuf};

/// A sidebar a server mod shows one player (`native_sidebar`): its title and
/// up to 15 lines, top first, each a text on the left and, where the score's
/// number would be, an optional text on the right. API 49.
    // rust: pub(crate) struct NativeSidebar {
    // rust: pub(crate) title: Text,
    // rust: pub(crate) lines: Vec<(Text, Option<Text>)>,
}

/// The objective a mod's sidebar is sent as: the player's client only; the
/// server's scoreboard never holds it.
pub const SIDEBAR_OBJECTIVE: []const u8 = "horizon:native_sidebar";

/// The brigadier parser of an argument kind, and its properties.
pub fn parser(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match kind {
    // rust: "word" => ("brigadier:string", json!({"type": "word"})),
    // rust: "text" => ("brigadier:string", json!({"type": "greedy"})),
    // rust: "integer" => ("brigadier:integer", Value::Null),
    // rust: "number" => ("brigadier:double", Value::Null),
    // rust: "boolean" => ("brigadier:bool", Value::Null),
    // rust: "player" => (
    // rust: "minecraft:entity",
    // rust: json!({"amount": "single", "type": "players"}),
    // rust: ),
    // rust: "item" => ("minecraft:item_stack", Value::Null),
    // rust: "block_pos" => ("minecraft:block_pos", Value::Null),
    // rust: _ => return None,
    // rust: })
}

/// The report's name of an operator level (`commands.json`'s
/// `permissions`).
pub const LEVELS: [[]const u8; 5] = ["", "moderators", "gamemasters", "admins", "owners"];

/// One parsed word of a usage: its key in the tree and its node, without
/// children.
pub fn usage_nodes(usage: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut optional_seen = false;
    // rust: let mut greedy_seen = false;
    // rust: for word in usage.split_whitespace() {
    // rust: if greedy_seen {
    // rust: return Err(format!("`{usage}`: a text argument must be last"));
}
    // rust: let (inner, optional) = if let Some(w) = word.strip_prefix('<') {
    // rust: (w.strip_suffix('>'), false)
    // rust: } else if let Some(w) = word.strip_prefix('[') {
    // rust: (w.strip_suffix(']'), true)
    // rust: } else {
    // rust: if optional_seen {
    // rust: return Err(format!("`{usage}`: `{word}` follows an optional argument"));
}
    // rust: let literal = !word.is_empty()
    // rust: && word
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || "_-".contains(c));
    // rust: if !literal {
    // rust: return Err(format!("`{usage}`: `{word}` is not a command word"));
}
    // rust: out.push((word.to_owned(), json!({"type": "literal"}), false));
    // rust: continue;
}
    // rust: let Some((name, kind)) = inner.and_then(|w| w.split_once(':')) else {
    // rust: return Err(format!("`{usage}`: `{word}` is not `<name:kind>`"));
}
    // rust: if optional_seen && !optional {
    // rust: return Err(format!("`{usage}`: `{word}` follows an optional argument"));
}
    // rust: let Some((parser, properties)) = parser(kind) else {
    // rust: return Err(format!("`{usage}`: unknown kind `{kind}`"));
}
    // rust: optional_seen |= optional;
    // rust: greedy_seen |= kind == "text";
    // rust: let mut node = json!({"type": "argument", "parser": parser});
    // rust: if !properties.is_null() {
    // rust: node["properties"] = properties;
}
    // rust: out.push((name.to_owned(), node, optional));
}
    // rust: if out.first().is_none_or(|n| n.1["type"] != "literal") {
    // rust: return Err(format!("`{usage}`: a command starts with its name"));
}
    // rust: Ok(out)
}

/// Native mods' commands as a root in the commands report's format
/// (`lan::commands`, which sends each player what their level allows), and
/// each command's level: the lowest of its usages. A node is runnable where
/// only optional arguments follow it. A command vanilla has (`vanilla`
/// answers) or a usage that doesn't parse is left out, with why.
    // rust: pub(super) fn command_tree(
    // rust: commands: &[NativeCommand],
    // rust: vanilla: impl Fn(&str) -> bool,
    // rust: ) -> (Value, HashMap<String, u8>, Vec<String>) {
    // rust: let mut root = Map::new();
    // rust: let mut levels: HashMap<String, u8> = HashMap::new();
    // rust: let mut problems = Vec::new();
    // rust: for command in commands {
    // rust: let nodes = match usage_nodes(&command.usage) {
    // rust: Ok(n) => n,
    // rust: Err(e) => {
    // rust: problems.push(e);
    // rust: continue;
}
}
    // rust: if vanilla(&nodes[0].0) {
    // rust: problems.push(format!("`{}`: vanilla has /{}", command.usage, nodes[0].0));
    // rust: continue;
}
    // rust: let mut children = &mut root;
    // rust: for (i, (name, node, _)) in nodes.iter().enumerate() {
    // rust: let runnable = nodes.get(i + 1).is_none_or(|n| n.2);
    // rust: let entry = children.entry(name.clone()).or_insert_with(|| {
    // rust: let mut n = node.clone();
    // rust: n["executable"] = false.into();
    // rust: n["level"] = 4.into();
    // rust: n
    // rust: });
    // rust: if entry["type"] != node["type"] || entry["parser"] != node["parser"] {
    // rust: problems.push(format!(
    // rust: "`{}`: `{name}` is another kind in an earlier usage",
    // rust: command.usage
    // rust: ));
    // rust: break;
}
    // rust: if runnable {
    // rust: entry["executable"] = true.into();
}
    // rust: let level = entry["level"]
    // rust: .as_u64()
    // rust: .unwrap_or(4)
    // rust: .min(command.level.into());
    // rust: entry["level"] = level.into();
    // rust: if !entry["children"].is_object() {
    // rust: entry["children"] = Value::Object(Map::new());
}
    // rust: children = entry["children"].as_object_mut().expect("made above");
}
    // rust: let level = levels.entry(nodes[0].0.clone()).or_insert(4);
    // rust: *level = (*level).min(command.level);
}
    // rust: let mut root = Value::Object(root);
    // rust: finish(&mut root);
    // rust: let tree = if levels.is_empty() {
    // rust: Value::Null
    // rust: } else {
    // rust: json!({"type": "root", "children": root})
}
    // rust: (tree, levels, problems)
}

/// Turns the working `level` into the report's `permissions`, and drops
/// empty child lists.
pub fn finish(children: *mut Value) void {
}
    // rust: let Some(map) = children.as_object_mut() else {
    // rust: return;
}
    // rust: for node in map.values_mut() {
    // rust: let level = node["level"].as_u64().unwrap_or(0) as usize;
    // rust: let object = node.as_object_mut().expect("a node");
    // rust: object.remove("level");
    // rust: if level > 0 {
    // rust: object.insert(
    // rust: "permissions".into(),
    // rust: json!({"type": "require", "permission": {"level": LEVELS[level.min(4)]}}),
    // rust: );
}
    // rust: if object
    // rust: .get("children")
    // rust: .is_some_and(|c| c.as_object().is_some_and(Map::is_empty))
    // rust: {
    // rust: object.remove("children");
    // rust: } else if let Some(c) = object.get_mut("children") {
    // rust: finish(c);
}
}
}

/// Helpers for server mods, kept as stable as the hook points.
// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// The players on this server, in the order they joined. Empty on a
    /// client and in a world nobody else can join.
    // rust: pub(super) fn native_server_players(&self) -> Vec<NativeServerPlayer> {
    // rust: let Some(host) = &self.lan else {
    // rust: return Vec::new();
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| NativeServerPlayer {
    // rust: uuid: g.uuid,
    // rust: name: g.name.clone(),
    // rust: permission: g.permission,
    // rust: dimension: g.dimension.clone(),
    // rust: position: g.position,
    // rust: game_mode: g.game_mode,
    // rust: health: g.health,
    // rust: yaw: g.yaw,
    // rust: pitch: g.pitch,
    // rust: entity_id: g.entity_id,
    // rust: address: g.address.ip().to_string(),
    // rust: })
    // rust: .collect()
}
    /// A system line in that player's chat, also inside a player's hook for
    /// the acting player; false when they aren't on.
    // rust: pub(super) fn native_tell(&mut self, uuid: u128, line: Text) -> bool {
    // rust: self.native_send(uuid, system_chat(&line))
}
    /// A line over that player's hotbar (the action bar), also inside a
    /// player's hook for the acting player; false when they aren't on. API 21.
    // rust: pub(super) fn native_action_bar(&mut self, uuid: u128, line: Text) -> bool {
    // rust: let packet = C::SystemChat(play::SystemChat {
    // rust: content: component_nbt(&line.component()),
    // rust: overlay: true,
    // rust: });
    // rust: self.native_send(uuid, packet)
}
    /// Sends `packet` to that player, also when they are the acting player
    /// (their packets then go after the hook); false when they aren't on.
    // rust: pub(super) fn native_send(&mut self, uuid: u128, packet: C) -> bool {
    // rust: self.native_send_all(uuid, vec![packet])
}
pub fn native_send_all(self: *Self, uuid: u128, packets: std.ArrayList(C)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.lan_acting_uuid == Some(uuid) {
    // rust: self.guest_packets.extend(packets);
    // rust: return true;
}
    // rust: let Some(host) = &self.lan else {
    // rust: return false;
}
    // rust: let Some(g) = host.hub.guests.iter().find(|g| g.placed && g.uuid == uuid) else {
    // rust: return false;
}
    // rust: for packet in &packets {
    // rust: host.hub.send_to(g.conn, packet);
}
    // rust: true
}
    /// Shows `sidebar` on that player's screen, in place of the one shown
    /// before, or takes it away (None). Only their client holds it: the
    /// server's scoreboard, its `/scoreboard` and the other players don't
    /// see it, and it is gone when they leave (a mod sends it again when
    /// they come back). It takes the sidebar's place from an objective the
    /// world shows there, for this player, until they rejoin. False when
    /// they aren't on. API 49.
    // rust: pub(super) fn native_sidebar(&mut self, uuid: u128, sidebar: Option<&NativeSidebar>) -> bool {
    // rust: let objective = SIDEBAR_OBJECTIVE.to_owned();
        // Removed first, so the new one's lines replace all the old ones.
    // rust: let mut packets = vec![C::SetObjective(play::SetObjective {
    // rust: name: objective.clone(),
    // rust: method: 1,
    // rust: display: None,
    // rust: })];
    // rust: if let Some(sidebar) = sidebar {
    // rust: let title = component_nbt(&sidebar.title.component());
    // rust: packets.push(C::SetObjective(play::SetObjective {
    // rust: name: objective.clone(),
    // rust: method: 0,
    // rust: display: Some((title, 0, Some(play::NumberFormat::Blank))),
    // rust: }));
            // DisplaySlot.SIDEBAR.
    // rust: packets.push(C::SetDisplayObjective(play::SetDisplayObjective {
    // rust: slot: 1,
    // rust: objective: objective.clone(),
    // rust: }));
    // rust: let lines = &sidebar.lines[..sidebar.lines.len().min(15)];
    // rust: for (i, (left, right)) in lines.iter().enumerate() {
    // rust: packets.push(C::SetScore(play::SetScore {
                    // Highest first. The display name shows, not the owner;
                    // an owner starting with '#' is hidden from the sidebar
                    // (ScoreHolder's isHidden), and ':' is in no player's name.
    // rust: owner: format!("horizon:line{i:02}"),
    // rust: objective: objective.clone(),
    // rust: score: (lines.len() - i) as i32,
    // rust: display: Some(component_nbt(&left.component())),
    // rust: number_format: Some(match right {
    // rust: Some(t) => play::NumberFormat::Fixed(component_nbt(&t.component())),
    // rust: None => play::NumberFormat::Blank,
    // rust: }),
    // rust: }));
}
}
    // rust: self.native_send_all(uuid, packets)
}
    /// The lines over and under that player's list of players (Tab):
    /// `ClientboundTabListPacket`, an empty text for none. False when they
    /// aren't on. API 49.
    // rust: pub(super) fn native_tab_list(&mut self, uuid: u128, header: &Text, footer: &Text) -> bool {
    // rust: let packet = C::TabList(play::TabList {
    // rust: header: component_nbt(&header.component()),
    // rust: footer: component_nbt(&footer.component()),
    // rust: });
    // rust: self.native_send(uuid, packet)
}
    /// The server's tick rate (20 unless `/tick rate` changed it) and the
    /// milliseconds its ticks took on average lately, as `/tick query`
    /// reports them. The ticks a second it keeps up is the rate, or
    /// 1000 / milliseconds when that is lower. API 49.
    // rust: pub(super) fn native_tick_stats(&self) -> (f32, f64) {
    // rust: (
    // rust: self.clock.rate(),
    // rust: self.clock.average_nanos() as f64 / 1_000_000.0,
    // rust: )
}
    /// Whether that player counts for `players_sleeping_percentage`: an
    /// ignored player who isn't in bed is left out of the players the night
    /// needs asleep, as a spectator is (an away-from-keyboard mod). Kept
    /// until a mod sets it back or the server stops, also if they leave and
    /// come back. Only where no player's state is swapped in, as
    /// `native_run_command`; false there and when they aren't on. API 49.
    // rust: pub(super) fn native_sleep_ignored(&mut self, uuid: u128, ignored: bool) -> bool {
    // rust: let Some(host) = &mut self.lan else {
    // rust: return false;
}
    // rust: if !host.hub.guests.iter().any(|g| g.placed && g.uuid == uuid) {
    // rust: return false;
}
    // rust: if ignored {
    // rust: host.sleep_ignored.insert(uuid);
    // rust: } else {
    // rust: host.sleep_ignored.remove(&uuid);
}
    // rust: true
}
    /// Hides that player (a vanish) from the players below permission
    /// `level`, or shows them again (None): from the next tick those players
    /// lose them from the Tab list and the world (their client stops
    /// tracking the player, as it does a spectator), and don't read their
    /// joining or leaving; players of `level` or more still see them, and
    /// a player made an operator meanwhile sees them again. By UUID: kept
    /// for a player who is off (who joins hidden), until a mod sets it again
    /// or the server stops. Works anywhere on a server, inside a player's
    /// hook too; false on a client and in a world nobody else can join.
    /// API 314.
    // rust: pub(super) fn native_hide_player(&mut self, uuid: u128, level: Option<u8>) -> bool {
    // rust: let Some(host) = &mut self.lan else {
    // rust: return false;
}
    // rust: match level {
    // rust: Some(level) => host.hub.hidden.insert(uuid, level),
    // rust: None => host.hub.hidden.remove(&uuid),
}
    // rust: true
}
    /// Shows `nickname` in place of that player's name in chat (their
    /// messages, `/me`, `/msg`) and in the Tab list; None shows their name
    /// again. Hovering the shown name gives the real one, which stays in the
    /// log, commands, selectors and the server's events. Kept until a mod
    /// sets it again or the server stops (also if they leave and come back).
    /// Plain text: the mod checks it (`native_text_allowed`, its length,
    /// other players' names). Only where no player's state is swapped in,
    /// as `native_run_command`; false there and when they aren't on. API
    /// 62.
    // rust: pub(super) fn native_set_nickname(&mut self, uuid: u128, nickname: Option<&str>) -> bool {
    // rust: let Some(host) = &mut self.lan else {
    // rust: return false;
}
    // rust: if !host.hub.guests.iter().any(|g| g.placed && g.uuid == uuid) {
    // rust: return false;
}
    // rust: host.hub.set_nickname(uuid, nickname.map(str::to_owned));
    // rust: true
}
    /// Whether the server's chat filter (`server.toml` `[chat_filter]`)
    /// lets `text` through: true without a filter, None inside a player's
    /// hook (where the server is out of reach). API 62.
    // rust: pub(super) fn native_text_allowed(&self, text: &str) -> Option<bool> {
    // rust: let host = self.lan.as_ref()?;
    // rust: Some(
    // rust: host.hub
    // rust: .chat_filter
    // rust: .as_ref()
    // rust: .is_none_or(|g| !g.filter.matches(text)),
    // rust: )
}
    /// A system line in every player's chat and the server's log.
    // rust: pub(super) fn native_broadcast(&self, mut line: Text) {
    // rust: let mut cancel = false;
    // rust: self.native_broadcast_message(&mut line, &mut cancel);
    // rust: if cancel {
    // rust: return;
}
    // rust: let plain = line.plain();
    // rust: if self.options.dedicated.is_some() {
    // rust: super::dedicated::log("INFO", &plain);
    // rust: } else {
    // rust: log::info!("{plain}");
}
    // rust: let Some(host) = &self.lan else {
    // rust: return;
}
    // rust: let packet = system_chat(&line);
    // rust: for g in host.hub.guests.iter().filter(|g| g.placed) {
    // rust: host.hub.send_to(g.conn, &packet);
}
}
    /// Posts a line to the dedicated server's event stream (`GET /api/v1/events`)
    /// as an `announce` event, which horizon-server's Discord bridge relays when
    /// `[discord] events` lists `announce`: `name` and `uuid` say who it is
    /// about (empty and 0 for no one), `message` is the line (`§` codes colour it).
    /// Only on a dedicated server; false elsewhere and for an empty message.
    /// API 163.
    // rust: pub(super) fn native_server_event(&self, name: &str, uuid: u128, message: &str) -> bool {
    // rust: if self.options.dedicated.is_none() || message.trim().is_empty() {
    // rust: return false;
}
    // rust: super::dedicated::events::record("announce", name, uuid, json!({ "message": message }));
    // rust: true
}
    /// A line of the command's answer, inside `native_perform_command`:
    /// sent to the player whose command it is after the call, as vanilla
    /// commands' feedback is.
    // rust: pub(super) fn native_feedback(&mut self, line: Text) {
    // rust: match &mut self.chat_capture {
    // rust: Some(lines) => lines.push(line),
    // rust: None => self.system_message(line),
}
}
    /// The player whose action or command a hook hears, as their state is
    /// swapped in (`native_perform_command`, `native_right_click_block`,
    /// `native_use_item_on`, `native_destroy_block`...): None outside such a
    /// hook. API 21.
    // rust: pub(super) fn native_acting_player(&self) -> Option<NativeServerPlayer> {
    // rust: let p = self.player.as_ref()?;
    // rust: Some(NativeServerPlayer {
    // rust: uuid: self.lan_acting_uuid?,
    // rust: name: self.lan_acting_name.clone()?,
    // rust: permission: self.lan_acting_permission?,
    // rust: dimension: self.dim.id().to_owned(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: game_mode: self.mode_id(),
    // rust: health: p.health.health(),
    // rust: yaw: p.yaw,
    // rust: pitch: p.pitch,
    // rust: entity_id: self.native_acting_entity() as i32,
    // rust: address: self
    // rust: .lan
    // rust: .as_ref()
    // rust: .and_then(|host| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| Some(g.uuid) == self.lan_acting_uuid)
    // rust: })
    // rust: .map(|g| g.address.ip().to_string())
    // rust: .unwrap_or_default(),
    // rust: })
}
    /// Runs `line` (no slash) as the server's console does: permission
    /// level 4, from the overworld's spawn, with no output. A teleport to
    /// another level (`execute in minecraft:the_nether run tp Alex 0 70 0`)
    /// happens at the next tick's start, as the console's. Whether it ran
    /// without failing. Only where no player's state is swapped in
    /// (`native_tick`, `native_menu_clicked`): false inside a player's hook,
    /// where the other players are out of reach. API 21.
    // rust: pub(super) fn native_run_command(&mut self, line: &str) -> bool {
    // rust: if self.lan_acting.is_some() || self.lan.is_none() {
    // rust: return false;
}
    // rust: let server = execute::Source {
    // rust: dimension: Dim::Overworld,
    // rust: ..self.server_source()
}
    // rust: let outer = self.command_source.replace(server);
    // rust: let ok = self.as_console(|g| g.run_command(line));
    // rust: self.command_source = outer;
    // rust: ok
}
    /// The open world's folder (`world/`, beside its `level.dat`): a server
    /// mod keeps its data in a folder of its own there, so the world's
    /// backups carry it. None when no world is open.
    // rust: pub(super) fn native_world_dir(&self) -> Option<PathBuf> {
    // rust: (!self.world_root.as_os_str().is_empty()).then(|| self.world_root.clone())
}
}

/// Plain stacks: no components beyond the count (no damage, name,
/// enchantment...), the only ones the item helpers count, take or give, so
/// a mod never prices a worn or enchanted item as a new one.
pub fn plain(stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.damage == 0 && stack.extra.is_none()
}

/// The slots the item helpers look at, in `Inventory.add`'s order: the
/// selected slot, the off hand, then the hotbar and the main inventory.
pub fn order(selected: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::iter::once(selected)
    // rust: .chain(std::iter::once(OFFHAND))
    // rust: .chain((0..36).filter(move |&i| i != selected))
}
pub const OFFHAND: usize = 36;

/// The 36 inventory slots and the off hand as one list ([`OFFHAND`] last).
    // rust: fn slots<'a>(
    // rust: inventory: &'a mut [Option<ItemStack>],
    // rust: offhand: &'a mut Option<ItemStack>,
    // rust: ) -> Vec<&'a mut Option<ItemStack>> {
    // rust: inventory
    // rust: .iter_mut()
    // rust: .take(36)
    // rust: .chain(std::iter::once(offhand))
    // rust: .collect()
}

/// How many of plain `item` the slots hold.
pub fn count_in(slots: *[*mut ?ItemStack], item: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: slots
    // rust: .iter()
    // rust: .filter_map(|s| s.as_ref())
    // rust: .filter(|s| &*s.item == item && plain(s))
    // rust: .map(|s| s.count)
    // rust: .sum()
}

/// Takes up to `count` plain `item`, selected slot first; what it took.
    // rust: fn take_from(
    // rust: mut slots: Vec<&mut Option<ItemStack>>,
    // rust: selected: usize,
    // rust: item: &str,
    // rust: count: u32,
    // rust: ) -> u32 {
    // rust: let mut taken = 0;
    // rust: for i in order(selected) {
    // rust: let slot = &mut *slots[i];
    // rust: if let Some(s) = slot
    // rust: && &*s.item == item
    // rust: && plain(s)
    // rust: {
    // rust: let n = s.count.min(count - taken);
    // rust: s.count -= n;
    // rust: taken += n;
    // rust: if s.count == 0 {
    // rust: *slot = None;
}
}
    // rust: if taken == count {
    // rust: break;
}
}
    // rust: taken
}

/// How many plain `item` (stacking to `max`) still fit.
pub fn room_in(slots: *[*mut ?ItemStack], item: []const u8, max: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: slots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, s)| match s.as_ref() {
            // getFreeSlot: never into an empty off hand.
    // rust: None if i == OFFHAND => 0,
    // rust: None => max,
    // rust: Some(s) if &*s.item == item && plain(s) => max.saturating_sub(s.count),
    // rust: Some(_) => 0,
    // rust: })
    // rust: .sum()
}

/// Adds up to `count` plain `item`, onto its stacks first
/// (`getSlotWithRemainingSpace`: the off hand's too), then into empty slots
/// of the inventory (`getFreeSlot`), in [`order`]; what it added. Nothing
/// is dropped.
    // rust: fn add_to(
    // rust: mut slots: Vec<&mut Option<ItemStack>>,
    // rust: selected: usize,
    // rust: item: &str,
    // rust: max: u32,
    // rust: count: u32,
    // rust: ) -> u32 {
    // rust: let mut added = 0;
    // rust: for pass in 0..2 {
    // rust: for i in order(selected) {
    // rust: let slot = &mut *slots[i];
    // rust: let n = match slot {
    // rust: Some(s) if pass == 0 && &*s.item == item && plain(s) => {
    // rust: let n = max.saturating_sub(s.count).min(count - added);
    // rust: s.count += n;
    // rust: n
}
    // rust: None if pass == 1 && i != OFFHAND => {
    // rust: let n = max.min(count - added);
    // rust: *slot = Some(ItemStack {
    // rust: item: item.into(),
    // rust: count: n,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: n
}
    // rust: _ => 0,
}
    // rust: added += n;
    // rust: if added == count {
    // rust: return added;
}
}
}
    // rust: added
}

/// The acting player's items, for server mods (API 9): the player whose
/// action or command a hook hears (`native_perform_command`), as their
/// state is swapped in. Only plain stacks count; the inventory's 36 slots
/// and the off hand, never the armour. Each change reaches the player's
/// screen as any change to their inventory does.
    // rust: impl Game<'_> {
    /// The main hand's stack: its item, count, and whether it is plain. On a
    /// client, the player's own.
    // rust: pub(super) fn native_held(&self) -> Option<(String, u32, bool)> {
    // rust: let s = self.inventory.get(self.selected)?.as_ref()?;
    // rust: Some((s.item.to_string(), s.count, plain(s)))
}
    /// How many of plain `item` (`minecraft:diamond`) the player carries.
    // rust: pub(super) fn native_count_items(&mut self, item: &str) -> u32 {
    // rust: count_in(&slots(&mut self.inventory, &mut self.offhand), item)
}
    /// Every plain item the player carries, with how many, by id.
    // rust: pub(super) fn native_carried_items(&self) -> Vec<(String, u32)> {
    // rust: let mut out: Vec<(String, u32)> = Vec::new();
    // rust: let held = self
    // rust: .inventory
    // rust: .iter()
    // rust: .take(36)
    // rust: .chain(std::iter::once(&self.offhand));
    // rust: for s in held.flatten().filter(|s| plain(s)) {
    // rust: match out.iter_mut().find(|(i, _)| *i == *s.item) {
    // rust: Some((_, n)) => *n += s.count,
    // rust: None => out.push((s.item.to_string(), s.count)),
}
}
    // rust: out
}
    /// Takes up to `count` plain `item`, the main hand first; what it took.
    // rust: pub(super) fn native_take_items(&mut self, item: &str, count: u32) -> u32 {
    // rust: if self.player.is_none() {
    // rust: return 0;
}
    // rust: let selected = self.selected;
    // rust: take_from(
    // rust: slots(&mut self.inventory, &mut self.offhand),
    // rust: selected,
    // rust: item,
    // rust: count,
    // rust: )
}
    /// How many plain `item` still fit; 0 for an unknown item.
    // rust: pub(super) fn native_room_for(&mut self, item: &str) -> u32 {
    // rust: let Some(max) = self.res.items().get(item).map(|i| i.max_stack) else {
    // rust: return 0;
}
    // rust: room_in(
    // rust: &slots(&mut self.inventory, &mut self.offhand),
    // rust: item,
    // rust: max.max(1),
    // rust: )
}
    /// Gives up to `count` plain `item` where they fit, as `Inventory.add`
    /// places them; what it gave (nothing is dropped). 0 for an unknown item.
    // rust: pub(super) fn native_give_items(&mut self, item: &str, count: u32) -> u32 {
    // rust: let Some(max) = self.res.items().get(item).map(|i| i.max_stack) else {
    // rust: return 0;
}
    // rust: if self.player.is_none() {
    // rust: return 0;
}
    // rust: let selected = self.selected;
    // rust: add_to(
    // rust: slots(&mut self.inventory, &mut self.offhand),
    // rust: selected,
    // rust: item,
    // rust: max.max(1),
    // rust: count,
    // rust: )
}
    /// Gives `stack` whole (its damage, name, enchantments... kept) to the
    /// player `uuid`, as `Inventory.add` places it: onto equal stacks first,
    /// then into empty inventory slots, never the armour or an empty off
    /// hand. What did not fit comes back (nothing is dropped): all of it for
    /// a player who isn't here, is dead, or whose state is swapped out by
    /// another player's (inside that player's hook, only they are reached).
    /// The player's screen follows as for any change to their inventory.
    /// What an auto-pickup or a machine's output to a player needs, from any
    /// server hook. API 98.
    // rust: pub(super) fn native_give_stack(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: mut stack: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: if uuid == self.native_acting_id() {
            // Their state is in place: the host's, or a guest's swapped in.
    // rust: if self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_none_or(|p| p.health.health() <= 0.0)
    // rust: {
    // rust: return Some(stack);
}
    // rust: return self.give(stack);
}
        // Inside a player's hook their state is in place and the records of
        // the others may hold swapped state (turns nest): only they are
        // reached, as the doc says.
    // rust: if self.lan_acting.is_some() {
    // rust: return Some(stack);
}
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(64, |i| i.max_stack);
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return Some(stack);
}
    // rust: let Some(g) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter_mut()
    // rust: .find(|g| g.placed && !g.dead && g.uuid == uuid)
    // rust: else {
    // rust: return Some(stack);
}
        // inventory_add indexes the 36 main slots.
    // rust: if g.inventory.len() < 36 {
    // rust: g.inventory.resize(36, None);
}
    // rust: let left = super::inventory_add(
    // rust: &mut g.inventory,
    // rust: &mut g.offhand,
    // rust: g.selected,
    // rust: max,
    // rust: &mut stack,
    // rust: );
    // rust: left.then_some(stack)
}
}

/// An experience orb as a server mod reads it (`native_experience_orbs`).
/// Read by mods only.
pub const NativeExperienceOrb = struct {
    /// The entity's ID, as `native_entity_join_level` names it.
    id: u32,
    position: [f64,
    /// `ExperienceOrb.value`: the points one pickup gives.
    value: u32,
    /// `ExperienceOrb.count`: orbs merged into this one, each worth `value`.
    count: u32,
};

/// Whether an orb at `position` (its box: 0.5 wide and high, standing on
/// it) meets the box `min`..`max`, touching faces excluded (`AABB.intersects`).
pub fn orb_meets(position: [f64; 3], min: [f64; 3], max: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: position[0] - 0.25 < max[0]
    // rust: && position[0] + 0.25 > min[0]
    // rust: && position[1] < max[1]
    // rust: && position[1] + 0.5 > min[1]
    // rust: && position[2] - 0.25 < max[2]
    // rust: && position[2] + 0.25 > min[2]
}

/// Experience for server mods. API 101.
    // rust: impl Game<'_> {
    /// The experience orbs of the server level `dimension` whose box meets
    /// the box `min`..`max`, in the level's order: what a mod reads before it
    /// cancels an orb in `native_entity_join_level`, to give its points with
    /// `native_give_experience`. Empty for a level not in place and on a
    /// client of a server.
    // rust: pub(super) fn native_experience_orbs(
    // rust: &self,
    // rust: dimension: &str,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: ) -> Vec<NativeExperienceOrb> {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: {
    // rust: return Vec::new();
}
    // rust: self.orbs
    // rust: .iter()
    // rust: .filter(|o| o.count > 0)
    // rust: .map(|o| NativeExperienceOrb {
    // rust: id: o.id,
    // rust: position: [o.position.x, o.position.y, o.position.z],
    // rust: value: o.value,
    // rust: count: o.count,
    // rust: })
    // rust: .filter(|o| orb_meets(o.position, min, max))
    // rust: .collect()
}
    /// Writes the experience orb `id`'s `value` (the points a pickup gives), `count`
    /// (orbs merged into it, each worth `value`) and `age` (ticks lived; an orb
    /// despawns at 6000); a `None` is left as it is. API 128.
    /// False, and nothing written, for an orb not in the server level `dimension`, a
    /// `value` or `count` of 0, and on a client of a server.
    // rust: pub(super) fn native_set_experience_orb(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: id: u32,
    // rust: value: Option<u32>,
    // rust: count: Option<u32>,
    // rust: age: Option<u32>,
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: || value == Some(0)
    // rust: || count == Some(0)
    // rust: {
    // rust: return false;
}
    // rust: let Some(orb) = self.orbs.iter_mut().find(|o| o.id == id) else {
    // rust: return false;
}
    // rust: orb.value = value.unwrap_or(orb.value);
    // rust: orb.count = count.unwrap_or(orb.count);
    // rust: orb.age = age.unwrap_or(orb.age);
    // rust: true
}
    /// Gives `points` of experience to the player `uuid` as an orb they touch
    /// does (`ExperienceOrb.playerTouch`): Mending repairs their damaged items
    /// with it first (`repairPlayerItems`), then the rest goes to their
    /// experience (`Player.giveExperiencePoints`), with the level-up sound
    /// every fifth level. No orb pickup sound. False, and nothing given, for
    /// a player who isn't here or is dead, and for another player than the one
    /// whose state is swapped in (inside that player's hook, only they are
    /// reached), and while the server's player list is busy elsewhere in the
    /// tick: give first, and cancel an orb only when this returned true.
    /// Their bar follows as for any change to their experience.
    // rust: pub(super) fn native_give_experience(&mut self, uuid: u128, points: u32) -> bool {
    // rust: self.native_as_player(uuid, |game| {
    // rust: let rest = if points > 0 { game.mending(points) } else { 0 };
    // rust: if rest > 0 {
    // rust: game.give_orb_points(rest);
}
    // rust: })
}
    /// Adds `levels` to the player `uuid`'s level, or takes them off when
    /// negative (`Player.giveExperienceLevels`): what the anvil and the
    /// enchanting table charge with, and a mod can charge or reward with.
    /// Below level 0 the level and the points are 0. The progress toward the
    /// next level is kept. False, and nothing changed, as for
    /// `native_give_experience`.
    // rust: pub(super) fn native_give_levels(&mut self, uuid: u128, levels: i32) -> bool {
    // rust: self.native_as_player(uuid, |game| game.give_levels(levels))
}
    /// Runs `f` with the player `uuid`'s state in place: theirs already when
    /// they are the acting player (the host, or a guest swapped in), else a
    /// guest's through `as_guest`, only where no other player is swapped in.
    /// False when it didn't run: no such player here, or dead.
pub fn native_as_player(self: *Self, uuid: u128, f: impl FnOnce(*mut Self) void {
}
    // rust: if uuid == self.native_acting_id() {
    // rust: if self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_none_or(|p| p.health.health() <= 0.0)
    // rust: {
    // rust: return false;
}
    // rust: f(self);
    // rust: return true;
}
    // rust: if self.lan_acting.is_some() {
    // rust: return false;
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return false;
}
    // rust: let conn = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.placed && !g.dead && g.uuid == uuid)
    // rust: .map(|g| g.conn);
    // rust: let ran = conn
    // rust: .and_then(|conn| self.as_guest(&mut host, conn, f))
    // rust: .is_some();
    // rust: self.lan = Some(host);
    // rust: ran
}
}

pub fn system_chat(line: *Text) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: C::SystemChat(play::SystemChat {
    // rust: content: component_nbt(&line.component()),
    // rust: overlay: false,
    // rust: })
}

/// Where the game calls the server hook points.
    // rust: impl Game<'_> {
    /// Asks the mods for their commands once per hub, and puts them in every
    /// player's command tree.
    // rust: pub(super) fn register_native_commands(&mut self, host: &mut LanHost) {
    // rust: if host.native_commands.is_some() {
    // rust: return;
}
    // rust: let mut commands = Vec::new();
    // rust: self.native_register_commands(&mut commands);
        // Horizon's own moderation commands go in the same tree, so operators' clients complete them
        // instead of showing them as unknown; the game still runs them itself (`run_guest_command`).
    // rust: let extras = super::tempban::moderation_commands(
    // rust: host.hub.chat_filter_on(),
    // rust: self.server_lists.is_some(),
    // rust: );
    // rust: commands.extend(extras.iter().cloned());
    // rust: let (tree, mut levels, problems) =
    // rust: command_tree(&commands, |name| host.hub.vanilla_command(name));
    // rust: for p in problems {
    // rust: log::warn!("Horizon: a native mod's command was left out: {p}");
}
    // rust: levels.retain(|name, _| {
    // rust: !extras
    // rust: .iter()
    // rust: .any(|c| c.usage.split(' ').next() == Some(name.as_str()))
    // rust: });
    // rust: host.hub.set_mod_commands(0, tree);
    // rust: host.native_commands = Some(levels);
}

    /// Asks the mods what root commands each player's tree keeps
    /// (`native_player_commands_sent`) and stores the answer in the hub,
    /// which sends the trees without what the mods took out: for `only`, or
    /// for every placed player.
    // rust: pub(super) fn native_filter_commands(&mut self, host: &mut LanHost, only: Option<u32>) {
    // rust: let players: Vec<(u32, u128, String)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| only.map_or(g.placed, |conn| g.conn == conn))
    // rust: .map(|g| (g.conn, g.uuid, g.name.clone()))
    // rust: .collect();
    // rust: for (conn, uuid, name) in players {
    // rust: let names = host.hub.command_names(conn);
    // rust: let mut kept = names.clone();
    // rust: let placed = host.hub.guest(conn).is_some_and(|g| g.placed);
    // rust: if !placed {
                // A joining player has no world yet: nothing can be told them.
    // rust: self.native_player_commands_sent(uuid, &name, &mut kept);
    // rust: } else if self.lan_acting == Some(conn) {
    // rust: self.native_player_commands_sent(uuid, &name, &mut kept);
    // rust: } else {
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.native_player_commands_sent(uuid, &name, &mut kept);
    // rust: });
}
    // rust: if let Some(g) = host.hub.guest_mut(conn) {
    // rust: g.hidden_commands = names.into_iter().filter(|n| !kept.contains(n)).collect();
}
}
}

    /// `Hub::resend_commands` with the mods' say on each tree.
    // rust: pub(super) fn resend_commands_filtered(&mut self) {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: host.hub.refresh_permissions();
    // rust: self.native_filter_commands(&mut host, None);
    // rust: host.hub.resend_commands();
    // rust: self.lan = Some(host);
}

    /// The level a guest needs for a mod's command (`line`, without its
    /// slash), when a mod registered it.
    // rust: pub(super) fn native_command_level(host: &LanHost, line: &str) -> Option<u8> {
    // rust: let name = line.split(' ').next().unwrap_or_default();
    // rust: host.native_commands.as_ref()?.get(name).copied()
}

    /// A guest's command for the mods, inside their swap
    /// (`run_guest_command`): true when one ran it.
    // rust: pub(super) fn perform_native_command(&mut self, conn: u32, permission: u8, line: &str) -> bool {
    // rust: let Some(host) = &self.lan else {
    // rust: return false;
}
    // rust: if Self::native_command_level(host, line).is_none_or(|level| level > permission) {
    // rust: return false;
}
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return false;
}
    // rust: let player = NativeServerPlayer {
    // rust: uuid: g.uuid,
    // rust: name: g.name.clone(),
    // rust: permission,
    // rust: dimension: g.dimension.clone(),
    // rust: position: g.position,
    // rust: game_mode: g.game_mode,
    // rust: health: g.health,
    // rust: yaw: g.yaw,
    // rust: pitch: g.pitch,
    // rust: entity_id: g.entity_id,
    // rust: address: g.address.ip().to_string(),
}
    // rust: let mut ran = false;
    // rust: self.native_perform_command(&player, line, &mut ran);
    // rust: if !ran {
            // Registered, but no mod took it: vanilla's unknown command.
    // rust: self.native_feedback(
    // rust: Text::translate("command.unknown.command", &[])
    // rust: .with_color(horizon_client::text::RED),
    // rust: );
}
    // rust: true
}
}

    // rust: impl Game<'_> {
    /// A console line for the mods: true when a mod registered its command
    /// (`native_register_commands`). The console is level 4, so a registered
    /// usage is always allowed; a command no mod takes answers as vanilla's
    /// unknown command.
    // rust: pub(super) fn perform_native_console_command(&mut self, line: &str) -> bool {
    // rust: let Some(host) = &self.lan else {
    // rust: return false;
}
    // rust: if Self::native_command_level(host, line).is_none() {
    // rust: return false;
}
    // rust: let mut ran = false;
    // rust: self.native_perform_console_command(line, &mut ran);
    // rust: if !ran {
    // rust: self.native_feedback(
    // rust: Text::translate("command.unknown.command", &[])
    // rust: .with_color(horizon_client::text::RED),
    // rust: );
}
    // rust: true
}
}

    // rust: mod tests {
//     use super::*;

pub fn tree(commands: *[NativeCommand]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: command_tree(commands, |name| name == "give")
}

pub fn stack(item: []const u8, count: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(ItemStack {
    // rust: item: item.into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })
}

pub fn items_are_taken_from_the_hand_first_and_only_plain() void {
}
    // rust: let mut inv = vec![None; 36];
    // rust: inv[0] = stack("minecraft:diamond", 10);
    // rust: inv[4] = stack("minecraft:diamond", 5);
    // rust: inv[8] = stack("minecraft:diamond", 7);
    // rust: inv[8].as_mut().unwrap().damage = 3;
    // rust: let mut off = stack("minecraft:diamond", 2);
    // rust: assert_eq!(
    // rust: count_in(&slots(&mut inv, &mut off), "minecraft:diamond"),
    // rust: 17
    // rust: );
    // rust: assert_eq!(
    // rust: take_from(slots(&mut inv, &mut off), 4, "minecraft:diamond", 6),
    // rust: 6
    // rust: );
    // rust: assert!(inv[4].is_none(), "the selected slot first");
    // rust: assert_eq!(off.as_ref().unwrap().count, 1, "then the off hand");
    // rust: assert_eq!(
    // rust: take_from(slots(&mut inv, &mut off), 4, "minecraft:diamond", 100),
    // rust: 11
    // rust: );
    // rust: assert_eq!(inv[8].as_ref().unwrap().count, 7, "a damaged stack stays");
    // rust: assert!(inv[0].is_none() && off.is_none());
}

pub fn items_are_given_only_where_they_fit() void {
}
    // rust: let mut inv = vec![stack("minecraft:dirt", 64); 36];
    // rust: inv[3] = stack("minecraft:diamond", 60);
    // rust: inv[9] = None;
    // rust: let mut off = None;
    // rust: assert_eq!(
    // rust: room_in(&slots(&mut inv, &mut off), "minecraft:diamond", 64),
    // rust: 4 + 64
    // rust: );
    // rust: assert_eq!(
    // rust: add_to(slots(&mut inv, &mut off), 0, "minecraft:diamond", 64, 200),
    // rust: 68
    // rust: );
    // rust: assert_eq!(inv[3].as_ref().unwrap().count, 64, "onto its stack first");
    // rust: assert!(off.is_none(), "never into an empty off hand (getFreeSlot)");
    // rust: assert_eq!(inv[9].as_ref().unwrap().count, 64);
    // rust: assert_eq!(
    // rust: room_in(&slots(&mut inv, &mut off), "minecraft:diamond", 64),
    // rust: 0
    // rust: );
    // rust: assert_eq!(
    // rust: add_to(slots(&mut inv, &mut off), 0, "minecraft:diamond", 64, 1),
    // rust: 0
    // rust: );
}

pub fn orbs_are_found_by_their_half_block_box() void {
}
        // A block's cell, as a mod asks for a broken block's drops.
    // rust: let (min, max) = ([10.0, 64.0, -3.0], [11.0, 65.0, -2.0]);
    // rust: assert!(orb_meets([10.5, 64.2, -2.5], min, max), "inside");
    // rust: assert!(
    // rust: orb_meets([11.2, 64.0, -2.5], min, max),
    // rust: "its box reaches in"
    // rust: );
    // rust: assert!(
    // rust: orb_meets([10.5, 63.6, -2.5], min, max),
    // rust: "standing just below"
    // rust: );
    // rust: assert!(!orb_meets([11.25, 64.0, -2.5], min, max), "a face touching");
    // rust: assert!(!orb_meets([10.5, 63.5, -2.5], min, max), "its top touching");
    // rust: assert!(!orb_meets([10.5, 65.0, -2.5], min, max), "standing on top");
}

pub fn whole_stacks_are_given_onto_equal_stacks_only() void {
}
//         use super::super::inventory_add;
    // rust: let mut inv = vec![stack("minecraft:dirt", 64); 36];
    // rust: inv[2] = stack("minecraft:iron_sword", 1);
    // rust: inv[2].as_mut().unwrap().damage = 5;
    // rust: inv[5] = stack("minecraft:arrow", 60);
    // rust: inv[7] = None;
    // rust: inv[20] = None;
    // rust: let mut off = stack("minecraft:arrow", 62);

        // A damaged sword never joins another stack: the first free slot.
    // rust: let mut sword = stack("minecraft:iron_sword", 1).unwrap();
    // rust: sword.damage = 40;
    // rust: assert!(!inventory_add(&mut inv, &mut off, 5, 1, &mut sword));
    // rust: assert_eq!(inv[7].as_ref().unwrap().damage, 40, "its damage is kept");
    // rust: assert_eq!(inv[2].as_ref().unwrap().damage, 5);

        // Arrows: the selected slot, then the off hand, then a free slot,
        // and what is left over comes back.
    // rust: let mut arrows = stack("minecraft:arrow", 80).unwrap();
    // rust: assert!(inventory_add(&mut inv, &mut off, 5, 64, &mut arrows));
    // rust: assert_eq!(inv[5].as_ref().unwrap().count, 64);
    // rust: assert_eq!(off.as_ref().unwrap().count, 64);
    // rust: assert_eq!(inv[20].as_ref().unwrap().count, 64);
    // rust: assert_eq!(arrows.count, 80 - 4 - 2 - 64);

        // A full inventory with an empty off hand takes nothing.
    // rust: let mut off = None;
    // rust: let mut apple = stack("minecraft:apple", 3).unwrap();
    // rust: assert!(inventory_add(&mut inv, &mut off, 0, 64, &mut apple));
    // rust: assert!(off.is_none(), "never into an empty off hand (getFreeSlot)");
    // rust: assert_eq!(apple.count, 3);
}

pub fn usages_merge_into_one_tree_with_runnable_nodes() void {
}
    // rust: let (t, levels, problems) = tree(&[
    // rust: NativeCommand::new("balance [player:player]"),
    // rust: NativeCommand::new("pay <player:player> <amount:integer>"),
    // rust: NativeCommand::op("eco give <player:player> <amount:integer>", 3),
    // rust: NativeCommand::op("eco take <player:player> <amount:integer>", 3),
    // rust: ]);
    // rust: assert!(problems.is_empty(), "{problems:?}");
    // rust: let c = &t["children"];
    // rust: assert_eq!(c["balance"]["executable"], true);
    // rust: assert_eq!(c["balance"]["children"]["player"]["executable"], true);
    // rust: assert_eq!(
    // rust: c["balance"]["children"]["player"]["parser"],
    // rust: "minecraft:entity"
    // rust: );
    // rust: assert_eq!(c["pay"]["executable"], false);
    // rust: assert_eq!(c["pay"]["children"]["player"]["executable"], false);
    // rust: let amount = &c["pay"]["children"]["player"]["children"]["amount"];
    // rust: assert_eq!(amount["executable"], true);
    // rust: assert_eq!(amount["parser"], "brigadier:integer");
    // rust: assert!(amount.get("children").is_none());
    // rust: assert_eq!(c["eco"]["permissions"]["permission"]["level"], "admins");
    // rust: assert!(c["eco"]["children"]["give"].is_object());
    // rust: assert!(c["eco"]["children"]["take"].is_object());
    // rust: assert!(c["pay"].get("permissions").is_none());
    // rust: assert_eq!(levels["eco"], 3);
    // rust: assert_eq!(levels["pay"], 0);
}

pub fn a_command_takes_its_lowest_level() void {
}
    // rust: let (t, levels, _) = tree(&[
    // rust: NativeCommand::new("warp [name:word]"),
    // rust: NativeCommand::op("warp set <name:word>", 2),
    // rust: ]);
    // rust: assert_eq!(levels["warp"], 0);
    // rust: assert!(t["children"]["warp"].get("permissions").is_none());
    // rust: let set = &t["children"]["warp"]["children"]["set"];
    // rust: assert_eq!(set["permissions"]["permission"]["level"], "gamemasters");
}

pub fn bad_usages_and_vanilla_names_are_left_out() void {
}
    // rust: let (t, levels, problems) = tree(&[
    // rust: NativeCommand::new("give <x:integer>"),
    // rust: NativeCommand::new("a [x:integer] <y:integer>"),
    // rust: NativeCommand::new("b <x:text> <y:word>"),
    // rust: NativeCommand::new("c <x:colour>"),
    // rust: NativeCommand::new("<x:integer>"),
    // rust: NativeCommand::new("Bad"),
    // rust: NativeCommand::new("d <x:integer>"),
    // rust: NativeCommand::new("d <x:word>"),
    // rust: ]);
    // rust: assert_eq!(problems.len(), 7, "{problems:?}");
    // rust: assert_eq!(levels.keys().collect::<Vec<_>>(), ["d"]);
    // rust: assert_eq!(
    // rust: t["children"]["d"]["children"]["x"]["parser"],
    // rust: "brigadier:integer"
    // rust: );
    // rust: let (none, levels, _) = tree(&[]);
    // rust: assert!(none.is_null() && levels.is_empty());
}
}
