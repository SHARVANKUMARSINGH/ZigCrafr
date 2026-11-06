//! Transpiled from Horizon Rust crate
//! Module: horizon-client_commands
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Command execution (the `execute` side of each vanilla command class):
//! entity selectors resolved against the game, vanilla feedback and errors.
    // rust: mod admin;
    // rust: pub(super) mod compute;
    // rust: mod data;
    // rust: pub(super) use data::place_summoned;
    // rust: mod effects;
    // rust: pub(super) mod execute;
    // rust: pub(super) mod extra;
    // rust: pub(in crate::game) mod items;
    // rust: mod misc;
    // rust: mod place;
    // rust: mod players;
    // rust: pub(super) mod pregen;
    // rust: mod profiles;
    // rust: mod raid;
    // rust: mod selector_bounds;
    // rust: mod terrain_cmds;
    // rust: mod test_locate;
    // rust: mod test_runs;
    // rust: mod text_commands;
    // rust: mod world_cmds;

// use super::{Dim, Game, Screen, chat::PLAYER_NAME};
// use horizon_client::{
    // rust: command::{
    // rust: Arg, CommandError, Context, Reader,
    // rust: args::{BlockInput, Coordinates, GameMode, ItemInput, Selector, Sort},
    // rust: vanilla::{self, DIFFICULTIES},
    // rust: },
    // rust: gamerules::{self, Value},
    // rust: items::ItemStack,
    // rust: text::{self, Style, Text},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use horizon_world::registry::BlockStateId;

    // rust: pub(super) type R<T> = Result<T, CommandError>;

/// An entity a selector found.
    // rust: pub(super) enum Target {
    /// The player in place: the host's, or the guest whose turn it is.
    // rust: Player,
    /// Another player of a hosted world or server: a guest by connection
    /// (game/commands/players.rs).
    // rust: Guest(u32),
    // rust: Mob(u32),
    // rust: Item(u32),
    /// An experience orb, by its entity id.
    // rust: Orb(u32),
    /// A projectile, by its entity id.
    // rust: Projectile(u32),
    // rust: Stand(u32),
    // rust: Frame(u32),
    // rust: Painting(u32),
    // rust: Boat(u32),
    // rust: Cart(u32),
    /// An entity of a type Horizon does not simulate (markers, displays,
    /// interactions...): kept as its saved data at a position.
    // rust: Other(u32),
    /// Active evoker fangs, including command-loaded ones.
    // rust: Fangs(u32),
    /// An End crystal, by its entity id (`minecraft:end_crystal`).
    // rust: Crystal(u32),
    /// The Ender Dragon, by its entity id (`minecraft:ender_dragon`).
    // rust: Dragon(u32),
    /// A primed TNT, by its entity id (`minecraft:tnt`).
    // rust: Tnt(u32),
    /// A falling block, by its entity id (`minecraft:falling_block`).
    // rust: Falling(u32),
    /// A firework rocket, by its entity id (`minecraft:firework_rocket`).
    // rust: Rocket(u32),
    /// A thrown trident, by its entity id (`minecraft:trident`).
    // rust: Trident(u32),
    /// An ominous item spawner, by its entity id (`minecraft:ominous_item_spawner`).
    // rust: Spawner(u32),
    /// A simulated lingering, creeper or dragon area-effect cloud.
    // rust: Cloud(u32),
}
/// `Entity.setXRot`: reduce the angle before clamping the pitch.
pub fn entity_pitch(pitch: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (pitch % 360.0).clamp(-90.0, 90.0)
}

/// An entity of a type Horizon does not simulate: its compound lives in the
/// entity memory (`persist.raw`), its position and rotation here.
    // rust: pub(in crate::game) struct OtherEntity {
    // rust: pub id: u32,
    // rust: pub kind: String,
    // rust: pub position: Vec3,
    // rust: pub yaw: f32,
    // rust: pub pitch: f32,
}
    // rust: pub(super) fn err(key: &str, args: &[&dyn std::fmt::Display]) -> CommandError {
    // rust: CommandError::tr(key, args)
}
/// `EntityType.getDescriptionId`: `entity.<namespace>.<path>`.
pub fn entity_name_key(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: format!("entity.{namespace}.{}", path.replace('/', "."))
}
pub fn texts(args: *[Text]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: args.to_vec()
}
/// Java's String.valueOf(float/double) for the values commands print.
pub fn java_float(v: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v == v.trunc() && v.abs() < 1.0e7 {
    // rust: format!("{v:.1}")
    // rust: } else {
    // rust: format!("{v}")
}
}
/// String.format(Locale.ROOT, "%.<decimals>f"): Java rounds the shortest
/// decimal text half-up, which `{:.N}` (exact value, half-even) does not.
    // rust: pub(super) fn percent_f(v: f64, decimals: usize) -> String {
    // rust: horizon_client::java_text::format_fixed(v, decimals)
}
/// String.format(Locale.ROOT, "%f").
pub fn format_double(v: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: percent_f(v, 6)
}
/// `EntitySelectorParser.createRotationPredicate`: the wrapped angle lies in
/// the wrapped range, which runs through 180 when its minimum is above its
/// maximum (defaults 0 and 359).
pub fn rotation_in() void {
}
    // rust: let min = wrap_degrees(lo.unwrap_or(0.0) as f32);
    // rust: let max = wrap_degrees(hi.unwrap_or(359.0) as f32);
    // rust: let angle = wrap_degrees(angle);
    // rust: if min > max {
    // rust: angle >= min || angle <= max
    // rust: } else {
    // rust: angle >= min && angle <= max
}
}
/// `Mth.wrapDegrees`.
pub fn wrap_degrees(angle: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let wrapped = angle % 360.0;
    // rust: if wrapped >= 180.0 {
    // rust: wrapped - 360.0
    // rust: } else if wrapped < -180.0 {
    // rust: wrapped + 360.0
    // rust: } else {
    // rust: wrapped
}
}

/// The network id of a target that is no player: its entity id.
pub fn non_player_entity_id(t: Target) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (Target::Mob(id)
    // rust: | Target::Item(id)
    // rust: | Target::Orb(id)
    // rust: | Target::Projectile(id)
    // rust: | Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Painting(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id)
    // rust: | Target::Crystal(id)
    // rust: | Target::Dragon(id)
    // rust: | Target::Tnt(id)
    // rust: | Target::Falling(id)
    // rust: | Target::Rocket(id)
    // rust: | Target::Trident(id)
    // rust: | Target::Spawner(id)
    // rust: | Target::Cloud(id)) = t
    // rust: else {
    // rust: return None;
}
    // rust: i32::try_from(id).ok()
}
    // rust: impl Game<'_> {
    /// `native_player_level_change` for a level that was `from` before an experience change.
    // rust: pub(super) fn native_player_level_changed(&mut self, from: i32) {
    // rust: let to = self.experience.level;
    // rust: if from != to
    // rust: && !horizon_client::mod_api::mods().is_empty()
    // rust: && let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_level_change(player, &name, from, to);
}
}

    /// `PlayerXpEvent.XpChange` for a `Player.giveExperiencePoints` of `amount`
    /// points: the amount to give, or `None` when a mod cancelled it.
    // rust: pub(super) fn xp_change(&mut self, amount: i32) -> Option<i32> {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return Some(amount);
}
    // rust: let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: else {
    // rust: return Some(amount);
}
    // rust: let (mut amount, mut cancel) = (amount, false);
    // rust: self.native_player_xp_change(player, &name, &mut amount, &mut cancel);
    // rust: (!cancel).then_some(amount)
}

    /// Commands.performCommand for a line without its slash.
    // rust: pub(super) fn run_command(&mut self, command: &str) -> bool {
    // rust: if self.client_mod_command(command) {
    // rust: return true;
}
    // rust: let d = vanilla::game_dispatcher_with_features(&self.level.enabled_features);
    // rust: let parse = d.parse(command, &self.ui.registries);
    // rust: let result = match parse.executable() {
    // rust: Err(e) => {
    // rust: self.syntax_failure(&e, command);
    // rust: return false;
}
    // rust: Ok((ctx, _)) => {
    // rust: let ctx = ctx.clone();
    // rust: let root = parse.context.clone();
    // rust: self.exec = Default::default();
    // rust: self.run_chain(&root, &ctx)
}
}
    // rust: let ok = result.is_ok();
    // rust: if let Err(e) = result {
    // rust: if e.input.is_some() {
    // rust: self.syntax_failure(&e, command);
    // rust: } else {
    // rust: self.command_failure(e.message);
}
}
        // InventoryChangeTrigger fires as slots change, not on the next tick.
    // rust: if self.player.is_some() {
    // rust: self.check_inventory_trigger();
}
    // rust: ok
}
    /// `run_command` with its output suppressed
    /// (`CommandSourceStack.withSuppressedOutput`): the player's own source,
    /// rights and checks, no feedback and no failure in the chat.
    // rust: pub(super) fn run_command_quietly(&mut self, command: &str) -> bool {
    // rust: let quiet = execute::Source {
    // rust: silent: true,
    // rust: ..self.player_source()
}
    // rust: let outer = self.command_source.replace(quiet);
    // rust: let ok = self.run_command(command);
    // rust: self.command_source = outer;
    // rust: ok
}
pub fn syntax_failure(self: *Self, e: *CommandError, command: []const u8) void {
}
    // rust: self.command_failure(e.message.clone());
    // rust: let Some(input) = &e.input else { return };
    // rust: let cursor = e.cursor.min(input.len());
    // rust: let suggest = Style {
    // rust: click: Some(text::ClickEvent::SuggestCommand(format!("/{command}"))),
    // rust: ..Style::default()
}
    // rust: let mut context = Text::empty();
    // rust: if cursor > 10 {
    // rust: context.push("...");
}
    // rust: let start = (0..=cursor.saturating_sub(10))
    // rust: .rev()
    // rust: .find(|&i| input.is_char_boundary(i))
    // rust: .unwrap_or(0);
    // rust: context.push(&input[start..cursor]);
    // rust: if cursor < input.len() {
    // rust: context.push(
    // rust: Text::literal(&input[cursor..])
    // rust: .with_color(text::RED)
    // rust: .underlined(),
    // rust: );
}
    // rust: context.push(
    // rust: Text::translate("command.context.here", &[])
    // rust: .with_color(text::RED)
    // rust: .italic(),
    // rust: );
    // rust: self.command_failure(context.with_color(text::GRAY).with_style(&suggest));
}
    /// CommandSourceStack.sendFailure: red text.
    // rust: pub(super) fn command_failure(&mut self, message: Text) {
    // rust: if self.command_source.is_some_and(|s| s.silent) {
    // rust: return;
}
    // rust: let message = Text::empty().append(message).with_color(text::RED);
    // rust: if let Some(block) = self.command_source.and_then(|s| s.block) {
    // rust: self.command_block_output(block, message);
    // rust: return;
}
    // rust: if let Some(cart) = self.command_source.and_then(|s| s.cart) {
    // rust: self.cart_command_output(cart, message);
    // rust: return;
}
    // rust: self.system_message(message);
}
    /// `sendSuccess(message, false)`: the source is told (when it takes
    /// success feedback), the operators are not.
    // rust: pub(super) fn feedback_unbroadcast(&mut self, message: Text) {
    // rust: if self.command_source.is_some_and(|s| s.silent) {
    // rust: return;
}
    // rust: if let Some(block) = self.command_source.and_then(|s| s.block) {
    // rust: self.command_block_success(block, message, false);
    // rust: return;
}
    // rust: if let Some(cart) = self.command_source.and_then(|s| s.cart) {
    // rust: self.cart_command_success(cart, message, false);
    // rust: return;
}
    // rust: if self.accepts_success() {
    // rust: self.system_message(message);
}
}
    /// `CommandSource.acceptsSuccess`: a player's source takes success feedback while
    /// `send_command_feedback` is on; the server console's and an RCON client's always do.
