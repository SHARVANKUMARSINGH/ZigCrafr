//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_images
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A shader pack's own images (`image.<name>`) and storage buffers (`bufferObject.<n>`) on the
//! GPU: created at the render size they depend on, kept across frames, images cleared before a
//! frame when the pack asks.

// use std::collections::BTreeMap;

// use horizon_shaders::{BufferObject, CustomImage, Format, Kind};

    // rust: pub(super) struct PackImage {
    // rust: pub(super) def: CustomImage,
    // rust: pub(super) format: wgpu::TextureFormat,
    // rust: pub(super) dimension: wgpu::TextureViewDimension,
    // rust: pub(super) view: Option<wgpu::TextureView>,
    /// Last frame's contents, for a pass that samples and stores the image (`copied`).
    // rust: pub(super) copy: Option<wgpu::TextureView>,
    // rust: pub(super) copied: bool,
    /// The contents before a compute pass that reads them so (`snapshot`), apart from `copy`,
    /// which a later pass may still sample.
    // rust: pub(super) before: Option<wgpu::TextureView>,
    // rust: pub(super) snapshotted: bool,
    /// The render size the image was made for (relative images follow it).
    // rust: made_for: [u32; 2],
}

    // rust: impl PackImage {
    // rust: pub(super) fn sample_type(&self, features: wgpu::Features) -> wgpu::TextureSampleType {
    // rust: self.format
    // rust: .sample_type(None, Some(features))
    // rust: .unwrap_or(wgpu::TextureSampleType::Float { filterable: false })
}
}

/// The images `image.*` declares.
    // rust: pub(super) fn images(defs: Vec<CustomImage>) -> Vec<PackImage> {
    // rust: defs.into_iter()
    // rust: .map(|def| PackImage {
    // rust: format: format(def.format),
    // rust: dimension: if def.is_1d() {
    // rust: wgpu::TextureViewDimension::D1
    // rust: } else if def.is_3d() {
    // rust: wgpu::TextureViewDimension::D3
    // rust: } else {
    // rust: wgpu::TextureViewDimension::D2
    // rust: },
    // rust: def,
    // rust: view: None,
    // rust: copy: None,
    // rust: copied: false,
    // rust: before: None,
    // rust: snapshotted: false,
    // rust: made_for: [0; 2],
    // rust: })
    // rust: .collect()
}

/// The texture dimension a view of `view` needs.
pub fn texture_dimension(view: wgpu::TextureViewDimension) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match view {
    // rust: wgpu::TextureViewDimension::D1 => wgpu::TextureDimension::D1,
    // rust: wgpu::TextureViewDimension::D3 => wgpu::TextureDimension::D3,
    // rust: _ => wgpu::TextureDimension::D2,
}
}

/// The wgpu format of an image's internal format: a storage format of the same channels.
    // rust: pub(super) fn format(f: Format) -> wgpu::TextureFormat {
//     use wgpu::TextureFormat as T;
    // rust: let pick = |r, rg, rgba| match f.channels {
    // rust: 1 => r,
    // rust: 2 => rg,
    // rust: _ => rgba,
}
    // rust: match (f.kind, f.bits) {
    // rust: (Kind::Int, 8) => pick(T::R8Sint, T::Rg8Sint, T::Rgba8Sint),
    // rust: (Kind::Int, 16) => pick(T::R16Sint, T::Rg16Sint, T::Rgba16Sint),
    // rust: (Kind::Int, _) => pick(T::R32Sint, T::Rg32Sint, T::Rgba32Sint),
    // rust: (Kind::Uint, 8) => pick(T::R8Uint, T::Rg8Uint, T::Rgba8Uint),
    // rust: (Kind::Uint, 16) => pick(T::R16Uint, T::Rg16Uint, T::Rgba16Uint),
    // rust: (Kind::Uint, _) => pick(T::R32Uint, T::Rg32Uint, T::Rgba32Uint),
    // rust: (Kind::Float, 32) => pick(T::R32Float, T::Rg32Float, T::Rgba32Float),
    // rust: (Kind::Float, _) => pick(T::R16Float, T::Rg16Float, T::Rgba16Float),
    // rust: (Kind::Snorm, _) => pick(T::R8Snorm, T::Rg8Snorm, T::Rgba8Snorm),
    // rust: (Kind::Unorm, 16) => pick(T::R16Unorm, T::Rg16Unorm, T::Rgba16Unorm),
    // rust: (Kind::Unorm, _) => pick(T::R8Unorm, T::Rg8Unorm, T::Rgba8Unorm),
}
}

