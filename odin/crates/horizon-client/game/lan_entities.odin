//! Transpiled from Horizon Rust crate
package horizon_client_lan_entities

import "core:fmt"
import "core:mem"
import "core:math"

// The entities beyond mobs and items that a server tracks to its clients
// (`ChunkMap.TrackedEntity`, `ServerEntity`): boats, minecarts, armor
// stands, item frames, paintings and the entities Horizon keeps without
// simulating them, each as vanilla pairs it (`getAddEntityPacket` and the
// synched data that differs from the defaults), and who rides what.
// use super::Game;
// use horizon_client::lan::{
    // rust: entity::{EntityState, Riding, States},
    // rust: hub::Hub,
    // rust: playerdata::ints_uuid,
}
// use horizon_protocol::entity_data::{Value, serializer};
// use horizon_world::{nbt::Tag, registry::BlockStateId};

// Allocate once: a native summon may need its id before the tracking tick.
    // rust: pub(super) fn assign_entity_id(next: &mut u32, id: &mut u32) -> u32 {
    // rust: if *id == 0 {
    // rust: *next += 1;
    // rust: *id = *next;
}
    // rust: *id
}

    // rust: impl Game<'_> {
    // `Entity.nextEntityId`: the id a new entity takes from the one counter.
    // rust: pub(super) fn take_entity_id(&mut self) -> u32 {
    // rust: self.next_entity += 1;
    // rust: self.next_entity
}
}

state :: proc(id: u32, kind: string, position: [f64; 3], yaw: f32, on_ground: bool) -> E {
    // Ported from Horizon
    return {}
}
    // rust: EntityState {
    // rust: id: id as i32,
    // rust: uuid: super::lan::entity_uuid(id),
    // rust: kind: kind.to_owned(),
    // rust: position,
    // rust: yaw,
    // rust: pitch: 0.0,
    // rust: head_yaw: 0.0,
    // rust: on_ground,
    // rust: velocity: [0.0; 3],
    // rust: minecart_steps: None,
    // rust: data: 0,
    // rust: meta: Vec::new(),
    // rust: defaults: Vec::new(),
    // rust: equipment: Vec::new(),
    // rust: attributes: Vec::new(),
    // rust: precise: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: needs_sync: false,
    // rust: idle: false,
    // rust: bare: false,
    // rust: leash: None,
    // rust: spectator: false,
    // rust: watching: false,
    // rust: hidden: None,
}
}

// `VehicleEntity`'s DATA_ID_HURT, DATA_ID_HURTDIR and DATA_ID_DAMAGE
// (entries 8 to 10) when they differ from their defaults (0, 1, 0).
vehicle_meta :: proc(hurt_time: i32, hurt_dir: i32, damage: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut meta = Vec::new();
    // rust: if hurt_time != 0 {
    // rust: meta.push((8, serializer::INT, Value::Int(hurt_time)));
}
    // rust: if hurt_dir != 1 {
    // rust: meta.push((9, serializer::INT, Value::Int(hurt_dir)));
}
    // rust: if damage != 0.0 {
    // rust: meta.push((10, serializer::FLOAT, Value::Float(damage)));
}
    // rust: meta
}

// `AbstractMinecart`'s DATA_ID_CUSTOM_DISPLAY_BLOCK (entry 11, an optional
// block state, empty by default) and DATA_ID_DISPLAY_OFFSET (entry 12, the
// kind's `getDefaultDisplayOffset` by default).
    // rust: fn cart_display_data(
    // rust: e: &mut EntityState,
    // rust: shown: Option<BlockStateId>,
    // rust: offset: Option<i32>,
    // rust: default_offset: i32,
    // rust: ) {
    // rust: e.defaults
    // rust: .push((11, serializer::OPTIONAL_BLOCK_STATE, Value::Id(0)));
    // rust: e.defaults
    // rust: .push((12, serializer::INT, Value::Int(default_offset)));
    // rust: if let Some(s) = shown {
    // rust: e.meta
    // rust: .push((11, serializer::OPTIONAL_BLOCK_STATE, Value::Id(s.0 as i32)));
}
    // rust: if let Some(o) = offset.filter(|&o| o != default_offset) {
    // rust: e.meta.push((12, serializer::INT, Value::Int(o)));
}
}