pub fn accepts_success(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.console_broadcast.is_some() || self.ui.rules.bool("send_command_feedback")
}
    /// sendSuccess honouring `send_command_feedback`.
    // rust: pub(super) fn feedback(&mut self, message: Text) {
    // rust: if self.command_source.is_some_and(|s| s.silent) {
    // rust: return;
}
    // rust: if let Some(block) = self.command_source.and_then(|s| s.block) {
    // rust: self.command_block_success(block, message, true);
    // rust: return;
}
    // rust: if let Some(cart) = self.command_source.and_then(|s| s.cart) {
    // rust: self.cart_command_success(cart, message, true);
    // rust: return;
}
    // rust: if self.accepts_success() {
    // rust: self.system_message(message.clone());
}
    // rust: self.broadcast_to_admins(message);
}
    /// `CommandSourceStack.broadcastToAdmins` for a command block or a command
    /// minecart called `name`: `[name: message]`, gray and italic, for every
    /// operator when `send_command_feedback` and for a dedicated server's console when
    /// `log_admin_commands`. Queued: `send_admin_feedback` sends it.
    // rust: pub(super) fn broadcast_source_to_admins(&mut self, name: Text, message: Text) {
    // rust: if message
    // rust: .translation_key()
    // rust: .is_some_and(|k| admin::QUIET.contains(&k))
    // rust: {
    // rust: return;
}
    // rust: let line = Text::translate("chat.type.admin", &[name, message])
    // rust: .with_color(text::GRAY)
    // rust: .italic();
    // rust: let ops = self.ui.rules.bool("send_command_feedback");
    // rust: let console = self.options.dedicated.is_some() && self.ui.rules.bool("log_admin_commands");
    // rust: if ops || console {
    // rust: self.admin_feedback.push((line, ops, console));
}
}
    /// CommandSourceStack.broadcastToAdmins (`sendSuccess` with `broadcast`)
    /// for a guest's command, the host's in a world open to LAN and the
    /// dedicated server console's when `broadcast-console-to-ops` is on:
    /// `[name: message]`, gray and italic, for the other operators when
    /// `send_command_feedback`, and for a player's command on a dedicated
    /// server the console when `log_admin_commands`. Queued while the
    /// command runs; `send_admin_feedback` sends it.
    // rust: pub(super) fn broadcast_to_admins(&mut self, message: Text) {
    // rust: let informs = match self.console_broadcast {
    // rust: Some(broadcast) => broadcast,
            // While a guest acts the host's LanHost is out of `self.lan`.
    // rust: None => self.lan_acting.is_some() || self.lan.is_some(),
}
    // rust: if !informs
    // rust: || message
    // rust: .translation_key()
    // rust: .is_some_and(|k| admin::QUIET.contains(&k))
    // rust: {
    // rust: return;
}
    // rust: let ops = self.ui.rules.bool("send_command_feedback");
        // MinecraftServer.sendSystemMessage, unless the server is the source.
    // rust: let console = self.console_broadcast.is_none()
    // rust: && self.lan_acting.is_some()
    // rust: && self.options.dedicated.is_some()
    // rust: && self.ui.rules.bool("log_admin_commands");
    // rust: if !ops && !console {
    // rust: return;
}
        // getDisplayName: the entity the command runs as (`execute as`), or
        // the server's own source, "Server".
    // rust: let who = match self.command_source.and_then(|s| s.entity) {
    // rust: Some(entity) => self.target_name(entity),
    // rust: None if self.console_broadcast.is_some() => {
    // rust: Text::literal(if self.rcon_source { "Rcon" } else { "Server" }.to_owned())
}
    // rust: None => self.player_display_name(),
}
    // rust: let line = Text::translate("chat.type.admin", &[who, message])
    // rust: .with_color(text::GRAY)
    // rust: .italic();
    // rust: self.admin_feedback.push((line, ops, console));
}
    /// Player.getDisplayName: the name (team-formatted), suggesting a
    /// `/tell`, showing the player on hover, inserting the name.
    // rust: pub(super) fn player_display_name(&self) -> Text {
    // rust: let name = self.acting_player_name().to_owned();
    // rust: let Some(uuid) = self.lan_acting_uuid else {
    // rust: return self.target_name(Target::Player);
}
    // rust: self.target_name(Target::Player).with_component_fields(vec![
    // rust: (
    // rust: "click_event".into(),
    // rust: serde_json::json!({"action": "suggest_command", "command": format!("/tell {name} ")}),
    // rust: ),
    // rust: (
    // rust: "hover_event".into(),
    // rust: serde_json::json!({"action": "show_entity", "id": "minecraft:player",
    // rust: "uuid": horizon_protocol::crypto::uuid_string(uuid), "name": name}),
    // rust: ),
    // rust: ("insertion".into(), name.into()),
    // rust: ])
}
pub fn source_position(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(s) = &self.command_source {
    // rust: return s.pos;
}
    // rust: match &self.player {
    // rust: Some(p) => [p.position.x, p.position.y, p.position.z],
    // rust: None => self.server_position(),
}
}
    /// MinecraftServer.createCommandSourceStack's position: the corner of
    /// the respawn block (`Vec3.atLowerCornerOf`).
    // rust: pub(super) fn server_position(&self) -> [f64; 3] {
    // rust: self.spawn.map_or([0.0, 64.0, 0.0], |s| {
    // rust: [s.x.floor(), s.y.floor(), s.z.floor()]
    // rust: })
}
pub fn source_rotation(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.command_source
    // rust: .map_or([self.yaw, self.pitch], |s| s.rot)
}
    /// LocalCoordinates use the anchored position; world coordinates the position.
    // rust: pub(super) fn resolve_coords(&self, c: &Coordinates) -> [f64; 3] {
    // rust: let origin = match (c, &self.command_source) {
    // rust: (Coordinates::Local(_), Some(s)) => self.anchor_position(s),
    // rust: _ => self.source_position(),
}
    // rust: c.position(origin, self.source_rotation())
}
    // rust: pub(super) fn coords(&self, ctx: &Context, name: &str) -> Option<Coordinates> {
    // rust: match ctx.get(name) {
    // rust: Some(Arg::Coords(c)) => Some(c.clone()),
    // rust: _ => None,
}
}
    // rust: pub(super) fn position_arg(&self, ctx: &Context, name: &str) -> Option<[f64; 3]> {
    // rust: self.coords(ctx, name).map(|c| self.resolve_coords(&c))
}
    /// BlockPosArgument.getLoadedBlockPos.
    // rust: pub(super) fn block_pos_arg(&self, ctx: &Context, name: &str) -> R<[i32; 3]> {
    // rust: let c = self
    // rust: .coords(ctx, name)
    // rust: .ok_or_else(|| err("argument.pos.missing.int", &[]))?;
        // BlockPos.containing(getPosition)
    // rust: let p = self.resolve_coords(&c).map(|v| v.floor() as i32);
    // rust: let dimension = self.command_source.map_or(self.dim, |s| s.dimension);
    // rust: if dimension != self.dim || !self.world.chunks.contains_key(&(p[0] >> 4, p[2] >> 4)) {
    // rust: return Err(err("argument.pos.unloaded", &[]));
}
    // rust: if p[1] < self.world.bottom_y() || p[1] >= self.world.top_y() {
    // rust: return Err(err("argument.pos.outofworld", &[]));
}
    // rust: Ok(p)
}
pub fn int(ctx: *Context, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ctx.get(name) {
    // rust: Some(Arg::Int(v)) => Some(*v),
    // rust: _ => None,
}
}
    // ---- entities -------------------------------------------------------

    /// The level `t` is in (`Entity.level`): a server's players have their
    /// own, which need not be the one in place; everything else is in the
    /// level in place.
    // rust: pub(super) fn target_level(&self, t: Target) -> Dim {
    // rust: let conn = match t {
    // rust: Target::Player => self.lan_acting,
    // rust: Target::Guest(conn) => Some(conn),
    // rust: _ => None,
}
    // rust: conn.and_then(|c| self.command_guest(c))
    // rust: .map_or(self.dim, |g| Dim::from_id(&g.dimension))
}
    // rust: pub(super) fn target_position(&self, t: Target) -> Option<[f64; 3]> {
    // rust: match t {
    // rust: Target::Player => self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]),
    // rust: Target::Guest(conn) => self.command_guest(conn).map(|g| g.position),
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| [m.position.x, m.position.y, m.position.z]),
    // rust: Target::Item(id) => self
    // rust: .dropped
    // rust: .iter()
    // rust: .find(|i| i.id == id)
    // rust: .map(|i| [i.position.x, i.position.y, i.position.z]),
    // rust: Target::Orb(id) => self
    // rust: .orbs
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .map(|o| [o.position.x, o.position.y, o.position.z]),
    // rust: Target::Projectile(id) => self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|a| a.id == id)
    // rust: .map(|a| [a.position.x, a.position.y, a.position.z]),
    // rust: Target::Stand(id) => self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .find(|a| a.id == id)
    // rust: .map(|a| [a.position.x, a.position.y, a.position.z]),
    // rust: Target::Frame(id) => self.item_frames.iter().find(|f| f.id == id).map(|f| {
    // rust: let (lo, hi) = f.bounds();
    // rust: [
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ]
    // rust: }),
    // rust: Target::Painting(id) => self.paintings.iter().find(|p| p.id == id).map(|p| {
    // rust: let (lo, hi) = p.bounds();
    // rust: [
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ]
    // rust: }),
    // rust: Target::Boat(id) => self
    // rust: .boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map(|b| [b.position.x, b.position.y, b.position.z]),
    // rust: Target::Cart(id) => self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| [c.position.x, c.position.y, c.position.z]),
    // rust: Target::Other(id) => self
    // rust: .others
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .map(|o| [o.position.x, o.position.y, o.position.z]),
    // rust: Target::Crystal(id) => self
    // rust: .crystals
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| [c.position.x, c.position.y, c.position.z]),
    // rust: Target::Dragon(id) => self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .filter(|d| d.id == id)
    // rust: .map(|d| [d.position.x, d.position.y, d.position.z]),
    // rust: Target::Tnt(id) => self
    // rust: .tnts
    // rust: .iter()
    // rust: .find(|t| t.id == id)
    // rust: .map(|t| [t.position.x, t.position.y, t.position.z]),
    // rust: Target::Falling(id) => self
    // rust: .falling
    // rust: .iter()
    // rust: .find(|f| f.id == id)
    // rust: .map(|f| [f.position.x, f.position.y, f.position.z]),
    // rust: Target::Rocket(id) => self
    // rust: .rockets
    // rust: .iter()
    // rust: .find(|r| r.id == id)
    // rust: .map(|r| [r.position.x, r.position.y, r.position.z]),
    // rust: Target::Cloud(id) => self.breath_clouds.iter().find(|c| c.id == id).map(|c| c.at),
    // rust: Target::Trident(id) => self
    // rust: .tridents
    // rust: .iter()
    // rust: .find(|t| t.id == id)
    // rust: .map(|t| [t.position.x, t.position.y, t.position.z]),
    // rust: Target::Fangs(id) => self.fangs.list.iter().find(|f| f.id == id).map(|f| f.pos),
    // rust: Target::Spawner(id) => self
    // rust: .ominous_spawners
    // rust: .iter()
    // rust: .find(|s| s.id == id)
    // rust: .map(|s| s.position),
}
}
    // rust: pub(super) fn target_type(&self, t: Target) -> String {
    // rust: match t {
    // rust: Target::Player | Target::Guest(_) => "minecraft:player".into(),
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or_else(String::new, |m| {
    // rust: horizon_client::command::args::normalize(&m.kind.id)
    // rust: }),
    // rust: Target::Item(_) => "minecraft:item".into(),
    // rust: Target::Orb(_) => "minecraft:experience_orb".into(),
    // rust: Target::Projectile(id) => self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|p| p.id == id)
    // rust: .map_or_else(String::new, |p| p.kind.id().into()),
    // rust: Target::Stand(_) => "minecraft:armor_stand".into(),
    // rust: Target::Frame(id) => {
    // rust: if self.item_frames.iter().any(|f| f.id == id && f.glow) {
    // rust: "minecraft:glow_item_frame".into()
    // rust: } else {
    // rust: "minecraft:item_frame".into()
}
}
    // rust: Target::Painting(_) => "minecraft:painting".into(),
    // rust: Target::Boat(id) => self
    // rust: .boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map_or_else(|| "minecraft:oak_boat".into(), |b| b.entity_type()),
    // rust: Target::Cart(id) => self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map_or_else(|| "minecraft:minecart".into(), |c| c.kind.id().into()),
    // rust: Target::Other(id) => self
    // rust: .others
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .map_or_else(String::new, |o| o.kind.clone()),
    // rust: Target::Crystal(_) => "minecraft:end_crystal".into(),
    // rust: Target::Dragon(_) => "minecraft:ender_dragon".into(),
    // rust: Target::Tnt(_) => "minecraft:tnt".into(),
    // rust: Target::Falling(_) => "minecraft:falling_block".into(),
    // rust: Target::Rocket(_) => "minecraft:firework_rocket".into(),
    // rust: Target::Trident(_) => "minecraft:trident".into(),
    // rust: Target::Fangs(_) => "minecraft:evoker_fangs".into(),
    // rust: Target::Spawner(_) => "minecraft:ominous_item_spawner".into(),
    // rust: Target::Cloud(_) => "minecraft:area_effect_cloud".into(),
}
}
    /// The name of the player the game acts for: a guest's own while their
    /// command or action runs (`Player.getName`).
    // rust: pub(super) fn acting_player_name(&self) -> &str {
    // rust: self.lan_acting_name.as_deref().unwrap_or(PLAYER_NAME)
}
    /// Entity.getDisplayName.
    // rust: pub(super) fn target_name(&self, t: Target) -> Text {
    // rust: match t {
    // rust: Target::Player => {
    // rust: let name = self.acting_player_name();
    // rust: if let Some(uuid) = self.lan_acting_uuid {
    // rust: return self.player_text(name, uuid);
}
    // rust: match self.score.board.players_team(name) {
                    // PlayerTeam.formatNameForTeam.
    // rust: Some(team) => team.formatted_name(Text::literal(name)),
    // rust: None => Text::literal(name),
}
}
    // rust: Target::Guest(conn) => match self.command_guest(conn) {
    // rust: Some(g) => self.player_text(&g.name, g.uuid),
    // rust: None => Text::empty(),
    // rust: },
            // ItemEntity.getName: its CustomName, else the stack's item name
            // (`getItemName`: `minecraft:item_name`, else the item's own).
    // rust: Target::Item(id) => {
    // rust: if let Some(c) = self.persist_raw(id).and_then(|r| r.get("CustomName")) {
    // rust: return horizon_client::scoreboard::comp_text(
    // rust: &horizon_client::scoreboard::tag_to_json(c),
    // rust: );
}
    // rust: let stack = self.dropped.iter().find(|i| i.id == id).map(|i| &i.stack);
    // rust: match stack.and_then(|s| s.item_name()) {
    // rust: Some(name) => Text::literal(name),
    // rust: None => {
    // rust: let item = stack.map(|s| s.item.to_string()).unwrap_or_default();
    // rust: Text::literal(self.pack.names.display_item(&item))
}
}
}
            // FallingBlockEntity.getTypeName: `entity.minecraft.falling_block_type`
            // with the block's name.
    // rust: Target::Falling(id) => {
    // rust: let block = self
    // rust: .falling
    // rust: .iter()
    // rust: .find(|f| f.id == id)
    // rust: .map(|f| self.res.facts().get(f.state).name.replace(':', "."))
    // rust: .unwrap_or_default();
    // rust: let block = Text::translate(&format!("block.{block}"), &[]);
    // rust: Text::translate("entity.minecraft.falling_block_type", &[block])
}
    // rust: Target::Mob(id) => self.mobs.iter().find(|m| m.id == id).map_or_else(
    // rust: || Text::translate("entity.", &[]),
    // rust: |m| match self.mob_team_of(m) {
    // rust: Some(team) => team.formatted_name(m.command_name()),
    // rust: None => m.command_name(),
    // rust: },
    // rust: ),
    // rust: other => {
                // Entity.getDisplayName: the CustomName component, else the type.
    // rust: let custom = match other {
    // rust: Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Painting(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id)
    // rust: | Target::Cloud(id) => self.persist_raw(id).and_then(|r| r.get("CustomName")),
    // rust: _ => None,
}
    // rust: if let Some(c) = custom {
    // rust: return horizon_client::scoreboard::comp_text(
    // rust: &horizon_client::scoreboard::tag_to_json(c),
    // rust: );
}
    // rust: let ty = self.target_type(other);
    // rust: Text::translate(&format!("entity.{}", ty.replace(':', ".")), &[])
}
}
}
    /// EntitySelector.findEntities.
    // rust: pub(super) fn select(&mut self, s: &Selector) -> Vec<Target> {
    // rust: if let Some(name) = &s.player_name {
    // rust: return self.player_named(name).into_iter().collect();
}
    // rust: if let Some(uuid) = s.uuid {
    // rust: return self.target_by_uuid(uuid).into_iter().collect();
}
    // rust: let origin = {
    // rust: let p = self.source_position();
    // rust: [
    // rust: s.pos[0].unwrap_or(p[0]),
    // rust: s.pos[1].unwrap_or(p[1]),
    // rust: s.pos[2].unwrap_or(p[2]),
    // rust: ]
}
    // rust: let mut source_candidates: Vec<Target> = Vec::new();
    // rust: match (s.kind, self.command_source) {
            // @s: the executing entity (none for a server source).
    // rust: ('s', Some(source)) => source_candidates.extend(source.entity),
    // rust: ('s', None) => source_candidates.extend(self.source_entity()),
            // A guest in place is among the players, in join order.
    // rust: _ if self.player.is_some() && self.lan_acting.is_none() => {
    // rust: source_candidates.push(Target::Player);
}
    // rust: _ => {}
}
    // rust: if s.kind != 's' {
    // rust: source_candidates.extend(self.player_candidates(s));
}
    // rust: let source_dim = self.dim;
        // A selector with a spatial constraint reaches the level the command
        // runs in only; an unbounded one reaches every loaded level
        // (EntitySelector.findEntities).
    // rust: let dims = if s.world_limited() {
    // rust: vec![source_dim]
    // rust: } else {
    // rust: self.loaded_dims()
}
    // rust: let mut out: Vec<(Target, f64)> = Vec::new();
    // rust: for dim in dims {
    // rust: let back = self.enter_command_level(dim);
    // rust: let mut candidates = Vec::new();
    // rust: if dim == source_dim {
    // rust: candidates.append(&mut source_candidates);
}
    // rust: if s.kind != 's' {
    // rust: candidates.extend(self.level_candidates());
}
    // rust: out.extend(self.select_in_level(candidates, s, origin));
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
}
    // rust: match s.sort {
    // rust: Sort::Nearest => out.sort_by(|a, b| a.1.total_cmp(&b.1)),
    // rust: Sort::Furthest => out.sort_by(|a, b| b.1.total_cmp(&a.1)),
    // rust: Sort::Random => {
    // rust: for i in (1..out.len()).rev() {
    // rust: let j = self.world.random.next_int_bound(i as i32 + 1).unwrap_or(0) as usize;
    // rust: out.swap(i, j);
}
}
    // rust: Sort::Arbitrary => {}
}
    // rust: out.into_iter()
    // rust: .take(s.limit.max(1))
    // rust: .map(|(t, _)| t)
    // rust: .collect()
}
    /// The candidates of the level in place that pass the selector
    /// (EntitySelector.getPredicate).
    // rust: fn select_in_level(
    // rust: &mut self,
    // rust: candidates: Vec<Target>,
    // rust: s: &Selector,
    // rust: origin: [f64; 3],
    // rust: ) -> Vec<(Target, f64)> {
    // rust: let level = self.experience.level;
    // rust: let creative = self.creative;
    // rust: let passing = self.selector_extra_filter(&candidates, s);
    // rust: candidates
    // rust: .into_iter()
    // rust: .filter_map(|t| {
    // rust: let p = self.target_position(t)?;
    // rust: let ty = self.target_type(t);
                // type=: every positive must match, no negative may match.
    // rust: for (want, neg) in &s.types {
    // rust: let matches = if let Some(tag) = want.strip_prefix('#') {
    // rust: self.entity_tag_matches(tag, &ty)
    // rust: } else {
    // rust: *want == ty
}
    // rust: if matches == *neg {
    // rust: return None;
}
}
    // rust: if !s.include_entities
    // rust: && !t.is_player()
    // rust: && s.types.iter().all(|(w, n)| *n || w != &ty)
    // rust: && s.kind != 'e'
    // rust: && s.kind != 'n'
    // rust: {
    // rust: return None;
}
    // rust: for (name, neg) in &s.names {
    // rust: let n = self.target_name(t).plain();
    // rust: if (n == *name) == *neg {
    // rust: return None;
}
}
    // rust: if !passing.contains(&t) {
    // rust: return None;
}
    // rust: let player = match t {
    // rust: Target::Player => Some((level, if creative { "creative" } else { "survival" })),
    // rust: Target::Guest(conn) => self.guest_level_and_mode(conn),
    // rust: _ => None,
}
    // rust: if let Some((lo, hi)) = s.level
    // rust: && player.is_none_or(|(level, _)| {
    // rust: lo.is_some_and(|l| level < l) || hi.is_some_and(|h| level > h)
    // rust: })
    // rust: {
    // rust: return None;
}
    // rust: for (mode, neg) in &s.gamemodes {
    // rust: if player.is_none_or(|(_, current)| (current == mode) == *neg) {
    // rust: return None;
}
}
    // rust: let d2 = (p[0] - origin[0]).powi(2)
    // rust: + (p[1] - origin[1]).powi(2)
    // rust: + (p[2] - origin[2]).powi(2);
    // rust: if let Some((lo, hi)) = s.distance
    // rust: && (lo.is_some_and(|l| d2 < l * l) || hi.is_some_and(|h| d2 > h * h))
    // rust: {
    // rust: return None;
}
                // x_rotation is the pitch, y_rotation the yaw (getXRot, getYRot).
    // rust: let [yaw, pitch] = self.target_rotation(t);
    // rust: if let Some(range) = s.x_rotation
    // rust: && !rotation_in(range, pitch)
    // rust: {
    // rust: return None;
}
    // rust: if let Some(range) = s.y_rotation
    // rust: && !rotation_in(range, yaw)
    // rust: {
    // rust: return None;
}
    // rust: if s.delta.iter().any(Option::is_some) {
    // rust: let d = s.delta.map(|v| v.unwrap_or(0.0));
    // rust: if let Some(bounds) = self.selector_target_bounds(t) {
    // rust: if !selector_bounds::selector_box(origin, d).intersects(bounds) {
    // rust: return None;
}
    // rust: } else {
                        // Unmodeled boxes retain their previous point fallback.
    // rust: for i in 0..3 {
    // rust: let (a, b) = (
    // rust: origin[i].min(origin[i] + d[i]),
    // rust: origin[i].max(origin[i] + d[i]) + 1.0,
    // rust: );
    // rust: if p[i] < a || p[i] >= b {
    // rust: return None;
}
}
}
}
    // rust: Some((t, d2))
    // rust: })
    // rust: .collect()
}
    /// The entities of the level in place a selector can find: one walk over
    /// the entity lists (a kind added there joins `@e` once it names its
    /// `Target`), then the kinds that are not on the walk. An
    /// unsorted selector lists them in that order.
pub fn level_candidates(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
//         use super::entity::{Entity as _, entity_lists_of, for_each_entity};
    // rust: let mut candidates = Vec::new();
    // rust: for_each_entity!(entity_lists_of!(self), entity => {
    // rust: candidates.extend(entity.selector_target());
    // rust: });
    // rust: candidates.extend(self.item_frames.iter().map(|f| Target::Frame(f.id)));
    // rust: candidates.extend(self.paintings.iter().map(|p| Target::Painting(p.id)));
    // rust: candidates.extend(self.others.iter().map(|o| Target::Other(o.id)));
    // rust: candidates.extend(self.fangs.list.iter().map(|f| Target::Fangs(f.id)));
        // The End crystals and the dragon (EndCrystal and EnderDragon
        // are entities of their own).
    // rust: candidates.extend(self.crystals.iter().map(|c| Target::Crystal(c.id)));
    // rust: if let Some(d) = &self.dragon {
    // rust: candidates.push(Target::Dragon(d.id));
}
    // rust: candidates.extend(self.ominous_spawners.iter().map(|s| Target::Spawner(s.id)));
    // rust: candidates.extend(
    // rust: self.breath_clouds
    // rust: .iter()
    // rust: .filter(|c| c.id != 0)
    // rust: .map(|c| Target::Cloud(c.id)),
    // rust: );
    // rust: candidates
}
    /// The loaded levels, in the order the server holds them: the
    /// overworld, the nether, the end (MinecraftServer.getAllLevels).
pub fn loaded_dims(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut dims = vec![self.dim];
    // rust: dims.extend(self.levels.parked_dims());
    // rust: dims.sort_by_key(|d| match d {
    // rust: Dim::Overworld => 0,
    // rust: Dim::Nether => 1,
    // rust: Dim::End => 2,
    // rust: });
    // rust: dims
}
    /// `Level.getEntity`: the entity of the level in place with a network
    /// id, players aside.
    // rust: pub(in crate::game) fn level_entity(&self, id: i32) -> Option<Target> {
    // rust: let id = u32::try_from(id).ok()?;
    // rust: [
    // rust: Target::Mob(id),
    // rust: Target::Item(id),
    // rust: Target::Orb(id),
    // rust: Target::Projectile(id),
    // rust: Target::Stand(id),
    // rust: Target::Frame(id),
    // rust: Target::Painting(id),
    // rust: Target::Boat(id),
    // rust: Target::Cart(id),
    // rust: Target::Other(id),
    // rust: Target::Fangs(id),
    // rust: Target::Crystal(id),
    // rust: Target::Dragon(id),
    // rust: Target::Tnt(id),
    // rust: Target::Falling(id),
    // rust: Target::Rocket(id),
    // rust: Target::Trident(id),
    // rust: Target::Spawner(id),
    // rust: Target::Cloud(id),
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|t| self.level_holds(*t))
}
    /// Whether the level in place holds the entity a target names.
pub fn level_holds(self: *Self, t: Target) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t {
            // A player is in no level of its own.
    // rust: Target::Player | Target::Guest(_) => true,
    // rust: Target::Mob(id) => self.mobs.iter().any(|m| m.id == id),
    // rust: Target::Item(id) => self.dropped.iter().any(|i| i.id == id),
    // rust: Target::Orb(id) => self.orbs.iter().any(|o| o.id == id),
    // rust: Target::Projectile(id) => self.creatures.projectiles.iter().any(|p| p.id == id),
    // rust: Target::Stand(id) => self.armor_stands.iter().any(|a| a.id == id),
    // rust: Target::Frame(id) => self.item_frames.iter().any(|f| f.id == id),
    // rust: Target::Painting(id) => self.paintings.iter().any(|p| p.id == id),
    // rust: Target::Boat(id) => self.boats.iter().any(|b| b.id == id),
    // rust: Target::Cart(id) => self.carts.iter().any(|c| c.id == id),
    // rust: Target::Other(id) => self.others.iter().any(|o| o.id == id),
    // rust: Target::Fangs(id) => self.fangs.list.iter().any(|f| f.id == id),
    // rust: Target::Crystal(id) => self.crystals.iter().any(|c| c.id == id),
    // rust: Target::Dragon(id) => self.dragon.as_ref().is_some_and(|d| d.id == id),
    // rust: Target::Tnt(id) => self.tnts.iter().any(|t| t.id == id),
    // rust: Target::Falling(id) => self.falling.iter().any(|f| f.id == id),
    // rust: Target::Rocket(id) => self.rockets.iter().any(|r| r.id == id),
    // rust: Target::Trident(id) => self.tridents.iter().any(|t| t.id == id),
    // rust: Target::Spawner(id) => self.ominous_spawners.iter().any(|s| s.id == id),
    // rust: Target::Cloud(id) => self.breath_clouds.iter().any(|c| c.id == id),
}
}
    /// Run `f` with the level that holds the entity a target names in place
    /// (the entity ids are unique across the loaded levels) and put the
    /// level back afterwards. `f` does not run when no level holds the
    /// entity.
    // rust: pub(in crate::game) fn in_target_level<R>(
    // rust: &mut self,
    // rust: t: Target,
    // rust: f: impl FnOnce(&mut Self) -> R,
    // rust: ) -> Option<R> {
    // rust: if self.level_holds(t) {
    // rust: return Some(f(self));
}
    // rust: for dim in self.levels.parked_dims() {
    // rust: let back = self.enter_command_level(dim);
    // rust: if self.level_holds(t) {
    // rust: let r = f(self);
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
    // rust: return Some(r);
}
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
}
    // rust: None
}
pub fn entity_tag_matches(self: *Self, tag: []const u8, ty: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = self.options.resources.join(format!(
    // rust: "data/minecraft/tags/entity_type/{}.json",
    // rust: tag.trim_start_matches("minecraft:")
    // rust: ));
    // rust: serde_json::from_slice::<serde_json::Value>(&std::fs::read(path).unwrap_or_default())
    // rust: .ok()
    // rust: .is_some_and(|v| {
    // rust: v["values"]
    // rust: .as_array()
    // rust: .is_some_and(|a| a.iter().any(|e| e.as_str() == Some(ty)))
    // rust: })
}
    /// EntityArgument.getEntities / getPlayers / getEntity / getPlayer.
    // rust: pub(super) fn entities(&mut self, ctx: &Context, name: &str, players: bool) -> R<Vec<Target>> {
    // rust: let Some(Arg::Entity(s)) = ctx.get(name).cloned() else {
    // rust: return Ok(vec![self.implied_player()]);
}
    // rust: let found: Vec<Target> = self
    // rust: .select(&s)
    // rust: .into_iter()
    // rust: .filter(|t| !players || t.is_player())
    // rust: .collect();
    // rust: if found.is_empty() {
    // rust: return Err(err(
    // rust: if players {
    // rust: "argument.entity.notfound.player"
    // rust: } else {
    // rust: "argument.entity.notfound.entity"
    // rust: },
    // rust: &[],
    // rust: ));
}
    // rust: Ok(found)
}
    // ---- dispatch -------------------------------------------------------

