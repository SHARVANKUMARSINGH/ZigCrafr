//! Transpiled from Horizon Rust crate
package horizon_client_render_model_library

import "core:fmt"
import "core:mem"
import "core:math"

// Parsed resource models for one startup or resource-pack reload.
// use crate::Result;
// use horizon_assets::{
    // rust: model::CuboidModel,
    // rust: resolve::{AssetReader, ModelLibrary},
}
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs,
    // rust: path::{Path, PathBuf},
    // rust: sync::Arc,
}

ParsedModels :: struct {
    models: BTreeMap<string,
    root: PathBuf,
}
// Asset files under a content root, for models that name a file (obj).
RootAssets :: struct {
    // rust: impl AssetReader for RootAssets {
read_text :: proc(self: ^Self, location: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = location.split_once(':')?;
        // Only a resource location's characters, and no `.`/`..` step: an
        // .obj's `mtllib` names its .mtl as raw text, so it must not reach a
        // file outside the content root (`../..:x` as a namespace would).
    // rust: let valid = |c: u8| c.is_ascii_lowercase() || c.is_ascii_digit() || b"_.-".contains(&c);
    // rust: if !namespace.bytes().all(valid)
    // rust: || matches!(namespace, "" | "." | "..")
    // rust: || !path.bytes().all(|c| valid(c) || c == b'/')
    // rust: || path.split('/').any(|part| matches!(part, "" | "." | ".."))
    // rust: {
    // rust: return None;
}
    // rust: horizon_core::prepared_files::read_to_string(
    // rust: &self.0.join(format!("assets/{namespace}/{path}")),
    // rust: )
    // rust: .ok()
}
}
    // rust: impl ParsedModels {
    // Every `models/**.json` of a namespace directory, by identifier.
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return Self {
    // rust: root: root.to_owned(),
    // rust: ..Self::default()
}
}
        // Listed first, then read and parsed at once: a content pack has tens
        // of thousands of models.
    // rust: let mut files = Vec::new();
    // rust: for ns in namespaces.flatten() {
    // rust: let namespace = ns.file_name().to_string_lossy().into_owned();
    // rust: let base = ns.path().join("models");
    // rust: let mut stack = vec![base.clone()];
    // rust: while let Some(dir) = stack.pop() {
    // rust: let Ok(entries) = fs::read_dir(&dir) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
                    // The entry's own type saves a stat per file; a link
                    // (content roots link into the base) is followed.
    // rust: let is_dir = match e.file_type() {
    // rust: Ok(t) if !t.is_symlink() => t.is_dir(),
    // rust: _ => path.is_dir(),
}
    // rust: if is_dir {
    // rust: stack.push(path);
    // rust: } else if path.extension().is_some_and(|x| x == "json")
    // rust: && let Ok(rel) = path.strip_prefix(&base)
    // rust: {
    // rust: let rel = rel.with_extension("").to_string_lossy().replace('\\', "/");
    // rust: files.push((format!("{namespace}:{rel}"), path));
}
}
}
}
    // rust: let parsed = crate::par::par_map(&files, |(_, path)| {
    // rust: let text = horizon_core::prepared_files::read_to_string(path).ok()?;
    // rust: CuboidModel::from_json(&text).ok().map(Arc::new)
    // rust: });
    // rust: let models = files
    // rust: .into_iter()
    // rust: .zip(parsed)
    // rust: .filter_map(|((id, _), model)| Some((id, model?)))
    // rust: .collect();
    // rust: Self {
    // rust: models,
    // rust: root: root.to_owned(),
}
}

    // Blocks require every referenced resource, including parents. Items instead
    // skip broken resources and use the resolver's missing-model fallback.