// An armor stand's pose (`ArmorStandPose`), each part that differs from the
// default, as DATA_HEAD_POSE to DATA_RIGHT_LEG_POSE (entries 16 to 21).
stand_poses :: proc(a: ^horizon_client::entities::ArmorStand) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut meta = Vec::new();
    // rust: for (i, (rotation, default)) in a
    // rust: .pose
    // rust: .iter()
    // rust: .zip(horizon_client::entities::ArmorStand::DEFAULT_POSE)
    // rust: .enumerate()
    // rust: {
    // rust: if *rotation != default {
    // rust: meta.push((
    // rust: 16 + i as u8,
    // rust: serializer::ROTATIONS,
    // rust: Value::Floats(rotation.to_vec()),
    // rust: ));
}
}
    // rust: meta
}

    // rust: impl Game<'_> {
    // The entities players started and stopped tracking since the last
    // tick, told to the mods in order with the hub back in `self.lan` and
    // no player's state swapped in (`ServerEntity.addPairing` and
    // `removePairing`).
    // rust: pub(super) fn run_native_tracking(&mut self) {
    // rust: let batches = match self.lan.as_mut() {
    // rust: Some(host) => std::mem::take(&mut host.hub.native_tracking),
    // rust: None => return,
}
    // rust: if self.remote.is_some() || self.options.execution_role.is_client() {
    // rust: return;
}
    // rust: for batch in batches {
    // rust: for e in batch.events {
    // rust: let (id, kind) = (e.entity as u32, &*e.tracked.kind);
    // rust: if e.start {
    // rust: self.native_player_start_tracking(
    // rust: batch.player,
    // rust: &batch.name,
    // rust: id,
    // rust: e.tracked.uuid,
    // rust: kind,
    // rust: );
    // rust: } else {
    // rust: self.native_player_stop_tracking(
    // rust: batch.player,
    // rust: &batch.name,
    // rust: id,
    // rust: e.tracked.uuid,
    // rust: kind,
    // rust: );
}
}
}
}

    // Who rides what (`Entity.getPassengers`): the players in their vehicles and
    // mobs on mobs.
    // rust: pub(super) fn lan_riding(&self, guests: &[(u32, i32)], riding: &mut Riding) {
    // rust: riding.clear();
        // The server's players in their boats and minecarts.
    // rust: for &(vehicle, guest) in guests {
    // rust: riding.add(vehicle as i32, guest);
}
    // rust: for m in self.mobs.iter().filter(|m| !m.removed) {
    // rust: if let Some(vehicle) = m.extra.mount {
    // rust: riding.add(vehicle as i32, m.id as i32);
}
}
    // rust: for (&vehicle, pass) in &mut riding.passengers {
    // rust: if let Some(driver) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id as i32 == vehicle)
    // rust: .and_then(|m| m.extra.rider)
    // rust: && let Some(pos) = pass.iter().position(|&p| p == driver as i32)
    // rust: && pos != 0
    // rust: {
    // rust: let d = pass.remove(pos);
    // rust: pass.insert(0, d);
}
}
}

    // Boats, minecarts, armor stands, item frames, paintings and the
    // entities kept unsimulated, as guests track them.
    // rust: pub(super) fn lan_object_states(
    // rust: &mut self,
    // rust: hub: &mut Hub,
    // rust: out: &mut States,
    // rust: drain_minecart_steps: bool,
    // rust: after: u32,
    // rust: ) {
    // rust: let guests: Vec<(u128, i32)> = hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| hub.here(g))
    // rust: .map(|g| (g.uuid, g.entity_id))
    // rust: .collect();
    // rust: for b in self.boats.iter().filter(|b| b.id > after) {
    // rust: let p = b.position;
    // rust: let mut e = state(b.id, &b.entity_type(), [p.x, p.y, p.z], b.yaw, b.on_ground);
            // Leashable.setLeashedTo / dropLeash: who holds the boat's lead.
    // rust: e.leash = self.boat_leash_link(b, &guests);
    // rust: e.velocity = [b.velocity.x, b.velocity.y, b.velocity.z];
    // rust: e.meta = vehicle_meta(b.hurt_time, b.hurt_dir, b.damage);
            // AbstractBoat.DATA_ID_PADDLE_LEFT and DATA_ID_PADDLE_RIGHT.
            // Omitted false values must reset clients that saw a true value,
            // including when the controlling passenger dismounts mid-stroke.
    // rust: for (k, paddling) in b.paddling.iter().enumerate() {
    // rust: e.defaults
    // rust: .push((11 + k as u8, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if *paddling {
    // rust: e.meta
    // rust: .push((11 + k as u8, serializer::BOOLEAN, Value::Bool(true)));
}
}
            // AbstractBoat.DATA_ID_BUBBLE_TIME, back to 0 once the boat is off
            // the column.
    // rust: if b.bubble_time != 0 {
    // rust: e.meta
    // rust: .push((13, serializer::INT, Value::Int(b.bubble_time)));
}
    // rust: e.defaults.push((13, serializer::INT, Value::Int(0)));
    // rust: out.push(e);
}
    // rust: let improvements = self.minecart_improvements();
    // rust: for c in self.carts.iter_mut().filter(|c| c.id > after) {
    // rust: let p = c.position;
    // rust: let mut e = state(c.id, c.kind.id(), [p.x, p.y, p.z], c.yaw, c.on_ground());
    // rust: e.pitch = c.pitch;
    // rust: e.velocity = [c.velocity.x, c.velocity.y, c.velocity.z];
    // rust: if improvements {
                // Joining another dimension only takes a spawn snapshot; its
                // regular tracking tick still owns the unsent steps.
    // rust: e.minecart_steps = Some(if drain_minecart_steps {
    // rust: std::mem::take(&mut c.lerp_steps)
    // rust: } else {
    // rust: Vec::new()
    // rust: });
}
    // rust: e.meta = vehicle_meta(c.hurt_time, c.hurt_dir, c.damage);
    // rust: let shown = c.custom_display.as_ref().and_then(|t| {
    // rust: horizon_client::entity_nbt::state_from_nbt(self.pack.assets.registry, t)
    // rust: });
    // rust: let default = super::minecarts::default_display_offset(c.kind) as i32;
    // rust: cart_display_data(&mut e, shown, c.custom_offset, default);
    // rust: match c.kind {
                // MinecartFurnace.DATA_ID_FUEL.
    // rust: super::minecarts::CartKind::Furnace => {
    // rust: e.defaults
    // rust: .push((13, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if c.fuel > 0 {
    // rust: e.meta.push((13, serializer::BOOLEAN, Value::Bool(true)));
}
}
                // MinecartCommandBlock.DATA_ID_COMMAND_NAME.
    // rust: super::minecarts::CartKind::CommandBlock => {
                    // and DATA_ID_LAST_OUTPUT (a component, defaults empty).
    // rust: let empty = Tag::String("".into());
    // rust: e.defaults
    // rust: .push((13, serializer::STRING, Value::String(String::new())));
    // rust: e.defaults
    // rust: .push((14, serializer::COMPONENT, Value::Text(empty.clone())));
    // rust: if !c.synced_command.is_empty() {
    // rust: e.meta.push((
    // rust: 13,
    // rust: serializer::STRING,
    // rust: Value::String(c.synced_command.clone()),
    // rust: ));
}
    // rust: if !c.synced_output.is_empty() {
    // rust: e.meta.push((
    // rust: 14,
    // rust: serializer::COMPONENT,
    // rust: Value::Text(Tag::String(c.synced_output.as_str().into())),
    // rust: ));
}
}
    // rust: _ => {}
}
    // rust: out.push(e);
}
    // rust: for a in self.armor_stands.iter().filter(|a| a.id > after) {
    // rust: let p = a.position;
    // rust: let mut e = state(
    // rust: a.id,
    // rust: "minecraft:armor_stand",
    // rust: [p.x, p.y, p.z],
    // rust: a.yaw,
    // rust: a.on_ground,
    // rust: );
    // rust: e.head_yaw = a.yaw;
    // rust: e.velocity = [a.velocity.x, a.velocity.y, a.velocity.z];
    // rust: let mut flags = 0i8;
    // rust: if a.fire_ticks > 0 {
    // rust: flags |= 1;
}
    // rust: if a.invisible {
    // rust: flags |= 0x20;
}
    // rust: if flags != 0 {
    // rust: e.meta.push((0, serializer::BYTE, Value::Byte(flags)));
}
            // LivingEntity.DATA_HEALTH_ID: 1 until the stand's max health is set.
    // rust: e.meta.push((9, serializer::FLOAT, Value::Float(a.health)));
            // ArmorStand.DATA_CLIENT_FLAGS: small 1, arms 4, no base plate 8, marker 16.
    // rust: let flags = i8::from(a.small)
    // rust: | i8::from(a.show_arms) << 2
    // rust: | i8::from(a.no_base_plate) << 3
    // rust: | i8::from(a.marker) << 4;
    // rust: if flags != 0 {
    // rust: e.meta.push((15, serializer::BYTE, Value::Byte(flags)));
}
    // rust: e.meta.extend(stand_poses(a));
            // Entity.DATA_CUSTOM_NAME and DATA_CUSTOM_NAME_VISIBLE: a hologram's text.
    // rust: if let Some(name) = &a.custom_name {
    // rust: e.meta.push((
    // rust: 2,
    // rust: serializer::OPTIONAL_COMPONENT,
    // rust: Value::OptText(Some(horizon_client::scoreboard::json_to_tag(
    // rust: &name.component(),
    // rust: ))),
    // rust: ));
    // rust: if a.name_visible {
    // rust: e.meta.push((3, serializer::BOOLEAN, Value::Bool(true)));
}
}
            // A name taken away or hidden again (`/data`) is sent as none / false.
    // rust: e.defaults
    // rust: .push((2, serializer::OPTIONAL_COMPONENT, Value::OptText(None)));
    // rust: e.defaults
    // rust: .push((3, serializer::BOOLEAN, Value::Bool(false)));
            // A pose put back to its default (`/data`) is sent as that default.
    // rust: e.defaults.push((15, serializer::BYTE, Value::Byte(0)));
    // rust: for (i, default) in horizon_client::entities::ArmorStand::DEFAULT_POSE
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: e.defaults.push((
    // rust: 16 + i as u8,
    // rust: serializer::ROTATIONS,
    // rust: Value::Floats(default.to_vec()),
    // rust: ));
}
            // Stored main hand, off hand, feet, legs, chest, head: the wire's slots 0 to 5.
    // rust: for (slot, item) in a.equipment.iter().enumerate() {
    // rust: if item.is_some() {
    // rust: e.equipment.push((slot as u8, hub.stack(item)));
}
}
    // rust: e.attributes = self.stand_attributes(a.id, &a.equipment);
    // rust: out.push(e);
}
    // rust: for f in self.item_frames.iter().filter(|f| f.id > after) {
            // ItemFrame.getAddEntityPacket: the block it hangs in and its direction.
    // rust: let mut e = state(f.id, f.kind(), f.pos.map(f64::from), 0.0, false);
    // rust: e.pitch = match f.facing {
    // rust: 0 => 90.0,
    // rust: 1 => -90.0,
    // rust: _ => 0.0,
}
    // rust: e.yaw = match f.facing {
    // rust: 2 => 180.0,
    // rust: 4 => 90.0,
    // rust: 5 => 270.0,
    // rust: _ => 0.0,
}
    // rust: e.data = i32::from(f.facing);
    // rust: if f.invisible {
    // rust: e.meta.push((0, serializer::BYTE, Value::Byte(0x20)));
}
            // HangingEntity.DATA_DIRECTION, south by default.
    // rust: if f.facing != 3 {
    // rust: e.meta
    // rust: .push((8, serializer::DIRECTION, Value::Id(i32::from(f.facing))));
}
    // rust: if f.item.is_some() {
    // rust: e.meta
    // rust: .push((9, serializer::ITEM_STACK, Value::Item(hub.stack(&f.item))));
}
    // rust: if f.rotation != 0 {
    // rust: e.meta
    // rust: .push((10, serializer::INT, Value::Int(i32::from(f.rotation))));
}
    // rust: out.push(e);
}
    // rust: for (p, &id) in self.knot_ids.iter().filter(|&(_, &id)| id > after) {
            // LeashFenceKnotEntity.getAddEntityPacket: the fence's block.
    // rust: out.push(state(
    // rust: id,
    // rust: "minecraft:leash_knot",
    // rust: p.map(f64::from),
    // rust: 0.0,
    // rust: false,
    // rust: ));
}
    // rust: for p in self.paintings.iter().filter(|p| p.id > after) {
    // rust: let mut e = state(p.id, "minecraft:painting", p.pos.map(f64::from), 0.0, false);
            // Direction.get2DDataValue (south 0, west 1, north 2, east 3) to its
            // 3D data value and yaw.
    // rust: let facing = [3, 4, 2, 5][usize::from(p.facing & 3)];
    // rust: e.yaw = f32::from(p.facing & 3) * 90.0;
    // rust: e.data = facing;
    // rust: if facing != 3 {
    // rust: e.meta.push((8, serializer::DIRECTION, Value::Id(facing)));
}
            // Painting.DATA_PAINTING_VARIANT_ID, a registry holder (id + 1),
            // set unless it is the registry's first variant (VariantUtils.getAny).
    // rust: if let Some(id) = hub.registry_id("minecraft:painting_variant", &p.variant)
    // rust: && id != 0
    // rust: {
    // rust: e.meta
    // rust: .push((9, serializer::PAINTING_VARIANT, Value::Id(id + 1)));
}
    // rust: out.push(e);
}
    // rust: for c in self.cushions.iter().filter(|c| c.id > after) {
    // rust: let p = c.position;
    // rust: let mut e = state(c.id, "minecraft:cushion", [p.x, p.y, p.z], c.yaw, false);
            // Cushion.DATA_COLOR, set unless it is the default white.
    // rust: if c.color != 0 {
    // rust: e.meta
    // rust: .push((8, serializer::DYE_COLOR, Value::Id(i32::from(c.color))));
}
    // rust: out.push(e);
}
        // DATA_ITEM, `ItemStack.EMPTY` by default.
    // rust: for o in self.ominous_spawners.iter().filter(|o| o.id > after) {
    // rust: let mut e = state(
    // rust: o.id,
    // rust: "minecraft:ominous_item_spawner",
    // rust: o.position,
    // rust: 0.0,
    // rust: false,
    // rust: );
    // rust: e.meta.push((
    // rust: 8,
    // rust: serializer::ITEM_STACK,
    // rust: Value::Item(
    // rust: hub.stack(&Some(o.item.clone()).filter(|i| &*i.item != "minecraft:air")),
    // rust: ),
    // rust: ));
    // rust: out.push(e);
}
    // rust: self.lan_projectile_states(hub, out, after);
    // rust: for o in self.others.iter().filter(|o| o.id > after) {
    // rust: let p = o.position;
    // rust: let mut e = state(o.id, &o.kind, [p.x, p.y, p.z], o.yaw, false);
    // rust: e.pitch = o.pitch;
    // rust: e.head_yaw = o.yaw;
    // rust: if let Some(tag) = self.persist.raw.get(&o.id) {
    // rust: self.lan_display_data(tag, hub, &mut e);
}
    // rust: out.push(e);
}
}
}

    // rust: impl Game<'_> {
    // The synched data of a text, block or item display kept unsimulated,
    // from its compound (`Display.readAdditionalSaveData`), with the
    // defaults to send when a value goes back to one.
