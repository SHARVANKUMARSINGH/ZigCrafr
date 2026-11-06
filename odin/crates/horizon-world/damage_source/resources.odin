//! Transpiled from Horizon Rust crate
package horizon_world_resources

import "core:fmt"
import "core:mem"
import "core:math"

// DamageType.DIRECT_CODEC resources and TagLoader's world pack stack.
// use super::{Catalog, DamageTypeId, Definition, Scaling, invalid, string};
// use crate::{
    // rust: loot::PackOverlay,
    // rust: worldgen::tags::{TagDefinitions, identifier},
}
// use serde_json::Value;
// use std::{collections::BTreeMap, fs, io, path::Path};

// The resource root's files of one damage registry kind, in every namespace.
// `json_folder` also reads prepared vanilla files from horizon-data.bin.
resource_files :: proc(root: ^Path, kind: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = BTreeMap::new();
    // rust: let namespaces = match fs::read_dir(root.join("data")) {
    // rust: Ok(entries) => entries,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => return Ok(files),
    // rust: Err(e) => return Err(e),
}
    // rust: for namespace in namespaces {
    // rust: let namespace = namespace?;
    // rust: if !namespace.path().is_dir() {
    // rust: continue;
}
    // rust: let ns = namespace.file_name().to_string_lossy().into_owned();
    // rust: let folder = match crate::json_folder::read(&namespace.path().join(kind)) {
    // rust: Ok(folder) => folder,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => continue,
    // rust: Err(e) => return Err(e),
}
    // rust: for file in &folder.files {
    // rust: files.insert(format!("{ns}:{}", file.name), file.bytes()?.to_vec());
}
}
    // rust: Ok(files)
}

// TagLoader.loadTagsForExistingRegistries: resources resolve against the
// supplied frozen registry. A missing required entry invalidates its tag;
// unrelated tags survive, while optional missing entries are ignored.
    // rust: pub fn resource_tags<T: Clone + Ord>(
    // rust: root: &Path,
    // rust: overlay: &PackOverlay<'_>,
    // rust: lookup: impl FnMut(&str, bool) -> Option<T>,
    // rust: ) -> io::Result<BTreeMap<String, Vec<T>>> {
    // rust: let mut files: BTreeMap<String, Vec<Vec<u8>>> = BTreeMap::new();
    // rust: let exported = root.join("damage-tags.json");
    // rust: if exported.exists() {
    // rust: let value: Value = serde_json::from_slice(&fs::read(exported)?)?;
    // rust: for (id, json) in value
    // rust: .as_object()
    // rust: .ok_or_else(|| invalid("expected damage tags"))?
    // rust: {
    // rust: files
    // rust: .entry(id.clone())
    // rust: .or_default()
    // rust: .push(string(json)?.as_bytes().to_vec());
}
}
    // rust: for (id, bytes) in resource_files(root, "tags/damage_type")? {
    // rust: files.entry(id).or_default().push(bytes);
}
    // rust: for (id, versions) in overlay.tag_kind("damage_type") {
    // rust: files
    // rust: .entry(id)
    // rust: .or_default()
    // rust: .extend(versions.iter().cloned());
}
    // ResourceManager lists stacks in Identifier file order (path first,
    // namespace second). Insertion order matters when tag cycles are pruned.
    // rust: let mut files: Vec<_> = files.into_iter().collect();
    // rust: files.sort_by_cached_key(|(id, _)| {
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: (format!("{path}.json"), ns.to_owned())
    // rust: });
    // rust: let mut tags = TagDefinitions::default();
    // rust: for (id, versions) in files {
    // rust: for bytes in versions {
    // rust: let result = std::str::from_utf8(&bytes)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|text| {
    // rust: tags.apply_json(&id, "pack", text)
    // rust: .map_err(|e| e.to_string())
    // rust: });
    // rust: if let Err(e) = result {
    // rust: log::warn!("Horizon: damage tag {id} is not read: {e}");
}
}
}
    // rust: let built = tags.build(lookup).map_err(|e| invalid(e.to_string()))?;
    // rust: for id in built.missing.keys() {
    // rust: log::warn!("Horizon: damage tag {id} has unresolved required entries");
}
    // rust: Ok(built.tags)
}

    // rust: impl Definition {
    // DamageType.DIRECT_CODEC with NbtOps: float exhaustion, and optional
    // fields omitted at their codec defaults. FloatTag.valueOf shares ZERO
    // for either sign of zero; the resident definition still keeps its bits.
to_nbt :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
//         use crate::nbt::Tag;
    // rust: let mut fields = vec![
    // rust: ("message_id", Tag::String(self.message_id.as_str().into())),
    // rust: ("scaling", Tag::String(self.scaling.name().into())),
    // rust: (
    // rust: "exhaustion",
    // rust: Tag::Float(if self.exhaustion == 0.0 {
    // rust: 0
    // rust: } else {
    // rust: self.exhaustion.to_bits()
    // rust: }),
    // rust: ),
    // rust: ];
    // rust: if self.effects != "hurt" {
    // rust: fields.push(("effects", Tag::String(self.effects.as_str().into())));
}
    // rust: if self.death_message_type != "default" {
    // rust: fields.push((
    // rust: "death_message_type",
    // rust: Tag::String(self.death_message_type.as_str().into()),
    // rust: ));
}
    // rust: Tag::compound(fields)
}

    // DamageType.DIRECT_CODEC: three required fields, two optional enums.
