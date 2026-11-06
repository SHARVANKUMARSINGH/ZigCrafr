//! Transpiled from Horizon Rust crate
//! Module: horizon-client_scoreboard
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The scoreboard in the running game: saved data, criteria that follow the
//! player (health, food, xp, deaths, kills, statistics), score holders for
//! entities, the selector options `scores=`, `team=` and `tag=`, the
//! commands' [`Env`] and the sidebar.
// use super::{Game, chat::PLAYER_NAME, commands::Target};
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: command::{
    // rust: Context,
    // rust: args::{IntRange, Selector},
    // rust: },
    // rust: hud::HudBatch,
    // rust: hud_layout, hud_overlays,
    // rust: lan::{guest::Guest, playerdata::ints_uuid},
    // rust: save::{self, uuid_from_text, uuid_text},
    // rust: scoreboard::{self as sb, Comp, Scoreboard, literal},
    // rust: scoreboard_cmd::{self, Env, Holder},
    // rust: tab_list::TabPlayer,
    // rust: text::Text,
}
// use horizon_world::nbt::Tag;
// use std::collections::{HashMap, HashSet};

/// What `ServerPlayer` last recorded for the criteria that follow the player.
    // rust: pub(super) struct Recorded {
    /// `lastRecordedHealthAndAbsorption` (compared as a float).
    // rust: health_and_absorption: Option<f32>,
    // rust: food: Option<i32>,
    // rust: air: Option<i32>,
    // rust: armor: Option<i32>,
    // rust: xp: Option<i32>,
    // rust: level: Option<i32>,
}
    // rust: impl Recorded {
    /// The food, air, armor, xp and level criteria whose value differs from the last
    /// recorded one, recorded as they are returned (`ServerPlayer.doTick`).
    // rust: fn changed_scores(
    // rust: &mut self,
    // rust: food: i32,
    // rust: air: i32,
    // rust: armor: i32,
    // rust: xp: i32,
    // rust: level: i32,
    // rust: ) -> Vec<(&'static str, i32)> {
    // rust: let mut out = Vec::new();
    // rust: for (criteria, last, value) in [
    // rust: (sb::CRITERIA_FOOD, &mut self.food, food),
    // rust: (sb::CRITERIA_AIR, &mut self.air, air),
    // rust: (sb::CRITERIA_ARMOR, &mut self.armor, armor),
    // rust: (sb::CRITERIA_XP, &mut self.xp, xp),
    // rust: (sb::CRITERIA_LEVEL, &mut self.level, level),
    // rust: ] {
    // rust: if *last != Some(value) {
    // rust: *last = Some(value);
    // rust: out.push((criteria, value));
}
}
    // rust: out
}
}
    // rust: pub(super) struct ScoreState {
    // rust: pub board: Scoreboard,
    /// `/data ... storage`.
    // rust: pub storage: horizon_client::command_storage::CommandStorage,
    // rust: pub stopwatches: horizon_client::stopwatches::Stopwatches,
    // rust: loaded: bool,
    // rust: recorded: Recorded,
}

pub fn in_range(v: i32) void {
}
    // rust: lo.is_none_or(|l| v >= l) && hi.is_none_or(|h| v <= h)
}

/// `TamableAnimal.getTeam`: a pet's own team, else, when it is tamed, its root
/// owner's, else none. An untamed pet has no owner to take one from.
    // rust: fn pet_team<'a>(board: &'a Scoreboard, own: &str, owner: Option<&str>) -> Option<&'a sb::Team> {
    // rust: board
    // rust: .players_team(own)
    // rust: .or_else(|| board.players_team(owner?))
}
/// A tamed pet's owner (`TamableAnimal.getOwnerReference` while `isTame`).
pub fn tame_owner(m: *horizon_client::mobs::Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.tame.then_some(m.extra.owner).flatten()
}
/// `TamableAnimal.getRootOwner`: the owner, or that owner's own root owner
/// while it is a tamed pet itself. `pet_owner` is the owner of the tamed pet
/// with a UUID, if it has one.
pub fn root_owner(mut owner: [i32; 4], pet_owner: impl Fn([i32; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // shortcut: vanilla has no cycle check, this bound stops a hand-made loop.
    // rust: for _ in 0..64 {
    // rust: match pet_owner(owner) {
    // rust: Some(next) => owner = next,
    // rust: None => break,
}
}
    // rust: owner
}

    // rust: impl Game<'_> {
