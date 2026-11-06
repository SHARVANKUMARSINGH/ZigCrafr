//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ticket_levels
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Which chunks tick, from the chunk tickets of `DistanceManager`.
//!
//! Every player holds two kinds of ticket:
//! - `PLAYER_LOADING` at level 31 (`ENTITY_TICKING`) on every chunk within
//!   the server's view distance (Chebyshev), from `PlayerTicketTracker`;
//! - `PLAYER_SIMULATION` at level `31 - simulationDistance` on its own chunk.
//!
//! A `/forceload`ed chunk holds a `FORCED` ticket at level 31 of both kinds.
//! An entity that came through a portal leaves a `PORTAL` ticket of radius 3
//! (`Entity.placePortalTicket`: level 30 of both kinds, for 300 ticks) on the
//! chunk it arrived in; it keeps that level running with no player in it.
//! The dragon fight holds a `DRAGON` ticket of radius 9 for as long as a player
//! watches it (`EnderDragonFight.tick`: level 24 of both kinds on the arena,
//! so its island ticks out to 7 chunks whatever the watcher's simulation
//! distance), and drops it when the last watcher goes.
//! Levels rise by one per chunk away from a ticket (`ChunkTracker`) and each
//! chunk takes the lowest. The loading level gives the chunk's
//! `FullChunkStatus` (`ChunkLevel.fullStatus`: 31 entity ticking, 32 block
//! ticking, 33 full) and the simulation level gives what
//! `inEntityTickingRange` (31 or less) and `inBlockTickingRange` (32 or less)
//! answer. Vanilla needs both:
//! - entities tick where both levels are entity ticking (`ServerLevel.tick`,
//!   and `EntityTickList` holds only the entities of entity-ticking chunks);
//! - random ticks run in the simulation tracker's entity-ticking chunks that
//!   have a ticking chunk (`ChunkMap.forEachBlockTickingChunk`);
//! - scheduled ticks, block events and block entities run where both are
//!   block ticking (`isPositionTickingWithEntitiesLoaded`,
//!   `shouldTickBlocksAt`, `LevelChunk.isTicking`).
//!
//! Whoever the players are (the local player, LAN guests, a dedicated
//! server's players), they count the same.
// use crate::fast_hash::FxHashMap;
// use std::sync::Arc;

/// `ChunkLevel`'s levels.
pub const ENTITY_TICKING: u8 = 31;
pub const BLOCK_TICKING: u8 = 32;
/// What a chunk with no ticket near it has (`FULL` and above count as none).
pub const NONE: (u8, u8) = (BLOCK_TICKING + 1, BLOCK_TICKING + 1);

/// `TicketType.PORTAL`'s timeout, in ticks.
pub const PORTAL_TIMEOUT: i32 = 300;
/// `Entity.placePortalTicket`'s radius: the ticket's level is `FULL` (33)
/// minus it.
pub const PORTAL_RADIUS: i32 = 3;
pub const PORTAL_LEVEL: i32 = BLOCK_TICKING as i32 + 1 - PORTAL_RADIUS;
/// `EnderDragonFight.tick`'s radius on the arena it holds a ticket on:
/// `addTicketWithRadius(TicketType.DRAGON, new ChunkPos(0, 0), 9)`, whose level
/// is `FULL` (33) minus the radius.
pub const ARENA_RADIUS: i32 = 9;
pub const ARENA_LEVEL: i32 = BLOCK_TICKING as i32 + 1 - ARENA_RADIUS;

