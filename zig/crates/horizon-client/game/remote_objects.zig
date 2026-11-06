//! Transpiled from Horizon Rust crate
//! Module: horizon-client_remote_objects
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Boats, minecarts, armor stands, item frames, paintings and fence knots on a server's
//! client (`ClientPacketListener.handleAddEntity`, `handleSetEntityData`,
//! `handleSetEquipment`): the server simulates them, the client places them
//! where it says and interpolates their moves like a mob's.
// use super::Game;
// use horizon_client::entities::{ArmorStand, Cushion, ItemFrame, Painting};
// use horizon_client::mobs::leash::Holder;
// use horizon_client::particles::{ParticleOptions, ParticleType};
// use horizon_core::geometry::Vec3;
// use horizon_core::random::RandomSource;
// use horizon_protocol::entity_data::Value;
// use std::sync::Arc;

/// `Mth.rotLerp(alpha, from, to)`: `from` turned `alpha` of the way to `to` by
/// the shorter arc (`wrapDegrees` of the difference).
    // rust: pub(super) fn rot_lerp(alpha: f32, from: f32, to: f32) -> f32 {
    // rust: let mut d = (to - from) % 360.0;
    // rust: if d >= 180.0 {
    // rust: d -= 360.0;
    // rust: } else if d < -180.0 {
    // rust: d += 360.0;
}
    // rust: from + alpha * d
}