pub fn scoreboard_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_root.join("data/minecraft/scoreboard.dat")
}
pub fn border_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: save::dimension_dir(&self.world_root, "minecraft:overworld")
    // rust: .join("data/minecraft/world_border.dat")
}
    /// `ScoreboardSaveData` read from `data/minecraft/scoreboard.dat`.
    // rust: pub(super) fn load_scoreboard(&mut self) {
    // rust: if self.score.loaded || self.remote.is_some() {
    // rust: return;
}
    // rust: self.score.loaded = true;
    // rust: if let Some(root) = save::read_dat(&self.scoreboard_path())
    // rust: && let Some(data) = root.get("data")
    // rust: {
    // rust: self.score.board = Scoreboard::unpack(data);
}
    // rust: self.score.storage =
    // rust: horizon_client::command_storage::CommandStorage::load(&self.world_root);
        // ServerLevel.getWorldBorder: each dimension's data/minecraft/world_border.dat. Horizon
        // keeps one border, so the overworld's file stands for it; the root file is what
        // older Horizon builds wrote.
    // rust: let border_path = self.border_path();
    // rust: if let Some(root) = save::read_dat(&border_path)
    // rust: .or_else(|| save::read_dat(&self.world_root.join("data/minecraft/world_border.dat")))
    // rust: && let Some(data) = root.get("data")
    // rust: {
    // rust: self.border = horizon_client::worldborder::WorldBorder::unpack(data);
}
    // rust: self.score.stopwatches = horizon_client::stopwatches::Stopwatches::load(&self.world_root);
    // rust: self.sync_score_registries();
}
    // rust: pub(super) fn save_scoreboard(&mut self) {
    // rust: if !self.score.loaded || self.remote.is_some() {
    // rust: return;
}
    // rust: self.score.storage.save(&self.world_root);
    // rust: self.score.stopwatches.save(&self.world_root);
    // rust: if self.border != horizon_client::worldborder::WorldBorder::default()
    // rust: && let Err(e) = save::write_dat(
    // rust: &self.border_path(),
    // rust: Tag::compound([
    // rust: ("data", self.border.pack()),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]),
    // rust: )
    // rust: {
    // rust: log::warn!("the world border was not written: {e}");
}
    // rust: let path = self.scoreboard_path();
    // rust: let board = &self.score.board;
    // rust: if board == &Scoreboard::default() && !path.exists() {
    // rust: return;
}
    // rust: if let Err(e) = save::write_dat(
    // rust: &path,
    // rust: Tag::compound([
    // rust: ("data", board.pack()),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]),
    // rust: ) {
    // rust: log::warn!("the scoreboard was not written: {e}");
}
}
    /// The names commands complete: objectives, teams and tracked holders.
    // rust: pub(super) fn sync_score_registries(&mut self) {
    // rust: let board = &self.score.board;
    // rust: let reg = &mut self.ui.registries;
    // rust: reg.objectives = board.objectives.iter().map(|o| o.name.clone()).collect();
        // Trigger objectives: the locks `/trigger` and `scoreboard players enable` complete from.
    // rust: reg.trigger_scores.clear();
    // rust: for o in board.objectives.iter().filter(|o| o.criteria == "trigger") {
    // rust: let locks = board
    // rust: .scores
    // rust: .iter()
    // rust: .filter_map(|(holder, s)| s.get(&o.name).map(|s| (holder.clone(), s.locked)))
    // rust: .collect();
    // rust: reg.trigger_scores.insert(o.name.clone(), locks);
}
    // rust: reg.trigger_objectives = reg
    // rust: .trigger_scores
    // rust: .iter()
    // rust: .filter(|(_, locks)| locks.get(PLAYER_NAME) == Some(&false))
    // rust: .map(|(o, _)| o.clone())
    // rust: .collect();
    // rust: reg.teams = board.teams.iter().map(|t| t.name.clone()).collect();
    // rust: reg.tracked = board.tracked();
    // rust: reg.storages = self.score.storage.keys();
    // rust: reg.stopwatches = self.score.stopwatches.ids();
}

    // ---- score holders ---------------------------------------------------

    /// `ScoreHolder.getScoreboardName`: the player's name, an entity's UUID.
    // rust: pub(super) fn holder_name(&mut self, t: Target) -> Option<String> {
    // rust: match t {
    // rust: Target::Player => Some(self.acting_player_name().to_owned()),
    // rust: Target::Guest(conn) => self.command_guest(conn).map(|g| g.name.clone()),
    // rust: Target::Mob(id)
    // rust: | Target::Item(id)
    // rust: | Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Painting(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
    // rust: | Target::Crystal(id)
    // rust: | Target::Dragon(id)
    // rust: | Target::Tnt(id)
    // rust: | Target::Falling(id)
    // rust: | Target::Rocket(id)
    // rust: | Target::Trident(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id)
    // rust: | Target::Cloud(id) => Some(uuid_text(self.uuid_for(id))),
            // It keeps its UUID with itself.
    // rust: Target::Spawner(id) => self
    // rust: .ominous_spawners
    // rust: .iter()
    // rust: .find(|s| s.id == id)
    // rust: .map(|s| uuid_text(s.uuid)),
            // Orbs and projectiles have no UUID here.
    // rust: Target::Orb(_) | Target::Projectile(_) => None,
}
}
pub fn holder_for(self: *Self, t: Target) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = self.holder_name(t)?;
    // rust: let shown = self.target_name(t);
    // rust: Some(Holder {
    // rust: display: Some(literal(&shown.plain())),
    // rust: text: shown,
    // rust: name,
    // rust: })
}
    /// The entity with the given scoreboard name.
