//! Transpiled from Horizon Rust crate
package horizon_client_render_optical_flow

import "core:fmt"
import "core:mem"
import "core:math"

// This file is part of the FidelityFX SDK.
//
// Copyright (C) 2024 Advanced Micro Devices, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// FSR 3.1's optical flow (AMD FidelityFX SDK 1.1.4, `ffx_opticalflow*`, MIT), ported to
// WGSL (`optical_flow.wgsl`): block motion between the previous frame's colour and this
// one's, and scene change detection, for frame interpolation (`interpolation.rs`).
//
// As in `ffx_opticalflow.cpp`: luma at the display size and 6 halvings, ping-ponged
// between frames; a histogram of the luma for scene change detection; then from the
// coarsest of 7 levels down, a block search seeded by the level above, a 3x3 filter and
// a scale to the next level. The ported passes differ only where WGSL needs it: the luma
// levels are `R32Float` holding AMD's 8-bit integers, wave operations are workgroup
// atomics, and the luma pyramid is one dispatch per level instead of one for all (SPD).
// The luma textures aren't cleared on a reset (AMD's are): its first 6 frames report a
// scene change and no motion, and rewrite them.
//
// The vectors point from a block of this frame to where it was in the previous one, in
// display pixels: content moving right by 4 pixels gives (-4, 0).

// The size in pixels of the square blocks the flow has one vector for.
BLOCK_SIZE :: 8
// `OpticalFlowMaxPyramidLevels`: the search's levels.
LEVELS :: 7
// `HistogramBins * HistogramsPerDim²`: the scene change histograms.
HISTOGRAM_WIDTH :: 256 * 9