/// The tickets of one level: where its players are, its forced chunks, its
/// portal tickets, the dragon fight's arena while a player watches it, and the
/// server's view and simulation distances.
pub const Sources = struct {
    players: Vec<(i32,
    forced: Vec<(i32,
    portal: Vec<(i32,
    /// The arena the dragon fight holds a `TicketType.DRAGON` ticket on while
    /// its boss bar has a watcher (`EnderDragonFight.tick`), `None` once none
    /// has (its `removeTicketWithRadius`).
    dragon: Option<(i32,
    view_distance: i32,
    simulation_distance: i32,
};

/// Each chunk's (loading, simulation) level, for the chunks where either is
/// block ticking or lower; `None` ticks everywhere (a game with no server and
/// no player: the headless fixtures). With them sits the box
/// `(min_x, min_z, max_x, max_z)` that holds every chunk that can random tick,
/// so a scan of the residents need not ask each one of them.
pub const Levels = struct {};

/// The levels by chunk: a grid over the tickets' bounding box while it is
/// small (players near each other, the usual case), sparse 16×16 tiles otherwise.
/// Every block entity, mob and ticking chunk asks each tick. Tiling also avoids
/// hashing every chunk when a player crossing a chunk boundary rebuilds the map.
pub const Map = enum {
    Grid {,
    x0: i32,
    z0: i32,
    width: u32,
    depth: u32,
    cells: Box<[(u8, u8)]>,
    // rust: },
    Sparse(FxHashMap<(i32, i32), (u8, u8)>),
    Tiled(Tiled),
};

/// The largest grid, in chunks: 1 MiB of levels, a box 724 chunks wide.
pub const GRID_CELLS: u64 = 1 << 19;

    // rust: impl Map {
pub fn get(self: *Self, x: i32, z: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Grid {
    // rust: x0,
    // rust: z0,
    // rust: width,
    // rust: depth,
    // rust: cells,
    // rust: } => {
    // rust: let (dx, dz) = (x.wrapping_sub(*x0) as u32, z.wrapping_sub(*z0) as u32);
    // rust: if dx < *width && dz < *depth {
    // rust: cells[(dz * width + dx) as usize]
    // rust: } else {
    // rust: NONE
}
}
    // rust: Self::Sparse(map) => map.get(&(x, z)).copied().unwrap_or(NONE),
    // rust: Self::Tiled(map) => map.get(x, z),
}
}
}

    // rust: type Tile = Box<[(u8, u8); 256]>;

/// Sparse tiles keep each nearby run of levels contiguous. Construction hashes
/// once per intersecting tile rather than once per chunk of every ticket.
pub const Tiled = struct {};
    // rust: impl Tiled {
    /// The same levels as the grid, for tickets too far apart for one.
pub fn new(s: *Sources) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut map = Self(FxHashMap::default());
    // rust: let (view, sim, reach) = reach(s);
    // rust: for &p in &s.players {
    // rust: map.add(p, reach, i32::from(ENTITY_TICKING), view, sim);
}
    // rust: for &p in &s.forced {
    // rust: map.add(
    // rust: p,
    // rust: 1,
    // rust: i32::from(ENTITY_TICKING),
    // rust: 0,
    // rust: i32::from(ENTITY_TICKING),
    // rust: );
}
    // rust: for &p in &s.portal {
            // The radius-3 ring is level NONE and cannot lower a cell.
    // rust: map.add(p, PORTAL_RADIUS - 1, PORTAL_LEVEL, 0, PORTAL_LEVEL);
}
    // rust: if let Some(arena) = s.dragon {
            // The same for the ring at the ticket's own radius.
    // rust: map.add(arena, ARENA_RADIUS - 1, ARENA_LEVEL, 0, ARENA_LEVEL);
}
    // rust: map
}
pub fn get(self: *Self, x: i32, z: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(NONE, |tile| tile[((z & 15) * 16 + (x & 15)) as usize])
}
    /// Lower each cell to the minimum of its level and the source plus distance;
    /// loading stays flat within the view distance.
pub fn add(self: *Self) void {
}
    // rust: let (x0, z0, x1, z1) = (px - r, pz - r, px + r, pz + r);
    // rust: for tz in z0 >> 4..=z1 >> 4 {
    // rust: for tx in x0 >> 4..=x1 >> 4 {
    // rust: let tile = self
    // rust: .0
    // rust: .entry((tx, tz))
    // rust: .or_insert_with(|| Box::new([NONE; 256]));
    // rust: let (bx, bz) = (tx * 16, tz * 16);
    // rust: for z in z0.max(bz)..=z1.min(bz + 15) {
    // rust: for x in x0.max(bx)..=x1.min(bx + 15) {
    // rust: let d = (x - px).abs().max((z - pz).abs());
    // rust: let e = &mut tile[((z - bz) * 16 + (x - bx)) as usize];
    // rust: e.0 =
    // rust: e.0.min((loading + (d - flat).max(0)).min(i32::from(NONE.0)) as u8);
    // rust: e.1 = e.1.min((sim + d).min(i32::from(NONE.1)) as u8);
}
}
}
}
}
}

    // rust: impl Levels {
    /// Chunk coordinates.
pub fn get(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(self.0.as_ref()?.get(x, z))
}
    /// `DistanceManager.inEntityTickingRange`, in an entity-ticking chunk:
    /// where entities tick.
pub fn entity_ticking(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x, z)
    // rust: .is_none_or(|(l, s)| l <= ENTITY_TICKING && s <= ENTITY_TICKING)
}
    /// `DistanceManager.inEntityTickingRange` alone: the simulation level,
    /// whatever the chunk's own status. `ChunkMap.tick` sends an entity's
    /// changes there only (or when it changed section or needs sync).
pub fn in_entity_ticking_range(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x, z).is_none_or(|(_, s)| s <= ENTITY_TICKING)
}
    /// `inBlockTickingRange` in a block-ticking chunk: where scheduled ticks,
    /// block events and block entities run.
