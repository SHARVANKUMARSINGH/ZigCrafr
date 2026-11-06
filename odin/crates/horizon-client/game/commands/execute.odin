//! Transpiled from Horizon Rust crate
package horizon_client_execute

import "core:fmt"
import "core:mem"
import "core:math"

// `/execute` (ExecuteCommand): walk the parsed redirect chain, forking and
// filtering command sources, then run the final command once per source,
// reporting each result to the `store` callbacks of its source.
// use super::{Arg, Context, Dim, Game, R, Target, data::DataRef, err};
// use horizon_client::{
    // rust: command::{CommandError, vanilla},
    // rust: nbt_path::NbtPath,
    // rust: text::Text,
}
// use horizon_world::nbt::Tag;

// `CommandSourceStack` fields Horizon models: the executing entity (None for
// the server), position, rotation, anchor, whether feedback is suppressed
// and the chain of `store` callbacks.
    // rust: pub(in crate::game) struct Source {
    // rust: pub entity: Option<Target>,
    // rust: pub pos: [f64; 3],
    // rust: pub rot: [f32; 2],
    // EntityAnchorArgument.Anchor: eyes (true) or feet.
    // rust: pub eyes: bool,
    // `withSuppressedOutput`: functions do not print feedback.
    // rust: pub silent: bool,
    // Index of the newest `store` in `ExecState::stores`.
    // rust: pub store: Option<u32>,
    // The level this command source uses. Horizon has only this dimension's
    // chunks loaded in the single-player client.
    // rust: pub dimension: Dim,
    // The dimension `execute in` named, if any: a server teleports its
    // players there (`TeleportCommand` into the source's level).
    // rust: pub level: Option<super::super::Dim>,
    // The command block whose output this source is
    // (`BaseCommandBlock.CloseableCommandBlockSource`).
    // rust: pub block: Option<(i32, i32, i32)>,
    // The command block minecart whose output this source is.
    // rust: pub cart: Option<u32>,
}

// Where `execute store` writes.
    // rust: pub(in crate::game) enum StoreTarget {
    // rust: Score(Vec<String>, String),
    // rust: Bossbar(String, bool),
    // rust: Data(DataRef, NbtPath, String, f64),
}
    // rust: pub(in crate::game) struct StoreEntry {
    // `store result` (true) or `store success`.
    // rust: result: bool,
    // rust: target: StoreTarget,
    // rust: parent: Option<u32>,
}
// Command execution state shared across nested commands and functions.
    // rust: pub(in crate::game) struct ExecState {
    // rust: stores: Vec<StoreEntry>,
    // Commands run since the outermost one began.
    // rust: pub commands: u32,
    // What the last leaf command reports to its `store` callbacks: None for
    // the default, `Some(None)` for nothing (a function that did not
    // `return`), `Some(Some((success, result)))` for an explicit value.
    // rust: pub callback: Option<Option<(bool, i32)>>,
    // The innermost function frame's `return`.
    // rust: pub returned: Option<Option<i32>>,
    // Depth of function calls.
    // rust: pub function_depth: u32,
}

// A modifier that brings the sources to `max_command_forks` ends the chain
// (`BuildContexts.ERROR_FORK_LIMIT_REACHED`); the error is only shown when
// no fork came before it (`CommandSourceStack.handleError`).
fork_limit_reached :: proc(forked: bool, limit: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if forked {
    // rust: Ok(0)
    // rust: } else {
    // rust: Err(err("command.forkLimit", &[&limit]))
}
}

// Java's `(int)`/`(short)`/`(byte)` narrowing of a double.
java_int :: proc(v: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v as i32
}

    // rust: impl Game<'_> {
    // The source a command typed by the player starts from.
    // rust: pub(in crate::game) fn player_source(&self) -> Source {
    // rust: Source {
            // The server console has no entity (CommandSourceStack of the server).
    // rust: entity: self.player.is_some().then_some(Target::Player),
    // rust: pos: self.source_position(),
    // rust: rot: self.source_rotation(),
    // rust: eyes: false,
    // rust: silent: false,
    // rust: store: None,
    // rust: dimension: self.dim,
    // rust: level: None,
    // rust: block: None,
    // rust: cart: None,
}
}
    // The server as a source (function ticks and schedules): the world spawn.
    // rust: pub(in crate::game) fn server_source(&self) -> Source {
    // rust: Source {
    // rust: entity: None,
    // rust: pos: self.server_position(),
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
    // rust: pub(in crate::game) fn target_rotation(&self, t: Target) -> [f32; 2] {
    // rust: match t {
    // rust: Target::Player => [self.yaw, self.pitch],
    // rust: Target::Guest(conn) => self
    // rust: .command_guest(conn)
    // rust: .map_or([0.0; 2], |g| [g.yaw, g.pitch]),
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or([0.0; 2], |m| [m.yaw, m.head_pitch]),
    // rust: Target::Stand(id) => self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .find(|a| a.id == id)
    // rust: .map_or([0.0; 2], |a| [a.yaw, 0.0]),
    // rust: Target::Boat(id) => self
    // rust: .boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map_or([0.0; 2], |b| [b.yaw, b.pitch]),
    // rust: Target::Cart(id) => self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map_or([0.0; 2], |c| [c.yaw, c.pitch]),
    // rust: Target::Fangs(id) => self
    // rust: .fangs
    // rust: .list
    // rust: .iter()
    // rust: .find(|f| f.id == id)
    // rust: .map_or([0.0; 2], |f| [f.yaw, 0.0]),
    // rust: Target::Other(id) => self
    // rust: .others
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .map_or([0.0; 2], |o| [o.yaw, o.pitch]),
    // rust: _ => [0.0; 2],
}
}
    // rust: pub(in crate::game) fn target_eye_height(&self, t: Target) -> f64 {
    // rust: match t {
    // rust: Target::Player => self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or(1.62, |p| f64::from(p.dimensions.eye_height)),
    // rust: Target::Guest(conn) => self.command_guest(conn).map_or(1.62, |g| g.eye_height()),
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or(0.0, |m| m.eye_y() - m.position.y),
            // ArmorStand.getDefaultDimensions: a marker's are empty, a small
            // stand's are BABY_DIMENSIONS, whose eye height is 0.9875F.
    // rust: Target::Stand(id) => match self.armor_stands.iter().find(|a| a.id == id) {
    // rust: Some(a) if a.marker => 0.0,
    // rust: Some(a) if a.small => f64::from(0.9875f32),
    // rust: _ => self.type_eye_height(&self.target_type(t)),
    // rust: },
            // Entity.getEyeHeight: the type's dimensions.
    // rust: _ => self.type_eye_height(&self.target_type(t)),
}
}
    // `EntityType.getDimensions().eyeHeight()` from `entity-types.json`,
    // read once: a float, widened as `Entity.getEyeY` does.
