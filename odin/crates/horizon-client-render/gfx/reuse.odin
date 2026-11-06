//! Transpiled from Horizon Rust crate
package horizon_client_render_reuse

import "core:fmt"
import "core:mem"
import "core:math"

// Pipelines kept between the renderers built on one device. The start builds
// three (the boot screen's, the title artwork's, the world's) and a resource
// reload or a graphics option builds another; each compiled every shader
// module and pipeline again, though most come out identical (the boot and
// title renderers' entirely, the world's entity pipelines). On a driver that
// compiles slowly (a cold shader cache, llvmpipe, a weak CPU) that was seconds
// of the main thread before the title showed.
//
// An object is kept under its descriptor's `Debug` text: wgpu prints the
// labels, sources, constants, formats and states, and the handles a descriptor
// names (shader modules, layouts) by their ids, so a descriptor that names a
// kept handle matches only the same handle. Kept objects stay alive, so their
// ids are never reused while they are keys.
// use std::{
    // rust: collections::HashMap,
    // rust: sync::{Mutex, PoisonError},
}

// One map of kept objects with the generation each was last asked for in.
Kept :: struct {
    map: Mutex<HashMap<string,
}
    // rust: impl<T> Default for Kept<T> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: map: Mutex::new(HashMap::new()),
}
}
}
    // rust: impl<T: Clone> Kept<T> {
    // The object kept under `key`, else `make`'s, kept. The lock is not
    // held while `make` compiles.
get :: proc(self: ^Self, key: string, generation: u32, make: impl FnOnce() -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Some((object, used)) = self
    // rust: .map
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .get_mut(&key)
    // rust: {
    // rust: *used = generation;
    // rust: return object.clone();
}
    // rust: let object = make();
    // rust: self.map
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .insert(key, (object.clone(), generation));
    // rust: object
}
keep_only :: proc(self: ^Self, generation: u32) {
}
    // rust: self.map
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .retain(|_, (_, used)| *used == generation);
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.map
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .len()
}
}

// The shader modules, layouts and pipelines of the device's renderers.
Reuse :: struct {
    generation: std::sync::atomic::AtomicU32,
    shaders: Kept<wgpu::ShaderModule>,
    bind_group_layouts: Kept<wgpu::BindGroupLayout>,
    pipeline_layouts: Kept<wgpu::PipelineLayout>,
    render: Kept<wgpu::RenderPipeline>,
}

    // rust: impl Reuse {
    // A renderer starts building: what it asks for is kept, the rest is let
    // go by [`Reuse::finish`].
begin :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.generation
    // rust: .fetch_add(1, std::sync::atomic::Ordering::Relaxed)
    // rust: .wrapping_add(1)
}
    // The renderer of `generation` is built: objects only older renderers
    // used are dropped here (the renderers still alive hold their own).
finish :: proc(self: ^Self, generation: u32) {
}
    // rust: self.shaders.keep_only(generation);
    // rust: self.bind_group_layouts.keep_only(generation);
    // rust: self.pipeline_layouts.keep_only(generation);
    // rust: self.render.keep_only(generation);
}
    // How many objects are kept.
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.shaders.len()
    // rust: + self.bind_group_layouts.len()
    // rust: + self.pipeline_layouts.len()
    // rust: + self.render.len()
}
current :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.generation.load(std::sync::atomic::Ordering::Relaxed)
}
    // `device`'s `create_*` calls through this cache.
    // rust: pub fn on<'a>(&'a self, device: &'a wgpu::Device) -> On<'a> {
    // rust: On {
    // rust: reuse: self,
    // rust: device,
    // rust: generation: self.current(),
}
}
}

// A device whose shader modules, layouts and render pipelines come from a
// [`Reuse`] when one with the same descriptor is kept.
On :: struct {
    reuse: ^'a Reuse,
    device: ^'a wgpu::Device,
    generation: u32,
}
    // rust: impl On<'_> {
    // rust: pub fn create_shader_module(
    // rust: &self,
    // rust: descriptor: wgpu::ShaderModuleDescriptor<'_>,
    // rust: ) -> wgpu::ShaderModule {
    // rust: let key = format!("{descriptor:?}");
    // rust: self.reuse.shaders.get(key, self.generation, || {
    // rust: self.device.create_shader_module(descriptor)
    // rust: })
}
    // rust: pub fn create_bind_group_layout(
    // rust: &self,
    // rust: descriptor: &wgpu::BindGroupLayoutDescriptor<'_>,
    // rust: ) -> wgpu::BindGroupLayout {
    // rust: let key = format!("{descriptor:?}");
    // rust: self.reuse.bind_group_layouts.get(key, self.generation, || {
    // rust: self.device.create_bind_group_layout(descriptor)
    // rust: })
}
    // rust: pub fn create_pipeline_layout(
    // rust: &self,
    // rust: descriptor: &wgpu::PipelineLayoutDescriptor<'_>,
    // rust: ) -> wgpu::PipelineLayout {
    // rust: let key = format!("{descriptor:?}");
    // rust: self.reuse.pipeline_layouts.get(key, self.generation, || {
    // rust: self.device.create_pipeline_layout(descriptor)
    // rust: })
}
    // rust: pub fn create_render_pipeline(
    // rust: &self,
    // rust: descriptor: &wgpu::RenderPipelineDescriptor<'_>,
    // rust: ) -> wgpu::RenderPipeline {
    // rust: let key = format!("{descriptor:?}");
    // rust: self.reuse.render.get(key, self.generation, || {
    // rust: self.device.create_render_pipeline(descriptor)
    // rust: })
}
}

    // rust: mod tests {
//     use super::Kept;

    // A key asked for again gets the kept object without making one; what
    // the latest generation did not ask for is let go when it finishes.
kept_objects_are_shared_until_a_build_stops_asking :: proc() {
}
    // rust: let kept = Kept::<u32>::default();
    // rust: let made = std::cell::Cell::new(0);
    // rust: let make = |value| {
    // rust: made.set(made.get() + 1);
    // rust: value
}
    // rust: assert_eq!(kept.get("a".into(), 1, || make(10)), 10);
    // rust: assert_eq!(kept.get("b".into(), 1, || make(20)), 20);
    // rust: kept.keep_only(1);
    // rust: assert_eq!(kept.len(), 2);
        // The next build asks for "a" only.
    // rust: assert_eq!(kept.get("a".into(), 2, || make(11)), 10);
    // rust: kept.keep_only(2);
    // rust: assert_eq!(kept.len(), 1);
    // rust: assert_eq!(kept.get("b".into(), 3, || make(21)), 21);
    // rust: assert_eq!(made.get(), 3);
}
}