lan_display_data :: proc(self: ^Self, tag: ^Tag, hub: ^Hub, e: ^EntityState) {
}
//         use horizon_client::text_display::{display_data, text_display_data};
    // rust: let empty = Tag::Compound(Default::default());
    // rust: let (meta, defaults) = match e.kind.as_str() {
    // rust: "minecraft:text_display" => (
    // rust: text_display_data(tag, false),
    // rust: text_display_data(&empty, true),
    // rust: ),
    // rust: "minecraft:block_display" => {
                // DATA_BLOCK_STATE_ID, air by default.
    // rust: let state = |t: Option<BlockStateId>| {
    // rust: (
    // rust: 23,
    // rust: serializer::BLOCK_STATE,
    // rust: Value::Id(t.map_or(0, |s| s.0 as i32)),
    // rust: )
}
    // rust: let air = self.pack.assets.registry.default_state("minecraft:air");
    // rust: let shown = tag.get("block_state").and_then(|t| self.state_from_nbt(t));
    // rust: (vec![state(shown.or(air))], vec![state(air)])
}
    // rust: "minecraft:item_display" => {
                // DATA_ITEM_STACK and DATA_ITEM_DISPLAY_ID (`ItemDisplayContext`).
    // rust: let item = tag
    // rust: .get("item")
    // rust: .and_then(horizon_client::save::item_from_nbt);
    // rust: let context = match tag.get("item_display") {
    // rust: Some(Tag::String(s)) => match s.to_string_lossy().as_str() {
    // rust: "thirdperson_lefthand" => 1,
    // rust: "thirdperson_righthand" => 2,
    // rust: "firstperson_lefthand" => 3,
    // rust: "firstperson_righthand" => 4,
    // rust: "head" => 5,
    // rust: "gui" => 6,
    // rust: "ground" => 7,
    // rust: "fixed" => 8,
    // rust: "on_shelf" => 9,
    // rust: _ => 0,
    // rust: },
    // rust: _ => 0,
}
    // rust: (
    // rust: vec![
    // rust: (23, serializer::ITEM_STACK, Value::Item(hub.stack(&item))),
    // rust: (24, serializer::BYTE, Value::Byte(context)),
    // rust: ],
    // rust: vec![
    // rust: (23, serializer::ITEM_STACK, Value::Item(None)),
    // rust: (24, serializer::BYTE, Value::Byte(0)),
    // rust: ],
    // rust: )
}
    // rust: _ => return,
}
    // rust: e.meta = display_data(tag, false);
    // rust: e.meta.extend(meta);
    // rust: e.defaults = display_data(&empty, true);
    // rust: e.defaults.extend(defaults);
}

    // `ClientboundAddEntityPacket(Entity, ServerEntity, int)`: the entity's
    // own UUID (`Entity.getUUID`), the one `/data`, saves and UUID
    // selectors use, so a client can name it back (the crosshair UUID that
    // `ClientSuggestionProvider.getSelectedEntities` suggests).
    // rust: pub(super) fn lan_entity_uuids(&mut self, states: &mut States) {
        // A bare state is never paired: its UUID is never read.
    // rust: for e in states.as_mut_slice().iter_mut().filter(|e| !e.bare) {
    // rust: e.uuid = ints_uuid(self.uuid_for(e.id as u32));
}
}

    // Gives the entities Horizon keeps without an id one (`Entity.id`, from
    // the same counter as the rest) before they are first tracked.
    // rust: pub(super) fn lan_assign_ids(&mut self) {
        // LeashFenceKnotEntity: one per fence post with a lead on it
        // (`notifyLeasheeRemoved` discards it once the last lead is gone).
    // rust: let knots: Vec<[i32; 3]> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| !m.removed)
    // rust: .filter_map(|m| match m.extra.leash {
    // rust: Some(horizon_client::mobs::leash::Holder::Knot(p)) => Some(p),
    // rust: _ => None,
    // rust: })
    // rust: .chain(self.boats.iter().filter_map(|b| match b.leash {
    // rust: Some(horizon_client::mobs::leash::Holder::Knot(p)) => Some(p),
    // rust: _ => None,
    // rust: }))
    // rust: .collect();
    // rust: self.knot_ids.retain(|p, _| knots.contains(p));
    // rust: for p in knots {
    // rust: self.knot_ids.entry(p).or_insert_with(|| {
    // rust: self.next_entity += 1;
    // rust: self.next_entity
    // rust: });
}
    // rust: let next = &mut self.next_entity;
    // rust: let mut give = |id: &mut u32| {
    // rust: assign_entity_id(next, id);
}
    // rust: self.tnts.iter_mut().for_each(|t| give(&mut t.id));
    // rust: self.falling.iter_mut().for_each(|f| give(&mut f.id));
    // rust: self.creatures
    // rust: .projectiles
    // rust: .iter_mut()
    // rust: .for_each(|p| give(&mut p.id));
    // rust: self.tridents.iter_mut().for_each(|t| give(&mut t.id));
    // rust: self.rockets.iter_mut().for_each(|r| give(&mut r.id));
    // rust: self.crystals.iter_mut().for_each(|c| give(&mut c.id));
    // rust: self.bolts.iter_mut().for_each(|b| give(&mut b.id));
    // rust: self.ominous_spawners
    // rust: .iter_mut()
    // rust: .for_each(|o| give(&mut o.id));
    // rust: self.potions.thrown_ids().for_each(&mut give);
    // rust: self.end.eye_ids().for_each(&mut give);
    // rust: self.breath_clouds.iter_mut().for_each(|b| give(&mut b.id));
    // rust: self.dragon_fireballs
    // rust: .iter_mut()
    // rust: .for_each(|b| give(&mut b.id));
}

    // Primed TNT, falling blocks, projectiles, tridents, firework rockets and
    // end crystals, as guests track them.
