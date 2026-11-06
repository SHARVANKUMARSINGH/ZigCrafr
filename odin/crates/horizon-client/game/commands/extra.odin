//! Transpiled from Horizon Rust crate
package horizon_client_extra

import "core:fmt"
import "core:mem"
import "core:math"

// Commands that act on the player and the hosted game rather than the world:
// `/spectate` (SpectateCommand), `/waypoint` (WaypointCommand), `/dialog`
// (DialogCommand), `/posteffect` (PostEffectCommand), `/kick`,
// `/fetchprofile`, `/publish`, `/unpublish`, `/debug`, `/jfr` and
// `/version`, with vanilla's feedback and failures.
// use super::{Arg, Context, Game, R, Target, err};
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: command::CommandError,
    // rust: skins::{NameOrId, Resolve, ResolvedProfile},
    // rust: snbt,
    // rust: text::{self, ClickEvent, InlineObject, Style, Text},
}
// use horizon_protocol::packets::{
    // rust: Empty,
    // rust: play::{self, Clientbound as C, DialogHolder},
}
// use horizon_world::nbt::Tag;
// use std::{collections::HashMap, time::Instant};

// Waypoint.Icon: the locator bar style and colour of a transmitter.
    // rust: pub(in crate::game) struct WaypointIcon {
    // rust: pub style: String,
    // rust: pub color: Option<i32>,
}
    // rust: impl Default for WaypointIcon {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: style: "minecraft:default".into(),
    // rust: color: None,
}
}
}

// A `/fetchprofile` lookup in flight: what it resolves, the message ids it
// answers with (`commands.fetchprofile.<kind>.success|failure`), the
// argument they show, and the source to answer.
    // rust: pub(in crate::game) struct ProfileFetch {
    // rust: key: NameOrId,
    // rust: kind: &'static str,
    // rust: argument: Text,
    // rust: source: Option<super::execute::Source>,
}

// `ResolvableProfile.CODEC` of a resolved profile as NBT (`id` as an int
// array, `name`, and `properties` only when there are some, each with its
// `signature` only when signed), and the same as the JSON a head object
// draws from.
encode_profile :: proc(profile: ^ResolvedProfile) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let ints = [
    // rust: (profile.id >> 96) as i32,
    // rust: (profile.id >> 64) as i32,
    // rust: (profile.id >> 32) as i32,
    // rust: profile.id as i32,
    // rust: ];
    // rust: let mut fields = vec![
    // rust: ("id", Tag::IntArray(ints.to_vec())),
    // rust: ("name", Tag::String(profile.name.as_str().into())),
    // rust: ];
    // rust: let mut json = serde_json::json!({ "id": ints, "name": profile.name });
    // rust: if !profile.properties.is_empty() {
    // rust: let mut list = Vec::new();
    // rust: let mut json_list = Vec::new();
    // rust: for (name, value, signature) in &profile.properties {
    // rust: let mut entry = vec![
    // rust: ("name", Tag::String(name.as_str().into())),
    // rust: ("value", Tag::String(value.as_str().into())),
    // rust: ];
    // rust: let mut j = serde_json::json!({ "name": name, "value": value });
    // rust: if let Some(signature) = signature {
    // rust: entry.push(("signature", Tag::String(signature.as_str().into())));
    // rust: j["signature"] = signature.clone().into();
}
    // rust: list.push(Tag::compound(entry));
    // rust: json_list.push(j);
}
    // rust: fields.push(("properties", Tag::List(list)));
    // rust: json["properties"] = json_list.into();
}
    // rust: (Tag::compound(fields), json)
}
    // rust: mod fetchprofile_tests {
//     use super::*;
unsigned_profile_without_properties_omits_them :: proc() {
}
    // rust: let profile = ResolvedProfile {
    // rust: id: 0x0000_0001_0000_0002_0000_0003_0000_0004,
    // rust: name: "Steve".into(),
    // rust: properties: Vec::new(),
}
    // rust: let (tag, json) = encode_profile(&profile);
    // rust: assert_eq!(snbt::to_snbt(&tag), "{id:[I;1,2,3,4],name:\"Steve\"}");
    // rust: assert!(json.get("properties").is_none());
}
properties_keep_the_signature_only_when_signed :: proc() {
}
    // rust: let profile = ResolvedProfile {
    // rust: id: 1,
    // rust: name: "Alex".into(),
    // rust: properties: vec![
    // rust: ("textures".into(), "v".into(), Some("s".into())),
    // rust: ("other".into(), "w".into(), None),
    // rust: ],
}
    // rust: let (tag, _) = encode_profile(&profile);
    // rust: assert_eq!(
    // rust: snbt::to_snbt(&tag),
    // rust: "{id:[I;0,0,0,1],name:\"Alex\",properties:[{name:\"textures\",signature:\"s\",value:\"v\"},{name:\"other\",value:\"w\"}]}"
    // rust: );
}
}
// Server-side player and server state these commands keep.
    // rust: pub(in crate::game) struct CommandExtras {
    // ServerPlayer.camera: the entity `/spectate` attached the view to.
    // rust: pub camera: Option<Target>,
    // The cameras of the guests of a server, by connection
    // (game/lan_camera.rs).
    // rust: pub guest_cameras: HashMap<u32, super::super::lan_camera::GuestCamera>,
    // `/spectate` for a guest: connection and the camera's network id
    // (None to stop), taken in the guests' tick.
    // rust: pub camera_requests: Vec<(u32, Option<i32>)>,
    // ServerPlayer.postEffects, in insertion order.
    // rust: pub post_effects: Vec<String>,
    // MinecraftServer's tick profiler (`/debug start`): when it started and
    // the tick count then.
    // rust: pub profiler: Option<(Instant, u64)>,
    // `debugCommandProfilerDelayStart`: the profiler starts with the next tick.
    // rust: pub profiler_delay: bool,
    // `/fetchprofile name|id` lookups still running.
    // rust: pub profile_fetches: Vec<ProfileFetch>,
    // The `/jfr start` recording: when it started and the tick count then.
    // rust: pub jfr: Option<(Instant, u64, String)>,
    // Waypoint icons changed by `/waypoint modify`.
    // rust: pub waypoint_icons: HashMap<Target, WaypointIcon>,
    // `/datapack disable vanilla` took the built-in pack out of the selection.
    // rust: pub vanilla_disabled: bool,
    // The waypoint manager's tracked transmitters (None until first used).
    // rust: pub waypoints: Option<Vec<Target>>,
    // Entities whose waypoint transmit range changed since they last ticked.
    // rust: pub waypoint_dirty: Vec<Target>,
    // Attribute maps of living entities whose attributes Horizon does not
    // model (an armor stand's, a mob's beyond its modelled three).
    // rust: pub attributes: HashMap<Target, horizon_world::attributes::entity::EntityAttributes>,
    // The `CommandResultCallback` results of the outermost source, when a
    // harness records them.
    // rust: pub results: Option<Vec<(bool, i32)>>,
    // The running `/pregen` task.
    // rust: pub pregen: Option<super::pregen::PregenTask>,
}

