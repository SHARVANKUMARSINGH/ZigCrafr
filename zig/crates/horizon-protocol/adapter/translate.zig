//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_translate
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What changes inside packets between an older release and the pinned one, after their ids are renumbered:
//! registry ids (block states, items, entity types, ...) and the packets whose fields changed. A packet not
//! named here passes byte for byte.
//!
//! Most packets that carry registry ids are decoded with the older version's ids renumbered as they are read
//! ([`ids::renumbering`]) and encoded again for Horizon; ids in plain fields are renumbered between the two.
//! A packet whose layout changed is read in the older layout by hand here.
// use super::{
    // rust: ServerVersion,
    // rust: ids::{self, Ids, Way},
    // rust: session::Session,
}
// use crate::{
    // rust: Result, State,
    // rust: buf::{Codec, Reader, Writer},
    // rust: chunk::{Paletted, Section, Strategy},
    // rust: ids as packet_ids,
    // rust: packets::{configuration, play},
}

    // rust: impl Ids {
    /// The table of a registry tags are sent for, by its name; registries the protocol syncs from the
    /// server's own data (biomes, enchantments, ...) are numbered by that data and alike on both sides.
pub fn by_registry(self: *Self, registry: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match registry {
    // rust: "minecraft:block" => self.block,
    // rust: "minecraft:item" => self.item,
    // rust: "minecraft:entity_type" => self.entity_type,
    // rust: "minecraft:fluid" => self.fluid,
    // rust: "minecraft:game_event" => self.game_event,
    // rust: "minecraft:particle_type" => self.particle_type,
    // rust: "minecraft:sound_event" => self.sound_event,
    // rust: "minecraft:mob_effect" => self.mob_effect,
    // rust: "minecraft:attribute" => self.attribute,
    // rust: "minecraft:block_entity_type" => self.block_entity_type,
    // rust: "minecraft:menu" => self.menu,
    // rust: "minecraft:villager_type" => self.villager_type,
    // rust: "minecraft:villager_profession" => self.villager_profession,
    // rust: "minecraft:data_component_type" => self.data_component_type,
    // rust: _ => ids::Remap::Same,
}
}
}

/// A clientbound packet, renumbered to the pinned `id`, as the pinned version lays it out: the pinned id
/// it now has (an older packet can become a different one) and its new payload, `None` when the payload
/// stays as it is. `None` altogether drops the packet.
    // rust: pub fn clientbound(
    // rust: session: &Session,
    // rust: state: State,
    // rust: id: i32,
    // rust: payload: &[u8],
    // rust: ) -> Result<Option<(i32, Option<Vec<u8>>)>> {
    // rust: let Some(ids) = session.version.ids() else {
    // rust: return Ok(Some((id, None)));
}
//     use packet_ids::play::clientbound as cb;
    // 1.21.11's configuration ends with the world clocks 26.1 syncs as a registry.
    // rust: if session.version.at_most(ServerVersion::V1_21_11)
    // rust: && (state, id)
    // rust: == (
    // rust: State::Configuration,
    // rust: packet_ids::configuration::clientbound::FINISH_CONFIGURATION,
    // rust: )
    // rust: {
    // rust: session
    // rust: .incoming
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push_back((id, payload.to_vec()));
    // rust: return Ok(Some((
    // rust: packet_ids::configuration::clientbound::REGISTRY_DATA,
    // rust: Some(v1_21_11::world_clocks()),
    // rust: )));
}
    // A release at a time: an older server's packets are brought to 26.2's layout first, oldest step first.
    // rust: let mut before: Option<Vec<u8>> = None;
    // rust: type Step = fn(&Session, State, i32, &[u8]) -> Result<Option<Vec<u8>>>;
    // rust: let steps: [(ServerVersion, Step); 2] = [
    // rust: (ServerVersion::V1_21_11, v1_21_11::clientbound),
    // rust: (ServerVersion::V26_1, v26_1::clientbound),
    // rust: ];
    // rust: for (from, step) in steps {
    // rust: if session.version.at_most(from)
    // rust: && let Some(next) = step(session, state, id, before.as_deref().unwrap_or(payload))?
    // rust: {
    // rust: before = Some(next);
}
}
    // rust: let payload = before.as_deref().unwrap_or(payload);
    // rust: let out = match (state, id) {
    // rust: (State::Configuration, packet_ids::configuration::clientbound::UPDATE_TAGS) => {
    // rust: let mut p = configuration::Clientbound::decode(id, payload)?;
    // rust: if let configuration::Clientbound::UpdateTags(t) = &mut p {
    // rust: tags(ids, &mut t.registries);
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::UPDATE_TAGS) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::UpdateTags(t) = &mut p {
    // rust: tags(ids, &mut t.registries);
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::LOGIN) => login(payload)?,
    // rust: (State::Play, cb::RESPAWN) => respawn(payload)?,
    // rust: (State::Play, cb::LEVEL_CHUNK_WITH_LIGHT) => chunk(ids, payload)?,
    // rust: (State::Play, cb::LIGHT_UPDATE) => light_update(payload)?,
    // rust: (State::Play, cb::UPDATE_ADVANCEMENTS) => advancements(ids, payload)?,
    // rust: (State::Play, cb::LEVEL_PARTICLES) => particles(ids, payload)?,
    // rust: (State::Play, cb::EXPLODE) => {
            // 26.3 adds whether the blast's sound plays, last; 26.2 always played it.
    // rust: let mut body = payload.to_vec();
    // rust: body.push(1);
    // rust: redecode(ids, id, &body)?
}
    // rust: (State::Play, cb::MOVE_ENTITY_POS) => move_entity(payload, true, false)?,
    // rust: (State::Play, cb::MOVE_ENTITY_POS_ROT) => move_entity(payload, true, true)?,
    // rust: (State::Play, cb::MOVE_ENTITY_ROT) => move_entity(payload, false, true)?,
    // rust: (State::Play, cb::ENTITY_POSITION_SYNC) => position_sync(payload)?,
    // rust: (State::Play, cb::ANIMATE) => {
    // rust: return animate(payload).map(|(id, body)| Some((id, Some(body))));
}
    // rust: (State::Play, cb::ADD_ENTITY) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::AddEntity(e) = &mut p {
    // rust: let falling_block = ids.entity_type.down(packet_ids_entity::FALLING_BLOCK);
    // rust: if Some(e.kind) == falling_block {
    // rust: e.data = ids.block_state.up(e.data).unwrap_or(0);
}
    // rust: e.kind = ids.entity_type.up(e.kind).unwrap_or(e.kind);
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::BLOCK_ENTITY_DATA) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::BlockEntityData(b) = &mut p {
    // rust: b.kind = ids.block_entity_type.up(b.kind).unwrap_or(b.kind);
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::BLOCK_UPDATE) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::BlockUpdate(b) = &mut p {
    // rust: b.state = ids.block_state.up(b.state).unwrap_or(0);
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::SECTION_BLOCKS_UPDATE) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::SectionBlocksUpdate(s) = &mut p {
    // rust: for change in &mut s.changes {
    // rust: let state = ids.block_state.up((*change >> 12) as i32).unwrap_or(0);
    // rust: *change = i64::from(state) << 12 | (*change & 0xfff);
}
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::LEVEL_EVENT) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::LevelEvent(e) = &mut p {
                // LevelEvent.PARTICLES_DESTROY_BLOCK and the brush's BLOCK_FINISHED_BRUSHING carry a state.
    // rust: if matches!(e.kind, 2001 | 3008) {
    // rust: e.data = ids.block_state.up(e.data).unwrap_or(0);
}
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::UPDATE_ATTRIBUTES) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::UpdateAttributes(a) = &mut p {
                // An attribute the pinned version lacks can't be: 26.3 only added some.
    // rust: for v in &mut a.values {
    // rust: v.attribute = ids.attribute.up(v.attribute).unwrap_or(v.attribute);
}
}
    // rust: strip_id(p.encode())
}
    // rust: (State::Play, cb::SET_ENTITY_DATA) if session.version.at_most(ServerVersion::V1_21_11) => {
    // rust: let mut p = decode_play(ids, id, payload)?;
    // rust: if let play::Clientbound::SetEntityData(d) = &mut p {
    // rust: if session.version.at_most(ServerVersion::V1_21_10) {
    // rust: v1_21_10::entity_data(session, d);
}
    // rust: v1_21_11::entity_data(session, d);
}
    // rust: strip_id(p.encode())
}
    // rust: (
    // rust: State::Play,
    // rust: cb::SET_ENTITY_DATA
    // rust: | cb::CONTAINER_SET_CONTENT
    // rust: | cb::CONTAINER_SET_SLOT
    // rust: | cb::SET_CURSOR_ITEM
    // rust: | cb::SET_PLAYER_INVENTORY
    // rust: | cb::SET_EQUIPMENT
    // rust: | cb::MERCHANT_OFFERS
    // rust: | cb::SOUND
    // rust: | cb::SOUND_ENTITY
    // rust: | cb::RECIPE_BOOK_ADD
    // rust: | cb::PLACE_GHOST_RECIPE,
    // rust: ) => redecode(ids, id, payload)?,
    // rust: _ => return Ok(Some((id, before))),
}
    // rust: Ok(Some((id, Some(out))))
}

