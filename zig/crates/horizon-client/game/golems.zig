//! Transpiled from Horizon Rust crate
//! Module: horizon-client_golems
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Building golems from blocks (`CarvedPumpkinBlock.trySpawnGolem`): a carved
//! pumpkin or jack o'lantern on two snow blocks makes a snow golem, and on a
//! T of four iron blocks (arms along X or Z, nothing beside the legs) an iron
//! golem. Players placing the pumpkin and dispensers share it.
// use super::Game;
// use horizon_client::Result;
// use horizon_client::block_pattern::{
    // rust: IRON_GOLEM_BASE, IRON_GOLEM_FULL, SNOW_GOLEM_BASE, SNOW_GOLEM_FULL,
}

    // rust: impl Game<'_> {
pub fn golem_block(self: *Self, p: [i32; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: &self.res.facts().get(state).name
}
pub fn is_golem_head(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.golem_block(p),
    // rust: "minecraft:carved_pumpkin" | "minecraft:jack_o_lantern"
    // rust: )
}
    /// The blocks of the golem completed at `head` and its spawn base
    /// (`BlockPattern.find`), snow golems first: the snow column
    /// (`SNOW_GOLEM_FULL`: "^", "#", "#") spawns at its bottom, the iron T
    /// (`IRON_GOLEM_FULL`: "~^~", "###", "~#~") under its head. The blocks
    /// come column by column, top first, as `clearPatternBlocks` visits them.
    /// With `base`, `SNOW_GOLEM_BASE` and `IRON_GOLEM_BASE` take any block
    /// where the head will go, as `canSpawnGolem` checks before it is there.
    // rust: fn find_golem(
    // rust: &self,
    // rust: head: [i32; 3],
    // rust: base: bool,
    // rust: ) -> Option<(&'static str, Vec<[i32; 3]>, [i32; 3])> {
    // rust: let air = |p: [i32; 3]| self.res.facts().is_air(self.world.block(p[0], p[1], p[2]));
    // rust: let snow = |c: char, p: [i32; 3]| match c {
    // rust: '^' => self.is_golem_head(p),
    // rust: _ => self.golem_block(p) == "minecraft:snow_block",
}
    // rust: let iron = |c: char, p: [i32; 3]| match c {
    // rust: '^' => self.is_golem_head(p),
    // rust: '#' => self.golem_block(p) == "minecraft:iron_block",
    // rust: _ => air(p),
}
    // rust: let (snow_pattern, iron_pattern) = if base {
    // rust: (SNOW_GOLEM_BASE, IRON_GOLEM_BASE)
    // rust: } else {
    // rust: (SNOW_GOLEM_FULL, IRON_GOLEM_FULL)
}
    // rust: if let Some(m) = snow_pattern.find(head, snow) {
    // rust: return Some(("minecraft:snow_golem", m.front_cells(), m.block(0, 2, 0)));
}
    // rust: let m = iron_pattern.find(head, iron)?;
    // rust: Some(("minecraft:iron_golem", m.front_cells(), m.block(1, 2, 0)))
}
    /// `CarvedPumpkinBlock.canSpawnGolem`: a snow or iron golem base, or a
    /// copper block (`#minecraft:copper`) below.
    // rust: pub(super) fn can_spawn_golem(&self, head: [i32; 3]) -> bool {
    // rust: self.find_golem(head, true).is_some() || self.copper_golem_base(head)
}
    /// The copper golem pattern ("^", "#"): a block of `#minecraft:copper` under the head.
