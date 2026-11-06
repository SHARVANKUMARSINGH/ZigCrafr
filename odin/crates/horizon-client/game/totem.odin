//! Transpiled from Horizon Rust crate
package horizon_client_totem

import "core:fmt"
import "core:mem"
import "core:math"

// The totem of undying (`LivingEntity.checkTotemDeathProtection` with the
// totem's `death_protection` component, entity event 35 on the client).
// use super::Game;
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: effects::EffectInstance,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: particles::{ParticleOptions, ParticleType},
}

TOTEM :: "minecraft:totem_of_undying"

// `EntityEvent.TOTEM_OF_UNDYING`.
    // rust: pub(super) const TOTEM_EVENT: i8 = 35;

    // rust: impl Game<'_> {
    // Whether either hand holds a totem, for the next hurt: the window's
    // player once a tick, a server's player for each of its turns.
    // rust: pub(super) fn update_totem_ready(&mut self) {
    // rust: let ready = self.held().is_some_and(|s| &*s.item == TOTEM)
    // rust: || self.offhand.as_ref().is_some_and(|s| &*s.item == TOTEM);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.health.totem_ready = ready;
}
}
    // The server's half once a totem fired: use it up (main hand first),
    // count it, set health to 1, then clear and apply its effects. Returns
    // the player's body, for entity event 35, which the caller broadcasts.
    // rust: pub(super) fn apply_totem(&mut self) -> Option<Body> {
    // rust: if !self.player.as_ref()?.health.totem_used {
    // rust: return None;
}
        // The mods hear a server player's totem before it is used up.
    // rust: if let (Some(uuid), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_totem(uuid, &name);
}
    // rust: let p = self.player.as_mut()?;
    // rust: p.health.totem_used = false;
    // rust: let _ = p.set_health(1.0, false);
    // rust: let body = Body {
    // rust: at: [p.position.x, p.position.y, p.position.z],
    // rust: width: f64::from(p.dimensions.width),
    // rust: height: f64::from(p.dimensions.height),
}
    // rust: let slot = if self.held().is_some_and(|s| &*s.item == TOTEM) {
    // rust: Some(self.selected)
    // rust: } else {
    // rust: None
}
    // rust: let cell = match slot {
    // rust: Some(i) => &mut self.inventory[i],
    // rust: None => &mut self.offhand,
}
    // rust: if let Some(s) = cell.as_mut() {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *cell = None;
}
}
    // rust: self.award_stat("used", TOTEM, 1);
    // rust: self.trigger_item(
    // rust: "minecraft:used_totem",
    // rust: &horizon_client::items::ItemStack::new(TOTEM, 1),
    // rust: );
        // ItemStack.causeUseVibration: the totem's use effects make one.
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:item_interact_finish", body.at, ctx);
        // DeathProtection.TOTEM_EFFECTS: clear, then regeneration II, absorption II, fire resistance.
    // rust: self.potions.effects.clear();
    // rust: for (id, ticks, amp) in [
    // rust: ("regeneration", 900, 1),
    // rust: ("absorption", 100, 1),
    // rust: ("fire_resistance", 800, 0),
    // rust: ] {
    // rust: if let Some(e) = horizon_client::brewing::effect(id) {
    // rust: self.add_player_effect(EffectInstance::new(e.id, ticks, amp));
}
}
    // rust: Some(body)
}
    // The window's player's totem: the server's half, then the event to
    // the guests and to this window's own client.
    // rust: pub(super) fn tick_totem(&mut self) {
    // rust: let Some(body) = self.apply_totem() else {
    // rust: return;
}
    // rust: self.totem_event(body, true);
}
    // Entity event 35 from a server, for this client's own player or an
    // entity it draws.
    // rust: pub(super) fn remote_totem(&mut self, id: i32) {
    // rust: let own = self.remote.as_ref().is_some_and(|r| r.entity_id == id);
    // rust: let body = if own {
    // rust: self.player.as_ref().map(|p| Body {
    // rust: at: [p.position.x, p.position.y, p.position.z],
    // rust: width: f64::from(p.dimensions.width),
    // rust: height: f64::from(p.dimensions.height),
    // rust: })
    // rust: } else {
    // rust: self.mobs.iter().find(|m| m.id == id as u32).map(|m| Body {
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: width: f64::from(m.width()),
    // rust: height: f64::from(m.height()),
    // rust: })
}
    // rust: if let Some(body) = body {
    // rust: self.totem_event(body, own);
}
}
    // `ClientPacketListener.handleEntityEvent` 35: the totem particles (a
    // 30-tick emitter) and its sound, heard here only (`playLocalSound`),
    // and the player's own rumble.
    // rust: pub(super) fn totem_event(&mut self, body: Body, own: bool) {
    // rust: self.particles.tracking_emitter_for(
    // rust: ParticleOptions::simple(ParticleType::TotemOfUndying),
    // rust: body.at,
    // rust: body.width,
    // rust: body.height,
    // rust: 30,
    // rust: );
    // rust: self.audio
    // rust: .play_unshared("minecraft:item.totem.use", Some(body.at), 1.0, 1.0);
    // rust: if own {
    // rust: self.pad_rumble(horizon_client::gamepad::Rumble::Totem);
            // findTotem, then LocalPlayer.displayItemActivation. The offsets
            // come from the player's own random in vanilla, not the level's:
            // the client-only particle random stands in for it.
    // rust: let totem = self.find_totem();
    // rust: self.item_activation
    // rust: .activate(totem, self.particles.random());
}
}
    // `ClientPacketListener.findTotem`: the first hand's item with
    // `death_protection`, else a new totem (a used single totem is gone by
    // the time the event arrives).