pub fn target_of_holder(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name == self.acting_player_name() {
    // rust: return Some(Target::Player);
}
    // rust: let uuid = uuid_from_text(name).filter(|_| name.len() == 36)?;
    // rust: self.target_with_uuid(uuid)
}
    /// `Entity.getTags` (the `Tags` list of the saved entity).
    // rust: pub(super) fn tags_of(&self, t: Target) -> Vec<String> {
    // rust: let raw = match t {
    // rust: Target::Mob(id)
    // rust: | Target::Item(id)
    // rust: | Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Painting(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
    // rust: | Target::Tnt(id)
    // rust: | Target::Orb(id)
    // rust: | Target::Projectile(id)
    // rust: | Target::Crystal(id)
    // rust: | Target::Dragon(id)
    // rust: | Target::Rocket(id)
    // rust: | Target::Trident(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id)
    // rust: | Target::Cloud(id) => self.persist.raw.get(&id),
    // rust: Target::Player => self.level.player_extra.as_ref(),
            // A server's player: the saved compound the guest's file is written from.
    // rust: Target::Guest(conn) => self.command_guest(conn).and_then(|g| g.saved.as_ref()),
    // rust: Target::Spawner(id) => self
    // rust: .ominous_spawners
    // rust: .iter()
    // rust: .find(|s| s.id == id)
    // rust: .and_then(|s| s.raw.as_deref()),
    // rust: Target::Falling(id) => self
    // rust: .falling
    // rust: .iter()
    // rust: .find(|f| f.id == id)
    // rust: .and_then(|f| f.saved.as_ref().map(|s| &s.1)),
}
    // rust: match raw.and_then(|r| r.get("Tags")) {
    // rust: Some(Tag::List(l)) => l
    // rust: .iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
    /// The selector options that need the scoreboard or entity data: which
    /// of `candidates` pass `scores=`, `team=` and `tag=`.
    // rust: pub(super) fn selector_extra_filter(
    // rust: &mut self,
    // rust: candidates: &[Target],
    // rust: s: &Selector,
    // rust: ) -> HashSet<Target> {
    // rust: let mut pass = HashSet::new();
    // rust: let needs_holder = !s.scores.is_empty() || !s.teams.is_empty();
    // rust: for &t in candidates {
    // rust: let mut ok = true;
    // rust: if needs_holder {
    // rust: let holder = self.holder_name(t);
    // rust: for (objective, range) in &s.scores {
    // rust: let value = holder
    // rust: .as_deref()
    // rust: .and_then(|h| self.score.board.score(h, objective))
    // rust: .map(|score| score.value);
    // rust: if !value.is_some_and(|v| in_range(v, *range)) {
    // rust: ok = false;
}
}
    // rust: let team = holder
    // rust: .as_deref()
    // rust: .and_then(|h| self.score.board.players_team(h))
    // rust: .map(|t| t.name.clone());
    // rust: for (want, negated) in &s.teams {
    // rust: let matches = match &team {
    // rust: Some(name) => name == want,
    // rust: None => want.is_empty(),
}
    // rust: if matches == *negated {
    // rust: ok = false;
}
}
}
    // rust: if !s.tags.is_empty() {
    // rust: let tags = self.tags_of(t);
    // rust: for (tag, negated) in &s.tags {
    // rust: let has = if tag.is_empty() {
    // rust: !tags.is_empty()
    // rust: } else {
    // rust: tags.contains(tag)
}
    // rust: if has == *negated {
    // rust: ok = false;
}
}
}
    // rust: if ok && !s.nbt.is_empty() {
                // NbtPredicate: the entity's saved data contains the pattern.
    // rust: let data = self.entity_nbt(t);
    // rust: for (pattern, negated) in &s.nbt {
    // rust: let matches = match (&data, horizon_world::nbt::parse_snbt(pattern)) {
    // rust: (Some(d), Ok((p, _))) => horizon_client::nbt_path::compare_nbt(&p, Some(d)),
    // rust: _ => false,
}
    // rust: if matches == *negated {
    // rust: ok = false;
}
}
}
    // rust: if ok && !s.predicates.is_empty() {
                // EntityPredicates: the datapack predicate with the entity as
                // `this` and the entity's position as origin.
    // rust: self.ensure_datapacks();
                // The player's records only as far as the predicates may ask.
    // rust: let asked = (s.predicates.iter())
    // rust: .filter_map(|(id, _)| self.fns.store.predicates.get(id))
    // rust: .fold(
    // rust: Default::default(),
    // rust: |all: horizon_client::advancements::FactsAsked, p| {
    // rust: all.or(horizon_client::advancements::facts_asked_in(p))
    // rust: },
    // rust: );
    // rust: let view = self.entity_view_asking(t, asked);
    // rust: let origin = self.target_position(t).unwrap_or_default();
    // rust: for (id, negated) in &s.predicates {
                    // EntitySelectorOptions rejects a missing registry entry
                    // before applying the predicate's negation.
    // rust: let Some(json) = self.fns.store.predicates.get(id) else {
    // rust: ok = false;
    // rust: break;
}
    // rust: let matches = self.conditions_hold(json, Some(&view), origin);
    // rust: if matches == *negated {
    // rust: ok = false;
}
}
}
    // rust: if ok && !s.advancements.is_empty() {
    // rust: ok = t == Target::Player && self.advancements_match(&s.advancements);
}
    // rust: if ok {
    // rust: pass.insert(t);
}
}
    // rust: pass
}

    /// `advancements=` of a selector, against the player's progress.
    // rust: fn advancements_match(
    // rust: &self,
    // rust: wanted: &[(String, horizon_client::command::args::AdvCondition)],
    // rust: ) -> bool {