// `optical_flow.wgsl`'s `Params`.
Params :: struct {
    display: [i32,
    level: u32,
    level_count: u32,
    frame_index: u32,
    transfer_function: u32,
    min_max_luminance: [f32,
}

Pipelines :: struct {
    prepare_luma: wgpu::ComputePipeline,
    luma_pyramid: wgpu::ComputePipeline,
    scd_histogram: wgpu::ComputePipeline,
    scd_divergence: wgpu::ComputePipeline,
    scd_finalize: wgpu::ComputePipeline,
    search: wgpu::ComputePipeline,
    filter: wgpu::ComputePipeline,
    scale: wgpu::ComputePipeline,
}

// One frame parity's bindings: which luma pyramid is this frame's.
Frame :: struct {
    // This frame's luma at the display size, where `prepare_luma` writes.
    luma0: wgpu::TextureView,
    luma_pyramid: [wgpu::BindGroup,
    scd_histogram: wgpu::BindGroup,
    search: [wgpu::BindGroup,
    scale: [wgpu::BindGroup,
}

OpticalFlow :: struct {
    display: [u32,
    pipelines: Pipelines,
    // One per level, the level's constants (the passes outside the search use level 0's).
    params: [dynamic]wgpu::Buffer,
    // The bindings of the frames whose luma lands in pyramid 0, and in pyramid 1.
    frames: [Frame,
    filter: [wgpu::BindGroup,
    scd_divergence: wgpu::BindGroup,
    scd_finalize: wgpu::BindGroup,
    scd_histogram: wgpu::Buffer,
    scd_previous_histogram: wgpu::Buffer,
    scd_temp: wgpu::Buffer,
    scd_output: wgpu::Buffer,
    vectors: wgpu::TextureView,
    flow_sizes: [[u32,
    // `resourceFrameIndex` and `frameIndex`.
    resource_frame: u32,
    frame_index: u32,
    first: bool,
}

    // rust: fn texture(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: [u32; 2],
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> wgpu::TextureView {
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::STORAGE_BINDING
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}

buffer :: proc(device: ^wgpu::Device, label: string, size: u64) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage: wgpu::BufferUsages::STORAGE
    // rust: | wgpu::BufferUsages::COPY_DST
    // rust: | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: })
}

// Bind `entries` (binding number, resource) for `pipeline`'s own layout.
    // rust: fn bind(
    // rust: device: &wgpu::Device,
    // rust: pipeline: &wgpu::ComputePipeline,
    // rust: entries: &[(u32, wgpu::BindingResource)],
    // rust: ) -> wgpu::BindGroup {
    // rust: let entries: Vec<_> = entries
    // rust: .iter()
    // rust: .map(|(binding, resource)| wgpu::BindGroupEntry {
    // rust: binding: *binding,
    // rust: resource: resource.clone(),
    // rust: })
    // rust: .collect();
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Optical flow"),
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &entries,
    // rust: })
}

view :: proc(v: ^wgpu::TextureView) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindingResource::TextureView(v)
}

whole :: proc(b: ^wgpu::Buffer) -> w {
    // Ported from Horizon
    return {}
}
    // rust: b.as_entire_binding()
}

    // rust: impl OpticalFlow {
    // For frames of `display` size.
new :: proc(device: ^wgpu::Device, display: [u32; 2]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Optical flow"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("optical_flow.wgsl").into()),
    // rust: });
    // rust: let pipeline = |entry: &str| {
    // rust: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some(entry),
    // rust: layout: None,
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: })
}
    // rust: let pipelines = Pipelines {
    // rust: prepare_luma: pipeline("prepare_luma"),
    // rust: luma_pyramid: pipeline("luma_pyramid"),
    // rust: scd_histogram: pipeline("scd_histogram_pass"),
    // rust: scd_divergence: pipeline("scd_divergence_pass"),
    // rust: scd_finalize: pipeline("scd_finalize_pass"),
    // rust: search: pipeline("search_pass"),
    // rust: filter: pipeline("filter_flow"),
    // rust: scale: pipeline("scale_pass"),
}
    // rust: let params: Vec<_> = (0..LEVELS)
    // rust: .map(|_| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Optical flow constants"),
    // rust: size: std::mem::size_of::<Params>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let luma: [Vec<wgpu::TextureView>; 2] = [0, 1].map(|_| {
    // rust: (0..LEVELS)
    // rust: .map(|k| {
    // rust: let size = display.map(|v| (v >> k).max(1));
    // rust: texture(
    // rust: device,
    // rust: "Optical flow luma",
    // rust: size,
    // rust: wgpu::TextureFormat::R32Float,
    // rust: )
    // rust: })
    // rust: .collect()
    // rust: });
    // rust: let mut flow_sizes = [[0; 2]; LEVELS];
    // rust: flow_sizes[0] = display.map(|v| v.div_ceil(BLOCK_SIZE));
    // rust: for l in 1..LEVELS {
    // rust: flow_sizes[l] = flow_sizes[l - 1].map(|v| v.div_ceil(2));
}
    // rust: let flow = |label| -> Vec<wgpu::TextureView> {
    // rust: flow_sizes
    // rust: .iter()
    // rust: .map(|&size| texture(device, label, size, wgpu::TextureFormat::Rg32Sint))
    // rust: .collect()
}
        // Per level: the scaled prediction from the level above, the search's vectors and
        // the filtered ones (level 0's are the output).
    // rust: let (predicted, searched, filtered) = (
    // rust: flow("Optical flow prediction"),
    // rust: flow("Optical flow search"),
    // rust: flow("Optical flow"),
    // rust: );
    // rust: let scd_histogram = buffer(device, "Scene change histogram", HISTOGRAM_WIDTH * 4);
    // rust: let scd_previous_histogram = buffer(
    // rust: device,
    // rust: "Scene change previous histogram",
    // rust: HISTOGRAM_WIDTH * 4,
    // rust: );
    // rust: let scd_temp = buffer(device, "Scene change temp", 12);
    // rust: let scd_next_histogram = buffer(device, "Next scene change histogram", HISTOGRAM_WIDTH * 4);
    // rust: let scd_output = buffer(device, "Scene change detection", 12);
    // rust: let frame = |current: usize| {
    // rust: let (cur, prev) = (&luma[current], &luma[1 - current]);
    // rust: Frame {
    // rust: luma0: cur[0].clone(),
    // rust: luma_pyramid: std::array::from_fn(|k| {
    // rust: bind(
    // rust: device,
    // rust: &pipelines.luma_pyramid,
    // rust: &[(2, view(&cur[k + 1])), (3, view(&cur[k]))],
    // rust: )
    // rust: }),
    // rust: scd_histogram: bind(
    // rust: device,
    // rust: &pipelines.scd_histogram,
    // rust: &[
    // rust: (0, whole(&params[0])),
    // rust: (3, view(&cur[0])),
    // rust: (7, whole(&scd_histogram)),
    // rust: ],
    // rust: ),
    // rust: search: std::array::from_fn(|l| {
    // rust: bind(
    // rust: device,
    // rust: &pipelines.search,
    // rust: &[
    // rust: (0, whole(&params[l])),
    // rust: (3, view(&cur[l])),
    // rust: (4, view(&prev[l])),
    // rust: (5, view(&predicted[l])),
    // rust: (6, view(&searched[l])),
    // rust: (10, whole(&scd_output)),
    // rust: ],
    // rust: )
    // rust: }),
    // rust: scale: std::array::from_fn(|i| {
    // rust: let l = i + 1;
    // rust: bind(
    // rust: device,
    // rust: &pipelines.scale,
    // rust: &[
    // rust: (0, whole(&params[l])),
    // rust: (3, view(&cur[l])),
    // rust: (4, view(&prev[l])),
    // rust: (5, view(&filtered[l])),
    // rust: (6, view(&predicted[l - 1])),
    // rust: (10, whole(&scd_output)),
    // rust: ],
    // rust: )
    // rust: }),
}
}
    // rust: let frames = [frame(0), frame(1)];
    // rust: let filter = std::array::from_fn(|l| {
    // rust: bind(
    // rust: device,
    // rust: &pipelines.filter,
    // rust: &[(5, view(&searched[l])), (6, view(&filtered[l]))],
    // rust: )
    // rust: });
    // rust: let scd_divergence = bind(
    // rust: device,
    // rust: &pipelines.scd_divergence,
    // rust: &[
    // rust: (7, whole(&scd_histogram)),
    // rust: (8, whole(&scd_previous_histogram)),
    // rust: (9, whole(&scd_temp)),
    // rust: (11, whole(&scd_next_histogram)),
    // rust: ],
    // rust: );
    // rust: let scd_finalize = bind(
    // rust: device,
    // rust: &pipelines.scd_finalize,
    // rust: &[
    // rust: (7, whole(&scd_histogram)),
    // rust: (8, whole(&scd_previous_histogram)),
    // rust: (9, whole(&scd_temp)),
    // rust: (10, whole(&scd_output)),
    // rust: (11, whole(&scd_next_histogram)),
    // rust: ],
    // rust: );
    // rust: Self {
    // rust: display,
    // rust: pipelines,
    // rust: params,
    // rust: frames,
    // rust: filter,
    // rust: scd_divergence,
    // rust: scd_finalize,
    // rust: scd_histogram,
    // rust: scd_previous_histogram,
    // rust: scd_temp,
    // rust: scd_output,
    // rust: vectors: filtered[0].clone(),
    // rust: flow_sizes,
    // rust: resource_frame: 0,
    // rust: frame_index: 0,
    // rust: first: true,
}
}

    // The flow from the previous call's `color` to this one's. `color`: `display` size,
    // a float texture holding Horizon's frame (gamma-encoded RGB, the swapchain's
    // values: AMD's SDR back buffer). `reset`: the previous frame is unrelated (first
    // frame, resize, teleport).
    // rust: pub fn dispatch(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: color: &wgpu::TextureView,
    // rust: reset: bool,
    // rust: ) {
    // rust: let reset = reset || self.first;
    // rust: self.first = false;
    // rust: self.frame_index = if reset { 0 } else { self.frame_index + 1 };
    // rust: if reset {
    // rust: for b in [
    // rust: &self.scd_temp,
    // rust: &self.scd_output,
    // rust: &self.scd_histogram,
    // rust: &self.scd_previous_histogram,
    // rust: ] {
    // rust: encoder.clear_buffer(b, 0, None);
}
}
    // rust: for (level, buffer) in self.params.iter().enumerate() {
    // rust: let params = Params {
    // rust: display: self.display.map(|v| v as i32),
    // rust: level: level as u32,
    // rust: level_count: LEVELS as u32,
    // rust: frame_index: self.frame_index,
    // rust: transfer_function: 0,
    // rust: min_max_luminance: [0.0, 1.0],
}
    // rust: queue.write_buffer(buffer, 0, bytemuck::bytes_of(&params));
}
    // rust: let frame = &self.frames[(self.resource_frame & 1) as usize];
    // rust: let prepare = bind(
    // rust: device,
    // rust: &self.pipelines.prepare_luma,
    // rust: &[
    // rust: (0, whole(&self.params[0])),
    // rust: (1, view(color)),
    // rust: (2, view(&frame.luma0)),
    // rust: ],
    // rust: );
    // rust: let p = &self.pipelines;
    // rust: let [w, h] = self.display;
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Optical flow"),
    // rust: timestamp_writes: None,
    // rust: });
    // rust: let mut run = |pipeline: &wgpu::ComputePipeline, group: &wgpu::BindGroup, x, y, z| {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.dispatch_workgroups(x, y, z);
}
    // rust: run(
    // rust: &p.prepare_luma,
    // rust: &prepare,
    // rust: (w.div_ceil(2)).div_ceil(16),
    // rust: (h.div_ceil(2)).div_ceil(16),
    // rust: 1,
    // rust: );
    // rust: for (k, group) in frame.luma_pyramid.iter().enumerate() {
    // rust: let size = self.display.map(|v| (v >> (k + 1)).max(1));
    // rust: run(
    // rust: &p.luma_pyramid,
    // rust: group,
    // rust: size[0].div_ceil(8),
    // rust: size[1].div_ceil(8),
    // rust: 1,
    // rust: );
}
    // rust: run(
    // rust: &p.scd_histogram,
    // rust: &frame.scd_histogram,
    // rust: ((w / 4) / 3).div_ceil(32),
    // rust: 16,
    // rust: 9,
    // rust: );
    // rust: run(&p.scd_divergence, &self.scd_divergence, 9, 3, 1);
    // rust: run(&p.scd_finalize, &self.scd_finalize, 9, 1, 1);
    // rust: for level in (0..LEVELS).rev() {
    // rust: let luma = self.display.map(|v| (v >> level).max(1));
    // rust: run(
    // rust: &p.search,
    // rust: &frame.search[level],
    // rust: (luma[0].div_ceil(4) * 16).div_ceil(64),
    // rust: luma[1].div_ceil(16),
    // rust: 1,
    // rust: );
    // rust: let size = self.flow_sizes[level];
    // rust: run(
    // rust: &p.filter,
    // rust: &self.filter[level],
    // rust: size[0].div_ceil(16),
    // rust: size[1].div_ceil(4),
    // rust: 1,
    // rust: );
    // rust: if level > 0 {
    // rust: let next = self.flow_sizes[level - 1];
    // rust: run(
    // rust: &p.scale,
    // rust: &frame.scale[level - 1],
    // rust: next[0].div_ceil(4),
    // rust: next[1].div_ceil(4),
    // rust: 1,
    // rust: );
}
}
    // rust: drop(pass);
    // rust: self.resource_frame = (self.resource_frame + 1) % 16;
}

    // This frame's vectors, one per `BLOCK_SIZE` block: `Rg32Sint`, the display size
    // over `BLOCK_SIZE` rounded up,
    // holding the values FSR's `R16G16_SINT` optical flow vector texture holds.