pub fn execute_command(self: *Self, id: []const u8, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "help" => self.cmd_help(ctx),
    // rust: "gamemode" => self.cmd_gamemode(ctx),
    // rust: "defaultgamemode" => {
    // rust: let Some(Arg::GameMode(m)) = ctx.get("gamemode") else {
    // rust: return Ok(0);
}
    // rust: self.set_default_game_mode(match m {
    // rust: horizon_client::command::args::GameMode::Survival => 0,
    // rust: horizon_client::command::args::GameMode::Creative => 1,
    // rust: horizon_client::command::args::GameMode::Adventure => 2,
    // rust: horizon_client::command::args::GameMode::Spectator => 3,
    // rust: });
    // rust: self.feedback(Text::translate(
    // rust: "commands.defaultgamemode.success",
    // rust: &[Text::translate(&format!("gameMode.{}", m.name()), &[])],
    // rust: ));
    // rust: Ok(0)
}
    // rust: "give" => self.cmd_give(ctx),
    // rust: "teleport.location"
    // rust: | "teleport.destination"
    // rust: | "teleport.targets.location"
    // rust: | "teleport.targets.destination" => self.cmd_teleport(id, ctx),
    // rust: id if id.starts_with("time.") => self.cmd_time(id, ctx),
    // rust: id if id.starts_with("raid.") => self.cmd_raid(id, ctx),
    // rust: "weather" => self.cmd_weather(ctx),
    // rust: "kill" => self.cmd_kill(ctx),
    // rust: "summon" => self.cmd_summon(ctx),
    // rust: "effect.give" => self.cmd_effect_give(ctx),
    // rust: "effect.clear" => self.cmd_effect_clear(ctx),
    // rust: "enchant" => self.cmd_enchant(ctx),
    // rust: "tellraw" => self.cmd_tellraw(ctx),
    // rust: "title" => self.cmd_title(ctx),
    // rust: "setblock" => self.cmd_setblock(ctx),
    // rust: "fill" => self.cmd_fill(ctx),
    // rust: "clone" => self.cmd_clone(ctx),
    // rust: "experience" => self.cmd_experience(ctx),
    // rust: "advancement" => self.cmd_advancement(ctx),
    // rust: "gamerule" => self.cmd_gamerule(ctx),
    // rust: "difficulty" => self.cmd_difficulty(ctx),
    // rust: "seed" => {
    // rust: let seed = self.level.seed.to_string();
    // rust: let value = Text::copyable(seed);
    // rust: self.feedback_unbroadcast(Text::translate("commands.seed.success", &[value]));
    // rust: Ok(self.level.seed as i32)
}
    // rust: "spawnpoint" => self.cmd_spawnpoint(ctx),
    // rust: "setworldspawn" => self.cmd_setworldspawn(ctx),
    // rust: "clear" => self.cmd_clear(ctx),
    // rust: "item" => self.cmd_item(ctx),
    // rust: "item.modify" => self.cmd_item_modify(ctx),
    // rust: "spectate" => self.cmd_spectate(ctx),
    // rust: id if id.starts_with("waypoint.") => self.cmd_waypoint(id, ctx),
    // rust: id if id.starts_with("dialog.") => self.cmd_dialog(id, ctx),
    // rust: id if id.starts_with("posteffect.") => self.cmd_posteffect(id, ctx),
    // rust: "kick" => self.cmd_kick(ctx),
    // rust: "op" | "deop" | "ban" | "pardon" => self.cmd_profiles(id, ctx),
    // rust: "ban-ip" | "pardon-ip" => self.cmd_ip_bans(id, ctx),
    // rust: id if id.starts_with("banlist") => self.cmd_banlist(id),
    // rust: id if id.starts_with("whitelist.") => self.cmd_whitelist(id, ctx),
    // rust: "setidletimeout" => self.cmd_setidle_timeout(ctx),
    // rust: "stop" => self.cmd_stop(),
    // rust: "save-all" => self.cmd_save_all(),
    // rust: "save-off" | "save-on" => self.cmd_auto_save(id == "save-on"),
    // rust: "transfer" => self.cmd_transfer(ctx),
    // rust: "fetchprofile" => self.cmd_fetchprofile(ctx),
    // rust: "publish" => self.cmd_publish(ctx),
    // rust: "unpublish" => self.cmd_unpublish(),
    // rust: "debug" => self.cmd_debug(ctx),
    // rust: "jfr" => self.cmd_jfr(ctx),
    // rust: "version" => self.cmd_version(),
    // rust: id if id.starts_with("test.") => self.cmd_test(id, ctx),
    // rust: "compute" => self.cmd_compute(ctx),
    // rust: "place" => self.cmd_place(ctx),
    // rust: "place.feature" | "place.jigsaw" | "place.structure" => {
    // rust: self.cmd_place_generated(id, ctx)
}
    // rust: "recipe.give" | "recipe.take" => self.cmd_recipe(id, ctx),
    // rust: "damage" => self.cmd_damage(ctx),
    // rust: "rotate" => self.cmd_rotate(ctx),
    // rust: "swing" => self.cmd_swing(ctx),
    // rust: "playsound" => self.cmd_playsound(ctx),
    // rust: "stopsound" => self.cmd_stopsound(ctx),
    // rust: "particle" => self.cmd_particle(ctx),
    // rust: id if id.starts_with("attribute.") => {
    // rust: let result = self.cmd_attribute(id, ctx);
                // AttributeInstance.setDirty: the entity reacts when it ticks.
    // rust: if result.is_ok()
    // rust: && matches!(ctx.get("attribute"), Some(Arg::Resource(a)) if a == "minecraft:waypoint_transmit_range")
    // rust: && !id.ends_with("get")
    // rust: && let Ok(t) = self.entities(ctx, "target", false)
    // rust: {
    // rust: let target = self.waypoint_target(t[0]);
    // rust: self.cmds.waypoint_dirty.push(target);
}
    // rust: result
}
    // rust: "ride.mount" | "ride.dismount" => self.cmd_ride(id, ctx),
    // rust: "spreadplayers" => self.cmd_spreadplayers(ctx),
    // rust: id if id.starts_with("forceload.") => self.cmd_forceload(id, ctx),
    // rust: id if id.starts_with("pregen.") => self.cmd_pregen(id, ctx),
    // rust: "fillbiome" => self.cmd_fillbiome(ctx),
    // rust: id if id.starts_with("worldborder.") => self.cmd_worldborder(id, ctx),
    // rust: id if id.starts_with("loot.") => self.cmd_loot(id, ctx),
    // rust: "teammsg" => self.cmd_teammsg(ctx),
    // rust: id if id.starts_with("stopwatch.") => self.cmd_stopwatch(id, ctx),
    // rust: id if id.starts_with("tick.") => self.cmd_tick(id, ctx),
    // rust: id if id.starts_with("random.") => self.cmd_random(id, ctx),
    // rust: "function" => self.cmd_function(ctx),
    // rust: "return.value" | "return.fail" => self.cmd_return(id, ctx),
    // rust: "schedule.function" | "schedule.clear" => self.cmd_schedule(id, ctx),
    // rust: "reload" => self.cmd_reload(),
    // rust: id if id.starts_with("datapack.") => self.cmd_datapack(id, ctx),
    // rust: id if id.starts_with("bossbar.") => self.cmd_bossbar(id, ctx),
    // rust: id if id.starts_with("data.") => self.cmd_data(id, ctx),
    // rust: id if id.starts_with("tag.") => self.cmd_tag(id, ctx),
    // rust: id if id.starts_with("scoreboard.")
    // rust: || id.starts_with("team.")
    // rust: || id.starts_with("trigger") =>
    // rust: {
    // rust: self.cmd_scoreboard(id, ctx)
}
    // rust: "locate.structure" | "locate.biome" => self.cmd_locate(id, ctx),
    // rust: "locate.poi" => self.cmd_locate_poi(ctx),
    // rust: "warden_spawn_tracker.clear" | "warden_spawn_tracker.set" => {
    // rust: let level = Self::int(ctx, "warning_level");
    // rust: self.cmd_warden_spawn_tracker(level);
    // rust: Ok(1)
}
    // rust: "say" | "me" | "msg" => self.cmd_say(id, ctx),
    // rust: "list" => self.cmd_list(ctx),
    // rust: _ => Err(err("command.failed", &[])),
}
}
pub fn cmd_help(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = vanilla::game_dispatcher_with_features(&self.level.enabled_features);
    // rust: let level = self.ui.registries.permission;
    // rust: match ctx.get("command") {
    // rust: None => {
    // rust: let usage = d.smart_usage(0, level);
    // rust: let n = usage.len() as i32;
    // rust: for (_, line) in usage {
    // rust: self.feedback_unbroadcast(Text::literal(format!("/{line}")));
}
    // rust: Ok(n)
}
    // rust: Some(Arg::Str(command)) => {
    // rust: let parse = d.parse(command, &self.ui.registries);
    // rust: if parse.context.nodes.is_empty() {
    // rust: return Err(err("commands.help.failed", &[]));
}
    // rust: let last = parse.context.nodes.last().map(|n| n.0).unwrap_or(0);
    // rust: let usage = d.smart_usage(last, level);
    // rust: let prefix = &command[..parse.context.range.1.min(command.len())];
    // rust: for (_, line) in &usage {
    // rust: self.feedback_unbroadcast(Text::literal(format!("/{prefix} {line}")));
}
    // rust: if usage.is_empty() {
    // rust: self.feedback_unbroadcast(Text::literal(format!("/{prefix}")));
}
    // rust: Ok(usage.len().max(1) as i32)
}
    // rust: _ => Ok(0),
}
}
    // rust: pub(super) fn set_game_mode(&mut self, mode: GameMode) -> bool {
    // rust: if self.mode == mode {
    // rust: return false;
}
        // A server player's change is heard by the mods first, who may keep it.
    // rust: if let Some(uuid) = self.lan_acting_uuid {
    // rust: let name = self.acting_player_name().to_owned();
    // rust: let mut cancel = false;
    // rust: self.native_player_game_mode_changed(
    // rust: uuid,
    // rust: &name,
    // rust: self.mode_id(),
    // rust: super::game_mode::mode_id_of(mode),
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: return false;
}
}
    // rust: self.set_mode(mode);
    // rust: if self.screen == Screen::Inventory && (self.creative || self.spectator()) {
    // rust: self.screen = Screen::Playing;
}
    // rust: true
}
pub fn cmd_gamemode(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Arg::GameMode(mode)) = ctx.get("gamemode").cloned() else {
    // rust: return Ok(0);
}
    // rust: let targets = if ctx.get("target").is_some() {
    // rust: self.entities(ctx, "target", true)?
    // rust: } else {
    // rust: vec![self.implied_player()]
}
    // rust: let mut count = 0;
    // rust: for t in targets {
    // rust: let mode_name = Text::translate(&format!("gameMode.{}", mode.name()), &[]);
            // GameModeCommand.logGamemodeChange: the source's own entity.
    // rust: let own = self.source_entity() == Some(t);
    // rust: let told = !own && self.ui.rules.bool("send_command_feedback");
    // rust: let changed = self.for_player(t, |g| {
    // rust: if !g.set_game_mode(mode) {
    // rust: return false;
}
    // rust: if told {
    // rust: g.system_message(Text::translate(
    // rust: "gameMode.changed",
    // rust: std::slice::from_ref(&mode_name),
    // rust: ));
}
    // rust: true
    // rust: });
    // rust: if changed != Some(true) {
    // rust: continue;
}
    // rust: count += 1;
    // rust: if own {
    // rust: self.feedback(Text::translate(
    // rust: "commands.gamemode.success.self",
    // rust: &[mode_name],
    // rust: ));
    // rust: } else {
    // rust: self.feedback(Text::translate(
    // rust: "commands.gamemode.success.other",
    // rust: &[self.target_name(t), mode_name],
    // rust: ));
}
}
    // rust: Ok(count)
}
    /// ItemStack.getDisplayName of one `item` with no components.
    // rust: pub(super) fn item_display_name(&self, item: &str) -> Text {
    // rust: self.stack_display_name(&ItemStack {
    // rust: item: item.into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })
}
    /// `ItemStack.getDisplayName`: the hover name (custom name in italics,
    /// a written book's title, a potion's effect name, else the item's
    /// translated name) in brackets, in the rarity colour and showing the
    /// stack on hover unless it is empty.
    // rust: pub(super) fn stack_display_name(&self, s: &ItemStack) -> Text {
    // rust: let item = &*s.item;
    // rust: let empty = item == "minecraft:air" || s.count == 0;
    // rust: let custom = s.data().and_then(|data| data.custom_name.as_ref());
    // rust: let hover = if let Some(c) = custom {
    // rust: horizon_client::component::name_text(c)
    // rust: } else if let Some(name) = s.data().and_then(|d| d.other("minecraft:item_name")) {
            // `ItemStack.getItemName`: the `item_name` component wins over the
            // item's own name (`Item.getName`), so a datapack's or a server's
            // renaming shows here as it does on the tooltip's first line.
    // rust: horizon_client::component::name_text(name)
    // rust: } else if let Some(title) = s
    // rust: .data()
    // rust: .and_then(|d| d.written.as_ref())
    // rust: .map(|w| w.title.clone())
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: {
    // rust: Text::literal(title)
    // rust: } else if matches!(
    // rust: item,
    // rust: "minecraft:potion"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:tipped_arrow"
    // rust: ) && s.potion().is_some()
    // rust: {
    // rust: Text::translate(
    // rust: &horizon_client::brewing::potion_name_key(item, s.potion()),
    // rust: &[],
    // rust: )
    // rust: } else if item == "minecraft:shield"
    // rust: && let Some(color) = s.data().and_then(|d| d.base_color.as_deref())
    // rust: {
            // `ShieldItem.getName`: the banner's base colour names the shield.
    // rust: Text::translate(&format!("item.minecraft.shield.{color}"), &[])
    // rust: } else if let Some(head) = horizon_client::item_tooltip::player_head_name(s) {
    // rust: head.text()
    // rust: } else {
            // Item.getDescriptionId: a block item's is the block's.
    // rust: let (namespace, path) = item.split_once(':').unwrap_or(("minecraft", item));
    // rust: let key = format!("item.{namespace}.{path}");
    // rust: let key = if self.pack.names.get(&key).is_some() {
    // rust: key
    // rust: } else {
    // rust: format!("block.{namespace}.{path}")
}
    // rust: Text::translate(&key, &[])
}
        // Component.empty().append(getHoverName()), italic for a custom name.
    // rust: let mut name = Text::empty().append(hover);
    // rust: if custom.is_some() {
    // rust: name = name.italic();
}
    // rust: let wrapped = Text::translate("chat.square_brackets", &[name]);
    // rust: if empty {
    // rust: return wrapped;
}
    // rust: let mut rarity = self.item_rarity(item);
    // rust: if !s.enchantments().is_empty() {
    // rust: rarity = match rarity.as_str() {
    // rust: "rare" => "epic".into(),
    // rust: "epic" => rarity,
    // rust: _ => "rare".into(),
}
}
    // rust: let color = match rarity.as_str() {
    // rust: "uncommon" => text::YELLOW,
    // rust: "rare" => text::AQUA,
    // rust: "epic" => text::LIGHT_PURPLE,
    // rust: _ => text::WHITE,
}
        // HoverEvent.ShowItem: the count only when it is not one.
    // rust: let mut shown = serde_json::json!({"action": "show_item", "id": item});
    // rust: if s.count != 1 {
    // rust: shown["count"] = s.count.into();
}
    // rust: wrapped
    // rust: .with_color(color)
    // rust: .with_component_fields(vec![("hover_event".into(), shown)])
}
    // rust: pub(super) fn item_rarity(&self, item: &str) -> String {
    // rust: static RARITY: std::sync::OnceLock<std::collections::HashMap<String, String>> =
    // rust: std::sync::OnceLock::new();
    // rust: let map = RARITY.get_or_init(|| {
    // rust: horizon_world::item_defaults::read(&self.options.resources)
    // rust: .unwrap_or_default()
    // rust: .into_iter()
    // rust: .filter_map(|(k, c)| c["minecraft:rarity"].as_str().map(|r| (k, r.to_owned())))
    // rust: .collect()
    // rust: });
    // rust: map.get(item).cloned().unwrap_or_else(|| "common".into())
}
pub fn cmd_give(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Arg::Item(ItemInput { id, components, .. })) = ctx.get("item").cloned() else {
    // rust: return Ok(0);
}
    // rust: let (damage, extra) = match components
    // rust: .as_deref()
    // rust: .map(horizon_client::item_data::command_components)
    // rust: {
    // rust: Some(Ok(tag)) => horizon_client::item_data::decode_components(Some(&tag)),
    // rust: Some(Err(e)) => return Err(CommandError::new(Text::literal(e))),
    // rust: None => (0, None),
}
    // rust: let count = Self::int(ctx, "count").unwrap_or(1);
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: let max_stack = self.items().get(&id).map_or(64, |i| i.max_stack) as i32;
        // A native mod's item can stack far past vanilla's 99: saturate rather
        // than overflow on a size near i32::MAX.
    // rust: let limit = max_stack.saturating_mul(100);
    // rust: if count > limit {
    // rust: return Err(CommandError::new(Text::translate(
    // rust: "commands.give.failed.toomanyitems",
    // rust: &[
    // rust: Text::literal(limit.to_string()),
    // rust: self.item_display_name(&id),
    // rust: ],
    // rust: )));
}
        // An air stack is empty: nothing is given (but the message still is).
    // rust: let empty = id == "minecraft:air";
    // rust: for &t in targets.iter().filter(|_| !empty) {
            // The player's UUID, which an item they could not hold is set to.
    // rust: let conn = match t {
    // rust: Target::Guest(conn) => Some(conn),
    // rust: _ => self.lan_acting,
}
    // rust: let uuid = match conn {
    // rust: Some(conn) => self
    // rust: .command_guest(conn)
    // rust: .map(|g| horizon_client::lan::playerdata::uuid_ints(g.uuid)),
    // rust: None => Some(self.level.ensure_player_uuid()),
}
    // rust: self.for_player(t, |g| {
    // rust: let mut remaining = count;
    // rust: while remaining > 0 {
    // rust: let size = remaining.min(max_stack);
    // rust: remaining -= size;
    // rust: let left = g.give(ItemStack {
    // rust: item: id.as_str().into(),
    // rust: count: size as u32,
    // rust: damage,
    // rust: extra: extra.clone(),
    // rust: });
                    // At the player who gets them.
    // rust: let p = g
    // rust: .target_position(Target::Player)
    // rust: .unwrap_or(g.source_position());
    // rust: if let Some(rest) = left {
                        // Inventory full: Player.createItemStackToDrop (thrown from
                        // the eyes), then setNoPickUpDelay and setTarget(player).
    // rust: let eye = g.eye_position().unwrap_or([
    // rust: p[0],
    // rust: p[1] + g.target_eye_height(Target::Player),
    // rust: p[2],
    // rust: ]);
    // rust: g.throw_from_eyes(rest, eye, false);
    // rust: if let Some(item) = g.just_spawned_item() {
    // rust: item.thrower = None;
    // rust: item.pickup_delay = 0;
    // rust: item.target = uuid;
}
    // rust: } else {
    // rust: let r = &mut g.world.random;
    // rust: let pitch = ((r.next_float() - r.next_float()) * 0.7 + 1.0) * 2.0;
    // rust: g.audio
    // rust: .play("minecraft:entity.item.pickup", Some(p), 0.2, pitch);
}
}
                // containerMenu.broadcastChanges: InventoryChangeTrigger
                // (and its announcement) comes before the command's message.
    // rust: if g.player.is_some() {
    // rust: g.check_inventory_trigger();
}
    // rust: });
}
        // The prototype stack: one item.
    // rust: let name = self.stack_display_name(&ItemStack {
    // rust: item: id.as_str().into(),
    // rust: count: 1,
    // rust: damage,
    // rust: extra: extra.clone(),
    // rust: });
    // rust: let message = if targets.len() == 1 {
    // rust: Text::translate(
    // rust: "commands.give.success.single",
    // rust: &[
    // rust: Text::literal(count.to_string()),
    // rust: name,
    // rust: self.target_name(targets[0]),
    // rust: ],
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "commands.give.success.multiple",
    // rust: &texts(&[
    // rust: Text::literal(count.to_string()),
    // rust: name,
    // rust: Text::literal(targets.len().to_string()),
    // rust: ]),
    // rust: )
}
    // rust: self.feedback(message);
    // rust: Ok(targets.len() as i32)
}
    // rust: fn teleport_to(
    // rust: &mut self,
    // rust: t: Target,
    // rust: pos: [f64; 3],
    // rust: rotation: Option<[f32; 2]>,
    // rust: turn_riders: bool,
    // rust: ) {
        // An entity in another level is teleported in the level that holds it.
    // rust: let _ = self.in_target_level(t, |g| g.teleport_to_in_level(t, pos, rotation, turn_riders));
}
    // rust: pub(super) fn teleport_to_in_level(
    // rust: &mut self,
    // rust: t: Target,
    // rust: pos: [f64; 3],
    // rust: rotation: Option<[f32; 2]>,
    // rust: turn_riders: bool,
    // rust: ) {