/// Pinned entity type ids the translation looks for.
    // rust: mod packet_ids_entity {
    /// `minecraft:falling_block` in 26.3.
pub const FALLING_BLOCK: i32 = 52;
}

/// A serverbound packet with Horizon's `id`, as the older server numbers and lays it out: its id there and
/// the payload. `None`: nothing is sent.
    // rust: pub fn serverbound(
    // rust: session: &Session,
    // rust: state: State,
    // rust: id: i32,
    // rust: payload: &[u8],
    // rust: ) -> Result<Option<(i32, Vec<u8>)>> {
    // rust: let renumbered = |id: i32, payload: Vec<u8>| {
    // rust: Ok(session
    // rust: .version
    // rust: .serverbound_id(state, id)
    // rust: .map(|mapped| (mapped, payload)))
}
    // rust: let Some(ids) = session.version.ids() else {
    // rust: return renumbered(id, payload.to_vec());
}
//     use packet_ids::play::serverbound as sb;
    // rust: match (state, id) {
        // 26.3 also states where the client was teleported to; 26.2 only the teleport's id.
    // rust: (State::Play, sb::ACCEPT_TELEPORTATION) => {
    // rust: let mut r = Reader::new(payload);
    // rust: let mut w = Writer::new();
    // rust: w.varint(r.varint()?);
    // rust: renumbered(id, w.data)
}
        // 26.3 inserted CHANGE_DESTROY_DIRECTION at 1; 26.2 has no such action.
    // rust: (State::Play, sb::PLAYER_ACTION) => {
    // rust: let mut r = Reader::new(payload);
    // rust: let action = r.varint()?;
    // rust: let action = match action {
    // rust: 0 => 0,
    // rust: 1 => return Ok(None),
    // rust: n => n - 1,
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(action);
    // rust: w.bytes(r.rest());
    // rust: renumbered(id, w.data)
}
    // rust: (State::Play, sb::INTERACT) if session.version.at_most(ServerVersion::V1_21_11) => {
    // rust: v1_21_11::interact(session, payload)
}
    // rust: (State::Play, sb::ATTACK) if session.version.at_most(ServerVersion::V1_21_11) => {
    // rust: v1_21_11::attack(payload)
}
        // 26.1 is told the entity a spectator picked by its UUID (spectate_entity, at the same id).
    // rust: (State::Play, sb::SPECTATOR_ACTION) if session.version == ServerVersion::V26_1 => {
    // rust: v26_1::spectate(session, payload)
}
        // 26.3's punch took over 26.2's swing of the main hand.
    // rust: (State::Play, sb::PUNCH) => {
    // rust: let mut w = Writer::new();
    // rust: w.varint(0);
    // rust: let swing = if session.version.at_most(ServerVersion::V1_21_11) {
    // rust: v1_21_11::SWING
    // rust: } else {
    // rust: V26_2_SWING
}
    // rust: Ok(Some((swing, w.data)))
}
    // rust: (State::Play, sb::SET_CREATIVE_MODE_SLOT | sb::CONTAINER_CLICK) => {
    // rust: let p = play::Serverbound::decode(id, payload)?;
    // rust: let payload = {
    // rust: let _down = ids::renumbering(ids, Way::Down);
    // rust: strip_id(p.encode())
}
    // rust: renumbered(id, payload)
}
    // rust: _ => renumbered(id, payload.to_vec()),
}
}

