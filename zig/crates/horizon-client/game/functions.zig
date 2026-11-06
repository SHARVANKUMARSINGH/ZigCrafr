//! Transpiled from Horizon Rust crate
//! Module: horizon-client_functions
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Data packs in the game: functions (`/function`, `/return`, tick and load
//! tags, `/schedule`), predicates, `/reload` and `/datapack`.
// use super::{
    // rust: Game,
    // rust: commands::{
    // rust: R, Target, err,
    // rust: execute::{ExecState, Source},
    // rust: },
}
// use horizon_client::{
    // rust: command::{Arg, Context},
    // rust: datapack::{self, DataPack, DataStore, Function},
    // rust: save,
    // rust: scoreboard::bracketed,
    // rust: text::{self, Text},
}
// use horizon_world::nbt::Tag;

/// A `TimerQueue` event.
    // rust: pub(super) struct Scheduled {
    /// `ns:function`, or `#ns:tag` for a function tag.
    // rust: pub id: String,
    // rust: pub time: i64,
    // rust: pub seq: u64,
}
    // rust: pub(super) struct FnState {
    // rust: pub store: DataStore,
    // rust: packs: Vec<DataPack>,
    /// Enabled pack ids, in load order (later overrides earlier).
    // rust: enabled: Vec<String>,
    // rust: loaded: bool,
    /// Run the `minecraft:load` tag on the next tick.
    // rust: load_pending: bool,
    // rust: pub schedule: Vec<Scheduled>,
    // rust: next_seq: u64,
    /// A dedicated server's `function-permission-level`.
    // rust: pub permission: Option<u8>,
}
/// What a function reported through `return`.
    // rust: pub(super) enum Outcome {
    // rust: NoReturn,
    // rust: Value(i32),
    // rust: Fail,
}

/// The world's pack stack: the built-in pack (unless disabled), the packs
/// of `<world>/datapacks` and the resources root's feature packs, with the
/// enabled ids from `datapacks.json` (`PackRepository.reload`).
    // rust: pub(super) struct PackStack {
    // rust: pub builtin: Option<DataPack>,
    // rust: pub packs: Vec<DataPack>,
    // rust: pub enabled: Vec<String>,
}
    // rust: impl PackStack {
    /// The enabled packs in `enabled` (the selected) order, later overriding
    /// earlier: `PackRepository.openAllSelected` keeps the selected order.
    // rust: pub(super) fn enabled_packs(&self) -> impl Iterator<Item = &DataPack> {
    // rust: self.enabled
    // rust: .iter()
    // rust: .filter_map(|id| self.packs.iter().find(|p| &p.id == id))
}
}
    // rust: pub(super) fn pack_stack(
    // rust: world_root: &std::path::Path,
    // rust: resources: &std::path::Path,
    // rust: vanilla_disabled: bool,
    // rust: enabled_features: &[String],
    // rust: ) -> PackStack {
    // rust: let builtin = (!vanilla_disabled).then(|| DataPack::builtin(resources));
    // rust: let packs = datapack::discover_with_features(world_root, resources);
    // rust: let enabled = datapack::enabled_ids(world_root, &packs, enabled_features);
    // rust: PackStack {
    // rust: builtin,
    // rust: packs,
    // rust: enabled,
}
}

/// The world's enabled packs' content files (`recipe/`, `loot_table/`,
/// `advancement/`, `tags/…`) for the tables to merge over the resource
/// root's own. Empty when the world has no packs.
    // rust: pub(super) fn content_overlay(
    // rust: world_root: &std::path::Path,
    // rust: resources: &std::path::Path,
    // rust: vanilla_disabled: bool,
    // rust: enabled_features: &[String],
    // rust: ) -> Vec<(String, Vec<Vec<u8>>)> {
    // rust: let stack = pack_stack(world_root, resources, vanilla_disabled, enabled_features);
    // rust: let packs: Vec<&DataPack> = stack.enabled_packs().collect();
    // rust: if packs.is_empty() {
    // rust: return Vec::new();
}
    // rust: DataStore::load(&packs).files.into_iter().collect()
}

/// The files the content tables load from: the world's enabled packs'
/// (`content_overlay`) with what native mods contribute for this load
/// (`native_data_pack_files`) below them. `PackOverlay::top` is a path's last
/// file, so a pack's file still overrides a mod's for the same path, and a
/// later contribution overrides an earlier one, as packs do. `Game` builds
/// its tables through here on a world's first open and on `/reload`, so the
/// mods are asked once per load.
    // rust: pub(super) fn overlay_files(
    // rust: world_root: &std::path::Path,
    // rust: resources: &std::path::Path,
    // rust: vanilla_disabled: bool,
    // rust: enabled_features: &[String],
    // rust: contributed: Vec<(String, Vec<u8>)>,
    // rust: ) -> Vec<(String, Vec<Vec<u8>>)> {
    // rust: let mut files = content_overlay(world_root, resources, vanilla_disabled, enabled_features);
    // rust: if contributed.is_empty() {
    // rust: return files;
}
    // A path's mod files in contribution order, under the pack files.
    // rust: let mut mods: std::collections::BTreeMap<String, Vec<Vec<u8>>> = Default::default();
    // rust: for (path, bytes) in contributed {
        // One bad file would fail its whole table and drop the world's pack
        // content with it, so it is skipped alone: every kind is JSON.
    // rust: if let Err(e) = serde_json::from_slice::<Box<serde_json::value::RawValue>>(&bytes) {
    // rust: log::warn!("Horizon: a native mod's data pack file {path} is not JSON, skipped: {e}");
    // rust: continue;
}
    // rust: mods.entry(path).or_default().push(bytes);
}
    // rust: for (path, versions) in files.iter_mut() {
    // rust: let Some(under) = mods.remove(path.as_str()) else {
    // rust: continue;
}
    // rust: let mut merged = under;
    // rust: merged.append(versions);
    // rust: *versions = merged;
}
    // The paths only a mod has.
    // rust: files.extend(mods);
    // rust: files
}

    // rust: impl FnState {
    /// The level function files compile at (`ServerFunctionLibrary`'s
    /// `functionCompilationPermissions`): `function-permission-level` on a
    /// dedicated server, game master (2) otherwise. Whoever runs a function,
    /// its commands need no more than this.
