//! Transpiled from Horizon Rust crate
package horizon_client_bossbars

import "core:fmt"
import "core:mem"
import "core:math"

// `/bossbar` (BossBarCommands) and drawing the custom boss bars.
// use super::{
    // rust: Dim, Game,
    // rust: commands::{R, Target, err},
}
// use horizon_client::{
    // rust: boss_overlay,
    // rust: bossbar::{self, BossBars},
    // rust: command::{Arg, Context},
    // rust: mobs::Species,
    // rust: save,
    // rust: scoreboard::{self as sb, Comp, json_to_tag},
    // rust: scoreboard_cmd::format_list,
    // rust: text::Text,
}
// use horizon_core::random::RandomSource;
// use horizon_protocol::packets::play::{self, BossAction, Clientbound as C};
// use horizon_world::{identifier::Identifier, java_hash_map::JavaHashMap, nbt::Tag};
// use std::collections::{HashMap, HashSet};

    // rust: pub(super) struct BossState {
    // rust: pub bars: BossBars,
    // CustomBossEvents' default HashMap order, used only by the list reply.
    // rust: listing: JavaHashMap<Identifier, usize>,
    // rust: loaded: bool,
    // What each viewer was last sent, so a change becomes one packet.
    // rust: sent: HashMap<u128, HashMap<u128, Offer>>,
}

    // rust: impl BossState {
add_bar :: proc(self: ^Self, id: string, name: Comp) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.bars.add(id, name) {
    // rust: return false;
}
    // rust: if let Ok(key) = Identifier::parse(id) {
    // rust: self.listing.put(key, self.bars.bars.len() - 1);
}
    // rust: true
}

remove_bar :: proc(self: ^Self, id: string) {
}
    // rust: self.bars.remove(id);
    // rust: if let Ok(key) = Identifier::parse(id) {
    // rust: self.listing.remove(&key);
}
        // Vec removal shifts indices. Replacing existing map values keeps
        // its table and bucket chains intact, unlike reconstructing the map.
    // rust: for (index, bar) in self.bars.bars.iter().enumerate() {
    // rust: if let Ok(key) = Identifier::parse(&bar.id) {
    // rust: self.listing.put(key, index);
}
}
}

rebuild_listing :: proc(self: ^Self) {
}
    // rust: self.listing = JavaHashMap::default();
    // rust: for (index, bar) in self.bars.bars.iter().enumerate() {
    // rust: if let Ok(key) = Identifier::parse(&bar.id) {
    // rust: self.listing.put(key, index);
}
}
}

listed_bars :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut bars: Vec<_> = self
    // rust: .listing
    // rust: .entries()
    // rust: .filter_map(|(_, index)| self.bars.bars.get(*index))
    // rust: .collect();
        // The existing permissive loader can retain invalid legacy IDs.
        // Preserve those entries rather than dropping them from the reply.
    // rust: if bars.len() != self.bars.bars.len() {
    // rust: for bar in &self.bars.bars {
    // rust: if !bars.iter().any(|listed| listed.id == bar.id) {
    // rust: bars.push(bar);
}
}
}
    // rust: bars
}
}

num :: proc(n: impl std::fmt::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(n.to_string())
}

    // rust: impl Game<'_> {