/// Whether this device can make `def`: its format's features, and a size in pixels within the
/// device's limits.
    // rust: pub(super) fn makeable(device: &wgpu::Device, def: &CustomImage) -> Result<(), String> {
    // rust: let format = format(def.format);
    // rust: let missing = format.required_features() - device.features();
    // rust: if !missing.is_empty() {
    // rust: return Err(format!(
    // rust: "{format:?} needs {missing:?}, which this GPU lacks"
    // rust: ));
}
    // rust: let limits = device.limits();
    // rust: let largest = if def.is_1d() {
    // rust: limits.max_texture_dimension_1d
    // rust: } else if def.is_3d() {
    // rust: limits.max_texture_dimension_3d
    // rust: } else {
    // rust: limits.max_texture_dimension_2d
}
    // rust: let [width, height, depth] = def.extent([1, 1]);
    // rust: let relative = matches!(def.size, horizon_shaders::ImageSize::Relative(_));
    // rust: if !relative && width.max(height).max(depth) > largest {
    // rust: return Err(format!(
    // rust: "{width}x{height}x{depth} is larger than this GPU's {largest}"
    // rust: ));
}
    // rust: Ok(())
}

/// Makes the images that are missing or sized for another render size; whether it made any.
    // rust: pub(super) fn resize_images(
    // rust: device: &wgpu::Device,
    // rust: images: &mut [PackImage],
    // rust: size: [u32; 2],
    // rust: ) -> bool {
    // rust: let largest = device.limits().max_texture_dimension_2d;
    // rust: let mut made = false;
    // rust: for image in images {
    // rust: let relative = matches!(image.def.size, horizon_shaders::ImageSize::Relative(_));
    // rust: if image.view.is_some() && (!relative || image.made_for == size) {
    // rust: continue;
}
    // rust: made = true;
        // A relative image larger than the render size stops at the device's limit.
    // rust: let [width, height, depth] = image.def.extent(size);
    // rust: let [width, height] = [width.min(largest), height.min(largest)];
    // rust: let make = |usage| {
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(&image.def.name),
    // rust: size: wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: depth,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: texture_dimension(image.dimension),
    // rust: format: image.format,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | usage,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}
        // Atomics on a texture need it made for them (Metal ignores them otherwise).
    // rust: let atomic = device.features().contains(wgpu::Features::TEXTURE_ATOMIC)
    // rust: && matches!(
    // rust: image.format,
    // rust: wgpu::TextureFormat::R32Sint | wgpu::TextureFormat::R32Uint
    // rust: );
    // rust: let atomic = if atomic {
    // rust: wgpu::TextureUsages::STORAGE_ATOMIC
    // rust: } else {
    // rust: wgpu::TextureUsages::empty()
}
    // rust: image.view = Some(make(
    // rust: wgpu::TextureUsages::STORAGE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | atomic,
    // rust: ));
    // rust: image.copy = image
    // rust: .copied
    // rust: .then(|| make(wgpu::TextureUsages::COPY_DST | wgpu::TextureUsages::STORAGE_BINDING));
    // rust: image.before = image
    // rust: .snapshotted
    // rust: .then(|| make(wgpu::TextureUsages::COPY_DST | wgpu::TextureUsages::STORAGE_BINDING));
    // rust: image.made_for = size;
}
    // rust: made
}

/// The most images a pack may have.
    // rust: pub(super) const IMAGES: usize = 64;

/// Copies `image` as it is before a compute pass whose loads read it so.
    // rust: pub(super) fn snapshot(encoder: &mut wgpu::CommandEncoder, image: &PackImage) {
    // rust: if let (Some(view), Some(before)) = (&image.view, &image.before) {
    // rust: encoder.copy_texture_to_texture(
    // rust: view.texture().as_image_copy(),
    // rust: before.texture().as_image_copy(),
    // rust: view.texture().size(),
    // rust: );
}
}

