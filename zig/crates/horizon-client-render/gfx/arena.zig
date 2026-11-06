//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_arena
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! One vertex buffer for every terrain section: sections own ranges of it, so
//! a frame binds it once and draws every section with indirect multi-draw.
//! Translucent quads can have an arena of their own (`Arena::translucent`),
//! with pages up to `LARGE_PAGE_BYTES`, and their sorted indices too
//! (`Arena::translucent_indices`): their back-to-front list then stays in one
//! page of each and draws in a few multi-draws.
// use std::collections::{BTreeMap, VecDeque};

/// Ranges are rounded up to this many vertices to limit fragmentation, and
/// start at multiples of it (`flat` names sections by these blocks).
pub const GRAIN: u64 = 256;
/// The largest page of the section arena, and of arenas shaders bind whole
/// as storage, in bytes.
pub const PAGE_BYTES: u64 = 256 << 20;
/// The largest page of an arena no shader binds as storage: under 2 GiB, where
/// DirectX 12 and OpenGL cap buffers (`i32::MAX`), with room for the bytes
/// wgpu-core adds to vertex buffers; the device's own limit still applies.
pub const LARGE_PAGE_BYTES: u64 = (1 << 31) - (1 << 20);

/// Free vertex ranges: start -> length, never adjacent.
pub const FreeList = struct {};

    // rust: impl FreeList {
pub fn new(capacity: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(BTreeMap::from([(0, capacity)]))
}
    /// First fit.
pub fn take(self: *Self, len: u64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (&start, &free) = self.0.iter().find(|(_, l)| **l >= len)?;
    // rust: self.0.remove(&start);
    // rust: if free > len {
    // rust: self.0.insert(start + len, free - len);
}
    // rust: Some(start)
}
pub fn give(self: *Self, start: u64, len: u64) void {
}
    // rust: let (mut start, mut len) = (start, len);
    // rust: if let Some((&prev, &prev_len)) = self.0.range(..start).next_back()
    // rust: && prev + prev_len == start
    // rust: {
    // rust: self.0.remove(&prev);
    // rust: start = prev;
    // rust: len += prev_len;
}
    // rust: if let Some(next_len) = self.0.remove(&(start + len)) {
    // rust: len += next_len;
}
    // rust: self.0.insert(start, len);
}
    /// `give` for many ranges: one merge of the sorted ranges into the list,
    /// where giving them one by one costs a few tree lookups each.
pub fn give_all(self: *Self, mut ranges: Vec<(u64) void {
}
    // rust: if ranges.len() < 64 {
    // rust: for (start, len) in ranges {
    // rust: self.give(start, len);
}
    // rust: return;
}
    // rust: ranges.sort_unstable();
    // rust: let mut free = std::mem::take(&mut self.0).into_iter().peekable();
    // rust: let mut given = ranges.into_iter().peekable();
    // rust: let mut merged: Vec<(u64, u64)> = Vec::new();
    // rust: loop {
    // rust: let next = match (free.peek(), given.peek()) {
    // rust: (Some(a), Some(b)) if a.0 <= b.0 => free.next(),
    // rust: (_, Some(_)) => given.next(),
    // rust: (Some(_), None) => free.next(),
    // rust: (None, None) => break,
}
    // rust: let (start, len) = next.expect("peeked");
    // rust: match merged.last_mut() {
    // rust: Some(last) if last.0 + last.1 == start => last.1 += len,
    // rust: _ => merged.push((start, len)),
}
}
        // Sorted: the tree is built in one pass.
    // rust: self.0 = merged.into_iter().collect();
}
}

/// One vertex buffer of the arena; only the newest page grows.
pub const Page = struct {
    buffer: wgpu::Buffer,
    /// Capacity in vertices.
    capacity: u64,
    free: FreeList,
    /// The buffer went to system memory (`Arena::create`'s fallback): meshes
    /// are never moved into it, and it is the first to empty.
    host: bool,
};

    // rust: impl Page {
    /// Vertices in the page's free ranges.
pub fn free_vertices(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.free.0.values().sum()
}
}

/// An arena with this many bytes in free ranges, at least half of its pages,
/// has a page worth emptying (`Arena::sparsest`).
pub const COMPACT_MIN_FREE: u64 = 128 << 20;
/// A page of at least this many bytes shrinks (`Arena::oversized`) when a page
/// of its ranges in use halves it or is `PAGE_BYTES` smaller.
pub const SHRINK_MIN_BYTES: u64 = 64 << 20;

/// Terrain vertices in pages of at most `page_limit` vertices (devices cap
/// buffer sizes): a section's vertices sit in one page.
pub const Arena = struct {
    pages: std.ArrayList(?Page),
    stride: u64,
    page_limit: u64,
    initial_capacity: u64,
    usage: wgpu::BufferUsages,
    /// A page being emptied (`Arena::close`): nothing is placed in it.
    closing: ?u32,
    /// A page had to go to system memory (logged once).
    spilled: bool,
    /// Tests: GPU-local pages fail as if video memory were full.
    video_memory_full: bool,
};

    // rust: impl Arena {
    /// Vertices; `storage` also lets shaders read them as a storage buffer (a shader pack's
    /// terrain program reads the other corners of a vertex's quad for its normal).
pub fn new(device: *wgpu::Device, stride: u64, capacity: u64, storage: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let usage = if storage {
    // rust: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::STORAGE
    // rust: } else {
    // rust: wgpu::BufferUsages::VERTEX
}
    // rust: Self::with_usage(device, stride, capacity, usage, PAGE_BYTES)
}
    /// Sorted translucent indices; `storage` when compute passes read them.
pub fn indices(device: *wgpu::Device, capacity: u64, storage: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let usage = if storage {
    // rust: wgpu::BufferUsages::INDEX | wgpu::BufferUsages::STORAGE
    // rust: } else {
    // rust: wgpu::BufferUsages::INDEX
}
    // rust: Self::with_usage(device, 4, capacity, usage, PAGE_BYTES)
}
    /// Translucent quads' vertices, which no shader reads as storage: pages
    /// up to `LARGE_PAGE_BYTES`. A page this large has no others to empty into
    /// (`sparsest`): once the view has settled, one far larger than its ranges
    /// in use moves into a new page of their size (`oversized`, `open_page`;
    /// `Renderer::shrink_translucent`).
pub fn translucent(device: *wgpu::Device, stride: u64, capacity: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let usage = wgpu::BufferUsages::VERTEX;
    // rust: Self::with_usage(device, stride, capacity, usage, LARGE_PAGE_BYTES)
}
    /// Sorted indices of the translucent arena's quads: pages up to
    /// `LARGE_PAGE_BYTES` as its own, so its draws keep to one index page too.
