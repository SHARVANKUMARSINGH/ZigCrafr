//! Transpiled from Horizon Rust crate
package horizon_client_native_visuals

import "core:fmt"
import "core:mem"
import "core:math"

// use super::Game;
// use super::native_hooks::{NativeBlockRim, NativeColoredLight};
// use horizon_client::{dynamic_light, gizmos};

// What one mod's visual requests may use of a frame, whatever other mods ask for: its first
// `RIMS_PER_MOD` rims and `LIGHTS_PER_MOD` lights are examined, and its valid rims draw at most
// `RIM_EDGES_PER_MOD` outline edges. Requests bundles' injections push share one budget.
    // rust: pub(super) const RIMS_PER_MOD: usize = 256;
    // rust: pub(super) const RIM_EDGES_PER_MOD: usize = 4096;
    // rust: pub(super) const LIGHTS_PER_MOD: usize = 8;

    // rust: fn rim_target_valid(
    // rust: loaded: bool,
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: air: horizon_world::registry::BlockStateId,
    // rust: ) -> bool {
    // rust: loaded && state != air
}

// One mod's rims within its budget: the first `RIMS_PER_MOD`, of which those `edges` accepts
// (it says how many outline edges a rim draws, None to refuse it), while they fit in
// `RIM_EDGES_PER_MOD` edges. A rim too big for what is left is skipped whole.
    // rust: fn budget_rims(
    // rust: rims: &mut Vec<NativeBlockRim>,
    // rust: edges: impl Fn(&NativeBlockRim) -> Option<usize>,
    // rust: out: &mut Vec<NativeBlockRim>,
    // rust: ) {
    // rust: let mut used = 0;
    // rust: for rim in rims.drain(..).take(RIMS_PER_MOD) {
    // rust: if let Some(n) = edges(&rim)
    // rust: && used + n <= RIM_EDGES_PER_MOD
    // rust: {
    // rust: used += n;
    // rust: out.push(rim);
}
}
}

// A rim's outline: its block's edges, placed in the world.
RimShape :: struct {
    origin: [f64,
    offset: [f64,
    // A context outline's box (light, scaffolding), whose edges are the unit cube's scaled.
    box_shape: Option<[f64,
    segments: ^'a [[f64,
}

    // rust: impl Game<'_> {
    // Moves one mod's requests (`rims`, `lights`, emptied) into the frame's, within its own
    // budget (`RIMS_PER_MOD`, `RIM_EDGES_PER_MOD`, `LIGHTS_PER_MOD`).
    // rust: pub(super) fn budget_visuals(
    // rust: &self,
    // rust: rims: &mut Vec<NativeBlockRim>,
    // rust: lights: &mut Vec<NativeColoredLight>,
    // rust: frame_rims: &mut Vec<NativeBlockRim>,
    // rust: frame_lights: &mut Vec<NativeColoredLight>,
    // rust: ) {
    // rust: let Some(player) = self.native_player() else {
    // rust: rims.clear();
    // rust: lights.clear();
    // rust: return;
}
    // rust: let player = [player.x, player.y, player.z];
    // rust: let cube = horizon_client::blocks::cube_edges();
    // rust: budget_rims(
    // rust: rims,
    // rust: |rim| self.rim_shape(rim, player, &cube).map(|s| s.segments.len()),
    // rust: frame_rims,
    // rust: );
    // rust: frame_lights.extend(
    // rust: lights
    // rust: .drain(..)
    // rust: .take(LIGHTS_PER_MOD)
    // rust: .filter(|l| self.light_valid(l, player)),
    // rust: );
}

    // The outline a rim draws, or None when it is refused: a bad width, too far from the
    // player, or not on a loaded, non-air block.
    // rust: fn rim_shape<'a>(
    // rust: &'a self,
    // rust: rim: &NativeBlockRim,
    // rust: player: [f64; 3],
    // rust: cube: &'a [[f64; 6]],
    // rust: ) -> Option<RimShape<'a>> {
    // rust: let pos = rim.pos;
    // rust: if !rim.width.is_finite()
    // rust: || !(0.5..=4.0).contains(&rim.width)
    // rust: || !close(pos.map(|v| f64::from(v) + 0.5), player)
    // rust: {
    // rust: return None;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let loaded = self
    // rust: .world
    // rust: .chunks
    // rust: .contains_key(&(pos[0].div_euclid(16), pos[2].div_euclid(16)));
    // rust: if !rim_target_valid(loaded, state, self.world.air) {
    // rust: return None;
}
    // rust: let facts = self.res.facts().get(state);
    // rust: let offset = if facts.outline_offset {
    // rust: self.pack
    // rust: .context
    // rust: .tables
    // rust: .offset(state, pos[0], pos[2])
    // rust: .unwrap_or([0.0; 3])
    // rust: } else {
    // rust: [0.0; 3]
}
    // rust: let box_shape = self.context_outline(pos, state);
    // rust: Some(RimShape {
    // rust: origin: pos.map(f64::from),
    // rust: offset,
    // rust: box_shape,
    // rust: segments: if box_shape.is_some() {
    // rust: cube
    // rust: } else {
    // rust: &facts.outline_edges
    // rust: },
    // rust: })
}