pub fn block_ticking(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x, z)
    // rust: .is_none_or(|(l, s)| l <= BLOCK_TICKING && s <= BLOCK_TICKING)
}
    /// `inEntityTickingRange` in a block-ticking chunk: where random ticks run.
pub fn random_ticking(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x, z)
    // rust: .is_none_or(|(l, s)| l <= BLOCK_TICKING && s <= ENTITY_TICKING)
}
    /// The box that holds every chunk `random_ticking` can answer for, or
    /// `None` with no tickets at all, where it ticks everywhere. A box whose
    /// minimum is past its maximum holds nothing: the tickets hold no player,
    /// no forced chunk and no `PORTAL` one, so nothing random ticks.
pub fn random_tick_bounds(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.1
}
    /// The loading track has `FullChunkStatus.ENTITY_TICKING`, independently
    /// of whether the simulation tracker also permits entities to tick.
pub fn loaded_entity_ticking(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x, z)
    // rust: .is_none_or(|(loading, _)| loading <= ENTITY_TICKING)
}
    /// `ChunkHolder.getFullStatus` is block ticking or more: the chunk's
    /// ticking future can complete (its saved ticks unpack then).
pub fn loaded_ticking(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x, z).is_none_or(|(l, _)| l <= BLOCK_TICKING)
}
    /// The same as [`Self::entity_ticking`] at a block position.
pub fn entity_ticking_at(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity_ticking(x >> 4, z >> 4)
}
    /// The same as [`Self::block_ticking`] at a block position.
pub fn block_ticking_at(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_ticking(x >> 4, z >> 4)
}
}

/// The levels, rebuilt only when their sources change (a player crossing
/// into another chunk, a distance or a forced chunk changing).
pub const ChunkTickets = struct {
    sources: ?Sources,
    levels: Levels,
    /// The `PORTAL` tickets: the chunk and the ticks it has left.
    portal: Vec<((i32,
};

    // rust: impl ChunkTickets {
    /// `None`: tick everywhere.
pub fn update(self: *Self, mut sources: ?Sources) void {
}
    // rust: if let Some(s) = sources.as_mut() {
    // rust: s.players.sort_unstable();
    // rust: s.players.dedup();
    // rust: s.forced.sort_unstable();
    // rust: s.portal = self.portal.iter().map(|&(c, _)| c).collect();
    // rust: s.portal.sort_unstable();
}
    // rust: if sources == self.sources {
    // rust: return;
}
    // rust: self.levels = match sources.as_ref() {
    // rust: Some(s) => {
    // rust: let map = Some(Arc::new(compute(s)));
                // Tickets with no random tick of their own still get a box, an
                // empty one: `None` is for a game with no tickets at all.
    // rust: Levels(map, Some(random_bounds(s).unwrap_or((1, 1, 0, 0))))
}
    // rust: None => Levels(None, None),
}
    // rust: self.sources = sources;
}
pub fn levels(self: *Self) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.levels.clone()
}
    /// `TicketStorage.addTicket` of a `PORTAL` ticket: one already on the
    /// chunk only starts its timeout again.
pub fn add_portal(self: *Self, chunk: (i32) void {
}
    // rust: match self.portal.iter_mut().find(|(c, _)| *c == chunk) {
    // rust: Some((_, left)) => *left = PORTAL_TIMEOUT,
    // rust: None => self.portal.push((chunk, PORTAL_TIMEOUT)),
}
}
    /// `TicketStorage.purgeStaleTickets` for the `PORTAL` tickets, once a
    /// tick: they time out after `PORTAL_TIMEOUT + 1` ticks.
pub fn tick_portal(self: *Self) void {
}
    // rust: for (_, left) in &mut self.portal {
    // rust: *left -= 1;
}
    // rust: self.portal.retain(|&(_, left)| left >= 0);
}
    /// A `PORTAL` ticket is held (`shouldKeepDimensionActive`), the chunks
    /// it is on.
pub fn portal_chunks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.portal.iter().map(|&(c, _)| c)
}
}

