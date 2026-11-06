//! Transpiled from Horizon Rust crate
package horizon_client_render_control

import "core:fmt"
import "core:mem"
import "core:math"

// Control-socket commands for inspecting rendering: place blocks without
// updates (`setblock`, `fill`) to build test scenes.
// use super::Game;
// use horizon_client::Result;
// use horizon_core::random::RandomSource;
// use horizon_world::registry::BlockStateId;
// use serde_json::{Value, json};

    // rust: pub const HELP: &[&str] = &[
    // rust: "setblock X Y Z STATE           set a block state (name[prop=value,...]) without updates",
    // rust: "fill X1 Y1 Z1 X2 Y2 Z2 STATE   fill a box with a block state without updates",
    // rust: "particle NAME X Y Z [DX DY DZ] [COUNT]  spawn particles (vanilla /particle spread)",
    // rust: "signedit X Y Z [front|back]    open the sign editor for the sign at X Y Z",
    // rust: "section-draws [flat|indirect]  how terrain sections are drawn (A/B checks); replies the mode",
    // rust: "section-cull [on|off]          occlusion culling of solid sections (A/B checks); replies the mode",
    // rust: "section-sides [on|off]         leave out solid quads facing away from the eye (A/B checks); replies the mode",
    // rust: "gpu-culling [on|off]           GPU Culling as its switch sets it, not saved (A/B checks); replies the mode",
    // rust: "render-capture on|off|DIR      keep copies of the meshes drawn (on), or write the next frame's scene to DIR for scene_replay",
    // rust: ];

    // rust: impl Game<'_> {
    // Parse `name[k=v,...]` into a registry state (defaults for missing properties).
parse_state :: proc(self: ^Self, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: parse_state(self.pack.assets.registry, text)
}
    // rust: pub(super) fn render_command(&mut self, words: &[&str]) -> Result<Option<Value>> {
    // rust: let int = |i: usize| -> Result<i32> {
    // rust: Ok(words
    // rust: .get(i)
    // rust: .ok_or_else(|| format!("missing argument {i}"))?
    // rust: .parse::<i32>()?)
}
    // rust: match words[0] {
    // rust: "setblock" => {
    // rust: let state = self.parse_state(words.get(4).ok_or("missing state")?)?;
    // rust: self.world.set(int(1)?, int(2)?, int(3)?, state)?;
    // rust: Ok(Some(json!({ "ok": true, "state": state.0 })))
}
    // rust: "fill" => {
    // rust: let state = self.parse_state(words.get(7).ok_or("missing state")?)?;
    // rust: let (a, b) = ([int(1)?, int(2)?, int(3)?], [int(4)?, int(5)?, int(6)?]);
    // rust: let mut count = 0;
    // rust: for x in a[0].min(b[0])..=a[0].max(b[0]) {
    // rust: for y in a[1].min(b[1])..=a[1].max(b[1]) {
    // rust: for z in a[2].min(b[2])..=a[2].max(b[2]) {
    // rust: self.world.set(x, y, z, state)?;
    // rust: count += 1;
}
}
}
    // rust: Ok(Some(json!({ "ok": true, "blocks": count })))
}
    // rust: "particle" => {
//                 use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let ty = ParticleType::from_name(words.get(1).ok_or("missing particle")?)
    // rust: .ok_or("unknown particle type")?;
    // rust: let num = |i: usize, default: f64| -> Result<f64> {
    // rust: Ok(words.get(i).map_or(Ok(default), |w| w.parse::<f64>())?)
}
    // rust: let at = [num(2, 0.0)?, num(3, 0.0)?, num(4, 0.0)?];
    // rust: let delta = [num(5, 0.0)?, num(6, 0.0)?, num(7, 0.0)?];
    // rust: let count = num(8, 1.0)? as u32;
    // rust: let options = match ty {
    // rust: ParticleType::Dust => ParticleOptions::dust([1.0, 0.0, 0.0], 1.0),
    // rust: ParticleType::Block
    // rust: | ParticleType::FallingDust
    // rust: | ParticleType::DustPillar
    // rust: | ParticleType::BlockMarker => {
    // rust: ParticleOptions::block(ty, "block/stone".into(), 0x808080)
}
    // rust: ParticleType::Item => self.item_particle(
    // rust: &horizon_client::items::ItemStack::new("minecraft:apple", 1),
    // rust: ),
    // rust: ParticleType::ItemSlime
    // rust: | ParticleType::ItemSnowball
    // rust: | ParticleType::ItemCobweb => {
    // rust: self.ensure_item_particle_sprites();
    // rust: ParticleOptions::simple(ty)
}
    // rust: _ => ParticleOptions::simple(ty),
}
                // ServerLevel.sendParticles: count 0 uses the delta as velocity.
    // rust: if count == 0 {
    // rust: self.particles.create(&options, at, delta);
}
    // rust: for _ in 0..count {
    // rust: let r = self.particles.random();
    // rust: let p = [
    // rust: at[0] + r.next_gaussian() * delta[0],
    // rust: at[1] + r.next_gaussian() * delta[1],
    // rust: at[2] + r.next_gaussian() * delta[2],
    // rust: ];
    // rust: self.particles.create(&options, p, [0.0; 3]);
}
    // rust: Ok(Some(json!({ "ok": true, "live": self.particles.len() })))
}
    // rust: "signedit" => {
    // rust: let key = (int(1)?, int(2)?, int(3)?);
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(key.0, key.1, key.2))
    // rust: .name
    // rust: .clone();
    // rust: let entity = self
    // rust: .new_block_entity(&name)
    // rust: .filter(|e| matches!(e, horizon_client::containers::BlockEntity::Sign(_)))
    // rust: .ok_or("no sign there")?;
    // rust: self.world.block_entities.get_or_insert_with(key, || entity);
    // rust: self.open_sign_editor(key, words.get(4) != Some(&"back"));
    // rust: Ok(Some(json!({ "ok": true })))
}
    // rust: other => Err(format!("unknown render command {other}").into()),
}
}
}

// Parse `name[k=v,...]` into a registry state (defaults for missing properties).
    // rust: pub(super) fn parse_state(
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: text: &str,
    // rust: ) -> Result<BlockStateId> {
    // rust: let (name, props) = match text.split_once('[') {
    // rust: Some((n, rest)) => (n, rest.trim_end_matches(']')),
    // rust: None => (text, ""),
}
    // rust: let name = if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let default = registry
    // rust: .default_state(&name)
    // rust: .ok_or_else(|| format!("unknown block {name}"))?;
    // rust: let mut state = registry
    // rust: .state(default)
    // rust: .ok_or("missing default state")?
    // rust: .clone();
    // rust: for pair in props.split(',').filter(|p| !p.is_empty()) {
    // rust: let (k, v) = pair
    // rust: .split_once('=')
    // rust: .ok_or_else(|| format!("bad property {pair}"))?;
    // rust: if !state.properties.contains_key(k) {
    // rust: return Err(format!("{name} has no property {k}").into());
}
    // rust: state.properties.insert(k.to_owned(), v.to_owned());
}
    // rust: Ok(registry.resolve(&state)?)
}