bossbar_path :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.world_root
    // rust: .join("data/minecraft/custom_boss_events.dat")
}
    // rust: pub(super) fn load_bossbars(&mut self) {
    // rust: if self.bosses.loaded || self.remote.is_some() {
    // rust: return;
}
    // rust: self.bosses.loaded = true;
    // rust: if let Some(root) = save::read_dat(&self.bossbar_path())
    // rust: && let Some(data) = root.get("data")
    // rust: {
    // rust: self.bosses.bars = BossBars::unpack(data);
}
    // rust: self.bosses.rebuild_listing();
    // rust: self.ui.registries.bossbars = self.bosses.bars.ids();
}
    // rust: pub(super) fn save_bossbars(&self) {
    // rust: if !self.bosses.loaded || self.remote.is_some() {
    // rust: return;
}
    // rust: if self.bosses.bars.bars.is_empty() && !self.bossbar_path().exists() {
    // rust: return;
}
    // rust: if let Err(e) = save::write_dat(
    // rust: &self.bossbar_path(),
    // rust: Tag::compound([
    // rust: ("data", self.bosses.bars.pack()),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]),
    // rust: ) {
    // rust: log::warn!("boss bars were not written: {e}");
}
}
    // rust: pub(in crate::game) fn bossbar_exists(&self, id: &str) -> bool {
    // rust: self.bosses.bars.get(id).is_some()
}
    // `execute store ... bossbar <id> value|max`.
    // rust: pub(in crate::game) fn set_bossbar_value(&mut self, id: &str, value: bool, v: i32) {
    // rust: if let Some(b) = self.bosses.bars.get_mut(id) {
    // rust: if value {
    // rust: b.value = v.clamp(0, b.max);
    // rust: } else {
    // rust: b.max = v.max(1);
    // rust: b.value = b.value.min(b.max);
}
}
    // rust: self.publish_boss_bars();
}
bar_id :: proc(ctx: ^Context) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match ctx.get("id") {
    // rust: Some(Arg::Resource(id)) => id.clone(),
    // rust: _ => String::new(),
}
}
bar_checked :: proc(self: ^Self, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = Self::bar_id(ctx);
    // rust: if self.bosses.bars.get(&id).is_none() {
    // rust: return Err(err("commands.bossbar.unknown", &[&id]));
}
    // rust: Ok(id)
}
    // rust: pub(super) fn cmd_bossbar(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: self.load_bossbars();
    // rust: let result = self.bossbar_command(id, ctx);
    // rust: self.ui.registries.bossbars = self.bosses.bars.ids();
    // rust: self.publish_boss_bars();
    // rust: result
}
bossbar_command :: proc(self: ^Self, id: string, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: "bossbar.add" => {
    // rust: let bar = Self::bar_id(ctx);
    // rust: if self.bosses.bars.get(&bar).is_some() {
    // rust: return Err(err("commands.bossbar.create.failed", &[&bar]));
}
    // rust: let name = self.component_json(ctx, "name")?;
    // rust: self.bosses.add_bar(&bar, name);
    // rust: if let Some(b) = self.bosses.bars.get_mut(&bar) {
                    // CustomBossEvents.create: Mth.createInsecureUUID(level.random).
    // rust: b.uuid = insecure_uuid(&mut self.world.random);
}
    // rust: let shown = self
    // rust: .bosses
    // rust: .bars
    // rust: .get(&bar)
    // rust: .map(|b| b.display_name())
    // rust: .unwrap_or_default();
    // rust: self.feedback(Text::translate("commands.bossbar.create.success", &[shown]));
    // rust: return Ok(self.bosses.bars.bars.len() as i32);
}
    // rust: "bossbar.list" => {
    // rust: let names: Vec<Text> = self
    // rust: .bosses
    // rust: .listed_bars()
    // rust: .into_iter()
    // rust: .map(horizon_client::bossbar::BossBar::display_name)
    // rust: .collect();
    // rust: let n = names.len();
    // rust: if n == 0 {
    // rust: self.feedback(Text::translate("commands.bossbar.list.bars.none", &[]));
    // rust: } else {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.list.bars.some",
    // rust: &[num(n), format_list(names)],
    // rust: ));
}
    // rust: return Ok(n as i32);
}
    // rust: _ => {}
}
    // rust: let bar = self.bar_checked(ctx)?;
    // rust: let shown = |g: &Self| {
    // rust: g.bosses
    // rust: .bars
    // rust: .get(&bar)
    // rust: .map(|b| b.display_name())
    // rust: .unwrap_or_default()
}
    // rust: let last = ctx.literals.last().cloned().unwrap_or_default();
    // rust: match id {
    // rust: "bossbar.remove" => {
    // rust: let s = shown(self);
    // rust: self.bosses.remove_bar(&bar);
    // rust: self.feedback(Text::translate("commands.bossbar.remove.success", &[s]));
    // rust: Ok(self.bosses.bars.bars.len() as i32)
}
    // rust: "bossbar.get" => {
    // rust: let b = self.bosses.bars.get(&bar).cloned().unwrap_or_else(|| {
    // rust: horizon_client::bossbar::BossBar::new(&bar, sb::literal(&bar))
    // rust: });
    // rust: let s = b.display_name();
    // rust: Ok(match last.as_str() {
    // rust: "value" => {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.get.value",
    // rust: &[s, num(b.value)],
    // rust: ));
    // rust: b.value
}
    // rust: "max" => {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.get.max",
    // rust: &[s, num(b.max)],
    // rust: ));
    // rust: b.max
}
    // rust: "visible" => {
    // rust: let key = if b.visible {
    // rust: "commands.bossbar.get.visible.visible"
    // rust: } else {
    // rust: "commands.bossbar.get.visible.hidden"
}
    // rust: self.feedback(Text::translate(key, &[s]));
    // rust: i32::from(b.visible)
}
    // rust: _ => {
    // rust: let names = self.bossbar_player_names(&b.players);
    // rust: let n = names.len();
    // rust: if n == 0 {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.get.players.none",
    // rust: &[s],
    // rust: ));
    // rust: } else {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.get.players.some",
    // rust: &[s, num(n), format_list(names)],
    // rust: ));
}
    // rust: n as i32
}
    // rust: })
}
    // rust: _ => self.bossbar_set(id, ctx, &bar, &last),
}
}
bossbar_set :: proc(self: ^Self, id: string, ctx: ^Context, bar: string, last: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let shown = |g: &Self| {
    // rust: g.bosses
    // rust: .bars
    // rust: .get(bar)
    // rust: .map(|b| b.display_name())
    // rust: .unwrap_or_default()
}
    // rust: let int = |name: &str| match ctx.get(name) {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 0,
}
    // rust: match id {
    // rust: "bossbar.set.name" => {
    // rust: let name = self.component_json(ctx, "name")?;
    // rust: let b = self.bosses.bars.get_mut(bar).expect("checked");
    // rust: if b.name == name {
    // rust: return Err(err("commands.bossbar.set.name.unchanged", &[]));
}
    // rust: b.name = name;
    // rust: let s = shown(self);
    // rust: self.feedback(Text::translate("commands.bossbar.set.name.success", &[s]));
    // rust: Ok(0)
}
    // rust: "bossbar.set.color" | "bossbar.set.style" => {
    // rust: let color = id.ends_with("color");
    // rust: let b = self.bosses.bars.get_mut(bar).expect("checked");
    // rust: let slot = if color { &mut b.color } else { &mut b.style };
    // rust: if slot == last {
    // rust: return Err(err(
    // rust: if color {
    // rust: "commands.bossbar.set.color.unchanged"
    // rust: } else {
    // rust: "commands.bossbar.set.style.unchanged"
    // rust: },
    // rust: &[],
    // rust: ));
}
    // rust: *slot = last.to_owned();
    // rust: let s = shown(self);
    // rust: self.feedback(Text::translate(
    // rust: if color {
    // rust: "commands.bossbar.set.color.success"
    // rust: } else {
    // rust: "commands.bossbar.set.style.success"
    // rust: },
    // rust: &[s],
    // rust: ));
    // rust: Ok(0)
}
    // rust: "bossbar.set.value" | "bossbar.set.max" => {
    // rust: let is_value = id.ends_with("value");
    // rust: let v = int(if is_value { "value" } else { "max" });
    // rust: let b = self.bosses.bars.get_mut(bar).expect("checked");
    // rust: let slot = if is_value { &mut b.value } else { &mut b.max };
    // rust: if *slot == v {
    // rust: return Err(err(
    // rust: if is_value {
    // rust: "commands.bossbar.set.value.unchanged"
    // rust: } else {
    // rust: "commands.bossbar.set.max.unchanged"
    // rust: },
    // rust: &[],
    // rust: ));
}
    // rust: *slot = v;
    // rust: let s = shown(self);
    // rust: self.feedback(Text::translate(
    // rust: if is_value {
    // rust: "commands.bossbar.set.value.success"
    // rust: } else {
    // rust: "commands.bossbar.set.max.success"
    // rust: },
    // rust: &[s, num(v)],
    // rust: ));
    // rust: Ok(v)
}
    // rust: "bossbar.set.visible" => {
    // rust: let visible = matches!(ctx.get("visible"), Some(Arg::Bool(true)));
    // rust: let b = self.bosses.bars.get_mut(bar).expect("checked");
    // rust: if b.visible == visible {
    // rust: return Err(err(
    // rust: if visible {
    // rust: "commands.bossbar.set.visibility.unchanged.visible"
    // rust: } else {
    // rust: "commands.bossbar.set.visibility.unchanged.hidden"
    // rust: },
    // rust: &[],
    // rust: ));
}
    // rust: b.visible = visible;
    // rust: let s = shown(self);
    // rust: self.feedback(Text::translate(
    // rust: if visible {
    // rust: "commands.bossbar.set.visible.success.visible"
    // rust: } else {
    // rust: "commands.bossbar.set.visible.success.hidden"
    // rust: },
    // rust: &[s],
    // rust: ));
    // rust: Ok(0)
}
    // rust: _ => {
                // players [<targets>]: replace the set. No argument clears it.
    // rust: let targets = if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", true)?
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let mut uuids = Vec::new();
    // rust: let mut names = Vec::new();
    // rust: for t in &targets {
    // rust: let Some(uuid) = self.player_target_uuid(*t) else {
    // rust: continue;
}
    // rust: if !uuids.contains(&uuid) {
    // rust: uuids.push(uuid);
    // rust: names.push(self.target_name(*t));
}
}
    // rust: let b = self.bosses.bars.get_mut(bar).expect("checked");
    // rust: let mut had = b.players.clone();
    // rust: had.sort();
    // rust: let mut next = uuids.clone();
    // rust: next.sort();
    // rust: if had == next {
    // rust: return Err(err("commands.bossbar.set.players.unchanged", &[]));
}
    // rust: b.players = uuids;
    // rust: let n = b.players.len();
    // rust: let s = shown(self);
    // rust: if n == 0 {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.set.players.success.none",
    // rust: &[s],
    // rust: ));
    // rust: } else {
    // rust: self.feedback(Text::translate(
    // rust: "commands.bossbar.set.players.success.some",
    // rust: &[s, num(targets.len()), format_list(names)],
    // rust: ));
}
    // rust: Ok(n as i32)
}
}
}
    // A component argument as JSON with its selectors resolved.