/// The box that holds every chunk `random_ticking` can answer for: a player's
/// simulation ticket reaches its simulation distance, a forced chunk only ever
/// random ticks in the chunk itself, and a `PORTAL` ticket inside its whole
/// area. Each is a superset of that ticket's random-ticking chunks, so the box
/// never rejects a chunk that random ticks.
pub fn random_bounds(s: *Sources) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sim = s.simulation_distance.clamp(0, 32);
    // rust: let boxes = s
    // rust: .players
    // rust: .iter()
    // rust: .map(|&p| (p, sim))
    // rust: .chain(s.forced.iter().map(|&f| (f, 0)))
    // rust: .chain(s.portal.iter().map(|&p| (p, PORTAL_RADIUS)))
    // rust: .chain(s.dragon.map(|arena| (arena, ARENA_RADIUS)));
    // rust: boxes.fold(None, |b, ((x, z), r)| {
    // rust: let (lo_x, lo_z, hi_x, hi_z) = (x - r, z - r, x + r, z + r);
    // rust: Some(match b {
    // rust: None => (lo_x, lo_z, hi_x, hi_z),
    // rust: Some((a, b, c, d)) => (lo_x.min(a), lo_z.min(b), hi_x.max(c), hi_z.max(d)),
    // rust: })
    // rust: })
}

/// How far a player's tickets reach, and the simulation ticket's level.
pub fn reach(s: *Sources) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let view = s.view_distance.clamp(0, 32);
    // rust: let simulation = s.simulation_distance.clamp(0, 32);
    // PLAYER_LOADING within the view distance, PLAYER_SIMULATION at the
    // player's chunk (`getPlayerTicketLevel`: never below 0).
    // rust: let player_sim = (i32::from(ENTITY_TICKING) - simulation).max(0);
    // rust: let reach = (view + 1).max(i32::from(BLOCK_TICKING) - player_sim);
    // rust: (view, player_sim, reach)
}

pub fn compute(s: *Sources) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (view, player_sim, reach) = reach(s);
    // rust: let boxes = s
    // rust: .players
    // rust: .iter()
    // rust: .map(|&p| (p, reach))
    // rust: .chain(s.forced.iter().map(|&f| (f, 1)))
    // rust: .chain(s.portal.iter().map(|&p| (p, PORTAL_RADIUS)))
    // rust: .chain(s.dragon.map(|arena| (arena, ARENA_RADIUS)));
    // rust: let Some((x0, z0, x1, z1)) = boxes.fold(None, |b, ((x, z), r)| {
    // rust: let (lo_x, lo_z, hi_x, hi_z) = (
    // rust: i64::from(x) - i64::from(r),
    // rust: i64::from(z) - i64::from(r),
    // rust: i64::from(x) + i64::from(r),
    // rust: i64::from(z) + i64::from(r),
    // rust: );
    // rust: Some(match b {
    // rust: None => (lo_x, lo_z, hi_x, hi_z),
    // rust: Some((a, b, c, d)) => (lo_x.min(a), lo_z.min(b), hi_x.max(c), hi_z.max(d)),
    // rust: })
    // rust: }) else {
    // rust: return Map::Tiled(Tiled(FxHashMap::default()));
}
    // rust: let (width, depth) = ((x1 - x0 + 1) as u64, (z1 - z0 + 1) as u64);
    // rust: if width * depth > GRID_CELLS {
    // rust: return Map::Tiled(Tiled::new(s));
}
    // rust: let (x0, z0, width, depth) = (x0 as i32, z0 as i32, width as u32, depth as u32);
    // rust: let mut cells = vec![NONE; (width * depth) as usize].into_boxed_slice();
    // rust: let mut lower = |x: i32, z: i32, loading: i32, sim: i32| {
    // rust: let i = ((z - z0) as u32 * width + (x - x0) as u32) as usize;
    // rust: let e = &mut cells[i];
    // rust: e.0 = e.0.min(loading.min(i32::from(NONE.0)) as u8);
    // rust: e.1 = e.1.min(sim.min(i32::from(NONE.1)) as u8);
}
    // rust: for &(px, pz) in &s.players {
    // rust: for dz in -reach..=reach {
    // rust: for dx in -reach..=reach {
    // rust: let d = dx.abs().max(dz.abs());
    // rust: lower(
    // rust: px + dx,
    // rust: pz + dz,
    // rust: i32::from(ENTITY_TICKING) + (d - view).max(0),
    // rust: player_sim + d,
    // rust: );
}
}
}
    // rust: for &(fx, fz) in &s.forced {
    // rust: for dz in -1i32..=1 {
    // rust: for dx in -1i32..=1 {
    // rust: let level = i32::from(ENTITY_TICKING) + dx.abs().max(dz.abs());
    // rust: lower(fx + dx, fz + dz, level, level);
}
}
}
    // rust: for &(cx, cz) in &s.portal {
    // rust: for dz in -PORTAL_RADIUS..=PORTAL_RADIUS {
    // rust: for dx in -PORTAL_RADIUS..=PORTAL_RADIUS {
    // rust: let level = PORTAL_LEVEL + dx.abs().max(dz.abs());
    // rust: lower(cx + dx, cz + dz, level, level);
}
}
}
    // rust: if let Some((ax, az)) = s.dragon {
    // rust: for dz in -ARENA_RADIUS..=ARENA_RADIUS {
    // rust: for dx in -ARENA_RADIUS..=ARENA_RADIUS {
    // rust: let level = ARENA_LEVEL + dx.abs().max(dz.abs());
    // rust: lower(ax + dx, az + dz, level, level);
}
}
}
    // rust: Map::Grid {
    // rust: x0,
    // rust: z0,
    // rust: width,
    // rust: depth,
    // rust: cells,
}
}