find_totem :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let models = &self.pack.item_renderer.models;
    // rust: [self.held(), self.offhand.as_ref()]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .find(|s| {
    // rust: models
    // rust: .components(&horizon_client::item_render::stack_view(s))
    // rust: .get("minecraft:death_protection")
    // rust: .is_some()
    // rust: })
    // rust: .cloned()
    // rust: .unwrap_or_else(|| ItemStack::new(TOTEM, 1))
}
    // `GameRenderer.tick`: the activated item counts down.
    // rust: pub(super) fn tick_item_activation(&mut self) {
    // rust: if self.player.is_some() {
    // rust: self.item_activation.tick();
}
}
    // `ScreenEffectRenderer.renderItemActivationAnimation`, for the hand
    // pass: the item in view space with the hand's projection but none of
    // the camera's turn or bob (a fresh `PoseStack`), so those are undone
    // here. `FIXED` display, no owner, seed 0 (`LevelExtractor`), full
    // brightness and `Lighting.Entry.ITEMS_3D`. Only F1 hides it.
    // rust: pub(super) fn item_activation_geometry(
    // rust: &self,
    // rust: partial: f32,
    // rust: view: glam::Mat4,
    // rust: aspect: f32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if self.ui.hide_gui {
    // rust: return;
}
    // rust: let (Some(stack), Some(pose)) = (
    // rust: self.item_activation.active(),
    // rust: self.item_activation.pose(partial, aspect),
    // rust: ) else {
    // rust: return;
}
    // rust: let state = self.resolve_item(stack, DisplayContext::Fixed, None, 0);
    // rust: let to_world = view.inverse();
    // rust: let (a, b) = horizon_client::item_render::gui::items_3d_lights();
    // rust: let lights = (
    // rust: to_world.transform_vector3(a).normalize(),
    // rust: to_world.transform_vector3(b).normalize(),
    // rust: );
        // PvP & HUD's totem animation size (100% is vanilla's), about the item's centre.
    // rust: let size = f32::from(self.settings.extras.pvp.tweaks.totem_size) / 100.0;
    // rust: let pose = pose * glam::Mat4::from_scale(glam::Vec3::splat(size));
    // rust: self.submit_item_lit(&state, to_world * pose, vertex_light(0xFF), lights, out);
}
}

// Where an entity event's entity stands and its size.
    // rust: pub(super) struct Body {
    // rust: pub at: [f64; 3],
    // rust: width: f64,
    // rust: height: f64,
}