pub fn command_level(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.permission.unwrap_or(2)
}
}

    // rust: impl Game<'_> {
    // ---- loading -----------------------------------------------------------

pub fn datapack_settings_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_root.join("datapacks.json")
}
    /// Discover and load the data packs of the world (once, or on `/reload`).
    // rust: pub(super) fn ensure_datapacks(&mut self) {
    // rust: if self.fns.loaded || self.world_root.as_os_str().is_empty() {
    // rust: return;
}
    // rust: self.reload_datapacks(false);
}
    // rust: pub(super) fn reload_datapacks(&mut self, run_load: bool) {
    // rust: let stack = pack_stack(
    // rust: &self.world_root,
    // rust: &self.options.resources,
    // rust: self.cmds.vanilla_disabled,
    // rust: &self.level.enabled_features,
    // rust: );
    // rust: self.fns.packs = stack.packs;
    // rust: self.fns.enabled = stack.enabled;
    // rust: self.rebuild_store();
    // rust: self.fns.loaded = true;
    // rust: self.fns.load_pending = true;
        // An explicit reload (`/reload`, `/datapack`) reloads the content
        // tables with the functions, as `ReloadableServerResources` does;
        // the lazy first load ran after the world already built them.
    // rust: if run_load {
    // rust: self.reload_world_tables();
}
    // rust: let _ = run_load;
    // rust: if self.fns.schedule.is_empty() {
    // rust: self.load_schedule();
}
}
pub fn rebuild_store(self: *Self) void {
}
        // The built-in pack first (lowest priority), unless disabled.
    // rust: let stack = pack_stack(
    // rust: &self.world_root,
    // rust: &self.options.resources,
    // rust: self.cmds.vanilla_disabled,
    // rust: &self.level.enabled_features,
    // rust: );
    // rust: let packs: Vec<&DataPack> = stack.builtin.iter().chain(stack.enabled_packs()).collect();
    // rust: let store = DataStore::load(&packs);
    // rust: for (id, e) in &store.errors {
    // rust: log::warn!("Horizon: failed to load function {id}: {e}");
}
    // rust: self.fns.store = store;
    // rust: self.sync_function_registries();
}
pub fn save_datapack_settings(self: *Self) void {
}
    // rust: let disabled: Vec<&String> = self
    // rust: .fns
    // rust: .packs
    // rust: .iter()
    // rust: .map(|p| &p.id)
    // rust: .filter(|id| !self.fns.enabled.contains(id))
    // rust: .collect();
    // rust: let json = serde_json::json!({"enabled": self.fns.enabled, "disabled": disabled});
    // rust: let _ = std::fs::write(self.datapack_settings_path(), json.to_string());
}
    // rust: pub(super) fn sync_function_registries(&mut self) {
    // rust: let reg = &mut self.ui.registries;
    // rust: reg.functions = self.fns.store.functions.keys().cloned().collect();
    // rust: reg.function_tags = self.fns.store.function_tags.keys().cloned().collect();
    // rust: reg.predicates = self.fns.store.predicates.keys().cloned().collect();
    // rust: reg.item_modifiers = self.fns.store.item_modifiers.keys().cloned().collect();
    // rust: reg.schedules = self.fns.schedule.iter().map(|s| s.id.clone()).collect();
    // rust: reg.datapacks_enabled = std::iter::once("vanilla".to_owned())
    // rust: .chain(self.fns.enabled.iter().cloned())
    // rust: .collect();
    // rust: reg.datapacks_disabled = self
    // rust: .fns
    // rust: .packs
    // rust: .iter()
    // rust: .map(|p| p.id.clone())
    // rust: .filter(|id| !self.fns.enabled.contains(id))
    // rust: .collect();
        // A pack's worldgen ids join the completion registries
        // (`command-registries.json` lists only the game's own), and so do
        // its worldgen tag ids for the `#tag` completions. The packs are the
        // ones the world's worldgen is built from.
    // rust: let packs = horizon_client::datapack::discover_with_features(
    // rust: &self.world_root,
    // rust: &self.options.resources,
    // rust: );
    // rust: let enabled = horizon_client::datapack::enabled_ids(
    // rust: &self.world_root,
    // rust: &packs,
    // rust: &self.level.enabled_features,
    // rust: );
    // rust: let enabled: Vec<_> = enabled
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: let (overrides, _) = horizon_client::datapack::worldgen_overrides(&enabled, |_| true);
    // rust: for (bundle, registry) in [
    // rust: ("biomes", "minecraft:worldgen/biome"),
    // rust: ("structures", "minecraft:worldgen/structure"),
    // rust: ("structure_sets", "minecraft:worldgen/structure_set"),
    // rust: ("template_pools", "minecraft:worldgen/template_pool"),
    // rust: ("processor_lists", "minecraft:worldgen/processor_list"),
    // rust: ] {
    // rust: let entry = reg.by_registry.entry(registry.to_owned()).or_default();
    // rust: for (id, _) in overrides.entries(bundle) {
    // rust: if !entry.ids.contains(&id.to_owned()) {
    // rust: entry.ids.push(id.to_owned());
}
}
    // rust: entry.ids.sort();
}
    // rust: let entry = reg
    // rust: .by_registry
    // rust: .entry("minecraft:worldgen/biome".to_owned())
    // rust: .or_default();
    // rust: for (id, _, _) in overrides.tags("biome_tags") {
    // rust: if !entry.tags.contains(&id.to_owned()) {
    // rust: entry.tags.push(id.to_owned());
}
}
    // rust: entry.tags.sort();
    // rust: let entry = reg
    // rust: .by_registry
    // rust: .entry("minecraft:worldgen/structure".to_owned())
    // rust: .or_default();
    // rust: for (id, _, _) in overrides.tags("structure_tags") {
    // rust: if !entry.tags.contains(&id.to_owned()) {
    // rust: entry.tags.push(id.to_owned());
}
}
    // rust: entry.tags.sort();
}

    // ---- scheduled events ------------------------------------------------------