component_json :: proc(self: ^Self, ctx: ^Context, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Arg::Str(json)) = ctx.get(name) else {
    // rust: return Ok(sb::literal(""));
}
    // rust: let value: Comp =
    // rust: serde_json::from_str(json).map_err(|e| err("argument.component.invalid", &[&e]))?;
    // rust: Ok(self.resolve_component(value))
}

    // Names of the online players in a boss bar's set, in join order.
bossbar_player_names :: proc(self: ^Self, players: ^[[i32; 4]]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.known_boss_players()
    // rust: .into_iter()
    // rust: .filter(|(uuid, _)| players.contains(uuid))
    // rust: .map(|(_, name)| name)
    // rust: .collect()
}
    // The players who can be told about a bar: the one in place, then guests.
known_boss_players :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: if self.player.is_some() {
    // rust: out.push((self.acting_uuid(), self.target_name(Target::Player)));
}
    // rust: if let Some(host) = &self.lan {
    // rust: for g in host.hub.guests.iter().filter(|g| g.placed) {
    // rust: let ints = horizon_client::lan::playerdata::uuid_ints(g.uuid);
    // rust: if out.iter().any(|(uuid, _)| *uuid == ints) {
    // rust: continue;
}
    // rust: out.push((ints, Text::literal(g.name.clone())));
}
}
    // rust: out
}
player_target_uuid :: proc(self: ^Self, target: Target) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match target {
    // rust: Target::Player => Some(self.acting_uuid()),
    // rust: Target::Guest(conn) => self.lan.as_ref().and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .map(|g| horizon_client::lan::playerdata::uuid_ints(g.uuid))
    // rust: }),
    // rust: _ => None,
}
}

    // ---- ServerBossEvent delivery ------------------------------------------------

    // Tell every viewer the boss events they should be seeing. The window
    // that simulates the world applies them to its own overlay; everyone
    // else gets `ClientboundBossEventPacket`s.
    // rust: pub(super) fn publish_boss_bars(&mut self) {
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: self.load_bossbars();
    // rust: let now = boss_overlay::now_millis();
    // rust: let viewers = self.boss_viewers();
    // rust: let live: HashSet<u128> = viewers.iter().map(|v| v.uuid).collect();
    // rust: self.bosses.sent.retain(|id, _| live.contains(id));
    // rust: let mut packets = Vec::new();
    // rust: for viewer in &viewers {
    // rust: let desired = self.boss_events_for(viewer);
    // rust: for event in self.diff_boss_events(viewer, desired) {
    // rust: if viewer.local {
    // rust: self.boss_overlay.apply(&event, now);
    // rust: } else if let Some(conn) = viewer.conn {
    // rust: packets.push((conn, C::BossEvent(event)));
}
}
}
    // rust: if packets.is_empty() {
    // rust: return;
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return;
}
    // rust: for (conn, packet) in &packets {
    // rust: host.hub.send_to(*conn, packet);
}
}
boss_viewers :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
        // While `as_guest` has swapped a guest in, the host's own position
        // is not in place. Their overlay updates once the tick puts it back.
    // rust: let local =
    // rust: self.serving.is_none() && self.options.dedicated.is_none() && self.lan_acting.is_none();
    // rust: if local && let Some(p) = &self.player {
    // rust: let ints = self.level.player_uuid.unwrap_or_else(|| self.acting_uuid());
    // rust: out.push(Viewer {
    // rust: uuid: horizon_client::lan::playerdata::ints_uuid(ints),
    // rust: ints,
    // rust: at: [p.position.x, p.position.y, p.position.z],
    // rust: alive: !p.health.dead_or_dying(),
    // rust: here: true,
    // rust: local: true,
    // rust: conn: None,
    // rust: view_chunks: self.settings.render_distance,
    // rust: });
}
    // rust: if let Some(host) = &self.lan {
    // rust: for g in host.hub.guests.iter().filter(|g| g.placed) {
    // rust: if out.iter().any(|v| v.uuid == g.uuid) {
    // rust: continue;
}
    // rust: out.push(Viewer {
    // rust: uuid: g.uuid,
    // rust: ints: horizon_client::lan::playerdata::uuid_ints(g.uuid),
    // rust: at: g.position,
    // rust: alive: !g.dead,
    // rust: here: g.dimension == self.dim.id(),
    // rust: local: false,
    // rust: conn: Some(g.conn),
    // rust: view_chunks: g.view_distance,
    // rust: });
}
}
    // rust: out
}
    // Custom bars (`CustomBossEvents.onPlayerConnect` sends them as a player
    // joins), then the dragon, withers and the raid.