/// Copies the images of `mask` (bit n: image n), which a pass samples and stores, for that pass
/// to sample.
    // rust: pub(super) fn copy(encoder: &mut wgpu::CommandEncoder, images: &[PackImage], mask: u64) {
    // rust: for (_, image) in images
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(k, _)| mask & 1 << k != 0)
    // rust: {
    // rust: if let (Some(view), Some(copy)) = (&image.view, &image.copy) {
    // rust: encoder.copy_texture_to_texture(
    // rust: view.texture().as_image_copy(),
    // rust: copy.texture().as_image_copy(),
    // rust: view.texture().size(),
    // rust: );
}
}
}

/// Clears the images the pack clears before each frame: with `clear_texture` where the device
/// has it (`clear`), else by copying from `zeros`, a buffer of zeros made large enough.
    // rust: pub(super) fn clear(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: images: &[PackImage],
    // rust: clear: bool,
    // rust: zeros: &mut Option<wgpu::Buffer>,
    // rust: ) {
    // rust: for view in images
    // rust: .iter()
    // rust: .filter(|i| i.def.clear)
    // rust: .filter_map(|i| i.view.as_ref())
    // rust: {
    // rust: let texture = view.texture();
    // rust: if clear {
    // rust: encoder.clear_texture(texture, &Default::default());
    // rust: continue;
}
    // rust: let size = texture.size();
    // rust: let texel = u64::from(texture.format().block_copy_size(None).unwrap_or(4));
    // rust: let row = (u64::from(size.width) * texel).next_multiple_of(256);
        // Zeros for a slice of rows at a time, the whole image taken in slices, so a large
        // volume doesn't need a buffer of its size.
    // rust: let rows = (ZEROS / row).clamp(1, u64::from(size.height)) as u32;
    // rust: let bytes = row * u64::from(rows);
    // rust: if zeros.as_ref().is_none_or(|z| z.size() < bytes) {
            // New buffers start zeroed.
    // rust: *zeros = Some(device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack image zeros"),
    // rust: size: bytes,
    // rust: usage: wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: }));
}
    // rust: let Some(buffer) = zeros.as_ref() else {
    // rust: continue;
}
    // rust: for z in 0..size.depth_or_array_layers {
    // rust: for y in (0..size.height).step_by(rows as usize) {
    // rust: let height = rows.min(size.height - y);
    // rust: encoder.copy_buffer_to_texture(
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(row as u32),
    // rust: rows_per_image: Some(height),
    // rust: },
    // rust: },
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: 0,
    // rust: origin: wgpu::Origin3d { x: 0, y, z },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: size.width,
    // rust: height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
}
}
}
}

/// The most bytes of zeros kept to clear images without `CLEAR_TEXTURE`.
pub const ZEROS: u64 = 4 << 20;

/// What an image no `image.*` gives binds. Iris 1.11.7 runs the program, and its loads read
/// zero, also after it stored into the image (observed with a probe pack). Here it is one texel
/// of the declared format, cleared before every pass that binds it; loads and stores outside
/// that texel are out of bounds (with the same probe pack on Vulkan, the loads read zero).
    // rust: pub(super) struct StandIn {
    // rust: format: wgpu::TextureFormat,
    // rust: dimension: wgpu::TextureViewDimension,
    // rust: pub(super) view: wgpu::TextureView,
    // rust: zeros: wgpu::Buffer,
}

    // rust: impl StandIn {
    /// Zero again, before a pass that binds it.
    // rust: pub(super) fn clear(&self, encoder: &mut wgpu::CommandEncoder) {
    // rust: encoder.copy_buffer_to_texture(
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &self.zeros,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: None,
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: self.view.texture().as_image_copy(),
    // rust: self.view.texture().size(),
    // rust: );
}
}

/// One stand-in for each format and dimension of `wanted`.
    // rust: pub(super) fn stand_ins(
    // rust: device: &wgpu::Device,
    // rust: wanted: Vec<(wgpu::TextureFormat, wgpu::TextureViewDimension)>,
    // rust: ) -> Vec<StandIn> {
    // rust: wanted
    // rust: .into_iter()
    // rust: .map(|(format, dimension)| {
    // rust: let atomic = device.features().contains(wgpu::Features::TEXTURE_ATOMIC)
    // rust: && matches!(
    // rust: format,
    // rust: wgpu::TextureFormat::R32Sint | wgpu::TextureFormat::R32Uint
    // rust: );
    // rust: let view = device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack image stand-in"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: texture_dimension(dimension),
    // rust: format,
    // rust: usage: wgpu::TextureUsages::STORAGE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | if atomic {
    // rust: wgpu::TextureUsages::STORAGE_ATOMIC
    // rust: } else {
    // rust: wgpu::TextureUsages::empty()
    // rust: },
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default());
            // New buffers start zeroed; one texel is at most 16 bytes.
    // rust: let zeros = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack image stand-in zeros"),
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: StandIn {
    // rust: format,
    // rust: dimension,
    // rust: view,
    // rust: zeros,
}
    // rust: })
    // rust: .collect()
}