pub fn schedule_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_root.join("data/minecraft/scheduled_events.dat")
}
pub fn load_schedule(self: *Self) void {
}
    // rust: let Some(root) = save::read_dat(&self.schedule_path()) else {
    // rust: return;
}
    // rust: let Some(Tag::List(events)) = root.get("data").and_then(|d| d.get("events")) else {
    // rust: return;
}
    // rust: for e in events {
    // rust: let (Some(Tag::Long(time)), Some(Tag::String(id)), Some(cb)) =
    // rust: (e.get("trigger_time"), e.get("id"), e.get("callback"))
    // rust: else {
    // rust: continue;
}
    // rust: let _ = cb;
    // rust: self.fns.next_seq += 1;
    // rust: self.fns.schedule.push(Scheduled {
    // rust: id: id.to_string_lossy(),
    // rust: time: *time,
    // rust: seq: self.fns.next_seq,
    // rust: });
}
}
    // rust: pub(super) fn save_schedule(&self) {
    // rust: if !self.fns.loaded || self.remote.is_some() {
    // rust: return;
}
    // rust: let mut events = self.fns.schedule.clone();
    // rust: events.sort_by_key(|e| (e.time, e.seq));
    // rust: let list = events
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let (kind, name) = match e.id.strip_prefix('#') {
    // rust: Some(tag) => ("minecraft:function_tag", tag),
    // rust: None => ("minecraft:function", e.id.as_str()),
}
    // rust: Tag::compound([
    // rust: ("trigger_time", Tag::Long(e.time)),
    // rust: ("id", Tag::String(e.id.as_str().into())),
    // rust: (
    // rust: "callback",
    // rust: Tag::compound([
    // rust: ("type", Tag::String(kind.into())),
    // rust: ("id", Tag::String(name.into())),
    // rust: ]),
    // rust: ),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: if events.is_empty() && !self.schedule_path().exists() {
    // rust: return;
}
    // rust: let _ = save::write_dat(
    // rust: &self.schedule_path(),
    // rust: Tag::compound([
    // rust: ("data", Tag::compound([("events", Tag::List(list))])),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]),
    // rust: );
}

    // ---- ticking -----------------------------------------------------------------

    /// `ServerFunctionManager.tick` and the scheduled events.
    // rust: pub(super) fn tick_functions(&mut self) {
    // rust: self.ensure_datapacks();
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: self.exec = ExecState::default();
    // rust: let source = self.server_source();
    // rust: if self.fns.load_pending {
    // rust: self.fns.load_pending = false;
    // rust: for f in self.fns.store.tag_functions("minecraft:load") {
    // rust: self.run_function_by_id(&f, None, source);
}
}
    // rust: let now = self.world.game_time;
    // rust: loop {
    // rust: let due = self
    // rust: .fns
    // rust: .schedule
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, e)| e.time <= now)
    // rust: .min_by_key(|(_, e)| (e.time, e.seq))
    // rust: .map(|(i, _)| i);
    // rust: let Some(i) = due else { break };
    // rust: let event = self.fns.schedule.remove(i);
    // rust: match event.id.strip_prefix('#') {
    // rust: Some(tag) => {
    // rust: for f in self.fns.store.tag_functions(tag) {
    // rust: self.run_function_by_id(&f, None, source);
}
}
    // rust: None => self.run_function_by_id(&event.id, None, source),
}
}
    // rust: for f in self.fns.store.tag_functions("minecraft:tick") {
    // rust: self.run_function_by_id(&f, None, source);
}
}
pub fn run_function_by_id(self: *Self, id: []const u8, args: ?*Tag, source: Source) void {
}
    // rust: self.exec.commands = 0;
    // rust: if let Some(f) = self.fns.store.functions.get(id).cloned() {
            // `ServerFunctionManager.execute` logs a function that failed to
            // instantiate or run; its lines' own failures stay silent.
    // rust: if let Err(e) = self.run_function(&f, args, source) {
    // rust: log::warn!(
    // rust: "Horizon: failed to run function {id}: {}",
    // rust: e.message.plain()
    // rust: );
}
}
}

    /// The function branch of advancement rewards: resolve the optional function
    /// and execute it as the rewarded player, with suppressed output and GAMEMASTER permission.
    // rust: pub(super) fn run_advancement_reward_function(&mut self, id: &str) {
    // rust: self.ensure_datapacks();
    // rust: let Some(function) = self.fns.store.functions.get(id).cloned() else {
    // rust: return;
}
    // rust: let Some(pos) = self.target_position(Target::Player) else {
    // rust: return;
}
        // createCommandSourceStack belongs to the player, not an enclosing
        // execute's position, rotation, output sink or store callback.
    // rust: let source = Source {
    // rust: pos,
    // rust: rot: self.target_rotation(Target::Player),
    // rust: silent: true,
    // rust: ..self.player_source()
}
        // The existing runner applies this level to nested function calls too.
    // rust: let permission = self
    // rust: .fns
    // rust: .permission
    // rust: .replace(horizon_client::command::vanilla::GAMEMASTERS);
    // rust: let callback = self.exec.callback.take();
    // rust: let result = self.run_function(&function, None, source);
    // rust: self.exec.callback = callback;
    // rust: self.fns.permission = permission;
    // rust: if let Err(error) = result {
    // rust: log::warn!(
    // rust: "Horizon: failed to run advancement reward function {id}: {}",
    // rust: error.message.plain()
    // rust: );
}
}

    // ---- running -----------------------------------------------------------------

    /// Run one function with `source`: its commands in order, until a `return`.
    // rust: pub(in crate::game) fn run_function(
    // rust: &mut self,
    // rust: f: &Function,
    // rust: args: Option<&Tag>,
    // rust: source: Source,
    // rust: ) -> R<Outcome> {
    // rust: let lines = f.instantiate(args).map_err(|(key, a)| {
    // rust: let args: Vec<&dyn std::fmt::Display> =
    // rust: a.iter().map(|s| s as &dyn std::fmt::Display).collect();
    // rust: err(
    // rust: "commands.function.instantiationFailure",
    // rust: &[&f.id, &horizon_client::text::Text::tr(&key, &args).plain()],
    // rust: )
    // rust: })?;
    // rust: if self.exec.function_depth >= 128 {
    // rust: return Ok(Outcome::NoReturn);
}
    // rust: self.exec.function_depth += 1;
    // rust: let outer = self.exec.returned.take();
    // rust: let level = std::mem::replace(&mut self.ui.registries.permission, self.fns.command_level());
    // rust: let inner = Source {
    // rust: silent: true,
    // rust: store: None,
    // rust: ..source
}
    // rust: for line in lines {
    // rust: let _ = self.execute_line(&line, inner);
    // rust: if self.exec.returned.is_some() {
    // rust: break;
}
    // rust: if self.exec.commands > self.ui.rules.int("max_command_sequence_length").max(1) as u32 {
    // rust: break;
}
}
    // rust: self.ui.registries.permission = level;
    // rust: let returned = std::mem::replace(&mut self.exec.returned, outer);
    // rust: self.exec.function_depth -= 1;
    // rust: Ok(match returned {
    // rust: None => Outcome::NoReturn,
    // rust: Some(Some(v)) => Outcome::Value(v),
    // rust: Some(None) => Outcome::Fail,
    // rust: })
}
    /// The functions a `FunctionArgument` names: a function or a tag.
    // rust: pub(in crate::game) fn functions_named(&mut self, name: &str) -> R<Vec<Function>> {
    // rust: self.ensure_datapacks();
    // rust: match name.strip_prefix('#') {
            // ServerFunctionLibrary.getTag: an unknown tag is empty.
    // rust: Some(tag) => {
    // rust: if !self.fns.store.function_tags.contains_key(tag) {
    // rust: return Ok(Vec::new());
}
    // rust: Ok(self
    // rust: .fns
    // rust: .store
    // rust: .tag_functions(tag)
    // rust: .iter()
    // rust: .filter_map(|id| self.fns.store.functions.get(id).cloned())
    // rust: .collect())
}
    // rust: None => self
    // rust: .fns
    // rust: .store
    // rust: .functions
    // rust: .get(name)
    // rust: .cloned()
    // rust: .map(|f| vec![f])
    // rust: .ok_or_else(|| err("arguments.function.unknown", &[&name])),
}
}
    /// `if function`: what each function returns (None if it did not).
    // rust: pub(in crate::game) fn call_function_ref(
    // rust: &mut self,
    // rust: name: &str,
    // rust: args: Option<&Tag>,
    // rust: ) -> R<Vec<Option<i32>>> {
    // rust: let functions = self.functions_named(name)?;
    // rust: let source = self.command_source.unwrap_or_else(|| self.player_source());
    // rust: let mut out = Vec::new();
    // rust: for f in functions {
    // rust: out.push(match self.run_function(&f, args, source)? {
    // rust: Outcome::NoReturn => None,
    // rust: Outcome::Value(v) => Some(v),
    // rust: Outcome::Fail => Some(0),
    // rust: });
}
    // rust: Ok(out)
}

    // ---- commands ------------------------------------------------------------------

    /// `FunctionCommand.decorateOutputIfNeeded`: report returned values even for failure.
    // rust: pub(super) fn cmd_function(&mut self, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Resource(name)) = ctx.get("name").cloned() else {
    // rust: return Ok(0);
}
    // rust: let functions = self.functions_named(&name)?;
    // rust: if functions.is_empty() {
    // rust: let id = name.trim_start_matches('#');
    // rust: return Err(err("commands.function.scheduled.no_functions", &[&id]));
}
    // rust: let args = if ctx.has("with") {
    // rust: let r = self.data_ref_named(ctx, 0, "source")?;
    // rust: let data = self.data_of(&r)?;
    // rust: let tag = match ctx.get("path") {
    // rust: Some(Arg::Str(p)) => {
    // rust: let path = horizon_client::nbt_path::NbtPath::parse(p)
    // rust: .map_err(horizon_client::data_cmd::path_error)?;
    // rust: horizon_client::data_cmd::single_tag(&path, &data)?
}
    // rust: _ => data,
}
    // rust: if !matches!(tag, Tag::Compound(_)) {
    // rust: return Err(err(
    // rust: "commands.function.error.argument_not_compound",
    // rust: &[&"tag"],
    // rust: ));
}
    // rust: Some(tag)
    // rust: } else if let Some(Arg::Str(text)) = ctx.get("arguments") {
    // rust: Some(
    // rust: horizon_world::nbt::parse_snbt(text)
    // rust: .map_err(|e| err("argument.nbt.invalid", &[&e]))?
    // rust: .0,
    // rust: )
    // rust: } else {
    // rust: None
}
    // rust: let message = if functions.len() == 1 {
    // rust: Text::translate(
    // rust: "commands.function.scheduled.single",
    // rust: &[Text::literal(functions[0].id.clone())],
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "commands.function.scheduled.multiple",
    // rust: &[horizon_client::scoreboard_cmd::format_list(
    // rust: functions
    // rust: .iter()
    // rust: .map(|f| Text::literal(f.id.clone()))
    // rust: .collect(),
    // rust: )],
    // rust: )
}
    // rust: self.feedback(message);
    // rust: let source = self.command_source.unwrap_or_else(|| self.player_source());
    // rust: let mut sum: i32 = 0;
    // rust: let mut any = false;
    // rust: let mut failed = false;
    // rust: for f in functions {
    // rust: match self.run_function(&f, args.as_ref(), source)? {
    // rust: Outcome::NoReturn => {}
    // rust: Outcome::Value(v) => {
    // rust: any = true;
    // rust: sum = sum.wrapping_add(v);
    // rust: let message = Text::translate(
    // rust: "commands.function.result",
    // rust: &[Text::literal(f.id.clone()), Text::literal(v.to_string())],
    // rust: );
    // rust: self.feedback(message);
}
    // rust: Outcome::Fail => {
    // rust: any = true;
    // rust: failed = true;
    // rust: self.feedback(Text::translate(
    // rust: "commands.function.result",
    // rust: &[Text::literal(f.id.clone()), Text::literal("0")],
    // rust: ));
}
}
}
    // rust: self.exec.callback = Some(if failed && sum == 0 {
    // rust: Some((false, 0))
    // rust: } else if any {
    // rust: Some((true, sum))
    // rust: } else {
    // rust: None
    // rust: });
    // rust: Ok(sum)
}
    /// `return <value>` and `return fail` (`return run` is a chain).
    // rust: pub(super) fn cmd_return(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: if id == "return.fail" {
    // rust: self.finish_return(None);
    // rust: self.exec.callback = Some(Some((false, 0)));
    // rust: return Ok(0);
}
    // rust: let value = match ctx.get("value") {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 0,
}
    // rust: self.finish_return(Some(value));
    // rust: Ok(value)
}
    // rust: pub(super) fn cmd_schedule(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: self.ensure_datapacks();
    // rust: if id == "schedule.clear" {
    // rust: let Some(Arg::Resource(name)) = ctx.get("function").cloned() else {
    // rust: return Ok(0);
}
    // rust: let before = self.fns.schedule.len();
    // rust: self.fns.schedule.retain(|e| e.id != name);
    // rust: let count = before - self.fns.schedule.len();
    // rust: if count == 0 {
    // rust: return Err(err("commands.schedule.cleared.failure", &[&name]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.schedule.cleared.success",
    // rust: &[Text::literal(count.to_string()), Text::literal(name)],
    // rust: ));
    // rust: self.sync_function_registries();
    // rust: return Ok(count as i32);
}
    // rust: let Some(Arg::Resource(name)) = ctx.get("function").cloned() else {
    // rust: return Ok(0);
}
    // rust: let time = match ctx.get("time") {
    // rust: Some(Arg::Int(t)) => *t,
    // rust: _ => 0,
}
    // rust: if time == 0 {
    // rust: return Err(err("commands.schedule.same_tick", &[]));
}
    // rust: let replace = !ctx.has("append");
    // rust: let tick_time = self.world.game_time + i64::from(time);
    // rust: let schedule_id = match name.strip_prefix('#') {
            // An unknown tag is empty, and scheduling it is allowed.
    // rust: Some(_) => name.clone(),
    // rust: None => {
    // rust: let Some(f) = self.fns.store.functions.get(&name) else {
    // rust: return Err(err("arguments.function.unknown", &[&name]));
}
    // rust: if f.is_macro() {
    // rust: return Err(err("commands.schedule.macro", &[]));
}
    // rust: name.clone()
}
}
    // rust: if replace {
    // rust: self.fns.schedule.retain(|e| e.id != schedule_id);
}
    // rust: if !self
    // rust: .fns
    // rust: .schedule
    // rust: .iter()
    // rust: .any(|e| e.id == schedule_id && e.time == tick_time)
    // rust: {
    // rust: self.fns.next_seq += 1;
    // rust: let seq = self.fns.next_seq;
    // rust: self.fns.schedule.push(Scheduled {
    // rust: id: schedule_id,
    // rust: time: tick_time,
    // rust: seq,
    // rust: });
}
    // rust: let key = if name.starts_with('#') {
    // rust: "commands.schedule.created.tag"
    // rust: } else {
    // rust: "commands.schedule.created.function"
}
    // rust: self.feedback(Text::translate(
    // rust: key,
    // rust: &[
    // rust: Text::literal(name.trim_start_matches('#').to_owned()),
    // rust: Text::literal(time.to_string()),
    // rust: Text::literal(tick_time.to_string()),
    // rust: ],
    // rust: ));
    // rust: self.sync_function_registries();
    // rust: Ok((tick_time.rem_euclid(i64::from(i32::MAX))) as i32)
}
    /// ReloadCommand: the message, then the (asynchronous) reload; returns 0.
    // rust: pub(super) fn cmd_reload(&mut self) -> R<i32> {
    // rust: self.feedback(Text::translate("commands.reload.success", &[]));
    // rust: self.reload_datapacks(true);
    // rust: Ok(0)
}
    /// `PackLocationInfo.createChatLink`: the id decorated with its source
    /// (`pack.nameAndSource`, grey) in brackets, green when enabled.
