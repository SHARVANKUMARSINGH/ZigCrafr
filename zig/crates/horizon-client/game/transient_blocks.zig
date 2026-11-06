//! Transpiled from Horizon Rust crate
//! Module: horizon-client_transient_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `ClientboundAddTransientBlockPacket`: a block the server places that the
//! client shows for a moment, drawn as a moving block until the section mesh
//! that holds it has been rebuilt (a landed falling block would otherwise
//! leave a gap between the entity going and the mesh catching up).
// use super::Game;
// use horizon_client::mesher::Vertex;
// use horizon_world::registry::BlockStateId;
// use std::{
    // rust: collections::{HashMap, VecDeque},
    // rust: time::{Duration, Instant},
}

/// `TransientBlock.DEFAULT_TIME_TO_LIVE`, in seconds.
pub const DEFAULT_TIME_TO_LIVE: f64 = 1.0;

/// `TransientBlock`: a block queued by the packet.
pub const Queued = struct {
    pos: [i32,
    state: BlockStateId,
    time_to_live: f64,
};

/// `TransientBlockRenderState`: a block on show.
pub const Shown = struct {
    state: BlockStateId,
    live_until: Instant,
    /// `createTimeNs`, on the mesher's dispatch clock (`Streaming::sequence`):
    /// `SectionOcclusionGraph.schedulePropagationFrom` removes the block once a
    /// mesh of its section whose compile task started after this is uploaded.
    created: u64,
};

/// `LevelExtractor.transientBlockQueue` and `LevelRenderer.transientBlocks`.
    // rust: pub(super) struct TransientBlocks {
    // rust: queue: VecDeque<Queued>,
    /// By block position, so a second one at the same place replaces it.
    // rust: shown: HashMap<[i32; 3], Shown>,
}

    // rust: impl TransientBlocks {
    /// `LevelExtractor.queueTransientBlock`.
pub fn queue(self: *Self, pos: [i32; 3], state: BlockStateId) void {
}
    // rust: self.queue.push_back(Queued {
    // rust: pos,
    // rust: state,
    // rust: time_to_live: DEFAULT_TIME_TO_LIVE,
    // rust: });
}

    /// `LevelExtractor.drainTransientBlockQueue`: queued blocks go on show
    /// for their time to live from `now`.
pub fn drain(self: *Self, now: Instant, created: u64) void {
}
    // rust: while let Some(block) = self.queue.pop_front() {
    // rust: self.shown.insert(
    // rust: block.pos,
    // rust: Shown {
    // rust: state: block.state,
    // rust: live_until: now + Duration::from_secs_f64(block.time_to_live),
    // rust: created,
    // rust: },
    // rust: );
}
}

    // rust: pub(super) fn clear(&mut self) {
    // rust: self.queue.clear();
    // rust: self.shown.clear();
}
}

/// `performTransientBlockRemovals`: a section's uploaded mesh shows a block created at `created`
/// when its compile task started after it (`state.createTimeNs > compileTaskStartTimeNs` keeps it).
pub fn shows_block(created: u64, compile_start: ?u64, upload_pending: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !upload_pending && compile_start.is_some_and(|start| created < start)
}
    // rust: impl Game<'_> {
    /// `ClientPacketListener.handleAddTransientBlockPacket`.
    // rust: pub(super) fn add_transient_block(&mut self, pos: [i32; 3], state: i32) {
    // rust: self.transient_blocks.queue(pos, BlockStateId(state as u32));
}

    /// `LevelExtractor.drainTransientBlockQueue`, once a frame.
    // rust: pub(super) fn drain_transient_block_queue(&mut self) {
    // rust: self.transient_blocks
    // rust: .drain(Instant::now(), self.streaming.sequence());
}

    /// `LevelRenderer.submitTransientBlocks`: each block whose time has not
    /// run out, drawn as a moving block at its position, camera-relative.
    /// One whose section mesh has been rebuilt since it came is dropped
    /// (`performTransientBlockRemovals`).
    // rust: pub(super) fn transient_block_geometry(&mut self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: if self.transient_blocks.shown.is_empty() {
    // rust: return;
}
    // rust: let now = Instant::now();
    // rust: let mut shown = std::mem::take(&mut self.transient_blocks.shown);
    // rust: shown.retain(|pos, block| {
    // rust: if now >= block.live_until {
    // rust: return false;
}
            // performTransientBlockRemovals: the section's uploaded mesh began compiling
            // at or after the block was created, so it shows the block.
    // rust: !self.section_of(*pos).is_some_and(|section| {
    // rust: shows_block(
    // rust: block.created,
    // rust: self.streaming.compile_start(section),
    // rust: self.section_upload_pending(section),
    // rust: )
    // rust: })
    // rust: });
    // rust: for (pos, block) in &shown {
    // rust: let at = glam::DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: self.moving_block_vertices(
    // rust: block.state,
    // rust: horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: at - camera,
    // rust: out,
    // rust: );
}
    // rust: self.transient_blocks.shown = shown;
}
}

    // rust: mod tests {
//     use super::*;

pub fn a_block_is_dropped_once_a_mesh_compiled_after_it_is_uploaded() void {
}
        // No mesh yet, or one that began before the block existed: kept.
    // rust: assert!(!shows_block(5, None, false));
    // rust: assert!(!shows_block(5, Some(5), false));
    // rust: assert!(!shows_block(5, Some(3), false));
        // A later compile start shows it, once the mesh is uploaded.
    // rust: assert!(shows_block(5, Some(6), false));
    // rust: assert!(!shows_block(5, Some(6), true));
}

    /// `drainTransientBlockQueue`: a block goes on show for a second from the
    /// frame that drains it, and a second at the same place replaces it.
pub fn queued_blocks_go_on_show_for_a_second() void {
}
    // rust: let mut blocks = TransientBlocks::default();
    // rust: blocks.queue([1, 2, 3], BlockStateId(5));
    // rust: assert!(blocks.shown.is_empty());
    // rust: let now = Instant::now();
    // rust: blocks.drain(now, 7);
    // rust: assert!(blocks.queue.is_empty());
    // rust: assert_eq!(blocks.shown[&[1, 2, 3]].created, 7);
    // rust: assert_eq!(
    // rust: blocks.shown[&[1, 2, 3]].live_until,
    // rust: now + Duration::from_secs(1)
    // rust: );
    // rust: blocks.queue([1, 2, 3], BlockStateId(6));
    // rust: blocks.drain(now, 9);
    // rust: assert_eq!(blocks.shown.len(), 1);
    // rust: assert_eq!(blocks.shown[&[1, 2, 3]].state, BlockStateId(6));
}
}