pub fn translucent_indices(device: *wgpu::Device, capacity: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let usage = wgpu::BufferUsages::INDEX;
    // rust: Self::with_usage(device, 4, capacity, usage, LARGE_PAGE_BYTES)
}
    /// The sorted-index arena and, when `split`, the translucent arena
    /// (vertices of `stride`) with large pages, which no shader binds;
    /// otherwise translucent quads stay in the section arena. The indices go in
    /// large pages too, unless flat draws (`flat`) bind their pages as storage.
    // rust: pub fn translucent_arenas(
    // rust: device: &wgpu::Device,
    // rust: stride: u64,
    // rust: flat: bool,
    // rust: split: bool,
    // rust: ) -> (Self, Option<Self>) {
    // rust: let indices = if split && !flat {
    // rust: Self::translucent_indices(device, 1 << 16)
    // rust: } else {
    // rust: Self::indices(device, 1 << 16, flat)
}
    // rust: (
    // rust: indices,
    // rust: split.then(|| Self::translucent(device, stride, 1 << 18)),
    // rust: )
}
    // rust: fn with_usage(
    // rust: device: &wgpu::Device,
    // rust: stride: u64,
    // rust: capacity: u64,
    // rust: usage: wgpu::BufferUsages,
    // rust: page_bytes: u64,
    // rust: ) -> Self {
        // Pages of `page_bytes`, or less where the device's buffers (or the
        // storage bindings that read them whole) are smaller.
    // rust: let limits = device.limits();
    // rust: let mut bytes = limits.max_buffer_size.min(page_bytes);
    // rust: if usage.contains(wgpu::BufferUsages::STORAGE) {
    // rust: bytes = bytes.min(limits.max_storage_buffer_binding_size);
}
    // rust: let page_limit = (bytes / stride) / GRAIN * GRAIN;
    // rust: let capacity = capacity.next_multiple_of(GRAIN).min(page_limit);
    // rust: Self {
    // rust: pages: Vec::new(),
    // rust: stride,
    // rust: page_limit,
    // rust: initial_capacity: capacity,
    // rust: usage,
    // rust: closing: None,
    // rust: spilled: false,
    // rust: video_memory_full: false,
}
}
    /// A buffer of `capacity` vertices in video memory or, when that is full,
    /// `spill` allows it and so does the device, in system memory: Vulkan
    /// drivers fail an allocation rather than page like OpenGL ones, and
    /// wgpu's default error handler panics. `None` when neither has room.
    // rust: fn create(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: capacity: u64,
    // rust: spill: bool,
    // rust: ) -> Option<(wgpu::Buffer, bool)> {
    // rust: let usage = self.usage | wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::COPY_SRC;
    // rust: let (label, bytes) = ("Section buffer arena", capacity * self.stride);
    // rust: let local = (!self.video_memory_full)
    // rust: .then(|| try_create(device, label, bytes, usage))
    // rust: .flatten();
    // rust: let local = try_create(device, label, bytes, usage);
    // rust: let local = local.map(|buffer| (buffer, false));
    // rust: local.or_else(|| {
            // Mappable buffers are placed in host-visible memory, which the
            // allocator takes from system memory once video memory is full.
    // rust: if !spill
    // rust: || !device
    // rust: .features()
    // rust: .contains(wgpu::Features::MAPPABLE_PRIMARY_BUFFERS)
    // rust: {
    // rust: return None;
}
    // rust: let buffer = try_create(device, label, bytes, usage | wgpu::BufferUsages::MAP_WRITE)?;
    // rust: if !std::mem::replace(&mut self.spilled, true) {
    // rust: log::warn!(
    // rust: "Horizon: video memory is full; more terrain is kept in system memory \
    // rust: (lower the render distance if frames slow down)"
    // rust: );
}
    // rust: Some((buffer, true))
    // rust: })
}
    /// The rounded length a request of `vertices` occupies.
pub fn span(vertices: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vertices.max(1).next_multiple_of(GRAIN)
}
    /// Bytes of every page's buffer.
pub fn bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pages.iter().flatten().map(|p| p.capacity).sum::<u64>() * self.stride
}
    /// The most vertices a page holds.
pub fn page_vertices(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.page_limit
}
    /// `page`'s buffer up to the end of its last range in use, as draws bind it:
    /// wgpu clears what a binding covers and nothing wrote yet when the frame is
    /// submitted, most of a page just made or grown.
pub fn binding(self: *Self, page: u32) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.pages[page as usize].as_ref().expect("live arena page");
    // rust: let end = match p.free.0.last_key_value() {
    // rust: Some((&start, &len)) if start + len == p.capacity => start,
    // rust: _ => p.capacity,
}
        // A page a draw names holds a range; wgpu refuses an empty slice.
    // rust: p.buffer.slice(..end.max(GRAIN) * self.stride)
}
pub fn has_page(self: *Self, page: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pages.get(page as usize).is_some_and(Option::is_some)
}
    /// Each live page's buffer, by page.
pub fn page_buffers(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pages = self.pages.iter().enumerate();
    // rust: pages.filter_map(|(i, p)| Some((i as u32, &p.as_ref()?.buffer)))
}
pub fn buffer(self: *Self, page: u32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.pages[page as usize]
    // rust: .as_ref()
    // rust: .expect("live arena page")
    // rust: .buffer
}
    /// Bytes of one vertex (or index).
pub fn stride(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stride
}
    /// Vertices in `page`'s ranges in use (as `span` rounds them).
pub fn used(self: *Self, page: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let page = self.pages[page as usize].as_ref().expect("live arena page");
    // rust: page.capacity - page.free_vertices()
}
    /// A range of `vertices`: (page, first vertex). Grows the newest page
    /// (copying its contents on the GPU, in `encoder`) or starts a new one
    /// when nothing free is large enough; `None` when no memory is left for
    /// it. Writes to the arena belong in `encoder` too, so that those
    /// recorded before a grow reach the grown page.
    // rust: pub fn alloc(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: vertices: u64,
    // rust: ) -> Option<(u32, u64)> {
    // rust: let len = Self::span(vertices).min(self.page_limit);
    // rust: if let Some(found) = self.alloc_existing(len) {
    // rust: return Some(found);
}
    // rust: let last = self.pages.len().saturating_sub(1);
    // rust: if let Some(page) = self.pages.last().and_then(Option::as_ref)
    // rust: && page.capacity < self.page_limit
    // rust: && self.closing != Some(last as u32)
    // rust: {
    // rust: let current = page.capacity;
    // rust: let grown = self.grown(current, len);
    // rust: if (grown - current >= len || grown == self.page_limit)
    // rust: && self.grow(device, encoder, last, grown)
    // rust: && let Some(start) = self.pages[last].as_mut().unwrap().free.take(len)
    // rust: {
    // rust: return Some((last as u32, start));
}
}
    // rust: let capacity = if self.pages.is_empty() {
    // rust: self.initial_capacity
    // rust: } else {
    // rust: 1 << 20
}
    // rust: .max(len)
    // rust: .min(self.page_limit);
        // A page just large enough when memory is short.
    // rust: let ((buffer, host), capacity) = match self.create(device, capacity, true) {
    // rust: Some(buffer) => (buffer, capacity),
    // rust: None if capacity > len => (self.create(device, len, true)?, len),
    // rust: None => return None,
}
    // rust: let mut free = FreeList::new(capacity);
    // rust: let start = free.take(len).expect("a new page fits one section");
    // rust: let page = Page {
    // rust: buffer,
    // rust: capacity,
    // rust: free,
    // rust: host,
}
    // rust: let index = self
    // rust: .pages
    // rust: .iter()
    // rust: .position(Option::is_none)
    // rust: .unwrap_or_else(|| {
    // rust: self.pages.push(None);
    // rust: self.pages.len() - 1
    // rust: });
    // rust: self.pages[index] = Some(page);
    // rust: Some((index as u32, start))
}
    /// A range of `vertices` in a page that exists already and is not being
    /// emptied: never grows the arena.
pub fn alloc_existing(self: *Self, vertices: u64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = Self::span(vertices).min(self.page_limit);
    // rust: let closing = self.closing;
    // rust: self.pages
    // rust: .iter_mut()
    // rust: .enumerate()
    // rust: .filter(|(i, _)| closing != Some(*i as u32))
    // rust: .find_map(|(i, page)| Some((i as u32, page.as_mut()?.free.take(len)?)))
}
    /// `alloc_existing` for a mesh moved off the closing page: only pages in
    /// video memory, so compaction never pushes terrain into system memory.
pub fn alloc_moved(self: *Self, vertices: u64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = Self::span(vertices).min(self.page_limit);
    // rust: let closing = self.closing;
    // rust: self.pages
    // rust: .iter_mut()
    // rust: .enumerate()
    // rust: .filter(|(i, p)| closing != Some(*i as u32) && p.as_ref().is_some_and(|p| !p.host))
    // rust: .find_map(|(i, page)| Some((i as u32, page.as_mut()?.free.take(len)?)))
}
    /// The page to empty when much of the arena is free ranges (video memory
    /// that fragmentation keeps: a page goes back only once all of it is free):
    /// the one with the fewest vertices in use that the other pages' free
    /// ranges can take. `None` when the arena is dense enough or already
    /// emptying a page.
pub fn sparsest(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sparsest_from(COMPACT_MIN_FREE)
}
    /// `sparsest` for an arena with at least `min_free` bytes in free ranges.
pub fn sparsest_from(self: *Self, min_free: u64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.closing.is_some() {
    // rust: return None;
}
    // rust: let pages = || {
    // rust: self.pages
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, p)| Some((i, p.as_ref()?)))
}
    // rust: let free: u64 = pages().map(|(_, p)| p.free_vertices()).sum();
    // rust: let capacity: u64 = pages().map(|(_, p)| p.capacity).sum();
    // rust: if free * self.stride < min_free || free * 2 < capacity {
    // rust: return None;
}
        // Moves only go to video-memory pages (`alloc_moved`).
    // rust: let local_free: u64 = pages()
    // rust: .filter(|(_, p)| !p.host)
    // rust: .map(|(_, p)| p.free_vertices())
    // rust: .sum();
    // rust: pages()
    // rust: .filter_map(|(i, p)| {
    // rust: let used = p.capacity - p.free_vertices();
    // rust: let own = if p.host { 0 } else { p.free_vertices() };
                // The room elsewhere, less a quarter for first fit's gaps.
    // rust: let elsewhere = (local_free - own) / 4 * 3;
                // A page in system memory is emptied first.
    // rust: (used > 0 && used <= elsewhere).then_some((!p.host, used, i as u32))
    // rust: })
    // rust: .min()
    // rust: .map(|(_, _, i)| i)
}
    /// A page far larger than its ranges in use, and the capacity a page of them
    /// gets (`grown`: twice theirs, or `PAGE_BYTES` more; at least the first
    /// page's): one of `SHRINK_MIN_BYTES` or more, with ranges in use (an empty
    /// one is `trim`'s), that this halves or makes `PAGE_BYTES` smaller. In
    /// system memory too (`open_page` makes the new one in video memory). None
    /// while a page is closing; the page it leads to is not oversized until its
    /// ranges change.