pub fn pack_link(self: *Self, id: []const u8, enabled: bool) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hint = if enabled { "disable" } else { "enable" };
    // rust: let style = text::Style {
    // rust: color: Some(if enabled { text::GREEN } else { text::RED }),
    // rust: click: Some(text::ClickEvent::SuggestCommand(format!(
    // rust: "/datapack {hint} \"{id}\""
    // rust: ))),
    // rust: ..text::Style::default()
}
    // rust: let description = self
    // rust: .fns
    // rust: .packs
    // rust: .iter()
    // rust: .find(|p| p.id == id)
    // rust: .map_or_else(|| "Default data pack".to_owned(), DataPack::description);
    // rust: let style = text::Style {
    // rust: hover: Some(Box::new(Text::literal(format!("{id}\n{description}")))),
    // rust: ..style
}
    // rust: let source = if id == "vanilla" {
    // rust: "pack.source.builtin"
    // rust: } else if FEATURE_PACKS.iter().any(|(p, _)| *p == id) {
    // rust: "pack.source.feature"
    // rust: } else {
    // rust: "pack.source.world"
}
    // rust: let name = Text::translate(
    // rust: "pack.nameAndSource",
    // rust: &[Text::literal(id), Text::translate(source, &[])],
    // rust: )
    // rust: .with_color(text::GRAY);
    // rust: bracketed(name).with_style(&style)
}
    /// The selected packs, lowest priority first.
