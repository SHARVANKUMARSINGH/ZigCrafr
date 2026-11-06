//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mod_api_host
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::{BlockStateId, Game};
// use horizon_client::mod_api::BlockPos;
// use horizon_world::{
    // rust: attachments::{ATTACHMENTS_KEY, attachment_compound},
    // rust: level::Ticks,
}

    // rust: fn world_attachments(
    // rust: world: &mut horizon_client::world::World,
    // rust: holder: horizon_client::mod_api::Holder,
    // rust: ) -> Result<&mut horizon_client::mod_api::Attachments, horizon_client::mod_api::AttachmentError> {
//     use horizon_client::mod_api::{AttachmentError, Holder};
    // rust: if holder == Holder::Level {
    // rust: return Ok(&mut world.attachments);
}
    // rust: if let Holder::BlockEntity([x, y, z]) = holder {
    // rust: let pos = (x, y, z);
    // rust: let chunk = world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .ok_or(AttachmentError::MissingHolder)?;
    // rust: attachment_compound(
    // rust: chunk
    // rust: .saved
    // rust: .as_ref()
    // rust: .and_then(|e| e.block_entity_sources.iter().find(|(p, _)| *p == pos))
    // rust: .and_then(|(_, tag)| tag.get(ATTACHMENTS_KEY)),
    // rust: )?;
    // rust: let map = world
    // rust: .block_entities
    // rust: .attachments_mut(pos)
    // rust: .ok_or(AttachmentError::MissingHolder)?;
    // rust: world.modified.insert((x >> 4, z >> 4));
    // rust: return Ok(map);
}
    // rust: let Holder::Chunk([x, z]) = holder else {
    // rust: return Err(AttachmentError::MissingHolder);
}
    // rust: let chunk = world
    // rust: .chunks
    // rust: .get_mut(&(x, z))
    // rust: .ok_or(AttachmentError::MissingHolder)?;
    // rust: let chunk = std::sync::Arc::make_mut(chunk);
    // rust: let extras = std::sync::Arc::make_mut(chunk.saved.get_or_insert_with(Default::default));
    // rust: attachment_compound(extras.root.get(&ATTACHMENTS_KEY.into()))?;
    // rust: world.modified.insert((x, z));
    // rust: Ok(&mut extras.attachments)
}

    // rust: impl Game<'_> {
    /// A guest's attachments back in their record, for `playerdata` to save.
    // rust: pub(super) fn guest_attachments_into(&self, guest: &mut horizon_client::lan::guest::Guest) {
    // rust: guest.attachments = self
    // rust: .guest_attachments
    // rust: .get(&guest.uuid)
    // rust: .cloned()
    // rust: .unwrap_or_default();
}

    /// Whether entity `id` is in the level, as a holder of attachments: one walk
    /// over the entity lists (a kind added there holds attachments too), then the
    /// kinds that are not on it.
pub fn attachment_entity_exists(self: *Self, id: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use super::entity::{Entity as _, entity_lists_of, for_each_entity};
    // rust: let mut found = false;
    // rust: for_each_entity!(entity_lists_of!(self), entity => {
    // rust: found |= entity.id() == id && !entity.is_removed();
    // rust: });
    // rust: found || self.entity_ids_off_walk().any(|e| e == id)
}

    /// The attachments of entities that left the level, dropped: each tick
    /// while any entity has some. Only those entities are looked at, and
    /// nothing else of the entities' memory changes.
    // rust: pub(super) fn prune_entity_attachments(&mut self) {
    // rust: let gone: Vec<[i32; 4]> = self
    // rust: .persist
    // rust: .uuids
    // rust: .iter()
    // rust: .filter(|(id, uuid)| {
    // rust: self.entity_attachments.contains_key(*uuid) && !self.attachment_entity_exists(**id)
    // rust: })
    // rust: .map(|(_, uuid)| *uuid)
    // rust: .collect();
    // rust: for uuid in gone {
    // rust: self.entity_attachments.remove(&uuid);
}
}

    // rust: pub(super) fn native_authoritative(&self) -> bool {
    // rust: self.serving.is_some() || self.options.dedicated.is_some()
}

    /// Access a holder's attachment map, to lend to a mod: a server's, whose
    /// synced changes are sent at the pass's end, or a client's copy of what
    /// its server synced.
    // rust: pub(super) fn attachment_map(
    // rust: &mut self,
    // rust: holder: horizon_client::mod_api::Holder,
    // rust: ) -> Result<&mut horizon_client::mod_api::Attachments, horizon_client::mod_api::AttachmentError>
    // rust: {
    // rust: if self.native_authoritative() {
    // rust: self.world.attachment_syncs.insert(holder);
    // rust: return self.attachment_map_quiet(holder);
}
    // rust: match self.remote.as_mut() {
    // rust: Some(remote) => Ok(remote.attachments.entry(holder).or_default()),
    // rust: None => Err(horizon_client::mod_api::AttachmentError::MissingHolder),
}
}

    /// `attachment_map` without recording the holder for the sync.
    // rust: pub(super) fn attachment_map_quiet(
    // rust: &mut self,
    // rust: holder: horizon_client::mod_api::Holder,
    // rust: ) -> Result<&mut horizon_client::mod_api::Attachments, horizon_client::mod_api::AttachmentError>
    // rust: {