/// The old per-chunk map: the reference the grid and tiles are tested against.
pub fn compute_sparse(s: *Sources) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (view, player_sim, reach) = reach(s);
    // rust: let mut levels: FxHashMap<(i32, i32), (u8, u8)> = FxHashMap::default();
    // rust: let mut lower = |key, loading: i32, sim: i32| {
    // rust: let e = levels.entry(key).or_insert(NONE);
    // rust: e.0 = e.0.min(loading.min(i32::from(NONE.0)) as u8);
    // rust: e.1 = e.1.min(sim.min(i32::from(NONE.1)) as u8);
}
    // rust: for &(px, pz) in &s.players {
    // rust: for dz in -reach..=reach {
    // rust: for dx in -reach..=reach {
    // rust: let d = dx.abs().max(dz.abs());
    // rust: lower(
    // rust: (px + dx, pz + dz),
    // rust: i32::from(ENTITY_TICKING) + (d - view).max(0),
    // rust: player_sim + d,
    // rust: );
}
}
}
    // rust: for &(fx, fz) in &s.forced {
    // rust: for dz in -1i32..=1 {
    // rust: for dx in -1i32..=1 {
    // rust: let level = i32::from(ENTITY_TICKING) + dx.abs().max(dz.abs());
    // rust: lower((fx + dx, fz + dz), level, level);
}
}
}
    // rust: for &(cx, cz) in &s.portal {
    // rust: for dz in -PORTAL_RADIUS..=PORTAL_RADIUS {
    // rust: for dx in -PORTAL_RADIUS..=PORTAL_RADIUS {
    // rust: let level = PORTAL_LEVEL + dx.abs().max(dz.abs());
    // rust: lower((cx + dx, cz + dz), level, level);
}
}
}
    // rust: if let Some((ax, az)) = s.dragon {
    // rust: for dz in -ARENA_RADIUS..=ARENA_RADIUS {
    // rust: for dx in -ARENA_RADIUS..=ARENA_RADIUS {
    // rust: let level = ARENA_LEVEL + dx.abs().max(dz.abs());
    // rust: lower((ax + dx, az + dz), level, level);
}
}
}
    // rust: levels.retain(|_, l| *l != NONE);
    // rust: levels
}

    // rust: mod tests {
//     use super::*;

pub fn levels(players: *[(i32) void {
}
    // rust: let mut t = ChunkTickets::default();
    // rust: t.update(Some(Sources {
    // rust: players: players.to_vec(),
    // rust: forced: forced.to_vec(),
    // rust: portal: Vec::new(),
    // rust: dragon: None,
    // rust: view_distance: view,
    // rust: simulation_distance: sim,
    // rust: }));
    // rust: t.levels()
}

pub fn simulation_distance_inside_the_view() void {
}
        // view 8, simulation 4: entities and random ticks out to 4 chunks,
        // scheduled ticks out to 5.
    // rust: let l = levels(&[(0, 0)], &[], 8, 4);
    // rust: assert!(l.entity_ticking(4, -4) && !l.entity_ticking(5, 0));
    // rust: assert!(l.random_ticking(-4, 4) && !l.random_ticking(0, 5));
    // rust: assert!(l.block_ticking(5, 5) && !l.block_ticking(6, 0));
    // rust: assert!(l.loaded_ticking(9, 9) && !l.loaded_ticking(10, 0));
        // A command asks the loading status, not the smaller simulation area.
    // rust: assert!(l.loaded_entity_ticking(8, 8));
    // rust: assert!(!l.loaded_entity_ticking(9, 0));
}

pub fn view_distance_inside_the_simulation() void {
}
        // view 4, simulation 10: what isn't loaded at entity ticking (beyond
        // the view distance) runs no entities, and block ticks stop where the
        // chunk is only full (beyond the view distance + 1).
    // rust: let l = levels(&[(0, 0)], &[], 4, 10);
    // rust: assert!(l.entity_ticking(4, 0) && !l.entity_ticking(5, 0));
    // rust: assert!(l.random_ticking(5, 0) && !l.random_ticking(6, 0));
    // rust: assert!(l.block_ticking(5, 5) && !l.block_ticking(6, 0));
    // rust: assert!(l.loaded_entity_ticking(4, 0));
    // rust: assert!(!l.loaded_entity_ticking(5, 0));
        // ChunkMap.tick's sendChanges reads the simulation level alone.
    // rust: assert!(l.in_entity_ticking_range(10, 0) && !l.in_entity_ticking_range(11, 0));
}