pub fn selected_packs(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let vanilla = (!self.cmds.vanilla_disabled).then(|| "vanilla".to_owned());
    // rust: vanilla
    // rust: .into_iter()
    // rust: .chain(self.fns.enabled.iter().cloned())
    // rust: .collect()
}
    /// `FileUtil.isPathPartPortable`: no trailing dot and no Windows device
    /// name (CON, PRN, AUX, NUL, COM and LPT with a digit from 1 to 9).
pub fn is_portable_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stem = name.split('.').next().unwrap_or_default();
    // rust: let device = match stem.len() {
    // rust: 3 => matches!(stem, "com" | "con" | "prn" | "aux" | "nul"),
    // rust: 4 => matches!(&stem[..3], "com" | "lpt") && matches!(stem.as_bytes()[3], b'1'..=b'9'),
    // rust: _ => false,
}
    // rust: !device && !name.ends_with('.')
}
    /// `DataPackCommand.createPack`: a pack folder with its `data` folder and a
    /// `pack.mcmeta` in the world's datapacks folder.
pub fn create_pack(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = match ctx.get("id") {
    // rust: Some(Arg::Str(s)) => s.clone(),
    // rust: _ => String::new(),
}
    // rust: let description = self.component_arg(ctx, "description")?;
        // FileUtil.isValidPathSegment: lowercase letters, digits, '-', '.' and '_'.
    // rust: let valid = !id.is_empty()
    // rust: && id != "."
    // rust: && id != ".."
    // rust: && id
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '-' | '.' | '_'));
    // rust: if !valid {
    // rust: return Err(err("commands.datapack.create.invalid_name", &[&id]));
}
    // rust: if !Self::is_portable_name(&id) {
    // rust: return Err(err("commands.datapack.create.invalid_full_name", &[&id]));
}
        // Without a world there is no datapacks folder to write to.
    // rust: if self.world_root.as_os_str().is_empty() {
    // rust: return Err(err("commands.datapack.create.io_failure", &[&id]));
}
    // rust: let datapacks = self.world_root.join("datapacks");
    // rust: let pack = datapacks.join(&id);
    // rust: if pack.exists() {
    // rust: return Err(err("commands.datapack.create.already_exists", &[&id]));
}
        // The data pack version (SharedConstants), written as a bare major
        // number for both bounds, as vanilla does.
    // rust: let pack_format = horizon_core::version::DATA_PACK_FORMAT.0;
    // rust: let mcmeta = serde_json::json!({
    // rust: "pack": {
    // rust: "description": description.component(),
    // rust: "min_format": pack_format,
    // rust: "max_format": pack_format,
}
    // rust: });
    // rust: let written = std::fs::create_dir_all(&datapacks)
    // rust: .and_then(|()| std::fs::create_dir(&pack))
    // rust: .and_then(|()| std::fs::create_dir(pack.join("data")))
    // rust: .and_then(|()| {
    // rust: std::fs::write(
    // rust: pack.join("pack.mcmeta"),
    // rust: serde_json::to_string_pretty(&mcmeta).unwrap_or_default(),
    // rust: )
    // rust: });
    // rust: if written.is_err() {
    // rust: return Err(err("commands.datapack.create.io_failure", &[&id]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.datapack.create.success",
    // rust: &[Text::literal(id)],
    // rust: ));
    // rust: Ok(1)
}
    // rust: pub(super) fn cmd_datapack(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: self.ensure_datapacks();
    // rust: let name = match ctx.get("name") {
    // rust: Some(Arg::Str(n)) => Some(n.clone()),
    // rust: _ => None,
}
    // rust: let selected = self.selected_packs();
        // `DataPackCommand.listAvailablePacks`: a feature pack the world's
        // features do not cover is not available.
    // rust: let available: Vec<String> = std::iter::once("vanilla".to_owned())
    // rust: .chain(self.fns.packs.iter().map(|p| p.id.clone()))
    // rust: .filter(|p| !selected.contains(p))
    // rust: .filter(|p| {
    // rust: FEATURE_PACKS
    // rust: .iter()
    // rust: .find(|(f, _)| *f == p.as_str())
    // rust: .is_none_or(|(_, flag)| self.level.enabled_features.iter().any(|f| f == flag))
    // rust: })
    // rust: .collect();
    // rust: let known = |g: &Self, n: &str| {
    // rust: n == "vanilla"
    // rust: || FEATURE_PACKS.iter().any(|(p, _)| *p == n)
    // rust: || g.fns.packs.iter().any(|p| p.id == n)
}
    // rust: match id {
    // rust: "datapack.create" => self.create_pack(ctx),
    // rust: "datapack.list" => {
    // rust: let want_enabled = ctx.has("enabled") || (!ctx.has("available"));
    // rust: let want_available = ctx.has("available") || (!ctx.has("enabled"));
    // rust: let mut total = 0;
    // rust: if want_enabled {
    // rust: if selected.is_empty() {
    // rust: self.feedback(Text::translate("commands.datapack.list.enabled.none", &[]));
    // rust: } else {
    // rust: let links: Vec<Text> =
    // rust: selected.iter().map(|p| self.pack_link(p, true)).collect();
    // rust: total += links.len();
    // rust: self.feedback(Text::translate(
    // rust: "commands.datapack.list.enabled.success",
    // rust: &[
    // rust: Text::literal(links.len().to_string()),
    // rust: horizon_client::scoreboard_cmd::format_list(links),
    // rust: ],
    // rust: ));
}
}
    // rust: if want_available {
    // rust: if available.is_empty() {
    // rust: self.feedback(Text::translate(
    // rust: "commands.datapack.list.available.none",
    // rust: &[],
    // rust: ));
    // rust: } else {
    // rust: let links: Vec<Text> =
    // rust: available.iter().map(|p| self.pack_link(p, false)).collect();
    // rust: total += links.len();
    // rust: self.feedback(Text::translate(
    // rust: "commands.datapack.list.available.success",
    // rust: &[
    // rust: Text::literal(links.len().to_string()),
    // rust: horizon_client::scoreboard_cmd::format_list(links),
    // rust: ],
    // rust: ));
}
}
    // rust: Ok(total as i32)
}
    // rust: "datapack.enable" => {
    // rust: let name = name.unwrap_or_default();
    // rust: if !known(self, &name) {
    // rust: return Err(err("commands.datapack.unknown", &[&name]));
}
    // rust: if selected.contains(&name) {
    // rust: return Err(err("commands.datapack.enable.failed", &[&name]));
}
    // rust: if let Some((_, flag)) = FEATURE_PACKS.iter().find(|(p, _)| *p == name)
    // rust: && !self.level.enabled_features.iter().any(|f| f == flag)
    // rust: {
                    // `DataPackCommand`: the pack's requested features must
                    // be a subset of the world's enabled ones.
    // rust: return Err(err(
    // rust: "commands.datapack.enable.failed.no_flags",
    // rust: &[&name, flag],
    // rust: ));
}
    // rust: if name == "vanilla" {
    // rust: self.cmds.vanilla_disabled = false;
    // rust: } else {
    // rust: let existing = match ctx.get("existing") {
    // rust: Some(Arg::Str(e)) => Some(e.clone()),
    // rust: _ => None,
}
    // rust: let position = if ctx.has("first") {
    // rust: 0
    // rust: } else if let Some(e) = &existing {
    // rust: let Some(i) = self.fns.enabled.iter().position(|p| p == e) else {
    // rust: return Err(err("commands.datapack.unknown", &[e]));
}
    // rust: if ctx.has("before") { i } else { i + 1 }
    // rust: } else {
    // rust: self.fns.enabled.len()
}
    // rust: self.fns.enabled.insert(position, name.clone());
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.datapack.modify.enable",
    // rust: &[self.pack_link(&name, true)],
    // rust: ));
    // rust: self.apply_pack_change();
    // rust: Ok(self.selected_packs().len() as i32)
}
    // rust: _ => {
    // rust: let name = name.unwrap_or_default();
    // rust: if !known(self, &name) {
    // rust: return Err(err("commands.datapack.unknown", &[&name]));
}
    // rust: if !selected.contains(&name) {
    // rust: return Err(err("commands.datapack.disable.failed", &[&name]));
}
    // rust: if FEATURE_PACKS.iter().any(|(p, _)| *p == name) {
                    // `DataPackCommand`'s ERROR_CANNOT_DISABLE_FEATURE: the
                    // flag stays on for the world's life.
    // rust: return Err(err("commands.datapack.disable.failed.feature", &[&name]));
}
    // rust: if name == "vanilla" {
    // rust: self.cmds.vanilla_disabled = true;
    // rust: } else {
    // rust: self.fns.enabled.retain(|p| p != &name);
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.datapack.modify.disable",
    // rust: &[self.pack_link(&name, true)],
    // rust: ));
    // rust: self.apply_pack_change();
    // rust: Ok(self.selected_packs().len() as i32)
}
}
}
    /// `ReloadCommand.reloadPacks`: no message of its own. It reloads the
    /// server's data as `/reload` does (`reload_datapacks`), the content
    /// tables with the functions.
