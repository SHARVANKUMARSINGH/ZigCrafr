//! Transpiled from Horizon Rust crate
package horizon_client_test_runs

import "core:fmt"
import "core:mem"
import "core:math"

// `TestCommand` over the test instance blocks of the level in place and the
// game's test instances: `run`, `runmultiple`, `runthese`, `runclosest`,
// `runthat`, `runfailed`, `resetclosest`/`these`/`that`,
// `clearthat`/`these`/`all` and `stop`, with `TestFinder`'s searches.
//
// Retries are `RetryOptions(numberOfTimes, untilFailed)`.
// use super::{Arg, Context, Game, R, err};
// use crate::game::{
    // rust: Dim,
    // rust: game_tests::{Grid, Info, Retry, RunnerOptions, verify_batches},
    // rust: test_instances::TestDef,
}
// use horizon_client::text::{self, Text};
// use horizon_world::worldgen::structure::BoundingBox;
// use horizon_world::worldgen::structure::Rotation;

    // rust: type Pos = (i32, i32, i32);

// `TestFinder.Builder`'s finders that the command picks.
Finder :: enum {
    // `radius(c, r)`.
    Radius(i32),
    // `nearest(c)`.
    Nearest,
    // `allNearby(c)`.
    AllNearby,
    // `lookedAt(c)`.
    LookedAt,
    // `failedTests(c, onlyRequiredTests)`.
    Failed(bool),
    // `byResourceSelection`, `copies` times over.
    Selection { tests: Vec<String>, copies: i32 },
}

// `StructureUtils.getRotationForRotationSteps`.
rotation_for_steps :: proc(steps: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: usize::try_from(steps)
    // rust: .ok()
    // rust: .and_then(|i| Rotation::ALL.get(i).copied())
}

    // rust: impl Game<'_> {
    // `CommandSourceStack.sendFailure`.
test_failure :: proc(self: ^Self, message: Text) {
}
    // rust: if self.command_source.is_some_and(|s| s.silent) {
    // rust: return;
}
    // rust: self.system_message(message.with_color(text::RED));
}

    // `StructureUtils.findTestBlocks`: the test instance blocks within
    // `radius` of `center` (the POI search is a sphere).
    // rust: pub(super) fn find_test_instance_blocks(&self, center: Pos, radius: i32) -> Vec<Pos> {
    // rust: let limit = i64::from(radius) * i64::from(radius);
    // rust: let mut found: Vec<Pos> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter(|(_, e)| {
    // rust: matches!(
    // rust: e,
    // rust: horizon_client::containers::BlockEntity::TestInstanceBlock(_)
    // rust: )
    // rust: })
    // rust: .map(|(p, _)| *p)
    // rust: .filter(|p| {
    // rust: let d = [p.0 - center.0, p.1 - center.1, p.2 - center.2].map(i64::from);
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] <= limit
    // rust: })
    // rust: .collect();
    // rust: found.sort_unstable();
    // rust: found
}

    // The block of the source's position (`BlockPos.containing`).
    // rust: pub(super) fn test_source_block(&self) -> Pos {
    // rust: let p = self.source_position();
    // rust: (
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: )
}

    // `StructureUtils.lookedAtTestPos`: the test whose box the player's
    // view ray (250 blocks) meets, the nearest to the source.
