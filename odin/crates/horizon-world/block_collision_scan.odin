//! Transpiled from Horizon Rust crate
package horizon_world_block_collision_scan

import "core:fmt"
import "core:mem"
import "core:math"

// Lazy block collision selection in vanilla cursor/query order. Providers own
// chunk availability, state metadata, suffocation predicates and context dispatch.
// use crate::{collision_context::CollisionContext, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::{Aabb, ShapeError, ShapeOp, Vec3, VoxelShape},
    // rust: position::{BlockPos, ChunkPos},
}

CollisionBlock :: struct {
    state: BlockStateId,
    large_collision_shape: bool,
    moving_piston: bool,
    // The shape is empty under every context (air, plants): a scan skips
    // the block without asking for its shape. Providers whose shapes come
    // from elsewhere leave it false.
    empty_shape: bool,
}

    // rust: pub trait BlockCollisionWorld {
    // rust: type Error;
    // rust: type Chunk: Copy;
    // None is a missing collision chunk; native iteration retries missing chunks.
collision_chunk :: proc(self: ^Self, position: ChunkPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn collision_block(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: position: BlockPos,
    // rust: ) -> Result<CollisionBlock, Self::Error>;
    // rust: fn is_suffocating(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: block: CollisionBlock,
    // rust: position: BlockPos,
    // rust: ) -> Result<bool, Self::Error>;
    // Query against the global collision world, not the cached chunk provider.
    // Shapes must preserve canonical block identity (including imported shapes).
    // rust: fn context_shape(
    // rust: &mut self,
    // rust: block: CollisionBlock,
    // rust: position: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> Result<VoxelShape, Self::Error>;
    // Whether a block of the chunk's section `section_y` (block y >> 4) may
    // have a large collision shape or be a moving piston: the only blocks
    // the scan keeps outside the box's own cells. False lets the scan pass
    // that section's outer cells without reading them; true reads them all.
may_reach_out :: proc(self: ^Self, _chunk: Self::Chunk, _section_y: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(true)
}
    // Whether every block of the chunk's section `section_y` has an empty collision shape under
    // every context (all air): true lets the scan pass that section's cells without reading
    // them. False, the default, reads every cell.
    // rust: fn section_is_empty(
    // rust: &mut self,
    // rust: _chunk: Self::Chunk,
    // rust: _section_y: i32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: Ok(false)
}
    // Whether the chunks `collision_chunk` reports, missing or not, stay as they are for the
    // whole scan, and asking again has no effect: true lets the scan pass the rest of a row in
    // a missing chunk without asking, and go back to the chunk it just left without asking
    // again. False, the default, asks at every cell of a missing chunk and at every change of
    // chunk, as vanilla's `BlockCollisions` does.
missing_chunks_stay_missing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}

CollisionScanError :: enum {
    InvalidBounds,
    TooLarge,
    VisitBudget,
    World(E),
    Shape(ShapeError),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for CollisionScanError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::InvalidBounds => f.write_str("collision scan bounds must be finite"),
    // rust: Self::TooLarge => {
    // rust: f.write_str("collision scan exceeds the positive Java-int cursor domain")
}
    // rust: Self::VisitBudget => f.write_str("collision scan candidate budget exhausted"),
    // rust: Self::World(error) => error.fmt(f),
    // rust: Self::Shape(error) => error.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for CollisionScanError<E> {}

BlockCollisionHit :: struct {
    position: BlockPos,
    shape: VoxelShape,
}

CellError :: enum {
    InvalidBounds,
    TooLarge,
}

// The cursor a scan of `bounds` walks: its padded start, the box's extents in
// cells and the cell count. `new` and [`scan_cells`] share it, so a caller
// that sizes a budget from a box counts exactly what the scan will visit.
cells :: proc(bounds: Aabb) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let min = bounds.min_position();
    // rust: let max = bounds.max_position();
    // rust: if !min.is_finite() || !max.is_finite() {
    // rust: return Err(CellError::InvalidBounds);
}
    // rust: let start = BlockPos::containing(Vec3::new(min.x - 1.0e-7, min.y - 1.0e-7, min.z - 1.0e-7))
    // rust: .offset(-1, -1, -1);
    // rust: let end = BlockPos::containing(Vec3::new(max.x + 1.0e-7, max.y + 1.0e-7, max.z + 1.0e-7))
    // rust: .offset(1, 1, 1);
    // rust: let sizes = [
    // rust: end.x.wrapping_sub(start.x).wrapping_add(1),
    // rust: end.y.wrapping_sub(start.y).wrapping_add(1),
    // rust: end.z.wrapping_sub(start.z).wrapping_add(1),
    // rust: ];
    // rust: if sizes.iter().any(|size| *size <= 0) {
    // rust: return Err(CellError::TooLarge);
}
    // rust: let count = sizes
    // rust: .into_iter()
    // rust: .try_fold(1u64, |n, size| {
    // rust: n.checked_mul(size as u64).filter(|n| *n <= i32::MAX as u64)
    // rust: })
    // rust: .ok_or(CellError::TooLarge)? as usize;
    // rust: Ok((start, sizes, count))
}