vectors :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.vectors
}

    // FSR's scene change detection texture (`R32_UINT`, 3 texels) as a storage
    // buffer of 3 `u32`: element `i` holds texel `i`'s value.
scene_change :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.scd_output
}
}

    // rust: pub(super) mod tests {
//     use super::*;

shader_validates :: proc() {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("optical_flow.wgsl")).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::empty(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}

    // A device with WebGPU's default limits (what every GPU wgpu runs on has), or `None`
    // without a GPU.
device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

    // Noise in 4x4 pixel cells, moved by `shift` pixels: what was at `p` is at `p + shift`.
    // A `seed` of 100 or more gives cells of one primary each.
pattern :: proc(size: [u32; 2], seed: u32, shift: [i32; 2]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut pixels = Vec::with_capacity((size[0] * size[1] * 4) as usize);
    // rust: for y in 0..size[1] as i32 {
    // rust: for x in 0..size[0] as i32 {
    // rust: let (cx, cy) = ((x - shift[0]).div_euclid(4), (y - shift[1]).div_euclid(4));
    // rust: let mut h = (cx as u32).wrapping_mul(0x9e37_79b9)
    // rust: ^ (cy as u32).wrapping_mul(0x85eb_ca6b)
    // rust: ^ seed.wrapping_mul(0xc2b2_ae35);
    // rust: h ^= h >> 15;
    // rust: h = h.wrapping_mul(0x2c1b_3c6d);
    // rust: h ^= h >> 12;
    // rust: let v = (h & 0xff) as u8;
    // rust: if seed >= 100 {
                    // Primaries: no two neighbours' colours point the same way.
    // rust: let mut c = [0, 0, 0, 255];
    // rust: c[(h >> 8) as usize % 3] = 128 + v / 2;
    // rust: pixels.extend_from_slice(&c);
    // rust: } else {
    // rust: pixels.extend_from_slice(&[v, v.wrapping_add(40), v / 2, 255]);
}
}
}
    // rust: pixels
}

    // rust: pub fn upload(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: size: [u32; 2],
    // rust: pixels: &[u8],
    // rust: ) -> wgpu::TextureView {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: queue.write_texture(
    // rust: texture.as_image_copy(),
    // rust: pixels,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(size[0] * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: texture.size(),
    // rust: );
    // rust: texture.create_view(&Default::default())
}

    // `texture`'s texels (`texel` bytes each), row by row.
    // rust: pub fn read(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: texture: &wgpu::Texture,
    // rust: texel: u32,
    // rust: ) -> Vec<u8> {
    // rust: let size = texture.size();
    // rust: let row = (size.width * texel).next_multiple_of(256);
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(row * size.height),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_texture_to_buffer(
    // rust: texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(row),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: size,
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let mapped = buffer.slice(..).get_mapped_range().unwrap();
    // rust: mapped
    // rust: .chunks(row as usize)
    // rust: .flat_map(|r| r[..(size.width * texel) as usize].to_vec())
    // rust: .collect()
}

    // rust: fn run(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: flow: &mut OpticalFlow,
    // rust: color: &wgpu::TextureView,
    // rust: reset: bool,
    // rust: ) {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: flow.dispatch(device, queue, &mut encoder, color, reset);
    // rust: queue.submit([encoder.finish()]);
}