looked_at_test :: proc(self: ^Self, center: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let player = self.player.as_ref()?;
    // rust: let eye = [
    // rust: player.position.x,
    // rust: player.position.y + f64::from(player.dimensions.eye_height),
    // rust: player.position.z,
    // rust: ];
    // rust: let (yaw, pitch) = (
    // rust: f64::from(self.yaw).to_radians(),
    // rust: f64::from(self.pitch).to_radians(),
    // rust: );
    // rust: let look = [
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: ];
    // rust: let end = [0, 1, 2].map(|i| eye[i] + look[i] * 250.0);
    // rust: self.find_test_instance_blocks(center, 250)
    // rust: .into_iter()
    // rust: .filter(|&p| {
    // rust: self.test_structure_box(p).is_some_and(|b| {
    // rust: let min = b.min.map(f64::from);
    // rust: let max = b.max.map(|v| f64::from(v) + 1.0);
    // rust: ray_hits_box(eye, end, min, max)
    // rust: })
    // rust: })
    // rust: .min_by_key(|p| {
    // rust: let d = [p.0 - center.0, p.1 - center.1, p.2 - center.2].map(i64::from);
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2]
    // rust: })
}

    // The test instance blocks a finder gives (`findTestPos`).
finder_positions :: proc(self: ^Self, finder: ^Finder) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let center = self.test_source_block();
    // rust: match finder {
    // rust: Finder::Radius(radius) => self.find_test_instance_blocks(center, *radius),
    // rust: Finder::Nearest => self
    // rust: .find_test_instance_blocks(center, 15)
    // rust: .into_iter()
    // rust: .min_by_key(|p| {
    // rust: (p.0 - center.0).abs() + (p.1 - center.1).abs() + (p.2 - center.2).abs()
    // rust: })
    // rust: .into_iter()
    // rust: .collect(),
    // rust: Finder::AllNearby => self.find_test_instance_blocks(center, 250),
    // rust: Finder::LookedAt => self.looked_at_test(center).into_iter().collect(),
    // rust: Finder::Failed(_) | Finder::Selection { .. } => Vec::new(),
}
}

    // The tests a finder gives (`findTests`), by id.
finder_tests :: proc(self: ^Self, finder: ^Finder) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let keys: Vec<String> = match finder {
    // rust: Finder::Failed(only_required) => self
    // rust: .game_tests
    // rust: .failed
    // rust: .iter()
    // rust: .filter(|k| !only_required || self.test_def(k).is_some_and(|def| def.required))
    // rust: .cloned()
    // rust: .collect(),
    // rust: Finder::Selection { tests, copies } => {
    // rust: (0..*copies).flat_map(|_| tests.iter().cloned()).collect()
}
    // rust: _ => Vec::new(),
}
    // rust: keys.into_iter()
    // rust: .filter_map(|k| self.test_def(&k).map(|def| (k, def)))
    // rust: .collect()
}

    // `verifyStructureExists`.
verify_test_structure :: proc(self: ^Self, structure: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.template_entry(structure).is_some() {
    // rust: return true;
}
    // rust: self.test_failure(Text::translate(
    // rust: "commands.test.error.structure_not_found",
    // rust: &[Text::literal(structure.to_owned())],
    // rust: ));
    // rust: false
}

    // `createGameTestInfo`: the test of a test instance block.