// The cells a scan of `bounds` visits, or `None` for a box `new` refuses
// (`InvalidBounds`, `TooLarge`): the most a budget can usefully be.
scan_cells :: proc(bounds: Aabb) -> O {
    // Ported from Horizon
    return {}
}
    // rust: cells(bounds).ok().map(|(_, _, count)| count)
}

// Sections whose facts a scan remembers: 2 x 2 columns by two
// sections holds every section of a box up to 16 blocks on each side.
REACH_SECTIONS :: 8

// What a scan asked the world about one section, once.
SectionFacts :: struct {
    at: ChunkPos,
    section_y: i32,
    // `section_is_empty`.
    empty: bool,
    // `may_reach_out`; not asked (false) for an empty section, whose cells are all passed.
    reaches: bool,
}

BlockCollisionScan :: struct {
    world: ^'w mut W,
    context: CollisionContext<'c>,
    bounds: Aabb,
    // `Shapes.create(box)`, built the first time a block's shape is not
    // the unit cube (finite bounds always make one).
    entity_shape: Maybe(VoxelShape),
    only_suffocating: bool,
    start: BlockPos,
    sizes: [uint,
    index: uint,
    // The cell at `index`, relative to `start` (x fastest, then y, then z).
    cursor: [uint,
    count: uint,
    budget: uint,
    // The last cell's chunk and its section's facts: the cells of a row in one chunk share
    // them, so most cells need one comparison.
    here: Option<(W::Chunk,
    // The `here` before, with `missing_stays`: a row across a chunk border goes back and forth
    // between the two.
    there: Option<(W::Chunk,
    // The facts of the last sections cells were in, replaced in turn. A box
    // across a chunk border goes back and forth between two columns on every
    // row, so one remembered section is asked again at each crossing.
    sections: [Maybe(SectionFacts),
    sections_next: uint,
    // `missing_chunks_stay_missing`, asked once.
    missing_stays: bool,
    failed: bool,
}
    // rust: impl<'w, 'c, W: BlockCollisionWorld> BlockCollisionScan<'w, 'c, W> {
    // Finite bounds and a positive-Java-int candidate volume are supported.
    // Budget counts every cursor cell, including skipped corners. After an error
    // iteration terminates; already performed queries are not rolled back.
    // rust: pub fn new(
    // rust: world: &'w mut W,
    // rust: context: CollisionContext<'c>,
    // rust: bounds: Aabb,
    // rust: only_suffocating: bool,
    // rust: candidate_budget: usize,
    // rust: ) -> Result<Self, CollisionScanError<W::Error>> {
    // rust: let (start, sizes, count) = cells(bounds).map_err(|error| match error {
    // rust: CellError::InvalidBounds => CollisionScanError::InvalidBounds,
    // rust: CellError::TooLarge => CollisionScanError::TooLarge,
    // rust: })?;
    // rust: let missing_stays = world.missing_chunks_stay_missing();
    // rust: Ok(Self {
    // rust: world,
    // rust: context,
    // rust: bounds,
    // rust: entity_shape: None,
    // rust: only_suffocating,
    // rust: start,
    // rust: sizes: sizes.map(|s| s as usize),
    // rust: index: 0,
    // rust: cursor: [0; 3],
    // rust: count,
    // rust: budget: candidate_budget,
    // rust: here: None,
    // rust: there: None,
    // rust: sections: [None; REACH_SECTIONS],
    // rust: sections_next: 0,
    // rust: missing_stays,
    // rust: failed: false,
    // rust: })
}

    // The cells after the current one (cell `x` of its row, block x `block_x`) that are in the
    // same row and chunk, never more than the budget has left: what can be passed at once.
rest_in_chunk :: proc(self: ^Self, x: uint, block_x: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.sizes[0] - 1 - x)
    // rust: .min(15 - (block_x & 15) as usize)
    // rust: .min(self.budget.saturating_sub(self.index))
}

    // The chunk and section facts of a cell in another chunk or section than the last one's;
    // None in a missing chunk.
    // rust: fn enter(
    // rust: &mut self,
    // rust: at: ChunkPos,
    // rust: section_y: i32,
    // rust: ) -> Result<Option<(W::Chunk, SectionFacts)>, CollisionScanError<W::Error>> {
    // rust: if self.missing_stays
    // rust: && let Some((chunk, facts)) = self.there
    // rust: && facts.at == at
    // rust: && facts.section_y == section_y
    // rust: {
    // rust: std::mem::swap(&mut self.here, &mut self.there);
    // rust: return Ok(Some((chunk, facts)));
}
    // rust: let chunk = match self.here {
    // rust: Some((chunk, facts)) if facts.at == at => chunk,
    // rust: _ => match self
    // rust: .world
    // rust: .collision_chunk(at)
    // rust: .map_err(CollisionScanError::World)?
    // rust: {
    // rust: Some(chunk) => chunk,
    // rust: None => {
                    // Vanilla forgets its chunk after a missing one and asks for it again. With
                    // `missing_stays` asking has no effect: `here` stays, as no cell of the
                    // missing chunk matches it.
    // rust: if !self.missing_stays {
    // rust: self.here = None;
}
    // rust: return Ok(None);
}
    // rust: },
}
    // rust: let facts = self.section_facts(at, chunk, section_y)?;
    // rust: self.there = self.here;
    // rust: self.here = Some((chunk, facts));
    // rust: Ok(Some((chunk, facts)))
}

    // The facts of the section a cell is in, asked once per section the scan enters.
    // rust: fn section_facts(
    // rust: &mut self,
    // rust: at: ChunkPos,
    // rust: chunk: W::Chunk,
    // rust: section_y: i32,
    // rust: ) -> Result<SectionFacts, CollisionScanError<W::Error>> {
    // rust: if let Some(&facts) = self
    // rust: .sections
    // rust: .iter()
    // rust: .flatten()
    // rust: .find(|facts| facts.at == at && facts.section_y == section_y)
    // rust: {
    // rust: return Ok(facts);
}
    // rust: let empty = self
    // rust: .world
    // rust: .section_is_empty(chunk, section_y)
    // rust: .map_err(CollisionScanError::World)?;
    // rust: let reaches = !empty
    // rust: && self
    // rust: .world
    // rust: .may_reach_out(chunk, section_y)
    // rust: .map_err(CollisionScanError::World)?;
    // rust: let facts = SectionFacts {
    // rust: at,
    // rust: section_y,
    // rust: empty,
    // rust: reaches,
}
    // rust: self.sections[self.sections_next] = Some(facts);
    // rust: self.sections_next = (self.sections_next + 1) % REACH_SECTIONS;
    // rust: Ok(facts)
}

    // Move the cursor `n` cells further along its row; `n` must not pass
    // the row's end.
