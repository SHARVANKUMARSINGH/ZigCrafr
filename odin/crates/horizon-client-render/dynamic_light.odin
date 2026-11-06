//! Transpiled from Horizon Rust crate
package horizon_client_render_dynamic_light

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon Extras' dynamic lights (docs/extras.md): a torch, lantern or other light source held by
// a player or mob, dropped as an item, or an entity on fire lights the blocks and entities
// around it. Not in vanilla; off by default.
//
// Client-only and at render time: the light engine, chunk meshes and saves never see it. Each
// frame the game picks the [`MAX`] sources nearest the camera; terrain.wgsl and entity.wgsl
// raise a vertex's block light to `level - distance` (one level per block, as block light falls
// off) when that is brighter. Off, the list is empty and the shaders skip the loop.
// use crate::blocks::BlockFacts;
// use glam::DVec3;
// use horizon_world::registry::BlockRegistry;
// use std::collections::HashMap;

// Lights the shaders read: `Globals.dynamic_lights` in gfx.rs, terrain.wgsl and entity.wgsl.
MAX :: 16
// Camera-relative position and radius; RGB intensity in a second vec4. The shaders read it as a flat
// `array<vec4<f32>, 32>` (nested arrays need ARB_arrays_of_arrays, absent from GL below 4.3).
    // rust: pub type Colored = [[f32; 4]; 2];

// Nearest validated native visual lights; never enters gameplay lighting.
    // rust: pub fn select_colored(
    // rust: sources: impl Iterator<Item = ([f64; 3], u32, f32, f32)>,
    // rust: camera: DVec3,
    // rust: ) -> Vec<Colored> {
    // rust: let mut nearest: Vec<_> = sources.collect();
    // rust: nearest.sort_by(|a, b| {
    // rust: (DVec3::from(a.0) - camera)
    // rust: .length_squared()
    // rust: .total_cmp(&(DVec3::from(b.0) - camera).length_squared())
    // rust: });
    // rust: nearest
    // rust: .into_iter()
    // rust: .take(MAX)
    // rust: .map(|(at, rgb, radius, intensity)| {
    // rust: let at = (DVec3::from(at) - camera).as_vec3();
    // rust: [
    // rust: [at.x, at.y, at.z, radius],
    // rust: [
    // rust: ((rgb >> 16) & 255) as f32 / 255.0,
    // rust: ((rgb >> 8) & 255) as f32 / 255.0,
    // rust: (rgb & 255) as f32 / 255.0,
    // rust: intensity,
    // rust: ],
    // rust: ]
    // rust: })
    // rust: .collect()
}
// What an entity on fire gives off, as a lit campfire or fire block does.
BURNING :: 15
// Sources farther than this from the camera light nothing it can see well.
REACH :: 96.0

// How brightly each item glows when held or dropped.
Luminance :: struct {

    // rust: impl Luminance {
    // A block item glows like its block's default state (`getLightEmission`): torches 14,
    // lanterns and glowstone 15, a lit redstone torch 7; a furnace's item, unlit, not at all.
new :: proc(facts: ^BlockFacts, registry: ^BlockRegistry) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut map = HashMap::new();
    // rust: for (id, state) in facts.states.iter().enumerate() {
    // rust: if state.emission == 0 || *state.item != *state.name {
    // rust: continue;
}
    // rust: if registry.default_state(&state.name).map(|d| d.0 as usize) == Some(id) {
    // rust: map.insert(state.item.to_string(), state.emission);
}
}
        // A bucket of lava glows as lava does.
    // rust: map.insert("minecraft:lava_bucket".into(), 15);
    // rust: Self(map)
}

of :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.get(item).copied().unwrap_or(0)
}

    // The HDR tier of an item that glows, as its block's (`mesher::hdr_tier`), 0 for the rest.
hdr_tier :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let name = item.strip_prefix("minecraft:").unwrap_or(item);
    // rust: crate::mesher::hdr_tier(name, self.of(item)) & !crate::mesher::WHOLE
}

from_pairs :: proc(pairs: ^[(string) {
}
    // rust: Self(pairs.iter().map(|(k, v)| (k.to_string(), *v)).collect())
}
}

// One light this frame: where it is (world space) and its level, 1 to 15.
Source :: struct {
    at: DVec3,
    level: u8,
}

// The [`MAX`] sources nearest `camera` within reach, as the shaders read them: camera-relative
// position and level. Overwrites `out`.
select :: proc(sources: ^[Source], camera: DVec3, out: ^[dynamic][f32; 4]) {
}
    // rust: out.clear();
    // rust: let key = |s: &Source| s.at.distance_squared(camera);
    // rust: let mut near: Vec<&Source> = sources
    // rust: .iter()
    // rust: .filter(|s| s.level > 0 && key(s) <= REACH * REACH)
    // rust: .collect();
    // rust: near.sort_by(|a, b| key(a).total_cmp(&key(b)));
    // rust: out.extend(near.into_iter().take(MAX).map(|s| {
    // rust: let p = (s.at - camera).as_vec3();
    // rust: [p.x, p.y, p.z, f32::from(s.level.min(15))]
    // rust: }));
}

