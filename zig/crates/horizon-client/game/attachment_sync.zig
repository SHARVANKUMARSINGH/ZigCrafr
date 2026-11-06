//! Transpiled from Horizon Rust crate
//! Module: horizon-client_attachment_sync
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Attachment sync (docs/native-mods.md, "Server attachments"): the server
//! sends the synced values of the holders a level pass lent to mods, and whole
//! snapshots to the players who started seeing a holder; a client keeps them.
// use super::{Game, lan::LanHost};
// use crate::lan::{
    // rust: guest::Guest,
    // rust: hub::{AttachmentSnapshot, Hub},
}
// use horizon_protocol::attachment_sync::{self, Message};
// use horizon_world::attachments::{Attachments, Holder};

/// The guests `holder`'s changes go to: those in the level in place who see it,
/// and a player's own wherever they are.
pub fn recipients(hub: *Hub, holder: Holder) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let owner = match holder {
    // rust: Holder::Player(uuid) => hub.guests.iter().find(|g| g.uuid == uuid),
    // rust: _ => None,
}
    // rust: let sees = move |g: &Guest| match holder {
    // rust: Holder::Level => true,
    // rust: Holder::Chunk([x, z]) => g.sent_chunks.contains(&(x, z)),
    // rust: Holder::BlockEntity([x, _, z]) => g.sent_chunks.contains(&(x >> 4, z >> 4)),
    // rust: Holder::Entity(id) => g.tracker.is_tracking(id as i32),
    // rust: Holder::Player(_) => owner.is_some_and(|o| g.tracker.is_tracking(o.entity_id)),
    // rust: _ => false,
}
    // rust: hub.guests.iter().filter(move |g| {
    // rust: matches!(holder, Holder::Player(uuid) if g.uuid == uuid) || (hub.here(g) && sees(g))
    // rust: })
}

    // rust: impl Game<'_> {
    /// The messages that give a player `holder`'s synced attachments whole: its
    /// own, and for a chunk those of its block entities. A player holder with
    /// none still gives one, to drop what the client holds.
pub fn attachment_snapshot(self: *Self, holder: Holder) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let changes = match holder {
            // Read in place: a chunk lent to a mod is copied and saved.
    // rust: Holder::Chunk([x, z]) => self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(x, z))
    // rust: .and_then(|chunk| chunk.saved.as_ref())
    // rust: .map(|extras| extras.attachments.synced()),
            // Read in place: lending the map would give the entity one.
    // rust: Holder::Entity(id) => self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&id)
    // rust: .and_then(|uuid| self.entity_attachments.get(uuid))
    // rust: .map(|map| map.synced()),
    // rust: _ => self
    // rust: .attachment_map_quiet(holder)
    // rust: .ok()
    // rust: .map(|map| map.synced()),
}
    // rust: .unwrap_or_default();
    // rust: let mut holders = vec![(holder, changes)];
    // rust: if let Holder::Chunk([x, z]) = holder {
    // rust: holders.extend(
    // rust: self.world
    // rust: .block_entities
    // rust: .chunk_attachments(x, z)
    // rust: .into_iter()
    // rust: .map(|((x, y, z), map)| (Holder::BlockEntity([x, y, z]), map.synced())),
    // rust: );
}
    // rust: holders
    // rust: .into_iter()
    // rust: .filter(|(holder, changes)| !changes.is_empty() || matches!(holder, Holder::Player(_)))
    // rust: .map(|(holder, changes)| Message {
    // rust: holder,
    // rust: replace: true,
    // rust: changes,
    // rust: })
    // rust: .collect()
}

    /// The holders players started seeing are sent whole to them, in the pass
    /// of the level they are in (another's stay queued), then the synced
    /// changes of the holders lent to mods since the last pass to the players
    /// who see them.
    // rust: pub(super) fn flush_attachment_sync(&mut self, host: &mut LanHost) {
    // rust: let hub = &mut host.hub;
    // rust: for snapshot in std::mem::take(&mut hub.attachment_snapshots) {
    // rust: let AttachmentSnapshot { player, holder } = snapshot;
    // rust: let Some(guest) = hub.guests.iter().find(|g| g.uuid == player) else {
    // rust: continue;
}
    // rust: if !guest.reads_attachment_sync() {
    // rust: continue;
}
    // rust: if guest.dimension != hub.config.dimension {
    // rust: hub.attachment_snapshots.push(snapshot);
    // rust: continue;
}
            // A guest is a player holder, whose entity another player tracks.
    // rust: let holder = match holder {
    // rust: Holder::Entity(id) => hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id == id as i32)
    // rust: .map_or(holder, |g| Holder::Player(g.uuid)),
    // rust: _ => holder,
}
    // rust: for message in self.attachment_snapshot(holder) {
    // rust: guest.send_attachment_sync(&message);
}
}
    // rust: for holder in std::mem::take(&mut self.world.attachment_syncs) {
    // rust: let Ok(map) = self.attachment_map_quiet(holder) else {
    // rust: continue;
}
    // rust: let changes = map.take_sync_changes();
    // rust: if changes.is_empty() {
    // rust: continue;
}
    // rust: let message = Message {
    // rust: holder,
    // rust: replace: false,
    // rust: changes,
}
    // rust: for guest in recipients(hub, holder) {
    // rust: guest.send_attachment_sync(&message);
}
}
}
}

    // rust: impl Game<'_> {
    /// A `horizon:attachment_sync` payload the server sent the window.
    // rust: pub(super) fn remote_attachment_sync(&mut self, data: &[u8]) {
    // rust: let message = match attachment_sync::decode(data) {
    // rust: Ok(message) => message,
    // rust: Err(e) => return log::debug!("Horizon: a bad attachment sync: {e}"),
}
    // rust: let Some(remote) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let map = remote.attachments.entry(message.holder).or_default();
    // rust: if message.replace {
    // rust: *map = Attachments::default();
}
    // rust: for change in message.changes {
    // rust: map.apply_sync(change);
}
}
}