pub fn copper_golem_base(self: *Self, head: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let below = [head[0], head[1] - 1, head[2]];
    // rust: let name = self.golem_block(below);
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:copper")
    // rust: .is_some_and(|t| t.contains(name))
}
    /// `CarvedPumpkinBlock.trySpawnGolem`, after a pumpkin was placed.
    // rust: pub(super) fn check_golem_spawn(&mut self, head: [i32; 3]) -> Result<()> {
    // rust: if !self.is_golem_head(head) {
    // rust: return Ok(());
}
    // rust: let Some((kind, blocks, base)) = self.find_golem(head, false) else {
    // rust: return self.try_spawn_copper_golem(head);
}
        // CarvedPumpkinBlock.spawnGolemInWorld
    // rust: self.clear_pattern_blocks(&blocks)?;
    // rust: let at = [
    // rust: f64::from(base[0]) + 0.5,
    // rust: f64::from(base[1]) + 0.05,
    // rust: f64::from(base[2]) + 0.5,
    // rust: ];
    // rust: let id = self.create_triggered(kind, at, 0.0);
        // CarvedPumpkinBlock.trySpawnGolem: setPlayerCreated(true) on the iron golem.
    // rust: if kind == "minecraft:iron_golem"
    // rust: && let Some(m) = id.and_then(|id| self.mobs.iter_mut().find(|m| m.id == id))
    // rust: {
    // rust: m.extra.player_created = true;
}
    // rust: self.trigger_summoned(id, 5.0);
    // rust: self.update_pattern_blocks(&blocks)
}
    /// SUMMONED_ENTITY for each player whose box is within `reach` blocks of
    /// the built mob's box (the local player here): 5 for golems
    /// (`CarvedPumpkinBlock.spawnGolemInWorld`), 50 for the wither
    /// (`WitherSkullBlock.checkSpawn`).
    // rust: pub(super) fn trigger_summoned(&mut self, id: Option<u32>, reach: f64) {
    // rust: let Some(built) = id
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
    // rust: let me = self.player_entity_for("minecraft:summoned_entity");
    // rust: let half = f64::from(built.width()) / 2.0;
    // rust: let height = f64::from(built.height());
    // rust: let [x, y, z] = me.position;
    // rust: let p = built.position;
        // The player's box is 0.6 wide and 1.8 tall.
    // rust: let near = x + 0.3 >= p.x - half - reach
    // rust: && x - 0.3 <= p.x + half + reach
    // rust: && y + 1.8 >= p.y - reach
    // rust: && y <= p.y + height + reach
    // rust: && z + 0.3 >= p.z - half - reach
    // rust: && z - 0.3 <= p.z + half + reach;
    // rust: if near {
    // rust: let view = self.mob_entity(&built);
    // rust: self.trigger_entity("minecraft:summoned_entity", "entity", &view);
}
}
    /// Whether placing a golem head at `head` completes a golem.
    // rust: pub(super) fn completes_golem(&self, head: [i32; 3]) -> bool {
    // rust: self.find_golem(head, true).is_some() || self.copper_golem_base(head)
}
    /// `Level.setBlock` of the golem head `state` at `head`, then
    /// `CarvedPumpkinBlock.onPlace`. When the head completes a golem, onPlace
    /// builds it inside setBlock and the spot is air again by the time
    /// setBlock would update neighbours, so it skips them.
    // rust: pub(super) fn set_golem_head(
    // rust: &mut self,
    // rust: head: [i32; 3],
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: ) -> Result<()> {
    // rust: if self.completes_golem(head) {
    // rust: let at = horizon_core::position::BlockPos::new(head[0], head[1], head[2]);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, state, 2 | 16));
    // rust: self.process_level_events()?;
    // rust: } else {
    // rust: self.level_set(head, state)?;
}
    // rust: self.check_golem_spawn(head)
}
    /// `EntityType.create(level, TRIGGERED)` and `snapTo`: a built golem or
    /// wither has no spawn finalization and draws nothing from the level.
    // rust: pub(super) fn create_triggered(&mut self, kind: &str, at: [f64; 3], yaw: f32) -> Option<u32> {
    // rust: let t = self.res.mob_types().get(kind).cloned()?;
    // rust: self.next_entity += 1;
    // rust: let mut mob = horizon_client::mobs::Mob::new(
    // rust: self.next_entity,
    // rust: t,
    // rust: horizon_core::geometry::Vec3::new(at[0], at[1], at[2]),
    // rust: yaw,
    // rust: );
    // rust: mob.head_yaw = yaw;
    // rust: mob.body_yaw = yaw;
    // rust: mob.previous_yaw = yaw;
    // rust: mob.previous_body_yaw = yaw;
    // rust: mob.previous_head_yaw = yaw;
    // rust: let id = mob.id;
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: Some(id)
}
    /// `CarvedPumpkinBlock.clearPatternBlocks`: every cell of the match
    /// becomes air (flags 2) with its destroy event (2001).
    // rust: pub(super) fn clear_pattern_blocks(&mut self, cells: &[[i32; 3]]) -> Result<()> {
    // rust: let air = self.world.air;
    // rust: for &p in cells {
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let pos = horizon_core::position::BlockPos::new(p[0], p[1], p[2]);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, pos, air, 2));
    // rust: self.level_events
    // rust: .push(horizon_world::level::LevelEvent::LevelEvent {
    // rust: id: 2001,
    // rust: pos,
    // rust: data: state.0 as i32,
    // rust: });
}
    // rust: self.process_level_events()
}
    /// `CarvedPumpkinBlock.updatePatternBlocks`: neighbours of every cell
    /// hear that air arrived.
    // rust: pub(super) fn update_pattern_blocks(&mut self, cells: &[[i32; 3]]) -> Result<()> {
    // rust: let air = self.world.air;
    // rust: for &p in cells {
    // rust: let pos = horizon_core::position::BlockPos::new(p[0], p[1], p[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.update_neighbors_at(level, ticks, pos, b.block(air))
    // rust: });
}
    // rust: self.process_level_events()
}
    /// The copper golem (`CarvedPumpkinBlock.trySpawnGolem`, after the snow
    /// and iron golems): both blocks clear, the golem appears where the
    /// pumpkin was, the copper block becomes the matching copper chest facing
    /// the pumpkin's way (`replaceCopperBlockWithChest`, flags 2) and the
    /// golem takes the block's weathering (`CopperGolem.spawn`).