pub fn apply_pack_change(self: *Self) void {
}
    // rust: self.save_datapack_settings();
    // rust: self.rebuild_store();
    // rust: self.fns.load_pending = true;
    // rust: self.reload_world_tables();
}

    // ---- predicates -------------------------------------------------------------------

    /// `ResourceOrIdArgument.getLootPredicate`: accept the inline or named
    /// predicate, then test it with the existing source entity and origin.
    // rust: pub(in crate::game) fn check_predicate(&mut self, id: &str) -> R<bool> {
    // rust: self.ensure_datapacks();
        // ResourceOrIdArgument retains either an inline value or a named id.
        // Both use the same evaluator and command-source context below.
    // rust: let json = if id.starts_with('{') {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(id)
    // rust: .map_err(|e| err("argument.nbt.invalid", &[&e]))?;
    // rust: horizon_client::scoreboard::tag_to_json(&tag)
    // rust: } else {
    // rust: self.fns
    // rust: .store
    // rust: .predicates
    // rust: .get(id)
    // rust: .cloned()
    // rust: .ok_or_else(|| err("argument.predicate.unknown", &[&id]))?
}
    // rust: let source = self.command_source.unwrap_or_else(|| self.player_source());
    // rust: let view = source.entity.map(|t| self.entity_view_asked(t, &json));
    // rust: Ok(self.conditions_hold(&json, view.as_ref(), source.pos))
}
}