/// One `LinearInterpolationHandler` step of a yaw with `steps` ticks left:
/// a `1 / steps` share of the way to `target`, so the last step lands on it.
    // rust: pub(super) fn lerp_yaw_step(yaw: f32, target: f32, steps: u32) -> f32 {
    // rust: if steps == 0 {
    // rust: yaw
    // rust: } else {
    // rust: rot_lerp(1.0 / steps as f32, yaw, target)
}
}

    // rust: impl Game<'_> {
    /// `handleAddEntity` for an object type; false when `kind` isn't one.
    /// Hanging entities come at their block, with their direction as the
    /// spawn data (`Direction.from3DDataValue`).
    // rust: pub(super) fn spawn_remote_object(
    // rust: &mut self,
    // rust: id: i32,
    // rust: kind: &str,
    // rust: position: [f64; 3],
    // rust: rotation: (f32, f32),
    // rust: data: i32,
    // rust: ) -> bool {
    // rust: let (yaw, pitch) = rotation;
    // rust: let id = id as u32;
    // rust: let at = Vec3::new(position[0], position[1], position[2]);
    // rust: let block = position.map(|v| v.floor() as i32);
    // rust: self.remove_remote_object(id);
    // rust: if kind == "minecraft:leash_knot" {
            // A lead that came before its knot waits as a mob holder with the
            // knot's id (handleEntityLinkPacket's delayed holder); now it can
            // be tied to the fence.
    // rust: self.remote_knots.insert(id, block);
    // rust: for m in &mut self.mobs {
    // rust: if m.extra.leash == Some(Holder::Mob(id)) {
    // rust: m.extra.leash = Some(Holder::Knot(block));
}
}
    // rust: for b in &mut self.boats {
    // rust: if b.leash == Some(Holder::Mob(id)) {
    // rust: b.leash = Some(Holder::Knot(block));
}
}
    // rust: } else if let Some(shows) = match kind {
    // rust: "minecraft:text_display" => Some(super::text_displays::Shows::Text),
    // rust: "minecraft:block_display" => Some(super::text_displays::Shows::Block),
    // rust: "minecraft:item_display" => Some(super::text_displays::Shows::Item),
    // rust: _ => None,
    // rust: } {
    // rust: self.text_displays.insert(
    // rust: id as i32,
    // rust: super::text_displays::RemoteTextDisplay::new(shows, position, yaw),
    // rust: );
    // rust: } else if kind == "minecraft:ominous_item_spawner" {
    // rust: self.add_remote_ominous_item_spawner(id, position);
    // rust: } else if kind == "minecraft:interaction" {
            // The width, height and response follow in SetEntityData.
    // rust: self.interactions.insert(
    // rust: id as i32,
    // rust: super::interactions::RemoteInteraction::new(position),
    // rust: );
    // rust: } else if let Some(cart) = super::minecarts::CartKind::from_id(kind) {
    // rust: let mut c = super::minecarts::Minecart::new(id, cart, at);
    // rust: c.yaw = yaw;
    // rust: c.previous_yaw = yaw;
    // rust: c.pitch = pitch;
    // rust: c.previous_pitch = pitch;
    // rust: self.carts.push(c);
    // rust: } else if let Some((wood, chest)) = super::boats::any_boat_wood(kind)
    // rust: && self.boat_models.has(wood, chest)
    // rust: {
    // rust: let mut b = super::boats::Boat::new(id, Arc::from(wood), at, yaw);
    // rust: if chest {
    // rust: b = b.with_chest();
}
    // rust: self.boats.push(b);
    // rust: } else if kind == "minecraft:armor_stand" {
    // rust: self.armor_stands.push(ArmorStand::new(id, at, yaw));
    // rust: } else if kind == "minecraft:item_frame" || kind == "minecraft:glow_item_frame" {
    // rust: self.item_frames.push(ItemFrame {
    // rust: id,
    // rust: pos: block,
    // rust: facing: data.clamp(0, 5) as u8,
    // rust: glow: kind == "minecraft:glow_item_frame",
    // rust: item: None,
    // rust: rotation: 0,
    // rust: drop_chance: 1.0,
    // rust: fixed: false,
    // rust: invisible: false,
    // rust: check_interval: 0,
    // rust: custom_name: None,
    // rust: });
    // rust: } else if kind == "minecraft:cushion" {
            // BlockAttachedEntity.pos: `BlockPos.containing` of the spawn.
    // rust: self.cushions.push(Cushion {
    // rust: id,
    // rust: position: at,
    // rust: pos: block,
    // rust: yaw: super::cushions::snap_yaw(yaw),
    // rust: color: 0,
    // rust: check_interval: 0,
    // rust: custom_name: None,
    // rust: });
    // rust: } else if kind == "minecraft:lightning_bolt" {
    // rust: self.spawn_remote_bolt(id, position);
    // rust: } else if kind == "minecraft:painting" {
            // The variant comes with the entity data; until then the
            // registry's first one (VariantUtils.getAny).
    // rust: let (variant, width, height) = self
    // rust: .remote_painting_variant(0)
    // rust: .map_or((Arc::from("minecraft:kebab"), 1, 1), |v| {
    // rust: (v.id, v.width, v.height)
    // rust: });
            // Direction 3D data value (north 2, south 3, west 4, east 5) to 2D.
    // rust: let facing = match data {
    // rust: 2 => 2,
    // rust: 4 => 1,
    // rust: 5 => 3,
    // rust: _ => 0,
}
    // rust: self.paintings.push(Painting {
    // rust: id,
    // rust: pos: block,
    // rust: facing,
    // rust: variant,
    // rust: width,
    // rust: height,
    // rust: check_interval: 0,
    // rust: });
    // rust: } else {
    // rust: return false;
}
    // rust: true
}

    /// A `painting_variant` by its network id, from the server's registry.