boss_events_for :: proc(self: ^Self, viewer: ^Viewer) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for b in &self.bosses.bars.bars {
    // rust: if !b.visible || !b.players.contains(&viewer.ints) {
    // rust: continue;
}
    // rust: out.push(Offer {
    // rust: id: b.uuid,
    // rust: name: json_to_tag(&b.name),
    // rust: progress: b.progress(),
    // rust: color: color_index(&b.color),
    // rust: overlay: style_index(&b.style),
    // rust: darken: b.darken,
    // rust: music: b.music,
    // rust: fog: b.fog,
    // rust: scope: Scope::Global,
    // rust: });
}
    // rust: if viewer.here
    // rust: && let Some(progress) = self.dragon_boss_progress(viewer.at, viewer.alive)
    // rust: {
    // rust: out.push(Offer {
    // rust: id: bossbar::stable_uuid("minecraft:ender_dragon"),
    // rust: name: translate_tag("entity.minecraft.ender_dragon"),
    // rust: progress,
    // rust: color: 0,
    // rust: overlay: 0,
    // rust: darken: false,
    // rust: music: true,
    // rust: fog: true,
    // rust: scope: Scope::Level(self.dim),
    // rust: });
}
    // rust: if viewer.here {
    // rust: let range = f64::from(10.min(viewer.view_chunks.max(0)) * 16);
    // rust: for m in self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.species() == Species::Wither && m.alive() && !m.removed)
    // rust: {
    // rust: let (dx, dz) = (m.position.x - viewer.at[0], m.position.z - viewer.at[2]);
    // rust: if dx * dx + dz * dz > range * range {
    // rust: continue;
}
    // rust: let progress = if m.extra.counter > 0 {
    // rust: 1.0 - m.extra.counter as f32 / horizon_client::mobs::wither::INVULNERABLE as f32
    // rust: } else {
    // rust: (m.health / m.attrs.max_health).clamp(0.0, 1.0)
}
    // rust: let name = if let Some(text) = &m.custom_name_text {
    // rust: json_to_tag(&text.component())
    // rust: } else if let Some(name) = &m.custom_name {
    // rust: Tag::String(name.as_str().into())
    // rust: } else {
    // rust: translate_tag("entity.minecraft.wither")
}
    // rust: out.push(Offer {
    // rust: id: super::lan::entity_uuid(m.id),
    // rust: name,
    // rust: progress,
    // rust: color: 5,
    // rust: overlay: 0,
    // rust: darken: true,
    // rust: music: false,
    // rust: fog: false,
    // rust: scope: Scope::Level(self.dim),
    // rust: });
}
}
    // rust: if viewer.here
    // rust: && let Some((id, name, progress)) = self.raid_boss_at(viewer.at, viewer.alive)
    // rust: {
    // rust: out.push(Offer {
    // rust: id: bossbar::stable_uuid(&format!("raid:{id}")),
    // rust: name,
    // rust: progress,
    // rust: color: 2,
    // rust: overlay: 2,
    // rust: darken: false,
    // rust: music: false,
    // rust: fog: false,
    // rust: scope: Scope::Level(self.dim),
    // rust: });
}
    // rust: out
}
    // The packets that take `viewer` from what it was last sent to `desired`
    // (`ServerBossEvent`'s broadcasts).