pub fn every_player_and_forced_chunk() void {
}
    // rust: let l = levels(&[(0, 0), (40, 0)], &[(-100, 7)], 4, 4);
    // rust: assert!(l.entity_ticking(44, 0) && l.entity_ticking(0, -4));
    // rust: assert!(!l.entity_ticking(20, 0));
        // A forced chunk entity ticks, its neighbours only block tick.
    // rust: assert!(l.entity_ticking(-100, 7) && !l.entity_ticking(-101, 7));
    // rust: assert!(l.block_ticking(-101, 8) && !l.block_ticking(-102, 7));
    // rust: assert!(!l.random_ticking(-101, 7));
    // rust: assert!(l.entity_ticking_at(-1600, 112) && !l.block_ticking_at(-1617, 112));
}

pub fn no_tickets_tick_nothing_and_no_sources_everything() void {
}
    // rust: let none = levels(&[], &[], 10, 10);
    // rust: assert!(!none.block_ticking(0, 0) && !none.entity_ticking(0, 0));
    // rust: let everywhere = ChunkTickets::default().levels();
    // rust: assert!(everywhere.random_ticking(1000, -1000));
}

    /// `EnderDragonFight.tick` holds the arena's `TicketType.DRAGON` ticket
    /// (radius 9, level 24) for as long as a player watches the fight, so the
    /// island ticks with its watcher far outside their simulation distance,
    /// and drops it when the last watcher goes.
pub fn a_watched_dragon_arena_ticks_beyond_the_watchers_simulation_distance() void {
}
    // rust: let mut t = ChunkTickets::default();
        // A watcher 12 chunks out whose simulation distance is 2: nothing
        // around (0, 0) ticks for it.
    // rust: let sources = |dragon| {
    // rust: Some(Sources {
    // rust: players: vec![(12, 0)],
    // rust: forced: Vec::new(),
    // rust: portal: Vec::new(),
    // rust: dragon,
    // rust: view_distance: 12,
    // rust: simulation_distance: 2,
    // rust: })
}
    // rust: t.update(sources(None));
    // rust: let lonely = t.levels();
    // rust: assert!(!lonely.entity_ticking(0, 0) && !lonely.block_ticking(0, 0));
    // rust: assert!(!lonely.random_ticking(3, 3));
    // rust: t.update(sources(Some((0, 0))));
    // rust: let watched = t.levels();
        // Level 24 on the arena rising one a chunk away: entities out to 7
        // chunks, block ticks and scheduled ticks out to 8.
    // rust: assert!(watched.entity_ticking(0, 0) && watched.entity_ticking(-7, 7));
    // rust: assert!(!watched.entity_ticking(8, 0) && watched.block_ticking(8, -8));
    // rust: assert!(watched.random_ticking(-7, 7) && !watched.random_ticking(8, 0));
    // rust: assert!(watched.loaded_ticking(8, 0) && !watched.block_ticking(9, 9));
        // The watcher's own tickets are what they were.
    // rust: assert!(watched.entity_ticking(12, 0) && !watched.entity_ticking(15, 0));
        // No watcher: the arena goes back to nobody's ticket.
    // rust: t.update(sources(None));
    // rust: assert!(!t.levels().block_ticking(0, 0));
}

pub fn rebuilt_only_when_sources_change() void {
}
    // rust: let mut t = ChunkTickets::default();
    // rust: let s = |players: Vec<(i32, i32)>| {
    // rust: Some(Sources {
    // rust: players,
    // rust: forced: Vec::new(),
    // rust: portal: Vec::new(),
    // rust: dragon: None,
    // rust: view_distance: 2,
    // rust: simulation_distance: 2,
    // rust: })
}
    // rust: t.update(s(vec![(0, 0), (5, 5)]));
    // rust: let first = t.levels();
    // rust: t.update(s(vec![(5, 5), (0, 0)]));
    // rust: assert!(Arc::ptr_eq(
    // rust: first.0.as_ref().unwrap(),
    // rust: t.levels().0.as_ref().unwrap()
    // rust: ));
    // rust: t.update(s(vec![(1, 0), (5, 5)]));
    // rust: assert!(t.levels().entity_ticking(3, 0) && !first.entity_ticking(3, 0));
    // rust: t.update(None);
    // rust: assert!(t.levels().0.is_none());
}

    /// The grid answers as the map does, everywhere around the tickets.