pub fn oversized(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.closing.is_some() {
    // rust: return None;
}
    // rust: let saving = PAGE_BYTES / self.stride;
    // rust: self.pages.iter().enumerate().find_map(|(i, p)| {
    // rust: let p = p.as_ref()?;
    // rust: let used = p.capacity - p.free_vertices();
    // rust: let capacity = self
    // rust: .grown(used, 0)
    // rust: .max(self.initial_capacity)
    // rust: .next_multiple_of(GRAIN)
    // rust: .min(self.page_limit);
    // rust: let smaller = 2 * capacity <= p.capacity || capacity + saving <= p.capacity;
    // rust: (p.capacity * self.stride >= SHRINK_MIN_BYTES && used > 0 && smaller)
    // rust: .then_some((i as u32, capacity))
    // rust: })
}
    /// A new, empty page of `capacity` vertices in video memory, made the newest
    /// (the one that grows), for what `Renderer::shrink_translucent` moves off an
    /// `oversized` page (`alloc_moved`) and for new ranges meanwhile. False, and
    /// nothing changes, when video memory has no room for it: in system memory it
    /// would slow every frame that draws it.
pub fn open_page(self: *Self, device: *wgpu::Device, capacity: u64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((buffer, host)) = self.create(device, capacity, false) else {
    // rust: return false;
}
    // rust: let free = FreeList::new(capacity);
    // rust: self.pages.push(Some(Page {
    // rust: buffer,
    // rust: capacity,
    // rust: free,
    // rust: host,
    // rust: }));
    // rust: true
}
    /// Stops placing vertices in `page` until `reopen`.
pub fn close(self: *Self, page: u32) void {
}
    // rust: self.closing = Some(page);
}
pub fn reopen(self: *Self) void {
}
    // rust: self.closing = None;
}
pub fn closing(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.closing
}
    /// Records the copy of `vertices` from one range to another of other pages.
    // rust: pub fn copy(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: from: (u32, u64),
    // rust: to: (u32, u64),
    // rust: vertices: u64,
    // rust: ) {
    // rust: debug_assert_ne!(from.0, to.0);
    // rust: encoder.copy_buffer_to_buffer(
    // rust: self.buffer(from.0),
    // rust: from.1 * self.stride,
    // rust: self.buffer(to.0),
    // rust: to.1 * self.stride,
    // rust: vertices * self.stride,
    // rust: );
}
pub fn release(self: *Self, page: u32, start: u64, vertices: u64) void {
}
    // rust: let len = Self::span(vertices).min(self.page_limit);
    // rust: self.pages[page as usize]
    // rust: .as_mut()
    // rust: .expect("live arena page")
    // rust: .free
    // rust: .give(start, len);
}
    /// `release` for many ranges (page, start, vertices) at once.
pub fn release_all(self: *Self, ranges: impl IntoIterator<Item = (u32) void {
}
    // rust: let mut by_page: Vec<Vec<(u64, u64)>> = Vec::new();
    // rust: for (page, start, vertices) in ranges {
    // rust: let page = page as usize;
    // rust: if by_page.len() <= page {
    // rust: by_page.resize_with(page + 1, Vec::new);
}
    // rust: by_page[page].push((start, Self::span(vertices).min(self.page_limit)));
}
    // rust: for (page, ranges) in by_page.into_iter().enumerate() {
    // rust: if ranges.is_empty() {
    // rust: continue;
}
    // rust: let page = self.pages[page].as_mut().expect("live arena page");
            // Every range of the page given back (a far teleport empties the arena): one
            // free range, without sorting tens of thousands into the list.
    // rust: let given: u64 = ranges.iter().map(|r| r.1).sum();
    // rust: if page.free_vertices() + given == page.capacity {
    // rust: page.free = FreeList::new(page.capacity);
    // rust: } else {
    // rust: page.free.give_all(ranges);
}
}
}
    /// The capacity the newest page grows to for a range of `len`: double, but
    /// by at most `PAGE_BYTES` past that size, so a large page is never left
    /// half empty (nor held twice during the copy) by hundreds of MiB.
pub fn grown(self: *Self, current: u64, len: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let step = current.min(PAGE_BYTES / self.stride);
    // rust: (current + step).max(current + len).min(self.page_limit)
}
    /// Moves a page into a larger buffer; false (the page unchanged) when
    /// there is no memory for it. A page past `PAGE_BYTES` grows in video
    /// memory only: moving all of it to system memory would slow every frame
    /// that draws it, so a new page takes the range instead (and may spill).
    // rust: fn grow(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: page: usize,
    // rust: capacity: u64,
    // rust: ) -> bool {
    // rust: let capacity = capacity.next_multiple_of(GRAIN).min(self.page_limit);
    // rust: let spill = capacity * self.stride <= PAGE_BYTES;
    // rust: let Some((buffer, host)) = self.create(device, capacity, spill) else {
    // rust: return false;
}
    // rust: let old = self.pages[page].as_mut().expect("live arena page");
        // Copies recorded for the old buffer run before this one.
    // rust: encoder.copy_buffer_to_buffer(&old.buffer, 0, &buffer, 0, old.capacity * self.stride);
    // rust: let previous = old.capacity;
    // rust: old.buffer = buffer;
    // rust: old.host = host;
    // rust: old.capacity = capacity;
    // rust: old.free.give(previous, capacity - previous);
    // rust: true
}
    /// Reclaim after an upload batch, so replacing a section can reuse its range. Gives back
    /// the buffers of the pages it emptied, for a [`Graveyard`].
pub fn trim(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut released = Vec::new();
    // rust: for page in &mut self.pages {
    // rust: if page
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.free.0.len() == 1 && p.free.0.get(&0) == Some(&p.capacity))
    // rust: && let Some(p) = page.take()
    // rust: {
    // rust: released.push(p.buffer);
}
}
    // rust: if self.closing.is_some_and(|page| !self.has_page(page)) {
    // rust: self.closing = None;
}
        // Keep live page indices stable; later allocations reuse interior holes.
    // rust: while self.pages.last().is_some_and(Option::is_none) {
    // rust: self.pages.pop();
}
    // rust: released
}
    /// Drops every page; gives back their buffers, for a [`Graveyard`].
pub fn clear(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.closing = None;
    // rust: self.pages.drain(..).flatten().map(|p| p.buffer).collect()
}
}

/// Frames a released page waits before it is freed: by then the GPU is done with the frames that
/// used it, and the bind groups naming it (flat draws' page tables) are gone, so the freeing
/// thread holds its last reference.
pub const GRAVE_FRAMES: usize = 4;

/// Buffers of released pages, freed [`GRAVE_FRAMES`] frames later on a thread of their own
/// ([`free_later`]): giving a page of up to 256 MB back to the driver on the render thread took
/// that frame 8-14 ms of CPU (Mesa's lavapipe), when flight or a teleport emptied a page.
pub const Graveyard = struct {
    graves: VecDeque<std.ArrayList(T)>,
};

    // rust: impl<T> Default for Graveyard<T> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: graves: VecDeque::new(),
}
}
}

    // rust: impl<T> Graveyard<T> {
    /// Released this frame.
pub fn add(self: *Self, items: impl IntoIterator<Item = T>) void {
}
    // rust: if self.graves.is_empty() {
    // rust: self.graves.push_back(Vec::new());
}
    // rust: if let Some(grave) = self.graves.back_mut() {
    // rust: grave.extend(items);
}
}
    /// A frame went by: what was released `GRAVE_FRAMES` frames ago, to free.
pub fn advance(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.graves.push_back(Vec::new());
    // rust: if self.graves.len() > GRAVE_FRAMES {
    // rust: self.graves.pop_front().unwrap_or_default()
    // rust: } else {
    // rust: Vec::new()
}
}
}