test_info_at :: proc(self: ^Self, pos: Pos, retry: Retry) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let key = self.test_instance_at(pos).and_then(|b| b.data.test.clone());
    // rust: if self.test_instance_at(pos).is_none() {
    // rust: self.test_failure(Text::translate(
    // rust: "commands.test.error.test_instance_not_found.position",
    // rust: &[pos.0, pos.1, pos.2].map(|v| Text::literal(v.to_string())),
    // rust: ));
    // rust: return None;
}
    // rust: let Some(def) = key.as_deref().and_then(|k| self.test_def(k)) else {
    // rust: let name = self.test_name(pos);
    // rust: self.test_failure(Text::translate(
    // rust: "commands.test.error.non_existant_test",
    // rust: &[name],
    // rust: ));
    // rust: return None;
}
    // rust: let key = key.unwrap_or_default();
    // rust: let key = if key.contains(':') {
    // rust: key
    // rust: } else {
    // rust: format!("minecraft:{key}")
}
    // rust: if !self.verify_test_structure(&def.structure) {
    // rust: return None;
}
    // rust: let rotation = self.test_rotation(pos);
    // rust: let id = self.game_tests.next_id();
    // rust: Some(Info::new(id, key, def, Some(pos), self.dim, rotation).with_retry(retry))
}

    // `toGameTestInfo`: a test without a block, in the level in place.
    // rust: fn test_info_for(
    // rust: &mut self,
    // rust: key: String,
    // rust: def: TestDef,
    // rust: steps: i32,
    // rust: retry: Retry,
    // rust: ) -> R<Option<Info>> {
    // rust: if !self.verify_test_structure(&def.structure) {
    // rust: return Ok(None);
}
        // `server.getLevel(dimension)`: the server's levels.
    // rust: let dim = match def.dimension.as_str() {
    // rust: "minecraft:overworld" | "minecraft:the_nether" | "minecraft:the_end" => {
    // rust: Some(Dim::from_id(&def.dimension))
}
    // rust: _ => None,
}
    // rust: .filter(|d| *d == self.dim || !self.options.execution_role.is_client());
    // rust: let Some(dim) = dim else {
    // rust: self.test_failure(Text::literal(format!(
    // rust: "Could not resolve level for dimension: {}",
    // rust: def.dimension
    // rust: )));
    // rust: return Ok(None);
}
    // rust: let rotation = rotation_for_steps(steps).ok_or_else(|| err("command.failed", &[]))?;
    // rust: let id = self.game_tests.next_id();
    // rust: Ok(Some(
    // rust: Info::new(id, key, def, None, dim, rotation).with_retry(retry),
    // rust: ))
}

    // The column `createTestPositionAround` starts from: the source's.
    // rust: pub(super) fn test_around(&self) -> (i32, i32) {
    // rust: let p = self.source_position();
    // rust: (p[0].floor() as i32, p[2].floor() as i32)
}

    // `createTestPositionAround`: three blocks south of the source, on the
    // surface of the level in place (`playerAndTestInfo` loads the chunk of
    // the source's column in that level first).
    // rust: pub(in crate::game) fn test_position_in_level(&mut self, (x, z): (i32, i32)) -> Pos {
    // rust: self.load_test_chunks(&BoundingBox::new([x, 0, z], [x, 0, z]));
    // rust: let facts = self.res.facts();
    // rust: let surface = self.world.world_surface(x, z, |s| facts.is_air(s));
    // rust: (x, surface, z + 3)
}

    // `createTestPositionAround` in the level in place.
    // rust: pub(super) fn test_position_around(&mut self) -> Pos {
    // rust: let around = self.test_around();
    // rust: self.test_position_in_level(around)
}

    // `TestCommand.run`.
run_tests :: proc(self: ^Self, finder: ^Finder, retry: Retry, steps: i32, per_row: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.clear_game_tests();
    // rust: let mut infos = Vec::new();
    // rust: for pos in self.finder_positions(finder) {
    // rust: infos.extend(self.test_info_at(pos, retry));
}
    // rust: for (key, def) in self.finder_tests(finder) {
    // rust: infos.extend(self.test_info_for(key, def, steps, retry)?);
}
    // rust: if infos.is_empty() {
    // rust: self.feedback_unbroadcast(Text::translate("commands.test.no_tests", &[]));
    // rust: return Ok(0);
}
    // rust: self.game_tests.failed.clear();
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.test.run.running",
    // rust: &[Text::literal(infos.len().to_string())],
    // rust: ));
    // rust: let grid = Grid::new(self.test_around(), per_row);
    // rust: self.track_and_start_runner(infos, false, Some(grid));
    // rust: Ok(1)
}

    // `TestCommand.verify`.
    // rust: pub(super) fn test_verify(&mut self, ctx: &Context) -> R<i32> {
    // rust: self.clear_game_tests();
    // rust: let tests = match ctx.get("tests") {
    // rust: Some(Arg::Str(pattern)) => horizon_client::command::args::select_resources(
    // rust: self.ui.registries.ids("minecraft:test_instance"),
    // rust: pattern,
    // rust: )
    // rust: .into_iter()
    // rust: .cloned()
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let finder = Finder::Selection { tests, copies: 1 };
    // rust: let mut infos = Vec::new();
    // rust: for pos in self.finder_positions(&finder) {
    // rust: infos.extend(self.test_info_at(pos, Retry::none()));
}
    // rust: for (key, def) in self.finder_tests(&finder) {
    // rust: infos.extend(self.test_info_for(key, def, 0, Retry::none())?);
}
    // rust: self.game_tests.failed.clear();
    // rust: let batches = verify_batches(&infos, || self.game_tests.next_id());
    // rust: let grid = Grid::new(self.test_around(), 10).clearing();
    // rust: self.track_and_start_batches(batches, RunnerOptions::verify(grid));
    // rust: Ok(1)
}

    // `TestCommand.reset`.