// use horizon_core::version::{BUILD_TIME, DATA_VERSION, STABLE, VANILLA_VERSION, VERSION_ID};

num :: proc(n: impl std::fmt::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(n.to_string())
}
tr_error :: proc(key: string, args: ^[Text]) -> C {
    // Ported from Horizon
    return {}
}
    // rust: CommandError::new(Text::translate(key, args))
}
// `String.format(Locale.ROOT, "%.2f", v)`.
two_places :: proc(v: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: super::percent_f(v, 2)
}
// `Util.getFilenameFormattedDateTime` (`yyyy-MM-dd_HH.mm.ss`, local time).
filename_date_time :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let secs = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs() as i64);
    // rust: let (y, mo, d, h, mi, s) = civil(secs);
    // rust: format!("{y:04}-{mo:02}-{d:02}_{h:02}.{mi:02}.{s:02}")
}
// UTC civil date and time of a Unix timestamp.
civil :: proc(secs: i64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let days = secs.div_euclid(86_400);
    // rust: let rem = secs.rem_euclid(86_400);
    // rust: let z = days + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z - era * 146_097;
    // rust: let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let d = doy - (153 * mp + 2) / 5 + 1;
    // rust: let m = if mp < 10 { mp + 3 } else { mp - 9 };
    // rust: let y = yoe + era * 400 + i64::from(m <= 2);
    // rust: (y, m, d, rem / 3600, rem % 3600 / 60, rem % 60)
}

    // rust: impl Game<'_> {
    // CommandSourceStack.getPlayerOrException.
    // rust: pub(super) fn source_player(&self) -> R<Target> {
    // rust: match self.command_source.map(|s| s.entity) {
    // rust: None | Some(Some(Target::Player)) => Ok(Target::Player),
    // rust: _ => Err(err("permissions.requires.player", &[])),
}
}
    // EntityArgument.getEntity / getPlayer.
one_entity :: proc(self: ^Self, ctx: ^Context, name: string, player: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.entities(ctx, name, player)?[0])
}

    // ---- /spectate ------------------------------------------------------

    // `SpectateCommand.spectate`.
    // rust: pub(super) fn cmd_spectate(&mut self, ctx: &Context) -> R<i32> {
    // rust: let target = if ctx.get("target").is_some() {
    // rust: Some(self.one_entity(ctx, "target", false)?)
    // rust: } else {
    // rust: None
}
    // rust: let player = if ctx.get("player").is_some() {
    // rust: self.one_entity(ctx, "player", true)?
    // rust: } else {
    // rust: self.source_player()?
}
    // rust: if target == Some(player) {
    // rust: return Err(err("commands.spectate.self", &[]));
}
    // rust: if !self.spectator() {
    // rust: return Err(tr_error(
    // rust: "commands.spectate.not_spectator",
    // rust: &[self.target_name(player)],
    // rust: ));
}
        // EntityType.clientTrackingRange: only a marker's is zero.
    // rust: if let Some(t) = target
    // rust: && self.target_type(t) == "minecraft:marker"
    // rust: {
    // rust: return Err(tr_error(
    // rust: "commands.spectate.cannot_spectate",
    // rust: &[self.target_name(t)],
    // rust: ));
}
        // A guest's camera is the hub's: the view moves in the guests' tick.
    // rust: let guest = match player {
    // rust: Target::Player => self.lan_acting,
    // rust: Target::Guest(conn) => Some(conn),
    // rust: _ => None,
}
    // rust: match guest {
    // rust: Some(conn) => {
    // rust: let camera = target.and_then(|t| self.network_entity_id(t));
    // rust: self.cmds.camera_requests.push((conn, camera));
}
    // rust: None => self.set_camera(target),
}
    // rust: match target {
    // rust: Some(t) => {
    // rust: let name = self.target_name(t);
    // rust: self.feedback(Text::translate(
    // rust: "commands.spectate.success.started",
    // rust: &[name],
    // rust: ));
}
    // rust: None => self.feedback(Text::translate("commands.spectate.success.stopped", &[])),
}
    // rust: Ok(1)
}
    // `ServerPlayer.setCamera`: a new camera moves the player to it.
    // rust: pub(in crate::game) fn set_camera(&mut self, target: Option<Target>) {
    // rust: let target = target.filter(|t| *t != Target::Player);
    // rust: if self.cmds.camera == target {
    // rust: return;
}
    // rust: self.cmds.camera = target;
    // rust: if let Some(t) = target
    // rust: && let Some(p) = self.target_position(t)
    // rust: && let Some(player) = self.player.as_mut()
    // rust: {
    // rust: player.position = horizon_core::geometry::Vec3::new(p[0], p[1], p[2]);
    // rust: self.previous_position = player.position;
}
}
    // Per-tick server work of these commands: the delayed tick profiler
    // start, queued messages and the spectator camera.
    // rust: pub(in crate::game) fn tick_command_extras(&mut self) {
    // rust: if self.cmds.profiler_delay {
    // rust: self.cmds.profiler_delay = false;
    // rust: self.cmds.profiler = Some((Instant::now(), self.ticks));
}
    // rust: self.tick_profile_fetches();
    // rust: self.tick_camera();
    // rust: self.tick_waypoints();
}
    // The camera part of `ServerPlayer.tick`: follow a living camera, drop a
    // removed one, and stop when the player sneaks or leaves spectator mode.
tick_camera :: proc(self: ^Self) {
}
    // rust: let Some(t) = self.cmds.camera else {
    // rust: return;
}
    // rust: if !self.spectator() {
    // rust: self.set_camera(None);
    // rust: return;
}
    // rust: let sneaking = self.keys.held(Action::Sneak) && self.screen == super::Screen::Playing;
    // rust: match self.target_position(t) {
    // rust: Some(p) if !sneaking => {
    // rust: let rot = self.target_rotation(t);
    // rust: if let Some(player) = self.player.as_mut() {
    // rust: player.position = horizon_core::geometry::Vec3::new(p[0], p[1], p[2]);
}
    // rust: self.yaw = rot[0];
    // rust: self.pitch = rot[1];
}
    // rust: _ => self.set_camera(None),
}
}

    // ---- /waypoint ------------------------------------------------------

    // A guest's body is only `Player` during its turn; retained command state
    // must use its connection so the next server tick still finds that body.
    // rust: pub(super) fn waypoint_target(&self, t: Target) -> Target {
    // rust: match t {
    // rust: Target::Player => self.lan_acting.map_or(t, Target::Guest),
    // rust: _ => t,
}
}

    // A living entity's `waypoint_transmit_range` (`isTransmittingWaypoint`).