//         use super::entity::Entity;
    // rust: let from = self.target_position(t);
        // Entity.calculatePassengerTransition compares a rider's angle with the
        // vehicle's own, so the vehicle's angles are read before the teleport,
        // beside its position.
    // rust: let from_rotation = self.target_rotation(t);
    // rust: let v = Vec3::new(pos[0], pos[1], pos[2]);
        // The riders turn from the unclamped angles (calculatePassengerTransition
        // adds their offset to the transition's, each rider's own setXRot clamps).
    // rust: let requested = rotation;
        // PositionMoveRotation.calculateAbsolute clamps pitch before setXRot.
    // rust: let rotation = rotation.map(|[yaw, pitch]| [yaw, pitch.clamp(-90.0, 90.0)]);
    // rust: match t {
    // rust: Target::Guest(_) => {
    // rust: self.for_player(t, |g| {
    // rust: g.teleport_to(Target::Player, pos, rotation, turn_riders)
    // rust: });
}
    // rust: Target::Player => {
                // ServerPlayer.teleport: removeVehicle before placing the player.
    // rust: self.stop_riding();
                // A server's player teleported within their level is placed
                // there at once: the arrival they were waiting for elsewhere
                // in it (whose chunks lose their tickets) is abandoned.
    // rust: if let Some(conn) = self.lan_acting {
    // rust: self.server_trips.retain(|trip| !trip.is(conn));
}
    // rust: let from = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = v;
    // rust: p.velocity = Vec3::new(0.0, 0.0, 0.0);
    // rust: p.fall_distance = 0.0;
    // rust: p.ground.on_ground = false;
}
    // rust: self.previous_position = v;
    // rust: if let Some([yaw, pitch]) = rotation {
    // rust: if yaw.is_finite() {
    // rust: self.yaw = yaw;
}
    // rust: if !pitch.is_nan() {
    // rust: self.pitch = entity_pitch(pitch);
}
}
                // A server player's teleport is told to the mods once their
                // move is in the hub (`leave_guest`).
    // rust: if let (Some(conn), Some(uuid), Some(name), Some(from)) = (
    // rust: self.lan_acting,
    // rust: self.lan_acting_uuid,
    // rust: self.lan_acting_name.clone(),
    // rust: from,
    // rust: ) {
    // rust: self.teleport_notes
    // rust: .push(super::server_travel::TeleportNote {
    // rust: conn,
    // rust: uuid,
    // rust: name,
    // rust: from,
    // rust: to: pos,
    // rust: dimension: self.dim.id().to_owned(),
    // rust: });
}
}
    // rust: Target::Mob(id) => {
                // Entity.teleport: stopRiding() before the entity is placed,
                // which a command's transition always does (a command's
                // transition is never asPassenger). A rider moved without this
                // is seated again by the next sync, so nothing moves.
    // rust: self.dismount_mob(id);
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.position = v;
    // rust: m.previous = v;
                    // Entity.teleportSetPosition: setYRot, setYHeadRot, setXRot
                    // (clamped to -90..90), then setOldRot.
    // rust: if let Some([yaw, pitch]) = rotation {
    // rust: if yaw.is_finite() {
    // rust: m.yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: m.head_yaw = yaw;
}
    // rust: if !pitch.is_nan() {
    // rust: m.head_pitch = entity_pitch(pitch);
}
    // rust: m.previous_yaw = m.yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
}
}
}
    // rust: Target::Item(id) => {
    // rust: if let Some(i) = self.dropped.iter_mut().find(|i| i.id == id) {
    // rust: i.position = v;
    // rust: i.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(i, r);
}
}
}
    // rust: Target::Orb(id) => {
    // rust: if let Some(o) = self.orbs.iter_mut().find(|o| o.id == id) {
    // rust: o.position = v;
    // rust: o.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(o, r);
}
}
}
    // rust: Target::Projectile(id) => {
    // rust: if let Some(a) = self.creatures.projectiles.iter_mut().find(|a| a.id == id) {
    // rust: a.position = v;
    // rust: a.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(a, r);
}
}
}
    // rust: Target::Stand(id) => {
    // rust: if let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == id) {
    // rust: a.position = v;
    // rust: a.previous = v;
                    // Entity.teleport's stopRiding(), as for a mob: a stand a
                    // server seats on a vehicle (a name tag hologram) leaves it.
    // rust: a.vehicle = None;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(a, r);
}
}
}
    // rust: Target::Boat(id) => {
    // rust: if let Some(b) = self.boats.iter_mut().find(|b| b.id == id) {
    // rust: b.position = v;
    // rust: b.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(b, r);
}
}
}
    // rust: Target::Cart(id) => {
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
    // rust: c.position = v;
    // rust: c.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(c, r);
}
}
}
    // rust: Target::Fangs(id) => {
    // rust: if let Some(f) = self.fangs.list.iter_mut().find(|f| f.id == id) {
    // rust: f.pos = [v.x, v.y, v.z];
    // rust: if let Some([yaw, _]) = rotation.filter(|r| r[0].is_finite()) {
    // rust: f.yaw = yaw;
}
}
}
    // rust: Target::Other(id) => {
    // rust: if let Some(o) = self.others.iter_mut().find(|o| o.id == id) {
    // rust: o.position = v;
    // rust: if let Some([yaw, pitch]) = rotation {
    // rust: if yaw.is_finite() {
    // rust: o.yaw = yaw;
}
    // rust: if !pitch.is_nan() {
    // rust: o.pitch = entity_pitch(pitch);
}
}
}
}
    // rust: Target::Crystal(id) => {
    // rust: if let Some(c) = self.crystals.iter_mut().find(|c| c.id == id) {
    // rust: c.position = v;
}
}
    // rust: Target::Dragon(id) => {
    // rust: if let Some(d) = self.dragon.as_mut().filter(|d| d.id == id) {
    // rust: d.position = v;
    // rust: d.previous = v;
}
}
    // rust: Target::Tnt(id) => {
    // rust: if let Some(t) = self.tnts.iter_mut().find(|t| t.id == id) {
    // rust: t.position = v;
    // rust: t.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(t, r);
}
}
}
    // rust: Target::Falling(id) => {
    // rust: if let Some(f) = self.falling.iter_mut().find(|f| f.id == id) {
    // rust: f.position = v;
    // rust: f.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(f, r);
}
}
}
    // rust: Target::Rocket(id) => {
    // rust: if let Some(r) = self.rockets.iter_mut().find(|r| r.id == id) {
    // rust: r.position = v;
    // rust: r.previous = v;
    // rust: if let Some(rot) = rotation {
    // rust: Entity::set_rotation(r, rot);
}
}
}
    // rust: Target::Trident(id) => {
    // rust: if let Some(t) = self.tridents.iter_mut().find(|t| t.id == id) {
    // rust: t.position = v;
    // rust: t.previous = v;
    // rust: if let Some(r) = rotation {
    // rust: Entity::set_rotation(t, r);
}
}
}
    // rust: Target::Spawner(id) => {
    // rust: if let Some(s) = self.ominous_spawners.iter_mut().find(|s| s.id == id) {
    // rust: s.position = [v.x, v.y, v.z];
}
}
    // rust: Target::Cloud(id) => {
    // rust: if let Some(c) = self.breath_clouds.iter_mut().find(|c| c.id == id) {
    // rust: c.at = pos;
}
}
            // Wall-mounted entities do not move.
    // rust: Target::Frame(_) | Target::Painting(_) => {}
}
        // Entity.teleportSameDimension: the riders go with their vehicle at
        // once, by the offset it took and the turn it was given.
    // rust: if let (Some(from), Some(to)) = (from, self.target_position(t)) {
    // rust: let placed = requested.filter(|_| turn_riders).map(|after| {
    // rust: super::vehicle_teleport::PlacedRotation {
    // rust: before: from_rotation,
    // rust: after,
}
    // rust: });
    // rust: self.teleport_passengers(t, from, to, placed);
}
    // rust: if self.options.dedicated.is_some()
    // rust: && let (Some(entity), Some(from), Some(to)) =
    // rust: (self.network_entity_id(t), from, self.target_position(t))
    // rust: {
    // rust: self.native_entity_teleport(self.dim.id(), entity as u32, from, to);
}
}

    /// A server's player teleported into another level than theirs
    /// (ServerPlayer.teleport): queued to move after the command. False
    /// when `t` is not a player in another level.
    // rust: fn teleport_across(
    // rust: &mut self,
    // rust: t: Target,
    // rust: level: super::Dim,
    // rust: pos: [f64; 3],
    // rust: rotation: Option<[f32; 2]>,
    // rust: turn_riders: bool,
    // rust: ) -> R<bool> {
    // rust: match self.teleport_vehicle_across(t, level, pos, rotation, turn_riders) {
    // rust: Ok(true) => return Ok(true),
    // rust: Ok(false) => {}
    // rust: Err(error) => {
    // rust: log::error!("entity teleport into {}: {error}", level.id());
    // rust: return Err(err("commands.generic.exception", &[]));
}
}
    // rust: let conn = match t {
    // rust: Target::Player => self.lan_acting,
    // rust: Target::Guest(conn) => Some(conn),
    // rust: _ => None,
}
    // rust: let at = self.target_level(t);
    // rust: let Some(conn) = conn.filter(|_| at != level) else {
    // rust: return Ok(false);
}
    // rust: self.level_teleports
    // rust: .push(super::server_travel::LevelTeleport {
    // rust: conn,
    // rust: dim: level,
    // rust: at: pos,
    // rust: rotation,
    // rust: vehicle: None,
    // rust: });
    // rust: Ok(true)
}
    /// `ServerPlayer.lookAt`: besides turning the player, tell their client
    /// with a `ClientboundPlayerLookAtPacket` (`from` anchor, the point, and
    /// the entity with its anchor when the target is one). Only a connected
    /// player has a client to tell. The entity form is sent whenever the
    /// target is an entity with a network id (`LookAt.LookAtEntity.perform`);
    /// a player whose id is not known here (a guest's turn, with the host
    /// out of reach) falls back to the point, which a client takes the same
    /// unless the entity moves first.
    /// `Entity.getId` as the players' clients know it: a player's is the one the
    /// hub gave it, any other entity's is its own id.
    // rust: pub(super) fn network_entity_id(&self, t: Target) -> Option<i32> {
    // rust: let host = self.lan.as_ref();
    // rust: match t {
    // rust: Target::Player => host?.hub.guest(self.lan_acting?).map(|g| g.entity_id),
    // rust: Target::Guest(conn) => host?.hub.guest(conn).map(|g| g.entity_id),
    // rust: other => non_player_entity_id(other),
}
}
    // rust: pub(super) fn send_player_look_at(
    // rust: &mut self,
    // rust: t: Target,
    // rust: from_eyes: bool,
    // rust: target: [f64; 3],
    // rust: entity: Option<(Target, bool)>,
    // rust: ) {
    // rust: let packet = C::PlayerLookAt(play::PlayerLookAt {
    // rust: from: i32::from(from_eyes),
    // rust: target,
    // rust: entity: entity.and_then(|(e, eyes)| {
    // rust: Some(play::LookAtEntity {
    // rust: id: self.network_entity_id(e)?,
    // rust: anchor: i32::from(eyes),
    // rust: })
    // rust: }),
    // rust: });
    // rust: match t {
    // rust: Target::Player if self.lan_acting.is_some() => self.guest_packets.push(packet),
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.send_to(conn, &packet);
}
}
    // rust: _ => {}
}
}
pub fn cmd_teleport(self: *Self, id: []const u8, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let targets = if id.starts_with("teleport.targets") {
    // rust: self.entities(ctx, "targets", false)?
    // rust: } else {
    // rust: vec![
    // rust: self.source_entity()
    // rust: .ok_or_else(|| err("permissions.requires.entity", &[]))?,
    // rust: ]
}
    // rust: if id.ends_with("destination") {
    // rust: let dest = self.entities(ctx, "destination", false)?[0];
    // rust: let (pos, level, rotation, destination_name) = self
    // rust: .in_target_level(dest, |game| {
    // rust: (
    // rust: game.target_position(dest).unwrap_or(game.source_position()),
    // rust: game.target_level(dest),
    // rust: Some(game.target_rotation(dest).map(wrap_degrees)),
    // rust: game.target_name(dest),
    // rust: )
    // rust: })
    // rust: .ok_or_else(|| err("argument.entity.notfound.entity", &[]))?;
    // rust: let target_name = (targets.len() == 1).then(|| {
    // rust: self.in_target_level(targets[0], |game| game.target_name(targets[0]))
    // rust: .unwrap_or_else(Text::empty)
    // rust: });
    // rust: for &t in &targets {
    // rust: if !self.teleport_across(t, level, pos, rotation, true)? {
                    // TeleportCommand.teleportToEntity: the destination's angles,
                    // which the riders turn to as well.
    // rust: self.teleport_to(t, pos, rotation, true);
}
}
    // rust: let message = if targets.len() == 1 {
    // rust: Text::translate(
    // rust: "commands.teleport.success.entity.single",
    // rust: &[target_name.unwrap(), destination_name],
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "commands.teleport.success.entity.multiple",
    // rust: &[Text::literal(targets.len().to_string()), destination_name],
    // rust: )
}
    // rust: self.feedback(message);
    // rust: return Ok(targets.len() as i32);
}
    // rust: let pos = self
    // rust: .position_arg(ctx, "location")
    // rust: .unwrap_or(self.source_position());
    // rust: if !(-30_000_000.0..30_000_000.0).contains(&pos[0])
    // rust: || !(-30_000_000.0..30_000_000.0).contains(&pos[2])
    // rust: || !(-20_000_000.0..20_000_000.0).contains(&pos[1])
    // rust: {
    // rust: return Err(err("commands.teleport.invalidPosition", &[]));
}
    // rust: let rotation = match ctx.get("rotation") {
    // rust: Some(Arg::Coords(c @ Coordinates::World(axes))) => Some((
    // rust: c.rotation(self.source_rotation()),
    // rust: [axes[0].relative, axes[1].relative],
    // rust: )),
    // rust: _ => None,
}
        // facing: look from the new position at a location or entity.
    // rust: let facing = self.position_arg(ctx, "facingLocation").or_else(|| {
    // rust: let Some(Arg::Entity(_)) = ctx.get("facingEntity") else {
    // rust: return None;
}
    // rust: None
    // rust: });
    // rust: let mut facing_entity = None;
    // rust: let facing = match (facing, ctx.get("facingEntity")) {
    // rust: (Some(f), _) => Some(f),
    // rust: (None, Some(_)) => {
    // rust: let e = self.entities(ctx, "facingEntity", false)?[0];
                // EntityAnchorArgument.Anchor.apply: the feet, or the eyes.
    // rust: let eyes = matches!(ctx.get("facingAnchor"), Some(Arg::Anchor(true)));
    // rust: facing_entity = Some((e, eyes));
    // rust: let eye_height = if eyes { self.target_eye_height(e) } else { 0.0 };
    // rust: self.target_position(e)
    // rust: .map(|p| [p[0], p[1] + eye_height, p[2]])
}
    // rust: _ => None,
}
        // Entity.lookAt: from the source's anchor (the feet, unless `anchored
        // eyes`) on the teleported entity, so the eyes depend on the target.
    // rust: let anchored_eyes = self.command_source.is_some_and(|s| s.eyes);
    // rust: let look_at = |this: &Self, t: Target| {
    // rust: let f = facing?;
    // rust: let eye = if anchored_eyes {
    // rust: pos[1] + this.target_eye_height(t)
    // rust: } else {
    // rust: pos[1]
}
    // rust: Some(world_cmds::look_at([pos[0], eye, pos[2]], f))
}
        // A server's player in another level than the source's (`execute
        // in`, the console's Overworld) moves there (ServerPlayer.teleport
        // into another level), after the command.
    // rust: let source_level = match self.command_source.and_then(|s| s.level) {
    // rust: Some(level) => level,
    // rust: None if self.source_entity().is_none() => super::Dim::Overworld,
    // rust: None => self.dim,
}
    // rust: let target_name = (targets.len() == 1).then(|| {
    // rust: self.in_target_level(targets[0], |game| game.target_name(targets[0]))
    // rust: .unwrap_or_else(Text::empty)
    // rust: });
    // rust: for &t in &targets {
            // `facing` teleports with the rotation unchanged (Relative.ROTATION,
            // no turn for the riders), then LookAt.perform turns the target alone.
    // rust: let looked = look_at(self, t);
    // rust: let turn_riders = looked.is_none();
    // rust: let rotation = looked.or_else(|| {
    // rust: let (angles, relative) = rotation?;
    // rust: let current = self
    // rust: .in_target_level(t, |game| game.target_rotation(t))
    // rust: .unwrap_or([0.0, 0.0]);
                // performTeleport wraps relative deltas before calculateAbsolute
                // adds them back; wrapping the resolved pitch changes its clamp.
    // rust: Some(std::array::from_fn(|axis| {
    // rust: if relative[axis] {
    // rust: current[axis] + wrap_degrees(angles[axis] - current[axis])
    // rust: } else {
    // rust: wrap_degrees(angles[axis])
}
    // rust: }))
    // rust: });
    // rust: if self.teleport_across(t, source_level, pos, rotation, turn_riders)? {
    // rust: continue;
}
    // rust: self.teleport_to(t, pos, rotation, turn_riders);
            // LookAt.perform after a successful teleportTo.
    // rust: if let Some(f) = facing {
    // rust: self.send_player_look_at(t, anchored_eyes, f, facing_entity);
}
}
    // rust: let [x, y, z] = pos.map(|v| Text::literal(format_double(v)));
    // rust: let message = if targets.len() == 1 {
    // rust: Text::translate(
    // rust: "commands.teleport.success.location.single",
    // rust: &[target_name.unwrap(), x, y, z],
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "commands.teleport.success.location.multiple",
    // rust: &[Text::literal(targets.len().to_string()), x, y, z],
    // rust: )
}
    // rust: self.feedback(message);
    // rust: Ok(targets.len() as i32)
}
    /// `ServerClockManager.getInstance`: commands address clock-keyed state.
    /// Keep the existing Overworld clock tied to the world's canonical day time.
pub fn command_clock_time(self: *Self, clock: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if clock == "minecraft:overworld" {
    // rust: self.world.day_time
    // rust: } else {
    // rust: self.ui.command_clocks.get(clock).map_or(0, |c| c.0)
}
}
pub fn set_command_clock_time(self: *Self, clock: []const u8, total: i64) void {
}
    // rust: if clock == "minecraft:overworld" {
    // rust: self.world.day_time = total;
    // rust: } else {
    // rust: self.ui
    // rust: .command_clocks
    // rust: .entry(clock.to_owned())
    // rust: .or_default()
    // rust: .0 = total;
}
}
pub fn command_clock_state(self: *Self, clock: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if clock == "minecraft:overworld" {
    // rust: &mut self.ui.clock
    // rust: } else {
    // rust: &mut self
    // rust: .ui
    // rust: .command_clocks
    // rust: .entry(clock.to_owned())
    // rust: .or_default()
    // rust: .1
}
}
    /// `TimeCommand.getDefaultClock`: explicit registered clocks and dimension defaults are
    /// separate; built-in timelines and markers belong only to Overworld.
pub fn cmd_time(self: *Self, id: []const u8, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id == "time.query.gametime" {
    // rust: let t = self.world.game_time;
    // rust: self.feedback_unbroadcast(Text::tr("commands.time.query.gametime", &[&t]));
    // rust: return Ok((t % i64::from(i32::MAX)) as i32);
}
        // `time of <clock>` names the clock; otherwise the dimension's default clock.
    // rust: let clock = match ctx.get("clock") {
    // rust: Some(Arg::Resource(c)) => c.clone(),
    // rust: _ => match self.dim {
    // rust: Dim::Overworld => "minecraft:overworld".to_owned(),
    // rust: Dim::End => "minecraft:the_end".to_owned(),
    // rust: Dim::Nether => {
    // rust: return Err(err("commands.time.no_default_clock", &[&self.dim.id()]));
}
    // rust: },
}
    // rust: let total = self.command_clock_time(&clock);
    // rust: match id {
    // rust: "time.set" => {
    // rust: let t = i64::from(Self::int(ctx, "time").unwrap_or(0));
    // rust: if total == t {
    // rust: return Err(err("commands.time.set.already_at_time", &[&clock, &t]));
}
    // rust: let mut cancel = false;
    // rust: self.native_time_skip(self.dim.id(), total, t, "command", &mut cancel);
    // rust: if !cancel {
    // rust: self.set_command_clock_time(&clock, t);
    // rust: self.command_clock_state(&clock).partial = 0.0;
}
    // rust: self.feedback(Text::tr("commands.time.set.absolute", &[&clock, &t]));
    // rust: Ok(t as i32)
}
    // rust: "time.set.marker" => {
    // rust: let Some(Arg::Resource(marker)) = ctx.get("timemarker").cloned() else {
    // rust: return Ok(0);
}
    // rust: let Some(m) = (clock == "minecraft:overworld")
    // rust: .then(|| self.ui.markers.get(&marker).copied())
    // rust: .flatten()
    // rust: else {
    // rust: return Err(err(
    // rust: "commands.time.no_time_marker_found",
    // rust: &[&marker, &clock],
    // rust: ));
}
    // rust: if m.occurs_at(total) {
    // rust: return Err(err(
    // rust: "commands.time.set.already_at_time_marker",
    // rust: &[&clock, &marker],
    // rust: ));
}
    // rust: let target = m.resolve(total);
    // rust: let mut cancel = false;
    // rust: self.native_time_skip(self.dim.id(), total, target, "command", &mut cancel);
    // rust: if !cancel {
    // rust: self.set_command_clock_time(&clock, target);
    // rust: self.command_clock_state(&clock).partial = 0.0;
}
    // rust: self.feedback(Text::tr(
    // rust: "commands.time.set.time_marker",
    // rust: &[&clock, &marker],
    // rust: ));
    // rust: Ok((self.command_clock_time(&clock) % i64::from(i32::MAX)) as i32)
}
    // rust: "time.add" => {
    // rust: let t = i64::from(Self::int(ctx, "time").unwrap_or(0));
    // rust: let target = (total + t).max(0);
    // rust: let mut cancel = false;
    // rust: self.native_time_skip(self.dim.id(), total, target, "command", &mut cancel);
    // rust: if !cancel {
    // rust: self.set_command_clock_time(&clock, target);
}
    // rust: let now = self.command_clock_time(&clock);
    // rust: self.feedback(Text::tr("commands.time.set.absolute", &[&clock, &now]));
    // rust: Ok((now % i64::from(i32::MAX)) as i32)
}
    // rust: "time.pause" | "time.resume" => {
    // rust: let pause = id == "time.pause";
    // rust: if self.command_clock_state(&clock).paused == pause {
    // rust: return Err(err(
    // rust: if pause {
    // rust: "commands.time.pause.already_paused"
    // rust: } else {
    // rust: "commands.time.pause.already_running"
    // rust: },
    // rust: &[&clock],
    // rust: ));
}
    // rust: self.command_clock_state(&clock).paused = pause;
    // rust: self.feedback(Text::tr(
    // rust: if pause {
    // rust: "commands.time.pause"
    // rust: } else {
    // rust: "commands.time.resume"
    // rust: },
    // rust: &[&clock],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "time.rate" => {
    // rust: let rate = match ctx.get("rate") {
    // rust: Some(Arg::Float(r)) => *r,
    // rust: _ => 1.0,
}
    // rust: if self.command_clock_state(&clock).rate == rate {
    // rust: return Err(err(
    // rust: "commands.time.rate.already_same",
    // rust: &[&clock, &java_float(f64::from(rate))],
    // rust: ));
}
    // rust: self.command_clock_state(&clock).rate = rate;
    // rust: self.feedback(Text::tr(
    // rust: "commands.time.rate",
    // rust: &[&clock, &java_float(f64::from(rate))],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "time.query.time" => {
    // rust: self.feedback_unbroadcast(Text::tr(
    // rust: "commands.time.query.absolute",
    // rust: &[&clock, &total],
    // rust: ));
    // rust: Ok((total % i64::from(i32::MAX)) as i32)
}
    // rust: "time.query.timeline" | "time.query.repetition" => {
    // rust: let Some(Arg::Resource(timeline)) = ctx.get("timeline").cloned() else {
    // rust: return Ok(0);
}
    // rust: let Some(period) = (clock == "minecraft:overworld")
    // rust: .then(|| self.ui.timelines.get(&timeline).copied())
    // rust: .flatten()
    // rust: else {
    // rust: return Err(err(
    // rust: "commands.time.wrong_timeline_for_clock",
    // rust: &[&timeline, &clock],
    // rust: ));
}
    // rust: if id == "time.query.timeline" {
    // rust: let ticks = period.map_or(total, |p| total.rem_euclid(p));
    // rust: self.feedback_unbroadcast(Text::tr(
    // rust: "commands.time.query.timeline",
    // rust: &[&timeline, &ticks],
    // rust: ));
    // rust: Ok(ticks as i32)
    // rust: } else {
    // rust: let reps = period.map_or(0, |p| total / p);
    // rust: self.feedback_unbroadcast(Text::tr(
    // rust: "commands.time.query.timeline.repetitions",
    // rust: &[&timeline, &reps],
    // rust: ));
    // rust: Ok(reps as i32)
}
}
    // rust: _ => Ok(0),
}
}
pub fn cmd_weather(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let duration = Self::int(ctx, "duration");
    // rust: let sample = |min: i32, max: i32, r: &mut horizon_core::random::LegacyRandom| {
    // rust: min + r.next_int_bound(max - min + 1).unwrap_or(0)
}
    // rust: let (key, clear, time, raining, thundering) = if ctx.has("clear") {
    // rust: (
    // rust: "commands.weather.set.clear",
    // rust: duration.unwrap_or_else(|| sample(12_000, 180_000, &mut self.world.random)),
    // rust: 0,
    // rust: false,
    // rust: false,
    // rust: )
    // rust: } else if ctx.has("rain") {
    // rust: (
    // rust: "commands.weather.set.rain",
    // rust: 0,
    // rust: duration.unwrap_or_else(|| sample(12_000, 24_000, &mut self.world.random)),
    // rust: true,
    // rust: false,
    // rust: )
    // rust: } else {
    // rust: (
    // rust: "commands.weather.set.thunder",
    // rust: 0,
    // rust: duration.unwrap_or_else(|| sample(3_600, 15_600, &mut self.world.random)),
    // rust: true,
    // rust: true,
    // rust: )
}
    // rust: let previous = (
    // rust: self.world.weather.clear_time,
    // rust: self.world.weather.rain_time,
    // rust: self.world.weather.thunder_time,
    // rust: self.world.weather.raining,
    // rust: self.world.weather.thundering,
    // rust: );
    // rust: let mut cancel = false;
    // rust: self.native_weather_change(self.dim.id(), raining, thundering, &mut cancel);
    // rust: let old_thundering = self.world.weather.thundering;
    // rust: let old_thunder_time = self.world.weather.thunder_time;
    // rust: let mut cancel_thunder = false;
    // rust: self.native_thunder_change(self.dim.id(), thundering, &mut cancel_thunder);
    // rust: if cancel {
    // rust: let w = &mut self.world.weather;
    // rust: (
    // rust: w.clear_time,
    // rust: w.rain_time,
    // rust: w.thunder_time,
    // rust: w.raining,
    // rust: w.thundering,
    // rust: ) = previous;
    // rust: } else {
            // ServerLevel.setWeatherParameters.
    // rust: let w = &mut self.world.weather;
    // rust: w.clear_time = clear;
    // rust: w.rain_time = time;
    // rust: w.thunder_time = time;
    // rust: w.raining = raining;
    // rust: w.thundering = thundering;
    // rust: if cancel_thunder {
    // rust: w.thunder_time = old_thunder_time;
    // rust: w.thundering = old_thundering;
}
}
    // rust: self.feedback(Text::translate(key, &[]));
    // rust: Ok(duration.unwrap_or(-1))
}
    // rust: pub(super) fn kill_target(&mut self, t: Target) {
        // An entity in another level is killed in the level that holds it.
    // rust: let _ = self.in_target_level(t, |g| g.kill_target_in_level(t));
}
pub fn kill_target_in_level(self: *Self, t: Target) void {
}
    // rust: match t {
    // rust: Target::Guest(_) => {
    // rust: self.for_player(t, |g| g.kill_target(Target::Player));
}
    // rust: Target::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: let _ = p.set_health(0.0, false);
}
    // rust: self.ui.death_cause = Some("death.attack.genericKill".into());
}
    // rust: Target::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
                    // LivingEntity.kill: a generic_kill hit of Float.MAX_VALUE,
                    // which its death message tells.
    // rust: if m.alive() {
    // rust: m.record_damage(
    // rust: horizon_client::mobs::Damage::of(
    // rust: horizon_client::mobs::DamageKind::GenericKill,
    // rust: ),
    // rust: f32::MAX,
    // rust: );
}
    // rust: m.health = 0.0;
    // rust: if m.death_time == 0 {
    // rust: m.death_time = 1;
}
}
}
    // rust: Target::Item(id) => {
    // rust: if let Some(i) = self.dropped.iter().position(|i| i.id == id) {
    // rust: self.remove_dropped(i);
}
}
    // rust: Target::Orb(id) => {
    // rust: if let Some(o) = self.orbs.iter_mut().find(|o| o.id == id) {
    // rust: o.age = u32::MAX / 2;
}
}
    // rust: Target::Projectile(id) => {
    // rust: self.creatures.projectiles.retain(|p| p.id != id);
}
    // rust: Target::Stand(id) => self.armor_stands.retain(|a| a.id != id),
    // rust: Target::Frame(id) => {
                // ItemFrame.onKilled.
    // rust: if let Some(frame) = self.item_frames.iter().find(|f| f.id == id).cloned() {
    // rust: self.remove_framed_map(&frame);
}
    // rust: self.item_frames.retain(|f| f.id != id);
}
    // rust: Target::Painting(id) => self.paintings.retain(|p| p.id != id),
    // rust: Target::Boat(id) => {
                // AbstractBoat.remove: a killed boat drops its lead.
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: self.release_vehicle_container(id);
    // rust: let b = self.boats.remove(i);
    // rust: self.boat_removed(&b);
}
}
    // rust: Target::Cart(id) => {
    // rust: self.release_vehicle_container(id);
    // rust: self.carts.retain(|c| c.id != id);
}
    // rust: Target::Other(id) => self.others.retain(|o| o.id != id),
    // rust: Target::Fangs(id) => self.fangs.list.retain(|f| f.id != id),
    // rust: Target::Crystal(id) => self.kill_crystal(id),
    // rust: Target::Dragon(id) => self.kill_dragon(id),
    // rust: Target::Tnt(id) => self.tnts.retain(|t| t.id != id),
    // rust: Target::Falling(id) => self.falling.retain(|f| f.id != id),
    // rust: Target::Rocket(id) => self.rockets.retain(|r| r.id != id),
    // rust: Target::Trident(id) => self.tridents.retain(|t| t.id != id),
    // rust: Target::Spawner(id) => self.ominous_spawners.retain(|s| s.id != id),
    // rust: Target::Cloud(id) => self.breath_clouds.retain(|c| c.id != id),
}
        // The orbs marked for removal are gone (Entity.kill removes them).
    // rust: self.orbs.retain(|o| o.age < u32::MAX / 2);
    // rust: self.native_leaves_flush();
}
pub fn cmd_kill(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let targets = if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", false)?
    // rust: } else {
    // rust: vec![self.implied_player()]
}
    // rust: let mut names: Vec<Text> = Vec::new();
    // rust: for &t in &targets {
            // The name of an entity in another level is read there.
    // rust: let name = match self.in_target_level(t, |g| g.target_name(t)) {
    // rust: Some(name) => name,
    // rust: None => self.target_name(t),
}
    // rust: names.push(name);
}
    // rust: for &t in &targets {
    // rust: self.kill_target(t);
}
    // rust: let message = if targets.len() == 1 {
    // rust: Text::translate("commands.kill.success.single", &[names[0].clone()])
    // rust: } else {
    // rust: Text::tr("commands.kill.success.multiple", &[&targets.len()])
}
    // rust: self.feedback(message);
    // rust: Ok(targets.len() as i32)
}
    /// `SummonCommand.createEntity`: Peaceful admission uses the entity-type
    /// policy for both forms, independently of the mob category.