reset_tests :: proc(self: ^Self, finder: ^Finder) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.clear_game_tests();
    // rust: let mut count = 0;
    // rust: for pos in self.finder_positions(finder) {
    // rust: if self.test_info_at(pos, Retry::none()).is_some() {
                // resetGameTestInfo: `TestInstanceBlockEntity.resetTest`.
    // rust: self.reset_test(pos);
    // rust: count += 1;
}
}
    // rust: if count == 0 {
    // rust: return Err(err("commands.test.clear.error.no_tests", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.test.reset.success",
    // rust: &[Text::literal(count.to_string())],
    // rust: ));
    // rust: Ok(count)
}

    // `TestCommand.clear`.
clear_tests :: proc(self: ^Self, finder: ^Finder) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.clear_game_tests();
    // rust: let tests = self.finder_positions(finder);
    // rust: for &pos in &tests {
    // rust: if let Some(area) = self.test_bounding_box(pos) {
    // rust: self.clear_test_space(&area);
}
    // rust: self.remove_test_barriers(pos);
            // level.destroyBlock(pos, false)
    // rust: self.set_test_block_state(
    // rust: pos,
    // rust: "minecraft:air",
    // rust: horizon_world::level::flags::UPDATE_ALL,
    // rust: );
}
    // rust: if tests.is_empty() {
    // rust: return Err(err("commands.test.clear.error.no_tests", &[]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.test.clear.success",
    // rust: &[Text::literal(tests.len().to_string())],
    // rust: ));
    // rust: Ok(tests.len() as i32)
}

    // The `/test` subcommands that run, reset and clear tests.
    // rust: pub(super) fn cmd_test_runs(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let int = |name: &str| match ctx.get(name) {
    // rust: Some(Arg::Int(v)) => Some(*v),
    // rust: _ => None,
}
        // runWithRetryOptions: `RetryOptions(numberOfTimes, untilFailed)`, else
        // no retries.
    // rust: let retry = match int("numberOfTimes") {
    // rust: Some(n) => Retry::new(n, matches!(ctx.get("untilFailed"), Some(Arg::Bool(true)))),
    // rust: None => Retry::none(),
}
    // rust: let has = |word: &str| ctx.literals.iter().any(|l| l == word);
    // rust: let looks = has("runthat") || has("resetthat") || has("clearthat");
    // rust: if looks {
    // rust: self.source_player()?;
}
    // rust: match id {
    // rust: "test.stop" => {
    // rust: self.clear_game_tests();
    // rust: Ok(1)
}
    // rust: "test.run" => {
    // rust: let tests = match ctx.get("tests") {
    // rust: Some(Arg::Str(pattern)) => horizon_client::command::args::select_resources(
    // rust: self.ui.registries.ids("minecraft:test_instance"),
    // rust: pattern,
    // rust: )
    // rust: .into_iter()
    // rust: .cloned()
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let copies = if has("runmultiple") {
    // rust: int("amount").unwrap_or(1)
    // rust: } else {
    // rust: 1
}
    // rust: let finder = Finder::Selection { tests, copies };
    // rust: self.run_tests(
    // rust: &finder,
    // rust: if has("runmultiple") {
    // rust: Retry::none()
    // rust: } else {
    // rust: retry
    // rust: },
    // rust: int("rotationSteps").unwrap_or(0),
    // rust: int("testsPerRow").unwrap_or(8),
    // rust: )
}
    // rust: "test.run.found" => {
    // rust: let finder = if has("runclosest") {
    // rust: Finder::Nearest
    // rust: } else if has("runthat") {
    // rust: Finder::LookedAt
    // rust: } else if has("runfailed") {
    // rust: let only = matches!(ctx.get("onlyRequiredTests"), Some(Arg::Bool(true)));
    // rust: Finder::Failed(only)
    // rust: } else {
    // rust: Finder::AllNearby
}
    // rust: self.run_tests(
    // rust: &finder,
    // rust: retry,
    // rust: int("rotationSteps").unwrap_or(0),
    // rust: int("testsPerRow").unwrap_or(8),
    // rust: )
}
    // rust: _ => {
    // rust: let finder = if has("resetclosest") {
    // rust: Finder::Nearest
    // rust: } else if has("resetthese") || has("clearthese") {
    // rust: Finder::AllNearby
    // rust: } else if looks {
    // rust: Finder::LookedAt
    // rust: } else {
                    // clearall [radius]: clamped to 0..=1024, 250 by default.
    // rust: Finder::Radius(int("radius").map_or(250, |r| r.clamp(0, 1024)))
}
    // rust: if id == "test.clear"
    // rust: && (has("resetclosest") || has("resetthese") || has("resetthat"))
    // rust: {
    // rust: self.reset_tests(&finder)
    // rust: } else {
    // rust: self.clear_tests(&finder)
}
}
}
}
}

