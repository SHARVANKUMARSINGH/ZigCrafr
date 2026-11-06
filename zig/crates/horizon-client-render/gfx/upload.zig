//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_upload
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Per-frame uploads through one reused staging belt. `Queue::write_buffer`
//! and `Queue::write_texture` create a fresh staging buffer for every call (on
//! Metal a kernel call each), which made the animated sprites' few hundred
//! texture writes a spike on every tick that changes a frame. The belt keeps a
//! few mapped buffers and records the copies into the frame's encoder instead.
// use std::num::NonZeroU64;

/// Large enough for a tick of animated sprites at 16x16 with every mip level.
pub const CHUNK: u64 = 1 << 20;

pub const Uploads = struct {
    belt: wgpu::util::StagingBelt,
    chunk: u64,
};

    // rust: impl Uploads {
pub fn new(device: *wgpu::Device) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_chunk(device, CHUNK)
}
    /// A belt whose staging buffers hold `chunk` bytes (a larger write gets
    /// a buffer of its own, rounded up to a power of two).
pub fn with_chunk(device: *wgpu::Device, chunk: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: belt: wgpu::util::StagingBelt::new(device.clone(), chunk),
    // rust: chunk,
}
}
    /// A mapped staging slice of at least `size` bytes. The belt gives a
    /// write larger than its chunk a buffer of exactly that size, keeps it for
    /// good and only reuses it for writes that fit: an upload that grows a
    /// little every frame (the entity batch while mobs appear) took a new
    /// buffer each frame until the game ran out of memory (#2826). Rounded up
    /// to a power of two, the large buffers it keeps are reused, one per
    /// doubling.
pub fn allocate(self: *Self, size: NonZeroU64, alignment: NonZeroU64) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = if size.get() > self.chunk {
    // rust: size.checked_next_power_of_two().unwrap_or(size)
    // rust: } else {
    // rust: size
}
    // rust: self.belt.allocate(size, alignment)
}
    /// Copy tightly packed RGBA8 `pixels` (`width` by `height`) into one mip
    /// level of one array layer, padding rows to the copy alignment.
    // rust: pub fn texture(
    // rust: &mut self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: destination: wgpu::TexelCopyTextureInfo<'_>,
    // rust: width: u32,
    // rust: height: u32,
    // rust: pixels: &[u8],
    // rust: ) {
    // rust: let row = width as usize * 4;
    // rust: debug_assert_eq!(pixels.len(), row * height as usize);
    // rust: let padded = row.next_multiple_of(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT as usize);
    // rust: let Some(size) = NonZeroU64::new((padded * height as usize) as u64) else {
    // rust: return;
}
    // rust: let alignment = NonZeroU64::new(u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT))
    // rust: .expect("non-zero alignment");
    // rust: let slice = self.allocate(size, alignment);
    // rust: {
    // rust: let mut view = slice
    // rust: .get_mapped_range_mut()
    // rust: .expect("staging belt slices are mapped");
    // rust: for (i, src) in pixels.chunks(row).enumerate() {
    // rust: view.slice(i * padded..i * padded + row)
    // rust: .copy_from_slice(src);
}
}
    // rust: encoder.copy_buffer_to_texture(
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: slice.buffer(),
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: slice.offset(),
    // rust: bytes_per_row: Some(padded as u32),
    // rust: rows_per_image: Some(height),
    // rust: },
    // rust: },
    // rust: destination,
    // rust: wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
}
    /// Copy `bytes` into `target` at `offset`, as `Queue::write_buffer`
    /// would, in the encoder's order.
    // rust: pub fn buffer(
    // rust: &mut self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: target: &wgpu::Buffer,
    // rust: offset: u64,
    // rust: bytes: &[u8],
    // rust: ) {
    // rust: let Some(size) = NonZeroU64::new(bytes.len() as u64) else {
    // rust: return;
}
        // The belt's own `write_buffer` checks, kept now that a large write's
        // slice is rounded up past them.
    // rust: assert!(
    // rust: offset.is_multiple_of(wgpu::COPY_BUFFER_ALIGNMENT)
    // rust: && size.get().is_multiple_of(wgpu::COPY_BUFFER_ALIGNMENT),
    // rust: "buffer upload at {offset} of {size} bytes must be 4-byte aligned"
    // rust: );
    // rust: let alignment = NonZeroU64::new(wgpu::COPY_BUFFER_ALIGNMENT).expect("non-zero alignment");
    // rust: let slice = self.allocate(size, alignment).slice(..size.get());
    // rust: encoder.copy_buffer_to_buffer(slice.buffer(), slice.offset(), target, offset, size.get());
    // rust: slice
    // rust: .get_mapped_range_mut()
    // rust: .expect("staging belt slices are mapped")
    // rust: .slice(..)
    // rust: .copy_from_slice(bytes);
}
    /// Close this frame's staging buffers: they come back for reuse once the
    /// encoder's submission finishes on the GPU.
pub fn finish(self: *Self, encoder: *wgpu::CommandEncoder) void {
}
    // rust: self.belt.finish_and_recall_on_submit(encoder);
}
}

    // rust: mod tests {
//     use super::*;

pub fn device() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

    /// Every mip level of one layer, read back as tightly packed RGBA8.
pub fn read_back(device: *wgpu::Device, queue: *wgpu::Queue, texture: *wgpu::Texture) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: for level in 0..texture.mip_level_count() {
    // rust: let edge = texture.width() >> level;
    // rust: let padded = (edge * 4).next_multiple_of(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT);
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(padded * edge),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_texture_to_buffer(
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d { x: 0, y: 0, z: 1 },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(padded),
    // rust: rows_per_image: Some(edge),
    // rust: },
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: edge,
    // rust: height: edge,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = buffer.slice(..).get_mapped_range().unwrap();
    // rust: for row in data.chunks(padded as usize) {
    // rust: out.extend_from_slice(&row[..edge as usize * 4]);
}
}
    // rust: out
}