skip :: proc(self: ^Self, n: uint) {
}
    // rust: if n == 0 {
    // rust: return;
}
    // rust: let [width, height, _] = self.sizes;
    // rust: self.index += n;
    // rust: self.cursor[0] += n;
    // rust: if self.cursor[0] == width {
    // rust: self.cursor[0] = 0;
    // rust: self.cursor[1] += 1;
    // rust: if self.cursor[1] == height {
    // rust: self.cursor[1] = 0;
    // rust: self.cursor[2] += 1;
}
}
}

find_next :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: while self.index < self.count {
    // rust: if self.index >= self.budget {
    // rust: return Err(CollisionScanError::VisitBudget);
}
    // rust: let [width, height, depth] = self.sizes;
    // rust: let relative = self.cursor;
    // rust: self.index += 1;
    // rust: self.cursor[0] += 1;
    // rust: if self.cursor[0] == width {
    // rust: self.cursor[0] = 0;
    // rust: self.cursor[1] += 1;
    // rust: if self.cursor[1] == height {
    // rust: self.cursor[1] = 0;
    // rust: self.cursor[2] += 1;
}
}
    // rust: let kind = relative
    // rust: .into_iter()
    // rust: .zip(self.sizes)
    // rust: .filter(|(p, size)| *p == 0 || *p == size - 1)
    // rust: .count();
    // rust: if kind == 3 {
    // rust: continue;
}
    // rust: let p = self
    // rust: .start
    // rust: .offset(relative[0] as i32, relative[1] as i32, relative[2] as i32);
    // rust: let chunk_position = p.chunk();
    // rust: let section_y = p.y >> 4;
    // rust: let (chunk, facts) = match self.here {
    // rust: Some((chunk, facts))
    // rust: if facts.at == chunk_position && facts.section_y == section_y =>
    // rust: {
    // rust: (chunk, facts)
}
    // rust: _ => match self.enter(chunk_position, section_y)? {
    // rust: Some(here) => here,
    // rust: None => {
                        // A chunk that stays missing has nothing in the rest of the row's cells
                        // in it: they are passed at once, as a section without blocks is below.
    // rust: if self.missing_stays {
    // rust: let rest = self.rest_in_chunk(relative[0], p.x);
    // rust: self.skip(rest);
}
    // rust: continue;
}
    // rust: },
}
            // A section whose blocks have no collision shape gives nothing for any cell in it,
            // inner or outer: the rest of the row in it is passed at once (never beyond the
            // budget, which still ends the scan where it would have). A far move's sweep is
            // mostly sky and chunks not loaded.
    // rust: if facts.empty {
    // rust: let rest = self.rest_in_chunk(relative[0], p.x);
    // rust: self.skip(rest);
    // rust: continue;
}
            // An outer cell only counts for a block reaching out of its own
            // cell: most sections hold none, so their outer cells go unread
            // (the result is the same, with a fifth of the block reads for a
            // mob's box).
    // rust: if kind != 0 && !facts.reaches {
                // On a row along the box's bottom, top or sides every
                // cell is outer: the rest of it in this chunk is passed
                // at once (never beyond the budget, which still ends the
                // scan where it would have).
    // rust: if relative[1] == 0
    // rust: || relative[1] == height - 1
    // rust: || relative[2] == 0
    // rust: || relative[2] == depth - 1
    // rust: {
    // rust: let rest = self.rest_in_chunk(relative[0], p.x);
    // rust: self.skip(rest);
}
    // rust: continue;
}
    // rust: let block = self
    // rust: .world
    // rust: .collision_block(chunk, p)
    // rust: .map_err(CollisionScanError::World)?;
    // rust: if self.only_suffocating
    // rust: && !self
    // rust: .world
    // rust: .is_suffocating(chunk, block, p)
    // rust: .map_err(CollisionScanError::World)?
    // rust: {
    // rust: continue;
}
    // rust: if kind == 1 && !block.large_collision_shape || kind == 2 && !block.moving_piston {
    // rust: continue;
}
    // rust: if block.empty_shape {
    // rust: continue;
}
    // rust: let shape = self
    // rust: .world
    // rust: .context_shape(block, p, &self.context)
    // rust: .map_err(CollisionScanError::World)?;
    // rust: let offset = Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z));
    // rust: let moved = if shape.is_block() {
                // Native adds one in floating point, including at i32::MAX.
    // rust: let top = Vec3::new(offset.x + 1.0, offset.y + 1.0, offset.z + 1.0);
    // rust: if !self.bounds.intersects_corners(offset, top) {
    // rust: continue;
}
    // rust: shape.moved(offset)
    // rust: } else {
                // Shapes whose bounds miss the box share no volume with it:
                // joinIsNotEmpty(AND) is false without moving them.
    // rust: if !shape
    // rust: .bounds()
    // rust: .is_some_and(|b| b.move_by(offset).intersects(self.bounds))
    // rust: {
    // rust: continue;
}
    // rust: let moved = shape.moved(offset);
    // rust: let entity_shape = match &self.entity_shape {
    // rust: Some(shape) => shape,
    // rust: None => self.entity_shape.insert(
    // rust: VoxelShape::from_box(self.bounds).map_err(CollisionScanError::Shape)?,
    // rust: ),
}
    // rust: if moved.is_empty()
    // rust: || !moved
    // rust: .join_is_not_empty(entity_shape, ShapeOp::AND)
    // rust: .map_err(CollisionScanError::Shape)?
    // rust: {
    // rust: continue;
}
    // rust: moved
}
    // rust: return Ok(Some(BlockCollisionHit {
    // rust: position: p,
    // rust: shape: moved,
    // rust: }));
}
    // rust: Ok(None)
}
}
    // rust: impl<W: BlockCollisionWorld> Iterator for BlockCollisionScan<'_, '_, W> {
    // rust: type Item = Result<BlockCollisionHit, CollisionScanError<W::Error>>;
next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.failed {
    // rust: return None;
}
    // rust: match self.find_next() {
    // rust: Ok(hit) => hit.map(Ok),
    // rust: Err(error) => {
    // rust: self.failed = true;
    // rust: Some(Err(error))
}
}
}
}
    // rust: impl<W: BlockCollisionWorld> std::iter::FusedIterator for BlockCollisionScan<'_, '_, W> {}