// `AABB.clip(from, to).isPresent()`: the segment meets the box.
ray_hits_box :: proc(from: [f64; 3], to: [f64; 3], min: [f64; 3], max: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (mut near, mut far) = (0.0f64, 1.0f64);
    // rust: for i in 0..3 {
    // rust: let d = to[i] - from[i];
    // rust: if d.abs() < 1.0e-7 {
    // rust: if from[i] < min[i] || from[i] > max[i] {
    // rust: return false;
}
    // rust: continue;
}
    // rust: let (a, b) = ((min[i] - from[i]) / d, (max[i] - from[i]) / d);
    // rust: let (lo, hi) = if a < b { (a, b) } else { (b, a) };
    // rust: near = near.max(lo);
    // rust: far = far.min(hi);
    // rust: if near > far {
    // rust: return false;
}
}
    // rust: true
}

    // rust: mod tests {
//     use super::*;

rotation_steps_run_from_zero_to_three :: proc() {
}
    // rust: assert_eq!(rotation_for_steps(0), Some(Rotation::None));
    // rust: assert_eq!(rotation_for_steps(1), Some(Rotation::Clockwise90));
    // rust: assert_eq!(rotation_for_steps(3), Some(Rotation::Counterclockwise90));
    // rust: assert_eq!(rotation_for_steps(4), None);
    // rust: assert_eq!(rotation_for_steps(-1), None);
}

a_ray_meets_a_box_it_crosses_and_misses_one_beside_it :: proc() {
}
    // rust: let (min, max) = ([0.0, 0.0, 0.0], [2.0, 2.0, 2.0]);
    // rust: assert!(ray_hits_box([-5.0, 1.0, 1.0], [5.0, 1.0, 1.0], min, max));
    // rust: assert!(!ray_hits_box([-5.0, 3.0, 1.0], [5.0, 3.0, 1.0], min, max));
    // rust: assert!(!ray_hits_box([-5.0, 1.0, 1.0], [-1.0, 1.0, 1.0], min, max));
}
}