pub fn remote_painting_variant(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = self.remote.as_ref()?;
    // rust: let name = r.registries.name("minecraft:painting_variant", id)?;
    // rust: self.painting_variants.get(name).cloned()
}

    /// `handleSetEntityData` for an object: what changes how it looks.
    // rust: pub(super) fn remote_object_data(&mut self, id: i32, values: &[(u8, i32, Value)]) {
    // rust: if self.text_displays.contains_key(&id) {
            // ItemDisplay.DATA_ITEM_STACK, read with the server's registries.
    // rust: let item = values
    // rust: .iter()
    // rust: .find_map(|(index, _, value)| match (index, value) {
    // rust: (23, Value::Item(stack)) => Some(self.to_stack(stack)),
    // rust: _ => None,
    // rust: });
    // rust: if let Some(display) = self.text_displays.get_mut(&id) {
    // rust: display.show(values, item);
    // rust: display.metadata(values);
}
    // rust: return;
}
    // rust: if self.remote_interaction_data(id, values) {
    // rust: return;
}
    // rust: let id = id as u32;
    // rust: for (index, _, value) in values {
    // rust: if let (8, Value::Item(stack)) = (index, value)
    // rust: && self.ominous_spawners.iter().any(|s| s.id == id)
    // rust: {
                // OminousItemSpawner.DATA_ITEM.
    // rust: if let (Some(item), Some(s)) = (
    // rust: self.to_stack(stack),
    // rust: self.ominous_spawners.iter_mut().find(|s| s.id == id),
    // rust: ) {
    // rust: s.item = item;
}
    // rust: } else if self.item_frames.iter().any(|f| f.id == id) {
                // HangingEntity.DATA_DIRECTION, ItemFrame.DATA_ITEM and DATA_ROTATION.
    // rust: let item = match (index, value) {
    // rust: (9, Value::Item(stack)) => Some(self.to_stack(stack)),
    // rust: _ => None,
}
    // rust: let Some(f) = self.item_frames.iter_mut().find(|f| f.id == id) else {
    // rust: continue;
}
    // rust: match (index, value) {
    // rust: (0, Value::Byte(flags)) => f.invisible = (*flags as u8 & 0x20) != 0,
    // rust: (8, Value::Id(d)) => f.facing = (*d).clamp(0, 5) as u8,
    // rust: (10, Value::Int(r)) => f.rotation = r.rem_euclid(8) as u8,
    // rust: _ => {}
}
    // rust: if let Some(item) = item {
    // rust: f.item = item;
}
    // rust: } else if self.paintings.iter().any(|p| p.id == id) {
                // Painting.DATA_PAINTING_VARIANT_ID: a registry holder (id + 1).
    // rust: if let (9, Value::Id(holder)) = (index, value)
    // rust: && let Some(v) = self.remote_painting_variant(holder - 1)
    // rust: && let Some(p) = self.paintings.iter_mut().find(|p| p.id == id)
    // rust: {
    // rust: p.variant = v.id;
    // rust: p.width = v.width;
    // rust: p.height = v.height;
}
    // rust: } else if let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == id) {
    // rust: match (index, value) {
    // rust: (0, Value::Byte(flags)) => a.invisible = flags & 0x20 != 0,
                    // Entity.DATA_CUSTOM_NAME and DATA_CUSTOM_NAME_VISIBLE.
    // rust: (2, Value::OptText(name)) => {
    // rust: a.custom_name = name.as_ref().map(horizon_client::entity_nbt::name_text);
}
    // rust: (2, Value::Text(name)) => {
    // rust: a.custom_name = Some(horizon_client::entity_nbt::name_text(name));
}
    // rust: (3, Value::Bool(visible)) => a.name_visible = *visible,
    // rust: (9, Value::Float(health)) => a.health = *health,
                    // ArmorStand.DATA_HEAD_POSE to DATA_RIGHT_LEG_POSE.
    // rust: (16..=21, Value::Floats(r)) if r.len() == 3 => {
    // rust: a.pose[usize::from(index - 16)] = [r[0], r[1], r[2]];
}
                    // ArmorStand.DATA_CLIENT_FLAGS.
    // rust: (15, Value::Byte(flags)) => {
    // rust: a.small = flags & 1 != 0;
    // rust: a.show_arms = flags & 4 != 0;
    // rust: a.no_base_plate = flags & 8 != 0;
    // rust: a.marker = flags & 16 != 0;
}
    // rust: _ => {}
}
    // rust: } else if let Some(c) = self.cushions.iter_mut().find(|c| c.id == id) {
                // Cushion.DATA_COLOR (DyeColor, a byte-backed id).
    // rust: if let (8, Value::Id(color)) = (index, value) {
    // rust: c.color = (*color).clamp(0, 15) as u8;
}
    // rust: } else if let Some(b) = self.boats.iter_mut().find(|b| b.id == id) {
                // VehicleEntity's hurt, direction and damage; the paddles and
                // the bubble time.
    // rust: match (index, value) {
    // rust: (8, Value::Int(v)) => b.hurt_time = *v,
    // rust: (9, Value::Int(v)) => b.hurt_dir = *v,
    // rust: (10, Value::Float(v)) => b.damage = *v,
    // rust: (11, Value::Bool(v)) => b.paddling[0] = *v,
    // rust: (12, Value::Bool(v)) => b.paddling[1] = *v,
                    // AbstractBoat.DATA_ID_BUBBLE_TIME.
    // rust: (13, Value::Int(v)) => b.bubble_time = *v,
    // rust: _ => {}
}
    // rust: } else if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
    // rust: match (index, value) {
    // rust: (8, Value::Int(v)) => c.hurt_time = *v,
    // rust: (9, Value::Int(v)) => c.hurt_dir = *v,
    // rust: (10, Value::Float(v)) => c.damage = *v,
                    // AbstractMinecart.DATA_ID_CUSTOM_DISPLAY_BLOCK (0, air,
                    // for none) and DATA_ID_DISPLAY_OFFSET.
    // rust: (11, Value::Id(state)) => {
    // rust: c.custom_display = (*state > 0).then(|| {
    // rust: horizon_client::entity_nbt::state_to_nbt(
    // rust: self.pack.assets.registry,
    // rust: horizon_world::registry::BlockStateId(*state as u32),
    // rust: )
    // rust: });
}
    // rust: (12, Value::Int(offset)) => c.custom_offset = Some(*offset),
    // rust: (13, Value::Bool(lit)) if c.kind == super::minecarts::CartKind::Furnace => {
    // rust: c.fuel = i32::from(*lit);
}
                    // MinecartCommandBlock.onSyncedDataUpdated: setCommand
                    // (which resets the success count) and setLastOutput.
    // rust: (13, Value::String(command))
    // rust: if c.kind == super::minecarts::CartKind::CommandBlock =>
    // rust: {
    // rust: c.command.set_command(command);
}
    // rust: (14, Value::Text(output))
    // rust: if c.kind == super::minecarts::CartKind::CommandBlock =>
    // rust: {
    // rust: c.command.last_output = Some(horizon_client::scoreboard::comp_text(
    // rust: &horizon_client::scoreboard::tag_to_json(output),
    // rust: ));
}
    // rust: _ => {}
}
}
}
}

    /// `handleSetEquipment` for an armor stand (EquipmentSlot ordinals 0 to
    /// 5: main hand, off hand, feet, legs, chest, head, its storage order).
    // rust: pub(super) fn remote_object_equipment(
    // rust: &mut self,
    // rust: id: i32,
    // rust: slots: &[(u8, Option<horizon_protocol::item::Stack>)],
    // rust: ) {
    // rust: if !self.armor_stands.iter().any(|a| a.id == id as u32) {
    // rust: return;
}
    // rust: let items: Vec<_> = slots
    // rust: .iter()
    // rust: .map(|(slot, stack)| (usize::from(*slot), self.to_stack(stack)))
    // rust: .collect();
    // rust: if let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == id as u32) {
    // rust: for (slot, item) in items {
    // rust: if let Some(s) = a.equipment.get_mut(slot) {
    // rust: *s = item;
}
}
}
}

    /// A move's rotation and ground state for an object.
    // rust: pub(super) fn turn_remote_object(&mut self, id: i32, yaw: Option<f32>, on_ground: bool) {
    // rust: let id = id as u32;
        // The boat the player drives turns here (isLocalInstanceAuthoritative).
    // rust: let driven = self.riding;
    // rust: if let Some(b) = self.boats.iter_mut().find(|b| b.id == id) {
    // rust: if Some(id) == driven {
    // rust: return;
}
            // AbstractBoat keeps a LinearInterpolationHandler: the new yaw is
            // the target of the three-tick lerp (`tick_remote_objects`), not
            // the boat's yaw at once.
    // rust: let _ = yaw;
    // rust: b.on_ground = on_ground;
    // rust: } else if let Some(c) = self.carts.iter_mut().find(|c| c.id == id)
    // rust: && let Some(yaw) = yaw
    // rust: {
    // rust: c.yaw = yaw;
}
}

    /// One tick of interpolation: `step` moves a position a step toward
    /// the entity's last sent one, if it has a move in progress. A minecart
    /// on `NewMinecartBehavior` is moved by `lerp_cart` (true when it did)
    /// instead.
    // rust: pub(super) fn tick_remote_objects(
    // rust: &mut self,
    // rust: mut step: impl FnMut(u32, Vec3) -> Vec3,
    // rust: mut turn: impl FnMut(u32, f32) -> f32,
    // rust: mut lerp_cart: impl FnMut(&mut super::minecarts::Minecart) -> bool,
    // rust: ) {
    // rust: for c in &mut self.carts {
    // rust: c.previous = c.position;
    // rust: c.previous_yaw = c.yaw;
    // rust: c.previous_pitch = c.pitch;
    // rust: if !lerp_cart(c) {
    // rust: c.position = step(c.id, c.position);
}
    // rust: c.accumulate_rotation();
    // rust: if c.kind == super::minecarts::CartKind::Furnace
    // rust: && c.fuel > 0
    // rust: && self.world.random.next_int_bound(4).unwrap_or(1) == 0
    // rust: {
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::LargeSmoke),
    // rust: [c.position.x, c.position.y + 0.8, c.position.z],
    // rust: [0.0; 3],
    // rust: );
}
            // MinecartTNT.tick: a primed cart counts its fuse down and sheds
            // smoke. The server explodes it; this copy only shows the fuse
            // (`TntMinecartRenderer`'s flash and swell).
    // rust: if c.kind == super::minecarts::CartKind::Tnt && c.fuse > 0 {
    // rust: c.fuse -= 1;
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::Smoke),
    // rust: [c.position.x, c.position.y + 0.5, c.position.z],
    // rust: [0.0; 3],
    // rust: );
}
}
        // The boat the player drives moves here, not where the server says.
    // rust: let driven = self.riding;
    // rust: for b in &mut self.boats {
    // rust: if Some(b.id) == driven {
    // rust: continue;
}
    // rust: b.previous = b.position;
    // rust: b.previous_yaw = b.yaw;
            // `LinearInterpolationHandler.interpolate`: the rotation moves a
            // step toward the server's with the position.
    // rust: b.yaw = turn(b.id, b.yaw);
    // rust: b.position = step(b.id, b.position);
}
    // rust: for a in &mut self.armor_stands {
    // rust: a.position = step(a.id, a.position);
}
    // rust: self.tick_remote_boat_bubbles();
}

    /// The boats, minecarts, armor stands, item frames and paintings in the
    /// level (a server's client: the ones it was sent), for `status`.
    // rust: pub(super) fn objects_status(&self) -> Vec<serde_json::Value> {