type_eye_height :: proc(self: ^Self, ty: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: static EYE_HEIGHTS: std::sync::OnceLock<std::collections::HashMap<String, f64>> =
    // rust: std::sync::OnceLock::new();
    // rust: EYE_HEIGHTS
    // rust: .get_or_init(|| {
    // rust: std::fs::read(self.options.resources.join("entity-types.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok())
    // rust: .and_then(|v| {
    // rust: v.as_object().map(|o| {
    // rust: o.iter()
    // rust: .filter_map(|(k, t)| {
    // rust: Some((k.clone(), f64::from(t["eye_height"].as_f64()? as f32)))
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: })
    // rust: .unwrap_or_default()
    // rust: })
    // rust: .get(ty)
    // rust: .copied()
    // rust: .unwrap_or(0.0)
}
    // EntityAnchorArgument.Anchor.apply.
    // rust: pub(super) fn anchor_position(&self, s: &Source) -> [f64; 3] {
    // rust: match s.entity {
    // rust: Some(t) if s.eyes => [s.pos[0], s.pos[1] + self.target_eye_height(t), s.pos[2]],
    // rust: _ => s.pos,
}
}
    // Evaluate `f` with `source` as the command source, in the source's
    // level (`CommandSourceStack.getLevel`): a server puts that level in
    // place for it.
    // rust: pub(in crate::game) fn with_source<T>(
    // rust: &mut self,
    // rust: source: Source,
    // rust: f: impl FnOnce(&mut Self) -> T,
    // rust: ) -> T {
    // rust: let previous = self.command_source.replace(source);
    // rust: let back = self.enter_command_level(source.dimension);
    // rust: let out = f(self);
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
    // rust: self.command_source = previous;
    // rust: out
}

    // ---- running commands -----------------------------------------------

    // Run one command line with `source` (no error reporting): the entry
    // for functions and `execute run`.
    // rust: pub(in crate::game) fn execute_line(&mut self, line: &str, source: Source) -> R<i32> {
    // rust: let d = vanilla::game_dispatcher_with_features(&self.level.enabled_features);
    // rust: let parse = d.parse(line, &self.ui.registries);
    // rust: let (ctx, _) = parse.executable()?;
    // rust: let ctx = ctx.clone();
    // rust: let root = parse.context.clone();
    // rust: self.with_source(source, |g| g.run_chain(&root, &ctx))
}
    // Run a parsed command (`root` is the first context; `ctx` the one with
    // the executable node): `execute` and `return` walk their own chains.
    // rust: pub(in crate::game) fn run_chain(&mut self, root: &Context, ctx: &Context) -> R<i32> {
    // rust: self.exec.commands += 1;
    // rust: let limit = self.ui.rules.int("max_command_sequence_length").max(1) as u32;
    // rust: if self.exec.commands > limit {
    // rust: return Err(err("command.failed", &[]));
}
    // rust: match root.literals.first().map(String::as_str) {
    // rust: Some("execute") => self.run_execute(root),
    // rust: Some("return") if root.child.is_some() => self.run_return_run(root),
    // rust: _ => {
    // rust: let id = ctx.command.unwrap_or("");
    // rust: self.run_leaf(id, ctx)
}
}
}
    // Run a leaf command and report its outcome to the `store` callbacks.
    // rust: pub(in crate::game) fn run_leaf(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: self.exec.callback = None;
    // rust: let store = self.command_source.and_then(|s| s.store);
    // rust: let result = self.execute_command(id, ctx);
    // rust: let custom = self.exec.callback.take();
    // rust: let outcome = match (&result, custom) {
    // rust: (_, Some(c)) => c,
    // rust: (Ok(v), None) => Some((true, *v)),
    // rust: (Err(_), None) => Some((false, 0)),
}
    // rust: if let Some((success, value)) = outcome {
    // rust: self.deliver(store, success, value);
}
    // rust: result
}
    // `CommandResultCallback`s of a source's `store` chain, oldest first.