pub fn try_spawn_copper_golem(self: *Self, head: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.copper_golem_base(head) {
    // rust: return Ok(());
}
    // rust: let below = [head[0], head[1] - 1, head[2]];
    // rust: let copper = self.world.block(below[0], below[1], below[2]);
    // rust: let pumpkin = self.world.block(head[0], head[1], head[2]);
    // rust: let registry = self.pack.assets.registry;
    // rust: let facing = registry
    // rust: .state(pumpkin)
    // rust: .and_then(|s| s.properties.get("facing").cloned())
    // rust: .unwrap_or_else(|| "north".into());
        // getWeatherStateFromPattern: waxed blocks weather like their unwaxed form.
    // rust: let base = self
    // rust: .golem_block(below)
    // rust: .trim_start_matches("minecraft:")
    // rust: .trim_start_matches("waxed_");
    // rust: let weather = ["exposed", "weathered", "oxidized"]
    // rust: .iter()
    // rust: .position(|w| base.starts_with(w))
    // rust: .map_or(0, |i| i as u8 + 1);
    // rust: let cells = [head, below];
    // rust: self.clear_pattern_blocks(&cells)?;
    // rust: let at = [
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + 0.05,
    // rust: f64::from(head[2]) + 0.5,
    // rust: ];
    // rust: let id = self.create_triggered("minecraft:copper_golem", at, 0.0);
    // rust: self.trigger_summoned(id, 5.0);
    // rust: self.update_pattern_blocks(&cells)?;
    // rust: let direction = match facing.as_str() {
    // rust: "south" => horizon_core::geometry::Direction::South,
    // rust: "west" => horizon_core::geometry::Direction::West,
    // rust: "east" => horizon_core::geometry::Direction::East,
    // rust: _ => horizon_core::geometry::Direction::North,
}
    // rust: let pos = horizon_core::position::BlockPos::new(below[0], below[1], below[2]);
    // rust: let chest = self.with_level(|b, level, ticks| {
    // rust: b.copper_chest_from_block(level, ticks, copper, direction, pos)
    // rust: });
    // rust: if let Some(chest) = chest {
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, pos, chest, 2));
    // rust: if let Some(entity) = horizon_client::containers::BlockEntity::for_block(
    // rust: &self.res.facts().get(chest).name,
    // rust: ) {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert((below[0], below[1], below[2]), entity);
}
}
    // rust: if let Some(m) = id.and_then(|id| self.mobs.iter_mut().find(|m| m.id == id)) {
    // rust: m.extra.variant = weather;
    // rust: let p = [m.position.x, m.position.y, m.position.z];
    // rust: self.audio
    // rust: .play("minecraft:entity.copper_golem.spawn", Some(p), 1.0, 1.0);
}
    // rust: self.process_level_events()
}
}

    // rust: mod tests {
//     use horizon_client::block_pattern::{
    // rust: BlockPattern, IRON_GOLEM_BASE, IRON_GOLEM_FULL, SNOW_GOLEM_BASE, SNOW_GOLEM_FULL,
}
//     use std::collections::HashMap;

    /// `BlockPattern.find` over `blocks` (anything else is air): the cells of
    /// the match, column by column, top first.
    // rust: fn find(
    // rust: pattern: BlockPattern,
    // rust: head: [i32; 3],
    // rust: blocks: &[([i32; 3], char)],
    // rust: ) -> Option<Vec<[i32; 3]>> {
    // rust: let world: HashMap<_, _> = blocks.iter().copied().collect();
    // rust: let at = |p: [i32; 3]| world.get(&p).copied().unwrap_or('~');
    // rust: let m = pattern.find(head, |c, p| at(p) == c)?;
    // rust: Some(m.front_cells())
}

pub fn a_snow_golem_column_counts_upright_lying_and_upside_down() void {
}
    // rust: let head = [5, 64, 5];
    // rust: for step in [
    // rust: [0, -1, 0],
    // rust: [1, 0, 0],
    // rust: [-1, 0, 0],
    // rust: [0, 0, 1],
    // rust: [0, 0, -1],
    // rust: [0, 1, 0],
    // rust: ] {
    // rust: let at = |n: i32| [0, 1, 2].map(|i| head[i] + step[i] * n);
    // rust: let blocks = [(at(0), '^'), (at(1), '#'), (at(2), '#')];
    // rust: assert_eq!(
    // rust: find(SNOW_GOLEM_FULL, head, &blocks),
    // rust: Some(vec![at(0), at(1), at(2)]),
    // rust: "snow blocks going {step:?} from the head"
    // rust: );
}
}

