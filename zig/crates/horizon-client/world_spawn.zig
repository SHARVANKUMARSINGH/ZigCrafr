//! Transpiled from Horizon Rust crate
//! Module: horizon-client_world_spawn
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Where a new world's spawn is and where a player first appears around it:
//! MinecraftServer.setInitialSpawn's chunk spiral and PlayerSpawnFinder.
// use horizon_world::heightmap::HeightmapType;

/// The block queries the spawn searches make on full (decorated, lit) chunks.
    // rust: pub trait SpawnLevel {
pub fn min_y(self: *Self) i;
    /// `chunk.getHeight(kind, x, z)`: one above the column's highest block
    /// matching the heightmap, or the minimum height.
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) i;
    /// `!getBlockState(pos).getFluidState().isEmpty()`.
pub fn has_fluid(self: *Self, x: i32, y: i32, z: i32) b;
    /// `Block.isFaceFull(state.getCollisionShape(level, pos), Direction.UP)`.
pub fn top_face_full(self: *Self, x: i32, y: i32, z: i32) b;
    /// `DimensionType.hasCeiling()`: the search starts at the generator's
    /// spawn height instead of each column's motion-blocking height.
pub fn has_ceiling(self: *Self) b;
    /// `ChunkGenerator.getSpawnHeight(level)`.
pub fn spawn_height(self: *Self) i;
}

/// PlayerSpawnFinder.getLevelRespawnPos: the block above the column's top
/// full-topped collision, unless water, lava or only non-colliding blocks
/// are on top. A level with a ceiling (`caveWorld`) searches from the
/// generator's spawn height, under the roof, not from the heightmap that
/// sees the roof.
pub fn level_respawn_pos(level: *impl SpawnLevel, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let top = if level.has_ceiling() {
    // rust: level.spawn_height()
    // rust: } else {
    // rust: level.height(HeightmapType::MotionBlocking, x, z)
}
    // rust: if top < level.min_y() {
    // rust: return None;
}
    // rust: let surface = level.height(HeightmapType::WorldSurface, x, z);
    // rust: if surface <= top && surface > level.height(HeightmapType::OceanFloor, x, z) {
    // rust: return None;
}
    // rust: for y in (level.min_y()..=top + 1).rev() {
    // rust: if level.has_fluid(x, y, z) {
    // rust: break;
}
    // rust: if level.top_face_full(x, y, z) {
    // rust: return Some([x, y + 1, z]);
}
}
    // rust: None
}

/// PlayerSpawnFinder.getSpawnPosInChunk: the first valid column, x-major.
pub fn spawn_pos_in_chunk(level: *impl SpawnLevel, cx: i32, cz: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for x in cx * 16..cx * 16 + 16 {
    // rust: for z in cz * 16..cz * 16 + 16 {
    // rust: if let Some(pos) = level_respawn_pos(level, x, z) {
    // rust: return Some(pos);
}
}
}
    // rust: None
}

/// setInitialSpawn's walk: Mth.square(11) steps of a square spiral around
/// the origin chunk, testing the steps within 5 chunks of it.
pub const ChunkSpiral = struct {
    step: i32,
    x: i32,
    z: i32,
    dx: i32,
    dz: i32,
};
    // rust: impl Default for ChunkSpiral {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new()
}
}
    // rust: impl ChunkSpiral {
    // rust: pub const fn new() -> Self {
    // rust: Self {
    // rust: step: 0,
    // rust: x: 0,
    // rust: z: 0,
    // rust: dx: 0,
    // rust: dz: -1,
}
}
    /// Steps taken so far.
pub fn steps(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.step
}
    /// The chunk offset to test now, or None once the walk is over.
pub fn current(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.step < 11 * 11).then_some((self.x, self.z))
}
    /// Whether `current` lies within the tested 11 by 11 chunks.
pub fn tested(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (-5..=5).contains(&self.x) && (-5..=5).contains(&self.z)
}
pub fn advance(self: *Self) void {
}
    // rust: if self.x == self.z
    // rust: || (self.x < 0 && self.x == -self.z)
    // rust: || (self.x > 0 && self.x == 1 - self.z)
    // rust: {
    // rust: (self.dx, self.dz) = (-self.dz, self.dx);
}
    // rust: self.x += self.dx;
    // rust: self.z += self.dz;
    // rust: self.step += 1;
}
}

/// What PlayerSpawnFinder tries next.
pub const SpawnCandidate = enum {
    /// A column to test with `level_respawn_pos` and a free player box.
    Column(i32, i32),
    /// Every column failed: the suggestion itself, height fixed up.
    Suggestion,
};

/// PlayerSpawnFinder: the columns of the square of `radius` around the
/// suggestion in a random coprime-stride order, then the suggestion.
pub const PlayerSpawnFinder = struct {
    suggestion: [i32,
    radius: i32,
    count: i32,
    coprime: i32,
    offset: i32,
    next: i32,
};
    // rust: impl PlayerSpawnFinder {
    /// `radius` is the respawn radius already clamped to the world border
    /// (findSpawn); `random(n)` draws the start offset in `0..n`.
pub fn new(suggestion: [i32; 3], radius: i32, random: impl FnOnce(i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let side = i64::from(radius) * 2 + 1;
    // rust: let count = (side * side).min(1024) as i32;
    // rust: Self {
    // rust: suggestion,
    // rust: radius,
    // rust: count,
    // rust: coprime: if count <= 16 { count - 1 } else { 17 },
    // rust: offset: random(count),
    // rust: next: 0,
}
}
    /// The next candidate, None once the suggestion was handed out.
pub fn next_candidate(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = self.next;
    // rust: if index > self.count {
    // rust: return None;
}
    // rust: self.next += 1;
    // rust: if index == self.count {
    // rust: return Some(SpawnCandidate::Suggestion);
}
    // rust: let value = (self.offset + self.coprime * index) % self.count;
    // rust: let side = self.radius * 2 + 1;
    // rust: Some(SpawnCandidate::Column(
    // rust: self.suggestion[0] + value % side - self.radius,
    // rust: self.suggestion[2] + value / side - self.radius,
    // rust: ))
}
    /// Hand the last candidate out again (its chunk was not loaded yet).