/// The built-in feature packs and the feature flag each needs (none of them
/// enabled in a world created without experiments).
    // rust: const FEATURE_PACKS: &[(&str, &str)] = &[
    // rust: ("minecart_improvements", "minecraft:minecart_improvements"),
    // rust: ("redstone_experiments", "minecraft:redstone_experiments"),
    // rust: ("trade_rebalance", "minecraft:trade_rebalance"),
    // rust: ];

    // rust: mod tests {
//     use super::*;

    /// Two packs override the same recipe: the later one in the selected
    /// (`datapacks.json`) order wins, not the later one alphabetically.
pub fn content_overlay_follows_enabled_order() void {
}
    // rust: for order in [["file/a", "file/b"], ["file/b", "file/a"]] {
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-overlay-{}-{}",
    // rust: std::process::id(),
    // rust: order[0].replace('/', "_")
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: for name in ["a", "b"] {
    // rust: let pack = dir.join("datapacks").join(name);
    // rust: std::fs::create_dir_all(pack.join("data/x/recipe")).unwrap();
    // rust: std::fs::write(pack.join("pack.mcmeta"), "{}").unwrap();
    // rust: std::fs::write(pack.join("data/x/recipe/r.json"), name).unwrap();
}
    // rust: let json = serde_json::json!({"enabled": order, "disabled": []});
    // rust: std::fs::write(dir.join("datapacks.json"), json.to_string()).unwrap();
    // rust: let files = content_overlay(&dir, std::path::Path::new(""), true, &[]);
    // rust: let (_, versions) = files.iter().find(|(id, _)| id == "recipe/x:r").unwrap();
    // rust: let last = versions.last().unwrap();
    // rust: assert_eq!(
    // rust: last.as_slice(),
    // rust: order[1].trim_start_matches("file/").as_bytes()
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}

    /// What a native mod contributes (`native_data_pack_files`) joins the load
    /// the tables are built from, a world's first open and `/reload` alike
    /// (`Game::build_world_tables` is both), and sits below the world's own
    /// packs. Each load asks again, so it is the current contribution that
    /// counts.