deliver :: proc(self: ^Self, store: Maybe(u32), success: bool, value: i32) {
}
        // The outermost source's own CommandResultCallback (harness record).
    // rust: if self.exec.function_depth == 0
    // rust: && let Some(results) = self.cmds.results.as_mut()
    // rust: {
    // rust: results.push((success, value));
}
    // rust: let mut chain = Vec::new();
    // rust: let mut at = store;
    // rust: while let Some(i) = at {
    // rust: let Some(e) = self.exec.stores.get(i as usize) else {
    // rust: break;
}
    // rust: chain.push(e.clone());
    // rust: at = e.parent;
}
    // rust: for e in chain.into_iter().rev() {
    // rust: let v = if e.result { value } else { i32::from(success) };
    // rust: self.store_value(&e.target, v);
}
}
store_value :: proc(self: ^Self, target: ^StoreTarget, value: i32) {
}
    // rust: match target {
    // rust: StoreTarget::Score(holders, objective) => {
    // rust: for h in holders {
    // rust: self.score.board.set(h, objective, value);
}
}
    // rust: StoreTarget::Bossbar(id, is_value) => self.set_bossbar_value(id, *is_value, value),
    // rust: StoreTarget::Data(r, path, kind, scale) => {
    // rust: let Ok(mut data) = self.data_of(r) else {
    // rust: return;
}
    // rust: let v = f64::from(value) * scale;
    // rust: let tag = match kind.as_str() {
    // rust: "int" => Tag::Int(java_int(v)),
    // rust: "float" => Tag::Float((v as f32).to_bits()),
    // rust: "short" => Tag::Short(java_int(v) as i16),
    // rust: "long" => Tag::Long(v as i64),
    // rust: "double" => Tag::Double(v.to_bits()),
    // rust: _ => Tag::Byte(java_int(v) as i8),
}
    // rust: if path.set(&mut data, &tag).is_ok() {
    // rust: let _ = self.set_data_of(r, data);
}
}
}
}

    // ExecuteCommand: `ctx` is the context holding the `execute` literal.
    // rust: pub(in crate::game) fn run_execute(&mut self, ctx: &Context) -> R<i32> {
        // BuildContexts: a modifier may not bring the sources to this many.
    // rust: let fork_limit = self.ui.rules.int("max_command_forks") as usize;
    // rust: let mut sources = vec![self.command_source.unwrap_or_else(|| self.player_source())];
    // rust: let mut c = ctx;
        // A fork modifier (as, at, positioned as, rotated as, facing entity,
        // on, a non-terminal if/unless) makes later errors silent
        // (CommandSourceStack.handleError with `forked`).
    // rust: let mut forked = false;
    // rust: loop {
    // rust: let word = c
    // rust: .literals
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .find(|w| *w != "execute")
    // rust: .unwrap_or("");
    // rust: match word {
    // rust: "run" => {
    // rust: let Some(command) = c.child.as_deref() else {
    // rust: return Err(err("command.unknown.command", &[]));
}
    // rust: let last = command.last_child();
    // rust: if last.command.is_none() {
    // rust: return Err(err("command.unknown.command", &[]));
}
    // rust: let mut total = 0;
    // rust: let many = sources.len() > 1;
    // rust: let mut failure = None;
    // rust: for s in sources {
    // rust: match self.with_source(s, |g| g.run_chain(command, last)) {
    // rust: Ok(n) => total += n,
    // rust: Err(_) if forked => {}
                            // Several sources: report each failure and carry on.
    // rust: Err(e) if many => self.command_failure(e.message),
    // rust: Err(e) => failure = Some(e),
}
    // rust: if self.exec.returned.is_some() {
    // rust: break;
}
}
    // rust: return match failure {
    // rust: Some(e) => Err(e),
    // rust: None => Ok(total),
}
}
    // rust: "if" | "unless" => {
    // rust: let want = word == "if";
    // rust: if c.child.is_none() {
    // rust: return self.run_conditional_terminal(c, sources, want);
}
    // rust: forked = true;
    // rust: let mut kept = Vec::new();
    // rust: for s in sources {
    // rust: let (keep, _) = self.with_source(s, |g| g.condition(c, want))?;
    // rust: if kept.len() + usize::from(keep) >= fork_limit {
    // rust: return fork_limit_reached(forked, fork_limit);
}
    // rust: if keep {
    // rust: kept.push(s);
}
}
    // rust: sources = kept;
}
    // rust: _ => {
    // rust: forked |= match word {
    // rust: "as" | "at" | "on" => true,
    // rust: "positioned" | "rotated" => c.has("as"),
    // rust: "facing" => c.has("entity"),
    // rust: _ => false,
}
    // rust: let mut next = Vec::new();
    // rust: for s in sources {
    // rust: let new = self.with_source(s, |g| g.modify(word, c, s))?;
    // rust: if next.len() + new.len() >= fork_limit {
    // rust: return fork_limit_reached(forked, fork_limit);
}
    // rust: next.extend(new);
}
    // rust: sources = next;
}
}
    // rust: match c.child.as_deref() {
    // rust: Some(child) => c = child,
    // rust: None => return Err(err("command.unknown.command", &[])),
}
}
}
    // A conditional that ends the chain runs as a command: a test per source.
    // rust: fn run_conditional_terminal(
    // rust: &mut self,
    // rust: c: &Context,
    // rust: sources: Vec<Source>,
    // rust: want: bool,
    // rust: ) -> R<i32> {
    // rust: let numeric = ["entity", "data", "blocks", "items", "slots"]
    // rust: .iter()
    // rust: .any(|k| c.has(k));
    // rust: let many = sources.len() > 1;
    // rust: let mut total = 0;
    // rust: let mut failure: Option<CommandError> = None;
    // rust: for s in sources {
    // rust: self.exec.callback = None;
    // rust: let (keep, count) = match self.with_source(s, |g| g.condition(c, want)) {
    // rust: Ok(v) => v,
    // rust: Err(e) => {
    // rust: self.deliver(s.store, false, 0);
    // rust: if many {
    // rust: self.command_failure(e.message);
    // rust: } else {
    // rust: failure = Some(e);
}
    // rust: continue;
}
}
    // rust: if keep {
    // rust: let n = if want && numeric { count } else { 1 };
    // rust: let message = if want && numeric {
    // rust: Text::translate(
    // rust: "commands.execute.conditional.pass_count",
    // rust: &[Text::literal(count.to_string())],
    // rust: )
    // rust: } else {
    // rust: Text::translate("commands.execute.conditional.pass", &[])
}
    // rust: self.with_source(s, |g| g.feedback(message));
    // rust: self.deliver(s.store, true, n);
    // rust: total += n;
    // rust: } else {
    // rust: self.deliver(s.store, false, 0);
    // rust: let e = if !want && numeric {
    // rust: err("commands.execute.conditional.fail_count", &[&count])
    // rust: } else {
    // rust: err("commands.execute.conditional.fail", &[])
}
    // rust: if many {
    // rust: self.command_failure(e.message);
    // rust: } else {
    // rust: failure = Some(e);
}
}
}
    // rust: match failure {
    // rust: Some(e) => Err(e),
    // rust: None => Ok(total),
}
}
    // `return run <command>`: run it and return its result from the frame.