lan_projectile_states :: proc(self: ^Self, hub: ^Hub, out: ^States, after: u32) {
}
    // rust: let owner = |who: Option<horizon_client::mobs::Who>| match who {
    // rust: Some(horizon_client::mobs::Who::Mob(id)) => id as i32,
    // rust: Some(horizon_client::mobs::Who::Player) | None => 0,
}
    // rust: let at = |p: horizon_core::geometry::Vec3| [p.x, p.y, p.z];
    // rust: for f in self.fangs.list.iter().filter(|f| f.id > after) {
    // rust: out.push(state(f.id, "minecraft:evoker_fangs", f.pos, f.yaw, false));
}
        // LightningBolt: each client draws and flashes its own.
    // rust: for b in self.bolts.iter().filter(|b| b.id > after) {
    // rust: out.push(state(b.id, "minecraft:lightning_bolt", b.at, 0.0, false));
}
    // rust: for t in self.tnts.iter().filter(|t| t.id > after) {
    // rust: let mut e = state(t.id, "minecraft:tnt", at(t.position), 0.0, t.on_ground);
    // rust: e.velocity = at(t.velocity);
            // PrimedTnt.DATA_FUSE_ID, 80 by default; requiresPrecisePosition
            // while it touches a block.
    // rust: if t.fuse != 80 {
    // rust: e.meta.push((8, serializer::INT, Value::Int(t.fuse)));
}
    // rust: e.precise = t.on_ground;
    // rust: out.push(e);
}
    // rust: for f in self.falling.iter().filter(|f| f.id > after) {
    // rust: let mut e = state(f.id, "minecraft:falling_block", at(f.position), 0.0, false);
    // rust: e.velocity = at(f.velocity);
            // getAddEntityPacket: the block state; DATA_START_POS.
    // rust: e.data = f.state.0 as i32;
    // rust: if f.no_gravity {
    // rust: e.meta.push((5, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: let start = [f.start_pos.x, f.start_pos.y, f.start_pos.z];
    // rust: if start != [0; 3] {
    // rust: e.meta.push((8, serializer::BLOCK_POS, Value::Pos(start)));
}
    // rust: out.push(e);
}
    // rust: for p in self.creatures.projectiles.iter().filter(|p| p.id > after) {