//         use horizon_client::command::args::AdvCondition;
    // rust: wanted.iter().all(|(id, cond)| {
    // rust: let Some(a) = self.adv.tree.get(id) else {
    // rust: return false;
}
    // rust: match cond {
    // rust: AdvCondition::Done(want) => self.adv.progress.done(a) == *want,
    // rust: AdvCondition::Criteria(list) => list
    // rust: .iter()
    // rust: .all(|(c, want)| self.adv.progress.has(id, c) == *want),
}
    // rust: })
}

    // ---- criteria ----------------------------------------------------------

    /// `ServerStatsCounter.setValue`'s scoreboard side: the objectives of
    /// each changed statistic's criteria follow it for the player `name`.
    // rust: pub(super) fn stat_criteria_changed(
    // rust: &mut self,
    // rust: name: &str,
    // rust: events: Vec<(String, String, Option<i32>)>,
    // rust: ) {
    // rust: let board = &mut self.score.board;
    // rust: if board.objectives.is_empty() {
    // rust: return;
}
    // rust: for (ty, key, amount) in events {
    // rust: let criteria = sb::stat_criteria(&ty, &key);
    // rust: if board.has_objectives_for(&criteria) {
    // rust: board.for_all_objectives(&criteria, name, |v| {
    // rust: amount.map_or(0, |n| v.wrapping_add(n))
    // rust: });
}
}
}
    /// `ServerScoreboard`'s packets: each placed player's client is sent
    /// what changed on the board since it was last sent it (all of it on
    /// joining), lan/scoreboard.rs.
    // rust: pub(super) fn lan_sync_scoreboard(&mut self, host: &mut super::lan::LanHost) {
    // rust: if host.hub.guests.iter().all(|g| !g.placed) {
    // rust: return;
}
    // rust: self.load_scoreboard();
    // rust: host.hub.teams.clone_from(&self.score.board.teams);
    // rust: let view = horizon_client::lan::scoreboard::View::of(&self.score.board);
    // rust: for g in host.hub.guests.iter_mut().filter(|g| g.placed) {
    // rust: if g.scoreboard != view {
    // rust: g.send_all(&g.scoreboard.changes(&view));
    // rust: g.scoreboard = view.clone();
}
}
}
    /// `ServerPlayer.doTick` score updates and the statistic criteria.
    // rust: pub(super) fn tick_scoreboard(&mut self) {
    // rust: self.load_scoreboard();
    // rust: let events = std::mem::take(&mut self.stats.events);
    // rust: self.stat_criteria_changed(PLAYER_NAME, events);
    // rust: let mut rec = std::mem::take(&mut self.score.recorded);
    // rust: self.record_player_scores(&mut rec);
    // rust: self.score.recorded = rec;
    // rust: if self.ticks.is_multiple_of(20) {
    // rust: self.sync_score_registries();
}
}
    /// `ServerPlayer.doTick`'s `updateScoreForCriteria` calls for the acting
    /// player (the host's own, or a guest swapped in): the health, food, air,
    /// armor, experience and level objectives follow what changed since `rec`.
    // rust: pub(super) fn record_player_scores(&mut self, rec: &mut Recorded) {
    // rust: self.load_scoreboard();
    // rust: if self.score.board.objectives.is_empty() {
    // rust: return;
}
    // rust: let display = self.player_display_comp();
    // rust: let name = self.acting_player_name().to_owned();
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: return;
}
    // rust: let health_and_absorption = p.health.health() + p.health.absorption();
    // rust: let food = p.health.food.food;
    // rust: let air = p.air;
        // getArmorValue: the armor attribute rounded down.
    // rust: let armor = p
    // rust: .attribute("minecraft:armor")
    // rust: .or_else(|_| p.attribute("armor"))
    // rust: .unwrap_or(0.0)
    // rust: .floor() as i32;
    // rust: let board = &mut self.score.board;
    // rust: if rec.health_and_absorption != Some(health_and_absorption) {
    // rust: rec.health_and_absorption = Some(health_and_absorption);
    // rust: let value = health_and_absorption.ceil() as i32;
    // rust: board.for_all_objectives_with(sb::CRITERIA_HEALTH, &name, Some(&display), |_| value);
}
    // rust: let (xp, level) = (self.experience.total, self.experience.level);
    // rust: for (criteria, value) in rec.changed_scores(food, air, armor, xp, level) {
    // rust: board.for_all_objectives_with(criteria, &name, Some(&display), |_| value);
}
}
    /// `ServerPlayer.die`: the acting player's `deathCount` objectives go up by one.
    // rust: pub(super) fn score_player_died(&mut self) {
    // rust: let display = self.player_display_comp();
    // rust: let me = self.acting_player_name().to_owned();
    // rust: self.score.board.for_all_objectives_with(
    // rust: sb::CRITERIA_DEATH_COUNT,
    // rust: &me,
    // rust: Some(&display),
    // rust: |v| v.wrapping_add(1),
    // rust: );
}
    /// `ServerPlayer.awardKillScore`: total kills and the team kill counts.
    // rust: pub(super) fn score_player_killed(&mut self, victim: Target) {
    // rust: let victim_name = self.holder_name(victim);
    // rust: let display = self.player_display_comp();
    // rust: let me = self.acting_player_name().to_owned();
    // rust: let board = &mut self.score.board;
    // rust: let inc = |v: i32| v.wrapping_add(1);
    // rust: board.for_all_objectives_with(sb::CRITERIA_TOTAL_KILLS, &me, Some(&display), inc);
    // rust: if victim == Target::Player {
    // rust: board.for_all_objectives_with(sb::CRITERIA_PLAYER_KILLS, &me, Some(&display), inc);
}
    // rust: let color_of =
    // rust: |board: &Scoreboard, name: &str| board.players_team(name).and_then(|t| t.color.clone());
    // rust: if let Some(victim_name) = victim_name {
    // rust: if let Some(color) = color_of(board, &victim_name) {
    // rust: let criteria = format!("teamkill.{color}");
    // rust: board.for_all_objectives_with(&criteria, &me, Some(&display), inc);
}
    // rust: if let Some(color) = color_of(board, &me) {
    // rust: let criteria = format!("killedByTeam.{color}");
    // rust: board.for_all_objectives(&criteria, &victim_name, inc);
}
}
}
    /// `Scoreboard.entityRemoved`: a dead non-player entity leaves the board.
    // rust: pub(super) fn score_entity_removed(&mut self, id: u32) {
    // rust: let Some(uuid) = self.persist.uuids.get(&id).copied() else {
    // rust: return;
}
    // rust: self.score.board.entity_removed(&uuid_text(uuid));
}

    // ---- teams in gameplay -----------------------------------------------------

    /// `Entity.getScoreboardName`: another player's profile name
    /// (`Player.getScoreboardName`), any other entity's UUID.