run_return_run :: proc(self: ^Self, root: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(command) = root.child.as_deref() else {
    // rust: return Err(err("command.unknown.command", &[]));
}
    // rust: let last = command.last_child();
    // rust: let result = self.run_chain(command, last);
        // The command's own callbacks do not fire; the function frame gets
        // its result instead.
    // rust: match result {
    // rust: Ok(v) => self.finish_return(Some(v)),
    // rust: Err(e) => {
    // rust: self.finish_return(None);
    // rust: self.command_failure(e.message);
}
}
    // rust: self.exec.callback = Some(None);
    // rust: Ok(0)
}
    // `Frame.returnSuccess`/`returnFailure` then `discard`.
    // rust: pub(in crate::game) fn finish_return(&mut self, value: Option<i32>) {
    // rust: self.exec.returned = Some(value);
}

    // The sources one modifier produces from `s`.
modify :: proc(self: ^Self, word: string, c: ^Context, s: Source) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let targets = |g: &mut Self| -> R<Vec<Target>> {
            // An empty selection forks to nothing rather than failing.
    // rust: match c.get("targets") {
    // rust: Some(Arg::Entity(sel)) => {
    // rust: let sel = sel.clone();
    // rust: Ok(g.select(&sel))
}
    // rust: _ => Ok(Vec::new()),
}
}
    // rust: Ok(match word {
    // rust: "as" => targets(self)?
    // rust: .into_iter()
    // rust: .map(|t| Source {
    // rust: entity: Some(t),
    // rust: ..s
    // rust: })
    // rust: .collect(),
    // rust: "at" => targets(self)?
    // rust: .into_iter()
    // rust: .filter_map(|t| {
                    // CommandSourceStack.withLevel(entity.level()).
    // rust: let level = self.target_level(t);
    // rust: Some(Source {
    // rust: pos: self.target_position(t)?,
    // rust: rot: self.target_rotation(t),
    // rust: dimension: level,
    // rust: level: (level != self.dim).then_some(level),
    // rust: ..s
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: "positioned" if c.has("as") => targets(self)?
    // rust: .into_iter()
    // rust: .filter_map(|t| {
                    // withPosition keeps the anchor (only `positioned <pos>`
                    // resets it to the feet).
    // rust: Some(Source {
    // rust: pos: self.target_position(t)?,
    // rust: ..s
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: "positioned" if c.has("over") => {
    // rust: let Some(Arg::Str(kind)) = c.get("heightmap") else {
    // rust: return Ok(vec![s]);
}
    // rust: let (x, z) = (s.pos[0].floor() as i32, s.pos[2].floor() as i32);
    // rust: if !self.world.chunks.contains_key(&(x >> 4, z >> 4)) {
    // rust: return Err(err("argument.pos.unloaded", &[]));
}
    // rust: let y = self.heightmap_at(kind, x, z);
    // rust: vec![Source {
    // rust: pos: [s.pos[0], f64::from(y), s.pos[2]],
    // rust: ..s
    // rust: }]
}
    // rust: "positioned" => {
    // rust: let pos = self
    // rust: .position_arg(c, "pos")
    // rust: .ok_or_else(|| err("argument.pos.missing.double", &[]))?;
    // rust: vec![Source {
    // rust: pos,
    // rust: eyes: false,
    // rust: ..s
    // rust: }]
}
    // rust: "rotated" if c.has("as") => targets(self)?
    // rust: .into_iter()
    // rust: .map(|t| Source {
    // rust: rot: self.target_rotation(t),
    // rust: ..s
    // rust: })
    // rust: .collect(),
    // rust: "rotated" => {
    // rust: let rot = match c.get("rot") {
    // rust: Some(Arg::Coords(r)) => r.rotation(s.rot),
    // rust: _ => s.rot,
}
    // rust: vec![Source { rot, ..s }]
}
    // rust: "facing" if c.has("entity") => {
    // rust: let eyes = matches!(c.get("anchor"), Some(Arg::Anchor(true)));
    // rust: targets(self)?
    // rust: .into_iter()
    // rust: .filter_map(|t| {
    // rust: let p = self.target_position(t)?;
    // rust: let y = if eyes {
    // rust: p[1] + self.target_eye_height(t)
    // rust: } else {
    // rust: p[1]
}
    // rust: Some(self.facing(s, [p[0], y, p[2]]))
    // rust: })
    // rust: .collect()
}
    // rust: "facing" => {
    // rust: let to = self
    // rust: .position_arg(c, "pos")
    // rust: .ok_or_else(|| err("argument.pos.missing.double", &[]))?;
    // rust: vec![self.facing(s, to)]
}
    // rust: "align" => {
    // rust: let Some(Arg::Str(axes)) = c.get("axes") else {
    // rust: return Ok(vec![s]);
}
    // rust: let mut pos = s.pos;
    // rust: for (i, axis) in ['x', 'y', 'z'].into_iter().enumerate() {
    // rust: if axes.contains(axis) {
    // rust: pos[i] = pos[i].floor();
}
}
    // rust: vec![Source { pos, ..s }]
}
    // rust: "anchored" => vec![Source {
    // rust: eyes: matches!(c.get("anchor"), Some(Arg::Anchor(true))),
    // rust: ..s
    // rust: }],
    // rust: "in" => {
                // CommandSourceStack.withLevel scales the source position;
                // absolute coordinates passed to /tp are unaffected.
    // rust: let Some(Arg::Resource(dim)) = c.get("dimension") else {
    // rust: return Ok(vec![s]);
}
    // rust: if !matches!(
    // rust: dim.as_str(),
    // rust: "minecraft:overworld" | "minecraft:the_nether" | "minecraft:the_end"
    // rust: ) {
    // rust: return Err(err("argument.dimension.invalid", &[dim]));
}
    // rust: let dimension = Dim::from_id(dim);
    // rust: let coordinate_scale = |dim| if dim == Dim::Nether { 8.0 } else { 1.0 };
    // rust: let scale = coordinate_scale(s.dimension) / coordinate_scale(dimension);
    // rust: vec![Source {
    // rust: pos: [s.pos[0] * scale, s.pos[1], s.pos[2] * scale],
    // rust: dimension,
    // rust: level: Some(super::super::Dim::from_id(dim)),
    // rust: ..s
    // rust: }]
}
    // rust: "summon" => {
    // rust: let Some(Arg::Resource(kind)) = c.get("entity").cloned() else {
    // rust: return Ok(vec![s]);
}
    // rust: let target = self.summon_with_nbt(&kind, s.pos, "{}")?;
    // rust: let Some(t) = target else {
    // rust: return Err(err("commands.summon.failed", &[]));
}
    // rust: vec![Source {
    // rust: entity: Some(t),
    // rust: ..s
    // rust: }]
}
    // rust: "on" => self.relation(c, s),
    // rust: "store" => vec![self.store_source(c, s)?],
    // rust: _ => return Err(err("command.unknown.command", &[])),
    // rust: })
}
    // `ExecuteCommand.createRelationOperations`: the entities `on <relation>` reaches.