diff_boss_events :: proc(self: ^Self, viewer: ^Viewer, desired: [dynamic]Offer) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let full = viewer.local;
    // rust: let dim = self.dim;
    // rust: let sent = self.bosses.sent.entry(viewer.uuid).or_default();
    // rust: let mut out = Vec::new();
    // rust: let event = |id, action| play::BossEvent { id, action };
    // rust: sent.retain(|id, prev| {
    // rust: let owned = full || prev.scope == Scope::Global || prev.scope == Scope::Level(dim);
    // rust: let keep = !owned || desired.iter().any(|e| e.id == *id);
    // rust: if !keep {
    // rust: out.push(event(*id, BossAction::Remove));
}
    // rust: keep
    // rust: });
    // rust: for offer in desired {
    // rust: let Some(prev) = sent.get(&offer.id) else {
    // rust: out.push(event(
    // rust: offer.id,
    // rust: BossAction::Add {
    // rust: name: offer.name.clone(),
    // rust: progress: offer.progress,
    // rust: color: offer.color,
    // rust: overlay: offer.overlay,
    // rust: darken: offer.darken,
    // rust: music: offer.music,
    // rust: fog: offer.fog,
    // rust: },
    // rust: ));
    // rust: sent.insert(offer.id, offer);
    // rust: continue;
}
    // rust: let id = offer.id;
    // rust: if prev.progress != offer.progress {
    // rust: let progress = offer.progress;
    // rust: out.push(event(id, BossAction::UpdateProgress { progress }));
}
    // rust: if prev.name != offer.name {
    // rust: let name = offer.name.clone();
    // rust: out.push(event(id, BossAction::UpdateName { name }));
}
    // rust: if (prev.color, prev.overlay) != (offer.color, offer.overlay) {
    // rust: let (color, overlay) = (offer.color, offer.overlay);
    // rust: out.push(event(id, BossAction::UpdateStyle { color, overlay }));
}
    // rust: if (prev.darken, prev.music, prev.fog) != (offer.darken, offer.music, offer.fog) {
    // rust: let (darken, music, fog) = (offer.darken, offer.music, offer.fog);
    // rust: out.push(event(
    // rust: id,
    // rust: BossAction::UpdateProperties { darken, music, fog },
    // rust: ));
}
    // rust: sent.insert(id, offer);
}
    // rust: out
}
    // `ClientPacketListener.handleBossUpdate`.
    // rust: pub(super) fn apply_boss_event(&mut self, packet: &play::BossEvent) {
    // rust: self.boss_overlay.apply(packet, boss_overlay::now_millis());
}
}