pub fn scoreboard_name(self: *Self, id: u32, uuid: [i32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote_player_name(id)
    // rust: .map_or_else(|| uuid_text(uuid), str::to_owned)
}
    /// `TamableAnimal.getTeam` of a mob or another player: its own team, else,
    /// when it is a tamed pet, its root owner's.
    // rust: pub(super) fn mob_team(&self, id: u32) -> Option<&sb::Team> {
    // rust: if self.score.board.teams.is_empty() {
    // rust: return None;
}
        // The mob is looked up only when its own name has no team: the
        // owner's team is the fallback.
    // rust: self.team_with_owner(id, || {
    // rust: self.mobs.iter().find(|m| m.id == id).and_then(tame_owner)
    // rust: })
}
    /// [`mob_team`](Self::mob_team) of a mob at hand, without looking it up.
    // rust: pub(super) fn mob_team_of(&self, m: &horizon_client::mobs::Mob) -> Option<&sb::Team> {
    // rust: if self.score.board.teams.is_empty() {
    // rust: return None;
}
    // rust: self.team_with_owner(m.id, || tame_owner(m))
}
    /// A mob's own team, else its tamed owner's (`owner` is asked only then).
    // rust: fn team_with_owner(
    // rust: &self,
    // rust: id: u32,
    // rust: owner: impl FnOnce() -> Option<[i32; 4]>,
    // rust: ) -> Option<&sb::Team> {
    // rust: let uuid = *self.persist.uuids.get(&id)?;
    // rust: let own = self.scoreboard_name(id, uuid);
    // rust: if let Some(team) = self.score.board.players_team(&own) {
    // rust: return Some(team);
}
    // rust: let owner = owner().and_then(|o| self.root_owner_name(o));
    // rust: pet_team(&self.score.board, &own, owner.as_deref())
}
    /// `TamableAnimal.getRootOwner().getScoreboardName`: a pet's owner, through
    /// owners that are tamed pets themselves.
pub fn root_owner_name(self: *Self, owner: [i32; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pet_owner = |uuid: [i32; 4]| {
    // rust: let Target::Mob(pet) = self.target_by_uuid(ints_uuid(uuid))? else {
    // rust: return None;
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == pet && m.extra.tame)?
    // rust: .extra
    // rust: .owner
}
    // rust: let root = root_owner(owner, pet_owner);
    // rust: Some(match self.target_by_uuid(ints_uuid(root))? {
    // rust: Target::Player => self.acting_player_name().to_owned(),
    // rust: Target::Guest(conn) => self.command_guest(conn)?.name.clone(),
    // rust: Target::Mob(id) => self.scoreboard_name(id, root),
    // rust: _ => uuid_text(root),
    // rust: })
}
    // rust: pub(super) fn player_team(&self) -> Option<&sb::Team> {
    // rust: self.score.board.players_team(self.acting_player_name())
}
    /// The teams of the player and of the mobs on one (empty without teams).
    // rust: pub(super) fn mob_teams(&self) -> horizon_client::mobs::Teams<'_> {
    // rust: if self.score.board.teams.is_empty() {
    // rust: return Default::default();
}
        // One pass over the mobs, not one per mob.
    // rust: let tame_owners: HashMap<u32, [i32; 4]> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter_map(|m| Some((m.id, tame_owner(m)?)))
    // rust: .collect();
    // rust: horizon_client::mobs::Teams {
    // rust: player: self.player_team(),
    // rust: mobs: self
    // rust: .persist
    // rust: .uuids
    // rust: .keys()
    // rust: .filter_map(|id| {
    // rust: let owner = || tame_owners.get(id).copied();
    // rust: Some((*id, self.team_with_owner(*id, owner)?))
    // rust: })
    // rust: .collect(),
}
}
    /// The mobs on the player's team (`isAlliedTo`).
    // rust: pub(super) fn player_allies(&self) -> HashSet<u32> {
    // rust: let Some(team) = self.player_team() else {
    // rust: return HashSet::new();
}
    // rust: self.persist
    // rust: .uuids
    // rust: .iter()
    // rust: .filter(|(id, uuid)| team.players.contains(&self.scoreboard_name(**id, **uuid)))
    // rust: .map(|(id, _)| *id)
    // rust: .collect()
}
    /// `Player.getDisplayName`: the name with the team's prefix, suffix and colour.
    // rust: pub(super) fn player_display_comp(&self) -> Comp {
    // rust: let name = literal(self.acting_player_name());
    // rust: match self.player_team() {
    // rust: Some(t) => t.formatted_name_comp(&name),
    // rust: None => name,
}
}
    // rust: pub(super) fn player_display_text(&self) -> Text {
    // rust: let name = Text::literal(self.acting_player_name());
    // rust: match self.player_team() {
    // rust: Some(t) => t.formatted_name(name),
    // rust: None => name,
}
}

    // ---- commands ------------------------------------------------------------

    /// The scoreboard names a score holder argument resolves to.
    // rust: pub(super) fn score_holder_names(
    // rust: &mut self,
    // rust: ctx: &Context,
    // rust: name: &str,
    // rust: default_wildcard: bool,
    // rust: ) -> super::commands::R<Vec<String>> {
    // rust: let mut env = GameEnv { g: self };
    // rust: Ok(
    // rust: scoreboard_cmd::holders(ctx, name, &mut env, default_wildcard)?
    // rust: .into_iter()
    // rust: .map(|h| h.name)
    // rust: .collect(),
    // rust: )
}
    // rust: pub(super) fn cmd_scoreboard(&mut self, id: &str, ctx: &Context) -> super::commands::R<i32> {
    // rust: let mut env = GameEnv { g: self };
    // rust: let result = scoreboard_cmd::execute(id, ctx, &mut env).unwrap_or_else(|| {
    // rust: Err(horizon_client::command::CommandError::tr(
    // rust: "command.failed",
    // rust: &[],
    // rust: ))
    // rust: });
    // rust: self.sync_score_registries();
    // rust: result
}
    /// ComponentUtils.updateForEntity for the pieces scoreboards store:
    /// `selector` and `score` components become their text.
    // rust: pub(super) fn resolve_component(&mut self, c: Comp) -> Comp {
    // rust: match c {
    // rust: Comp::Object(mut o) => {
    // rust: if let Some(sel) = o.get("selector").and_then(Comp::as_str).map(str::to_owned) {
    // rust: let text = self.resolve_selector_text(&sel);
    // rust: o.remove("selector");
    // rust: o.insert("text".into(), Comp::String(text));
    // rust: } else if let Some(score) = o.get("score").cloned() {
    // rust: let name = score.get("name").and_then(Comp::as_str).unwrap_or("");
    // rust: let objective = score.get("objective").and_then(Comp::as_str).unwrap_or("");
    // rust: let name = if name == "*" { PLAYER_NAME } else { name };
    // rust: let text = self
    // rust: .score
    // rust: .board
    // rust: .score(name, objective)
    // rust: .map_or_else(String::new, |s| s.value.to_string());
    // rust: o.remove("score");
    // rust: o.insert("text".into(), Comp::String(text));
}
    // rust: for key in ["extra", "with"] {
    // rust: if let Some(Comp::Array(list)) = o.remove(key) {
    // rust: let list = list
    // rust: .into_iter()
    // rust: .map(|c| self.resolve_component(c))
    // rust: .collect();
    // rust: o.insert(key.into(), Comp::Array(list));
}
}
    // rust: Comp::Object(o)
}
    // rust: Comp::Array(list) => Comp::Array(
    // rust: list.into_iter()
    // rust: .map(|c| self.resolve_component(c))
    // rust: .collect(),
    // rust: ),
    // rust: other => other,
}
}
pub fn resolve_selector_text(self: *Self, raw: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut reader = horizon_client::command::Reader::new(raw);
    // rust: let ty = horizon_client::command::args::ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
}
    // rust: let Ok(horizon_client::command::Arg::Entity(sel)) =
    // rust: ty.parse(&mut reader, &self.ui.registries)
    // rust: else {
    // rust: return raw.to_owned();
}
    // rust: let names: Vec<String> = self
    // rust: .select(&sel)
    // rust: .into_iter()
    // rust: .map(|t| self.target_name(t).plain())
    // rust: .collect();
    // rust: names.join(", ")
}

    // ---- the sidebar -----------------------------------------------------------

    /// The objective in the player's team's sidebar slot, else the sidebar's.