transmit_range :: proc(self: ^Self, t: Target) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(t, Target::Guest(_)) {
    // rust: return self
    // rust: .for_player(t, |g| g.transmit_range(Target::Player))
    // rust: .unwrap_or(0.0);
}
    // rust: if t == Target::Player {
    // rust: return self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|p| {
    // rust: let k = p.attributes.key("minecraft:waypoint_transmit_range")?;
    // rust: p.attributes
    // rust: .value(Some(k), horizon_world::attribute_map::ValueKind::Computed)
    // rust: .ok()
    // rust: })
    // rust: .unwrap_or(0.0);
}
    // rust: let catalog = self.motion.attributes.clone();
    // rust: let Some(key) = catalog.id("minecraft:waypoint_transmit_range") else {
    // rust: return 0.0;
}
    // rust: match self.cmds.attributes.get_mut(&t) {
    // rust: Some(map) => map.value(key).unwrap_or(0.0),
    // rust: None => 0.0,
}
}
    // `ServerWaypointManager.transmitters()`: the tracked set. The player
    // joins tracked when transmitting; a changed range takes effect when the
    // entity next ticks (`LivingEntity.onAttributeUpdated`), and
    // `/waypoint modify` re-tracks its waypoint whatever its range.
waypoint_transmitters :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if self.cmds.waypoints.is_none() {
    // rust: let tracked = if self.transmit_range(Target::Player) > 0.0 {
    // rust: vec![self.waypoint_target(Target::Player)]
    // rust: } else {
    // rust: Vec::new()
}
    // rust: self.cmds.waypoints = Some(tracked);
}
    // rust: let tracked = self.cmds.waypoints.clone().unwrap_or_default();
    // rust: let alive: Vec<Target> = tracked
    // rust: .into_iter()
    // rust: .filter(|t| self.target_position(*t).is_some())
    // rust: .collect();
    // rust: self.cmds.waypoints = Some(alive.clone());
    // rust: alive
    // rust: .into_iter()
    // rust: .map(|t| match t {
    // rust: Target::Guest(conn) if self.lan_acting == Some(conn) => Target::Player,
    // rust: _ => t,
    // rust: })
    // rust: .collect()
}
    // The waypoint part of a living entity's tick: dirty transmit ranges
    // track or untrack it.
    // rust: pub(in crate::game) fn tick_waypoints(&mut self) {
    // rust: let dirty = std::mem::take(&mut self.cmds.waypoint_dirty);
    // rust: if dirty.is_empty() {
    // rust: return;
}
    // rust: self.waypoint_transmitters();
    // rust: for t in dirty {
    // rust: let on = self.transmit_range(t) > 0.0;
    // rust: if let Some(tracked) = self.cmds.waypoints.as_mut() {
    // rust: tracked.retain(|x| *x != t);
    // rust: if on {
    // rust: tracked.push(t);
}
}
}
}
waypoint_icon :: proc(self: ^Self, t: Target) -> W {
    // Ported from Horizon
    return {}
}
    // rust: self.cmds
    // rust: .waypoint_icons
    // rust: .get(&self.waypoint_target(t))
    // rust: .cloned()
    // rust: .unwrap_or_default()
}
    // `WaypointArgument.getWaypoint`.
waypoint_arg :: proc(self: ^Self, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let t = self.one_entity(ctx, "waypoint", false)?;
    // rust: if !self.is_living(t) {
    // rust: return Err(err("argument.waypoint.invalid", &[]));
}
    // rust: Ok(t)
}
is_living :: proc(self: ^Self, t: Target) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(t, Target::Player | Target::Mob(_) | Target::Stand(_))
}
    // rust: pub(super) fn cmd_waypoint(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: if id == "waypoint.list" {
    // rust: let dimension = self.dim.id();
    // rust: let waypoints = self.waypoint_transmitters();
    // rust: if waypoints.is_empty() {
    // rust: self.feedback(Text::translate(
    // rust: "commands.waypoint.list.empty",
    // rust: &[Text::literal(dimension)],
    // rust: ));
    // rust: return Ok(0);
}
    // rust: let mut names = Text::empty();
    // rust: for (i, t) in waypoints.iter().enumerate() {
    // rust: if i > 0 {
    // rust: names.push(", ");
}
    // rust: let pos = self
    // rust: .target_position(*t)
    // rust: .unwrap_or_default()
    // rust: .map(|v| v.floor() as i32);
    // rust: let color = self.waypoint_icon(*t).color.unwrap_or(-1) as u32 & 0xFF_FFFF;
    // rust: let style = Style {
    // rust: color: Some(color),
    // rust: click: Some(text::ClickEvent::SuggestCommand(format!(
    // rust: "/execute in {dimension} run tp @s {} {} {}",
    // rust: pos[0], pos[1], pos[2]
    // rust: ))),
    // rust: hover: Some(Box::new(Text::translate("chat.coordinates.tooltip", &[]))),
    // rust: ..Style::default()
}
                // getFeedbackDisplayName().copy().withStyle(color): the
                // waypoint colour replaces the team colour of the name.
    // rust: let name = match (
    // rust: *t,
    // rust: self.score
    // rust: .board
    // rust: .players_team(super::super::chat::PLAYER_NAME),
    // rust: ) {
    // rust: (Target::Player, Some(team)) => {
    // rust: let mut n = Text::empty();
    // rust: n.push(horizon_client::scoreboard::comp_text(&team.prefix));
    // rust: n.push(super::super::chat::PLAYER_NAME);
    // rust: n.push(horizon_client::scoreboard::comp_text(&team.suffix));
    // rust: n
}
    // rust: _ => self.target_name(*t),
}
    // rust: names.push(name.with_style(&style));
}
    // rust: let n = waypoints.len() as i32;
    // rust: self.feedback(Text::translate(
    // rust: "commands.waypoint.list.success",
    // rust: &[num(n), Text::literal(dimension), names],
    // rust: ));
    // rust: return Ok(n);
}
    // rust: let t = self.waypoint_arg(ctx)?;
    // rust: let mut icon = self.waypoint_icon(t);
    // rust: let style_literal = ctx.literals.iter().any(|l| l == "style");
    // rust: let message = if style_literal {
    // rust: icon.style = if ctx.literals.iter().any(|l| l == "reset") {
    // rust: "minecraft:default".into()
    // rust: } else {
    // rust: match ctx.get("style") {
    // rust: Some(Arg::Resource(s)) => s.clone(),
    // rust: _ => "minecraft:default".into(),
}
}
    // rust: Text::translate("commands.waypoint.modify.style", &[])
    // rust: } else if ctx.literals.iter().any(|l| l == "reset") {
    // rust: icon.color = None;
    // rust: Text::translate("commands.waypoint.modify.color.reset", &[])
    // rust: } else if ctx.literals.iter().any(|l| l == "hex") {
    // rust: let rgb = match ctx.get("color") {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 0,
}
    // rust: icon.color = Some(rgb);
    // rust: let hex = format!("{:06X}", rgb as u32 & 0xFF_FFFF);
    // rust: Text::translate(
    // rust: "commands.waypoint.modify.color",
    // rust: &[Text::colored(hex, rgb as u32 & 0xFF_FFFF)],
    // rust: )
    // rust: } else {
    // rust: let name = match ctx.get("color") {
    // rust: Some(Arg::Str(s)) => s.clone(),
    // rust: _ => "white".into(),
}
    // rust: let rgb = text::named_color(&name).unwrap_or(0xFF_FFFF);
    // rust: icon.color = Some(rgb as i32);
    // rust: Text::translate(
    // rust: "commands.waypoint.modify.color",
    // rust: &[Text::colored(name, rgb)],
    // rust: )
}
    // rust: let t = self.waypoint_target(t);
    // rust: self.cmds.waypoint_icons.insert(t, icon);
        // WaypointCommand.mutateIcon: untrack, change, track again.
    // rust: self.waypoint_transmitters();
    // rust: if let Some(tracked) = self.cmds.waypoints.as_mut() {
    // rust: tracked.retain(|x| *x != t);
    // rust: tracked.push(t);
}
    // rust: self.feedback(message);
    // rust: Ok(0)
}

    // ---- /dialog --------------------------------------------------------

    // rust: pub(super) fn cmd_dialog(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: let n = targets.len() as i32;
    // rust: if id == "dialog.show" {
    // rust: let Some(Arg::Resource(dialog)) = ctx.get("dialog").cloned() else {
    // rust: return Ok(0);
}
    // rust: self.show_dialog_to(&targets, &dialog);
    // rust: } else {
    // rust: self.clear_dialog_to(&targets);
}
    // rust: let (single, multiple) = if id == "dialog.show" {
    // rust: (
    // rust: "commands.dialog.show.single",
    // rust: "commands.dialog.show.multiple",
    // rust: )
    // rust: } else {
    // rust: (
    // rust: "commands.dialog.clear.single",
    // rust: "commands.dialog.clear.multiple",
    // rust: )
}
    // rust: let message = if n == 1 {
    // rust: Text::translate(single, &[self.target_name(targets[0])])
    // rust: } else {
    // rust: Text::translate(multiple, &[num(n)])
}
    // rust: self.feedback(message);
    // rust: Ok(n)
}

    // ---- /posteffect ----------------------------------------------------

    // `ServerPlayer.postEffects` of a player target: a connected player's
    // (told to their client at the end of their tick), or the host's own.