pub fn grid_matches_the_map() void {
}
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = |n: i32| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed % (2 * n as u64 + 1)) as i32 - n
}
    // rust: for case in 0..200 {
    // rust: let spread = [3, 20, 80][case % 3];
    // rust: let players: Vec<_> = (0..1 + case % 12)
    // rust: .map(|_| (next(spread), next(spread)))
    // rust: .collect();
    // rust: let forced: Vec<_> = (0..case % 4)
    // rust: .map(|_| (next(spread), next(spread)))
    // rust: .collect();
    // rust: let s = Sources {
    // rust: players,
    // rust: forced,
    // rust: portal: Vec::new(),
                // Tiled maps hold the arena too.
    // rust: dragon: (case % 3 == 0).then(|| (next(spread), next(spread))),
    // rust: view_distance: 2 + next(12).abs(),
    // rust: simulation_distance: 2 + next(12).abs(),
}
    // rust: let Map::Grid { .. } = compute(&s) else {
    // rust: panic!("case {case} fell back to the map");
}
    // rust: let (grid, map) = (compute(&s), Map::Sparse(compute_sparse(&s)));
    // rust: let r = spread + 50;
    // rust: for z in -r..=r {
    // rust: for x in -r..=r {
    // rust: assert_eq!(grid.get(x, z), map.get(x, z), "case {case} at ({x}, {z})");
}
}
}
}

pub fn far_apart_tickets_tick_only_their_neighbourhoods() void {
}
    // rust: let l = levels(
    // rust: &[(0, 0), (100_000, -100_000)],
    // rust: &[(i32::MAX - 2, i32::MIN + 2)],
    // rust: 10,
    // rust: 10,
    // rust: );
    // rust: assert!(matches!(**l.0.as_ref().unwrap(), Map::Tiled(_)));
    // rust: assert!(l.entity_ticking(100_010, -100_010) && !l.block_ticking(50_000, 0));
    // rust: assert!(l.entity_ticking(i32::MAX - 2, i32::MIN + 2));
}

    /// `tick_blocks` filters its candidates with the bounds box before it asks
    /// `random_ticking`: whatever random ticks is inside it, every ticket's
    /// own area, a `PORTAL` ticket's with no player near it included.
pub fn random_tick_bounds_cover_every_random_ticking_chunk() void {
}
    // rust: let mut t = ChunkTickets::default();
        // A view distance shorter than the simulation one, two players far
        // apart, a forced chunk, `PORTAL` tickets that outlive them, and the
        // dragon fight's arena, which random ticks with nobody near it.
    // rust: let sources = || {
    // rust: Some(Sources {
    // rust: players: vec![(60, 40), (80, 80)],
    // rust: forced: vec![(-30, 17)],
    // rust: portal: Vec::new(),
    // rust: dragon: Some((0, 0)),
    // rust: view_distance: 4,
    // rust: simulation_distance: 12,
    // rust: })
}
    // rust: t.update(sources());
    // rust: for portal in [(0, 0), (25, -25), (300, 300), (-80, 95)] {
    // rust: t.add_portal(portal);
    // rust: t.update(sources());
    // rust: let levels = t.levels();
    // rust: let (min_x, min_z, max_x, max_z) = levels.random_tick_bounds().unwrap();
    // rust: for z in -100..=310 {
    // rust: for x in -100..=310 {
    // rust: if levels.random_ticking(x, z) {
    // rust: assert!(
    // rust: x >= min_x && x <= max_x && z >= min_z && z <= max_z,
    // rust: "({x}, {z}) random ticks outside the box"
    // rust: );
}
}
}
}
}

    /// cargo test --release -p horizon-client-lib --lib ticket_levels::tests::levels_cost -- --ignored --nocapture