/// 26.2's serverbound `swing` (play), which 26.3 replaced with `punch`.
pub const V26_2_SWING: i32 = 63;

/// A play packet decoded with the older version's ids renumbered as they are read.
pub fn decode_play(ids: *'static Ids, id: i32, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let _up = ids::renumbering(ids, Way::Up);
    // rust: play::Clientbound::decode(id, payload)
}

/// The packet's payload once its registry ids are renumbered by decoding it.
pub fn redecode(ids: *'static Ids, id: i32, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = decode_play(ids, id, payload)?;
    // rust: Ok(strip_id(p.encode()))
}

pub fn strip_id(body: std.ArrayList(u8)) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(&body);
    // rust: match r.varint() {
    // rust: Ok(_) => r.rest().to_vec(),
    // rust: Err(_) => body,
}
}

pub fn tags(ids: *Ids, registries: *mut [configuration::RegistryTags]) void {
}
    // rust: for registry in registries {
    // rust: let remap = ids.by_registry(&registry.registry);
    // rust: for tag in &mut registry.tags {
    // rust: tag.ids = tag.ids.iter().filter_map(|&id| remap.up(id)).collect();
}
}
}

/// 26.2's CommonPlayerSpawnInfo, read into Horizon's: the game types went from bytes (-1 for no previous
/// one) to VarInts (an optional one as id + 1).
pub fn spawn_info(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dimension_type = r.varint()?;
    // rust: let dimension = r.string(32767)?;
    // rust: let seed = r.i64()?;
    // rust: let game_type = i32::from(r.i8()?);
    // rust: let previous = r.i8()?;
    // rust: let debug = r.bool()?;
    // rust: let flat = r.bool()?;
    // rust: let last_death = <crate::buf::Opt<play::GlobalPos>>::read(r)?;
    // rust: Ok(play::SpawnInfo {
    // rust: dimension_type,
    // rust: dimension,
    // rust: seed,
    // rust: game_type,
    // rust: previous_game_type: (previous >= 0).then_some(i32::from(previous)),
    // rust: debug,
    // rust: flat,
    // rust: last_death,
    // rust: portal_cooldown: r.varint()?,
    // rust: sea_level: r.varint()?,
    // rust: })
}

pub fn login(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let mut w = Writer::new();
    // rust: w.i32(r.i32()?);
    // rust: w.bool(r.bool()?);
    // rust: let n = r.count(r.remaining())?;
    // rust: w.varint(n as i32);
    // rust: for _ in 0..n {
    // rust: w.string(&r.string(32767)?);
}
    // rust: for _ in 0..3 {
    // rust: w.varint(r.varint()?);
}
    // rust: for _ in 0..3 {
    // rust: w.bool(r.bool()?);
}
    // rust: play::SpawnInfo::write(&spawn_info(&mut r)?, &mut w);
    // rust: w.bytes(r.rest());
    // rust: Ok(w.data)
}

pub fn respawn(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let mut w = Writer::new();
    // rust: play::SpawnInfo::write(&spawn_info(&mut r)?, &mut w);
    // rust: w.bytes(r.rest());
    // rust: Ok(w.data)
}

/// The column's sections with their block states renumbered and packed for the pinned palette width (a
/// section on the older global palette uses fewer bits per entry), and its light masks as 26.3 sends them.
/// Biomes are the server's own registry and stay as they are.
pub fn chunk(ids: *'static Ids, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let x = r.i32()?;
    // rust: let z = r.i32()?;
    // rust: let heightmaps = crate::chunk::Heightmaps::read(&mut r)?;
    // rust: let buffer = r.byte_array(r.remaining())?;
    // rust: let mut block_entities = <crate::buf::List<crate::chunk::BlockEntityInfo>>::read(&mut r)?;
    // A block entity type the pinned version dropped (26.1's bed) goes; the block still draws.
    // rust: block_entities.retain_mut(|b| match ids.block_entity_type.up(b.kind) {
    // rust: Some(kind) => {
    // rust: b.kind = kind;
    // rust: true
}
    // rust: None => false,
    // rust: });
    // rust: let light = light(&mut r)?;
    // rust: let (old_bits, new_bits) = ids.state_bits();
    // rust: let mut sections = Reader::new(&buffer);
    // rust: let mut out = Vec::new();
    // rust: while sections.remaining() > 0 {
    // rust: let mut s = Section::read(&mut sections, old_bits, 0)?;
    // rust: s.states = renumber_states(ids, &s.states, new_bits);
    // rust: out.push(s);
}
    // rust: let mut w = Writer::new();
    // rust: play::LevelChunkWithLight::write(
    // rust: &play::LevelChunkWithLight {
    // rust: x,
    // rust: z,
    // rust: chunk: crate::chunk::ChunkData {
    // rust: heightmaps,
    // rust: buffer: crate::chunk::ChunkData::from_sections(&out),
    // rust: block_entities,
    // rust: },
    // rust: light,
    // rust: },
    // rust: &mut w,
    // rust: );
    // rust: Ok(w.data)
}

/// 26.2's ClientboundLightUpdatePacketData: its four masks are `BitSet.toLongArray` (a VarInt count of
/// longs); 26.3 sends `toByteArray`, the same bits as little-endian bytes without trailing zeros.
pub fn light(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mask = || -> Result<Vec<u8>> {
    // rust: let longs = r.long_array()?;
    // rust: let mut bytes: Vec<u8> = longs.iter().flat_map(|l| l.to_le_bytes()).collect();
    // rust: let len = bytes.iter().rposition(|&b| b != 0).map_or(0, |i| i + 1);
    // rust: bytes.truncate(len);
    // rust: Ok(bytes)
}
    // rust: let sky_mask = mask()?;
    // rust: let block_mask = mask()?;
    // rust: let empty_sky_mask = mask()?;
    // rust: let empty_block_mask = mask()?;
    // rust: Ok(crate::chunk::LightData {
    // rust: sky_mask,
    // rust: block_mask,
    // rust: empty_sky_mask,
    // rust: empty_block_mask,
    // rust: sky: crate::chunk::Layers::read(r)?,
    // rust: block: crate::chunk::Layers::read(r)?,
    // rust: })
}