//             use horizon_client::projectiles::ProjectileKind as K;
            // A spectral arrow is its own entity type.
    // rust: let kind = if p.is_spectral_arrow() {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: p.kind.id()
}
    // rust: let mut e = state(p.id, kind, at(p.position), p.yaw, false);
    // rust: e.pitch = p.pitch;
    // rust: e.velocity = at(p.velocity);
    // rust: e.needs_sync = p.needs_sync;
            // Projectile.getAddEntityPacket: the owner's id.
    // rust: e.data = match p.guest.and_then(|conn| hub.guest(conn)) {
    // rust: Some(g) => g.entity_id,
    // rust: None => owner(p.owner),
}
            // Entity.DATA_SHARED_FLAGS_ID's FLAG_ONFIRE: Entity.baseTick's
            // `setSharedFlagOnFire(remainingFireTicks > 0)`, which a client's
            // isOnFire reads to draw the flames (a Flame bow's arrow).
    // rust: if p.arrow.as_ref().is_some_and(|a| a.on_fire()) {
    // rust: e.meta.push((0, serializer::BYTE, Value::Byte(1)));
}
    // rust: match &p.kind {
    // rust: K::Arrow { critical, .. } => {
    // rust: let a = p.arrow.as_deref();
    // rust: e.meta.extend(arrow_meta(
    // rust: *critical,
    // rust: a.is_some_and(|a| a.no_physics),
    // rust: a.map_or(0, |a| a.pierce),
    // rust: a.is_some_and(|a| a.in_ground) || p.stuck,
    // rust: ));
                    // Arrow.ID_EFFECT_COLOR, -1 by default.
    // rust: let color = p.arrow_effect_color();
    // rust: if color != -1 {
    // rust: e.meta.push((11, serializer::INT, Value::Int(color)));
}
}
                // ThrownTrident.ID_LOYALTY (none for a mob's) and ID_FOIL, on
                // AbstractArrow's flags.
    // rust: K::Trident => {
    // rust: let a = p.arrow.as_deref();
    // rust: e.meta.extend(arrow_meta(
    // rust: false,
    // rust: a.is_some_and(|a| a.no_physics),
    // rust: 0,
    // rust: a.is_some_and(|a| a.in_ground) || p.stuck,
    // rust: ));
    // rust: if a.is_some_and(|a| a.pickup_item.has_any_enchantments()) {
    // rust: e.meta.push((12, serializer::BOOLEAN, Value::Bool(true)));
}
}
                // WitherSkull.DATA_DANGEROUS.
    // rust: K::WitherSkull { dangerous: true } => {
    // rust: e.meta.push((8, serializer::BOOLEAN, Value::Bool(true)));
}
                // ThrowableItemProjectile.DATA_ITEM_STACK: the potion's
                // `potion_contents`, whose effects the guest's splash and
                // whose colour its drawing need. A plain splash potion is the
                // client's default and is not sent.
    // rust: K::Potion(stack, _) if stack.extra.is_some() || stack.count != 1 => {
    // rust: e.meta.push((
    // rust: 8,
    // rust: serializer::ITEM_STACK,
    // rust: Value::Item(hub.stack(&Some((**stack).clone()))),
    // rust: ));
}
                // Fireball.DATA_ITEM_STACK: the item it is drawn as, which a
                // guest has no other way of learning. A plain fire charge is
                // the client's default and is not sent.
    // rust: K::SmallFireball | K::LargeFireball { .. }
    // rust: if p.item.as_ref().is_some_and(|i| {
    // rust: &*i.item != "minecraft:fire_charge" || i.count != 1 || i.extra.is_some()
    // rust: }) =>
    // rust: {
    // rust: e.meta
    // rust: .push((8, serializer::ITEM_STACK, Value::Item(hub.stack(&p.item))));
}
    // rust: _ => {}
}
            // ChunkMap.addEntity (#7461): a fresh arrow joined before its first tick
            // is paired as it joined with IN_GROUND=false, and its first update is deferred
            // to the next tick's send_changes so impact updates (e.g. point-blank wall
            // collision) arrive after the client's first tick has completed.
    // rust: if !hub.tracks(p.id as i32)
    // rust: && let Some(a) = p.arrow.as_deref()
    // rust: && let (Some(spawn_pos), Some(spawn_vel), Some((pitch, yaw))) =
    // rust: (a.spawn_pos, a.spawn_velocity, a.spawn_rot)
    // rust: {
    // rust: let mut joined = state(p.id, kind, at(spawn_pos), yaw, false);
    // rust: joined.pitch = pitch;
    // rust: joined.velocity = at(spawn_vel);
    // rust: joined.needs_sync = p.needs_sync;
    // rust: joined.data = e.data;
    // rust: joined.uuid = e.uuid;
    // rust: if a.on_fire() {
    // rust: joined.meta.push((0, serializer::BYTE, Value::Byte(1)));
}
    // rust: match &p.kind {
    // rust: K::Arrow { critical, .. } => {
    // rust: joined
    // rust: .meta
    // rust: .extend(arrow_meta(*critical, a.no_physics, a.pierce, false));
    // rust: let color = p.arrow_effect_color();
    // rust: if color != -1 {
    // rust: joined.meta.push((11, serializer::INT, Value::Int(color)));
}
}
    // rust: K::Trident => {
    // rust: joined
    // rust: .meta
    // rust: .extend(arrow_meta(false, a.no_physics, 0, false));
    // rust: if a.pickup_item.has_any_enchantments() {
    // rust: joined
    // rust: .meta
    // rust: .push((12, serializer::BOOLEAN, Value::Bool(true)));
}
}
    // rust: _ => {}
}
    // rust: hub.note_fresh_joined(&[joined]);
}
    // rust: out.push(e);
}
        // Thrown potions and bottles: ThrowableItemProjectile.DATA_ITEM_STACK
        // (the potion's colour), which a plain bottle's type already has.
    // rust: for (id, kind, stack, position, velocity) in
    // rust: self.potions.thrown_tracked().filter(|(id, ..)| *id > after)
    // rust: {
    // rust: let mut e = state(id, kind, at(position), 0.0, false);
    // rust: e.velocity = at(velocity);
    // rust: if stack.extra.is_some() || stack.count != 1 {
    // rust: e.meta.push((
    // rust: 8,
    // rust: serializer::ITEM_STACK,
    // rust: Value::Item(hub.stack(&Some(stack.clone()))),
    // rust: ));
}
    // rust: out.push(e);
}
        // EyeOfEnder: its item is the plain eye (DATA_ITEM_STACK's default).
    // rust: for (id, position, velocity) in self.end.eyes_tracked().filter(|(id, ..)| *id > after) {
    // rust: let mut e = state(id, "minecraft:eye_of_ender", position, 0.0, false);
    // rust: e.velocity = velocity;
    // rust: out.push(e);
}
    // rust: for t in self.tridents.iter().filter(|t| t.id > after) {
    // rust: let mut e = state(t.id, "minecraft:trident", at(t.position), t.yaw, false);
    // rust: e.pitch = t.pitch;
    // rust: e.velocity = at(t.velocity);
            // Projectile.getAddEntityPacket: the owner's id, the guest's that
            // threw it.
    // rust: e.data = match t.guest.and_then(|conn| hub.guest(conn)) {
    // rust: Some(g) => g.entity_id,
    // rust: None => owner(Some(horizon_client::mobs::Who::Player)),
}
    // rust: e.meta = arrow_meta(false, t.no_physics, 0, t.in_ground);
            // Entity.DATA_SHARED_FLAGS_ID: FLAG_ONFIRE.
    // rust: if t.fire_ticks > 0 {
    // rust: e.meta.push((0, serializer::BYTE, Value::Byte(1)));
}
            // ThrownTrident.ID_LOYALTY and ID_FOIL.
    // rust: if t.loyalty != 0 {
    // rust: e.meta
    // rust: .push((11, serializer::BYTE, Value::Byte(t.loyalty as i8)));
}
    // rust: if t.stack.has_any_enchantments() {
    // rust: e.meta.push((12, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: out.push(e);
}
    // rust: for r in self.rockets.iter().filter(|r| r.id > after) {
    // rust: let mut e = state(
    // rust: r.id,
    // rust: "minecraft:firework_rocket",
    // rust: at(r.position),
    // rust: 0.0,
    // rust: false,
    // rust: );
    // rust: e.velocity = at(r.velocity);
            // DATA_ID_FIREWORKS_ITEM once set from a stack, DATA_ATTACHED_TO_TARGET,
            // DATA_SHOT_AT_ANGLE.
    // rust: let plain = &*r.item.item == "minecraft:firework_rocket"
    // rust: && r.item.count == 1
    // rust: && r.item.extra.is_none();
    // rust: if !plain {
    // rust: e.meta.push((
    // rust: 8,
    // rust: serializer::ITEM_STACK,
    // rust: Value::Item(hub.stack(&Some(r.item.clone()))),
    // rust: ));
}
    // rust: let boosted = match r.guest {
    // rust: Some(conn) => hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .map(|g| g.entity_id),
    // rust: None => None,
}
    // rust: if r.attached
    // rust: && let Some(player) = boosted
    // rust: {
    // rust: e.meta
    // rust: .push((9, serializer::OPTIONAL_UNSIGNED_INT, Value::Id(player + 1)));
}
    // rust: if r.angled {
    // rust: e.meta.push((10, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: out.push(e);
}
    // rust: for c in self.crystals.iter().filter(|c| c.id > after) {
    // rust: let mut e = state(c.id, "minecraft:end_crystal", at(c.position), 0.0, false);
            // EndCrystal.DATA_BEAM_TARGET and DATA_SHOW_BOTTOM (true by default).
            // The beam's default is listed so that clearing it (the respawn
            // sequence ending) is sent to the guests instead of leaving the old beam.
    // rust: e.defaults = vec![(8, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(None))];
    // rust: if c.beam.is_some() {
    // rust: e.meta
    // rust: .push((8, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(c.beam)));
}
    // rust: if !c.show_bottom {
    // rust: e.meta.push((9, serializer::BOOLEAN, Value::Bool(false)));
}
    // rust: out.push(e);
}
        // The dragon's breath and lingering potion clouds (AreaEffectCloud's DATA_RADIUS,
        // DATA_WAITING for its 20-tick wait, and DATA_PARTICLE): the
        // client draws them from these (`tick_remote_clouds`).
        // The hub is out of `self.lan` meanwhile, so it is passed in.
    // rust: let breath = Self::hub_particle(
    // rust: hub,
    // rust: &horizon_client::particles::ParticleOptions::simple(
    // rust: horizon_client::particles::ParticleType::DragonBreath,
    // rust: ),
    // rust: None,
    // rust: );
    // rust: for b in self.dragon_fireballs.iter().filter(|b| b.id > after) {
    // rust: let p = b.position;
    // rust: let mut e = state(b.id, "minecraft:dragon_fireball", at(p), 0.0, false);
    // rust: e.velocity = [b.velocity.x, b.velocity.y, b.velocity.z];
    // rust: out.push(e);
}
    // rust: for b in self.breath_clouds.iter().filter(|b| b.id > after) {
    // rust: let mut e = state(b.id, "minecraft:area_effect_cloud", b.at, 0.0, false);
    // rust: e.meta.push((8, serializer::FLOAT, Value::Float(b.radius)));
    // rust: if b.waiting() {
    // rust: e.meta.push((9, serializer::BOOLEAN, Value::Bool(true)));
}
            // The hub is out of `self.lan` while these states are built, so
            // the particle must be encoded through the hub passed in: going
            // through `network_particle` would drop it and leave the client
            // on the default white particle.
    // rust: let particle = match &b.potion {
    // rust: Some(p) => Self::hub_particle(hub, &p.particle(), None),
    // rust: None => breath.clone(),
}
    // rust: if let Some(p) = &particle {
    // rust: e.meta
    // rust: .push((10, serializer::PARTICLE, Value::Particle(p.clone())));
}
    // rust: e.defaults
    // rust: .push((9, serializer::BOOLEAN, Value::Bool(false)));
    // rust: out.push(e);
}
    // rust: out.extend(self.lan_dragon_state());
}
}