pub fn sidebar_objective(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let board = &self.score.board;
    // rust: if board.display.is_empty() {
    // rust: return None;
}
        // A server's client is in its team by its profile name.
    // rust: let name = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map_or(PLAYER_NAME, |r| r.profile_name.as_str());
    // rust: let team_slot = board
    // rust: .players_team(name)
    // rust: .and_then(|t| t.color.as_ref())
    // rust: .map(|c| format!("sidebar.team.{c}"))
    // rust: .and_then(|slot| board.display_objective(&slot));
    // rust: team_slot.or_else(|| board.display_objective(sb::SLOT_SIDEBAR))
}
    /// The sidebar the HUD shows: its objective and its lines, for `status`.
    // rust: pub(super) fn sidebar_status(&self) -> serde_json::Value {
    // rust: let board = &self.score.board;
    // rust: let Some(objective) = self.sidebar_objective() else {
    // rust: return serde_json::Value::Null;
}
    // rust: let scores: serde_json::Map<String, serde_json::Value> = board
    // rust: .scores
    // rust: .iter()
    // rust: .filter_map(|(holder, s)| Some((holder.clone(), s.get(&objective.name)?.value.into())))
    // rust: .collect();
    // rust: serde_json::json!({ "objective": objective.name, "title": objective.display_text().plain(), "scores": scores })
}

    /// `Hud.extractScoreboardSidebar` / `displayScoreboardSidebar`.
    // rust: pub(super) fn draw_scoreboard(&self, batch: &mut HudBatch) {
    // rust: let board = &self.score.board;
    // rust: let Some(objective) = self.sidebar_objective() else {
    // rust: return;
}
    // rust: let draws = hud_overlays::sidebar(
    // rust: batch.width as i32,
    // rust: batch.height as i32,
    // rust: board,
    // rust: objective,
    // rust: &self.gui.atlas.font,
    // rust: self.settings.text_background(0.3),
    // rust: self.settings.text_background(0.4),
    // rust: );
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
}

    // rust: impl Game<'_> {
    /// Advance the skin slots to a new frame with what the last one drew, and
    /// store any finished skin downloads into the atlas.
    // rust: pub(super) fn flush_skin_slots(&mut self) {
    // rust: let (ready, drawn) = {
    // rust: let mut downloads = self.skin_downloads.borrow_mut();
    // rust: (downloads.take_ready(), downloads.take_drawn())
}
    // rust: self.skin_slots.next_frame(drawn);
    // rust: for (location, rgba) in ready {
    // rust: self.store_skin(location, rgba);
}
    // rust: self.cosmetics_frame();
}
    /// `Hud.extractTabList`: the player list while the player-list key is
    /// held. A local world shows it with a joined LAN guest or a `list`
    /// objective.
    // rust: pub(super) fn draw_tab_list(&mut self, batch: &mut HudBatch) {