post_effects_of :: proc(self: ^Self, t: Target) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let conn = match t {
    // rust: Target::Guest(conn) => Some(conn),
    // rust: Target::Player => self.lan_acting,
    // rust: _ => return Vec::new(),
}
    // rust: match conn {
    // rust: Some(conn) => self
    // rust: .command_guest(conn)
    // rust: .map(|g| g.post_effects.clone())
    // rust: .unwrap_or_default(),
    // rust: None => self.cmds.post_effects.clone(),
}
}

    // Changes a player target's `postEffects`; whether `change` did, which
    // sets `postEffectsDirty` for the packet.
    // rust: fn change_post_effects(
    // rust: &mut self,
    // rust: t: Target,
    // rust: change: impl FnOnce(&mut Vec<String>) -> bool,
    // rust: ) -> bool {
    // rust: let conn = match t {
    // rust: Target::Guest(conn) => Some(conn),
    // rust: Target::Player => self.lan_acting,
    // rust: _ => return false,
}
    // rust: match conn {
    // rust: Some(conn) => {
    // rust: let Some(g) = self.lan.as_mut().and_then(|h| h.hub.guest_mut(conn)) else {
    // rust: return false;
}
    // rust: let changed = change(&mut g.post_effects);
    // rust: g.post_effects_dirty |= changed;
    // rust: changed
}
    // rust: None => change(&mut self.cmds.post_effects),
}
}

    // rust: pub(super) fn cmd_posteffect(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: if id == "posteffect.list" {
    // rust: let t = self.one_entity(ctx, "target", true)?;
    // rust: let name = self.target_name(t);
    // rust: let effects = self.post_effects_of(t);
    // rust: if effects.is_empty() {
    // rust: self.feedback(Text::translate("commands.posteffect.list.empty", &[name]));
    // rust: } else {
    // rust: self.feedback(Text::translate(
    // rust: "commands.posteffect.list.success",
    // rust: &[name, num(effects.len()), Text::literal(effects.join(", "))],
    // rust: ));
}
    // rust: return Ok(effects.len() as i32);
}
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: let effect = match ctx.get("posteffect") {
    // rust: Some(Arg::Resource(s)) => s.clone(),
    // rust: _ => String::new(),
}
    // rust: let mut changed: Vec<Target> = Vec::new();
    // rust: for t in &targets {
    // rust: let done = self.change_post_effects(*t, |list| match id {
                // ServerPlayer.addPostEffect.
    // rust: "posteffect.add" => {
    // rust: if list.contains(&effect) {
    // rust: false
    // rust: } else {
    // rust: list.push(effect.clone());
    // rust: true
}
}
                // ServerPlayer.removePostEffect.
    // rust: "posteffect.remove" => match list.iter().position(|e| *e == effect) {
    // rust: Some(i) => {
    // rust: list.remove(i);
    // rust: true
}
    // rust: None => false,
    // rust: },
                // ServerPlayer.clearPostEffects.
    // rust: _ => !std::mem::take(list).is_empty(),
    // rust: });
    // rust: if done {
    // rust: changed.push(*t);
}
}
    // rust: let key = id.trim_start_matches("posteffect.");
    // rust: if changed.is_empty() {
    // rust: return Err(err(&format!("commands.posteffect.{key}.failed"), &[]));
}
    // rust: let n = changed.len() as i32;
    // rust: let effect_text = Text::literal(effect);
    // rust: let message = match (key, n) {
    // rust: ("clear", 1) => Text::translate(
    // rust: "commands.posteffect.clear.success.single",
    // rust: &[self.target_name(changed[0])],
    // rust: ),
    // rust: ("clear", _) => {
    // rust: Text::translate("commands.posteffect.clear.success.multiple", &[num(n)])
}
    // rust: (_, 1) => Text::translate(
    // rust: &format!("commands.posteffect.{key}.success.single"),
    // rust: &[effect_text, self.target_name(changed[0])],
    // rust: ),
    // rust: _ => Text::translate(
    // rust: &format!("commands.posteffect.{key}.success.multiple"),
    // rust: &[effect_text, num(n)],
    // rust: ),
}
    // rust: self.feedback(message);
    // rust: Ok(n)
}

    // ---- /test ----------------------------------------------------------

    // `TestCommand`: running, resetting and clearing tests is
    // `test_runs`; `locate`, `pos` and `create` are `test_locate`.
    // rust: pub(super) fn cmd_test(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: match id {
    // rust: "test.run" | "test.run.found" | "test.clear" | "test.stop" => {
    // rust: self.cmd_test_runs(id, ctx)
}
    // rust: "test.verify" => self.test_verify(ctx),
    // rust: "test.create" => self.test_create(ctx),
    // rust: "test.locate" => self.test_locate(ctx),
    // rust: _ => self.test_show_pos(ctx),
}
}
    // `Entity.pick(10, 1, false)`: the first non-air block on the view ray,
    // else the block at the ray's end.
    // rust: pub(super) fn test_pick_block(&self) -> [i32; 3] {