// `Mth.createInsecureUUID`.
insecure_uuid :: proc(random: ^impl RandomSource) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let most = random.next_long() & -61441 | 16384;
    // rust: let least = random.next_long() & 4_611_686_018_427_387_903 | i64::MIN;
    // rust: ((most as u64 as u128) << 64) | (least as u64 as u128)
}
translate_tag :: proc(key: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([("translate", Tag::String(key.into()))])
}
color_index :: proc(color: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: bossbar::COLORS
    // rust: .iter()
    // rust: .position(|c| *c == color)
    // rust: .unwrap_or(6) as i32
}
style_index :: proc(style: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: bossbar::STYLES
    // rust: .iter()
    // rust: .position(|s| *s == style)
    // rust: .unwrap_or(0) as i32
}

Scope :: enum {
    Global,
    Level(Dim),
}
Viewer :: struct {
    uuid: u128,
    ints: [i32,
    at: [f64,
    alive: bool,
    here: bool,
    local: bool,
    conn: Maybe(u32),
    view_chunks: i32,
}
// A boss event as one viewer should see it, and as it was last sent.
Offer :: struct {
    id: u128,
    name: Tag,
    progress: f32,
    // `BossBarColor` and `BossBarOverlay` ordinals.
    color: i32,
    overlay: i32,
    darken: bool,
    music: bool,
    fog: bool,
    scope: Scope,
}

    // rust: mod listing_tests {
//     use super::*;

ids :: proc(state: ^BossState) -> V {
    // Ported from Horizon
    return {}
}
    // rust: state
    // rust: .listed_bars()
    // rust: .into_iter()
    // rust: .map(|bar| bar.id.as_str())
    // rust: .collect()
}

bossbar_listing_uses_identifier_hash_order_and_current_names :: proc() {
}
    // rust: let mut state = BossState::default();
    // rust: state.add_bar("audit:test", sb::literal("Title"));
    // rust: state.bars.get_mut("audit:test").unwrap().name = sb::literal("Other");
    // rust: state.add_bar("audit:second", sb::literal("Second"));
    // rust: assert_eq!(ids(&state), ["audit:second", "audit:test"]);
    // rust: let names: Vec<_> = state
    // rust: .listed_bars()
    // rust: .into_iter()
    // rust: .map(|b| b.name.clone())
    // rust: .collect();
    // rust: assert_eq!(names, [sb::literal("Second"), sb::literal("Other")]);
}