//         use horizon_client::tab_list::{self, TabInputs};
        // Player heads and the player list both draw from the same skin
        // slots: a new frame, with what the last one drew.
    // rust: self.flush_skin_slots();
    // rust: let key = self.screen == super::Screen::Playing && self.keys.held(Action::Playerlist);
    // rust: let (mut players, online_mode, upside_down) = match self.remote_tab_players() {
    // rust: Some(remote) => remote,
    // rust: None => {
                // The integrated server: the local player, online mode, no ping.
    // rust: let uuid = self.level.player_uuid.map_or(0, |u| {
    // rust: u.iter()
    // rust: .fold(0u128, |a, &w| (a << 32) | u128::from(w as u32))
    // rust: });
    // rust: let mut me = TabPlayer::new(uuid, PLAYER_NAME);
    // rust: me.game_mode = self.mode_id();
    // rust: me.skin = "entity/player/wide/steve".into();
    // rust: let guests = self.lan.as_ref().map_or(&[][..], |h| &h.hub.guests);
    // rust: let players = local_tab_players(me, guests);
    // rust: let upside_down = players
    // rust: .iter()
    // rust: .filter(|p| p.name == "Dinnerbone" || p.name == "Grumm")
    // rust: .map(|p| p.uuid)
    // rust: .collect();
    // rust: (players, true, upside_down)
}
}
    // rust: let has_objective = self.score.board.display_objective(sb::SLOT_LIST).is_some();
    // rust: let shown = tab_list::visible(
    // rust: key,
    // rust: self.has_singleplayer_server(),
    // rust: players.len(),
    // rust: has_objective,
    // rust: );
    // rust: if self.tab_list.set_visible(shown) {
            // PlayerTabOverlay.setVisible: the names, said as the list comes up.
    // rust: self.say_system_now(&tab_list::narration(&players, &self.score.board));
}
    // rust: if !shown {
    // rust: return;
}
        // The faces of the players the list shows.
    // rust: let faces: std::collections::HashSet<u128> =
    // rust: tab_list::sorted_players(&players, &self.score.board)
    // rust: .iter()
    // rust: .map(|p| p.uuid)
    // rust: .collect();
    // rust: for p in players.iter_mut().filter(|p| faces.contains(&p.uuid)) {
    // rust: p.skin = self.face_skin(p.uuid, &p.skin);
}
    // rust: let board = &self.score.board;
    // rust: let objective = board.display_objective(sb::SLOT_LIST);
    // rust: let up = |id: u128| upside_down.contains(&id);
        // Horizon's mark before the names of Horizon players (the cosmetics service's cache).
    // rust: let horizon = self.horizon_players(players.iter().map(|p| p.uuid));
    // rust: let marked = |id: u128| horizon.contains(&id);
    // rust: let inputs = TabInputs {
    // rust: players: &players,
    // rust: board,
    // rust: objective,
    // rust: screen_width: batch.width as i32,
    // rust: online_mode,
    // rust: gui_ticks: self.visual_ticks() as i64,
            // Horizon has no "chat background only" option: vanilla's default (on).
    // rust: background: tab_list::row_background(
    // rust: true,
    // rust: f64::from(self.settings.text_background_opacity),
    // rust: ),
    // rust: upside_down: &up,
    // rust: horizon: &marked,
}
    // rust: let draws = self.tab_list.layout(&inputs, &self.gui.atlas.font);
    // rust: horizon_client::hud_layout::paint(batch, &self.gui.atlas, &draws);
}
}

/// The host and guests that have entered the world, rebuilt from live state.
    // rust: pub(super) fn local_tab_players(me: TabPlayer, guests: &[Guest]) -> Vec<TabPlayer> {
    // rust: let mut players = vec![me];
    // rust: players.extend(guests.iter().filter(|g| g.placed).map(|g| {
    // rust: let mut player = TabPlayer::new(g.uuid, &g.name);
    // rust: player.game_mode = g.game_mode;
    // rust: player.latency = g.latency.load(std::sync::atomic::Ordering::Relaxed);
    // rust: player
    // rust: }));
    // rust: players
}

/// The commands' view of the game.
pub const GameEnv = struct {
    g: *'a mut Game<'b>,
};
    // rust: impl Env for GameEnv<'_, '_> {
pub fn sb(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.g.score.board
}
pub fn sb_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.g.score.board
}
pub fn select(self: *Self, selector: *Selector) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let found = self.g.select(selector);
    // rust: found
    // rust: .into_iter()
    // rust: .filter_map(|t| self.g.holder_for(t))
    // rust: .collect()
}
pub fn named(self: *Self, name: []const u8) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name.eq_ignore_ascii_case(self.g.acting_player_name()) && self.g.player.is_some() {
    // rust: return self
    // rust: .g
    // rust: .holder_for(Target::Player)
    // rust: .unwrap_or_else(|| Holder::named(name));
}
    // rust: match self.g.target_of_holder(name) {
    // rust: Some(t) => self.g.holder_for(t).unwrap_or_else(|| Holder::named(name)),
    // rust: None => Holder::named(name),
}
}
pub fn source(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entity = match self.g.command_source {
    // rust: Some(s) => s.entity,
    // rust: None => Some(Target::Player),
    // rust: }?;
    // rust: let name = match entity {
    // rust: Target::Player => self.g.acting_player_name().to_owned(),
    // rust: Target::Mob(id) | Target::Item(id) => uuid_text(self.g.uuid_for(id)),
    // rust: _ => return None,
}
    // rust: let text = self.g.target_name(entity);
    // rust: Some((
    // rust: Holder {
    // rust: display: Some(literal(&text.plain())),
    // rust: text,
    // rust: name,
    // rust: },
    // rust: entity == Target::Player,
    // rust: ))
}
pub fn resolve(self: *Self, c: Comp) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.g.resolve_component(c)
}
pub fn feedback(self: *Self, message: Text) void {
}
    // rust: self.g.feedback(message);
}
}

    // rust: mod tab_list_tests {
//     use super::*;
//     use horizon_client::{
    // rust: lan::{Joined, PlayerSender},
    // rust: tab_list,
}
//     use horizon_protocol::packets::configuration::ClientInformation;
//     use std::sync::{
    // rust: Arc,
    // rust: atomic::{AtomicI32, Ordering},
    // rust: mpsc,
}

pub fn guest(uuid: u128, name: []const u8) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, _rx) = mpsc::channel();
    // rust: Guest::new(
    // rust: Joined {
    // rust: conn: uuid as u32,
    // rust: uuid,
    // rust: name: name.into(),
    // rust: properties: Vec::new(),
    // rust: info: ClientInformation::new(8),
    // rust: brand: "test".into(),
    // rust: sender: PlayerSender::new(tx, Arc::default()),
    // rust: latency: Arc::new(AtomicI32::new(42)),
    // rust: address: "127.0.0.1:25565".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: uuid as i32,
    // rust: [0.0, 64.0, 0.0],
    // rust: 8,
    // rust: )
}