vectors :: proc(device: ^wgpu::Device, queue: ^wgpu::Queue, flow: ^OpticalFlow) -> V {
    // Ported from Horizon
    return {}
}
    // rust: read(device, queue, flow.vectors.texture(), 8)
    // rust: .chunks(8)
    // rust: .map(|c| {
    // rust: [
    // rust: i32::from_le_bytes(c[0..4].try_into().unwrap()),
    // rust: i32::from_le_bytes(c[4..8].try_into().unwrap()),
    // rust: ]
    // rust: })
    // rust: .collect()
}

scd :: proc(device: ^wgpu::Device, queue: ^wgpu::Queue, flow: ^OpticalFlow) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 12,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_buffer_to_buffer(flow.scene_change(), 0, &buffer, 0, 12);
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let bytes = buffer.slice(..).get_mapped_range().unwrap().to_vec();
    // rust: u32::from_le_bytes(bytes[4..8].try_into().unwrap())
}

    // A frame moved right by 16 and down by 8: the blocks inside report where they were
    // (-16, -8), and nothing reads as a scene change. A much darker frame then does.
finds_a_shift_and_a_scene_change :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let size = [512, 288];
    // rust: let still = upload(&device, &queue, size, &pattern(size, 1, [0, 0]));
    // rust: let moved = upload(&device, &queue, size, &pattern(size, 1, [16, 8]));
        // Scene changes are told by the luma's histogram: a much darker frame.
    // rust: let dark: Vec<u8> = pattern(size, 2, [0, 0]).iter().map(|v| v / 5).collect();
    // rust: let other = upload(&device, &queue, size, &dark);
    // rust: let mut flow = OpticalFlow::new(&device, size);
        // The first 6 frames after a reset are scene changes.
    // rust: run(&device, &queue, &mut flow, &still, true);
    // rust: for _ in 0..6 {
    // rust: run(&device, &queue, &mut flow, &still, false);
}
    // rust: run(&device, &queue, &mut flow, &moved, false);
    // rust: let [w, h] = flow.flow_sizes[0];
    // rust: let found = vectors(&device, &queue, &flow);
    // rust: let inside: Vec<_> = (4..h - 4)
    // rust: .flat_map(|y| (4..w - 4).map(move |x| (x, y)))
    // rust: .map(|(x, y)| found[(y * w + x) as usize])
    // rust: .collect();
    // rust: let right = inside.iter().filter(|v| **v == [-16, -8]).count();
    // rust: assert!(
    // rust: right * 10 >= inside.len() * 9,
    // rust: "{right} of {} blocks: {:?}",
    // rust: inside.len(),
    // rust: &inside[..8]
    // rust: );
    // rust: assert_eq!(scd(&device, &queue, &flow) & 0xf, 0);
    // rust: run(&device, &queue, &mut flow, &other, false);
    // rust: assert_eq!(scd(&device, &queue, &flow) & 1, 1);
    // rust: assert!(vectors(&device, &queue, &flow).iter().all(|v| *v == [0, 0]));
}

