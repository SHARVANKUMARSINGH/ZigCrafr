//! Transpiled from Horizon Rust crate
package horizon_client_native_entity_data

import "core:fmt"
import "core:mem"
import "core:math"

// An entity's saved data, tags and name for native server mods, through an
// `EntityRef` (docs/native-mods.md, "Entity and level handles", #7387): what
// `/data` and `/tag` read and change. They return `None` (or `false`) for a
// stale handle or on a client, which the server sends no saved data or tags;
// only the name reads there.
// use super::{Game, commands::Target};
// use horizon_client::mod_api::EntityRef;
// use horizon_world::nbt::{Compound, Tag};

// The most tags an entity holds (`Entity.addTag`).
MAX_TAGS :: 1024

    // rust: impl Game<'_> {
    // The entity's data as `/data get entity` shows it
    // (`Entity.saveWithoutId`): its compound without `id`. An entity with no
    // UUID yet gets the one it will be saved with. API 386.
    // rust: pub(super) fn native_entity_nbt(&mut self, entity: EntityRef) -> Option<Compound> {
    // rust: if self.remote.is_some() {
    // rust: return None;
}
    // rust: let t = self.native_entity_target(entity)?;
    // rust: match self.entity_nbt(t)? {
    // rust: Tag::Compound(mut c) => {
    // rust: c.remove(&"id".into());
    // rust: Some(c)
}
    // rust: _ => None,
}
}
    // Merges `nbt` into the entity's data and loads the entity from it, as
    // `/data merge entity` does (`EntityDataAccessor.setData`): true when it
    // changed. False for a player (vanilla refuses them too), a kind Horizon
    // can't reload yet (only mobs, dropped items, armor stands and item
    // frames), data nested too deep, or data that changes nothing. API
    // 386.
    // rust: pub(super) fn native_entity_merge_nbt(&mut self, entity: EntityRef, nbt: Compound) -> bool {
    // rust: if self.remote.is_some() {
    // rust: return false;
}
    // rust: let Some(t) = self.native_entity_target(entity) else {
    // rust: return false;
}
    // rust: let Some(old) = self.native_entity_nbt(entity).map(Tag::Compound) else {
    // rust: return false;
}
    // rust: let nbt = Tag::Compound(nbt);
    // rust: if horizon_client::nbt_path::too_deep(&nbt, 0) {
    // rust: return false;
}
    // rust: let merged = horizon_client::data_cmd::merged(&old, &nbt);
    // rust: merged != old && self.apply_entity_nbt(t, merged).is_ok()
}
    // The entity's tags (`Entity.getTags`), as `/tag <entity> list` shows
    // them. API 386.
    // rust: pub(super) fn native_entity_tags(&self, entity: EntityRef) -> Option<Vec<String>> {
    // rust: if self.remote.is_some() {
    // rust: return None;
}
    // rust: Some(self.tags_of(self.native_entity_target(entity)?))
}
    // Adds tag `tag` (`Entity.addTag`): false when it has it already, holds
    // 1024, its kind can't store tags yet, or the handle is stale. API 386.
    // rust: pub(super) fn native_entity_add_tag(&mut self, entity: EntityRef, tag: &str) -> bool {
    // rust: if self.remote.is_some() {
    // rust: return false;
}
    // rust: let Some(t) = self.native_entity_target(entity) else {
    // rust: return false;
}
    // rust: let mut tags = self.tags_of(t);
    // rust: if tags.len() >= MAX_TAGS || tags.iter().any(|x| x == tag) {
    // rust: return false;
}
    // rust: tags.push(tag.to_owned());
        // False, not a silent no-op, for kinds whose tags aren't stored yet
        // (ominous item spawners, falling blocks, rockets).
    // rust: self.set_entity_tags(t, &tags)
}
    // Removes tag `tag` (`Entity.removeTag`): false when it didn't have it.
    // API 386.
    // rust: pub(super) fn native_entity_remove_tag(&mut self, entity: EntityRef, tag: &str) -> bool {
    // rust: if self.remote.is_some() {
    // rust: return false;
}
    // rust: let Some(t) = self.native_entity_target(entity) else {
    // rust: return false;
}
    // rust: let mut tags = self.tags_of(t);
    // rust: let before = tags.len();
    // rust: tags.retain(|x| x != tag);
    // rust: tags.len() != before && self.set_entity_tags(t, &tags)
}
    // The entity's name as plain text (`Entity.getName`): its custom name,
    // a player's name, else its type's name. On a client (API
    // @API:client_entity_refs@), from the custom name the server synced
    // (`Entity.DATA_CUSTOM_NAME`) and a player's profile name. API
    // 386.
    // rust: pub(super) fn native_entity_name(&self, entity: EntityRef) -> Option<String> {
    // rust: let t = self.native_entity_target(entity)?;
    // rust: if let Some(r) = &self.remote {
    // rust: let id = i32::try_from(entity.id()).ok()?;
    // rust: if let Some((_, Some(name))) = r.level_player(id) {
    // rust: return Some(name.to_owned());
}
    // rust: if let Target::Stand(id) = t
    // rust: && let Some(name) = self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .find(|a| a.id == id)
    // rust: .and_then(|a| a.custom_name.as_ref())
    // rust: {
    // rust: return Some(name.plain());
}
}
    // rust: Some(self.target_name(t).plain())
}
}