pub fn light_update(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let x = r.varint()?;
    // rust: let z = r.varint()?;
    // rust: let light = light(&mut r)?;
    // rust: let mut w = Writer::new();
    // rust: play::LightUpdate::write(&play::LightUpdate { x, z, light }, &mut w);
    // rust: Ok(w.data)
}

pub fn renumber_states(ids: *Ids, states: *Paletted, new_bits: u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let up = |id: i32| ids.block_state.up(id).unwrap_or(0);
    // rust: if !states.palette.is_empty() {
        // A palette: renumbering its entries is enough.
    // rust: let mut out = states.clone();
    // rust: out.palette.iter_mut().for_each(|p| *p = up(*p));
    // rust: return out;
}
    // rust: let values: Vec<i32> = (0..crate::chunk::BLOCKS)
    // rust: .map(|i| up(states.get(i)))
    // rust: .collect();
    // rust: Paletted::from_values(&values, Strategy::Blocks, new_bits)
}

/// 26.2 keeps an advancement's tab position in its display (two floats after the background); 26.3 sends
/// it after the whole advancement, displayed or not. What follows the added advancements is unchanged.
pub fn advancements(ids: *'static Ids, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let mut w = Writer::new();
    // rust: w.bool(r.bool()?);
    // rust: let n = r.count(r.remaining())?;
    // rust: w.varint(n as i32);
    // rust: for _ in 0..n {
    // rust: w.string(&r.string(32767)?);
    // rust: let parent = r.bool()?;
    // rust: w.bool(parent);
    // rust: if parent {
    // rust: w.string(&r.string(32767)?);
}
    // rust: let mut position = (0.0, 0.0);
    // rust: let display = r.bool()?;
    // rust: w.bool(display);
    // rust: if display {
    // rust: w.nbt(&r.nbt()?);
    // rust: w.nbt(&r.nbt()?);
    // rust: let icon = {
    // rust: let _up = ids::renumbering(ids, Way::Up);
    // rust: crate::item::Template::read(&mut r)?
}
    // rust: crate::item::Template::write(&icon, &mut w);
    // rust: w.varint(r.varint()?);
    // rust: let flags = r.i32()?;
    // rust: w.i32(flags);
    // rust: if flags & 1 != 0 {
    // rust: w.string(&r.string(32767)?);
}
    // rust: position = (r.f32()?, r.f32()?);
}
    // rust: let groups = r.count(r.remaining())?;
    // rust: w.varint(groups as i32);
    // rust: for _ in 0..groups {
    // rust: let k = r.count(r.remaining())?;
    // rust: w.varint(k as i32);
    // rust: for _ in 0..k {
    // rust: w.string(&r.string(32767)?);
}
}
    // rust: w.bool(r.bool()?);
    // rust: w.f32(position.0);
    // rust: w.f32(position.1);
}
    // rust: w.bytes(r.rest());
    // rust: Ok(w.data)
}

/// 26.2: flags, position, spread, one max speed, an Int count, then the particle. 26.3 sends the particle
/// first, a speed per axis, a VarInt count and how the spread is drawn (0, gaussian, as 26.2 did).
pub fn particles(ids: *'static Ids, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let override_limiter = r.bool()?;
    // rust: let always_show = r.bool()?;
    // rust: let pos = [r.f64()?, r.f64()?, r.f64()?];
    // rust: let dist = [r.f32()?, r.f32()?, r.f32()?];
    // rust: let speed = r.f32()?;
    // rust: let count = r.i32()?;
    // rust: let particle = {
    // rust: let _up = ids::renumbering(ids, Way::Up);
    // rust: crate::entity_data::Particle::read(&mut r)?
}
    // rust: let mut w = Writer::new();
    // rust: play::LevelParticles::write(
    // rust: &play::LevelParticles {
    // rust: particle,
    // rust: override_limiter,
    // rust: always_show,
    // rust: pos,
    // rust: dist,
    // rust: max_speed: [speed; 3],
    // rust: count,
    // rust: randomization: 0,
    // rust: },
    // rust: &mut w,
    // rust: );
    // rust: Ok(w.data)
}

/// 26.2 sends a move as three Short deltas (1/4096 of a block) then on-ground, and a turn as the two angles
/// then on-ground; 26.3 packs on-ground with the delta's step count, and sends it before the angles.
pub fn move_entity(payload: []const u8, pos: bool, rot: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let id = r.varint()?;
    // rust: let delta = if pos {
    // rust: Some(play::VecDelta::Linear([r.i16()?, r.i16()?, r.i16()?]))
    // rust: } else {
    // rust: None
}
    // rust: let rotation = if rot { Some((r.i8()?, r.i8()?)) } else { None };
    // rust: let on_ground = r.bool()?;
    // rust: let m = play::MoveEntity {
    // rust: id,
    // rust: delta,
    // rust: rotation,
    // rust: on_ground,
}
    // rust: let mut w = Writer::new();
    // rust: match (pos, rot) {
    // rust: (true, false) => play::MoveEntityPos::write(&play::MoveEntityPos(m), &mut w),
    // rust: (true, true) => play::MoveEntityPosRot::write(&play::MoveEntityPosRot(m), &mut w),
    // rust: _ => play::MoveEntityRot::write(&play::MoveEntityRot(m), &mut w),
}
    // rust: Ok(w.data)
}

/// 26.2: the entity, PositionMoveRotation (position, motion, the two angles), on-ground. 26.3 sends where it
/// goes as a path, then the angles; the motion is no longer sent.
pub fn position_sync(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let id = r.varint()?;
    // rust: let position = [r.f64()?, r.f64()?, r.f64()?];
    // rust: let _motion = [r.f64()?, r.f64()?, r.f64()?];
    // rust: let yaw = r.f32()?;
    // rust: let pitch = r.f32()?;
    // rust: let on_ground = r.bool()?;
    // rust: let mut w = Writer::new();
    // rust: play::EntityPositionSync::write(
    // rust: &play::EntityPositionSync {
    // rust: id,
    // rust: path: play::PositionPath::Linear(position),
    // rust: yaw,
    // rust: pitch,
    // rust: on_ground,
    // rust: },
    // rust: &mut w,
    // rust: );
    // rust: Ok(w.data)
}