//         use serde_json::json;
    // rust: let at = |p: Vec3| [p.x, p.y, p.z];
    // rust: let mut out = Vec::new();
    // rust: for b in &self.boats {
    // rust: out.push(json!({"id": b.id, "kind": b.entity_type(), "position": at(b.position), "yaw": b.yaw}));
}
    // rust: for c in &self.carts {
    // rust: out.push(
    // rust: json!({"id": c.id, "kind": c.kind.id(), "position": at(c.position), "yaw": c.yaw}),
    // rust: );
}
    // rust: for a in &self.armor_stands {
    // rust: let items: Vec<_> = a
    // rust: .equipment
    // rust: .iter()
    // rust: .map(|i| i.as_ref().map(|i| &*i.item))
    // rust: .collect();
    // rust: out.push(json!({"id": a.id, "kind": "minecraft:armor_stand", "position": at(a.position), "yaw": a.yaw,
    // rust: "small": a.small, "arms": a.show_arms, "no_base_plate": a.no_base_plate, "equipment": items}));
}
    // rust: for c in &self.cushions {
    // rust: out.push(
    // rust: json!({"id": c.id, "kind": "minecraft:cushion", "position": at(c.position),
    // rust: "yaw": c.yaw, "color": c.color_name()}),
    // rust: );
}
    // rust: for (&id, i) in &self.interactions {
    // rust: out.push(json!({"id": id, "kind": "minecraft:interaction",
    // rust: "position": at(i.position), "width": i.width, "height": i.height,
    // rust: "response": i.response}));
}
    // rust: for f in &self.item_frames {
    // rust: out.push(
    // rust: json!({"id": f.id, "kind": f.kind(), "position": f.pos, "facing": f.facing,
    // rust: "item": f.item.as_ref().map(|i| &*i.item), "rotation": f.rotation}),
    // rust: );
}
    // rust: for p in &self.paintings {
    // rust: out.push(json!({"id": p.id, "kind": "minecraft:painting", "position": p.pos, "facing": p.facing,
    // rust: "variant": &*p.variant}));
}
    // rust: out
}

    /// Every object a server sent (a new connection, level or dimension).
    /// Experience orbs too: `ClientPacketListener.handleRespawn` replaces the
    /// `ClientLevel` on a dimension change, and `Hub::change_level` does not
    /// remove the old level's entities one by one. An orb kept here follows
    /// the player (`ExperienceOrb.tick` on the client) and is never
    /// `playerTouch`ed.
    // rust: pub(super) fn clear_remote_objects(&mut self) {
    // rust: self.text_displays.clear();
    // rust: self.interactions.clear();
    // rust: self.ominous_spawners.clear();
    // rust: self.remote_knots.clear();
    // rust: self.carts.clear();
    // rust: self.boats.clear();
    // rust: self.armor_stands.clear();
    // rust: self.cushions.clear();
    // rust: self.item_frames.clear();
    // rust: self.paintings.clear();
    // rust: self.orbs.clear();
}

    // rust: pub(super) fn remove_remote_object(&mut self, id: u32) {
    // rust: self.text_displays.remove(&(id as i32));
    // rust: self.interactions.remove(&(id as i32));
    // rust: self.ominous_spawners.retain(|s| s.id != id);
    // rust: self.remote_knots.remove(&id);
    // rust: self.carts.retain(|c| c.id != id);
    // rust: self.boats.retain(|b| b.id != id);
    // rust: self.armor_stands.retain(|a| a.id != id);
        // `Entity.setRemoved`: the cushion's rider gets off where it sat
        // (`LivingEntity.dismountVehicle`), not inside the block below.
    // rust: if self.riding == Some(id)
    // rust: && let Some(y) = self
    // rust: .cushions
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| c.position.y)
    // rust: {
    // rust: self.dismount_removed_vehicle(y);
}
    // rust: self.cushions.retain(|c| c.id != id);
    // rust: self.item_frames.retain(|f| f.id != id);
    // rust: self.paintings.retain(|p| p.id != id);
    // rust: self.bolts.retain(|b| b.id != id);
}
}

    // rust: mod tests {