//         use horizon_core::{
    // rust: geometry::{Vec3, traverse_blocks},
    // rust: position::BlockPos,
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return [0; 3];
}
    // rust: let eye = Vec3::new(
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.eye_height),
    // rust: p.position.z,
    // rust: );
    // rust: let (yaw, pitch) = (
    // rust: f64::from(self.yaw).to_radians(),
    // rust: f64::from(self.pitch).to_radians(),
    // rust: );
    // rust: let dir = [
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: ];
    // rust: let end = Vec3::new(
    // rust: eye.x + dir[0] * 10.0,
    // rust: eye.y + dir[1] * 10.0,
    // rust: eye.z + dir[2] * 10.0,
    // rust: );
    // rust: let hit = traverse_blocks(eye, end, 256, |b: BlockPos| {
    // rust: let state = self.world.block(b.x, b.y, b.z);
    // rust: (!self.res.facts().is_air(state)).then_some([b.x, b.y, b.z])
    // rust: });
    // rust: hit.ok().flatten().unwrap_or([
    // rust: end.x.floor() as i32,
    // rust: end.y.floor() as i32,
    // rust: end.z.floor() as i32,
    // rust: ])
}

    // ---- /kick ----------------------------------------------------------

    // `KickCommand.kickPlayers`: only guests of a published world can be
    // kicked; the owner never.
    // rust: pub(super) fn cmd_kick(&mut self, ctx: &Context) -> R<i32> {
    // rust: let selector = match ctx.get("targets") {
    // rust: Some(Arg::Entity(s)) => Some(s.clone()),
    // rust: _ => None,
}
        // EntityArgument.getPlayers runs before the published check.
    // rust: let host = self.entities(ctx, "targets", true).unwrap_or_default();
    // rust: let guests: Vec<(u32, String)> = match (&self.lan, &selector) {
    // rust: (Some(lan), Some(s)) => lan
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| lan.hub.singleplayer_owner != Some(g.uuid))
    // rust: .filter(|g| match &s.player_name {
    // rust: Some(name) => g.name.eq_ignore_ascii_case(name),
    // rust: None => s.kind == 'a' || s.kind == 'e',
    // rust: })
    // rust: .map(|g| (g.conn, g.name.clone()))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: if host.is_empty() && guests.is_empty() {
    // rust: return Err(err("argument.entity.notfound.player", &[]));
}
    // rust: if self.lan.is_none() || (self.serving() && self.published_port().is_none()) {
    // rust: return Err(err("commands.kick.singleplayer.failed", &[]));
}
    // rust: let reason_raw = match ctx.get("reason") {
    // rust: Some(Arg::Str(s)) => Some(s.clone()),
    // rust: _ => None,
}
    // rust: let reason = match &reason_raw {
    // rust: Some(raw) => self.expand_selectors(raw),
    // rust: None => Text::translate("multiplayer.disconnect.kicked", &[]),
}
    // rust: let tag = match &reason_raw {
    // rust: Some(_) => horizon_world::nbt::Tag::String(reason.plain().as_str().into()),
    // rust: None => horizon_world::nbt::Tag::compound([(
    // rust: "translate",
    // rust: horizon_world::nbt::Tag::String("multiplayer.disconnect.kicked".into()),
    // rust: )]),
}
    // rust: let mut count = 0;
    // rust: for (conn, name) in guests {
    // rust: if let Some(lan) = self.lan.as_mut() {
    // rust: lan.hub.kick(conn, tag.clone());
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.kick.success",
    // rust: &[Text::literal(name), reason.clone()],
    // rust: ));
    // rust: count += 1;
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.kick.owner.failed", &[]));
}
    // rust: Ok(count)
}

    // ---- /fetchprofile --------------------------------------------------

    // `FetchProfileCommand.resolveName` and `resolveId`: the lookup runs on
    // background threads (`Util.nonCriticalIoPool`, here the cached profile
    // resolver's), and the answer is reported by a later tick;
    // `printForEntity` reports the player's own profile at once.
    // rust: pub(super) fn cmd_fetchprofile(&mut self, ctx: &Context) -> R<i32> {
    // rust: if ctx.literals.iter().any(|l| l == "name") {
    // rust: let name = match ctx.get("name") {
    // rust: Some(Arg::Str(s)) => s.clone(),
    // rust: _ => String::new(),
}
    // rust: self.cmds.profile_fetches.push(ProfileFetch {
    // rust: key: NameOrId::Name(name.clone()),
    // rust: kind: "name",
    // rust: argument: Text::literal(name),
    // rust: source: self.command_source,
    // rust: });
    // rust: return Ok(1);
}
    // rust: if ctx.literals.iter().any(|l| l == "id") {
    // rust: let id = match ctx.get("id") {
    // rust: Some(Arg::Str(s)) => horizon_client::command::selector::java_uuid(s),
    // rust: _ => None,
}
    // rust: .unwrap_or_default();
            // `Component.translationArg(id)`: the UUID's string form.
    // rust: self.cmds.profile_fetches.push(ProfileFetch {
    // rust: key: NameOrId::Id(id),
    // rust: kind: "id",
    // rust: argument: Text::literal(horizon_protocol::crypto::uuid_string(id)),
    // rust: source: self.command_source,
    // rust: });
    // rust: return Ok(1);
}
    // rust: let t = self.one_entity(ctx, "entity", false)?;
    // rust: if t != Target::Player {
    // rust: return Err(tr_error(
    // rust: "commands.fetchprofile.no_profile",
    // rust: &[self.target_name(t)],
    // rust: ));
}
        // The player in place: a guest's own profile while their command runs.
    // rust: let id = horizon_client::lan::playerdata::ints_uuid(self.acting_uuid());
    // rust: let name = self.acting_player_name().to_owned();
    // rust: self.report_resolved_profile(
    // rust: "commands.fetchprofile.entity.success",
    // rust: Text::literal(&name),
    // rust: &ResolvedProfile {
    // rust: id,
    // rust: name,
    // rust: properties: Vec::new(),
    // rust: },
    // rust: );
    // rust: Ok(1)
}
    // The answers of the profile lookups that have come in
    // (`server.execute(() -> result.ifPresentOrElse(...))`).
    // Whether a `/fetchprofile` lookup is still in flight (the command
    // harness waits for them, as vanilla's oracle resolves at once).
    // rust: pub(in crate::game) fn profile_fetches_pending(&mut self) -> bool {
    // rust: let mut resolver = self.skin_profiles.borrow_mut();
    // rust: self.cmds
    // rust: .profile_fetches
    // rust: .iter()
    // rust: .any(|f| matches!(resolver.state(&f.key), Resolve::Pending))
}
tick_profile_fetches :: proc(self: ^Self) {
}
    // rust: let fetches = std::mem::take(&mut self.cmds.profile_fetches);
    // rust: for fetch in fetches {
    // rust: let state = self.skin_profiles.borrow_mut().state(&fetch.key);
    // rust: match state {
    // rust: Resolve::Pending => self.cmds.profile_fetches.push(fetch),
    // rust: Resolve::Done(result) => {
    // rust: let outer = std::mem::replace(&mut self.command_source, fetch.source);
    // rust: match result {
    // rust: Some(profile) => self.report_resolved_profile(
    // rust: &format!("commands.fetchprofile.{}.success", fetch.kind),
    // rust: fetch.argument,
    // rust: &profile,
    // rust: ),
    // rust: None => self.command_failure(Text::translate(
    // rust: &format!("commands.fetchprofile.{}.failure", fetch.kind),
    // rust: &[fetch.argument],
    // rust: )),
}
    // rust: self.command_source = outer;
}
}
}
}
    // `FetchProfileCommand.reportResolvedProfile`: the profile as
    // `ResolvableProfile.CODEC` encodes it (`id`, `name`, and `properties`
    // only when there are some), four clickable actions and the head object,
    // sent with `sendSuccess(..., false)`.
    // rust: fn report_resolved_profile(
    // rust: &mut self,
    // rust: message_id: &str,
    // rust: argument: Text,
    // rust: profile: &ResolvedProfile,
    // rust: ) {
    // rust: let (profile_tag, json) = encode_profile(profile);
    // rust: let encoded_profile = snbt::to_snbt(&profile_tag);
        // `Component.object(new PlayerSprite(profile, true))`, encoded: `hat`
        // is left out at its default.
    // rust: let encoded_component = snbt::to_snbt(&Tag::compound([("player", profile_tag)]));
    // rust: let mut head = Text::literal("\u{FFFC}");
    // rust: head.spans[0].style.inline_object = Some(InlineObject::Player {
    // rust: profile: json,
    // rust: hat: true,
    // rust: fallback: format!("[{} head]", profile.name),
    // rust: });
    // rust: let item = |key: &str, args: &[Text], click: ClickEvent| {
    // rust: let inner = Text::translate(key, args)
    // rust: .with_color(text::GREEN)
    // rust: .with_style(&Style {
    // rust: click: Some(click),
    // rust: ..Style::default()
    // rust: });
    // rust: Text::translate("chat.square_brackets", &[inner])
}
    // rust: let mut clickable = item(
    // rust: "commands.fetchprofile.copy_component",
    // rust: &[],
    // rust: ClickEvent::CopyToClipboard(encoded_profile.clone()),
    // rust: );
    // rust: clickable.push(" ");
    // rust: clickable.push(item(
    // rust: "commands.fetchprofile.give_item",
    // rust: &[],
    // rust: ClickEvent::RunCommand(format!(
    // rust: "give @s minecraft:player_head[profile={encoded_profile}]"
    // rust: )),
    // rust: ));
    // rust: clickable.push(" ");
    // rust: clickable.push(item(
    // rust: "commands.fetchprofile.summon_mannequin",
    // rust: &[],
    // rust: ClickEvent::RunCommand(format!(
    // rust: "summon minecraft:mannequin ~ ~ ~ {{profile:{encoded_profile}}}"
    // rust: )),
    // rust: ));
    // rust: clickable.push(" ");
    // rust: clickable.push(item(
    // rust: "commands.fetchprofile.copy_text",
    // rust: &[head.with_color(text::WHITE)],
    // rust: ClickEvent::CopyToClipboard(encoded_component),
    // rust: ));
    // rust: self.feedback_unbroadcast(Text::translate(message_id, &[argument, clickable]));
}

    // ---- /publish, /unpublish -------------------------------------------

    // `PublishCommand.publish` with `IntegratedServer.publishServer`.
    // rust: pub(super) fn cmd_publish(&mut self, ctx: &Context) -> R<i32> {
    // rust: let allow = matches!(ctx.get("allowCommands"), Some(Arg::Bool(true)));
    // rust: let port = match ctx.get("port") {
    // rust: Some(Arg::Int(p)) => *p,
            // HttpUtil.getAvailablePort.
    // rust: _ => std::net::TcpListener::bind((
    // rust: if std::env::var_os("HORIZON_TEST_LOOPBACK").is_some_and(|v| v == "1") {
    // rust: "127.0.0.1"
    // rust: } else {
    // rust: "0.0.0.0"
    // rust: },
    // rust: 0,
    // rust: ))
    // rust: .and_then(|l| l.local_addr())
    // rust: .map_or(25564, |a| i32::from(a.port())),
}
    // rust: let published = if self.serving() {
    // rust: self.published_port()
    // rust: } else {
    // rust: self.lan.as_ref().map(|l| l.settings.port)
}
    // rust: if let Some(port) = published {
    // rust: return Err(err("commands.publish.alreadyPublished.lan", &[&port]));
}
    // rust: let settings = super::super::lan::LanSettings {
    // rust: port: port as u16,
    // rust: guest_commands: allow,
    // rust: force_game_mode: false,
}
        // A dedicated server is open from the start (`published` above).
    // rust: let started = self.serving() && self.publish(settings).is_ok();
    // rust: if !started {
    // rust: return Err(err("commands.publish.failed", &[]));
}
    // rust: let port_text = port.to_string();
    // rust: let link = Text::literal(port_text.clone()).with_style(&Style {
    // rust: color: Some(text::GREEN),
    // rust: hover: Some(Box::new(Text::translate("chat.copy.click", &[]))),
    // rust: ..Style::default()
    // rust: });
    // rust: self.feedback(Text::translate(
    // rust: "commands.publish.started.lan",
    // rust: &[Text::translate("chat.square_brackets", &[link])],
    // rust: ));
    // rust: Ok(port)
}
    // rust: pub(super) fn cmd_unpublish(&mut self) -> R<i32> {
    // rust: if self.serving() {
    // rust: if !self.unpublish() {
    // rust: return Err(err("commands.unpublish.notPublished", &[]));
}
    // rust: self.feedback(Text::translate("commands.unpublish.success", &[]));
    // rust: return Ok(1);
}
    // rust: if self.lan.is_none() {
    // rust: return Err(err("commands.unpublish.notPublished", &[]));
}
    // rust: self.lan_close(false);
    // rust: self.feedback(Text::translate("commands.unpublish.success", &[]));
    // rust: Ok(1)
}

    // ---- /debug, /jfr, /version -----------------------------------------

    // rust: pub(super) fn cmd_debug(&mut self, ctx: &Context) -> R<i32> {
    // rust: if ctx.literals.iter().any(|l| l == "function") {
    // rust: return self.cmd_debug_function(ctx);
}
        // MinecraftServer.isTimeProfilerRunning / startTimeProfiler /
        // stopTimeProfiler: a stop before the delayed start took effect
        // reports empty results and leaves the start pending.
    // rust: let running = self.cmds.profiler_delay || self.cmds.profiler.is_some();
    // rust: if ctx.literals.iter().any(|l| l == "start") {
    // rust: if running {
    // rust: return Err(err("commands.debug.alreadyRunning", &[]));
}
    // rust: self.cmds.profiler_delay = true;
    // rust: self.feedback(Text::translate("commands.debug.started", &[]));
    // rust: return Ok(0);
}
    // rust: if !running {
    // rust: return Err(err("commands.debug.notRunning", &[]));
}
    // rust: let (seconds, ticks) = match self.cmds.profiler.take() {
    // rust: Some((started, ticks)) => (
    // rust: started.elapsed().as_nanos() as f64 / 1.0e9,
    // rust: (self.ticks - ticks) as f64,
    // rust: ),
    // rust: None => (0.0, 0.0),
}
    // rust: let tps = ticks / seconds;
    // rust: self.feedback(Text::translate(
    // rust: "commands.debug.stopped",
    // rust: &[
    // rust: Text::literal(two_places(seconds)),
    // rust: num(ticks as i64),
    // rust: Text::literal(two_places(tps)),
    // rust: ],
    // rust: ));
    // rust: Ok(tps as i32)
}
    // `DebugCommand.TraceCustomExecutor`: run the functions with a tracer
    // writing to `debug/debug-trace-<time>.txt`.