pub fn belt_uploads_match_queue_writes_on_every_mip_level() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let texture = || {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 16,
    // rust: height: 16,
    // rust: depth_or_array_layers: 3,
    // rust: },
    // rust: mip_level_count: 5,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::COPY_DST | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let (expected, actual) = (texture(), texture());
    // rust: let mut uploads = Uploads::new(&device);
        // Two frames, so the second reuses the belt's recalled buffers.
    // rust: for frame in 0..2u8 {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: for level in 0..5 {
    // rust: let edge = 16 >> level;
    // rust: let pixels: Vec<u8> = (0..edge * edge * 4)
    // rust: .map(|i| {
    // rust: (i as u8)
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(level as u8 * 7 + frame)
    // rust: })
    // rust: .collect();
    // rust: let at = |texture| wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d { x: 0, y: 0, z: 1 },
    // rust: aspect: wgpu::TextureAspect::All,
}
    // rust: queue.write_texture(
    // rust: at(&expected),
    // rust: &pixels,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(edge * 4),
    // rust: rows_per_image: Some(edge),
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: edge,
    // rust: height: edge,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: uploads.texture(&mut encoder, at(&actual), edge, edge, &pixels);
}
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: assert_eq!(
    // rust: read_back(&device, &queue, &actual),
    // rust: read_back(&device, &queue, &expected),
    // rust: "frame {frame}"
    // rust: );
}
}

    /// Staging buffers the belt holds, once every submitted frame is done
    /// with them. The belt only reports its buffers through `Debug`.
pub fn kept_buffers(device: *wgpu::Device, uploads: *mut Uploads) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
        // Finishing an empty frame takes back every recalled buffer.
    // rust: uploads.finish(&device.create_command_encoder(&Default::default()));
    // rust: let belt = format!("{:?}", uploads.belt);
    // rust: let count = |field: &str| -> usize {
    // rust: let at = belt.find(&format!("{field}: ")).expect(&belt) + field.len() + 2;
    // rust: let digits = belt[at..].split(|c: char| !c.is_ascii_digit()).next();
    // rust: digits.and_then(|d| d.parse().ok()).expect(&belt)
}
    // rust: count("active_chunks") + count("closed_chunks") + count("free_chunks")
}

    /// #2826: a write larger than the chunk that grows a little every frame
    /// (the entity batch while mobs appear) got a new exact-size buffer each
    /// frame, all of them kept, until the game ran out of memory.
pub fn growing_large_writes_reuse_the_belt_buffers() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
pub const CHUNK: u64 = 1 << 16;
pub const TARGET: usize = 4 * CHUNK ;
    // rust: let target = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: TARGET as u64,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let readback = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: TARGET as u64,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut uploads = Uploads::with_chunk(&device, CHUNK);
    // rust: let mut expected = vec![0u8; TARGET];
    // rust: let frames = 64;
    // rust: for frame in 0..frames {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
            // One small write, then the large one, 1.5 to 3.5 chunks long.
    // rust: uploads.buffer(&mut encoder, &target, TARGET as u64 - 4, &[9; 4]);
    // rust: expected[TARGET - 4..].fill(9);
    // rust: let len = (3 * CHUNK as usize / 2 + frame * 2048).next_multiple_of(4);
    // rust: let bytes: Vec<u8> = (0..len).map(|i| (i + frame) as u8).collect();
    // rust: uploads.buffer(&mut encoder, &target, 0, &bytes);
    // rust: expected[..len].copy_from_slice(&bytes);
    // rust: encoder.copy_buffer_to_buffer(&target, 0, &readback, 0, TARGET as u64);
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: readback
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
            // Only the written bytes land: the rest of the target is untouched.
    // rust: assert!(
    // rust: *readback.slice(..).get_mapped_range().unwrap() == expected[..],
    // rust: "frame {frame}"
    // rust: );
    // rust: readback.unmap();
}
        // A chunk for the small writes and a buffer per doubling of the large
        // one (2 and 4 chunks), maybe one more where a small write took the
        // start of a buffer the large one needed whole: not one per frame.
    // rust: let kept = kept_buffers(&device, &mut uploads);
    // rust: assert!(
    // rust: kept <= 4,
    // rust: "the belt kept {kept} buffers over {frames} frames"
    // rust: );
}

pub fn belt_buffer_writes_land_in_order_at_their_offsets() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let target = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 64,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let readback = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 64,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut expected = [0u8; 64];
    // rust: for frame in 0..3u8 {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
            // Overlapping writes: the later one wins, as with the queue.
    // rust: for (offset, len, value) in [(0, 32, frame + 1), (16, 32, frame + 10), (60, 4, 7)] {
    // rust: let bytes = vec![value; len];
    // rust: uploads.buffer(&mut encoder, &target, offset as u64, &bytes);
    // rust: expected[offset..offset + len].copy_from_slice(&bytes);
}
    // rust: uploads.buffer(&mut encoder, &target, 0, &[]);
    // rust: encoder.copy_buffer_to_buffer(&target, 0, &readback, 0, 64);
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: readback
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: assert_eq!(
    // rust: *readback.slice(..).get_mapped_range().unwrap(),
    // rust: expected[..]
    // rust: );
    // rust: readback.unmap();
}
}
}
