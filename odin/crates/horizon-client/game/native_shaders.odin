//! Transpiled from Horizon Rust crate
package horizon_client_native_shaders

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's own shader packs in the game (docs/shaders.md): the pick in `shaderpacks/` (a
// folder with `horizon-shaders.toml`, or a `.hshader`; `game/shader_packs.rs`) runs once it
// passes `horizon_shader_api::check`. The pack is looked at twice a second: a saved file (or
// saved option values) is checked and the pack rebuilt, and a
// pack that fails is refused with its problems in the chat while the last good one keeps
// drawing.

// use std::{
    // rust: hash::{Hash, Hasher},
    // rust: path::Path,
    // rust: time::{Duration, Instant},
}

// use horizon_client::text::Text;
// use horizon_shader_api::{Api, Blend, Manifest, Pack, check};

// use super::Game;

LOOK_EVERY :: Duration::from_millis(500)
RED :: 0xFF5555

    // rust: pub(super) struct NativeShaders {
    // The pack's name in `shaderpacks/`, of either kind (`game/shader_packs.rs`); empty: none.
    // rust: pub picked: String,
    // The pack's files when it was last read (`fingerprint`).
    // rust: stamp: Option<u64>,
    // rust: looked: Option<Instant>,
}

    // rust: impl NativeShaders {
picking :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: picked: name.to_owned(),
    // rust: ..Self::default()
}
}
}

    // rust: impl Game<'_> {
    // Builds the pack at `path` when its files changed since it was last read.
    // rust: pub(super) fn tick_native_shader_pack(&mut self, path: &Path) {
    // rust: let now = Instant::now();
    // rust: let state = &mut self.native_shaders;
    // rust: if state.looked.is_some_and(|t| now - t < LOOK_EVERY) {
    // rust: return;
}
    // rust: state.looked = Some(now);
    // rust: let stamp = fingerprint(path);
    // rust: if stamp == state.stamp {
    // rust: return;
}
    // rust: let reload = state.stamp.is_some();
    // rust: state.stamp = stamp;
    // rust: let Some(renderer) = &mut self.renderer else {
    // rust: return;
}
    // rust: let result = Pack::read(path).map_err(|e| vec![e]).and_then(|pack| {
    // rust: if let Some(why) = not_drawn(&pack.manifest) {
    // rust: return Err(vec![why]);
}
    // rust: let report = check(&pack)
    // rust: .map_err(|p| p.iter().map(ToString::to_string).collect::<Vec<String>>())?;
            // The player's values (the pack's Shader Options page), else the defaults.
    // rust: let options = &pack.manifest.options;
    // rust: let values = horizon_client::shader_pack_list::load_values(path, options);
    // rust: let constants = options.iter().map(|o| o.id.clone()).zip(values).collect();
    // rust: let sprites = || {
    // rust: let layers = self.pack.render.sprite_layers.iter();
    // rust: layers.map(|(name, layer)| (name.as_str(), *layer))
}
    // rust: let tags = pack.manifest.sprite_tags(sprites());
    // rust: let mut materials = pack.manifest.sprite_materials(sprites());
            // `blocks` lists: the sprites their models draw with, where no pattern named them.
    // rust: let listed = pack.manifest.material_blocks();
    // rust: if !listed.is_empty() {
    // rust: let macros = horizon_shaders::Macros::standard();
    // rust: let properties = horizon_shaders::Properties::parse(&listed, &macros);
    // rust: let ids = horizon_shaders::BlockIds::parse(&properties);
    // rust: let table = super::shader_packs::block_id_table(&self.pack, &ids);
    // rust: for (layer, id) in table.iter().step_by(2).enumerate() {
    // rust: let layer = layer as u32;
    // rust: if *id > 0 && !materials.iter().any(|m| m.0 == layer) {
    // rust: materials.push((layer, *id as u32));
}
}
    // rust: materials.sort_unstable();
}
    // rust: let layers = sprites().map(|(_, l)| l as usize + 1).max().unwrap_or(0);
    // rust: let translucent = pack.manifest.translucent_layers(&materials, layers);
            // Each light-giving block state's `[[lights]]` colour, with its level.
    // rust: let mut lights = horizon_client::gfx::block_light::LightTable::default();
    // rust: if !pack.manifest.lights.is_empty() {
    // rust: for (id, state) in self.res.facts().states.iter().enumerate() {
    // rust: if state.emission == 0 {
    // rust: continue;
}
    // rust: if let Some(color) = pack.manifest.light_of(&state.name) {
    // rust: lights.insert(id as u32, (color, state.emission));
}
}
}
    // rust: let labels = renderer
    // rust: .set_native_shader_pack(Some((report, constants, tags, materials, lights)))
    // rust: .map_err(|e| vec![e])?;
    // rust: Ok((pack.manifest, labels, translucent))
    // rust: });
        // The resources were loaded without a native pack, so without the resource packs'
        // LabPBR maps its material stage reads: load them once, now that one runs.
    // rust: if result.as_ref().is_ok_and(|(m, _, _)| m.material.is_some())
    // rust: && !horizon_client::sprites::labpbr_maps()
    // rust: {
    // rust: horizon_client::sprites::set_labpbr_maps(true);
    // rust: log::info!("Horizon: reloading resources for the LabPBR maps a native pack reads");
    // rust: self.reload_packs();
}
    // rust: let name = path.file_name().unwrap_or_default().to_string_lossy();
    // rust: match result {
    // rust: Ok((m, labels, translucent)) => {
    // rust: self.set_translucent_layers(translucent);
    // rust: log::info!(
    // rust: "shader pack {} {}: {} in {} ms",
    // rust: m.id,
    // rust: m.version,
    // rust: labels.join(", "),
    // rust: now.elapsed().as_millis()
    // rust: );
    // rust: if reload {
    // rust: self.system_message(Text::literal(format!("Shader pack {} reloaded", m.name)));
}
}
    // rust: Err(problems) => {
    // rust: log::warn!("shader pack {name} refused: {}", problems.join("; "));
    // rust: self.system_message(Text::colored(format!("Shader pack {name} refused:"), RED));
    // rust: for p in problems {
    // rust: self.system_message(Text::colored(p, RED));
}
}
}
}
}