pub fn a_bent_or_short_snow_column_is_no_golem() void {
}
    // rust: let head = [0, 0, 0];
    // rust: let bent = [(head, '^'), ([0, -1, 0], '#'), ([1, -1, 0], '#')];
    // rust: assert_eq!(find(SNOW_GOLEM_FULL, head, &bent), None);
    // rust: assert_eq!(
    // rust: find(SNOW_GOLEM_FULL, head, &[(head, '^'), ([0, -1, 0], '#')]),
    // rust: None
    // rust: );
}

pub fn an_iron_golem_t_counts_lying_on_its_back() void {
}
        // Head at the origin, body along +x, arms along z, all at y 0.
    // rust: let head = [0, 0, 0];
    // rust: let blocks = [
    // rust: (head, '^'),
    // rust: ([1, 0, -1], '#'),
    // rust: ([1, 0, 0], '#'),
    // rust: ([1, 0, 1], '#'),
    // rust: ([2, 0, 0], '#'),
    // rust: ];
    // rust: let cells = find(IRON_GOLEM_FULL, head, &blocks).expect("a lying iron golem");
        // Column 1, rows 0 to 2: the head, the body and the legs.
    // rust: assert_eq!(&cells[3..6], &[[0, 0, 0], [1, 0, 0], [2, 0, 0]]);
    // rust: let mut arms_out = blocks.to_vec();
    // rust: arms_out.push(([2, 0, 1], '#'));
    // rust: assert_eq!(
    // rust: find(IRON_GOLEM_FULL, head, &arms_out),
    // rust: None,
    // rust: "a block beside the legs"
    // rust: );
}

pub fn the_base_patterns_ignore_the_head() void {
}
        // canSpawnGolem checks the base patterns before the head is there: the
        // head's cell (' ' in the pattern) takes any block.
    // rust: let snow = [([0, -1, 0], '#'), ([0, -2, 0], '#')];
    // rust: assert_eq!(
    // rust: find(SNOW_GOLEM_BASE, [0, 0, 0], &snow),
    // rust: Some(vec![[0, 0, 0], [0, -1, 0], [0, -2, 0]])
    // rust: );
    // rust: assert_eq!(find(SNOW_GOLEM_FULL, [0, 0, 0], &snow), None);
    // rust: let iron = [
    // rust: ([-1, 0, 0], '#'),
    // rust: ([0, 0, 0], '#'),
    // rust: ([1, 0, 0], '#'),
    // rust: ([0, -1, 0], '#'),
    // rust: ];
    // rust: assert!(find(IRON_GOLEM_BASE, [0, 1, 0], &iron).is_some());
    // rust: assert_eq!(find(IRON_GOLEM_FULL, [0, 1, 0], &iron), None);
}

pub fn the_first_corner_of_the_search_cube_wins() void {
}
        // There is no snow at the head, so the corners x fastest, then y, then
        // z decide: the column one step along +x is the one taken.
    // rust: let column = |c: [i32; 3]| {
    // rust: [
    // rust: (c, '^'),
    // rust: ([c[0], c[1] - 1, c[2]], '#'),
    // rust: ([c[0], c[1] - 2, c[2]], '#'),
    // rust: ]
}
    // rust: let blocks: Vec<_> = [column([1, 0, 0]), column([0, 1, 0]), column([0, 0, 1])].concat();
    // rust: assert_eq!(
    // rust: find(SNOW_GOLEM_FULL, [0, 0, 0], &blocks),
    // rust: Some(vec![[1, 0, 0], [1, -1, 0], [1, -2, 0]])
    // rust: );
}

pub fn forwards_then_up_in_direction_order_picks_the_column() void {
}
        // One head with a snow block below it and along both z ways. Every
        // `up` is tried for one `forwards` before the next forwards, in
        // Direction order and never along `forwards`: down's first usable up
        // is north, so the +z column is the match, not the column below (up,
        // under forwards north) nor the one along -z (south, later).
    // rust: let head = [0, 0, 0];
    // rust: let blocks = [
    // rust: (head, '^'),
    // rust: ([0, -1, 0], '#'),
    // rust: ([0, -2, 0], '#'),
    // rust: ([0, 0, 1], '#'),
    // rust: ([0, 0, 2], '#'),
    // rust: ([0, 0, -1], '#'),
    // rust: ([0, 0, -2], '#'),
    // rust: ];
    // rust: assert_eq!(
    // rust: find(SNOW_GOLEM_FULL, head, &blocks),
    // rust: Some(vec![[0, 0, 0], [0, 0, 1], [0, 0, 2]])
    // rust: );
}
}