/// Drops `items` on a short-lived thread of its own, as `chunk::free_columns` does for
/// unloaded chunks; should the thread not start, they drop here.
    // rust: pub fn free_later<T: Send + 'static>(items: Vec<T>) {
    // rust: if items.is_empty() {
    // rust: return;
}
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("Buffer freeing".into())
    // rust: .spawn(move || drop(items));
}

/// `create_buffer` with an out-of-memory failure returned instead of raised
/// (raised errors are fatal).
    // rust: pub(super) fn try_create(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: u64,
    // rust: usage: wgpu::BufferUsages,
    // rust: ) -> Option<wgpu::Buffer> {
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::OutOfMemory);
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage,
    // rust: mapped_at_creation: false,
    // rust: });
    // Native error scopes resolve at once.
    // rust: pollster::block_on(scope.pop()).is_none().then_some(buffer)
}

    // rust: mod tests {
//     use super::*;

    /// A released page is handed back for freeing `GRAVE_FRAMES` frames later, in order.
pub fn graveyard_frees_after_its_frames() void {
}
    // rust: let mut graves = Graveyard::default();
    // rust: graves.add([1, 2]);
    // rust: let mut freed = Vec::new();
    // rust: for frame in 0..GRAVE_FRAMES + 2 {
    // rust: if frame == 1 {
    // rust: graves.add([3]);
}
    // rust: freed.push(graves.advance());
}
    // rust: let mut expected = vec![Vec::new(); GRAVE_FRAMES + 2];
    // rust: expected[GRAVE_FRAMES - 1] = vec![1, 2];
    // rust: expected[GRAVE_FRAMES] = vec![3];
    // rust: assert_eq!(freed, expected);
}

pub fn device() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device_with(wgpu::Features::empty())
}

    /// A device with those of `features` the adapter has.
pub fn device_with(features: wgpu::Features) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: eprintln!("arena GPU regression: {}", adapter.get_info().name);
    // rust: let required_features = adapter.features() & features;
    // rust: pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_features,
    // rust: ..Default::default()
    // rust: }))
    // rust: .ok()
}

    /// A device with the adapter's own limits, as the renderer opens it: page
    /// caps past the default 256 MiB buffer limit show there.
pub fn device_at_limits() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
    // rust: }))
    // rust: .ok()
}

    /// `device` and `device_at_limits`: the default limits bind 128 MiB of a storage
    /// buffer, half their 256 MiB buffers, so storage pages shrink to the binding there;
    /// the adapter's own let large pages past 256 MiB.
pub fn devices() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let devices = [device(), device_at_limits()];
    // rust: devices.into_iter().flatten().collect()
}

    /// `Arena::alloc`, with the copies of a grow submitted at once.
    // rust: fn alloc(
    // rust: arena: &mut Arena,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: vertices: u64,
    // rust: ) -> Option<(u32, u64)> {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let range = arena.alloc(device, &mut encoder, vertices);
    // rust: queue.submit([encoder.finish()]);
    // rust: range
}

pub fn writes_recorded_before_a_grow_reach_the_grown_page() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::indices(&device, GRAIN, false);
    // rust: let mut uploads = super::super::upload::Uploads::new(&device);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let (page, start) = arena.alloc(&device, &mut encoder, GRAIN).unwrap();
    // rust: uploads.buffer(
    // rust: &mut encoder,
    // rust: arena.buffer(page),
    // rust: start * 4,
    // rust: &7u32.to_le_bytes(),
    // rust: );
        // The page is full: the next range grows it, in the same encoder.
    // rust: let (grown, next) = arena.alloc(&device, &mut encoder, GRAIN).unwrap();
    // rust: assert_eq!(grown, page);
    // rust: uploads.buffer(
    // rust: &mut encoder,
    // rust: arena.buffer(grown),
    // rust: next * 4,
    // rust: &9u32.to_le_bytes(),
    // rust: );
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: assert_eq!(read(&device, &queue, arena.buffer(page), start * 4), 7);
    // rust: assert_eq!(read(&device, &queue, arena.buffer(page), next * 4), 9);
}

    /// Released together, every range of a page leaves it one free range (a far teleport
    /// empties the arena at once), while a page keeping some ranges frees only the others.
pub fn ranges_released_at_once_free_exactly_their_vertices() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::new(&device, 4, GRAIN, false);
    // rust: arena.page_limit = 4 * GRAIN;
    // rust: let ranges: Vec<(u32, u64)> = (0..8)
    // rust: .map(|_| alloc(&mut arena, &device, &queue, GRAIN).unwrap())
    // rust: .collect();
    // rust: let (first, second) = (ranges[0].0, ranges[7].0);
    // rust: assert_ne!(first, second);
        // All four of the first page, the middle two of the second.
    // rust: let released: Vec<(u32, u64, u64)> = ranges
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|&(i, _)| i < 4 || i == 5 || i == 6)
    // rust: .map(|(_, &(page, start))| (page, start, GRAIN))
    // rust: .collect();
    // rust: arena.release_all(released);
    // rust: let free = |page: u32| -> Vec<(u64, u64)> {
    // rust: let free = &arena.pages[page as usize].as_ref().unwrap().free.0;
    // rust: free.iter().map(|(&start, &len)| (start, len)).collect()
}
    // rust: assert_eq!(free(first), vec![(0, 4 * GRAIN)]);
    // rust: assert_eq!(free(second), vec![(ranges[5].1, 2 * GRAIN)]);
        // The emptied page takes a whole page's range again, without growing.
    // rust: let pages = arena.pages.iter().flatten().count();
    // rust: assert_eq!(arena.alloc_existing(4 * GRAIN), Some((first, 0)));
    // rust: assert_eq!(arena.pages.iter().flatten().count(), pages);
}

pub fn a_sparse_page_empties_into_the_others_and_is_reclaimed() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::new(&device, 4, GRAIN, false);
    // rust: arena.page_limit = 4 * GRAIN;
        // Eight ranges fill two pages, each holding its own number.
    // rust: let ranges: Vec<(u32, u64)> = (0..8)
    // rust: .map(|i| {
    // rust: let range = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: queue.write_buffer(
    // rust: arena.buffer(range.0),
    // rust: range.1 * 4,
    // rust: &(100 + i as u32).to_le_bytes(),
    // rust: );
    // rust: range
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(arena.pages.iter().flatten().count(), 2);
    // rust: let (first, second) = (ranges[0].0, ranges[7].0);
    // rust: assert_ne!(first, second);
        // Fragmented: one range live in the first page, two in the second.
    // rust: for (i, &(page, start)) in ranges.iter().enumerate() {
    // rust: if ![0, 6, 7].contains(&i) {
    // rust: arena.release(page, start, GRAIN);
}
}
        // Dense enough arenas, and ones without room elsewhere, are left alone.
    // rust: assert_eq!(arena.sparsest_from(u64::MAX), None);
    // rust: assert_eq!(arena.sparsest_from(0), Some(first));
    // rust: arena.close(first);
    // rust: assert_eq!(
    // rust: arena.sparsest_from(0),
    // rust: None,
    // rust: "one page is emptied at a time"
    // rust: );
        // New ranges avoid the closing page though it has room.
    // rust: let (page, extra) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: assert_eq!(page, second);
    // rust: arena.release(page, extra, GRAIN);
        // Its live range moves, data included, and the page goes back.
    // rust: let (page, start) = ranges[0];
    // rust: let to = arena.alloc_existing(GRAIN).unwrap();
    // rust: assert_eq!(to.0, second);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: arena.copy(&mut encoder, (page, start), to, GRAIN);
    // rust: queue.submit([encoder.finish()]);
    // rust: arena.release(page, start, GRAIN);
    // rust: assert_eq!(read(&device, &queue, arena.buffer(to.0), to.1 * 4), 100);
        // Emptied but not trimmed yet: it stays closed, so uploads can't refill it.
    // rust: assert_eq!(arena.closing(), Some(page));
    // rust: let refill = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: assert_ne!(refill.0, page);
    // rust: arena.release(refill.0, refill.1, GRAIN);
    // rust: let before = arena.bytes();
    // rust: arena.trim();
    // rust: assert_eq!(arena.bytes(), before - 4 * GRAIN * 4);
    // rust: assert_eq!(arena.closing(), None);
        // The others kept their ranges.
    // rust: for i in [6, 7] {
    // rust: let (page, start) = ranges[i];
    // rust: assert_eq!(
    // rust: read(&device, &queue, arena.buffer(page), start * 4),
    // rust: 100 + i as u32
    // rust: );
}
}

    /// The renderer's half of that compaction (`move_off_page`) moves what each
    /// section holds in the section arena, data and all. Split, that is its
    /// solid quads alone, and nothing of a section without any, whose (0, 0)
    /// names no range of page 0; else solid and translucent quads together,
    /// `translucent_at` along. GPU culling's records of the sections with solid
    /// quads move with them.