pub fn levels_cost() void {
}
    // rust: for (players, spacing, distance) in [
    // rust: (1usize, 0, 10),
    // rust: (10, 0, 10),
    // rust: (25, 0, 10),
    // rust: (50, 0, 10),
    // rust: (100, 150, 10),
    // rust: (100, 150, 32),
    // rust: ] {
            // The benchmark's bots: most near spawn, a fifth flying outwards.
    // rust: let at: Vec<_> = (0..players)
    // rust: .map(|i| {
    // rust: if spacing != 0 {
    // rust: return ((i % 10) as i32 * spacing, (i / 10) as i32 * spacing);
}
    // rust: let a = i as f64 * 2.399;
    // rust: let d = if i % 5 == 0 { 30.0 } else { 3.0 };
    // rust: ((a.cos() * d) as i32, (a.sin() * d) as i32)
    // rust: })
    // rust: .collect();
    // rust: let s = Sources {
    // rust: players: at.clone(),
    // rust: forced: Vec::new(),
    // rust: portal: Vec::new(),
    // rust: dragon: None,
    // rust: view_distance: distance,
    // rust: simulation_distance: distance,
}
    // rust: let rounds = 20;
    // rust: let t = std::time::Instant::now();
    // rust: for _ in 0..rounds {
    // rust: std::hint::black_box(compute_sparse(std::hint::black_box(&s)));
}
    // rust: let map_build = t.elapsed().as_secs_f64() * 1e3 / rounds as f64;
    // rust: let t = std::time::Instant::now();
    // rust: for _ in 0..rounds {
    // rust: std::hint::black_box(compute(std::hint::black_box(&s)));
}
    // rust: let selected_build = t.elapsed().as_secs_f64() * 1e3 / rounds as f64;
    // rust: let mut tickets = ChunkTickets::default();
    // rust: tickets.update(Some(s.clone()));
    // rust: let mut moved = s.clone();
    // rust: let t = std::time::Instant::now();
    // rust: for _ in 0..rounds {
    // rust: moved.players[0].0 += 1;
    // rust: tickets.update(Some(moved.clone()));
    // rust: std::hint::black_box(tickets.levels());
}
    // rust: let moving = t.elapsed().as_secs_f64() * 1e3 / rounds as f64;
    // rust: println!("one player moving: {moving:.3} ms/update");
            // A tick's questions: every chunk within 12 of every player.
    // rust: let (map, selected) = (Map::Sparse(compute_sparse(&s)), compute(&s));
    // rust: let tiled = Map::Tiled(Tiled::new(&s));
    // rust: let t = std::time::Instant::now();
    // rust: for _ in 0..rounds {
    // rust: std::hint::black_box(Tiled::new(std::hint::black_box(&s)));
}
    // rust: let tiled_build = t.elapsed().as_secs_f64() * 1e3 / rounds as f64;
    // rust: let ask = |m: &Map| {
    // rust: let t = std::time::Instant::now();
    // rust: let mut n = 0u32;
    // rust: for _ in 0..rounds {
    // rust: for &(px, pz) in &at {
    // rust: for z in pz - 12..=pz + 12 {
    // rust: for x in px - 12..=px + 12 {
    // rust: n +=
    // rust: u32::from(std::hint::black_box(m.get(x, z)).0 <= BLOCK_TICKING);
}
}
}
}
    // rust: std::hint::black_box(n);
    // rust: t.elapsed().as_secs_f64() * 1e3 / rounds as f64
}
    // rust: println!(
    // rust: "{players} players: spacing={spacing} distance={distance}: scalar/selected/tiled build {map_build:.3}/{selected_build:.3}/{tiled_build:.3} ms, {} lookups {:.3}/{:.3}/{:.3} ms",
    // rust: players * 625,
    // rust: ask(&map),
    // rust: ask(&selected),
    // rust: ask(&tiled)
    // rust: );
}
}
}

    // rust: mod tiled_tests {
//     use super::*;
pub fn tiles_match_scalar_levels_with_overlaps_and_portals() void {
}
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = |n: i32| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed % (2 * n as u64 + 1)) as i32 - n
}
    // rust: for case in 0..60 {
    // rust: let s = Sources {
    // rust: players: (0..case % 13)
    // rust: .map(|_| (next(4000), next(4000)))
    // rust: .chain([(15, -16), (16, -15)])
    // rust: .collect(),
    // rust: forced: (0..case % 4).map(|_| (next(100), next(100))).collect(),
    // rust: portal: (0..case % 5)
    // rust: .map(|_| (next(100), next(100)))
    // rust: .chain([(16, -16)])
    // rust: .collect(),
    // rust: dragon: (case % 4 == 0).then(|| (next(100), next(100))),
    // rust: view_distance: [0, 2, 10, 32][case % 4],
    // rust: simulation_distance: [32, 10, 2, 0][(case / 4) % 4],
}
    // rust: let expected = compute_sparse(&s);
    // rust: let tiled = Tiled::new(&s);
    // rust: for (&(x, z), &want) in &expected {
    // rust: assert_eq!(tiled.get(x, z), want, "case {case}, {x}, {z}");
}
            // Query a fixed neighbourhood of every source, including holes
            // and negative coordinates, without depending on the tile layout.
    // rust: for &(cx, cz) in s.players.iter().chain(&s.forced).chain(&s.portal) {
    // rust: for dz in -48..=48 {
    // rust: for dx in -48..=48 {
    // rust: let key = (cx + dx, cz + dz);
    // rust: assert_eq!(
    // rust: tiled.get(key.0, key.1),
    // rust: expected.get(&key).copied().unwrap_or(NONE),
    // rust: "case {case}, {key:?}"
    // rust: );
}
}
}
    // rust: assert_eq!(tiled.get(50_000, -50_000), NONE);
}
}
}