/// 26.2's animate swings hands too (0 main, 3 off), which 26.3 sends as `swing_animation`; the others were
/// renumbered (wake up 2 -> 0, critical hits 4, 5 -> 1, 2).
pub fn animate(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let id = r.varint()?;
    // rust: let action = r.u8()?;
    // rust: let mut w = Writer::new();
    // rust: if action == 0 || action == 3 {
        // A plain swing: SwingAnimationType WHACK over the default 6 ticks.
    // rust: play::SwingAnimation::write(
    // rust: &play::SwingAnimation {
    // rust: id,
    // rust: hand: i32::from(action == 3),
    // rust: kind: 1,
    // rust: duration: 6,
    // rust: },
    // rust: &mut w,
    // rust: );
    // rust: return Ok((packet_ids::play::clientbound::SWING_ANIMATION, w.data));
}
    // rust: let action = match action {
    // rust: 2 => 0,
    // rust: 4 => 1,
    // rust: 5 => 2,
    // rust: other => other,
}
    // rust: w.varint(id);
    // rust: w.u8(action);
    // rust: Ok((packet_ids::play::clientbound::ANIMATE, w.data))
}

/// 1.21.10 (and 1.21.9) to 1.21.11.
    // rust: mod v1_21_10 {
//     use super::*;

    // 1.21.10's packets are laid out as 1.21.11's but for `horse_screen_open`, which 1.21.11 renamed
    // `mount_screen_open` (the id tables pair them): only entity data needs a step.
//     use crate::entity_data::{Value, serializer};

    /// Entity types (26.3 ids) whose entity data 1.21.11 changed.
pub const BEE: i32 = 11;
pub const WOLF: i32 = 152;
pub const MANNEQUIN: i32 = 84;
pub const PLAYER: i32 = 159;

    /// 1.21.11 made the bee's and the wolf's anger end a LONG (an INT before) and an avatar's main arm a
    /// HUMANOID_ARM (a BYTE before, with the same 0 left, 1 right). Indexes as 1.21.10 numbers them.
pub fn entity_data(session: *Session, data: *mut play::SetEntityData) void {
}
    // rust: let Some(kind) = session.kinds.lock().unwrap().get(&data.id).copied() else {
    // rust: return;
}
    // rust: for (index, ser, value) in &mut data.values {
    // rust: match (kind, *index, &*value) {
    // rust: (BEE, 18, Value::Int(v)) | (WOLF, 21, Value::Int(v)) => {
    // rust: *value = Value::Long(i64::from(*v));
    // rust: *ser = serializer::LONG;
}
    // rust: (PLAYER | MANNEQUIN, 15, Value::Byte(v)) => {
    // rust: *value = Value::Id(i32::from(*v));
    // rust: *ser = serializer::HUMANOID_ARM;
}
    // rust: _ => {}
}
}
}

    // rust: mod tests {
//         use super::*;

pub fn a_bee_s_anger_and_a_player_s_arm_take_1_21_11_s_types() void {
}
    // rust: let session = Session::new(ServerVersion::V1_21_10);
    // rust: session.kinds.lock().unwrap().insert(1, BEE);
    // rust: session.kinds.lock().unwrap().insert(2, PLAYER);
    // rust: let mut bee = play::SetEntityData {
    // rust: id: 1,
    // rust: values: vec![(18, serializer::INT, Value::Int(400))],
}
    // rust: entity_data(&session, &mut bee);
    // rust: assert_eq!(bee.values, vec![(18, serializer::LONG, Value::Long(400))]);
    // rust: let mut player = play::SetEntityData {
    // rust: id: 2,
    // rust: values: vec![(15, serializer::BYTE, Value::Byte(1))],
}
    // rust: entity_data(&session, &mut player);
    // rust: assert_eq!(
    // rust: player.values,
    // rust: vec![(15, serializer::HUMANOID_ARM, Value::Id(1))]
    // rust: );
}
}
}

/// 1.21.11 to 26.1.
    // rust: mod v1_21_11 {
//     use super::*;

    /// 1.21.11's serverbound `swing` and `interact` (play).
pub const SWING: i32 = 60;
pub const INTERACT: i32 = 25;

    /// Entity types (26.3 ids) whose class extends AgeableMob: 26.1 added a second boolean to it, after the
    /// baby flag (16), so their later entity data entries moved up one. Read off 26.1.2's EntityType
    /// registrations and class hierarchy.
    // rust: const AGEABLE: [i32; 39] = [
    // rust: 4, 7, 11, 19, 20, 21, 26, 30, 36, 37, 55, 56, 59, 62, 63, 65, 67, 79, 87, 88, 89, 92, 97,
    // rust: 99, 101, 105, 111, 114, 119, 122, 130, 132, 138, 141, 143, 145, 152, 155, 156,
    // rust: ];

    /// 1.21.11's packet in 26.1's layout; `None` when it is laid out alike. Ids stay the server's.
    // rust: pub fn clientbound(
    // rust: session: &Session,
    // rust: state: State,
    // rust: id: i32,
    // rust: payload: &[u8],
    // rust: ) -> Result<Option<Vec<u8>>> {
//         use packet_ids::play::clientbound as cb;
    // rust: Ok(match (state, id) {
    // rust: (State::Play, cb::ADD_ENTITY) => {
    // rust: let mut r = Reader::new(payload);
    // rust: let entity = r.varint()?;
    // rust: r.uuid()?;
    // rust: let kind = r.varint()?;
    // rust: if let Some(ids) = session.version.ids()
    // rust: && let Some(kind) = ids.entity_type.up(kind)
    // rust: {
    // rust: session.kinds.lock().unwrap().insert(entity, kind);
}
    // rust: None
}
    // rust: (State::Play, cb::REMOVE_ENTITIES) => {
    // rust: let mut r = Reader::new(payload);
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut kinds = session.kinds.lock().unwrap();
    // rust: for _ in 0..n {
    // rust: kinds.remove(&r.varint()?);
}
    // rust: None
}
    // rust: (State::Play, cb::SET_TIME) => Some(set_time(payload)?),
    // rust: (State::Play, cb::LEVEL_CHUNK_WITH_LIGHT) => Some(chunk(payload)?),
    // rust: _ => None,
    // rust: })
}

    /// 1.21.11's chunk sections hold the non-empty block count, then the states and biomes; 26.1 adds the
    /// fluid count after the block count (Horizon reads it but goes by the states). The rest of the packet
    /// is laid out alike.