pub fn compaction_moves_what_sections_hold_in_the_section_arena() void {
}
//         use super::super::{Part, SectionGpu, gpu_culling, move_off_page};
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let stride = std::mem::size_of::<crate::mesher::TerrainVertex>() as u64;
    // rust: let section = |(page, start), translucent_at, solid, translucent| SectionGpu {
    // rust: page,
    // rust: start,
    // rust: translucent_at,
    // rust: solid,
    // rust: solid_slots: u64::from(solid) * 4,
    // rust: packed: false,
    // rust: sides: crate::mesher::Sides::unsorted(solid),
    // rust: translucent,
    // rust: sort: super::super::translucency::SortState::new(Vec::new()),
    // rust: sorted_indices: None,
    // rust: flat_id: None,
    // rust: gpu_id: None,
    // rust: gpu_fading: false,
    // rust: fading: None,
    // rust: leaving: None,
    // rust: animated_layers: Box::new([]),
}
    // rust: for split in [true, false] {
    // rust: let mut arena = Arena::new(&device, stride, 4 * GRAIN, false);
    // rust: arena.page_limit = 4 * GRAIN;
            // Page 0: two sections' grains and two free ones; page 1: one taken.
    // rust: let (_, a) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: let (_, b) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: let (_, rest) = alloc(&mut arena, &device, &queue, 2 * GRAIN).unwrap();
    // rust: assert_eq!(alloc(&mut arena, &device, &queue, GRAIN), Some((1, 0)));
    // rust: arena.release(0, rest, 2 * GRAIN);
            // Split, a grain of solid quads each (the first's translucent ones, and
            // all of a water section's, in the translucent arena); else a grain of
            // solid and translucent quads, and one of translucent quads alone.
    // rust: let mut sections = if split {
    // rust: vec![
    // rust: section((0, a), (0, 0), 64, 64),
    // rust: section((0, 0), (0, GRAIN), 0, 64),
    // rust: section((0, b), (0, 0), 64, 0),
    // rust: ]
    // rust: } else {
    // rust: vec![
    // rust: section((0, a), (0, a + 128), 32, 32),
    // rust: section((0, b), (0, b), 0, 64),
    // rust: ]
}
            // A range's first and last vertex hold its section's number, and the
            // first translucent one of a mixed range that plus 100.
    // rust: let write = |(page, at): (u32, u64), value: usize| {
    // rust: let bytes = (value as u32).to_le_bytes();
    // rust: queue.write_buffer(arena.buffer(page), at * stride, &bytes);
}
    // rust: for (i, s) in sections.iter().enumerate() {
    // rust: if let Some((page, start, len)) = s.vertex_ranges(split).0 {
    // rust: write((page, start), i);
    // rust: write((page, start + len - 1), i);
    // rust: if !split && s.solid > 0 && s.translucent > 0 {
    // rust: write(s.translucent_at, 100 + i);
}
}
}
    // rust: let before: Vec<_> = sections
    // rust: .iter()
    // rust: .map(|s| (s.page, s.start, s.translucent_at))
    // rust: .collect();
            // The sections with solid quads have records, on page 0, each with
            // its cell's box.
    // rust: let mut records = gpu_culling::Records::default();
    // rust: for (i, s) in sections.iter_mut().enumerate() {
    // rust: if s.solid > 0 {
    // rust: s.gpu_id = Some(records.insert(s.record((i as i32, 0, 0), None)));
}
}
    // rust: let recorded = records.live() as u32;
    // rust: assert_eq!(records.page_sections(), [recorded], "split {split}");
    // rust: arena.close(0);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let meshes = sections.iter_mut();
    // rust: let mut budget = u64::MAX;
    // rust: assert!(move_off_page(
    // rust: &mut arena,
    // rust: &mut encoder,
    // rust: None,
    // rust: Some(&mut records),
    // rust: meshes,
    // rust: 0,
    // rust: Part::Section { split },
    // rust: &mut budget
    // rust: ));
    // rust: queue.submit([encoder.finish()]);
    // rust: let word =
    // rust: |(page, at): (u32, u64)| read(&device, &queue, arena.buffer(page), at * stride);
    // rust: for (i, s) in sections.iter().enumerate() {
                // Its record names its solid quads where they are now, its box kept.
    // rust: let record = (s.solid > 0).then(|| s.record((i as i32, 0, 0), None));
    // rust: let held = s.gpu_id.and_then(|id| records.at(id));
    // rust: assert_eq!(held, record.as_ref(), "split {split}, section {i}");
    // rust: let Some((page, start, len)) = s.vertex_ranges(split).0 else {
    // rust: assert_eq!(
    // rust: (s.page, s.start, s.translucent_at),
    // rust: before[i],
    // rust: "split {split}"
    // rust: );
    // rust: continue;
}
    // rust: assert_eq!(page, 1, "split {split}");
    // rust: assert_eq!(word((page, start)), i as u32);
    // rust: assert_eq!(word((page, start + len - 1)), i as u32);
    // rust: if !split {
    // rust: assert_eq!(s.translucent_at, (page, start + u64::from(s.solid) * 4));
    // rust: if s.solid > 0 {
    // rust: assert_eq!(word(s.translucent_at), 100 + i as u32);
}
}
}
            // Page 0's count went to page 1 with them.
    // rust: assert_eq!(records.page_sections(), [0, recorded], "split {split}");
            // Page 0 empties without a range given twice, and page 1 took a grain
            // per section moved: one is left.
    // rust: arena.trim();
    // rust: assert!(!arena.has_page(0), "split {split}");
    // rust: assert!(arena.alloc_existing(GRAIN).is_some(), "split {split}");
    // rust: assert_eq!(arena.alloc_existing(GRAIN), None, "split {split}");
}
}

    /// Flat draws find a section's origin by the id its blocks name, in the section arena's
    /// tables and, split, in the translucent arena's (`flat::TRANSLUCENT_KEYS`). Translucent
    /// quads a shrink moves (`move_off_page`) keep naming their section, or flat draws would
    /// put them at another section's origin.
pub fn moved_translucent_quads_keep_their_section_s_flat_id() void {
}
//         use super::super::{Part, SectionGpu, flat, move_off_page, upload::Uploads};
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: "@vertex fn vs() -> @builtin(position) vec4<f32> { return vec4<f32>(0.0); }
    // rust: @fragment fn fs() -> @location(0) vec4<f32> { return vec4<f32>(0.0); }"
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let terrain_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: None,
    // rust: entries: &[],
    // rust: });
    // rust: let pipeline = |layout: &wgpu::PipelineLayout, label: &str, _: &str, _: &str, _, _, _| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("vs"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("fs"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::TextureFormat::Rgba8Unorm.into())],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let mut flat = flat::Flat::new(&device, &terrain_layout, 4 * GRAIN, 0, pipeline);
    // rust: let stride = std::mem::size_of::<crate::mesher::TerrainVertex>() as u64;
    // rust: let mut translucent = Arena::translucent(&device, stride, 4 * GRAIN);
    // rust: translucent.page_limit = 4 * GRAIN;
    // rust: flat.set_translucent_page_vertices(translucent.page_vertices());
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
        // Page 0: another section's grain, then this one's two; page 1: a grain taken.
    // rust: let (_, other) = alloc(&mut translucent, &device, &queue, GRAIN).unwrap();
    // rust: let (_, at) = alloc(&mut translucent, &device, &queue, 2 * GRAIN).unwrap();
    // rust: let (_, rest) = alloc(&mut translucent, &device, &queue, GRAIN).unwrap();
    // rust: assert_eq!(
    // rust: alloc(&mut translucent, &device, &queue, GRAIN),
    // rust: Some((1, 0))
    // rust: );
    // rust: translucent.release(0, rest, GRAIN);
    // rust: let key = |page: u32| page + flat::TRANSLUCENT_KEYS;
    // rust: let other_id = flat.add(&device, &mut encoder, &mut uploads, key(0), other, GRAIN);
        // Its solid quads in the section arena's page 0, its translucent ones here.
    // rust: let id = flat.add(&device, &mut encoder, &mut uploads, 0, 0, GRAIN);
    // rust: flat.place(
    // rust: &device,
    // rust: &mut encoder,
    // rust: &mut uploads,
    // rust: id,
    // rust: key(0),
    // rust: at,
    // rust: 2 * GRAIN,
    // rust: );
    // rust: let mut section = SectionGpu {
    // rust: page: 0,
    // rust: start: 0,
    // rust: translucent_at: (0, at),
    // rust: solid: 64,
    // rust: solid_slots: 64 * 4,
    // rust: packed: false,
    // rust: sides: crate::mesher::Sides::unsorted(64),
    // rust: translucent: 128,
    // rust: sort: super::super::translucency::SortState::new(Vec::new()),
    // rust: sorted_indices: None,
    // rust: flat_id: Some(id),
    // rust: gpu_id: None,
    // rust: gpu_fading: false,
    // rust: fading: None,
    // rust: leaving: None,
    // rust: animated_layers: Box::new([]),
}
    // rust: translucent.close(0);
    // rust: let mut budget = u64::MAX;
    // rust: assert!(move_off_page(
    // rust: &mut translucent,
    // rust: &mut encoder,
    // rust: Some((&mut flat, &device, &mut uploads)),
    // rust: None,
    // rust: std::iter::once(&mut section),
    // rust: 0,
    // rust: Part::Translucent,
    // rust: &mut budget
    // rust: ));
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: let (page, start) = section.translucent_at;
    // rust: assert_eq!(page, 1);
    // rust: assert_eq!(section.flat_id, Some(id));
    // rust: let named =
    // rust: |page: u32, grain: u64| read(&device, &queue, flat.blocks(key(page)), grain * 4);
    // rust: for grain in start / GRAIN..(start / GRAIN + 2) {
    // rust: assert_eq!(named(1, grain), id, "grain {grain} of its new range");
}
        // The section arena's table and the other section's grain are untouched.
    // rust: assert_eq!(read(&device, &queue, flat.blocks(0), 0), id);
    // rust: assert_eq!(named(0, other / GRAIN), other_id);
}

    /// Draws bind a large page up to the end of its last range in use, a grain at
    /// least: wgpu clears what a binding covers and nothing wrote when the frame is
    /// submitted, so a grown page bound whole had its new tail cleared on the GPU.