pub fn cmd_summon(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Arg::Resource(kind)) = ctx.get("entity").cloned() else {
    // rust: return Ok(0);
}
        // ResourceArgument.getSummonableEntityType.
    // rust: if matches!(
    // rust: kind.as_str(),
    // rust: "minecraft:player" | "minecraft:fishing_bobber"
    // rust: ) {
    // rust: return Err(err("entity.not_summonable", &[&kind]));
}
    // rust: let pos = self
    // rust: .position_arg(ctx, "pos")
    // rust: .unwrap_or(self.source_position());
    // rust: let block_y = pos[1].floor() as i32;
    // rust: if !(-30_000_000.0..30_000_000.0).contains(&pos[0])
    // rust: || !(-20_000_000..20_000_000).contains(&block_y)
    // rust: || !(-30_000_000.0..30_000_000.0).contains(&pos[2])
    // rust: {
    // rust: return Err(err("commands.summon.invalidPosition", &[]));
}
    // rust: if self.ui.difficulty == 0 && !horizon_client::mobs::finalize::allowed_in_peaceful(&kind) {
    // rust: return Err(err("commands.summon.failed.peaceful", &[]));
}
    // rust: let short = kind.trim_start_matches("minecraft:").to_owned();
    // rust: if let Some(Arg::Str(nbt)) = ctx.get("nbt").cloned() {
            // With an NBT argument the entity is built from it, unfinalized.
    // rust: let before = self.spawned_mark();
    // rust: let name = match self.summon_with_nbt(&kind, pos, &nbt)? {
    // rust: Some(target) => self.target_name(target),
                // Spawned as a kind no command target stands for (primed
                // TNT, falling blocks, projectiles): its type's name.
    // rust: None if self.spawned_mark() != before => {
    // rust: Text::translate(&entity_name_key(&kind), &[])
}
    // rust: None => return Err(err("commands.summon.failed", &[])),
}
    // rust: self.feedback(Text::translate("commands.summon.success", &[name]));
    // rust: return Ok(1);
}
    // rust: let name;
    // rust: if self.res.mob_types().contains_key(&kind) {
    // rust: self.spawn_mob_spawned(&short, pos)
    // rust: .ok_or_else(|| err("commands.summon.failed.uuid", &[]))?;
    // rust: name = Text::translate(&entity_name_key(&kind), &[]);
    // rust: } else {
    // rust: match short.as_str() {
    // rust: "item" => {
                    // An item entity needs an item; vanilla spawns an empty one that despawns.
    // rust: return Err(err("commands.summon.failed", &[]));
}
    // rust: "experience_orb" => {
                    // `new ExperienceOrb(level, pos, Vec3.ZERO, 0)`, unstuck
                    // like any other orb spawn.
    // rust: let at = self.unstuck_orb(pos);
    // rust: self.next_entity += 1;
    // rust: self.orbs.push(horizon_client::entities::ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: self.next_entity,
    // rust: position: Vec3::new(at[0], at[1], at[2]),
    // rust: previous: Vec3::new(at[0], at[1], at[2]),
    // rust: velocity: Vec3::new(0.0, 0.0, 0.0),
    // rust: value: 0,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
    // rust: });
                    // tryAddFreshEntityWithPassengers refused: ERROR_DUPLICATE_UUID.
    // rust: if !self.native_joins_flush(false, self.next_entity) {
    // rust: return Err(err("commands.summon.failed.uuid", &[]));
}
    // rust: name = Text::translate("entity.minecraft.experience_orb", &[]);
}
    // rust: "lightning_bolt" => {
    // rust: let block = [
    // rust: pos[0].floor() as i32,
    // rust: pos[1].floor() as i32,
    // rust: pos[2].floor() as i32,
    // rust: ];
    // rust: if !self.lightning_strike_allowed(self.lan_acting_uuid, block, "command") {
    // rust: return Err(err("commands.summon.failed", &[]));
}
    // rust: self.spawn_bolt(pos, false);
    // rust: name = Text::translate("entity.minecraft.lightning_bolt", &[]);
}
    // rust: "end_crystal" => {
                    // EndCrystal's constructor takes an id from the entity
                    // counter, and the crystal is shown with its base.
    // rust: self.next_entity += 1;
    // rust: self.crystals.push(super::dragon::Crystal {
    // rust: id: self.next_entity,
    // rust: position: Vec3::new(pos[0], pos[1], pos[2]),
    // rust: show_bottom: true,
    // rust: time: self.world.random.next_int_bound(100_000).unwrap_or(0),
    // rust: beam: None,
    // rust: invulnerable: false,
    // rust: });
                    // tryAddFreshEntityWithPassengers refused: ERROR_DUPLICATE_UUID.
    // rust: if !self.native_joins_flush(false, self.next_entity) {
    // rust: return Err(err("commands.summon.failed.uuid", &[]));
}
    // rust: name = Text::translate("entity.minecraft.end_crystal", &[]);
}
    // rust: k if super::minecarts::CartKind::from_id(&kind).is_some() => {
    // rust: let cart_kind = super::minecarts::CartKind::from_id(&kind)
    // rust: .unwrap_or(super::minecarts::CartKind::Rideable);
    // rust: self.next_entity += 1;
    // rust: let mut cart = super::minecarts::Minecart::new(
    // rust: self.next_entity,
    // rust: cart_kind,
    // rust: Vec3::new(pos[0], pos[1], pos[2]),
    // rust: );
                    // SummonCommand.createEntity loads even an empty compound, so a
                    // spawner minecart's BaseSpawner.load runs: SpawnPotentials becomes
                    // WeightedList.of(new SpawnData()).
    // rust: if cart.spawner.is_some() {
//                         use horizon_client::mobs::spawner::{Spawner, SpawnerExt};
    // rust: let empty = horizon_world::nbt::Tag::Compound(Default::default());
    // rust: cart.spawner = Some(Box::new(Spawner::load(&empty)));
}
    // rust: let id = cart.id;
    // rust: self.carts.push(cart);
    // rust: if !self.native_joins_flush(false, id) {
    // rust: return Err(err("commands.summon.failed.uuid", &[]));
}
    // rust: name = Text::translate(&format!("entity.minecraft.{k}"), &[]);
}
                // SummonCommand.createEntity: any other type from an empty compound.
    // rust: _ => {
    // rust: let before = self.spawned_mark();
    // rust: name = match self.summon_with_nbt(&kind, pos, "{}")? {
    // rust: Some(target) => self.target_name(target),
                        // Spawned as a kind no command target stands for
                        // (primed TNT, falling blocks, projectiles).
    // rust: None if self.spawned_mark() != before => {
    // rust: Text::translate(&entity_name_key(&kind), &[])
}
    // rust: None => return Err(err("commands.summon.failed", &[])),
}
}
}
}
    // rust: self.feedback(Text::translate("commands.summon.success", &[name]));
    // rust: Ok(1)
}
    /// What changes when an entity spawns, kinds that take their id only
    /// when first tracked (primed TNT, falling blocks, projectiles)
    /// included: a summon compares it before and after.
pub fn spawned_mark(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: self.next_entity,
    // rust: self.tnts.len()
    // rust: + self.falling.len()
    // rust: + self.creatures.projectiles.len()
    // rust: + self.rockets.len()
    // rust: + self.tridents.len(),
    // rust: )
}
    /// BlockStateArgument -> registry state.
    // rust: pub(super) fn block_state(&self, b: &BlockInput) -> R<BlockStateId> {
    // rust: let state = horizon_world::chunk::BlockState {
    // rust: name: b.id.clone(),
    // rust: properties: b.properties.iter().cloned().collect(),
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .resolve(&state)
    // rust: .map_err(|_| err("argument.block.id.invalid", &[&b.id]))
}
    /// BlockPredicateArgument test.
pub fn block_matches(self: *Self, b: *BlockInput, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: block_input_matches(
    // rust: self.pack.assets.registry,
    // rust: [&self.res.items().block_tags, &self.items().block_tags],
    // rust: b,
    // rust: state,
    // rust: )
}
    /// `BlockInput.overwriteWithDefinedProperties`: restore explicit command
    /// properties after normalizing the state against neighbouring blocks.
    // rust: fn block_input_state(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: input: &BlockInput,
    // rust: state: BlockStateId,
    // rust: strict: bool,
    // rust: ) -> R<BlockStateId> {
    // rust: if strict {
    // rust: return Ok(state);
}
    // rust: let updated = self.with_level(|b, level, ticks| {
    // rust: let at = horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let updated = b.update_from_neighbour_shapes(level, ticks, at, state);
    // rust: if b.is_air(updated) { state } else { updated }
    // rust: });
    // rust: let registry = self.pack.assets.registry;
    // rust: let mut descriptor = registry
    // rust: .state(updated)
    // rust: .expect("registered block state")
    // rust: .clone();
    // rust: for (key, value) in &input.properties {
    // rust: if descriptor.properties.contains_key(key) {
    // rust: descriptor.properties.insert(key.clone(), value.clone());
}
}
    // rust: registry
    // rust: .resolve(&descriptor)
    // rust: .map_err(|_| err("argument.block.id.invalid", &[&input.id]))
}
    /// Place a state like BlockInput.place: false when nothing changed.
    // rust: pub(super) fn place_state(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: strict: bool,
    // rust: ) -> R<bool> {
    // rust: let previous = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if previous == state {
    // rust: return Ok(false);
}
        // A different block replaces the block entity (Level.setBlock).
    // rust: let (old, new) = (
    // rust: self.res.facts().get(previous).name.clone(),
    // rust: self.res.facts().get(state).name.clone(),
    // rust: );
        // The command clears the old block entity without its side effects
        // (UPDATE_SKIP_BLOCK_ENTITY_SIDEEFFECTS); the new block gets a fresh one.
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if old != new {
    // rust: self.jukebox_removed(pos);
    // rust: self.world.block_entities.remove(&key);
}
    // rust: if strict {
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(
    // rust: level,
    // rust: ticks,
    // rust: horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: state,
    // rust: horizon_world::level::flags::UPDATE_CLIENTS
    // rust: | horizon_world::level::flags::UPDATE_SKIP_ALL_SIDEEFFECTS,
    // rust: );
    // rust: });
    // rust: self.process_level_events()
    // rust: .map_err(|e| CommandError::new(Text::literal(e.to_string())))?;
    // rust: } else {
    // rust: self.level_set(pos, state)
    // rust: .map_err(|e| CommandError::new(Text::literal(e.to_string())))?;
}
        // LevelChunk.setBlockState creates it when the block, not the state, is still
        // there after onPlace: a powered hopper turns itself `enabled=false`.
    // rust: let landed = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if old != new
    // rust: && self.res.facts().get(landed).name == new
    // rust: && let Some(entity) = self.new_block_entity(&new)
    // rust: {
    // rust: self.world.block_entities.insert(key, entity);
}
    // rust: Ok(true)
}
pub fn cmd_setblock(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = self.block_pos_arg(ctx, "pos")?;
    // rust: let Some(Arg::Block(b)) = ctx.get("block").cloned() else {
    // rust: return Ok(0);
}
    // rust: let state = self.block_state(&b)?;
        // SetBlockCommand.setBlock: `ServerLevel.isDebug` fails it.
    // rust: if self.world_debug {
    // rust: return Err(err("commands.setblock.failed", &[]));
}
    // rust: let current = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if ctx.has("keep") && current != self.world.air {
    // rust: return Err(err("commands.setblock.failed", &[]));
}
        // SetBlockCommand.setBlock skips placement when destruction already
        // leaves an air state and the requested state is also air.
    // rust: let place_needed = if ctx.has("destroy") {
    // rust: self.destroy_block_dropping(pos)?;
    // rust: let remaining = self.world.block(pos[0], pos[1], pos[2]);
    // rust: !(self.res.facts().is_air(state) && self.res.facts().is_air(remaining))
    // rust: } else {
    // rust: true
}
    // rust: if place_needed {
    // rust: let state = self.block_input_state(pos, &b, state, ctx.has("strict"))?;
    // rust: let placed = self.place_state(pos, state, ctx.has("strict"))?;
    // rust: let loaded = match &b.nbt {
    // rust: Some(nbt) => self.load_block_entity_nbt(pos, nbt),
    // rust: None => false,
}
    // rust: if !placed && !loaded {
    // rust: return Err(err("commands.setblock.failed", &[]));
}
    // rust: } else if !ctx.has("strict") {
            // ServerLevel.updateNeighboursOnBlockSet still runs when placing
            // air was unnecessary. The unchanged air has no analog output or
            // removal side effects, so only its neighbours need notification.
    // rust: let remaining = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.update_neighbors_at(
    // rust: level,
    // rust: ticks,
    // rust: horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: b.block(remaining),
    // rust: );
    // rust: });
    // rust: self.process_level_events()
    // rust: .map_err(|e| CommandError::new(Text::literal(e.to_string())))?;
}
    // rust: self.feedback(Text::tr(
    // rust: "commands.setblock.success",
    // rust: &[&pos[0], &pos[1], &pos[2]],
    // rust: ));
    // rust: Ok(1)
}
    /// `Level.destroyBlock(pos, true)` through the behaviour library: the
    /// destroy event, the block's drops without a tool or breaker, then its
    /// fluid's block, the block entity spilling its contents on the way.
    // rust: pub(super) fn destroy_block_dropping(&mut self, pos: [i32; 3]) -> R<()> {
    // rust: let at = horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.destroy_block(level, ticks, at, true));
    // rust: self.process_level_events()
    // rust: .map_err(|e| CommandError::new(Text::literal(e.to_string())))
}
    /// The block entity part of `BlockInput.place`: load the block entity
    /// from the argument's tag; true when its saved data changed.
    // rust: pub(super) fn load_block_entity_nbt(&mut self, pos: [i32; 3], nbt: &str) -> bool {
//         use horizon_world::nbt::Tag;
    // rust: if self.pot_data(pos).is_some() {
    // rust: let Ok((tag, _)) = horizon_world::nbt::parse_snbt(nbt) else {
    // rust: return false;
}
    // rust: return self.set_pot_data(pos, &tag).unwrap_or(false);
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(e) = self.world.block_entities.get(&key) else {
    // rust: return false;
}
    // rust: let name = self.data_block_name(pos);
    // rust: let before = horizon_client::save::encode_block_entity(key, e, &name);
    // rust: let Ok((mut tag, _)) = horizon_world::nbt::parse_snbt(nbt) else {
    // rust: return false;
}
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: for k in ["id", "x", "y", "z"] {
    // rust: if let Some(v) = before.get(k) {
    // rust: c.insert(k.into(), v.clone());
}
}
}
    // rust: let Some((_, mut new)) = horizon_client::save::decode_block_entity(&tag) else {
    // rust: return false;
}
    // rust: let rolled = self.take_loot_table(key, &tag, &mut new);
    // rust: let after = horizon_client::save::encode_block_entity(key, &new, &name);
        // The lock is outside the model: a tag that only changes it still
        // changes the block entity.
    // rust: let lock_changed = self.world.block_lock(key) != tag.get("lock");
        // So is the custom name.
    // rust: let name_changed = self.load_block_name(key, &new, &tag);
    // rust: if after == before && !rolled && !lock_changed && !name_changed {
    // rust: return false;
}
    // rust: self.world.block_entities.insert(key, new);
    // rust: self.world.set_block_lock(key, &tag);
    // rust: self.update_spawner_display(key);
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: true
}
    /// `RandomizableContainer.unpackLootTable` for a player who opens a
    /// container: a roll the container still holds fires
    /// `player_generates_container_loot` for its table, and from then on the
    /// container saves its items, not the table.
    // rust: pub(super) fn unpack_opened_loot(&mut self, key: (i32, i32, i32), name: &str) {
    // rust: let Some(rolled) = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(key.0 >> 4, key.2 >> 4))
    // rust: .and_then(|c| c.saved.as_ref())
    // rust: .and_then(|s| s.rolled_loot.iter().find(|r| r.pos == key))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
        // The roll is still there only while the container holds exactly its items.
    // rust: let still_rolled = self
    // rust: .world
    // rust: .block_entities
    // rust: .get_mut(&key)
    // rust: .is_some_and(|entity| {
    // rust: let mut tag = horizon_client::save::encode_block_entity(key, entity, name);
    // rust: match &mut tag {
    // rust: horizon_world::nbt::Tag::Compound(map) => rolled.restore(map),
    // rust: _ => false,
}
    // rust: });
    // rust: if still_rolled {
    // rust: self.trigger_loot_table(&rolled.table);
}
    // rust: let Some(chunk) = self.world.chunks.get_mut(&(key.0 >> 4, key.2 >> 4)) else {
    // rust: return;
}
    // rust: let chunk = std::sync::Arc::make_mut(chunk);
    // rust: let mut extras = chunk
    // rust: .saved
    // rust: .take()
    // rust: .map(std::sync::Arc::unwrap_or_clone)
    // rust: .unwrap_or_default();
    // rust: horizon_client::save::consume_container_loot(&mut extras, key);
    // rust: chunk.saved = Some(std::sync::Arc::new(extras));
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
}
    /// RandomizableContainer.tryLoadLootTable for a tag a command gives a
    /// container (`setblock`, `data`): an empty container with a `LootTable`
    /// is rolled now, as a loaded chunk's are (`save::roll_loaded_loot`), and
    /// the roll is kept with its chunk, so that the container saves, and
    /// `data get` shows, its table and seed until its items change. A tag
    /// without one drops what the container had. True when it had a table.
    // rust: pub(super) fn take_loot_table(
    // rust: &mut self,
    // rust: key: (i32, i32, i32),
    // rust: tag: &horizon_world::nbt::Tag,
    // rust: entity: &mut horizon_client::containers::BlockEntity,
    // rust: ) -> bool {