relation :: proc(self: ^Self, c: ^Context, s: Source) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(entity) = s.entity else {
    // rust: return Vec::new();
}
    // rust: let found: Vec<Target> = match c.literals.last().map(String::as_str) {
    // rust: Some("owner") => match entity {
                // OwnableEntity.getOwner → EntityReference.getLivingEntity:
                // a marker or a display with that UUID is not an owner.
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .and_then(|m| m.extra.owner)
                    // A guest owner too, not only the player in place.
    // rust: .and_then(|u| {
    // rust: self.target_by_uuid(horizon_client::lan::playerdata::ints_uuid(u))
    // rust: })
    // rust: .filter(|owner| {
    // rust: matches!(
    // rust: owner,
    // rust: Target::Player
    // rust: | Target::Guest(_)
    // rust: | Target::Mob(_)
    // rust: | Target::Stand(_)
    // rust: | Target::Dragon(_)
    // rust: )
    // rust: })
    // rust: .into_iter()
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
            // Leashable.getLeashHolder: the server's resolved holder, not a
            // saved UUID that is still waiting for tickLeash to restore it.
    // rust: Some("leasher") => {
    // rust: let leash =
    // rust: match entity {
    // rust: Target::Mob(id) => self.mobs.iter().find(|m| m.id == id).and_then(|m| {
    // rust: m.extra.leash.map(|holder| (holder, m.extra.leash_player))
    // rust: }),
    // rust: Target::Boat(id) => self
    // rust: .boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .and_then(|b| b.leash.map(|holder| (holder, b.leash_player))),
    // rust: _ => None,
}
    // rust: leash
    // rust: .and_then(|(holder, player)| match holder {
                        // The player who tied it (the host's when unrecorded).
    // rust: horizon_client::mobs::leash::Holder::Player => {
    // rust: let uuid = player.or(self.level.player_uuid)?;
    // rust: self.target_by_uuid(horizon_client::lan::playerdata::ints_uuid(uuid))
}
    // rust: horizon_client::mobs::leash::Holder::Mob(i) => Some(Target::Mob(i)),
    // rust: horizon_client::mobs::leash::Holder::Boat(_)
    // rust: | horizon_client::mobs::leash::Holder::Knot(_) => None,
    // rust: })
    // rust: .into_iter()
    // rust: .collect()
}
            // TraceableEntity.getOwner: who shot a projectile, who threw an
            // item, who summoned a vex.
    // rust: Some("origin") => match entity {
    // rust: Target::Projectile(id) => self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|p| p.id == id)
    // rust: .and_then(|p| {
                        // Projectile.getOwner resolves EntityReference<Entity>,
                        // including loaded owners that cannot be a Who.
    // rust: let Some(owner) = p.owner else {
    // rust: return p.owner_uuid.and_then(|uuid| {
    // rust: self.target_by_uuid(horizon_client::lan::playerdata::ints_uuid(
    // rust: uuid,
    // rust: ))
    // rust: });
}
    // rust: match (owner, p.guest) {
                            // A guest's shot: `Who::Player` is them.
    // rust: (horizon_client::mobs::Who::Player, Some(conn))
    // rust: if self.lan_acting == Some(conn) =>
    // rust: {
    // rust: Some(Target::Player)
}
    // rust: (horizon_client::mobs::Who::Player, Some(conn)) => {
    // rust: Some(Target::Guest(conn))
}
    // rust: (horizon_client::mobs::Who::Player, None) => Some(Target::Player),
    // rust: (horizon_client::mobs::Who::Mob(id), _) => Some(Target::Mob(id)),
}
    // rust: })
    // rust: .into_iter()
    // rust: .collect(),
    // rust: Target::Item(id) => self
    // rust: .dropped
    // rust: .iter()
    // rust: .find(|d| d.id == id)
    // rust: .and_then(|d| d.thrower)
    // rust: .and_then(|words| {
    // rust: let uuid = words
    // rust: .iter()
    // rust: .fold(0u128, |all, w| all << 32 | u128::from(*w as u32));
    // rust: self.target_by_uuid(uuid)
    // rust: })
    // rust: .into_iter()
    // rust: .collect(),
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && m.kind.id == "minecraft:vex")
    // rust: .map(|m| m.extra.counter2 as u32)
    // rust: .filter(|owner| *owner != 0)
    // rust: .map(Target::Mob)
    // rust: .into_iter()
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: Some("vehicle") => self.ride_vehicle(entity).into_iter().collect(),
    // rust: Some("controller") | Some("passengers") => match entity {
    // rust: Target::Mob(id) if self.mobs.iter().any(|m| m.id == id && m.rider.is_some()) => {
    // rust: vec![Target::Player]
}
    // rust: _ => Vec::new(),
    // rust: },
    // rust: Some("target") | Some("attacker") => {
    // rust: let attacker = c.literals.last().is_some_and(|l| l == "attacker");
    // rust: match entity {
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .and_then(|m| {
    // rust: if attacker {
    // rust: m.ai.last_hurt_by
    // rust: } else {
    // rust: m.ai.target
}
    // rust: })
    // rust: .map(|w| match w {
    // rust: horizon_client::mobs::Who::Player => {
                                // LivingEntity.getLastHurtByMob is the player
                                // who hit it, not whichever client is reading it.
    // rust: match self.last_hurt_by_player.get(&id) {
    // rust: Some(Some(conn))
    // rust: if attacker && self.lan_acting != Some(*conn) =>
    // rust: {
    // rust: Target::Guest(*conn)
}
    // rust: _ => Target::Player,
}
}
    // rust: horizon_client::mobs::Who::Mob(i) => Target::Mob(i),
    // rust: })
    // rust: .into_iter()
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
    // rust: _ => Vec::new(),
}
    // rust: found
    // rust: .into_iter()
    // rust: .filter(|t| self.target_position(*t).is_some())
    // rust: .map(|t| Source {
    // rust: entity: Some(t),
    // rust: ..s
    // rust: })
    // rust: .collect()
}
    // `ServerLevel.getEntity(UUID)`: any entity of the level in place, not
    // only mobs (displays, armor stands, items...). The map is keyed by id,
    // so a killed entity and a later summon of the same UUID can both be
    // in it; the one the level still holds is the entity.
    // rust: pub(in crate::game) fn target_with_uuid(&self, uuid: [i32; 4]) -> Option<Target> {
    // rust: if is_player_in_place(uuid, self.lan_acting_uuid, self.level.player_uuid) {
    // rust: return Some(Target::Player);
}
    // rust: self.persist.uuids.iter().find_map(|(&id, found)| {
    // rust: if *found != uuid {
    // rust: return None;
}
    // rust: self.level_entity(i32::try_from(id).ok()?)
    // rust: })
}
    // The highest block of a heightmap type at a column (`Level.getHeight`).