pub fn retry(self: *Self) void {
}
    // rust: self.next -= 1;
}
}

    // rust: mod tests {
//     use super::*;

pub fn spiral_walks_out_from_the_origin_like_set_initial_spawn() void {
}
    // rust: let mut spiral = ChunkSpiral::default();
    // rust: let mut seen = Vec::new();
    // rust: while let Some(at) = spiral.current() {
    // rust: if spiral.tested() {
    // rust: seen.push(at);
}
    // rust: spiral.advance();
}
    // rust: assert_eq!(
    // rust: &seen[..9],
    // rust: &[
    // rust: (0, 0),
    // rust: (1, 0),
    // rust: (1, 1),
    // rust: (0, 1),
    // rust: (-1, 1),
    // rust: (-1, 0),
    // rust: (-1, -1),
    // rust: (0, -1),
    // rust: (1, -1)
    // rust: ]
    // rust: );
    // rust: seen.sort_unstable();
    // rust: seen.dedup();
    // rust: assert_eq!(seen.len(), 121);
}

pub fn finder_visits_every_column_once_then_the_suggestion() void {
}
    // rust: let mut finder = PlayerSpawnFinder::new([100, 70, -40], 10, |n| n / 3);
    // rust: let mut columns = Vec::new();
    // rust: while let Some(c) = finder.next_candidate() {
    // rust: columns.push(c);
}
    // rust: assert_eq!(columns.len(), 442);
    // rust: assert_eq!(columns.last(), Some(&SpawnCandidate::Suggestion));
    // rust: columns.sort_by_key(|c| format!("{c:?}"));
    // rust: columns.dedup();
    // rust: assert_eq!(columns.len(), 442);
    // rust: let mut zero = PlayerSpawnFinder::new([5, 64, 5], 0, |_| 0);
    // rust: assert_eq!(zero.next_candidate(), Some(SpawnCandidate::Column(5, 5)));
    // rust: assert_eq!(zero.next_candidate(), Some(SpawnCandidate::Suggestion));
    // rust: assert_eq!(zero.next_candidate(), None);
}

pub const Flat = struct {
    top: i32,
    water: bool,
};
    // rust: impl SpawnLevel for Flat {
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: -64
}
pub fn height(self: *Self, kind: HeightmapType, _: i32, _: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: HeightmapType::OceanFloor if self.water => self.top - 3,
    // rust: _ => self.top + 1,
}
}
pub fn has_fluid(self: *Self, _: i32, y: i32, _: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.water && y <= self.top && y > self.top - 3
}
pub fn top_face_full(self: *Self, _: i32, y: i32, _: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: y <= self.top
}
pub fn has_ceiling(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn spawn_height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 64
}
}

    /// A level with a roof: the heightmap sees the roof, the search should not.
pub const Cave = struct {
    floor: i32,
    roof: i32,
    spawn_height: i32,
    ceiling: bool,
};
    // rust: impl SpawnLevel for Cave {
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: -64
}
pub fn height(self: *Self, _: HeightmapType, _: i32, _: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.roof + 1
}
pub fn has_fluid(self: *Self, _: i32, _: i32, _: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn top_face_full(self: *Self, _: i32, y: i32, _: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: y == self.roof || y <= self.floor
}
pub fn has_ceiling(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ceiling
}
pub fn spawn_height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.spawn_height
}
}

pub fn respawn_column_stands_on_land_not_water() void {
}
    // rust: assert_eq!(
    // rust: level_respawn_pos(
    // rust: &Flat {
    // rust: top: 70,
    // rust: water: false
    // rust: },
    // rust: 3,
    // rust: 4
    // rust: ),
    // rust: Some([3, 71, 4])
    // rust: );
    // rust: assert_eq!(
    // rust: level_respawn_pos(
    // rust: &Flat {
    // rust: top: 62,
    // rust: water: true
    // rust: },
    // rust: 3,
    // rust: 4
    // rust: ),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: spawn_pos_in_chunk(
    // rust: &Flat {
    // rust: top: 70,
    // rust: water: false
    // rust: },
    // rust: -2,
    // rust: 1
    // rust: ),
    // rust: Some([-32, 71, 16])
    // rust: );
}

pub fn a_ceiling_starts_the_respawn_search_at_the_generator_spawn_height() void {
}
    // rust: let cave = Cave {
    // rust: floor: 50,
    // rust: roof: 120,
    // rust: spawn_height: 60,
    // rust: ceiling: true,
}
        // From under the roof the floor is 51; from the heightmap it would be
        // the roof itself, 121.
    // rust: assert_eq!(level_respawn_pos(&cave, 1, 2), Some([1, 51, 2]));
    // rust: let open = Cave {
    // rust: ceiling: false,
    // rust: ..cave
}
    // rust: assert_eq!(level_respawn_pos(&open, 1, 2), Some([1, 121, 2]));
}
}