repeated_cuts_and_stable_frames_update_the_history :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let size = [384, 216];
    // rust: let bright = upload(
    // rust: &device,
    // rust: &queue,
    // rust: size,
    // rust: &vec![255; (size[0] * size[1] * 4) as usize],
    // rust: );
    // rust: let dark_pixels: Vec<u8> = (0..size[0] * size[1])
    // rust: .flat_map(|_| [0, 0, 0, 255])
    // rust: .collect();
    // rust: let dark = upload(&device, &queue, size, &dark_pixels);
    // rust: let mut flow = OpticalFlow::new(&device, size);
    // rust: run(&device, &queue, &mut flow, &bright, true);
    // rust: for _ in 0..6 {
    // rust: run(&device, &queue, &mut flow, &bright, false);
}
    // rust: for frame in 0..16 {
    // rust: let color = if frame % 2 == 0 { &dark } else { &bright };
    // rust: run(&device, &queue, &mut flow, color, false);
    // rust: assert_eq!(scd(&device, &queue, &flow) & 1, 1, "cut {frame}");
    // rust: assert!(vectors(&device, &queue, &flow).iter().all(|v| *v == [0, 0]));
    // rust: run(&device, &queue, &mut flow, color, false);
    // rust: assert_eq!(scd(&device, &queue, &flow) & 1, 0, "stable frame {frame}");
}
}
}