pub fn chunk(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let x = r.i32()?;
    // rust: let z = r.i32()?;
    // rust: let heightmaps = crate::chunk::Heightmaps::read(&mut r)?;
    // rust: let buffer = r.byte_array(r.remaining())?;
    // rust: let mut sections = Reader::new(&buffer);
    // rust: let mut out = Writer::new();
    // rust: while sections.remaining() > 0 {
    // rust: out.i16(sections.i16()?);
    // rust: out.i16(0);
    // rust: Paletted::read(&mut sections, Strategy::Blocks, 0)?.write(&mut out);
    // rust: Paletted::read(&mut sections, Strategy::Biomes, 0)?.write(&mut out);
}
    // rust: let mut w = Writer::new();
    // rust: w.i32(x);
    // rust: w.i32(z);
    // rust: crate::chunk::Heightmaps::write(&heightmaps, &mut w);
    // rust: w.byte_array(&out.data);
    // rust: w.bytes(r.rest());
    // rust: Ok(w.data)
}

    /// 1.21.11 sends the game time, the day time and whether the day time runs; 26.1 the game time and a
    /// state per world clock. The day time becomes the overworld clock's (id 0 in [`world_clocks`]),
    /// standing still when it doesn't run.
pub fn set_time(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let game_time = r.i64()?;
    // rust: let day_time = r.i64()?;
    // rust: let ticking = r.bool()?;
    // rust: let mut w = Writer::new();
    // rust: play::SetTime::write(
    // rust: &play::SetTime {
    // rust: game_time,
    // rust: clocks: vec![play::ClockState {
    // rust: clock: 0,
    // rust: total_ticks: day_time,
    // rust: partial_tick: 0.0,
    // rust: rate: if ticking { 1.0 } else { 0.0 },
    // rust: }],
    // rust: },
    // rust: &mut w,
    // rust: );
    // rust: Ok(w.data)
}

    /// The `minecraft:world_clock` registry 1.21.11 has none of: the overworld's clock alone.
pub fn world_clocks() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: configuration::RegistryData::write(
    // rust: &configuration::RegistryData {
    // rust: registry: "minecraft:world_clock".into(),
    // rust: entries: vec![configuration::RegistryEntry {
    // rust: id: "minecraft:overworld".into(),
    // rust: data: None,
    // rust: }],
    // rust: },
    // rust: &mut w,
    // rust: );
    // rust: w.data
}

    /// Entity data of an AgeableMob moves past the entry 26.1 inserted after the baby flag.
pub fn entity_data(session: *Session, data: *mut play::SetEntityData) void {
}
    // rust: let kind = session.kinds.lock().unwrap().get(&data.id).copied();
    // rust: if kind.is_some_and(|k| AGEABLE.contains(&k)) {
    // rust: for (index, _, _) in &mut data.values {
    // rust: if *index >= 17 {
    // rust: *index += 1;
}
}
}
}

    /// Horizon's interact (entity, hand, where on it, sneaking) is 1.21.11's INTERACT_AT (action 2: the
    /// point as floats, then the hand), followed as vanilla 1.21.11 did by INTERACT (action 0: the hand).
pub fn interact(session: *Session, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let entity = r.varint()?;
    // rust: let hand = r.varint()?;
    // rust: let at = crate::buf::LpVec3::read(&mut r)?;
    // rust: let sneaking = r.bool()?;
    // rust: let mut first = Writer::new();
    // rust: first.varint(entity);
    // rust: first.varint(2);
    // rust: at.iter().for_each(|v| first.f32(*v as f32));
    // rust: first.varint(hand);
    // rust: first.bool(sneaking);
    // rust: let mut then = Writer::new();
    // rust: then.varint(INTERACT);
    // rust: then.varint(entity);
    // rust: then.varint(0);
    // rust: then.varint(hand);
    // rust: then.bool(sneaking);
    // rust: session.outgoing.lock().unwrap().push(then.data);
    // rust: Ok(Some((INTERACT, first.data)))
}

    /// 26.1's attack is 1.21.11's interact with action 1 (ATTACK).
pub fn attack(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let mut w = Writer::new();
    // rust: w.varint(r.varint()?);
    // rust: w.varint(1);
    // rust: w.bool(false);
    // rust: Ok(Some((INTERACT, w.data)))
}

    // rust: mod tests {
//         use super::*;

pub fn a_1_21_11_time_becomes_the_overworld_clock() void {
}
    // rust: let mut w = Writer::new();
    // rust: w.i64(100);
    // rust: w.i64(6000);
    // rust: w.bool(false);
    // rust: let body = set_time(&w.data).unwrap();
    // rust: let p =
    // rust: play::Clientbound::decode(packet_ids::play::clientbound::SET_TIME, &body).unwrap();
    // rust: let play::Clientbound::SetTime(t) = p else {
    // rust: panic!("{p:?}")
}
    // rust: assert_eq!(t.game_time, 100);
    // rust: assert_eq!((t.clocks[0].clock, t.clocks[0].total_ticks), (0, 6000));
    // rust: assert_eq!(t.clocks[0].rate, 0.0); // the day time stands still
}

pub fn an_interaction_is_sent_as_interact_at_then_interact() void {
}
    // rust: let session = Session::new(ServerVersion::V1_21_11);
    // rust: let mut w = Writer::new();
    // rust: w.varint(9); // entity
    // rust: w.varint(1); // off hand
    // rust: crate::buf::LpVec3::write(&[0.5, 1.0, 0.0], &mut w);
    // rust: w.bool(true);
    // rust: let (id, first) = interact(&session, &w.data).unwrap().unwrap();
    // rust: assert_eq!(id, INTERACT);
    // rust: let mut r = Reader::new(&first);
    // rust: assert_eq!((r.varint().unwrap(), r.varint().unwrap()), (9, 2)); // INTERACT_AT
    // rust: assert!((r.f32().unwrap() - 0.5).abs() < 0.01); // LpVec3 is approximate
    // rust: let then = session.take_outgoing();
            // INTERACT (action 0) with the off hand, sneaking.
    // rust: assert_eq!(then, vec![vec![INTERACT as u8, 9, 0, 1, 1]]);
}
}
}