pub fn large_pages_are_bound_up_to_their_last_range_in_use() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::translucent(&device, 24, GRAIN);
    // rust: let ranges: Vec<_> = (0..3)
    // rust: .map(|_| alloc(&mut arena, &device, &queue, GRAIN).unwrap())
    // rust: .collect();
        // The third grain grew the page to four.
    // rust: assert_eq!(arena.buffer(0).size(), 4 * GRAIN * 24);
    // rust: assert_eq!(arena.binding(0).size(), 3 * GRAIN * 24);
        // A free range before the last in use stays bound, none after it; an empty
        // page binds a grain (wgpu refuses an empty slice).
    // rust: arena.release(0, ranges[1].1, GRAIN);
    // rust: assert_eq!(arena.binding(0).size(), 3 * GRAIN * 24);
    // rust: arena.release(0, ranges[2].1, GRAIN);
    // rust: assert_eq!(arena.binding(0).size(), GRAIN * 24);
    // rust: arena.release(0, ranges[0].1, GRAIN);
    // rust: assert_eq!(arena.binding(0).size(), GRAIN * 24);
}

pub fn empty_pages_are_reclaimed_without_moving_live_ranges() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::new(&device, 4, GRAIN, false);
    // rust: arena.page_limit = 2 * GRAIN;
    // rust: assert_eq!(arena.bytes(), 0);
    // rust: let (first, a) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: let (_, b) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: let (live, c) = alloc(&mut arena, &device, &queue, 2 * GRAIN).unwrap();
    // rust: let buffer = arena.buffer(live).clone();
    // rust: let data = [1u8, 2, 3, 4];
    // rust: queue.write_buffer(&buffer, c * 4, &data);
    // rust: assert_eq!(arena.bytes(), 4 * GRAIN * 4);
    // rust: arena.release(first, a, GRAIN);
    // rust: arena.trim();
    // rust: assert_eq!(arena.bytes(), 4 * GRAIN * 4);
    // rust: arena.release(first, b, GRAIN);
    // rust: arena.trim();
    // rust: assert_eq!(arena.bytes(), 2 * GRAIN * 4);
    // rust: assert_eq!(arena.buffer(live), &buffer);
    // rust: let (reused, d) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: assert_eq!(reused, first);

    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: wgpu::util::DownloadBuffer::read_buffer(
    // rust: &device,
    // rust: &queue,
    // rust: &arena.buffer(live).slice(c * 4..c * 4 + 4),
    // rust: move |result| tx.send(result.unwrap().to_vec()).unwrap(),
    // rust: );
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: assert_eq!(rx.recv().unwrap(), data);
    // rust: arena.release(reused, d, GRAIN);
    // rust: arena.release(live, c, 2 * GRAIN);
    // rust: arena.trim();
    // rust: assert_eq!(arena.bytes(), 0);
    // rust: assert!(arena.pages.is_empty());
}

    /// Every arena's pages stay within its cap and the device's limits: the
    /// whole-page storage bindings of flat draws and shader packs included.
pub fn pages_stay_within_their_caps_and_the_device_limits() void {
}
    // rust: let devices = devices();
    // rust: if devices.is_empty() {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let bytes = |a: &Arena| a.page_vertices() * a.stride;
    // rust: for (device, _) in &devices {
    // rust: let limits = device.limits();
    // rust: for storage in [false, true] {
    // rust: for arena in [
    // rust: Arena::new(device, 24, GRAIN, storage),
    // rust: Arena::indices(device, GRAIN, storage),
    // rust: ] {
    // rust: assert!(bytes(&arena) <= PAGE_BYTES.min(limits.max_buffer_size));
    // rust: let binding = limits.max_storage_buffer_binding_size;
    // rust: assert!(!storage || bytes(&arena) <= binding);
}
}
    // rust: for large in [
    // rust: Arena::translucent(device, 24, GRAIN),
    // rust: Arena::translucent_indices(device, GRAIN),
    // rust: ] {
    // rust: assert!(bytes(&large) <= LARGE_PAGE_BYTES.min(limits.max_buffer_size));
    // rust: assert!(!large.usage.contains(wgpu::BufferUsages::STORAGE));
}
}
}

    /// The translucent arena comes with the split layout alone, and only then
    /// are the index pages large, unless flat draws (`flat`) bind them as
    /// storage. Otherwise, as while a shader pack's terrain draws flat (gfx's
    /// `translucent_split`), translucent quads keep to the section arena.
pub fn translucent_arenas_follow_the_layout() void {
}
    // rust: let devices = devices();
    // rust: if devices.is_empty() {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut exercised = false;
    // rust: for (device, _) in &devices {
    // rust: let limits = device.limits();
    // rust: let large = limits.max_buffer_size > PAGE_BYTES;
    // rust: exercised |= large;
    // rust: for flat in [false, true] {
    // rust: for split in [false, true] {
    // rust: let case = format!("large {large}, flat {flat}, split {split}");
    // rust: let (indices, translucent) = Arena::translucent_arenas(device, 24, flat, split);
    // rust: assert_eq!(translucent.is_some(), split, "{case}");
    // rust: let bytes = indices.page_vertices() * 4;
    // rust: let storage = indices.usage.contains(wgpu::BufferUsages::STORAGE);
    // rust: assert_eq!(storage, flat, "{case}");
    // rust: assert!(!storage || bytes <= limits.max_storage_buffer_binding_size);
    // rust: assert_eq!(bytes > PAGE_BYTES, split && !flat && large, "{case}");
    // rust: if let Some(t) = translucent {
    // rust: assert_eq!(t.page_vertices() * 24 > PAGE_BYTES, large, "{case}");
}
}
}
}
    // rust: if !exercised {
    // rust: eprintln!("buffers end at PAGE_BYTES here: large pages not exercised");
}
}

    /// Pages double up to `PAGE_BYTES`, then grow by `PAGE_BYTES` at most.