//         use horizon_client::{containers::BlockEntity, save, structure_blocks};
    // rust: let table = save::text(tag.get("LootTable"))
    // rust: .and_then(|id| horizon_client_core::identifier::normalize_id(&id));
    // rust: let rolled = match (table, entity) {
    // rust: (Some(table), BlockEntity::Chest(slots)) if slots.iter().all(Option::is_none) => {
    // rust: let loot = structure_blocks::loot_data(&self.options.resources, &self.pack_files());
    // rust: let at = Vec3::new(f64::from(key.0), f64::from(key.1), f64::from(key.2));
    // rust: let biome = self.biome_name_at(at).unwrap_or_default();
    // rust: Some(structure_blocks::roll_container(
    // rust: slots,
    // rust: loot.as_deref(),
    // rust: table,
    // rust: structure_blocks::loot_seed(tag),
    // rust: key,
    // rust: &biome,
    // rust: ))
}
    // rust: _ => None,
}
    // rust: let Some(chunk) = self.world.chunks.get_mut(&(key.0 >> 4, key.2 >> 4)) else {
    // rust: return false;
}
    // rust: let held = |c: &horizon_client::chunk::Chunk| {
    // rust: c.saved
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.rolled_loot.iter().any(|r| r.pos == key))
}
    // rust: if rolled.is_none() && !held(chunk) {
    // rust: return false;
}
    // rust: let chunk = std::sync::Arc::make_mut(chunk);
    // rust: let mut extras = chunk
    // rust: .saved
    // rust: .take()
    // rust: .map(std::sync::Arc::unwrap_or_clone)
    // rust: .unwrap_or_default();
    // rust: save::consume_container_loot(&mut extras, key);
    // rust: let taken = rolled.is_some();
    // rust: extras.rolled_loot.extend(rolled);
    // rust: chunk.saved = Some(std::sync::Arc::new(extras));
    // rust: taken
}
    /// The loot table and seed a container still holding its roll saves
    /// (`RolledLoot::restore`), in place of its items.
    // rust: pub(super) fn restore_loot_table(
    // rust: &self,
    // rust: key: (i32, i32, i32),
    // rust: tag: &mut horizon_world::nbt::Tag,
    // rust: ) {
    // rust: let horizon_world::nbt::Tag::Compound(map) = tag else {
    // rust: return;
}
    // rust: let rolled = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(key.0 >> 4, key.2 >> 4))
    // rust: .and_then(|c| c.saved.as_ref())
    // rust: .and_then(|s| s.rolled_loot.iter().find(|r| r.pos == key));
    // rust: if let Some(r) = rolled {
    // rust: r.restore(map);
}
}
pub fn cmd_fill(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let a = self.block_pos_arg(ctx, "from")?;
    // rust: let b = self.block_pos_arg(ctx, "to")?;
    // rust: let Some(Arg::Block(block)) = ctx.get("block").cloned() else {
    // rust: return Ok(0);
}
    // rust: let filter = match ctx.get("filter") {
    // rust: Some(Arg::Block(f)) => Some(f.clone()),
    // rust: _ => None,
}
    // rust: let min = [a[0].min(b[0]), a[1].min(b[1]), a[2].min(b[2])];
    // rust: let max = [a[0].max(b[0]), a[1].max(b[1]), a[2].max(b[2])];
    // rust: let area = (0..3)
    // rust: .map(|i| i64::from(max[i] - min[i] + 1))
    // rust: .product::<i64>();
    // rust: let limit = self.ui.rules.int("max_block_modifications");
    // rust: if area > i64::from(limit) {
    // rust: return Err(err("commands.fill.toobig", &[&limit, &area]));
}
        // FillCommand.fillBlocks: `ServerLevel.isDebug` fails it.
    // rust: if self.world_debug {
    // rust: return Err(err("commands.fill.failed", &[]));
}
    // rust: let state = self.block_state(&block)?;
    // rust: let air = self.world.air;
    // rust: let (hollow, outline, destroy, strict, keep) = (
    // rust: ctx.has("hollow"),
    // rust: ctx.has("outline"),
    // rust: ctx.has("destroy"),
    // rust: ctx.has("strict"),
    // rust: ctx.has("keep"),
    // rust: );
    // rust: let mut count = 0;
        // Whether the filter takes a state, worked out once per state: a fill visits up to 32768 blocks of a handful
        // of states, and matching a tag is a name lookup.
    // rust: let mut matched: std::collections::HashMap<BlockStateId, bool> =
    // rust: std::collections::HashMap::new();
    // rust: let plain = !(destroy || hollow || outline);
    // rust: for y in min[1]..=max[1] {
    // rust: for z in min[2]..=max[2] {
    // rust: for x in min[0]..=max[0] {
    // rust: let current = self.world.block(x, y, z);
    // rust: if keep && current != air {
    // rust: continue;
}
                    // Already the block it would become: nothing to place (place_state would do nothing either).
    // rust: if plain && current == state {
    // rust: continue;
}
    // rust: if let Some(f) = &filter {
    // rust: let ok = match matched.get(&current) {
    // rust: Some(&ok) => ok,
    // rust: None => {
    // rust: let ok = self.block_matches(f, current);
    // rust: matched.insert(current, ok);
    // rust: ok
}
}
    // rust: if !ok {
    // rust: continue;
}
}
    // rust: let edge = x == min[0]
    // rust: || x == max[0]
    // rust: || y == min[1]
    // rust: || y == max[1]
    // rust: || z == min[2]
    // rust: || z == max[2];
    // rust: let mut affected = false;
    // rust: if destroy && current != air {
    // rust: self.destroy_block_dropping([x, y, z])?;
    // rust: affected = true;
}
    // rust: let target = if (outline || hollow) && !edge {
    // rust: if outline {
    // rust: if affected {
    // rust: count += 1;
}
    // rust: continue;
}
    // rust: air
    // rust: } else {
    // rust: state
}
    // rust: if self.place_state([x, y, z], target, strict)? || affected {
    // rust: count += 1;
}
}
}
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.fill.failed", &[]));
}
    // rust: self.feedback(Text::tr("commands.fill.success", &[&count]));
    // rust: Ok(count)
}
pub fn cmd_clone(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let a = self.block_pos_arg(ctx, "begin")?;
    // rust: let b = self.block_pos_arg(ctx, "end")?;
    // rust: let dest = self.block_pos_arg(ctx, "destination")?;
    // rust: let min = [a[0].min(b[0]), a[1].min(b[1]), a[2].min(b[2])];
    // rust: let max = [a[0].max(b[0]), a[1].max(b[1]), a[2].max(b[2])];
    // rust: let size = [max[0] - min[0], max[1] - min[1], max[2] - min[2]];
    // rust: let dmax = [dest[0] + size[0], dest[1] + size[1], dest[2] + size[2]];
    // rust: let overlap = (0..3).all(|i| dest[i] <= max[i] && dmax[i] >= min[i]);
    // rust: let moving = ctx.has("move");
        // Mode.canOverlap: only the normal mode refuses overlapping regions.
    // rust: if !ctx.has("force") && !moving && overlap {
    // rust: return Err(err("commands.clone.overlap", &[]));
}
    // rust: let area = (0..3).map(|i| i64::from(size[i] + 1)).product::<i64>();
    // rust: let limit = self.ui.rules.int("max_block_modifications");
    // rust: if area > i64::from(limit) {
    // rust: return Err(err("commands.clone.toobig", &[&limit, &area]));
}
    // rust: for p in [dest, dmax] {
    // rust: if !self.world.chunks.contains_key(&(p[0] >> 4, p[2] >> 4)) {
    // rust: return Err(err("argument.pos.unloaded", &[]));
}
}
        // CloneCommands.clone: the destination level being a Debug world fails it.
    // rust: if self.world_debug {
    // rust: return Err(err("commands.clone.failed", &[]));
}
    // rust: let filter = match ctx.get("filter") {
    // rust: Some(Arg::Block(f)) => Some(f.clone()),
    // rust: _ => None,
}
    // rust: let air = self.world.air;
    // rust: let masked = ctx.has("masked");
    // rust: let mut copies = Vec::new();
    // rust: for y in min[1]..=max[1] {
    // rust: for z in min[2]..=max[2] {
    // rust: for x in min[0]..=max[0] {
    // rust: let s = self.world.block(x, y, z);
    // rust: if masked && s == air {
    // rust: continue;
}
    // rust: if let Some(f) = &filter
    // rust: && !self.block_matches(f, s)
    // rust: {
    // rust: continue;
}
    // rust: copies.push((
    // rust: [x, y, z],
    // rust: [
    // rust: dest[0] + x - min[0],
    // rust: dest[1] + y - min[1],
    // rust: dest[2] + z - min[2],
    // rust: ],
    // rust: s,
    // rust: self.world.block_entities.get(&(x, y, z)).cloned(),
    // rust: self.world.block_names.get(&(x, y, z)).cloned(),
    // rust: ));
}
}
}
    // rust: if moving {
    // rust: for (from, ..) in &copies {
    // rust: self.place_state(*from, air, true)?;
}
}
    // rust: let strict = ctx.has("strict");
        // CloneCommands.clone sets every destination to a barrier first, so
        // each copied state but a barrier counts as placed.
    // rust: let barrier = self.pack.assets.registry.default_state("minecraft:barrier");
    // rust: let mut count = 0;
    // rust: for (_, to, s, entity, name) in copies {
    // rust: self.place_state(to, s, strict)?;
    // rust: if Some(s) != barrier {
    // rust: count += 1;
}
    // rust: if let Some(e) = entity {
    // rust: let key = (to[0], to[1], to[2]);
    // rust: self.world.block_entities.insert(key, e);
                // The copied tag carries the custom name.
    // rust: match name {
    // rust: Some(name) => self.world.block_names.insert(key, name),
    // rust: None => self.world.block_names.remove(&key),
}
}
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.clone.failed", &[]));
}
    // rust: self.feedback(Text::tr("commands.clone.success", &[&count]));
    // rust: Ok(count)
}
    /// Player.giveExperiencePoints including negative amounts.
    /// The caller reports the level change to the mods.
pub fn give_points(self: *Self, amount: i32) void {
}
    // rust: let e = &mut self.experience;
    // rust: let mut sound_level = None;
    // rust: e.progress += amount as f32 / horizon_client::entities::Experience::needed(e.level) as f32;
    // rust: e.total = e.total.saturating_add(amount).clamp(0, i32::MAX);
    // rust: while e.progress < 0.0 {
    // rust: let f = e.progress * horizon_client::entities::Experience::needed(e.level) as f32;
    // rust: if e.level > 0 {
    // rust: e.level -= 1;
    // rust: e.progress = 1.0 + f / horizon_client::entities::Experience::needed(e.level) as f32;
    // rust: } else {
    // rust: e.level = 0;
    // rust: e.progress = 0.0;
}
}
    // rust: while e.progress >= 1.0 {
    // rust: e.progress =
    // rust: (e.progress - 1.0) * horizon_client::entities::Experience::needed(e.level) as f32;
    // rust: e.level += 1;
    // rust: if e.level % 5 == 0 {
    // rust: sound_level.get_or_insert(e.level);
}
    // rust: e.progress /= horizon_client::entities::Experience::needed(e.level) as f32;
}
    // rust: if let Some(level) = sound_level {
    // rust: self.play_level_up(1, level);
}
}
    /// AdvancementCommands.perform / performCriterion.
pub fn cmd_advancement(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: self.load_advancements();
    // rust: let tree = self.adv.tree.clone();
    // rust: let grant = ctx.has("grant");
    // rust: let key = if grant { "grant" } else { "revoke" };
    // rust: let index = match ctx.get("advancement") {
    // rust: Some(Arg::Resource(id)) => Some(
    // rust: *tree
    // rust: .by_id
    // rust: .get(id)
    // rust: .ok_or_else(|| err("advancement.advancementNotFound", &[id]))?,
    // rust: ),
    // rust: _ => None,
}
    // rust: if let (Some(i), Some(Arg::Str(criterion))) = (index, ctx.get("criterion")) {
    // rust: let a = &tree.list[i];
    // rust: let name = super::advancements::adv_name(a);
    // rust: if !a.criteria.iter().any(|c| &c.name == criterion) {
    // rust: return Err(CommandError::new(Text::translate(
    // rust: "commands.advancement.criterionNotFound",
    // rust: &[name, Text::literal(criterion.clone())],
    // rust: )));
}
            // AdvancementCommands.performCriterion: each selected player's own turn.
    // rust: let results = self.advancement_turns(&targets, |g| {
    // rust: i32::from(if grant {
    // rust: g.grant_advancement(i, Some(criterion))
    // rust: } else {
    // rust: g.revoke_advancement(i, Some(criterion))
    // rust: })
    // rust: });
    // rust: let (who, many) = self.advancement_subject(&results);
    // rust: let to = if many { "many" } else { "one" };
    // rust: let args = [Text::literal(criterion.clone()), name, who];
    // rust: if results.iter().map(|r| r.1).sum::<i32>() == 0 {
    // rust: return Err(CommandError::new(Text::translate(
    // rust: &format!("commands.advancement.{key}.criterion.to.{to}.failure"),
    // rust: &args,
    // rust: )));
}
    // rust: self.feedback(Text::translate(
    // rust: &format!("commands.advancement.{key}.criterion.to.{to}.success"),
    // rust: &args,
    // rust: ));
    // rust: return Ok(results.iter().map(|r| r.1).sum());
}
        // getAdvancements: parents first (nearest up), the target, then
        // the subtree depth first.
    // rust: let list: Vec<usize> = match index {
    // rust: None => (0..tree.list.len()).collect(),
    // rust: Some(i) => {
    // rust: let mut out = Vec::new();
    // rust: if ctx.has("until") || ctx.has("through") {
    // rust: let mut p = tree.list[i].parent.as_ref();
    // rust: while let Some(&pi) = p.and_then(|id| tree.by_id.get(id)) {
    // rust: out.push(pi);
    // rust: p = tree.list[pi].parent.as_ref();
}
}
    // rust: out.push(i);
    // rust: if ctx.has("from") || ctx.has("through") {
    // rust: let kids = tree.children();
pub fn add(kids: *[std.ArrayList(usize)], i: usize, out: *mut std.ArrayList(usize)) void {
}
    // rust: for &c in &kids[i] {
    // rust: out.push(c);
    // rust: add(kids, c, out);
}
}
    // rust: add(&kids, i, &mut out);
}
    // rust: out
}
}
    // rust: let quiet = index.is_none();
        // AdvancementCommands.perform: Action.perform for each selected player.
    // rust: let results = self.advancement_turns(&targets, |g| {
    // rust: let was_quiet = std::mem::replace(&mut g.adv.quiet, quiet);
    // rust: let mut count = 0;
    // rust: for &i in &list {
    // rust: let changed = if grant {
    // rust: g.grant_advancement(i, None)
    // rust: } else {
    // rust: g.revoke_advancement(i, None)
}
    // rust: count += i32::from(changed);
}
    // rust: g.adv.quiet = was_quiet;
    // rust: count
    // rust: });
    // rust: let total: i32 = results.iter().map(|r| r.1).sum();
    // rust: let (who, many) = self.advancement_subject(&results);
    // rust: let to = if many { "many" } else { "one" };
    // rust: let (what, first) = if list.len() == 1 {
    // rust: ("one", super::advancements::adv_name(&tree.list[list[0]]))
    // rust: } else {
    // rust: ("many", Text::literal(list.len().to_string()))
}
    // rust: let args = [first, who];
    // rust: if total == 0 {
    // rust: return Err(CommandError::new(Text::translate(
    // rust: &format!("commands.advancement.{key}.{what}.to.{to}.failure"),
    // rust: &args,
    // rust: )));
}
    // rust: self.feedback(Text::translate(
    // rust: &format!("commands.advancement.{key}.{what}.to.{to}.success"),
    // rust: &args,
    // rust: ));
    // rust: Ok(total)
}
    /// Run `f` as each selected player's own turn and collect what it changed;
    /// a target without a turn counts as unchanged, like in `cmd_clear`.
    // rust: fn advancement_turns(
    // rust: &mut self,
    // rust: targets: &[Target],
    // rust: f: impl Fn(&mut Self) -> i32,
    // rust: ) -> Vec<(Target, i32)> {
    // rust: targets
    // rust: .iter()
    // rust: .map(|&t| (t, self.for_player(t, &f).unwrap_or(0)))
    // rust: .collect()
}
    /// The player argument of the advancement feedback: with the tracker's
    /// NON_ZERO elements on success and every element on failure, the one
    /// player's name, else the count (CommandResponseTracker.dispatch).
pub fn advancement_subject(self: *Self, results: *[(Target) void {
}
    // rust: let changed: Vec<Target> = results.iter().filter(|r| r.1 != 0).map(|r| r.0).collect();
    // rust: let picked: Vec<Target> = if changed.is_empty() {
    // rust: results.iter().map(|r| r.0).collect()
    // rust: } else {
    // rust: changed
}
    // rust: match picked.as_slice() {
    // rust: [t] => (self.target_name(*t), false),
    // rust: _ => (Text::literal(picked.len().to_string()), true),
}
}
pub fn cmd_experience(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let levels = ctx.has("levels");
    // rust: let unit = if levels { "levels" } else { "points" };
    // rust: if ctx.has("query") {
    // rust: let target = self.entities(ctx, "target", true)?[0];
            // ExperienceCommand.queryExperience: the target's own level or points.
    // rust: let value = self
    // rust: .for_player(target, |g| {
    // rust: let e = &g.experience;
    // rust: if levels {
    // rust: e.level
    // rust: } else {
    // rust: (e.progress * horizon_client::entities::Experience::needed(e.level) as f32)
    // rust: as i32
}
    // rust: })
    // rust: .unwrap_or(0);
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: &format!("commands.experience.query.{unit}"),
    // rust: &[self.target_name(target), Text::literal(value.to_string())],
    // rust: ));
    // rust: return Ok(value);
}
    // rust: let targets = self.entities(ctx, "target", true)?;
    // rust: let amount = Self::int(ctx, "amount").unwrap_or(0);
    // rust: let add = ctx.has("add");
    // rust: let op = if add { "add" } else { "set" };
        // Every target changes (a set of points can be refused for some).
    // rust: let changed: Vec<Target> = targets
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&t| {
    // rust: self.for_player(t, |g| g.change_experience(add, levels, amount)) == Some(true)
    // rust: })
    // rust: .collect();
    // rust: if changed.is_empty() {
    // rust: return Err(err("commands.experience.set.points.invalid", &[]));
}
    // rust: let (key, who) = match changed[..] {
    // rust: [only] => ("single", self.target_name(only)),
    // rust: _ => ("multiple", Text::literal(changed.len().to_string())),
}
    // rust: self.feedback(Text::translate(
    // rust: &format!("commands.experience.{op}.{unit}.success.{key}"),
    // rust: &[Text::literal(amount.to_string()), who],
    // rust: ));
    // rust: Ok(changed.len() as i32)
}
    /// ExperienceCommand's add and set on the player in place: false when
    /// the points to set do not fit the level.