/// The stand-in of this format and dimension.
    // rust: pub(super) fn stand_in(
    // rust: stand_ins: &[StandIn],
    // rust: format: wgpu::TextureFormat,
    // rust: dimension: wgpu::TextureViewDimension,
    // rust: ) -> Option<&StandIn> {
    // rust: stand_ins
    // rust: .iter()
    // rust: .find(|s| s.format == format && s.dimension == dimension)
}

/// The pack's storage buffers, bound in set 4.
    // rust: pub(super) struct Buffers {
    // rust: pub(super) layout: wgpu::BindGroupLayout,
    // rust: objects: BTreeMap<u32, BufferObject>,
    /// The fewest bytes each one's shaders bind it as (`Post::buffer_minimums`).
    // rust: minimums: BTreeMap<u32, u64>,
    // rust: pub(super) group: Option<wgpu::BindGroup>,
    // rust: buffers: Vec<wgpu::Buffer>,
    // rust: made_for: [u32; 2],
}

    // rust: impl Buffers {
    /// The layout of `objects`, bound in `stages`; each buffer is at least its entry in
    /// `minimums` long.
    // rust: pub(super) fn new(
    // rust: device: &wgpu::Device,
    // rust: objects: BTreeMap<u32, BufferObject>,
    // rust: minimums: BTreeMap<u32, u64>,
    // rust: stages: wgpu::ShaderStages,
    // rust: ) -> Self {
    // rust: let entries: Vec<_> = objects
    // rust: .keys()
    // rust: .map(|&binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: stages,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only: false },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: })
    // rust: .collect();
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack buffers"),
    // rust: entries: &entries,
    // rust: });
    // rust: Self {
    // rust: layout,
    // rust: objects,
    // rust: minimums,
    // rust: group: None,
    // rust: buffers: Vec::new(),
    // rust: made_for: [0; 2],
}
}

    /// Makes the buffers (again, when one depends on the render size and it changed): their
    /// contents start zeroed and persist across frames.
    // rust: pub(super) fn resize(&mut self, device: &wgpu::Device, size: [u32; 2]) {
    // rust: let relative = self
    // rust: .objects
    // rust: .values()
    // rust: .any(|o| matches!(o, BufferObject::PerPixel { .. }));
    // rust: if self.group.is_some() && (!relative || self.made_for == size) {
    // rust: return;
}
    // rust: let limits = device.limits();
    // rust: let largest = limits
    // rust: .max_buffer_size
    // rust: .min(limits.max_storage_buffer_binding_size)
    // rust: & !3;
    // rust: self.buffers = self
    // rust: .objects
    // rust: .iter()
    // rust: .map(|(binding, o)| {
    // rust: let least = self.minimums.get(binding).copied().unwrap_or(0);
    // rust: let wanted = buffer_size(*o, size, least);
    // rust: if wanted > largest {
    // rust: log::warn!(
    // rust: "shader pack: bufferObject.{binding} wants {wanted} bytes, this device \
    // rust: binds at most {largest}"
    // rust: );
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack buffer"),
    // rust: size: wanted.min(largest),
    // rust: usage: wgpu::BufferUsages::STORAGE,
    // rust: mapped_at_creation: false,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let entries: Vec<_> = self
    // rust: .objects
    // rust: .keys()
    // rust: .zip(&self.buffers)
    // rust: .map(|(&binding, b)| wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: b.as_entire_binding(),
    // rust: })
    // rust: .collect();
    // rust: self.group = Some(device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack buffers"),
    // rust: layout: &self.layout,
    // rust: entries: &entries,
    // rust: }));
    // rust: self.made_for = size;
}

    /// Whether the pack declares buffer `binding`.
    // rust: pub(super) fn has(&self, binding: u32) -> bool {
    // rust: self.objects.contains_key(&binding)
}
}