pub fn large_pages_grow_by_bounded_steps() void {
}
    // rust: let Some((device, _)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::translucent(&device, 24, GRAIN);
        // Exercise the policy past the test device's own buffer limit.
    // rust: arena.page_limit = LARGE_PAGE_BYTES / 24 / GRAIN * GRAIN;
    // rust: let step = PAGE_BYTES / 24;
    // rust: assert_eq!(arena.grown(1 << 18, GRAIN), 1 << 19);
    // rust: assert_eq!(arena.grown(step, GRAIN), 2 * step);
    // rust: assert_eq!(arena.grown(3 * step, GRAIN), 4 * step);
    // rust: assert_eq!(arena.grown(3 * step, step + GRAIN), 4 * step + GRAIN);
    // rust: assert_eq!(
    // rust: arena.grown(arena.page_limit - GRAIN, GRAIN),
    // rust: arena.page_limit
    // rust: );
}

    /// A large page far larger than its ranges in use moves into a new page of their
    /// size (`begin_shrink`) over frames, through `move_off_page`: a budget a call,
    /// its first range whatever its size, data and all, while new ranges, writes and
    /// releases go on around the moves in one encoder, as the renderer records them.
    /// The other range of each mesh stays; the emptied page takes no new range until
    /// `trim` returns it. Translucent vertices and sorted indices alike.
pub fn a_large_page_moves_into_one_of_the_size_its_ranges_get() void {
}
//         use super::super::{Part, SectionGpu, begin_shrink, move_off_page};
        // Where system memory could take the new page, it must not.
    // rust: let Some((device, queue)) = device_with(wgpu::Features::MAPPABLE_PRIMARY_BUFFERS) else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: for (mut arena, part) in [
    // rust: (Arena::translucent(&device, 24, GRAIN), Part::Translucent),
    // rust: (Arena::translucent_indices(&device, GRAIN), Part::Indices),
    // rust: ] {
    // rust: let indices = matches!(part, Part::Indices);
    // rust: let stride = arena.stride;
            // 64 quads a mesh: their vertices, or their sorted indices.
    // rust: let len: u64 = if indices { 64 * 6 } else { 64 * 4 };
    // rust: let span = len.next_multiple_of(GRAIN);
            // Its range here at `at`; the other one names a page that is not there.
    // rust: let mesh = |at: (u32, u64), solid: u32, translucent: u32| SectionGpu {
    // rust: page: 0,
    // rust: start: 0,
    // rust: translucent_at: if indices { (7, 7) } else { at },
    // rust: solid,
    // rust: solid_slots: u64::from(solid) * 4,
    // rust: packed: false,
    // rust: sides: crate::mesher::Sides::unsorted(solid),
    // rust: translucent,
    // rust: sort: super::super::translucency::SortState::new(Vec::new()),
    // rust: sorted_indices: (translucent > 0).then_some(if indices { at } else { (7, 7) }),
    // rust: flat_id: None,
    // rust: gpu_id: None,
    // rust: gpu_fading: false,
    // rust: fading: None,
    // rust: leaving: None,
    // rust: animated_layers: Box::new([]),
}
    // rust: let mut uploads = super::super::upload::Uploads::new(&device);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
            // As the renderer writes: through a belt, in the encoder's order.
    // rust: let mut write = |encoder: &mut _, buffer: &wgpu::Buffer, at: u64, value: u32| {
    // rust: uploads.buffer(encoder, buffer, at * stride, &value.to_le_bytes())
}
            // Sixteen meshes with their number at both ends of their range, and one
            // of solid quads alone (nothing here).
    // rust: let mut meshes: Vec<(u32, SectionGpu)> = (0..16)
    // rust: .map(|i| {
    // rust: let at = arena.alloc(&device, &mut encoder, len).unwrap();
    // rust: write(&mut encoder, arena.buffer(at.0), at.1, i);
    // rust: write(&mut encoder, arena.buffer(at.0), at.1 + len - 1, i);
    // rust: (i, mesh(at, 0, 64))
    // rust: })
    // rust: .collect();
    // rust: meshes.push((99, mesh((0, 0), 64, 0)));
            // Grown past `SHRINK_MIN_BYTES` in the same encoder (the writes before
            // reach the grown buffer), then mostly freed, as after a teleport.
    // rust: let big = (64u64 << 20).div_ceil(stride);
    // rust: let at = arena.alloc(&device, &mut encoder, big).unwrap();
    // rust: arena.release(at.0, at.1, big);
    // rust: for (_, s) in meshes.extract_if(.., |(i, _)| ![0, 3, 6, 9, 12, 99].contains(i)) {
    // rust: let (page, start, n) = part.of(&s).unwrap();
    // rust: arena.release(page, start, n);
}
            // No video memory for the new page: nothing changes, nothing spills.
    // rust: arena.video_memory_full = true;
    // rust: let held = meshes.iter_mut().map(|(_, s)| s);
    // rust: assert_eq!(begin_shrink(&mut arena, &device, held, part), Some(false));
    // rust: assert_eq!((arena.closing(), arena.pages.len()), (None, 1));
    // rust: assert!(!arena.spilled);
    // rust: arena.video_memory_full = false;
    // rust: let held = meshes.iter_mut().map(|(_, s)| s);
    // rust: assert_eq!(begin_shrink(&mut arena, &device, held, part), Some(true));
    // rust: assert_eq!(arena.closing(), Some(0));
            // Twice the five meshes' ranges.
    // rust: assert_eq!(arena.pages[1].as_ref().unwrap().capacity, 10 * span);
            // New ranges go to the new page meanwhile.
    // rust: let upload = arena.alloc(&device, &mut encoder, GRAIN).unwrap();
    // rust: assert_eq!(upload.0, 1);
    // rust: write(&mut encoder, arena.buffer(1), upload.1, 77);
            // Moves what page 0 holds within `budget`: how many meshes page 1 has then.
    // rust: let moved = |arena: &mut Arena,
    // rust: encoder: &mut _,
    // rust: meshes: &mut [(u32, SectionGpu)],
    // rust: budget: &mut u64| {
    // rust: let held = meshes.iter_mut().map(|(_, s)| s);
    // rust: assert!(move_off_page(
    // rust: arena, encoder, None, None, held, 0, part, budget
    // rust: ));
    // rust: let on = |s: &SectionGpu| part.of(s).is_some_and(|r| r.0 == 1);
    // rust: meshes.iter().filter(|(_, s)| on(s)).count()
}
    // rust: let mut budget = 2 * len * stride;
    // rust: let on = moved(&mut arena, &mut encoder, &mut meshes, &mut budget);
    // rust: assert_eq!((on, budget), (2, 0));
            // Out of budget, a call still moves its first range.
    // rust: let on = moved(&mut arena, &mut encoder, &mut meshes, &mut budget);
    // rust: assert_eq!(on, 3);
            // The sorter writes where #0 is now; a mesh still on the old page goes.
    // rust: let (page, start, _) = part.of(&meshes[0].1).unwrap();
    // rust: write(&mut encoder, arena.buffer(page), start, 100);
    // rust: let gone = meshes
    // rust: .iter()
    // rust: .position(|(_, s)| part.of(s).is_some_and(|r| r.0 == 0));
    // rust: let (page, start, n) = part.of(&meshes.remove(gone.unwrap()).1).unwrap();
    // rust: arena.release(page, start, n);
    // rust: budget = u64::MAX;
    // rust: let on = moved(&mut arena, &mut encoder, &mut meshes, &mut budget);
    // rust: assert_eq!(on, 4);
            // Emptied, it stays closed until `trim`.
    // rust: assert_eq!((arena.used(0), arena.closing()), (0, Some(0)));
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: let word = |page, at: u64| read(&device, &queue, arena.buffer(page), at * stride);
    // rust: for (i, s) in &meshes {
    // rust: let Some((page, start, n)) = part.of(s) else {
                    // Solid quads alone: as it was.
    // rust: let at = if indices { (7, 7) } else { (0, 0) };
    // rust: assert_eq!((*i, s.translucent_at, s.sorted_indices), (99, at, None));
    // rust: continue;
}
    // rust: assert_eq!(page, 1);
    // rust: assert_eq!(word(page, start), if *i == 0 { 100 } else { *i });
    // rust: assert_eq!(word(page, start + n - 1), *i);
                // Its other range stays where it was.
    // rust: assert!(s.translucent_at == (7, 7) || s.sorted_indices == Some((7, 7)));
}
    // rust: assert_eq!(word(upload.0, upload.1), 77);
    // rust: arena.trim();
    // rust: assert!(!arena.has_page(0));
    // rust: assert_eq!(arena.closing(), None);
    // rust: assert_eq!(arena.bytes(), 10 * span * stride);
}
}

    /// Large pages shrink when a page of their ranges in use (what `grown` makes of
    /// them, at least the first page's size) halves them or is `PAGE_BYTES`
    /// smaller: at the smallest page that shrinks and at the largest.