from_json :: proc(name: string, bytes: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let value: BTreeMap<String, &serde_json::value::RawValue> = serde_json::from_slice(bytes)?;
    // rust: let text = |key: &str, default: Option<&str>| -> io::Result<String> {
    // rust: match value.get(key).filter(|v| v.get() != "null") {
    // rust: Some(v) => serde_json::from_str(v.get()).map_err(|e| invalid(e.to_string())),
    // rust: None => default
    // rust: .map(str::to_owned)
    // rust: .ok_or_else(|| invalid(format!("missing damage {key}"))),
}
}
    // rust: if identifier(name).map_err(|e| invalid(e.to_string()))? != name {
    // rust: return Err(invalid("noncanonical damage type"));
}
    // rust: let scaling = match text("scaling", None)?.as_str() {
    // rust: "never" => Scaling::Never,
    // rust: "when_caused_by_living_non_player" => Scaling::LivingNonPlayer,
    // rust: "always" => Scaling::Always,
    // rust: _ => return Err(invalid("unknown damage scaling")),
}
    // rust: let effects = text("effects", Some("hurt"))?;
    // rust: if ![
    // rust: "hurt", "thorns", "drowning", "burning", "poking", "freezing",
    // rust: ]
    // rust: .contains(&effects.as_str())
    // rust: {
    // rust: return Err(invalid("unknown damage effects"));
}
    // rust: let death = text("death_message_type", Some("default"))?;
    // rust: if !["default", "fall_variants", "intentional_game_design"].contains(&death.as_str()) {
    // rust: return Err(invalid("unknown death message type"));
}
    // rust: Ok(Self {
    // rust: name: name.into(),
    // rust: message_id: text("message_id", None)?,
            // JsonOps parses directly to float; an intermediate f64 can
            // round the other way at a float's halfway boundary.
    // rust: exhaustion: value
    // rust: .get("exhaustion")
    // rust: .ok_or_else(|| invalid("missing damage exhaustion"))?
    // rust: .get()
    // rust: .parse::<f32>()
    // rust: .map_err(|_| invalid("expected damage exhaustion"))?,
    // rust: scaling,
    // rust: effects,
    // rust: death_message_type: death,
    // rust: })
}
}

    // rust: impl Catalog {
    // The exported vanilla definitions plus ordinary resource-root and
    // enabled world-pack files. No definition is published on codec failure.
load :: proc(root: ^Path, overlay: ^PackOverlay<'_>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let catalog = serde_json::from_slice(&fs::read(root.join("damage-catalog.json"))?)?;
        // Resolve tags only after custom definitions have joined the registry.
    // rust: Self::from_json(&catalog, &serde_json::json!({}))?.with_packs(root, overlay)
}

    // Names in a resolved tag, independently of local or network indices.
tag_members :: proc(self: ^Self, tag: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.tags
    // rust: .get(tag)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|id| self.definitions[id.0].name.as_str())
}

    // RegistryDataLoader's world-load snapshot. Existing local definition
    // indices stay stable; new names append in sorted order. Wire IDs remain
    // the separately synchronized registry's, looked up by name.
with_packs :: proc(self: ^Self, root: ^Path, overlay: ^PackOverlay<'_>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = resource_files(root, "damage_type")?;
    // rust: for (id, versions) in overlay.kind("damage_type") {
    // rust: files.insert(id.into(), PackOverlay::top(versions).to_vec());
}
    // rust: let mut catalog = self.clone();
    // rust: for (id, bytes) in files {
    // rust: let definition = Definition::from_json(&id, &bytes)
    // rust: .map_err(|e| invalid(format!("damage type {id}: {e}")))?;
    // rust: match catalog.ids.get(&id) {
    // rust: Some(index) => catalog.definitions[index.0] = definition,
    // rust: None => {
    // rust: catalog
    // rust: .ids
    // rust: .insert(id, DamageTypeId(catalog.definitions.len()));
    // rust: catalog.definitions.push(definition);
}
}
}
    // rust: catalog.reload_tags(root, overlay)
}

    // MinecraftServer.reloadResources retains the frozen damage registry;
    // only tags change, including when a pack containing a type is disabled.
reload_tags :: proc(self: ^Self, root: ^Path, overlay: ^PackOverlay<'_>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut catalog = self.clone();
    // rust: catalog.tags = resource_tags(root, overlay, |id, _| catalog.ids.get(id).copied())?
    // rust: .into_iter()
    // rust: .map(|(id, values)| (id, values.into_iter().collect()))
    // rust: .collect();
    // rust: Ok(catalog)
}
}

    // rust: mod tests;