pub fn contributed_files_join_the_load_below_the_worlds_packs() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-contributed-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let pack = dir.join("datapacks").join("pack");
    // rust: std::fs::create_dir_all(pack.join("data/pkg/tags/item")).unwrap();
    // rust: std::fs::write(pack.join("pack.mcmeta"), "{}").unwrap();
    // rust: std::fs::write(
    // rust: pack.join("data/pkg/tags/item/both.json"),
    // rust: r#"{"replace": true, "values": ["pkg:from_pack"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let settings = serde_json::json!({"enabled": ["file/pack"], "disabled": []});
    // rust: std::fs::write(dir.join("datapacks.json"), settings.to_string()).unwrap();
    // rust: let tag = |entry: &str| format!(r#"{{"values": ["{entry}"]}}"#).into_bytes();
    // rust: let files = overlay_files(
    // rust: &dir,
    // rust: std::path::Path::new(""),
    // rust: true,
    // rust: &[],
    // rust: vec![
    // rust: ("tags/pkg:item/both".to_owned(), tag("pkg:from_mod")),
    // rust: ("tags/pkg:item/mod_only".to_owned(), tag("pkg:only_mod")),
    // rust: ],
    // rust: );
        // The pack's file is the path's last (`PackOverlay::top`), and its
        // `replace` drops what the mod put below it.
    // rust: let (_, versions) = files
    // rust: .iter()
    // rust: .find(|(id, _)| id == "tags/pkg:item/both")
    // rust: .unwrap();
    // rust: assert!(horizon_world::loot::PackOverlay::top(versions).starts_with(b"{\"replace\""));
    // rust: let overlay = horizon_world::loot::PackOverlay { files: &files };
    // rust: let tags = horizon_items::items::load_tags(&dir, "item", &overlay).unwrap();
    // rust: assert!(tags["pkg:both"].contains("pkg:from_pack"));
    // rust: assert!(!tags["pkg:both"].contains("pkg:from_mod"));
        // A path only the mod has reaches the tables too.
    // rust: assert_eq!(
    // rust: tags["pkg:mod_only"].iter().collect::<Vec<_>>(),
    // rust: ["pkg:only_mod"]
    // rust: );
        // The next load asks again: the new contribution, not the first's.
    // rust: let files = overlay_files(
    // rust: &dir,
    // rust: std::path::Path::new(""),
    // rust: true,
    // rust: &[],
    // rust: vec![("tags/pkg:item/mod_only".to_owned(), tag("pkg:second_load"))],
    // rust: );
    // rust: let overlay = horizon_world::loot::PackOverlay { files: &files };
    // rust: let tags = horizon_items::items::load_tags(&dir, "item", &overlay).unwrap();
    // rust: assert_eq!(
    // rust: tags["pkg:mod_only"].iter().collect::<Vec<_>>(),
    // rust: ["pkg:second_load"]
    // rust: );
        // A file that isn't JSON is skipped alone, not the whole load.
    // rust: let files = overlay_files(
    // rust: &dir,
    // rust: std::path::Path::new(""),
    // rust: true,
    // rust: &[],
    // rust: vec![
    // rust: ("tags/pkg:item/mod_only".to_owned(), b"{not json".to_vec()),
    // rust: ("tags/pkg:item/good".to_owned(), tag("pkg:good")),
    // rust: ],
    // rust: );
    // rust: let overlay = horizon_world::loot::PackOverlay { files: &files };
    // rust: let tags = horizon_items::items::load_tags(&dir, "item", &overlay).unwrap();
    // rust: assert!(!tags.contains_key("pkg:mod_only"));
    // rust: assert!(tags["pkg:good"].contains("pkg:good"));
        // With nothing contributed the overlay is the packs' own.
    // rust: assert_eq!(
    // rust: overlay_files(&dir, std::path::Path::new(""), true, &[], Vec::new()),
    // rust: content_overlay(&dir, std::path::Path::new(""), true, &[])
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