pub fn large_pages_shrink_when_that_halves_them_or_saves_a_page() void {
}
    // rust: let Some((device, _)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut arena = Arena::translucent(&device, 24, 1 << 18);
    // rust: arena.page_limit = LARGE_PAGE_BYTES / 24 / GRAIN * GRAIN;
    // rust: let (limit, step) = (arena.page_limit, PAGE_BYTES / 24);
        // `oversized` looks at the counts only: a small buffer stands in.
    // rust: let buffer = try_create(&device, "Stand-in page", 4, wgpu::BufferUsages::VERTEX).unwrap();
    // rust: let mut shrinks = |capacity: u64, used: u64, host: bool| {
    // rust: let free = FreeList(BTreeMap::from([(used, capacity - used)]));
    // rust: let buffer = buffer.clone();
    // rust: arena.pages = vec![Some(Page {
    // rust: buffer,
    // rust: capacity,
    // rust: free,
    // rust: host,
    // rust: })];
    // rust: arena.oversized().map(|(_, to)| to)
}
    // rust: let least = (64u64 << 20).div_ceil(24).next_multiple_of(GRAIN);
    // rust: let quarter = least / 4 / GRAIN * GRAIN;
    // rust: assert_eq!(shrinks(least, quarter, false), Some(2 * quarter));
    // rust: assert_eq!(shrinks(least, quarter + GRAIN, false), None);
    // rust: let used = (limit - 2 * step) / GRAIN * GRAIN;
    // rust: let target = (used + step).next_multiple_of(GRAIN);
    // rust: assert_eq!(shrinks(limit, used, false), Some(target));
    // rust: assert_eq!(shrinks(limit, used + GRAIN, false), None);
        // The page it leads to, holding the same, is not oversized.
    // rust: assert_eq!(shrinks(target, used, false), None);
        // Not below the first page's size; smaller pages and empty ones stay.
    // rust: assert_eq!(shrinks(least, GRAIN, false), Some(1 << 18));
    // rust: assert_eq!(shrinks(least - GRAIN, GRAIN, false), None);
    // rust: assert_eq!(shrinks(least, 0, false), None);
        // One in system memory goes back to video memory; none while one closes.
    // rust: assert_eq!(shrinks(least, quarter, true), Some(2 * quarter));
    // rust: arena.closing = Some(0);
    // rust: assert_eq!(arena.oversized(), None);
}

pub fn clearing_an_arena_releases_buffers_and_can_allocate_again() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: for mut arena in [
    // rust: Arena::new(&device, 28, GRAIN, false),
    // rust: Arena::translucent(&device, 24, GRAIN),
    // rust: Arena::indices(&device, GRAIN, false),
    // rust: Arena::translucent_indices(&device, GRAIN),
    // rust: ] {
    // rust: alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: assert_eq!(arena.bytes(), arena.stride * GRAIN);
    // rust: arena.clear();
    // rust: assert_eq!(arena.bytes(), 0);
    // rust: assert_eq!(alloc(&mut arena, &device, &queue, GRAIN), Some((0, 0)));
    // rust: assert_eq!(arena.bytes(), arena.stride * GRAIN);
}
}

pub fn free_ranges_coalesce() void {
}
    // rust: let mut free = FreeList::new(4 * GRAIN);
    // rust: let a = free.take(GRAIN).unwrap();
    // rust: let b = free.take(2 * GRAIN).unwrap();
    // rust: let c = free.take(GRAIN).unwrap();
    // rust: assert_eq!((a, b, c), (0, GRAIN, 3 * GRAIN));
    // rust: assert_eq!(free.take(1), None);
    // rust: free.give(a, GRAIN);
    // rust: free.give(c, GRAIN);
        // Two holes of one grain: a two-grain request does not fit.
    // rust: assert_eq!(free.take(2 * GRAIN), None);
    // rust: free.give(b, 2 * GRAIN);
    // rust: assert_eq!(free, FreeList::new(4 * GRAIN));
}

pub fn many_ranges_given_at_once_coalesce_as_one_by_one() void {
}
    // rust: let fill = || {
    // rust: let mut free = FreeList::new(1 << 30);
    // rust: let taken: Vec<(u64, u64)> = (0..500u64)
    // rust: .map(|i| {
    // rust: let len = GRAIN * (1 + i * 7 % 5);
    // rust: (free.take(len).unwrap(), len)
    // rust: })
    // rust: .collect();
    // rust: for &(start, len) in taken.iter().step_by(3) {
    // rust: free.give(start, len);
}
    // rust: (free, taken)
}
        // Every other range of those still taken, in a scattered order.
    // rust: let (mut one_by_one, taken) = fill();
    // rust: let (mut at_once, _) = fill();
    // rust: let mut given: Vec<(u64, u64)> = (0..taken.len())
    // rust: .filter(|i| i % 3 != 0 && i % 2 == 0)
    // rust: .map(|i| taken[i])
    // rust: .collect();
    // rust: given.sort_by_key(|&(start, _)| start.wrapping_mul(0x9E37_79B9_7F4A_7C15));
    // rust: assert!(given.len() >= 64);
    // rust: for &(start, len) in &given {
    // rust: one_by_one.give(start, len);
}
    // rust: at_once.give_all(given);
    // rust: assert_eq!(at_once, one_by_one);
        // The rest too: everything is free again, in one range.
    // rust: let rest: Vec<(u64, u64)> = (0..taken.len())
    // rust: .filter(|i| i % 3 != 0 && i % 2 != 0)
    // rust: .map(|i| taken[i])
    // rust: .collect();
    // rust: at_once.give_all(rest);
    // rust: assert_eq!(at_once, FreeList::new(1 << 30));
}

pub fn first_fit_reuses_the_lowest_hole() void {
}
    // rust: let mut free = FreeList::new(8 * GRAIN);
    // rust: let a = free.take(GRAIN).unwrap();
    // rust: let _b = free.take(GRAIN).unwrap();
    // rust: free.give(a, GRAIN);
    // rust: assert_eq!(free.take(GRAIN), Some(a));
}

pub fn read(device: *wgpu::Device, queue: *wgpu::Queue, buffer: *wgpu::Buffer, offset: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: wgpu::util::DownloadBuffer::read_buffer(
    // rust: device,
    // rust: queue,
    // rust: &buffer.slice(offset..offset + 4),
    // rust: move |result| tx.send(result.unwrap().to_vec()).unwrap(),
    // rust: );
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: u32::from_le_bytes(rx.recv().unwrap()[..4].try_into().unwrap())
}

pub fn full_video_memory_spills_to_system_memory() void {
}
    // rust: let Some((device, queue)) = device_with(wgpu::Features::MAPPABLE_PRIMARY_BUFFERS) else {
    // rust: return;
}
    // rust: if !device
    // rust: .features()
    // rust: .contains(wgpu::Features::MAPPABLE_PRIMARY_BUFFERS)
    // rust: {
    // rust: return;
}
    // rust: let mut arena = Arena::indices(&device, GRAIN, false);
    // rust: let (page, start) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: queue.write_buffer(arena.buffer(page), start * 4, &7u32.to_le_bytes());
    // rust: arena.video_memory_full = true;
        // The full page can't grow in video memory: it moves to system
        // memory with its contents, and new ranges come from there.
    // rust: let (grown, next) = alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: assert!(arena.spilled);
    // rust: assert_eq!(grown, page);
    // rust: assert!(
    // rust: arena
    // rust: .buffer(page)
    // rust: .usage()
    // rust: .contains(wgpu::BufferUsages::MAP_WRITE)
    // rust: );
    // rust: queue.write_buffer(arena.buffer(grown), next * 4, &9u32.to_le_bytes());
    // rust: assert_eq!(read(&device, &queue, arena.buffer(page), start * 4), 7);
    // rust: assert_eq!(read(&device, &queue, arena.buffer(grown), next * 4), 9);
        // Compaction never moves terrain into a page in system memory.
    // rust: assert!(arena.pages[page as usize].as_ref().unwrap().host);
    // rust: assert_eq!(arena.alloc_moved(GRAIN), None);
}

pub fn no_memory_left_is_not_an_error() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let mut arena = Arena::indices(&device, GRAIN, false);
    // rust: alloc(&mut arena, &device, &queue, GRAIN).unwrap();
    // rust: arena.video_memory_full = true;
        // Without mappable primary buffers nothing can spill: the request
        // fails, and the arena keeps what it has.
    // rust: assert_eq!(alloc(&mut arena, &device, &queue, GRAIN), None);
    // rust: assert_eq!(arena.bytes(), GRAIN * 4);
    // rust: arena.release(0, 0, GRAIN);
    // rust: assert_eq!(alloc(&mut arena, &device, &queue, GRAIN), Some((0, 0)));
}
}