heightmap_at :: proc(self: ^Self, kind: string, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let top = self.world.top_y();
    // rust: for y in (self.world.bottom_y()..top).rev() {
    // rust: let state = self.world.block(x, y, z);
    // rust: if state == self.world.air {
    // rust: continue;
}
    // rust: let facts = self.res.facts().get(state);
    // rust: let blocks = facts.legacy_solid || facts.fluid != horizon_client::blocks::Fluid::None;
    // rust: let leaves = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .is_some_and(|s| s.name.ends_with("_leaves"));
    // rust: let found = match kind {
    // rust: "ocean_floor" => facts.legacy_solid,
    // rust: "motion_blocking" => blocks,
    // rust: "motion_blocking_no_leaves" => blocks && !leaves,
    // rust: _ => true,
}
    // rust: if found {
    // rust: return y + 1;
}
}
    // rust: self.world.bottom_y()
}
    // A `store` modifier: a new callback in the source's chain.
store_source :: proc(self: ^Self, c: ^Context, s: Source) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let result = c.has("result");
    // rust: let target = if c.has("score") {
    // rust: let holders = self.score_holder_names(c, "targets", true)?;
    // rust: let Some(Arg::Str(objective)) = c.get("objective") else {
    // rust: return Err(err("command.failed", &[]));
}
    // rust: if self.score.board.objective(objective).is_none() {
    // rust: return Err(err("arguments.objective.notFound", &[objective]));
}
    // rust: StoreTarget::Score(holders, objective.clone())
    // rust: } else if c.has("bossbar") {
    // rust: let Some(Arg::Resource(id)) = c.get("id") else {
    // rust: return Err(err("command.failed", &[]));
}
    // rust: if !self.bossbar_exists(id) {
    // rust: return Err(err("commands.bossbar.unknown", &[id]));
}
    // rust: StoreTarget::Bossbar(id.clone(), c.has("value"))
    // rust: } else {
    // rust: let r = self.data_ref(c, 0)?;
    // rust: let path = match c.get("path") {
    // rust: Some(Arg::Str(p)) => {
    // rust: NbtPath::parse(p).map_err(horizon_client::data_cmd::path_error)?
}
    // rust: _ => return Err(err("command.failed", &[])),
}
    // rust: let kind = c
    // rust: .literals
    // rust: .iter()
    // rust: .find(|l| {
    // rust: matches!(
    // rust: l.as_str(),
    // rust: "int" | "float" | "short" | "long" | "double" | "byte"
    // rust: )
    // rust: })
    // rust: .cloned()
    // rust: .unwrap_or_else(|| "int".into());
    // rust: let scale = match c.get("scale") {
    // rust: Some(Arg::Double(v)) => *v,
    // rust: _ => 1.0,
}
    // rust: StoreTarget::Data(r, path, kind, scale)
}
    // rust: self.exec.stores.push(StoreEntry {
    // rust: result,
    // rust: target,
    // rust: parent: s.store,
    // rust: });
    // rust: Ok(Source {
    // rust: store: Some(self.exec.stores.len() as u32 - 1),
    // rust: ..s
    // rust: })
}
    // CommandSourceStack.facing: rotation from the anchor point to `to`.
facing :: proc(self: ^Self, s: Source, to: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let from = self.anchor_position(&s);
    // rust: let (dx, dy, dz) = (to[0] - from[0], to[1] - from[1], to[2] - from[2]);
    // rust: let horizontal = (dx * dx + dz * dz).sqrt();
    // rust: let pitch = (-(dy.atan2(horizontal).to_degrees())) as f32;
    // rust: let yaw = (dz.atan2(dx).to_degrees() - 90.0) as f32;
    // rust: Source {
    // rust: rot: [yaw.rem_euclid(360.0), pitch],
    // rust: ..s
}
}

    // ---- conditions ----------------------------------------------------------

    // Whether the source stays for `if`/`unless` (`want`), and the count the
    // numeric conditions report.
condition :: proc(self: ^Self, c: ^Context, want: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if c.has("function") {
    // rust: return self.condition_function(c, want);
}
    // rust: let (matched, count) = self.condition_matches(c)?;
    // rust: Ok((matched == want, count))
}
    // `if function`/`unless function`: the source stays when a function
    // returns a non-zero (`if`) or zero (`unless`) value; one that does not
    // return leaves it out either way.