light_valid :: proc(self: ^Self, l: ^NativeColoredLight, player: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: close(l.at, player)
    // rust: && l.rgb <= 0xffffff
    // rust: && l.radius.is_finite()
    // rust: && (0.25..=16.0).contains(&l.radius)
    // rust: && l.intensity.is_finite()
    // rust: && (0.0..=1.0).contains(&l.intensity)
    // rust: && self.world.chunks.contains_key(&(
    // rust: (l.at[0].floor() as i32).div_euclid(16),
    // rust: (l.at[2].floor() as i32).div_euclid(16),
    // rust: ))
}

    // Frame-local requests never persist after a mod is removed or a world changes.
    // rust: pub(super) fn native_frame_visuals(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: lines: &mut Vec<gizmos::Line>,
    // rust: ) -> Vec<dynamic_light::Colored> {
    // rust: let mut particle_lights = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .and_then(|r| r.particle_lights())
    // rust: .map_or_else(Vec::new, |entries| {
    // rust: self.particles
    // rust: .lights(entries, self.clock.camera_fraction() as f32)
    // rust: });
        // Held and dropped items whose block the pack's `[[lights]]` colour shine in that colour,
        // as far as their dynamic light reaches.
    // rust: if let Some(renderer) = self.renderer.as_ref().filter(|r| r.has_light_colors()) {
    // rust: for (source, item) in self.dynamic_light_sources(alpha) {
    // rust: let Some(color) = item.and_then(|i| renderer.light_color(&i)) else {
    // rust: continue;
}
    // rust: let top = color[0].max(color[1]).max(color[2]);
    // rust: if source.level == 0 || top <= 0.0 {
    // rust: continue;
}
    // rust: let [r, g, b] = color.map(|c| (c / top * 255.0).round() as u32);
    // rust: particle_lights.push((
    // rust: source.at.to_array(),
    // rust: r << 16 | g << 8 | b,
    // rust: f32::from(source.level),
    // rust: 1.0,
    // rust: ));
}
}
    // rust: let Some(player) = self.native_player() else {
    // rust: return dynamic_light::select_colored(particle_lights.into_iter(), camera);
}
    // rust: let player = [player.x, player.y, player.z];
        // Already within each mod's budget (`budget_visuals`); checked again for what a
        // bundle's injection may add after it.
    // rust: let mut rims = Vec::new();
    // rust: let mut lights = Vec::new();
    // rust: self.native_visuals(&mut rims, &mut lights);
    // rust: let cube = horizon_client::blocks::cube_edges();
    // rust: for rim in &rims {
    // rust: let Some(shape) = self.rim_shape(rim, player, &cube) else {
    // rust: continue;
}
    // rust: for edge in shape.segments {
    // rust: let point = |end: usize| {
    // rust: std::array::from_fn(|i| {
    // rust: let v = edge[i + 3 * end];
    // rust: if let Some(b) = shape.box_shape {
    // rust: shape.origin[i] + b[i] + v * (b[i + 3] - b[i])
    // rust: } else {
    // rust: shape.origin[i] + shape.offset[i] + v
}
    // rust: })
}
    // rust: lines.push(gizmos::Line {
    // rust: start: point(0),
    // rust: end: point(1),
    // rust: color: rim.argb,
    // rust: width: rim.width,
    // rust: });
}
}
    // rust: let sources = lights.into_iter().filter(|l| self.light_valid(l, player));
    // rust: dynamic_light::select_colored(
    // rust: sources
    // rust: .map(|l| (l.at, l.rgb, l.radius, l.intensity))
    // rust: .chain(particle_lights),
    // rust: camera,
    // rust: )
}
}

// Within 32 blocks of the player, and finite.
close :: proc(at: [f64; 3], player: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: at.iter().all(|v| v.is_finite())
    // rust: && (at[0] - player[0]).powi(2) + (at[1] - player[1]).powi(2) + (at[2] - player[2]).powi(2)
    // rust: <= 1024.0
}

    // rust: mod tests {
//     use super::{RIM_EDGES_PER_MOD, RIMS_PER_MOD, budget_rims, rim_target_valid};
//     use crate::game::native_hooks::NativeBlockRim;
//     use horizon_world::registry::BlockStateId;

ordinary_loaded_blocks_can_have_rims :: proc() {
}
    // rust: let air = BlockStateId(0);
    // rust: let stone = BlockStateId(1); // No emission requirement.
    // rust: assert!(rim_target_valid(true, stone, air));
    // rust: assert!(!rim_target_valid(false, stone, air));
    // rust: assert!(!rim_target_valid(true, air, air));
}

rims :: proc(n: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..n)
    // rust: .map(|x| NativeBlockRim {
    // rust: pos: [x, 64, 0],
    // rust: argb: 0xFFFF_0000,
    // rust: width: 1.0,
    // rust: })
    // rust: .collect()
}

each_mod_gets_its_own_rims_and_edges :: proc() {
}
    // rust: let mut frame = Vec::new();
        // Two mods asking for 300 full cubes each: each keeps 256 of its own,
        // the second untouched by what the first used.
    // rust: for _ in 0..2 {
    // rust: let mut mine = rims(300);
    // rust: budget_rims(&mut mine, |_| Some(12), &mut frame);
    // rust: assert!(mine.is_empty());
}
    // rust: assert_eq!(frame.len(), 2 * 256);
    // rust: assert_eq!(frame[255].pos[0], 255);
    // rust: assert_eq!(frame[256].pos[0], 0);
}

a_mods_edges_are_bounded_and_refused_rims_cost_nothing :: proc() {
}
    // rust: let mut frame = Vec::new();
        // 30-edge outlines: 4096 / 30 = 136 fit; refused odd rims don't count.
    // rust: let mut mine = rims(RIMS_PER_MOD as i32);
    // rust: budget_rims(&mut mine, |r| (r.pos[0] % 2 == 0).then_some(30), &mut frame);
    // rust: assert_eq!(frame.len(), 128);
    // rust: assert!(frame.iter().all(|r| r.pos[0] % 2 == 0));
    // rust: frame.clear();
    // rust: let mut mine = rims(RIMS_PER_MOD as i32);
    // rust: budget_rims(&mut mine, |_| Some(30), &mut frame);
    // rust: assert_eq!(frame.len(), RIM_EDGES_PER_MOD / 30);
}
}