/// The bytes a storage buffer is made with for a render size of `render`: what the pack
/// declares, or more when a shader binds it as a larger block (`least`), which wgpu needs where
/// OpenGL binds the smaller buffer; a multiple of 4.
pub fn buffer_size(object: BufferObject, render: [u32; 2], least: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: object.size(render).max(least).next_multiple_of(4)
}

/// A debug readback of one of the pack's images (`HORIZON_SHADER_PACK_DUMP=<name>`): every 60
/// frames, how many of its texels are not zero, logged.
    // rust: pub(super) struct Dump {
    // rust: name: String,
    // rust: frame: u32,
    // rust: pending: Option<(wgpu::Buffer, usize, [u32; 3], u32)>,
}

    // rust: impl Dump {
    // rust: pub(super) fn new() -> Option<Self> {
    // rust: let name = std::env::var("HORIZON_SHADER_PACK_DUMP").ok()?;
    // rust: Some(Self {
    // rust: name,
    // rust: frame: 0,
    // rust: pending: None,
    // rust: })
}

    /// Reads last frame's copy, once its commands ran.
    // rust: pub(super) fn read(&mut self, device: &wgpu::Device) {
    // rust: let Some((buffer, texel, [w, h, d], row)) = self.pending.take() else {
    // rust: return;
}
    // rust: buffer.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: let _ = device.poll(wgpu::PollType::Wait {
    // rust: submission_index: None,
    // rust: timeout: None,
    // rust: });
    // rust: let Ok(data) = buffer.slice(..).get_mapped_range() else {
    // rust: return;
}
    // rust: let (mut set, mut total) = (0usize, 0usize);
    // rust: for z in 0..d as usize {
    // rust: for y in 0..h as usize {
    // rust: let start = (z * h as usize + y) * row as usize;
    // rust: for x in 0..w as usize {
    // rust: let at = start + x * texel;
    // rust: total += 1;
    // rust: if data[at..at + texel].iter().any(|&b| b != 0) {
    // rust: set += 1;
}
}
}
}
    // rust: log::info!(
    // rust: "shader pack image {}: {set} of {total} texels set",
    // rust: self.name
    // rust: );
}

    /// Copies the image for `read` every 60 frames.
    // rust: pub(super) fn copy(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: images: &[PackImage],
    // rust: ) {
    // rust: self.frame += 1;
    // rust: if !self.frame.is_multiple_of(60) {
    // rust: return;
}
    // rust: let Some(image) = images.iter().find(|i| i.def.name == self.name) else {
    // rust: return;
}
    // rust: let Some(view) = &image.view else { return };
    // rust: let size = view.texture().size();
    // rust: let texel = image.format.block_copy_size(None).unwrap_or(4) as usize;
    // rust: let row = (size.width as usize * texel).next_multiple_of(256) as u32;
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack image dump"),
    // rust: size: u64::from(row) * u64::from(size.height) * u64::from(size.depth_or_array_layers),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: view.texture().as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(row),
    // rust: rows_per_image: Some(size.height),
    // rust: },
    // rust: },
    // rust: size,
    // rust: );
    // rust: let dims = [size.width, size.height, size.depth_or_array_layers];
    // rust: self.pending = Some((buffer, texel, dims, row));
}
}

    // rust: mod tests {
//     use super::*;

    /// A buffer the pack declares smaller than a shader's block grows to the block (40 bytes
    /// bound as a 48-byte block failed wgpu's validation, #7178); a larger one keeps its size.
pub fn a_buffer_is_at_least_its_shaders_block() void {
}
    // rust: assert_eq!(buffer_size(BufferObject::Bytes(40), [1, 1], 48), 48);
    // rust: assert_eq!(
    // rust: buffer_size(BufferObject::Bytes(40980), [1, 1], 40992),
    // rust: 40992
    // rust: );
    // rust: assert_eq!(buffer_size(BufferObject::Bytes(100), [1, 1], 48), 100);
    // rust: assert_eq!(buffer_size(BufferObject::Bytes(41), [1, 1], 0), 44);
    // rust: let per_pixel = BufferObject::PerPixel {
    // rust: bytes: 4,
    // rust: scale: [0.5, 0.5],
}
    // rust: assert_eq!(buffer_size(per_pixel, [10, 10], 64), 100);
    // rust: assert_eq!(buffer_size(per_pixel, [4, 4], 64), 64);
}
}