pub fn lan_tab_list_tracks_join_and_disconnect() void {
}
    // rust: let me = TabPlayer::new(1, PLAYER_NAME);
    // rust: let mut guests = vec![guest(2, "Alex")];
    // rust: let players = local_tab_players(me.clone(), &guests);
    // rust: assert_eq!(players.as_slice(), std::slice::from_ref(&me));
    // rust: assert!(!tab_list::visible(true, true, players.len(), false));

    // rust: guests[0].placed = true;
    // rust: let players = local_tab_players(me.clone(), &guests);
    // rust: assert_eq!(players.len(), 2);
    // rust: assert_eq!(players[0], me);
    // rust: assert_eq!(players[1].uuid, 2);
    // rust: assert_eq!(players[1].name, "Alex");
    // rust: assert!(tab_list::visible(true, true, players.len(), false));
    // rust: assert!(!tab_list::visible(false, true, players.len(), false));

    // rust: guests.clear();
    // rust: let players = local_tab_players(me, &guests);
    // rust: assert_eq!(players.len(), 1);
    // rust: assert!(!tab_list::visible(true, true, players.len(), false));
    // rust: assert!(tab_list::visible(true, true, players.len(), true));
}

pub fn lan_tab_list_reads_current_guest_state() void {
}
    // rust: let me = TabPlayer::new(1, PLAYER_NAME);
    // rust: let mut guests = vec![guest(2, "Alex"), guest(3, "Grumm")];
    // rust: for guest in &mut guests {
    // rust: guest.placed = true;
}
    // rust: guests[0].game_mode = tab_list::SPECTATOR;
    // rust: let players = local_tab_players(me.clone(), &guests);
    // rust: assert_eq!(players.len(), 3);
    // rust: assert_eq!(players[1].game_mode, tab_list::SPECTATOR);
    // rust: assert_eq!(players[1].latency, 42);
    // rust: assert_eq!(players[1].skin, tab_list::default_skin(2));
    // rust: assert_eq!(players[2].name, "Grumm");

    // rust: guests[0].game_mode = 1;
    // rust: guests[0].latency.store(123, Ordering::Relaxed);
    // rust: guests.remove(1);
    // rust: let players = local_tab_players(me, &guests);
    // rust: assert_eq!(players.len(), 2);
    // rust: assert_eq!(players[1].game_mode, 1);
    // rust: assert_eq!(players[1].latency, 123);
}
}

    // rust: mod team_tests {
//     use super::*;

pub const WOLF: [i32; 4] = [1, 2, 3, 4];
pub const CAT: [i32; 4] = [5, 6, 7, 8];
pub const STEVE: [i32; 4] = [9, 10, 11, 12];

    /// The player in place is on `red`, the cat on `blue`; nobody else is on a
    /// team (`Game::mob_team` names the player by profile, a mob by UUID).
pub fn board() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut board = Scoreboard::default();
    // rust: board.add_team("red");
    // rust: board.add_to_team("Steve", "red");
    // rust: board.add_team("blue");
    // rust: board.add_to_team(&uuid_text(CAT), "blue");
    // rust: board
}

pub fn team_name(team: ?*sb::Team) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: team.map(|t| t.name.as_str())
}

pub fn a_tamed_pet_with_no_team_answers_its_owners() void {
}
    // rust: let board = board();
    // rust: let wolf = uuid_text(WOLF);
    // rust: assert_eq!(
    // rust: team_name(pet_team(&board, &wolf, Some("Steve"))),
    // rust: Some("red")
    // rust: );
}

pub fn a_pet_with_its_own_team_answers_that_one() void {
}
    // rust: let board = board();
    // rust: let cat = uuid_text(CAT);
    // rust: assert_eq!(
    // rust: team_name(pet_team(&board, &cat, Some("Steve"))),
    // rust: Some("blue")
    // rust: );
}

pub fn an_untamed_pet_answers_no_team() void {
}
    // rust: let board = board();
    // rust: let wolf = uuid_text(WOLF);
        // `mob_team` names no owner for a pet that is not tamed.
    // rust: assert_eq!(pet_team(&board, &wolf, None), None);
}

pub fn a_pet_owned_by_a_pet_reaches_the_root_owner() void {
}
    // rust: let board = board();
        // The wolf's owner is the cat, whose own owner is the player: the
        // wolf answers the player's team, not the cat's.
    // rust: let pet_owner = |pet: [i32; 4]| (pet == CAT).then_some(STEVE);
    // rust: let root = root_owner(CAT, pet_owner);
    // rust: assert_eq!(root, STEVE);
    // rust: let root_name = if root == STEVE { "Steve" } else { "nobody" };
    // rust: assert_eq!(
    // rust: team_name(pet_team(&board, &uuid_text(WOLF), Some(root_name))),
    // rust: Some("red")
    // rust: );
        // An owner loop (only `/data` can make one) stops instead of hanging.
    // rust: let looped = |uuid: [i32; 4]| Some(if uuid == WOLF { CAT } else { WOLF });
    // rust: let root = root_owner(WOLF, looped);
    // rust: assert!(root == WOLF || root == CAT);
}

pub fn air_score_follows_the_air_supply_and_updates_only_on_change() void {
}
    // rust: let mut rec = Recorded::default();
    // rust: let first = rec.changed_scores(20, 120, 0, 0, 0);
    // rust: assert!(first.contains(&(sb::CRITERIA_AIR, 120)));
    // rust: assert!(rec.changed_scores(20, 120, 0, 0, 0).is_empty());
    // rust: assert_eq!(
    // rust: rec.changed_scores(20, 119, 0, 0, 0),
    // rust: vec![(sb::CRITERIA_AIR, 119)]
    // rust: );
    // rust: assert_eq!(
    // rust: rec.changed_scores(20, -5, 0, 0, 0),
    // rust: vec![(sb::CRITERIA_AIR, -5)]
    // rust: );
}
}