pub fn change_experience(self: *Self, add: bool, levels: bool, amount: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let old_level = self.experience.level;
    // rust: if add {
    // rust: if levels {
                // Player.giveExperienceLevels handles the strict negative
                // boundary and emits the level-change hook itself.
    // rust: self.give_levels(amount);
    // rust: return true;
    // rust: } else if let Some(amount) = self.xp_change(amount) {
    // rust: self.give_points(amount);
}
    // rust: } else if levels {
    // rust: self.experience.level = amount;
    // rust: } else {
    // rust: let needed = horizon_client::entities::Experience::needed(self.experience.level);
    // rust: if amount > needed - 1 {
    // rust: return false;
}
    // rust: self.experience.progress = amount as f32 / needed as f32;
}
    // rust: self.native_player_level_changed(old_level);
    // rust: true
}
    /// `GameRules.set` as the `/gamerule` command and the management protocol call it: the rule changes, the
    /// world follows it, and a dedicated server tells the event stream (`MinecraftServer.onGameRuleChanged`
    /// tells the management protocol's clients).
    // rust: pub(super) fn set_game_rule(&mut self, rule: &gamerules::Rule, value: Value) {
    // rust: self.ui.rules.set(rule.name, value);
    // rust: self.sync_rules();
    // rust: if self.options.dedicated.is_some() {
    // rust: let (value_type, json) = match value {
    // rust: Value::Bool(b) => ("boolean", serde_json::json!(b)),
    // rust: Value::Int(i) => ("integer", serde_json::json!(i)),
}
    // rust: super::dedicated::events::record_server(
    // rust: "gamerule",
    // rust: serde_json::json!({
    // rust: "key": format!("minecraft:{}", rule.name),
    // rust: "valueType": value_type,
    // rust: "value": json,
    // rust: }),
    // rust: );
}
}
pub fn cmd_gamerule(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(name) = ctx.literals.get(1).cloned() else {
    // rust: return Ok(0);
}
    // rust: let Some(rule) = gamerules::rule(&name) else {
    // rust: return Ok(0);
}
    // rust: let current = self.ui.rules.get(rule.name).unwrap_or(rule.default);
    // rust: let value = match ctx.get("value") {
    // rust: Some(Arg::Bool(b)) => Value::Bool(*b),
    // rust: Some(Arg::Int(i)) => Value::Int(*i),
    // rust: _ => {
    // rust: self.feedback_unbroadcast(Text::tr(
    // rust: "commands.gamerule.query",
    // rust: &[&rule.name, &current],
    // rust: ));
    // rust: return Ok(match current {
    // rust: Value::Bool(b) => i32::from(b),
    // rust: Value::Int(i) => i,
    // rust: });
}
}
    // rust: if current == value {
    // rust: return Err(err("commands.gamerule.not_set", &[&rule.name, &value]));
}
    // rust: self.set_game_rule(rule, value);
    // rust: self.feedback(Text::tr("commands.gamerule.set", &[&rule.name, &value]));
    // rust: Ok(match value {
    // rust: Value::Bool(b) => i32::from(b),
    // rust: Value::Int(i) => i,
    // rust: })
}
pub fn cmd_difficulty(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = |d: u8| {
    // rust: Text::translate(
    // rust: &format!("options.difficulty.{}", DIFFICULTIES[d as usize]),
    // rust: &[],
    // rust: )
}
    // rust: let Some(i) = DIFFICULTIES.iter().position(|d| ctx.has(d)) else {
    // rust: let current = self.ui.difficulty;
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.difficulty.query",
    // rust: &[name(current)],
    // rust: ));
    // rust: return Ok(i32::from(current));
}
    // rust: let i = i as u8;
    // rust: if self.ui.difficulty == i {
    // rust: return Err(CommandError::new(Text::translate(
    // rust: "commands.difficulty.failure",
    // rust: &[name(i)],
    // rust: )));
}
    // rust: self.set_difficulty_forced(i);
    // rust: self.feedback(Text::translate("commands.difficulty.success", &[name(i)]));
    // rust: Ok(0)
}
    /// `MinecraftServer.setDifficulty(difficulty, true)`.
    // rust: pub(super) fn set_difficulty_forced(&mut self, i: u8) {
    // rust: let from = self.ui.difficulty;
    // rust: self.ui.difficulty = i;
        // The level data holds the world's difficulty: it survives the
        // reopen, so it follows the command.
    // rust: self.level.set_difficulty(i);
    // rust: self.sync_rules();
        // MinecraftServer.setDifficulty: every player, guests included, is
        // sent the new difficulty.
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub
    // rust: .broadcast(&C::ChangeDifficulty(play::ChangeDifficulty {
    // rust: difficulty: i32::from(i),
    // rust: locked: self.level.difficulty_locked,
    // rust: }));
}
    // rust: if from != i {
    // rust: let (from, to) = difficulty_names(from, i);
    // rust: self.native_difficulty_changed(from, to);
}
}
pub fn cmd_spawnpoint(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let targets = if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", true)?
    // rust: } else {
    // rust: vec![Target::Player]
}
    // rust: let pos = if ctx.get("pos").is_some() {
    // rust: self.block_pos_arg(ctx, "pos")?
    // rust: } else {
    // rust: let p = self.source_position();
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]
}
    // rust: let rot = match ctx.get("rotation") {
    // rust: Some(Arg::Coords(c)) => c.rotation(self.source_rotation()),
    // rust: _ => [0.0, 0.0],
}
    // rust: let yaw = ((rot[0] + 180.0).rem_euclid(360.0)) - 180.0;
    // rust: let pitch = rot[1].clamp(-90.0, 90.0);
        // SetSpawnCommand: a forced point in the source's level, for each target.
    // rust: let level = self.dim;
    // rust: for &t in &targets {
    // rust: self.for_player(t, |g| {
    // rust: let mut cancel = false;
    // rust: if let (Some(player), Some(name)) = (g.lan_acting_uuid, g.lan_acting_name.clone()) {
    // rust: g.native_player_spawn_point_set(
    // rust: player,
    // rust: &name,
    // rust: level.id(),
    // rust: pos,
    // rust: "command",
    // rust: &mut cancel,
    // rust: );
}
    // rust: if cancel {
    // rust: return;
}
    // rust: if level == Dim::Overworld {
    // rust: g.spawn = Some(Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ));
    // rust: g.respawn_config = None;
    // rust: } else {
    // rust: g.spawn = None;
    // rust: g.respawn_config = Some(super::respawn_anchor::RespawnConfig {
    // rust: dim: level,
    // rust: pos,
    // rust: yaw,
    // rust: forced: true,
    // rust: });
}
    // rust: });
}
    // rust: let dim = Text::literal(self.dim.id());
    // rust: let p = pos.map(|v| Text::literal(v.to_string()));
    // rust: let mut args = vec![
    // rust: p[0].clone(),
    // rust: p[1].clone(),
    // rust: p[2].clone(),
    // rust: Text::literal(java_float(f64::from(yaw))),
    // rust: Text::literal(java_float(f64::from(pitch))),
    // rust: dim,
    // rust: ];
    // rust: let key = if targets.len() == 1 {
    // rust: args.push(self.target_name(targets[0]));
    // rust: "commands.spawnpoint.success.single"
    // rust: } else {
    // rust: args.push(Text::literal(targets.len().to_string()));
    // rust: "commands.spawnpoint.success.multiple"
}
    // rust: self.feedback(Text::translate(key, &args));
    // rust: Ok(targets.len() as i32)
}
pub fn cmd_setworldspawn(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = if ctx.get("pos").is_some() {
    // rust: self.block_pos_arg(ctx, "pos")?
    // rust: } else {
    // rust: let p = self.source_position();
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]
}
    // rust: let rot = match ctx.get("rotation") {
    // rust: Some(Arg::Coords(c)) => c.rotation(self.source_rotation()),
    // rust: _ => [0.0, 0.0],
}
        // LevelData.setRespawnData: the world's spawn (level.dat `spawn`).
    // rust: let old = self.level.world_spawn.replace(pos);
    // rust: self.level.world_spawn_angle = rot;
    // rust: self.native_spawn_change(pos, rot);
        // A player whose fallback is the world spawn (no spawnpoint of its
        // own; a bed or an anchor that is gone falls back to it) respawns at
        // the new one.
    // rust: let floor = |s: Vec3| [s.x.floor() as i32, s.y.floor() as i32, s.z.floor() as i32];
    // rust: if self.spawn.map(floor) == old {
    // rust: self.spawn = Some(Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ));
}
    // rust: let args = [
    // rust: Text::literal(pos[0].to_string()),
    // rust: Text::literal(pos[1].to_string()),
    // rust: Text::literal(pos[2].to_string()),
    // rust: Text::literal(java_float(f64::from(rot[0]))),
    // rust: Text::literal(java_float(f64::from(rot[1]))),
    // rust: Text::literal(self.dim.id()),
    // rust: ];
    // rust: self.feedback(Text::translate("commands.setworldspawn.success", &args));
    // rust: Ok(1)
}
pub fn item_matches(self: *Self, predicate: *ItemInput, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if predicate.any {
    // rust: return true;
}
    // rust: if predicate.tag {
    // rust: let tag = predicate.id.trim_start_matches("minecraft:");
    // rust: return self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get(tag)
    // rust: .or_else(|| self.items().item_tags.get(&predicate.id))
    // rust: .is_some_and(|s| {
    // rust: s.contains(item) || s.contains(item.trim_start_matches("minecraft:"))
    // rust: });
}
    // rust: predicate.id == item
}
    /// `ItemPredicateArgument`: the item test and its `[...]` component
    /// tests (presence, `=` equality, `!` negation, `|` alternatives).
    // rust: pub(super) fn stack_matches(&self, predicate: &ItemInput, stack: &ItemStack) -> bool {
    // rust: if !self.item_matches(predicate, &stack.item) {
    // rust: return false;
}
    // rust: let Some(tests) = predicate.components.as_deref() else {
    // rust: return true;
}
    // rust: let inner = tests
    // rust: .trim()
    // rust: .strip_prefix('[')
    // rust: .and_then(|t| t.strip_suffix(']'))
    // rust: .unwrap_or("");
    // rust: let components = match horizon_client::item_data::encode_components(stack) {
    // rust: Some(horizon_world::nbt::Tag::Compound(c)) => c,
    // rust: _ => Default::default(),
}
    // rust: let test = |term: &str| -> bool {
    // rust: let term = term.trim();
    // rust: let (negated, term) = match term.strip_prefix('!') {
    // rust: Some(t) => (true, t.trim()),
    // rust: None => (false, term),
}
    // rust: let split = term.find(['=', '~']).unwrap_or(term.len());
    // rust: let id = term[..split].trim();
    // rust: let id = if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: let present = components.get(&id.as_str().into());
    // rust: let result = match term[split..].chars().next() {
    // rust: Some('=') => {
    // rust: let value = horizon_world::nbt::parse_snbt(term[split + 1..].trim())
    // rust: .ok()
    // rust: .map(|(t, _)| t);
    // rust: match (present, value) {
    // rust: (Some(have), Some(want)) => {
    // rust: horizon_client::nbt_path::compare_nbt(&want, Some(have))
    // rust: && horizon_client::nbt_path::compare_nbt(have, Some(&want))
}
    // rust: _ => false,
}
}
    // rust: Some('~') => {
                    // Sub-predicates: `count` and component predicates.
    // rust: let value = horizon_world::nbt::parse_snbt(term[split + 1..].trim())
    // rust: .ok()
    // rust: .map(|(t, _)| t);
    // rust: match (id.as_str(), value) {
    // rust: ("minecraft:count", Some(v)) => {
    // rust: let n = i64::from(stack.count);
    // rust: match &v {
    // rust: horizon_world::nbt::Tag::Compound(_) => {
    // rust: let get = |k: &str| match v.get(k) {
    // rust: Some(horizon_world::nbt::Tag::Int(i)) => {
    // rust: Some(i64::from(*i))
}
    // rust: _ => None,
}
    // rust: get("min").is_none_or(|m| n >= m)
    // rust: && get("max").is_none_or(|m| n <= m)
}
    // rust: horizon_world::nbt::Tag::Int(i) => n == i64::from(*i),
    // rust: _ => false,
}
}
    // rust: (_, Some(v)) => present.is_some_and(|have| {
    // rust: horizon_client::nbt_path::compare_nbt(&v, Some(have))
    // rust: }),
    // rust: _ => false,
}
}
    // rust: _ => present.is_some(),
}
    // rust: result != negated
}
    // rust: split_top_level(inner, ',')
    // rust: .iter()
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: .all(|term| split_top_level(term, '|').iter().any(|alt| test(alt)))
}
pub fn cmd_clear(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let targets = if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", true)?
    // rust: } else {
    // rust: vec![Target::Player]
}
    // rust: let predicate = match ctx.get("item") {
    // rust: Some(Arg::Item(i)) => i.clone(),
    // rust: _ => ItemInput {
    // rust: id: "*".into(),
    // rust: tag: false,
    // rust: any: true,
    // rust: components: None,
    // rust: },
}
    // rust: let max = Self::int(ctx, "maxCount").unwrap_or(-1);
    // rust: let counting = max == 0;
        // ClearInventoryCommands.clearInventory: each player on their own.
    // rust: let mut removed = 0i32;
    // rust: let mut found = Vec::new();
    // rust: for &t in &targets {
    // rust: let n = self
    // rust: .for_player(t, |g| g.clear_matching(&predicate, max))
    // rust: .unwrap_or(0);
    // rust: removed += n;
    // rust: if n != 0 {
    // rust: found.push(t);
}
}
    // rust: if removed == 0 {
    // rust: return Err(if targets.len() == 1 {
    // rust: CommandError::new(Text::translate(
    // rust: "clear.failed.single",
    // rust: &[self.target_name(targets[0])],
    // rust: ))
    // rust: } else {
    // rust: err("clear.failed.multiple", &[&targets.len()])
    // rust: });
}
    // rust: let kind = if counting { "test" } else { "success" };
    // rust: let (key, who) = match found[..] {
    // rust: [only] => ("single", self.target_name(only)),
    // rust: _ => ("multiple", Text::literal(found.len().to_string())),
}
    // rust: self.feedback(Text::translate(
    // rust: &format!("commands.clear.{kind}.{key}"),
    // rust: &[Text::literal(removed.to_string()), who],
    // rust: ));
    // rust: Ok(removed)
}
    /// Inventory.clearOrCountMatchingItems for the player in place: `max`
    /// of the matching items go (all when negative, none and only counted
    /// when 0). Returns how many matched.
pub fn clear_matching(self: *Self, predicate: *ItemInput, max: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let counting = max == 0;
        // Inventory slots 0..40: main, armor feet to head, off hand;
        // then clearOrCountMatchingItems visits the crafting grid and carried stack.
    // rust: let mut removed = 0i32;
    // rust: let mut budget = if max < 0 { i32::MAX } else { max };
    // rust: let all = |g: &Self| -> Vec<Option<ItemStack>> {
    // rust: let mut v: Vec<Option<ItemStack>> = g.inventory.clone();
    // rust: v.extend(g.armor.iter().rev().cloned());
    // rust: v.push(g.offhand.clone());
    // rust: v.extend(g.craft_grid.iter().cloned());
    // rust: v.push(g.carried.clone());
    // rust: v
}
    // rust: let matching: Vec<bool> = all(self)
    // rust: .iter()
    // rust: .map(|s| s.as_ref().is_some_and(|s| self.stack_matches(predicate, s)))
    // rust: .collect();
    // rust: let mut slots: Vec<&mut Option<ItemStack>> = Vec::new();
    // rust: slots.extend(self.inventory.iter_mut());
    // rust: slots.extend(self.armor.iter_mut().rev());
    // rust: slots.push(&mut self.offhand);
    // rust: slots.extend(self.craft_grid.iter_mut());
    // rust: slots.push(&mut self.carried);
    // rust: for (slot, matches) in slots.into_iter().zip(matching) {
    // rust: if !matches {
    // rust: continue;
}
    // rust: let Some(stack) = slot.as_mut() else { continue };
    // rust: let take = if counting {
    // rust: stack.count as i32
    // rust: } else {
    // rust: (stack.count as i32).min(budget)
}
    // rust: removed += take;
    // rust: if !counting {
    // rust: budget -= take;
    // rust: stack.count -= take as u32;
    // rust: if stack.count == 0 {
    // rust: *slot = None;
}
    // rust: if budget == 0 {
    // rust: break;
}
}
}
    // rust: removed
}
    /// `PoiTypes`: the point of interest type of a block state.
pub fn poi_type(self: *Self, state: horizon_world::registry::BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = self.pack.assets.registry.state(state)?;
    // rust: horizon_client::save::poi_type(s).map(|(kind, _)| kind)
}
    /// `LocateCommand.locatePoi`: `PoiManager.findClosestWithType` within
    /// 256 blocks of the source, over the loaded chunks.
pub fn cmd_locate_poi(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Arg::Resource(poi)) = ctx.get("poi").cloned() else {
    // rust: return Ok(0);
}
    // rust: let wanted: Vec<String> = match poi.strip_prefix('#') {
    // rust: Some(tag) => self.tag_entries("point_of_interest_type", tag),
    // rust: None => vec![poi.clone()],
}
    // rust: let from = self.source_position().map(|v| v.floor() as i32);
pub const RANGE: i32 = 256;
    // rust: let mut cache: std::collections::HashMap<u32, Option<&'static str>> =
    // rust: std::collections::HashMap::new();
    // rust: let mut best: Option<(i64, [i32; 3], &'static str)> = None;
    // rust: let (cx0, cz0) = ((from[0] - RANGE) >> 4, (from[2] - RANGE) >> 4);
    // rust: let (cx1, cz1) = ((from[0] + RANGE) >> 4, (from[2] + RANGE) >> 4);
    // rust: for cx in cx0..=cx1 {
    // rust: for cz in cz0..=cz1 {
    // rust: let Some(chunk) = self.world.chunks.get(&(cx, cz)) else {
    // rust: continue;
}
    // rust: for (i, section) in chunk.sections.iter().enumerate() {
    // rust: let mut wanted_state = |state: u32| {
    // rust: cache
    // rust: .entry(state)
    // rust: .or_insert_with(|| {
    // rust: self.poi_type(horizon_world::registry::BlockStateId(state))
    // rust: .filter(|t| wanted.iter().any(|w| w == t))
    // rust: })
    // rust: .is_some()
}
    // rust: if !section.blocks.maybe_has(&mut wanted_state) {
    // rust: continue;
}
    // rust: let base_y = self.world.bottom_y() + 16 * i as i32;
    // rust: for j in 0..4096 {
    // rust: let state = section.get(j);
    // rust: let Some(kind) = cache.get(&state).copied().flatten() else {
    // rust: continue;
}
    // rust: let p = [
    // rust: cx * 16 + (j & 15) as i32,
    // rust: base_y + (j >> 8) as i32,
    // rust: cz * 16 + ((j >> 4) & 15) as i32,
    // rust: ];
    // rust: let d = [p[0] - from[0], p[1] - from[1], p[2] - from[2]]
    // rust: .map(|d| i64::from(d) * i64::from(d))
    // rust: .iter()
    // rust: .sum::<i64>();
    // rust: if d <= i64::from(RANGE * RANGE) && best.is_none_or(|(b, _, _)| d < b) {
    // rust: best = Some((d, p, kind));
}
}
}
}
}
    // rust: let Some((_, p, kind)) = best else {
    // rust: return Err(CommandError::new(Text::tr(
    // rust: "commands.locate.poi.not_found",
    // rust: &[&poi],
    // rust: )));
}
    // rust: let link = Text::teleport_link(p[0], None, p[2]);
    // rust: let (dx, dz) = (p[0] - from[0], p[2] - from[2]);
    // rust: let distance = ((dx * dx + dz * dz) as f32).sqrt().floor() as i32;
    // rust: let shown = if poi.starts_with('#') {
    // rust: format!("{poi} ({kind})")
    // rust: } else {
    // rust: poi
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.locate.poi.success",
    // rust: &[
    // rust: Text::literal(shown),
    // rust: link,
    // rust: Text::literal(distance.to_string()),
    // rust: ],
    // rust: ));
    // rust: Ok(distance)
}
pub fn cmd_locate(self: *Self, id: []const u8, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let origin = self.source_position();
    // rust: if id == "locate.biome" {
    // rust: let Some(Arg::Resource(biome)) = ctx.get("biome").cloned() else {
    // rust: return Ok(0);
}
            // LocateCommand.locateBiome: BiomeSource.findClosestBiome3d with
            // a 6400-block radius, 32-block columns and 64-block layers.
    // rust: let from = origin.map(|v| v.floor() as i32);
    // rust: let allowed = |name: &str| self.biome_matches(&biome, name);
    // rust: let search = horizon_world::worldgen::generator::BiomeSearch {
    // rust: allowed: &allowed,
    // rust: origin: from,
    // rust: radius: 6400,
    // rust: horizontal: 32,
    // rust: vertical: 64,
    // rust: min_y: self.world.bottom_y(),
    // rust: max_y: self.world.top_y() - 1,
}
    // rust: let found = self
    // rust: .end
    // rust: .locator()
    // rust: .and_then(|t| t.find_closest_biome(&search));
    // rust: let Some((name, p)) = found else {
    // rust: return Err(CommandError::new(Text::tr(
    // rust: "commands.locate.biome.not_found",
    // rust: &[&biome],
    // rust: )));
}
    // rust: let d2 = [p[0] - from[0], p[1] - from[1], p[2] - from[2]]
    // rust: .map(|d| f64::from(d) * f64::from(d))
    // rust: .iter()
    // rust: .sum::<f64>();
    // rust: let shown = if biome.starts_with('#') {
    // rust: format!("{biome} ({name})")
    // rust: } else {
    // rust: biome.clone()
}
    // rust: let link = Text::teleport_link(p[0], Some(p[1]), p[2]);
    // rust: let distance = (d2 as f32).sqrt().floor() as i32;
    // rust: self.feedback(Text::translate(
    // rust: "commands.locate.biome.success",
    // rust: &[
    // rust: Text::literal(shown),
    // rust: link,
    // rust: Text::literal(distance.to_string()),
    // rust: ],
    // rust: ));
    // rust: return Ok(distance);
}
    // rust: let Some(Arg::Resource(s)) = ctx.get("structure").cloned() else {
    // rust: return Ok(0);
}
        // LocateCommand.locateStructure: an id or a #tag of structures.
    // rust: let names = match s.strip_prefix('#') {
    // rust: Some(tag) => self.structure_tag(tag),
    // rust: None => vec![s.clone()],
}
    // rust: let from = origin.map(|v| v.floor() as i32);
    // rust: let found = self.end.locator().and_then(|t| t.locate(&names, from, 100));
    // rust: let Some((name, p)) = found else {
    // rust: return Err(CommandError::new(Text::tr(
    // rust: "commands.locate.structure.not_found",
    // rust: &[&s],
    // rust: )));
}
    // rust: let link = Text::teleport_link(p[0], None, p[2]);
    // rust: let (dx, dz) = (f64::from(p[0] - from[0]), f64::from(p[2] - from[2]));
    // rust: let distance = (dx * dx + dz * dz).sqrt().floor() as i32;
    // rust: let shown = if s.starts_with('#') {
    // rust: format!("{s} ({name})")
    // rust: } else {
    // rust: name
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.locate.structure.success",
    // rust: &[
    // rust: Text::literal(shown),
    // rust: link,
    // rust: Text::literal(distance.to_string()),
    // rust: ],
    // rust: ));
    // rust: Ok(distance)
}
    /// The structures of a `worldgen/structure` tag, nested tags expanded.
    // rust: pub(super) fn structure_tag(&self, tag: &str) -> Vec<String> {
    // rust: self.tag_entries("worldgen/structure", tag)
}
    /// The entries of a data pack tag of `registry`, nested tags expanded.
    // rust: pub(super) fn tag_entries(&self, registry: &str, tag: &str) -> Vec<String> {
    // rust: let mut out = Vec::new();
    // rust: let mut pending = vec![tag.to_owned()];
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: while let Some(t) = pending.pop() {
    // rust: if !seen.insert(t.clone()) {
    // rust: continue;
}
    // rust: let (ns, path) = t.split_once(':').unwrap_or(("minecraft", &t));
    // rust: let file = self
    // rust: .options
    // rust: .resources
    // rust: .join(format!("data/{ns}/tags/{registry}/{path}.json"));
            // The game's file and the world's packs' both count, entries
            // joined in resource-stack order; a pack file with `replace`
            // drops what the lower sources put in (`TagLoader.load`).
    // rust: let packed = self
    // rust: .fns
    // rust: .store
    // rust: .files
    // rust: .get(&format!("tags/{ns}:{registry}/{path}"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|b| serde_json::from_slice::<serde_json::Value>(b).ok());
    // rust: let parsed = std::fs::read(file)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok())
    // rust: .into_iter()
    // rust: .chain(packed);
    // rust: let mut entries = Vec::new();
    // rust: for v in parsed {
    // rust: if v["replace"].as_bool() == Some(true) {
    // rust: entries.clear();
}
    // rust: entries.extend(v["values"].as_array().into_iter().flatten().cloned());
}
    // rust: for e in &entries {
    // rust: let id = e.as_str().or_else(|| e["id"].as_str()).unwrap_or_default();
    // rust: match id.strip_prefix('#') {
    // rust: Some(nested) => pending.push(nested.to_owned()),
    // rust: None if !id.is_empty() => out.push(id.to_owned()),
    // rust: None => {}
}
}
}
    // rust: out
}
    /// ListPlayersCommand: every online player in join order (a single-player
    /// owner is one of them), with the count and the max.