/// 26.1 to 26.2: what changed in the packets of the release before.
    // rust: mod v26_1 {
//     use super::*;

    /// 26.1's packet in 26.2's layout; `None` when it is laid out alike.
    // rust: pub fn clientbound(
    // rust: session: &Session,
    // rust: state: State,
    // rust: id: i32,
    // rust: payload: &[u8],
    // rust: ) -> Result<Option<Vec<u8>>> {
//         use packet_ids::play::clientbound as cb;
    // rust: Ok(match (state, id) {
            // 26.2 adds the session's id after the profile; 26.1 has none to give.
    // rust: (State::Login, packet_ids::login::clientbound::LOGIN_FINISHED) => {
    // rust: let mut body = payload.to_vec();
    // rust: body.extend_from_slice(&[0; 16]);
    // rust: Some(body)
}
    // rust: (State::Play, cb::LOGIN) => Some(login(payload)?),
    // rust: (State::Play, cb::SET_PLAYER_TEAM) => Some(team(payload)?),
    // rust: (State::Play, cb::ADD_ENTITY) => {
    // rust: let mut r = Reader::new(payload);
    // rust: let entity = r.varint()?;
    // rust: let uuid = r.uuid()?;
    // rust: session.uuids.lock().unwrap().insert(entity, uuid);
    // rust: None
}
    // rust: (State::Play, cb::REMOVE_ENTITIES) => {
    // rust: let mut r = Reader::new(payload);
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut uuids = session.uuids.lock().unwrap();
    // rust: for _ in 0..n {
    // rust: uuids.remove(&r.varint()?);
}
    // rust: None
}
    // rust: _ => None,
    // rust: })
}

    /// 26.2 tells the client whether the server checks accounts (after the spawn info); 26.1 doesn't, so
    /// it reads as an offline server's.
pub fn login(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: r.i32()?;
    // rust: r.bool()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: for _ in 0..n {
    // rust: r.string(32767)?;
}
    // rust: for _ in 0..3 {
    // rust: r.varint()?;
}
    // rust: for _ in 0..3 {
    // rust: r.bool()?;
}
    // rust: super::spawn_info(&mut r)?;
    // rust: let at = r.position();
    // rust: let mut body = payload[..at].to_vec();
    // rust: body.push(0);
    // rust: body.extend_from_slice(&payload[at..]);
    // rust: Ok(body)
}

    /// 26.1's team parameters: name, options, visibility, collision, colour as a ChatFormatting (RESET for
    /// none), prefix, suffix. 26.2 sends name, prefix, suffix, visibility, collision, an optional
    /// TeamColor (ChatFormatting's first 16, in order) and the options last.
pub fn team(payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(payload);
    // rust: let mut w = Writer::new();
    // rust: w.string(&r.string(32767)?);
    // rust: let method = r.i8()?;
    // rust: w.i8(method);
    // rust: if method == 0 || method == 2 {
    // rust: let name = r.nbt()?;
    // rust: let options = r.i8()?;
    // rust: let visibility = r.varint()?;
    // rust: let collision = r.varint()?;
    // rust: let color = r.varint()?;
    // rust: let prefix = r.nbt()?;
    // rust: let suffix = r.nbt()?;
    // rust: w.nbt(&name);
    // rust: w.nbt(&prefix);
    // rust: w.nbt(&suffix);
    // rust: w.varint(visibility);
    // rust: w.varint(collision);
    // rust: <crate::buf::Opt<crate::buf::VarInt>>::write(
    // rust: &(0..16).contains(&color).then_some(color),
    // rust: &mut w,
    // rust: );
    // rust: w.i8(options);
}
    // rust: w.bytes(r.rest());
    // rust: Ok(w.data)
}

    /// Horizon's spectator_action names an entity by its network id; 26.1's spectate_entity (at the same
    /// id) by its UUID. Nothing is sent for one the client never saw added, or for no entity.
pub fn spectate(session: *Session, payload: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(target) = <crate::buf::OptVarInt>::read(&mut Reader::new(payload))? else {
    // rust: return Ok(None);
}
    // rust: let Some(uuid) = session.uuids.lock().unwrap().get(&target).copied() else {
    // rust: return Ok(None);
}
    // rust: let mut w = Writer::new();
    // rust: w.uuid(uuid);
    // rust: Ok(Some((SPECTATE_ENTITY, w.data)))
}

    /// 26.1's serverbound `spectate_entity` (play).
pub const SPECTATE_ENTITY: i32 = 62;

    // rust: mod tests {
//         use super::*;

pub fn a_26_1_team_reads_as_26_2s() void {
}
    // rust: let mut w = Writer::new();
    // rust: w.string("red");
    // rust: w.i8(0);
    // rust: w.nbt(&horizon_world::nbt::Tag::String("Red".into()));
    // rust: w.i8(3);
    // rust: w.varint(1);
    // rust: w.varint(2);
    // rust: w.varint(12); // RED
    // rust: w.nbt(&horizon_world::nbt::Tag::String("[".into()));
    // rust: w.nbt(&horizon_world::nbt::Tag::String("]".into()));
    // rust: w.varint(1);
    // rust: w.string("Steve");
    // rust: let body = team(&w.data).unwrap();
    // rust: let p =
    // rust: play::Clientbound::decode(packet_ids::play::clientbound::SET_PLAYER_TEAM, &body)
    // rust: .unwrap();
    // rust: let play::Clientbound::SetPlayerTeam(t) = p else {
    // rust: panic!("{p:?}")
}
    // rust: let params = t.parameters.unwrap();
    // rust: assert_eq!(params.color, Some(12));
    // rust: assert_eq!(params.options, 3);
    // rust: assert_eq!(params.name_tag_visibility, 1);
    // rust: assert_eq!(params.prefix, horizon_world::nbt::Tag::String("[".into()));
    // rust: assert_eq!(t.players, vec!["Steve".to_string()]);
}