condition_function :: proc(self: ^Self, c: ^Context, want: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Arg::Resource(name)) = c.get("name").cloned() else {
    // rust: return Ok((false, 0));
}
    // rust: let results = self.call_function_ref(&name, None)?;
    // rust: let keep = results.iter().any(|r| r.is_some_and(|v| (v != 0) == want));
    // rust: Ok((keep, 0))
}
    // `ExecuteCommand.isChunkLoaded`: an entity-ticking loading status and
    // completed entity loading, rather than merely a retained lit column.
command_chunk_loaded :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.tickets.levels().loaded_entity_ticking(x, z)
    // rust: && self.world.chunks.contains_key(&(x, z))
    // rust: && self.streaming.is_lit(x, z)
            // Streaming queues the saved tags before making the column resident;
            // spawn_loaded_entities applies them before this chunk's entities run.
    // rust: && !self.world.loaded_entities.iter().any(|(key, _)| *key == (x, z))
}

condition_matches :: proc(self: ^Self, c: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let flag = |b: bool| (b, i32::from(b));
    // rust: if c.has("data") {
    // rust: let r = self.data_ref_named(c, 0, "source")?;
    // rust: let data = self.data_of(&r)?;
    // rust: let Some(Arg::Str(p)) = c.get("path") else {
    // rust: return Ok((false, 0));
}
    // rust: let path = NbtPath::parse(p).map_err(horizon_client::data_cmd::path_error)?;
    // rust: let n = path.count(&data) as i32;
    // rust: return Ok((n > 0, n));
}
    // rust: if c.has("items") || c.has("slots") {
    // rust: return self.condition_items(c);
}
    // rust: if c.has("entity") {
    // rust: let Some(Arg::Entity(sel)) = c.get("entities").cloned() else {
    // rust: return Ok((false, 0));
}
    // rust: let n = self.select(&sel).len() as i32;
    // rust: return Ok((n > 0, n));
}
    // rust: if c.has("loaded") {
    // rust: let p = self
    // rust: .coords(c, "pos")
    // rust: .map(|co| co.block(self.source_position(), self.source_rotation()));
    // rust: let dimension = self.command_source.map_or(self.dim, |s| s.dimension);
    // rust: return Ok(flag(
    // rust: dimension == self.dim
    // rust: && p.is_some_and(|p| self.command_chunk_loaded(p[0] >> 4, p[2] >> 4)),
    // rust: ));
}
    // rust: if c.has("dimension") {
    // rust: let dimension = self.command_source.map_or(self.dim, |s| s.dimension);
    // rust: return Ok(flag(matches!(c.get("dimension"), Some(Arg::Resource(d))
    // rust: if d.as_str() == dimension.id())));
}
    // rust: if c.has("block") {
    // rust: let p = self.block_pos_arg(c, "pos")?;
    // rust: let Some(Arg::Block(b)) = c.get("block").cloned() else {
    // rust: return Ok((false, 0));
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: return Ok(flag(self.block_matches(&b, state)));
}
    // rust: if c.has("biome") {
    // rust: let p = self.block_pos_arg(c, "pos")?;
    // rust: let Some(Arg::Resource(want_biome)) = c.get("biome").cloned() else {
    // rust: return Ok((false, 0));
}
    // rust: let name = self.biome_name_at_block(p);
    // rust: return Ok(flag(
    // rust: name.is_some_and(|n| self.biome_matches(&want_biome, &n)),
    // rust: ));
}
    // rust: if c.has("score") {
    // rust: return self.condition_score(c).map(flag);
}
    // rust: if c.has("blocks") {
    // rust: return self.condition_blocks(c);
}
    // rust: if c.has("range") && c.has("id") {
    // rust: return self.condition_stopwatch(c).map(flag);
}
    // rust: if c.has("predicate") {
    // rust: let Some(Arg::Resource(id)) = c.get("predicate").cloned() else {
    // rust: return Ok((false, 0));
}
    // rust: return Ok(flag(self.check_predicate(&id)?));
}
    // rust: Ok((false, 0))
}
condition_stopwatch :: proc(self: ^Self, c: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Arg::Resource(id)) = c.get("id").cloned() else {
    // rust: return Ok(false);
}
    // rust: let Some(Arg::DoubleRange((lo, hi))) = c.get("range").cloned() else {
    // rust: return Ok(false);
}
    // rust: let Some(t) = self.score.stopwatches.elapsed_seconds(&id) else {
    // rust: return Err(err("commands.stopwatch.does_not_exist", &[&id]));
}
    // rust: Ok(lo.is_none_or(|l| t >= l) && hi.is_none_or(|h| t <= h))
}
condition_score :: proc(self: ^Self, c: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let target = self.score_holder_names(c, "target", false)?;
    // rust: let Some(Arg::Str(to)) = c.get("targetObjective").cloned() else {
    // rust: return Ok(false);
}
    // rust: if self.score.board.objective(&to).is_none() {
    // rust: return Err(err("arguments.objective.notFound", &[&to]));
}
    // rust: let Some(a) = target
    // rust: .first()
    // rust: .and_then(|t| self.score.board.score(t, &to))
    // rust: .map(|s| s.value)
    // rust: else {
    // rust: return Ok(false);
}
    // rust: if c.has("matches") {
    // rust: let Some(Arg::IntRange((lo, hi))) = c.get("range") else {
    // rust: return Ok(false);
}
    // rust: return Ok(lo.is_none_or(|l| a >= l) && hi.is_none_or(|h| a <= h));
}
    // rust: let source = self.score_holder_names(c, "source", false)?;
    // rust: let Some(Arg::Str(so)) = c.get("sourceObjective").cloned() else {
    // rust: return Ok(false);
}
    // rust: if self.score.board.objective(&so).is_none() {
    // rust: return Err(err("arguments.objective.notFound", &[&so]));
}
    // rust: let Some(b) = source
    // rust: .first()
    // rust: .and_then(|t| self.score.board.score(t, &so))
    // rust: .map(|s| s.value)
    // rust: else {
    // rust: return Ok(false);
}
    // rust: let op = c.literals.last().map_or("", String::as_str);
    // rust: Ok(match op {
    // rust: "=" => a == b,
    // rust: "<" => a < b,
    // rust: "<=" => a <= b,
    // rust: ">" => a > b,
    // rust: ">=" => a >= b,
    // rust: _ => false,
    // rust: })
}
    // `if blocks`: the region at `start..end` equals the one at `destination`.