cmd_debug_function :: proc(self: ^Self, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.exec.function_depth > 0 {
    // rust: return Err(err("commands.debug.function.noRecursion", &[]));
}
    // rust: let Some(Arg::Resource(id)) = ctx.get("name").cloned() else {
    // rust: return Ok(0);
}
    // rust: let functions = self.functions_named(&id)?;
    // rust: let output = format!("debug-trace-{}.txt", filename_date_time());
    // rust: let dir = std::env::current_dir().unwrap_or_default().join("debug");
    // rust: let mut trace = String::new();
    // rust: let mut total = 0;
    // rust: let mut traced: Vec<String> = Vec::new();
    // rust: for f in &functions {
    // rust: let lines = match f.instantiate(None) {
    // rust: Ok(lines) => lines,
    // rust: Err((key, args)) => {
    // rust: let args: Vec<&dyn std::fmt::Display> =
    // rust: args.iter().map(|s| s as &dyn std::fmt::Display).collect();
    // rust: let reason = Text::tr(&key, &args);
    // rust: self.command_failure(Text::translate(
    // rust: "commands.function.instantiationFailure",
    // rust: &[Text::literal(f.id.clone()), reason],
    // rust: ));
    // rust: continue;
}
}
    // rust: total += lines.len() as i32;
    // rust: traced.push(f.id.clone());
    // rust: trace.push_str(&f.id);
    // rust: trace.push('\n');
    // rust: self.trace_function(&f.id, &lines, 0, &mut trace);
}
    // rust: let written = std::fs::create_dir_all(&dir)
    // rust: .and_then(|()| std::fs::write(dir.join(&output), trace))
    // rust: .is_ok();
    // rust: if !written {
    // rust: self.command_failure(Text::translate("commands.debug.function.traceFailed", &[]));
}
    // rust: let message = if traced.len() == 1 {
    // rust: Text::translate(
    // rust: "commands.debug.function.success.single",
    // rust: &[
    // rust: num(total),
    // rust: Text::literal(traced[0].clone()),
    // rust: Text::literal(output),
    // rust: ],
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "commands.debug.function.success.multiple",
    // rust: &[num(total), num(traced.len()), Text::literal(output)],
    // rust: )
}
    // rust: self.feedback(message);
    // rust: Ok(total)
}
    // The tracer's `[F]`/`[C]` lines for one function, running its commands.