block_library :: proc(self: ^Self, root: ^Path, pending: [dynamic]string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.block_models(root, pending, false)
}
    // [`Self::block_library`], but a model that does not read takes the
    // built-in missing model, logged, as vanilla's model discovery does
    // ("Missing block model"). Mods' content gets this; vanilla's resources
    // always read.
    // rust: pub fn block_library_or_missing(
    // rust: &self,
    // rust: root: &Path,
    // rust: pending: Vec<String>,
    // rust: ) -> Result<ModelLibrary> {
    // rust: self.block_models(root, pending, true)
}
    // rust: fn block_models(
    // rust: &self,
    // rust: root: &Path,
    // rust: mut pending: Vec<String>,
    // rust: or_missing: bool,
    // rust: ) -> Result<ModelLibrary> {
    // rust: let mut models = BTreeMap::new();
    // rust: let mut skipped = std::collections::BTreeSet::new();
    // rust: while let Some(name) = pending.pop() {
    // rust: if models.contains_key(&name) || skipped.contains(&name) {
    // rust: continue;
}
    // rust: let model = match self.models.get(&name) {
    // rust: Some(model) => Arc::clone(model),
    // rust: None => {
    // rust: let read = || -> Result<CuboidModel> {
    // rust: let (namespace, path) =
    // rust: name.split_once(':').ok_or("invalid model identifier")?;
    // rust: let text = horizon_core::prepared_files::read_to_string(
    // rust: &root.join(format!("assets/{namespace}/models/{path}.json")),
    // rust: )?;
    // rust: Ok(CuboidModel::from_json(&text)?)
}
    // rust: match read() {
    // rust: Ok(model) => Arc::new(model),
    // rust: Err(e) if or_missing => {
    // rust: log::warn!("Horizon: missing block model {name}: {e}");
    // rust: skipped.insert(name);
    // rust: continue;
}
    // rust: Err(e) => return Err(e),
}
}
}
    // rust: pending.extend(model.referenced_models());
    // rust: models.insert(name, model);
}
    // rust: Ok(ModelLibrary::from_shared(models)?.with_assets(Arc::new(RootAssets(root.to_owned()))))
}
into_item_library :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let root = self.root;
    // rust: ModelLibrary::with_shared_item_generator(self.models)
    // rust: .map(|library| Arc::new(library.with_assets(Arc::new(RootAssets(root)))))
    // rust: .map_err(|e| format!("item models: {e:?}"))
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_assets::resolve::{GENERATED_MODEL, MISSING_MODEL};

Fixture :: struct {
    // rust: impl Fixture {
write :: proc(self: ^Self, name: string, json: string) {
}
    // rust: let (namespace, path) = name.split_once(':').unwrap();
    // rust: let path = self
    // rust: .0
    // rust: .join(format!("assets/{namespace}/models/{path}.json"));
    fs: :create_dir_all(path.parent().unwrap()).unwrap(),
    fs: :write(path,
}
}
    // rust: impl Drop for Fixture {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

