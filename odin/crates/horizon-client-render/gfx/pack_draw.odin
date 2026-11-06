//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_draw

import "core:fmt"
import "core:mem"
import "core:math"

// The uniforms a shader pack's gbuffers programs read per draw (`HzDraw` at set 2, the
// translator's `DRAW_UNIFORMS`): one slot per render stage of a uniform buffer, picked with a
// dynamic offset at each draw.

// use horizon_shaders::{RENDER_STAGES, render_stage};

// Where a run of `Frame::entities` begins, and what it is (slice 7): the run lasts until the
// next span. Recorded only while a shader pack draws entities, so Horizon's own frames carry
// none; Horizon itself still draws the whole list at once.
EntitySpan :: struct {
    // The first vertex.
    start: u32,
    // The render stage (5.4: `ENTITIES`, `BLOCK_ENTITIES`, `PARTICLES`, `DESTROY`), which picks
    // the program.
    stage: u32,
    // `entityId` for entities, `blockEntityId` for block entities (5.3), else 0.
    id: i32,
    // An entity part that blends (a name tag, a shadow): `gbuffers_entities_translucent`.
    translucent: bool,
    // Hidden from the camera (Horizon's entity culling, the player in first person): only the
    // shadow pass draws it.
    hidden: bool,
    // The local player (`shadowPlayer`).
    player: bool,
    // A block entity whose block emits light (`shadowLightBlockEntities`).
    emissive: bool,
}

    // rust: impl EntitySpan {
    // Marks vertices `start..end` of `spans`' list (one entity) as hidden: the span covering
    // `start` is split there, the spans inside are hidden, and the geometry after `end` goes
    // on in the last span's kind. False when no span covers `start`.
hide :: proc(spans: ^[dynamic]EntitySpan, start: uint, end: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(i) = spans.iter().rposition(|s| s.start as usize <= start) else {
    // rust: return false;
}
    // rust: let after = spans[spans.len() - 1];
    // rust: if spans[i].start as usize != start {
    // rust: let split = EntitySpan {
    // rust: start: start as u32,
    // rust: ..spans[i]
}
    // rust: spans.insert(i + 1, split);
}
    // rust: for s in spans.iter_mut().skip(i) {
    // rust: if s.start as usize >= start {
    // rust: s.hidden = true;
}
}
    // rust: if end > start {
    // rust: spans.push(EntitySpan {
    // rust: start: end as u32,
    // rust: ..after
    // rust: });
}
    // rust: true
}
}

// `HzDraw`'s size: `renderStage`, `entityId`, `blockEntityId`, `currentRenderedItemId`,
// `entityColor`.
SIZE :: 32

    // rust: pub(super) struct DrawUniforms {
    // rust: pub layout: wgpu::BindGroupLayout,
    // rust: group: wgpu::BindGroup,
    // rust: stride: u32,
}

    // rust: impl DrawUniforms {
new :: proc(device: ^wgpu::Device) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let stride = SIZE.max(device.limits().min_uniform_buffer_offset_alignment);
    // rust: let mut contents = vec![0u8; stride as usize * RENDER_STAGES.len()];
    // rust: for (i, slot) in contents.chunks_mut(stride as usize).enumerate() {
    // rust: slot[..4].copy_from_slice(&(i as i32).to_le_bytes());
            // `blockEntityId` outside block entities, as Iris has it; `currentRenderedItemId`
            // outside items, as Iris 1.11.7 gives it to terrain, water and the sky (observed).
    // rust: slot[8..12].copy_from_slice(&(-1i32).to_le_bytes());
    // rust: slot[12..16].copy_from_slice(&(-1i32).to_le_bytes());
}
    // rust: let buffer = wgpu::util::DeviceExt::create_buffer_init(
    // rust: device,
    // rust: &wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Shader pack draws"),
    // rust: contents: &contents,
    // rust: usage: wgpu::BufferUsages::UNIFORM,
    // rust: },
    // rust: );
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack draws"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: true,
    // rust: min_binding_size: wgpu::BufferSize::new(u64::from(SIZE)),
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack draws"),
    // rust: layout: &layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &buffer,
    // rust: offset: 0,
    // rust: size: wgpu::BufferSize::new(u64::from(SIZE)),
    // rust: }),
    // rust: }],
    // rust: });
    // rust: Self {
    // rust: layout,
    // rust: group,
    // rust: stride,
}
}

    // Draws that follow read `renderStage` = `MC_RENDER_STAGE_<stage>`, other values zero.
bind :: proc(self: ^Self, pass: ^wgpu::RenderPass<'_>, stage: string) {
}
    // rust: pass.set_bind_group(2, &self.group, &[self.stride * render_stage(stage)]);
}
}

    // rust: mod tests {
//     use super::EntitySpan;

span :: proc(start: u32, id: i32) -> E {
    // Ported from Horizon
    return {}
}
    // rust: EntitySpan {
    // rust: start,
    // rust: id,
    // rust: ..Default::default()
}
}

hide_splits_the_span_around_one_entity :: proc() {
}
        // Two cows in one span: the second (vertices 8..16) is hidden.
    // rust: let mut spans = vec![span(0, 7)];
    // rust: assert!(EntitySpan::hide(&mut spans, 8, 16));
    // rust: let hidden = EntitySpan {
    // rust: hidden: true,
    // rust: ..span(8, 7)
}
    // rust: assert_eq!(spans, [span(0, 7), hidden, span(16, 7)]);
        // An entity with its own span and a part after it (armour) is hidden whole.
    // rust: let mut spans = vec![span(0, 1), span(4, 2), span(6, 3)];
    // rust: assert!(EntitySpan::hide(&mut spans, 4, 10));
    // rust: assert!(!spans[0].hidden && spans[1].hidden && spans[2].hidden);
    // rust: assert_eq!(spans[3], span(10, 3));
    // rust: assert!(!EntitySpan::hide(&mut Vec::new(), 0, 4));
}
}