condition_blocks :: proc(self: ^Self, c: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b, d) = (
    // rust: self.block_pos_arg(c, "start")?,
    // rust: self.block_pos_arg(c, "end")?,
    // rust: self.block_pos_arg(c, "destination")?,
    // rust: );
    // rust: let masked = c.has("masked");
    // rust: let lo = [a[0].min(b[0]), a[1].min(b[1]), a[2].min(b[2])];
    // rust: let hi = [a[0].max(b[0]), a[1].max(b[1]), a[2].max(b[2])];
    // rust: let area = i64::from(hi[0] - lo[0] + 1)
    // rust: * i64::from(hi[1] - lo[1] + 1)
    // rust: * i64::from(hi[2] - lo[2] + 1);
    // rust: if area > 32768 {
    // rust: return Err(err("commands.execute.blocks.toobig", &[&32768, &area]));
}
    // rust: let offset = [d[0] - lo[0], d[1] - lo[1], d[2] - lo[2]];
    // rust: let mut count = 0;
    // rust: for z in lo[2]..=hi[2] {
    // rust: for y in lo[1]..=hi[1] {
    // rust: for x in lo[0]..=hi[0] {
    // rust: let src = self.world.block(x, y, z);
    // rust: if masked && src == self.world.air {
    // rust: continue;
}
    // rust: let (dx, dy, dz) = (x + offset[0], y + offset[1], z + offset[2]);
    // rust: if src != self.world.block(dx, dy, dz) {
    // rust: return Ok((false, 0));
}
    // rust: let (se, de) = (
    // rust: self.world.block_entities.get(&(x, y, z)),
    // rust: self.world.block_entities.get(&(dx, dy, dz)),
    // rust: );
    // rust: if let Some(se) = se {
    // rust: let name = self.data_block_name([x, y, z]);
    // rust: let Some(de) = de else {
    // rust: return Ok((false, 0));
}
    // rust: let st = horizon_client::save::encode_block_entity((0, 0, 0), se, &name);
    // rust: let dt = horizon_client::save::encode_block_entity((0, 0, 0), de, &name);
    // rust: if st != dt {
    // rust: return Ok((false, 0));
}
}
    // rust: count += 1;
}
}
}
    // rust: Ok((true, count))
}
    // The biome name at a block position.
biome_name_at_block :: proc(self: ^Self, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let chunk = self.world.chunks.get(&(p[0] >> 4, p[2] >> 4))?;
        // The world's table (`world_biomes!`): a packed biome's id is past
        // the built-in list, and `Biomes::get` would clamp it to the last
        // vanilla one.
    // rust: Some(
    // rust: world_biomes!(self)
    // rust: .get(chunk.biome(p[0], p[1], p[2]))
    // rust: .name
    // rust: .clone(),
    // rust: )
}
    // A biome id or `#tag` matched against a biome name.
    // rust: pub(super) fn biome_matches(&self, wanted: &str, biome: &str) -> bool {
    // rust: match wanted.strip_prefix('#') {
    // rust: Some(tag) => self.biome_tag_has(tag, biome),
    // rust: None => wanted == biome,
}
}
    // `#tag`: the biome tags the game's files and the world's packs define,
    // nested tags expanded; an unknown tag falls back to the game's built-in
    // table.
biome_tag_has :: proc(self: ^Self, tag: string, biome: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let entries = self.tag_entries("worldgen/biome", tag);
    // rust: entries.iter().any(|id| id == biome)
    // rust: || (entries.is_empty() && self.res.mob_data().biome_has(tag, biome))
}
}

// Whether `uuid` is the player in place (`Target::Player`): during a guest's turn that is the guest, not the
// level's own player (the world owner), whom `Level.getEntity(UUID)` finds only while they are in the level.
    // rust: fn is_player_in_place(
    // rust: uuid: [i32; 4],
    // rust: acting: Option<u128>,
    // rust: level_player: Option<[i32; 4]>,
    // rust: ) -> bool {
    // rust: match acting {
    // rust: Some(guest) => horizon_client::lan::playerdata::ints_uuid(uuid) == guest,
    // rust: None => Some(uuid) == level_player,
}
}

    // rust: mod tests {
//     use super::is_player_in_place;
//     use horizon_client::lan::playerdata::ints_uuid;

OWNER :: [0, 0, 0, 12]
GUEST :: [0, 0, 0, 13]

    // A owns the world, B is a guest: the sequence of one command each way.
the_owners_uuid_is_not_the_guest_in_place :: proc() {
}
        // A's own command, or the single-player one: no guest in place, the level's player is.
    // rust: assert!(is_player_in_place(OWNER, None, Some(OWNER)));
    // rust: assert!(!is_player_in_place(GUEST, None, Some(OWNER)));
        // B's turn: only B is in place, the owner's UUID names someone else.
    // rust: let b = Some(ints_uuid(GUEST));
    // rust: assert!(is_player_in_place(GUEST, b, Some(OWNER)));
    // rust: assert!(!is_player_in_place(OWNER, b, Some(OWNER)));
        // A's own turn as a guest of an integrated server.
    // rust: let a = Some(ints_uuid(OWNER));
    // rust: assert!(is_player_in_place(OWNER, a, Some(OWNER)));
    // rust: assert!(!is_player_in_place(GUEST, a, Some(OWNER)));
        // No level player at all (a dedicated server): nobody is in place without a guest.
    // rust: assert!(!is_player_in_place(OWNER, None, None));
}
}