trace_function :: proc(self: ^Self, id: string, lines: ^[string], depth: uint, out: ^string) {
}
    // rust: let indent = |d: usize| "    ".repeat(d + 1);
    // rust: out.push_str(&format!("{}[F] {id} size={}\n", indent(depth), lines.len()));
    // rust: let source = super::execute::Source {
    // rust: silent: true,
    // rust: ..self.player_source()
}
    // rust: for line in lines {
    // rust: out.push_str(&format!("{}[C] {line}", indent(depth + 1)));
    // rust: match self.execute_line(line, source) {
    // rust: Ok(v) => out.push_str(&format!(" -> {v}\n")),
    // rust: Err(e) => {
    // rust: out.push('\n');
    // rust: out.push_str(&format!("{}[E] {}", indent(depth + 2), e.message.plain()));
}
}
}
}

    // `/jfr start|stop` (JfrCommand). Horizon has no JVM flight recorder:
    // the recording is its own tick timing, dumped as JSON.
    // rust: pub(super) fn cmd_jfr(&mut self, ctx: &Context) -> R<i32> {
    // rust: if ctx.literals.iter().any(|l| l == "start") {
    // rust: if self.cmds.jfr.is_some() {
    // rust: return Err(err("commands.jfr.start.failed", &[]));
}
    // rust: let stamp = filename_date_time();
    // rust: self.cmds.jfr = Some((Instant::now(), self.ticks, stamp));
    // rust: self.feedback(Text::translate("commands.jfr.started", &[]));
    // rust: return Ok(1);
}
    // rust: let Some((started, ticks, stamp)) = self.cmds.jfr.take() else {
    // rust: return Err(tr_error(
    // rust: "commands.jfr.dump.failed",
    // rust: &[Text::literal("Not currently profiling")],
    // rust: ));
}
    // rust: let relative = format!("debug/client-{stamp}.json");
    // rust: let path = std::env::current_dir().unwrap_or_default().join(&relative);
    // rust: let report = serde_json::json!({
    // rust: "environment": "client",
    // rust: "seconds": started.elapsed().as_secs_f64(),
    // rust: "ticks": self.ticks - ticks,
    // rust: });
    // rust: let written = path
    // rust: .parent()
    // rust: .map_or(Ok(()), std::fs::create_dir_all)
    // rust: .and_then(|()| std::fs::write(&path, report.to_string()));
    // rust: if let Err(e) = written {
    // rust: return Err(tr_error(
    // rust: "commands.jfr.dump.failed",
    // rust: &[Text::literal(e.to_string())],
    // rust: ));
}
    // rust: let file = Text::literal(relative).underlined().with_style(&Style {
    // rust: hover: Some(Box::new(Text::translate("chat.copy.click", &[]))),
    // rust: ..Style::default()
    // rust: });
    // rust: self.feedback(Text::translate("commands.jfr.stopped", &[file]));
    // rust: Ok(1)
}

    // `VersionCommand.dumpVersion`'s lines: Horizon reports the version it
    // implements.
    // rust: pub(in crate::game) fn version_lines(&self) -> Vec<Text> {
    // rust: let protocol = horizon_protocol::PROTOCOL_VERSION;
    // rust: let mut lines: Vec<Text> = [
    // rust: ("commands.version.id", vec![Text::literal(VERSION_ID)]),
    // rust: (
    // rust: "commands.version.name",
    // rust: vec![Text::literal(VANILLA_VERSION)],
    // rust: ),
    // rust: ("commands.version.data", vec![num(DATA_VERSION)]),
    // rust: ("commands.version.series", vec![Text::literal("main")]),
    // rust: (
    // rust: "commands.version.protocol",
    // rust: vec![num(protocol), Text::literal(format!("0x{protocol:x}"))],
    // rust: ),
    // rust: (
    // rust: "commands.version.build_time",
    // rust: vec![Text::literal(BUILD_TIME)],
    // rust: ),
    // rust: (
    // rust: "commands.version.pack.resource",
    // rust: vec![Text::literal("97.1")],
    // rust: ),
    // rust: ("commands.version.pack.data", vec![Text::literal("121.0")]),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(key, args)| Text::translate(key, &args))
    // rust: .collect();
    // rust: lines.push(Text::translate(
    // rust: if STABLE {
    // rust: "commands.version.stable.yes"
    // rust: } else {
    // rust: "commands.version.stable.no"
    // rust: },
    // rust: &[],
    // rust: ));
    // rust: lines
}
    // `VersionCommand`.
    // rust: pub(super) fn cmd_version(&mut self) -> R<i32> {
    // rust: if !self.command_source.is_some_and(|s| s.silent) {
    // rust: self.system_message(Text::translate("commands.version.header", &[]));
    // rust: for line in self.version_lines() {
    // rust: self.system_message(line);
}
}
    // rust: Ok(1)
}
}

    // rust: impl Game<'_> {
    // `ServerPlayer.openDialog` for every target of `/dialog show`: a guest
    // is sent `ClientboundShowDialogPacket`, the window's own player opens
    // the dialog on its screen.