//     use super::*;

pub fn rot_lerp_takes_the_short_way_round() void {
}
        // 350 to 10 is 20 degrees by the short arc, not -340.
    // rust: assert!((rot_lerp(0.5, 350.0, 10.0) - 360.0).abs() < 1e-4);
    // rust: assert!((rot_lerp(0.5, 10.0, 350.0) - 0.0).abs() < 1e-4);
    // rust: assert!((rot_lerp(0.25, -90.0, 80.0) - -47.5).abs() < 1e-4);
    // rust: assert_eq!(rot_lerp(0.0, 33.0, 200.0), 33.0);
}

pub fn a_boat_turns_a_third_of_the_way_each_of_three_ticks() void {
}
        // The server says 120 degrees while the boat is at 0: 40, 80, 120.
    // rust: let mut yaw = 0.0;
    // rust: let mut seen = Vec::new();
    // rust: for steps in (1..=3).rev() {
    // rust: yaw = lerp_yaw_step(yaw, 120.0, steps);
    // rust: seen.push(yaw);
}
    // rust: for (got, want) in seen.iter().zip([40.0, 80.0, 120.0]) {
    // rust: assert!((got - want).abs() < 1e-3, "{seen:?}");
}
        // Across the wrap it still ends on the target, the short way.
    // rust: let mut yaw = 350.0;
    // rust: for steps in (1..=3).rev() {
    // rust: yaw = lerp_yaw_step(yaw, 10.0, steps);
}
    // rust: assert!((yaw - 370.0).abs() < 1e-3, "{yaw}");
        // No steps left: the yaw is left alone.
    // rust: assert_eq!(lerp_yaw_step(5.0, 90.0, 0), 5.0);
}
}