shared_views_preserve_resolution_errors_builtins_and_reload :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let fixture = Fixture(
    // rust: std::env::temp_dir().join(format!("horizon-shared-models-{}", std::process::id())),
    // rust: );
    // rust: fixture.write("horizon:parent", r##"{"textures":{"side":"#all","all":"block/stone"},"elements":[{"from":[0,0,0],"to":[16,8,16],"faces":{"up":{"texture":"#side"}}}]}"##);
    // rust: fixture.write("horizon:nested/child", r#"{"parent":"horizon:parent","textures":{"all":"block/glass"},"display":{"gui":{"rotation":[30,45,0]}}}"#);
    // rust: fixture.write("horizon:broken", "{");
    // rust: fixture.write("horizon:dangling", r#"{"parent":"horizon:absent"}"#);
    // rust: fixture.write("horizon:a", r#"{"parent":"horizon:b"}"#);
    // rust: fixture.write("horizon:b", r#"{"parent":"horizon:a"}"#);
    // rust: fixture.write(
    // rust: GENERATED_MODEL,
    // rust: r#"{"elements":[{"from":[0,0,0],"to":[1,1,1],"faces":{"up":{"texture":"particle"}}}],"gui_light":"side"}"#,
    // rust: );
    // rust: fixture.write(MISSING_MODEL, r#"{"elements":[]}"#);
    // rust: let parsed = ParsedModels::load(&fixture.0);
    // rust: let direct = ParsedModels::default();
    // rust: let names = vec![
    // rust: "horizon:nested/child".into(),
    // rust: GENERATED_MODEL.into(),
    // rust: MISSING_MODEL.into(),
    // rust: "horizon:a".into(),
    // rust: ];
    // rust: let old = direct.block_library(&fixture.0, names.clone())?;
    // rust: let shared = parsed.block_library(&fixture.0, names)?;
    // rust: for name in ["horizon:nested/child", GENERATED_MODEL, MISSING_MODEL] {
    // rust: assert_eq!(
    // rust: format!("{:?}", old.resolve(name)?),
    // rust: format!("{:?}", shared.resolve(name)?)
    // rust: );
}
    // rust: assert!(shared.resolve("horizon:a").is_err());
    // rust: for name in ["horizon:broken", "horizon:absent", "horizon:dangling"] {
    // rust: let load = |models: &ParsedModels| {
    // rust: models
    // rust: .block_library(&fixture.0, vec![name.into()])
    // rust: .err()
    // rust: .unwrap()
    // rust: .to_string()
}
    // rust: assert_eq!(load(&direct), load(&parsed));
            // Mods' content: vanilla's missing model instead of an error.
    // rust: let lenient = parsed.block_library_or_missing(&fixture.0, vec![name.into()])?;
    // rust: assert_eq!(
    // rust: format!("{:?}", lenient.resolve(name)?.elements()),
    // rust: format!("{:?}", lenient.resolve(MISSING_MODEL)?.elements()),
    // rust: "{name}"
    // rust: );
}
    // rust: let items = parsed.into_item_library()?;
    // rust: let block = shared.resolve("horizon:nested/child")?;
    // rust: let item = items.resolve("horizon:nested/child")?;
    // rust: assert!(std::ptr::eq(
    // rust: block.elements().as_ptr(),
    // rust: item.elements().as_ptr()
    // rust: ));
    // rust: assert_eq!(
    // rust: item.material("side")?.unwrap().sprite,
    // rust: "minecraft:block/glass"
    // rust: );
    // rust: assert_eq!(shared.resolve(GENERATED_MODEL)?.elements().len(), 1);
    // rust: assert!(items.resolve(GENERATED_MODEL)?.elements().is_empty());
    // rust: assert!(items.resolve(GENERATED_MODEL)?.uses_item_generator());
    // rust: for name in [
    // rust: "horizon:broken",
    // rust: "horizon:absent",
    // rust: "horizon:dangling",
    // rust: MISSING_MODEL,
    // rust: ] {
    // rust: assert_eq!(items.resolve(name)?.elements().len(), 1);
}
    // rust: assert!(items.resolve("horizon:a").is_err());
    // rust: fixture.write("horizon:parent", r#"{"elements":[]}"#);
    // rust: let reloaded = ParsedModels::load(&fixture.0).into_item_library()?;
    // rust: assert!(
    // rust: reloaded
    // rust: .resolve("horizon:nested/child")?
    // rust: .elements()
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(items.resolve("horizon:nested/child")?.elements().len(), 1);
        // An unrelated bad item identifier must not make block preparation fail
        // (which would trigger resource-pack rollback at a different stage).
    // rust: fixture.write("horizon:INVALID", "{}");
    // rust: let parsed = ParsedModels::load(&fixture.0);
    // rust: assert!(
    // rust: parsed
    // rust: .block_library(&fixture.0, vec!["horizon:nested/child".into()])
    // rust: .is_ok()
    // rust: );
    // rust: assert!(parsed.into_item_library().is_err());
    // rust: Ok(())
}

    // An .obj's `mtllib` is raw text: no namespace or path step reaches a
    // file outside the content root.
root_assets_stay_inside_the_content_root :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-root-assets-{}", std::process::id()));
    // rust: let inside = root.join("content");
    // rust: fs::create_dir_all(inside.join("assets/m/models")).unwrap();
    // rust: fs::write(inside.join("assets/m/models/a.mtl"), "newmtl a").unwrap();
    // rust: fs::write(root.join("secret.mtl"), "newmtl secret").unwrap();
    // rust: let assets = RootAssets(inside);
    // rust: assert_eq!(
    // rust: assets.read_text("m:models/a.mtl").as_deref(),
    // rust: Some("newmtl a")
    // rust: );
    // rust: for escape in [
    // rust: "../..:secret.mtl",
    // rust: "..:../secret.mtl",
    // rust: "m:../../../secret.mtl",
    // rust: "m:models/./a.mtl",
    // rust: "M:models/a.mtl",
    // rust: ":models/a.mtl",
    // rust: ] {
    // rust: assert_eq!(assets.read_text(escape), None, "{escape}");
}
    // rust: fs::remove_dir_all(&root).unwrap();
}
}