// `AbstractArrow`'s ID_FLAGS (critical 1, no physics 2), PIERCE_LEVEL and
// IN_GROUND, when they differ from the defaults.
    // rust: fn arrow_meta(
    // rust: critical: bool,
    // rust: no_physics: bool,
    // rust: pierce: u8,
    // rust: in_ground: bool,
    // rust: ) -> Vec<(u8, i32, Value)> {
    // rust: let mut meta = Vec::new();
    // rust: let flags = i8::from(critical) | i8::from(no_physics) << 1;
    // rust: if flags != 0 {
    // rust: meta.push((8, serializer::BYTE, Value::Byte(flags)));
}
    // rust: if pierce != 0 {
    // rust: meta.push((9, serializer::BYTE, Value::Byte(pierce as i8)));
}
    // rust: if in_ground {
    // rust: meta.push((10, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: meta
}

    // rust: mod tests {
//     use super::*;

summoned_ids_are_unique_and_survive_the_tracking_pass :: proc() {
}
    // rust: let mut next = 40;
    // rust: let mut roots = [0; 3];
    // rust: let returned = roots.each_mut().map(|id| assign_entity_id(&mut next, id));
    // rust: assert_eq!(returned, [41, 42, 43]);
        // Tracking sees the same roots plus an unrelated deferred entity.
    // rust: for id in &mut roots {
    // rust: assign_entity_id(&mut next, id);
}
    // rust: let mut later = 0;
    // rust: assert_eq!(assign_entity_id(&mut next, &mut later), 44);
    // rust: assert_eq!(roots, returned);
    // rust: assert_eq!(next, 44);
}