pub fn cmd_list(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let players: Vec<(u128, String)> = self
    // rust: .lan
    // rust: .iter()
    // rust: .flat_map(|h| h.hub.guests.iter())
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| (g.uuid, g.name.clone()))
    // rust: .collect();
    // rust: let max = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(horizon_client::lan::MAX_PLAYERS, |h| {
    // rust: h.hub.lan.shared.max_players()
    // rust: });
    // rust: let uuids = ctx.has("uuids");
    // rust: let mut names = Text::empty();
    // rust: for (k, (uuid, name)) in players.iter().enumerate() {
    // rust: if k > 0 {
                // ComponentUtils.formatList: gray commas.
    // rust: names.push(Text::colored(", ", text::GRAY));
}
    // rust: if uuids {
    // rust: names.push(Text::translate(
    // rust: "commands.list.nameAndId",
    // rust: &[
    // rust: Text::literal(name.as_str()),
    // rust: Text::literal(horizon_protocol::crypto::uuid_string(*uuid)),
    // rust: ],
    // rust: ));
    // rust: } else {
    // rust: names.push(self.player_text(name, *uuid));
}
}
    // rust: let count = players.len();
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.list.players",
    // rust: &[
    // rust: Text::literal(count.to_string()),
    // rust: Text::literal(max.to_string()),
    // rust: names,
    // rust: ],
    // rust: ));
    // rust: Ok(count as i32)
}
pub fn cmd_say(self: *Self, id: []const u8, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw = match ctx.get(if id == "me" { "action" } else { "message" }) {
    // rust: Some(Arg::Str(s)) => s.clone(),
    // rust: _ => String::new(),
}
    // rust: let message = self.expand_selectors(&raw);
        // CommandSourceStack.getDisplayName: the executing entity's name.
    // rust: let name = match self.command_source.map(|s| s.entity) {
    // rust: Some(Some(t)) => self.target_name(t),
    // rust: Some(None) => Text::literal("Server"),
    // rust: None => self.player_display_name(),
}
    // rust: let line = match id {
    // rust: "say" => Text::translate("chat.type.announcement", &[name, message]),
    // rust: "me" => Text::translate("chat.type.emote", &[name, message]),
    // rust: _ => {
    // rust: let _ = self.entities(ctx, "targets", true)?;
                // Whispering to yourself: the incoming and outgoing lines.
    // rust: let out = Text::translate(
    // rust: "commands.message.display.outgoing",
    // rust: &[self.player_display_name(), message.clone()],
    // rust: )
    // rust: .with_color(text::GRAY)
    // rust: .italic();
    // rust: self.system_message(out);
    // rust: Text::translate(
    // rust: "commands.message.display.incoming",
    // rust: &[self.player_display_name(), message],
    // rust: )
    // rust: .with_color(text::GRAY)
    // rust: .italic()
}
}
    // rust: if let Some(capture) = self.chat_capture.as_mut() {
    // rust: capture.push(line.clone());
}
    // rust: let focused = self.screen == Screen::Chat;
    // rust: self.ui.chat.add(
    // rust: &self.gui.atlas,
    // rust: line,
    // rust: None,
    // rust: horizon_client::chat::ChatSource::Player,
    // rust: self.visual_ticks(),
    // rust: focused,
    // rust: );
    // rust: Ok(1)
}
    /// MessageArgument: `@p`-style selectors in a message become names.
    // rust: pub(super) fn expand_selectors(&mut self, raw: &str) -> Text {
    // rust: let mut out = Text::empty();
    // rust: let mut rest = raw;
    // rust: while let Some(at) = rest.find('@') {
    // rust: out.push(&rest[..at]);
    // rust: let mut reader = Reader::new(&rest[at..]);
    // rust: match (horizon_client::command::ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
    // rust: })
    // rust: .parse(&mut reader, &self.ui.registries)
    // rust: {
    // rust: Ok(Arg::Entity(s)) if reader.cursor > 1 => {
    // rust: let found = self.select(&s);
    // rust: for (i, t) in found.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(", ");
}
    // rust: out.push(self.target_name(*t));
}
    // rust: rest = &rest[at + reader.cursor..];
}
    // rust: _ => {
    // rust: out.push("@");
    // rust: rest = &rest[at + 1..];
}
}
}
    // rust: out.push(rest);
    // rust: out
}
}

/// Split at a separator outside brackets, braces and quotes.
pub fn split_top_level(s: []const u8, sep: char) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let (mut depth, mut quote, mut escaped, mut start) = (0i32, None::<char>, false, 0);
    // rust: for (i, ch) in s.char_indices() {
    // rust: if let Some(q) = quote {
    // rust: if escaped {
    // rust: escaped = false;
    // rust: } else if ch == '\\' {
    // rust: escaped = true;
    // rust: } else if ch == q {
    // rust: quote = None;
}
    // rust: continue;
}
    // rust: match ch {
    // rust: '"' | '\'' => quote = Some(ch),
    // rust: '[' | '{' => depth += 1,
    // rust: ']' | '}' => depth -= 1,
    // rust: c if c == sep && depth == 0 => {
    // rust: out.push(&s[start..i]);
    // rust: start = i + ch.len_utf8();
}
    // rust: _ => {}
}
}
    // rust: out.push(&s[start..]);
    // rust: out
}

/// BlockPredicateArgument test, against the registry and the block tags:
/// a `#tag` is looked up by its path in `tags[0]`, then by its whole id in
/// `tags[1]` (as `Game::block_matches` reads them).
    // rust: pub(super) fn block_input_matches(
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: tags: [&std::collections::HashMap<String, std::collections::HashSet<String>>; 2],
    // rust: b: &BlockInput,
    // rust: state: BlockStateId,
    // rust: ) -> bool {
    // rust: let Some(s) = registry.state(state) else {
    // rust: return false;
}
    // rust: let name_ok = if b.tag {
    // rust: let tag = b.id.trim_start_matches("minecraft:");
    // rust: tags[0]
    // rust: .get(tag)
    // rust: .or_else(|| tags[1].get(&b.id))
    // rust: .is_some_and(|set| {
    // rust: set.contains(&s.name) || set.contains(s.name.trim_start_matches("minecraft:"))
    // rust: })
    // rust: } else {
    // rust: s.name == b.id
}
    // rust: name_ok
    // rust: && b.properties
    // rust: .iter()
    // rust: .all(|(k, v)| s.properties.get(k) == Some(v))
}

/// The names `native_difficulty_changed` hears for a change from `from` to
/// `to`: the four difficulties of `options.difficulty.*`, the index kept in
/// range as the command and the options keep it.
pub fn difficulty_names(from: u8, to: u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: DIFFICULTIES[usize::from(from) & 3],
    // rust: DIFFICULTIES[usize::from(to) & 3],
    // rust: )
}

    // rust: mod teleport_pitch_tests {
pub fn teleport_and_rotate_resolve_pitch_at_their_own_boundary() void {
}
//         use super::Target;
//         use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let kind = game
    // rust: .res
    // rust: .mob_types()
    // rust: .get("minecraft:zombie")
    // rust: .unwrap()
    // rust: .clone();
    // rust: game.mobs.push(horizon_client::mobs::Mob::new(
    // rust: 42,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.0, 0.0, 0.0),
    // rust: 0.0,
    // rust: ));
    // rust: for (rotation, expected) in [
    // rust: ([40.0, f32::NAN], [40.0, 20.0]),
    // rust: ([f32::INFINITY, 30.0], [10.0, 30.0]),
    // rust: ([40.0, f32::INFINITY], [40.0, 90.0]),
    // rust: ([40.0, f32::NEG_INFINITY], [40.0, -90.0]),
    // rust: ] {
    // rust: game.yaw = 10.0;
    // rust: game.pitch = 20.0;
    // rust: game.teleport_to_in_level(Target::Player, [0.0; 3], Some(rotation), true);
    // rust: assert_eq!([game.yaw, game.pitch], expected);
    // rust: game.mobs[0].yaw = 10.0;
    // rust: game.mobs[0].head_pitch = 20.0;
    // rust: game.teleport_to_in_level(Target::Mob(42), [0.0; 3], Some(rotation), true);
    // rust: assert_eq!([game.mobs[0].yaw, game.mobs[0].head_pitch], expected);
}
    // rust: game.build_registries();
    // rust: game.set_allow_commands(true);
    // rust: for (command, expected) in [
    // rust: ("rotate @e[type=minecraft:zombie,limit=1] 0 360", 90.0),
    // rust: ("tp @e[type=minecraft:zombie,limit=1] 0 0 0 0 360", 0.0),
    // rust: ("tp @e[type=minecraft:zombie,limit=1] 0 0 0 0 270", -90.0),
    // rust: ] {
    // rust: assert!(game.run_command(command), "{command}");
    // rust: assert_eq!(game.mobs[0].head_pitch, expected, "{command}");
}
    // rust: for (source, target, angle, expected) in [
    // rust: (90.0, 90.0, "~100", 90.0),
    // rust: (-90.0, -90.0, "~-100", -90.0),
    // rust: (0.0, -90.0, "~100", -90.0),
    // rust: (0.0, 90.0, "~-100", 90.0),
    // rust: ] {
    // rust: game.pitch = source;
    // rust: game.mobs[0].head_pitch = target;
    // rust: assert!(game.run_command(&format!(
    // rust: "tp @e[type=minecraft:zombie,limit=1] 0 0 0 0 {angle}"
    // rust: )));
    // rust: assert_eq!(game.mobs[0].head_pitch, expected);
}
    // rust: game.yaw = 190.0;
    // rust: game.mobs[0].yaw = 170.0;
    // rust: assert!(game.run_command("tp @e[type=minecraft:zombie,limit=1] 0 0 0 ~ ~"));
    // rust: assert_eq!(game.mobs[0].yaw, 190.0, "relative yaw wraps the delta");

    // rust: game.mobs[0].head_pitch = 360.0;
    // rust: assert!(
    // rust: game.run_command(
    // rust: "tp @e[type=minecraft:zombie,limit=1] @e[type=minecraft:zombie,limit=1]"
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: game.mobs[0].head_pitch, 0.0,
    // rust: "destination rotation wraps too"
    // rust: );

    // rust: let overflow = "9".repeat(400);
    // rust: for (pitch, expected) in [(overflow.clone(), 90.0), (format!("-{overflow}"), -90.0)] {
    // rust: assert!(game.run_command(&format!(
    // rust: "rotate @e[type=minecraft:zombie,limit=1] 0 {pitch}"
    // rust: )));
    // rust: assert_eq!(game.mobs[0].head_pitch, expected);
}
    // rust: for (yaw, pitch, expected) in [
    // rust: ("40", overflow.as_str(), [40.0, 20.0]),
    // rust: (overflow.as_str(), "30", [10.0, 30.0]),
    // rust: ] {
    // rust: game.mobs[0].yaw = 10.0;
    // rust: game.mobs[0].head_pitch = 20.0;
    // rust: assert!(game.run_command(&format!(
    // rust: "tp @e[type=minecraft:zombie,limit=1] 0 0 0 {yaw} {pitch}"
    // rust: )));
    // rust: assert_eq!([game.mobs[0].yaw, game.mobs[0].head_pitch], expected);
}
}

pub fn pitch_wraps_before_clamping() void {
}
    // rust: assert_eq!(super::entity_pitch(360.0), 0.0);
    // rust: assert_eq!(super::entity_pitch(450.0), 90.0);
    // rust: assert_eq!(super::entity_pitch(-360.0), 0.0);
    // rust: assert_eq!(super::entity_pitch(-450.0), -90.0);
    // rust: assert_eq!(super::entity_pitch(super::wrap_degrees(270.0)), -90.0);
    // rust: assert_eq!(super::entity_pitch(super::wrap_degrees(-270.0)), 90.0);
    // rust: assert_eq!(super::entity_pitch(super::wrap_degrees(360.0)), 0.0);
    // rust: assert_eq!(super::entity_pitch(super::wrap_degrees(450.0)), 90.0);
    // rust: assert_eq!(super::wrap_degrees(190.0), -170.0);
    // rust: assert_eq!(super::wrap_degrees(540.0), -180.0);
}
}

    // rust: mod difficulty_tests {
//     use super::difficulty_names;

pub fn a_difficulty_change_names_both_ends() void {
}
    // rust: assert_eq!(difficulty_names(0, 3), ("peaceful", "hard"));
    // rust: assert_eq!(difficulty_names(2, 1), ("normal", "easy"));
        // The four difficulties are the only indexes the command and the
        // options keep; an index outside them still names one.
    // rust: assert_eq!(difficulty_names(7, 4), ("hard", "peaceful"));
}
}

    // rust: mod summon_tests {
pub fn a_summoned_entity_is_named_from_its_own_namespace() void {
}
//         use super::entity_name_key;
    // rust: assert_eq!(
    // rust: entity_name_key("minecraft:snowball"),
    // rust: "entity.minecraft.snowball"
    // rust: );
    // rust: assert_eq!(entity_name_key("ruby:bolt"), "entity.ruby.bolt");
    // rust: assert_eq!(entity_name_key("ruby:spell/bolt"), "entity.ruby.spell.bolt");
}
}

    // rust: mod look_at_tests {
//     use super::{Target, non_player_entity_id};

pub fn look_at_entity_form_names_any_entity_by_its_id() void {
}
    // rust: for t in [
    // rust: Target::Mob(7),
    // rust: Target::Item(7),
    // rust: Target::Orb(7),
    // rust: Target::Projectile(7),
    // rust: Target::Boat(7),
    // rust: Target::Cart(7),
    // rust: Target::Crystal(7),
    // rust: Target::Dragon(7),
    // rust: Target::Tnt(7),
    // rust: Target::Falling(7),
    // rust: Target::Rocket(7),
    // rust: Target::Trident(7),
    // rust: Target::Spawner(7),
    // rust: Target::Cloud(7),
    // rust: ] {
    // rust: assert_eq!(non_player_entity_id(t), Some(7), "{t:?}");
}
        // Players are the hub's to name; a dragon part's id is no entity id.
    // rust: assert_eq!(non_player_entity_id(Target::Player), None);
    // rust: assert_eq!(non_player_entity_id(Target::Guest(3)), None);
    // rust: assert_eq!(non_player_entity_id(Target::Mob(u32::MAX - 4096)), None);
}
}

    // rust: mod percent_f_tests {
//     use super::percent_f;

pub fn rounds_the_shortest_decimal_half_up_like_java() void {
}
        // WorldBorderCommand: "%.1f" distance, "%.2f" buffer, "%.0f" size.
    // rust: assert_eq!(percent_f(10.35, 1), "10.4");
    // rust: assert_eq!(percent_f(5.125, 2), "5.13");
    // rust: assert_eq!(percent_f(10.5, 0), "11");
    // rust: assert_eq!(percent_f(2.5, 0), "3");
        // TeleportCommand.formatDouble: "%f".
    // rust: assert_eq!(percent_f(0.1234565, 6), "0.123457");
    // rust: assert_eq!(percent_f(-1.005, 2), "-1.01");
    // rust: assert_eq!(percent_f(3.0, 2), "3.00");
}
}

    // rust: mod teleport_rider_tests {
pub fn a_vehicle_carries_its_riders_and_a_rider_leaves_its_vehicle() void {
}
//         use super::Target;
//         use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//         use horizon_core::geometry::Vec3;
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let horse = game.res.mob_types().get("minecraft:horse").unwrap().clone();
    // rust: let villager = game
    // rust: .res
    // rust: .mob_types()
    // rust: .get("minecraft:villager")
    // rust: .unwrap()
    // rust: .clone();
        // A villager riding a horse, 30 degrees off it.
    // rust: game.mobs.push(horizon_client::mobs::Mob::new(
    // rust: 42,
    // rust: horse,
    // rust: Vec3::new(3.0, 64.0, 5.0),
    // rust: 0.0,
    // rust: ));
    // rust: let mut rider =
    // rust: horizon_client::mobs::Mob::new(43, villager, Vec3::new(3.0, 64.5, 5.0), 30.0);
    // rust: rider.extra.mount = Some(42);
    // rust: game.mobs.push(rider);
        // Entity.teleportPassengers: the rider keeps its offset from the
        // vehicle and turns by what the vehicle turned.
    // rust: game.teleport_to_in_level(Target::Mob(42), [10.0, 70.0, -4.0], Some([90.0, 0.0]), true);
    // rust: let vehicle = game.mobs.iter().find(|m| m.id == 42).unwrap();
    // rust: assert_eq!(vehicle.position, Vec3::new(10.0, 70.0, -4.0));
    // rust: let rider = game.mobs.iter().find(|m| m.id == 43).unwrap();
    // rust: assert_eq!(rider.position, Vec3::new(10.0, 70.5, -4.0));
    // rust: assert_eq!(rider.yaw, 120.0, "the rider keeps its angle to the vehicle");
    // rust: assert_eq!(
    // rust: rider.extra.mount,
    // rust: Some(42),
    // rust: "a teleported vehicle keeps its riders"
    // rust: );
        // A relative yaw (`~90`) is the same turn: the transition carries the
        // 90-degree delta and the rider adds it to its own angle.
    // rust: game.teleport_to_in_level(
    // rust: Target::Mob(42),
    // rust: [10.0, 70.0, -4.0],
    // rust: Some([180.0, 0.0]),
    // rust: true,
    // rust: );
    // rust: let rider = game.mobs.iter().find(|m| m.id == 43).unwrap();
    // rust: assert_eq!(rider.yaw, 210.0, "the rider turns by the vehicle's turn");
        // `facing` keeps the transition's rotation: the vehicle looks, the rider does not turn.
    // rust: game.teleport_to_in_level(Target::Mob(42), [10.0, 70.0, -4.0], Some([0.0, 0.0]), false);
    // rust: let rider = game.mobs.iter().find(|m| m.id == 43).unwrap();
    // rust: assert_eq!(
    // rust: rider.yaw, 210.0,
    // rust: "a vehicle turned by `facing` leaves its rider"
    // rust: );
        // Entity.teleport's stopRiding(): a target that is itself a passenger
        // leaves its vehicle, or the next sync seats it where it was.
    // rust: game.teleport_to_in_level(Target::Mob(43), [0.0, 64.0, 0.0], None, false);
    // rust: let rider = game.mobs.iter().find(|m| m.id == 43).unwrap();
    // rust: assert_eq!(rider.extra.mount, None, "the teleported rider dismounted");
    // rust: assert_eq!(rider.position, Vec3::new(0.0, 64.0, 0.0));
}
}

    // rust: mod selector_bounds_tests {
//     use super::*;
//     use crate::game::{Audio, Options, Progress, Settings, load_resources};
//     use horizon_client::{entities::ArmorStand, mobs::Mob};
//     use horizon_core::geometry::Vec3;

pub fn actual_selector_uses_body_overlap_but_distance_stays_at_the_origin() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: eprintln!("Prepared resources unavailable; Game selector coverage did not run");
    // rust: return;
}
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: let kind = game.res.mob_types().get("minecraft:pig").unwrap().clone();
    // rust: game.mobs
    // rust: .push(Mob::new(30, kind, Vec3::new(10.5, 220.0, 10.5), 0.0));
    // rust: let target = Target::Mob(30);
    // rust: let mut selector = Selector {
    // rust: kind: 'e',
    // rust: include_entities: true,
    // rust: limit: usize::MAX,
    // rust: delta: [Some(0.0); 3],
    // rust: ..Default::default()
}
    // rust: let origin = [9.5, 220.0, 10.5];
    // rust: assert_eq!(
    // rust: game.select_in_level(vec![target], &selector, origin),
    // rust: vec![(target, 1.0)]
    // rust: );
    // rust: selector.distance = Some((None, Some(0.9)));
    // rust: assert!(
    // rust: game.select_in_level(vec![target], &selector, origin)
    // rust: .is_empty()
    // rust: );
    // rust: selector.distance = None;
    // rust: assert!(
    // rust: game.select_in_level(vec![target], &selector, [11.0, 220.0, 10.5])
    // rust: .is_empty()
    // rust: );
    // rust: selector.delta = [Some(-1.0), None, None];
    // rust: assert_eq!(
    // rust: game.select_in_level(vec![target], &selector, [11.5, 220.0, 10.5])
    // rust: .len(),
    // rust: 1
    // rust: );
    // rust: game.armor_stands
    // rust: .push(ArmorStand::new(31, Vec3::new(30.5, 220.0, 10.5), 0.0));
    // rust: selector.delta = [Some(0.0); 3];
    // rust: for (x, count) in [(29.5, 1), (29.25, 0), (30.75, 0), (29.250000000000004, 1)] {
    // rust: assert_eq!(
    // rust: game.select_in_level(vec![Target::Stand(31)], &selector, [x, 220.0, 10.5])
    // rust: .len(),
    // rust: count
    // rust: );
}
}
}

    // rust: mod query_feedback_tests {
pub fn a_silent_source_drops_query_results_but_still_stores_them() void {
}
//         use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: game.set_allow_commands(true);
    // rust: assert!(game.run_command("time set 1234"));
    // rust: assert!(game.run_command("scoreboard objectives add q dummy"));
    // rust: let queries = [
    // rust: "time query time",
    // rust: "time query day",
    // rust: "time query day repetition",
    // rust: "time query gametime",
    // rust: "seed",
    // rust: "gamerule keep_inventory",
    // rust: "difficulty",
    // rust: "list",
    // rust: "help seed",
    // rust: ];
        // A function's source (silent, like `run_command_quietly`) is told nothing.
    // rust: for command in queries {
    // rust: game.chat_capture = Some(Vec::new());
    // rust: assert!(game.run_command_quietly(command), "{command}");
    // rust: let lines = game.chat_capture.take().unwrap();
    // rust: assert!(lines.is_empty(), "{command}: {:?}", lines[0].plain());
}
        // The player's own source still sees each result.
    // rust: for command in queries {
    // rust: game.chat_capture = Some(Vec::new());
    // rust: assert!(game.run_command(command), "{command}");
    // rust: assert_eq!(game.chat_capture.take().unwrap().len(), 1, "{command}");
}
        // The result still reaches `execute store`.
    // rust: assert!(game.run_command_quietly("execute store result score #t q run time query day"));
    // rust: game.chat_capture = Some(Vec::new());
    // rust: assert!(game.run_command("scoreboard players get #t q"));
    // rust: let lines = game.chat_capture.take().unwrap();
    // rust: assert!(lines[0].plain().contains("1234"), "{:?}", lines[0].plain());
}
}