bossbar_listing_retains_resize_history_after_removals :: proc() {
}
    // rust: let mut state = BossState::default();
    // rust: state.add_bar("audit:test", sb::literal("Title"));
    // rust: state.add_bar("audit:second", sb::literal("Second"));
    // rust: for i in 0..11 {
    // rust: state.add_bar(&format!("audit:bar{i}"), sb::literal("Extra"));
}
    // rust: for i in 0..11 {
    // rust: state.remove_bar(&format!("audit:bar{i}"));
}
        // After the 13th put, HashMap keeps its 32-slot table. These keys
        // occupy buckets 11 and 24, rather than buckets 11 and 8 at size 16.
    // rust: assert_eq!(ids(&state), ["audit:test", "audit:second"]);
    // rust: state.remove_bar("audit:test");
    // rust: state.remove_bar("audit:second");
    // rust: assert!(ids(&state).is_empty());
    // rust: state.add_bar("audit:test", sb::literal("Again"));
    // rust: state.add_bar("audit:second", sb::literal("Second"));
    // rust: assert_eq!(ids(&state), ["audit:test", "audit:second"]);
}

bossbar_listing_rebuilds_for_the_loaded_store :: proc() {
}
    // rust: let mut state = BossState::default();
    // rust: state.bars.add("audit:test", sb::literal("Title"));
    // rust: state.bars.add("audit:second", sb::literal("Second"));
    // rust: state.rebuild_listing();
    // rust: assert_eq!(ids(&state), ["audit:second", "audit:test"]);
}
}