//         use horizon_client::mod_api::AttachmentError;
    // rust: if !self.native_authoritative() {
    // rust: return Err(AttachmentError::MissingHolder);
}
    // rust: if let horizon_client::mod_api::Holder::Entity(id) = holder {
    // rust: if !self.attachment_entity_exists(id) {
    // rust: return Err(AttachmentError::MissingHolder);
}
    // rust: attachment_compound(
    // rust: self.persist
    // rust: .raw
    // rust: .get(&id)
    // rust: .and_then(|tag| tag.get(ATTACHMENTS_KEY)),
    // rust: )?;
    // rust: let uuid = self.uuid_for(id);
    // rust: return Ok(self.entity_attachments.entry(uuid).or_default());
}
    // rust: if let horizon_client::mod_api::Holder::Player(uuid) = holder {
    // rust: if self.lan_acting_uuid == Some(uuid) {
    // rust: return Ok(&mut self.player_attachments);
}
    // rust: return self
    // rust: .guest_attachments
    // rust: .get_mut(&uuid)
    // rust: .ok_or(AttachmentError::MissingHolder);
}
    // rust: world_attachments(&mut self.world, holder)
}
}

    // rust: mod generated {
    // rust: include!(concat!(env!("OUT_DIR"), "/mod_api_host_generated.rs"));
}

    // rust: impl horizon_client::mod_api::LevelHost for super::GameLevel<'_> {
pub fn block_state(self: *Self, pos: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::level::LevelAccess::block_state(self, BlockPos::new(pos[0], pos[1], pos[2]))
}
pub fn is_client_side(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::level::LevelAccess::is_client_side(self)
}
    // rust: fn state_with_property(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId> {
    // rust: self.native_state_with_property(state, key, value)
}
}

    // rust: impl horizon_client::mod_api::LevelRandomHost for super::GameLevel<'_> {
    // rust: fn attachments(
    // rust: &mut self,
    // rust: holder: horizon_client::mod_api::Holder,
    // rust: ) -> Result<&mut horizon_client::mod_api::Attachments, horizon_client::mod_api::AttachmentError>
    // rust: {
    // rust: if !self.native_authoritative {
    // rust: return Err(horizon_client::mod_api::AttachmentError::MissingHolder);
}
    // rust: self.world.attachment_syncs.insert(holder);
    // rust: world_attachments(self.world, holder)
}
pub fn random(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.native_level_random()
}
}

    // rust: pub(super) struct LevelTicks<'a, L> {
    // rust: pub level: L,
    // rust: pub ticks: &'a mut Ticks,
}

    // rust: impl<'a, L: std::ops::Deref<Target = super::GameLevel<'a>>> horizon_client::mod_api::LevelHost
    // rust: for LevelTicks<'_, L>
    // rust: {
pub fn block_state(self: *Self, pos: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::mod_api::LevelHost::block_state(&*self.level, pos)
}
pub fn is_client_side(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::mod_api::LevelHost::is_client_side(&*self.level)
}
    // rust: fn state_with_property(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId> {
    // rust: horizon_client::mod_api::LevelHost::state_with_property(&*self.level, state, key, value)
}
}

    // rust: impl horizon_client::mod_api::LevelRandomHost for LevelTicks<'_, &mut super::GameLevel<'_>> {
    // rust: fn attachments(
    // rust: &mut self,
    // rust: holder: horizon_client::mod_api::Holder,
    // rust: ) -> Result<&mut horizon_client::mod_api::Attachments, horizon_client::mod_api::AttachmentError>
    // rust: {
    // rust: horizon_client::mod_api::LevelRandomHost::attachments(&mut *self.level, holder)
}
pub fn random(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::mod_api::LevelRandomHost::random(&mut *self.level)
}
}

    // rust: impl<'a, L: std::ops::Deref<Target = super::GameLevel<'a>>> horizon_client::mod_api::LevelTicksHost
    // rust: for LevelTicks<'_, L>
    // rust: {
pub fn schedule_block_tick(self: *Self, pos: [i32; 3], block: []const u8, delay: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level
    // rust: .native_schedule_block_tick(self.ticks, pos, block, delay)
}
pub fn schedule_fluid_tick(self: *Self, pos: [i32; 3], fluid: []const u8, delay: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level
    // rust: .native_schedule_fluid_tick(self.ticks, pos, fluid, delay)
}
}

    // rust: impl horizon_client::mod_api::LevelWriteHost for LevelTicks<'_, &mut super::GameLevel<'_>> {
pub fn set_block_property(self: *Self, pos: [i32; 3], key: []const u8, value: []const u8, flags: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level
    // rust: .native_set_block_property(self.ticks, pos, key, value, flags)
}

    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: &str,
    // rust: at: [f64; 3],
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> bool {
    // rust: self.level
    // rust: .native_play_sound(sound, at, source, volume, pitch)
}

    // rust: fn send_particles(
    // rust: &mut self,
    // rust: options: &horizon_client::mod_api::ParticleOptions,
    // rust: state: Option<BlockStateId>,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: i32,
    // rust: ) -> bool {
    // rust: self.level
    // rust: .native_send_particles(options, state, at, spread, speed, count)
}
}