pub fn reset_is_no_team_colour() void {
}
    // rust: let mut w = Writer::new();
    // rust: w.string("t");
    // rust: w.i8(2);
    // rust: w.nbt(&horizon_world::nbt::Tag::String("T".into()));
    // rust: w.i8(0);
    // rust: w.varint(0);
    // rust: w.varint(0);
    // rust: w.varint(21); // RESET
    // rust: w.nbt(&horizon_world::nbt::Tag::String("".into()));
    // rust: w.nbt(&horizon_world::nbt::Tag::String("".into()));
    // rust: let body = team(&w.data).unwrap();
    // rust: let p =
    // rust: play::Clientbound::decode(packet_ids::play::clientbound::SET_PLAYER_TEAM, &body)
    // rust: .unwrap();
    // rust: let play::Clientbound::SetPlayerTeam(t) = p else {
    // rust: panic!("{p:?}")
}
    // rust: assert_eq!(t.parameters.unwrap().color, None);
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn ids() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::super::ServerVersion::V26_2.ids().unwrap()
}

pub fn a_26_2_chunk_section_on_the_global_palette_is_repacked_wider() void {
}
    // rust: let ids = ids();
        // Every block a different state from 0..4096: past 8 bits, so the global palette at 15 bits.
    // rust: let values: Vec<i32> = (0..4096).map(|i| 13000 + i).collect();
    // rust: let old = Paletted::from_values(&values, Strategy::Blocks, 15);
    // rust: assert_eq!(old.bits, 15);
    // rust: let new = renumber_states(ids, &old, 16);
    // rust: assert_eq!(new.bits, 16);
        // oak_slab's first state, 13330 in 26.2, is 15177 in 26.3.
    // rust: assert_eq!(new.get(330), 15177);
    // rust: assert_eq!(new.get(0), ids.block_state.up(13000).unwrap());
}

pub fn a_26_2_move_reads_as_26_3s() void {
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(7);
    // rust: w.i16(4096);
    // rust: w.i16(0);
    // rust: w.i16(-2048);
    // rust: w.bool(true);
    // rust: let body = move_entity(&w.data, true, false).unwrap();
    // rust: let p = play::Clientbound::decode(packet_ids::play::clientbound::MOVE_ENTITY_POS, &body)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: p,
    // rust: play::Clientbound::MoveEntityPos(play::MoveEntityPos(play::MoveEntity {
    // rust: id: 7,
    // rust: delta: Some(play::VecDelta::Linear([4096, 0, -2048])),
    // rust: rotation: None,
    // rust: on_ground: true,
    // rust: }))
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: w.varint(7);
    // rust: w.i8(10);
    // rust: w.i8(-20);
    // rust: w.bool(false);
    // rust: let body = move_entity(&w.data, false, true).unwrap();
    // rust: let p = play::Clientbound::decode(packet_ids::play::clientbound::MOVE_ENTITY_ROT, &body)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: p,
    // rust: play::Clientbound::MoveEntityRot(play::MoveEntityRot(play::MoveEntity {
    // rust: id: 7,
    // rust: delta: None,
    // rust: rotation: Some((10, -20)),
    // rust: on_ground: false,
    // rust: }))
    // rust: );
}

pub fn a_26_2_swing_becomes_a_swing_animation() void {
}
    // rust: let (id, body) = animate(&[5, 3]).unwrap();
    // rust: assert_eq!(id, packet_ids::play::clientbound::SWING_ANIMATION);
    // rust: let p = play::Clientbound::decode(id, &body).unwrap();
    // rust: assert_eq!(
    // rust: p,
    // rust: play::Clientbound::SwingAnimation(play::SwingAnimation {
    // rust: id: 5,
    // rust: hand: 1,
    // rust: kind: 1,
    // rust: duration: 6
    // rust: })
    // rust: );
    // rust: assert_eq!(
    // rust: animate(&[5, 4]).unwrap(),
    // rust: (packet_ids::play::clientbound::ANIMATE, vec![5, 1])
    // rust: );
}

pub fn falling_blocks_are_known_in_both_numberings() void {
}
    // rust: let ids = ids();
    // rust: assert_eq!(
    // rust: ids.entity_type
    // rust: .down(packet_ids_entity::FALLING_BLOCK)
    // rust: .and_then(|o| ids.entity_type.up(o)),
    // rust: Some(packet_ids_entity::FALLING_BLOCK)
    // rust: );
}

pub fn a_26_2_light_mask_of_longs_becomes_26_3s_bytes() void {
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(3);
    // rust: w.varint(-2);
        // Sky mask: sections 0 and 2 (one long, 0b101); block mask: section 9 (bit 9); both empty masks none.
    // rust: for mask in [&[0b101_i64][..], &[1 << 9], &[], &[]] {
    // rust: w.varint(mask.len() as i32);
    // rust: mask.iter().for_each(|&l| w.i64(l));
}
    // rust: w.varint(0);
    // rust: w.varint(0);
    // rust: let body = light_update(&w.data).unwrap();
    // rust: let p =
    // rust: play::Clientbound::decode(packet_ids::play::clientbound::LIGHT_UPDATE, &body).unwrap();
    // rust: let play::Clientbound::LightUpdate(l) = p else {
    // rust: panic!("{p:?}");
}
    // rust: assert_eq!((l.x, l.z), (3, -2));
    // rust: assert_eq!(l.light.sky_mask, vec![0b101]);
    // rust: assert_eq!(l.light.block_mask, vec![0, 0b10]);
    // rust: assert!(l.light.empty_sky_mask.is_empty());
}

pub fn a_26_3_destroy_direction_change_is_not_sent_to_26_2() void {
}
    // rust: let session = Session::new(super::super::ServerVersion::V26_2);
    // rust: let action = |n: i32| {
    // rust: let mut w = Writer::new();
    // rust: w.varint(n);
    // rust: w.i64(0);
    // rust: w.u8(1);
    // rust: serverbound(
    // rust: &session,
    // rust: State::Play,
    // rust: packet_ids::play::serverbound::PLAYER_ACTION,
    // rust: &w.data,
    // rust: )
    // rust: .unwrap()
    // rust: .map(|(_, payload)| payload[0])
}
    // rust: assert_eq!(action(0), Some(0)); // start destroying
    // rust: assert_eq!(action(1), None); // change_destroy_direction, new in 26.3
    // rust: assert_eq!(action(3), Some(2)); // stop destroying: 3 in 26.3, 2 in 26.2
}
}