// Why the game doesn't draw a pack the check may still pass: what it asks of shader API 0.2
// (docs/design/hdr-linear-light.md, steps 3 and 4) isn't served yet.
not_drawn :: proc(m: ^Manifest) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.blend == Blend::Linear {
    // rust: return Some(
    // rust: "[frame] blend = \"linear\" isn't served yet: leave it out, or set \"gamma\"".into(),
    // rust: );
}
    // rust: (m.api != Api::V0_1).then(|| {
    // rust: format!(
    // rust: "it is written for shader API {}, which is experimental and not drawn yet: \
    // rust: horizon-shader check takes it, the game takes shader API 0.1",
    // rust: m.api
    // rust: )
    // rust: })
}

// A hash of the names, sizes and modification times of the pack's files and of its saved
// option values (`None` when the pack is unreadable).
fingerprint :: proc(path: ^Path) -> O {
    // Ported from Horizon
    return {}
}
walk :: proc(path: ^Path, hasher: ^std::hash::DefaultHasher) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let meta = std::fs::metadata(path).ok()?;
    // rust: path.hash(hasher);
    // rust: if meta.is_dir() {
    // rust: let mut entries: Vec<_> = std::fs::read_dir(path)
    // rust: .ok()?
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .collect();
    // rust: entries.sort();
    // rust: for entry in entries {
    // rust: walk(&entry, hasher)?;
}
    // rust: } else {
    // rust: meta.len().hash(hasher);
    // rust: meta.modified().ok()?.hash(hasher);
}
    // rust: Some(())
}
    // rust: let mut hasher = std::hash::DefaultHasher::new();
    // rust: walk(path, &mut hasher)?;
    // The player's option values, when there are any.
    // rust: let values = horizon_client::shader_pack_list::values_path(path);
    // rust: let _ = walk(&values, &mut hasher);
    // rust: Some(hasher.finish())
}

    // rust: mod tests {
//     use super::not_drawn;
//     use horizon_shader_api::Manifest;

manifest :: proc(api: string, extra: string) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Manifest::parse(&format!(
    // rust: "schema = 1\nid = \"p\"\nname = \"P\"\nversion = \"1\"\napi = \"{api}\"\n\
    // rust: [[post]]\nfile = \"post.wgsl\"\n{extra}"
    // rust: ))
    // rust: .unwrap()
}

only_shader_api_0_1_is_drawn :: proc() {
}
    // rust: assert_eq!(not_drawn(&manifest("0.1", "")), None);
    // rust: let why = not_drawn(&manifest("0.2", "")).unwrap();
    // rust: assert!(
    // rust: why.contains("shader API 0.2, which is experimental"),
    // rust: "{why}"
    // rust: );
    // rust: let why = not_drawn(&manifest("0.2", "[frame]\nblend = \"linear\"\n")).unwrap();
    // rust: assert!(why.contains("blend = \"linear\" isn't served yet"), "{why}");
}
}