// The block light a vertex at `pos` (camera-relative) gets from `lights`, 0 to 15: the WGSL
// `dynamic_block_light` in Rust, for tests.
level_at :: proc(pos: [f32; 3], lights: ^[[f32; 4]]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: lights.iter().fold(0.0f32, |level, l| {
    // rust: let d =
    // rust: ((pos[0] - l[0]).powi(2) + (pos[1] - l[1]).powi(2) + (pos[2] - l[2]).powi(2)).sqrt();
    // rust: level.max(l[3] - d)
    // rust: })
}

    // rust: mod tests {
//     use super::*;

items_shine_as_their_blocks :: proc() {
}
//         use crate::mesher::{BRIGHT, INCANDESCENT};
    // rust: let lum = Luminance::from_pairs(&[
    // rust: ("minecraft:torch", 14),
    // rust: ("minecraft:glowstone", 15),
    // rust: ("minecraft:lava_bucket", 15),
    // rust: ("minecraft:campfire", 15),
    // rust: ]);
    // rust: assert_eq!(lum.hdr_tier("minecraft:torch"), INCANDESCENT);
    // rust: assert_eq!(lum.hdr_tier("minecraft:glowstone"), BRIGHT);
    // rust: assert_eq!(lum.hdr_tier("minecraft:lava_bucket"), INCANDESCENT);
        // Items carry no sprite thresholds: only the tier, not "all over".
    // rust: assert_eq!(lum.hdr_tier("minecraft:campfire"), BRIGHT);
    // rust: assert_eq!(lum.hdr_tier("minecraft:apple"), 0);
}

colored_sources_are_camera_relative_and_bounded :: proc() {
}
    // rust: let lights = select_colored(
    // rust: (0..20).map(|x| ([x as f64, 64.0, 0.0], 0xff8040, 5.0, 0.5)),
    // rust: DVec3::new(2.0, 64.0, 0.0),
    // rust: );
    // rust: assert_eq!(lights.len(), MAX);
    // rust: assert_eq!(lights[0][0][0], 0.0);
    // rust: assert_eq!(lights[0][1], [1.0, 128.0 / 255.0, 64.0 / 255.0, 0.5]);
}

nearest_sources_win :: proc() {
}
    // rust: let camera = DVec3::new(100.0, 64.0, 100.0);
    // rust: let mut sources: Vec<Source> = (0..40)
    // rust: .map(|i| Source {
    // rust: at: camera + DVec3::new(f64::from(i), 0.0, 0.0),
    // rust: level: 14,
    // rust: })
    // rust: .collect();
    // rust: sources.push(Source {
    // rust: at: camera + DVec3::new(0.5, 0.0, 0.0),
    // rust: level: 0,
    // rust: });
    // rust: sources.push(Source {
    // rust: at: camera + DVec3::new(0.0, 0.0, 200.0),
    // rust: level: 15,
    // rust: });
    // rust: let mut out = Vec::new();
    // rust: select(&sources, camera, &mut out);
    // rust: assert_eq!(out.len(), MAX);
    // rust: assert_eq!(out[0], [0.0, 0.0, 0.0, 14.0]);
    // rust: assert_eq!(out[MAX - 1][0], (MAX - 1) as f32);
    // rust: select(&[], camera, &mut out);
    // rust: assert!(out.is_empty());
}

light_falls_off_a_level_per_block :: proc() {
}
    // rust: let torch = [[0.0, 0.0, 0.0, 14.0]];
    // rust: assert_eq!(level_at([0.0, 0.0, 0.0], &torch), 14.0);
    // rust: assert_eq!(level_at([3.0, 4.0, 0.0], &torch), 9.0);
    // rust: assert_eq!(level_at([20.0, 0.0, 0.0], &torch), 0.0);
    // rust: let two = [[0.0, 0.0, 0.0, 14.0], [10.0, 0.0, 0.0, 15.0]];
    // rust: assert_eq!(level_at([8.0, 0.0, 0.0], &two), 13.0);
    // rust: assert_eq!(level_at([0.0; 3], &[]), 0.0);
}

item_luminance :: proc() {
}
    // rust: let l = Luminance::from_pairs(&[("minecraft:torch", 14)]);
    // rust: assert_eq!(l.of("minecraft:torch"), 14);
    // rust: assert_eq!(l.of("minecraft:stone"), 0);
}
}
