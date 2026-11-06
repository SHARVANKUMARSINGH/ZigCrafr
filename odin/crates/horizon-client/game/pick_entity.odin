//! Transpiled from Horizon Rust crate
package horizon_client_pick_entity

import "core:fmt"
import "core:mem"
import "core:math"

// Pick Block on an entity (`Minecraft.pickBlockOrEntity`'s entity case and
// `ServerGamePacketListenerImpl.handlePickItemFromEntity`): the client aims,
// the server answers with `Entity.getPickResult`.
// use super::Game;
// use horizon_client::{items::ItemStack, save::uuid_text};

    // rust: impl Game<'_> {
    // The entity the crosshair hits before any block, as `Entity.getId`; an
    // entity with nothing to pick (a projectile, a player, the dragon) is
    // `Some(None)`. `None` when the view hits a block or nothing.
    // rust: pub(super) fn pick_entity_hit(&self) -> Option<Option<i32>> {
    // rust: let mut best: Option<(f64, Option<i32>)> = None;
    // rust: let mut offer = |distance: f64, id: Option<i32>| {
    // rust: if self.before_block(distance) && best.is_none_or(|b| distance < b.0) {
    // rust: best = Some((distance, id));
}
}
    // rust: if let Some(hit) = self.remote_object_hit(true) {
            // Interaction.getPickResult is Entity's: nothing to pick.
    // rust: let id = (!self.interactions.contains_key(&hit.id)).then_some(hit.id);
    // rust: offer(hit.distance, id);
}
    // rust: if let Some((i, d, _)) = self.mob_hit() {
    // rust: offer(d, Some(self.mobs[i].id as i32));
}
    // rust: if let Some((_, d)) = self.redirectable_hit() {
    // rust: offer(d, None);
}
    // rust: if let Some((_, d)) = self.dragon_hit() {
    // rust: offer(d, None);
}
    // rust: best.map(|b| b.1)
}

    // `ClientSuggestionProvider.getSelectedEntities`: the UUID
    // (`Entity.getStringUUID`) of the entity the crosshair hits before any
    // block (`Minecraft.hitResult` an `EntityHitResult`).
    // rust: pub(super) fn crosshair_entity_uuid(&self) -> Option<String> {
        // The nearest entity wins, as in `pick_entity_hit`; one whose UUID
        // the client doesn't know (the dragon's parts) suggests nothing.
    // rust: let mut best: Option<(f64, Option<[i32; 4]>)> = None;
    // rust: let mut offer = |distance: f64, uuid: Option<[i32; 4]>| {
    // rust: if self.before_block(distance) && best.is_none_or(|b| distance < b.0) {
    // rust: best = Some((distance, uuid));
}
}
    // rust: let uuid_of = |id: u32| self.persist.uuids.get(&id).copied();
    // rust: if let Some(hit) = self.remote_object_hit(true) {
    // rust: offer(hit.distance, uuid_of(hit.id as u32));
}
    // rust: if let Some((i, d, _)) = self.mob_hit() {
    // rust: offer(d, uuid_of(self.mobs[i].id));
}
    // rust: if let Some((i, d)) = self.redirectable_hit() {
    // rust: offer(d, uuid_of(self.creatures.projectiles[i].id));
}
    // rust: if let Some((_, d)) = self.dragon_hit() {
    // rust: offer(d, None);
}
    // rust: best.and_then(|b| b.1).map(uuid_text)
}

    // `Entity.getPickResult` of the entity `id`: a mob's spawn egg, the item
    // of a boat, minecart, armor stand, cushion, painting, item frame (the
    // framed item when it holds one) or end crystal.
    // rust: pub(super) fn entity_pick_result(&self, id: i32) -> Option<ItemStack> {
    // rust: let id = u32::try_from(id).ok()?;
    // rust: let item = if let Some(m) = self.mobs.iter().find(|m| m.id == id) {
            // Mob.getPickResult: SpawnEggItem.byId.
    // rust: let egg = format!("{}_spawn_egg", m.kind.id);
    // rust: return self.items().get(&egg).map(|_| ItemStack::new(&egg, 1));
    // rust: } else if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: b.entity_type()
    // rust: } else if let Some(c) = self.carts.iter().find(|c| c.id == id) {
    // rust: c.kind.item().to_owned()
    // rust: } else if self.armor_stands.iter().any(|a| a.id == id) {
    // rust: "minecraft:armor_stand".to_owned()
    // rust: } else if let Some(c) = self.cushions.iter().find(|c| c.id == id) {
    // rust: c.item()
    // rust: } else if let Some(f) = self.item_frames.iter().find(|f| f.id == id) {
            // ItemFrame.getPickResult: what it frames, else the frame itself.
    // rust: return Some(
    // rust: f.item
    // rust: .clone()
    // rust: .unwrap_or_else(|| ItemStack::new(f.kind(), 1)),
    // rust: );
    // rust: } else if self.paintings.iter().any(|p| p.id == id) {
    // rust: "minecraft:painting".to_owned()
    // rust: } else if self.crystals.iter().any(|c| c.id == id) {
    // rust: "minecraft:end_crystal".to_owned()
    // rust: } else {
    // rust: return None;
}
    // rust: Some(ItemStack::new(&item, 1))
}

    // `Player.isWithinEntityInteractionRange(entity, 3.0)`: the entity's box
    // within the interaction range plus 3 of the eyes.
    // rust: pub(super) fn within_entity_range(&self, id: i32) -> bool {
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return false;
}
    // rust: let mob = u32::try_from(id)
    // rust: .ok()
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id))
    // rust: .map(|m| m.bounds());
    // rust: let Some(b) = self
    // rust: .object_target(id)
    // rust: .map(|(lo, hi, _)| (lo, hi))
    // rust: .or_else(|| {
    // rust: mob.or_else(|| self.tracked_special_box(id)).map(|b| {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z])
    // rust: })
    // rust: })
    // rust: else {
    // rust: return false;
}
    // rust: let d2: f64 = (0..3)
    // rust: .map(|a| (eye[a] - eye[a].clamp(b.0[a], b.1[a])).powi(2))
    // rust: .sum();
    // rust: let range = self.entity_reach + 3.0;
    // rust: d2 < range * range
}
}