show_dialog_to :: proc(self: ^Self, targets: ^[Target], dialog: string) {
}
    // rust: let Some(holder) = self.dialog_holder(dialog) else {
    // rust: return;
}
    // rust: self.send_dialog(targets, &holder);
}
    // `ServerPlayer.openDialog` for the dialog of a `show_dialog` click
    // event (a sign's): a registry id or the dialog itself, opened for the
    // player the game acts for.
    // rust: pub(in crate::game) fn show_click_dialog(&mut self, dialog: &horizon_world::nbt::Tag) {
    // rust: let holder = match dialog {
    // rust: horizon_world::nbt::Tag::String(id) => self.dialog_holder(&id.to_string_lossy()),
    // rust: direct => Some(DialogHolder::Direct(direct.clone())),
}
    // rust: if let Some(holder) = holder {
    // rust: self.send_dialog(&[Target::Player], &holder);
}
}
    // `ServerPlayer.openDialog` for each target: the packet to a guest, the
    // screen to the window's own player.
send_dialog :: proc(self: ^Self, targets: ^[Target], holder: ^DialogHolder) {
}
    // rust: let packet = C::ShowDialog(play::ShowDialog {
    // rust: dialog: holder.clone(),
    // rust: });
    // rust: for &t in targets {
    // rust: match t {
    // rust: Target::Player if self.lan_acting.is_some() => {
    // rust: self.guest_packets.push(packet.clone());
}
    // rust: Target::Player => self.show_play_dialog(holder),
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.send_to(conn, &packet);
}
}
    // rust: _ => {}
}
}
}
    // `ServerPlayer.closeDialog` for every target of `/dialog clear`.
clear_dialog_to :: proc(self: ^Self, targets: ^[Target]) {
}
    // rust: let packet = C::ClearDialog(Empty);
    // rust: for &t in targets {
    // rust: match t {
    // rust: Target::Player if self.lan_acting.is_some() => {
    // rust: self.guest_packets.push(packet.clone());
}
    // rust: Target::Player => self.clear_dialog(),
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.send_to(conn, &packet);
}
}
    // rust: _ => {}
}
}
}
    // `ServerPlayer.openDialog`'s dialog: an entry of the `minecraft:dialog`
    // registry, or the dialog an inline `ResourceOrIdArgument` carries.
dialog_holder :: proc(self: ^Self, dialog: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = dialog.trim();
    // rust: if text.starts_with('{') {
    // rust: return horizon_client::command::snbt::parse_fully(text)
    // rust: .ok()
    // rust: .map(DialogHolder::Direct);
}
        // A registry id, written with or without its namespace.
    // rust: let id = if text.contains(':') {
    // rust: text.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{text}")
}
    // rust: let index = self
    // rust: .ui
    // rust: .registries
    // rust: .ids("minecraft:dialog")
    // rust: .iter()
    // rust: .position(|name| *name == id);
    // rust: match index {
    // rust: Some(i) => Some(DialogHolder::Registry(i as i32)),
    // rust: None => {
    // rust: log::warn!("Horizon: no dialog {id} in the registry");
    // rust: None
}
}
}
}
    // rust: impl Game<'_> {}