armor_stand_poses_send_only_what_differs :: proc() {
}
    // rust: let mut stand = horizon_client::entities::ArmorStand::new(1, Default::default(), 0.0);
    // rust: stand.pose[0] = [10.0, 20.0, 0.0];
    // rust: let meta = stand_poses(&stand);
    // rust: assert_eq!(
    // rust: meta,
    // rust: vec![(
    // rust: 16,
    // rust: serializer::ROTATIONS,
    // rust: Value::Floats(vec![10.0, 20.0, 0.0])
    // rust: )]
    // rust: );
    // rust: let plain = horizon_client::entities::ArmorStand::new(1, Default::default(), 0.0);
    // rust: assert!(stand_poses(&plain).is_empty());
}

    // Issue #8050: a cart's custom display block and offset reach clients
    // as entries 11 and 12, the offset only off the kind's default.
cart_display_block_and_offset_are_synched :: proc() {
}
    // rust: let mut e = state(1, "minecraft:minecart", [0.0; 3], 0.0, false);
    // rust: cart_display_data(&mut e, Some(BlockStateId(42)), Some(14), 6);
    // rust: assert_eq!(
    // rust: e.meta,
    // rust: vec![
    // rust: (11, serializer::OPTIONAL_BLOCK_STATE, Value::Id(42)),
    // rust: (12, serializer::INT, Value::Int(14)),
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: e.defaults,
    // rust: vec![
    // rust: (11, serializer::OPTIONAL_BLOCK_STATE, Value::Id(0)),
    // rust: (12, serializer::INT, Value::Int(6)),
    // rust: ]
    // rust: );
    // rust: let mut plain = state(2, "minecraft:hopper_minecart", [0.0; 3], 0.0, false);
    // rust: cart_display_data(&mut plain, None, Some(1), 1);
    // rust: assert!(plain.meta.is_empty());
    // rust: assert_eq!(plain.defaults[1], (12, serializer::INT, Value::Int(1)));
}
}
