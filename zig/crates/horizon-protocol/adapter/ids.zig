//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_ids
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registry ids an older server numbers differently: the tables `tools/generate_registry_id_adapter.py`
//! writes, and the per-thread context the item and particle readers consult while a packet from such a
//! server is decoded (an id there decides how the bytes after it read, so it must be renumbered as it is
//! read, not afterwards).
// use std::cell::Cell;

/// How one registry's ids differ between an older version and the pinned one.
pub const Remap = enum {
    /// Numbered alike.
    Same,
    /// Runs `(from, to, length)`: ids `from..from + length` map to `to..to + length`. `up` goes from the older
    /// version to the pinned one, `down` back. An id in no run has no entry on the other side.
    Runs {,
    up: &'static [(u16, u16, u16)],
    down: &'static [(u16, u16, u16)],
    // rust: },
};

pub fn lookup(runs: *[(u16) void {
}
    // rust: let id = u16::try_from(id).ok()?;
    // rust: let i = runs
    // rust: .partition_point(|&(from, _, _)| from <= id)
    // rust: .checked_sub(1)?;
    // rust: let (from, to, length) = runs[i];
    // rust: (id - from < length).then(|| i32::from(to + (id - from)))
}

    // rust: impl Remap {
    /// The pinned id of the older version's `id`; `None` when the pinned version has no such entry.
pub fn up(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Same => Some(id),
    // rust: Self::Runs { up, .. } => lookup(up, id),
}
}
    /// The older version's id of the pinned `id`; `None` when the older version has no such entry.
pub fn down(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Same => Some(id),
    // rust: Self::Runs { down, .. } => lookup(down, id),
}
}
}

/// Block states and every registry the protocol sends by id, for one older version.
pub const Ids = struct {
    /// How the older version lays out what the shared readers decode.
    quirks: Quirks,
    /// How many block states the older version and the pinned one have.
    states: (u32,
    block_state: Remap,
    item: Remap,
    entity_type: Remap,
    particle_type: Remap,
    sound_event: Remap,
    data_component_type: Remap,
    command_argument_type: Remap,
    custom_stat: Remap,
    map_decoration_type: Remap,
    block: Remap,
    block_entity_type: Remap,
    menu: Remap,
    mob_effect: Remap,
    attribute: Remap,
    stat_type: Remap,
    fluid: Remap,
    game_event: Remap,
    recipe_serializer: Remap,
    slot_display: Remap,
    recipe_display: Remap,
    recipe_book_category: Remap,
    villager_type: Remap,
    villager_profession: Remap,
    position_source_type: Remap,
    consume_effect_type: Remap,
    enchantment_effect_component_type: Remap,
    /// The data components the older version has and the pinned one lacks: their older ids and names.
    dropped_components: *'static [(u16,
    /// EntityDataSerializers' registration order (not a registry).
    entity_data_serializer: Remap,
};

/// Layout differences inside structures the pinned readers decode while ids are renumbered up.
pub const Quirks = struct {
    /// `SlotDisplay` type 6 holds a bare tag id (TagSlotDisplay) instead of a HolderSet (26.2).
    tag_slot_display_is_id: bool,
    /// `pot_decorations` is a list of up to four item ids, a brick for an undecorated side, instead of four
    /// optional item stack templates (26.2).
    pot_decorations_are_items: bool,
    /// `jukebox_playable` is an EitherHolder (a flag, then a song's key or holder) instead of a holder, and
    /// `damage_resistant` a bare damage type tag instead of a HolderSet (1.21.11).
    either_holder_song_and_tag_resistance: bool,
    /// `use_remainder` holds an ItemStack and `container` a list of optional ones (a count first, 0 for
    /// none) instead of item stack templates (1.21.11).
    stacks_in_components: bool,
};
    // rust: impl Quirks {
    // rust: pub const NONE: Self = Self {
    // rust: tag_slot_display_is_id: false,
    // rust: pot_decorations_are_items: false,
    // rust: either_holder_song_and_tag_resistance: false,
    // rust: stacks_in_components: false,
}
}

/// Whether an older server's packet is being read on this thread.
pub fn reading_older() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(ACTIVE.get(), Some((_, Way::Up)))
}

/// Reads and writes the pinned numbering on this thread until the guard drops: for values already
/// renumbered while an older server's packet is read.
pub fn pinned() G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Guard(ACTIVE.replace(None))
}

/// The older version's quirks while its packets are decoded on this thread; none otherwise.
pub fn quirks() Q {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ACTIVE.get() {
    // rust: Some((ids, Way::Up)) => ids.quirks,
    // rust: _ => Quirks::NONE,
}
}

    // rust: impl Ids {
    /// Bits per entry of a chunk section's global block palette: the older version's, then the pinned one's
    /// (`Mth.ceillog2` of the state count).
pub fn state_bits(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bits = |n: u32| (u32::BITS - n.saturating_sub(1).leading_zeros()) as u8;
    // rust: (bits(self.states.0), bits(self.states.1))
}
}

/// Which way ids are being renumbered on this thread.
pub const Way = enum {
    /// Decoding what an older server sent: its ids become the pinned version's.
    Up,
    /// Encoding for an older server: the pinned ids become its own.
    Down,
};

    // rust: thread_local! {
pub const ACTIVE: Cell<?(*'static Ids, Way)> = const { Cell::new(None) };
}

/// Renumber ids `way` on this thread until the guard drops. Readers and writers that pick a layout by an id
/// (item stacks, data components, particles) consult it through [`item`], [`component`] and [`particle`].
pub fn renumbering(ids: *'static Ids, way: Way) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Guard(ACTIVE.replace(Some((ids, way))))
}

/// Restores the previous context when dropped.
pub const Guard = struct {};
    // rust: impl Drop for Guard {
pub fn drop(self: *Self) void {
}
    // rust: ACTIVE.set(self.0);
}
}

pub fn apply(id: i32, pick: impl Fn(*Ids) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ACTIVE.get() {
    // rust: None => id,
        // An id the other side lacks becomes -1, which every reader turns away or reads as nothing.
    // rust: Some((ids, Way::Up)) => pick(ids).up(id).unwrap_or(-1),
    // rust: Some((ids, Way::Down)) => pick(ids).down(id).unwrap_or(-1),
}
}

/// An item id as read or about to be written on this thread.
pub fn item(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.item)
}
/// A data component type id as read or about to be written on this thread.
pub fn component(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.data_component_type)
}
/// The name of the data component an older server sent as `id` (its own number) that the pinned version
/// no longer has, while such a server's packet is read on this thread. The readers read its value past and
/// drop it.
pub fn dropped_component(id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ACTIVE.get() {
    // rust: Some((ids, Way::Up)) => ids
    // rust: .dropped_components
    // rust: .iter()
    // rust: .find(|(old, _)| i32::from(*old) == id)
    // rust: .map(|(_, name)| *name),
    // rust: _ => None,
}
}
/// A particle type id as read or about to be written on this thread.
pub fn particle(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.particle_type)
}
/// A block state id as read or about to be written on this thread.
pub fn block_state(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.block_state)
}
/// An entity type id as read or about to be written on this thread.
pub fn entity_type(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.entity_type)
}
/// A sound event id as read or about to be written on this thread.
pub fn sound_event(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.sound_event)
}
/// An entity data serializer id as read on this thread.
pub fn entity_data_serializer(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.entity_data_serializer)
}
/// A slot display type id as read on this thread.
pub fn slot_display(id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: apply(id, |ids| ids.slot_display)
}
/// The ids on this thread now, if any.
pub fn active() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ACTIVE.get()
}

    // rust: mod tests {
//     use super::*;

pub fn runs_map_inside_and_nothing_outside() void {
}
    // rust: let runs = Remap::Runs {
    // rust: up: &[(0, 0, 3), (3, 5, 2)],
    // rust: down: &[(0, 0, 3), (5, 3, 2)],
}
    // rust: assert_eq!(runs.up(2), Some(2));
    // rust: assert_eq!(runs.up(3), Some(5));
    // rust: assert_eq!(runs.up(4), Some(6));
    // rust: assert_eq!(runs.up(5), None);
    // rust: assert_eq!(runs.up(-1), None);
    // rust: assert_eq!(runs.down(3), None);
    // rust: assert_eq!(runs.down(6), Some(4));
}

pub fn the_context_lasts_while_its_guard_does() void {
}
pub const IDS: Ids = super::super::v26_2_ids::IDS;
    // rust: assert_eq!(item(926), 926);
    // rust: {
            // diamond: 926 in 26.2, 1012 in 26.3.
    // rust: let _up = renumbering(&IDS, Way::Up);
    // rust: assert_eq!(item(926), 1012);
    // rust: {
    // rust: let _down = renumbering(&IDS, Way::Down);
    // rust: assert_eq!(item(1012), 926);
}
    // rust: assert_eq!(item(926), 1012);
}
    // rust: assert_eq!(item(926), 926);
}

pub fn the_26_2_tables_match_the_reports() void {
}
        // Read off both versions' registries and blocks reports by hand.
    // rust: let ids = crate::adapter::ServerVersion::V26_2.ids().unwrap();
    // rust: assert_eq!(ids.item.up(926), Some(1012)); // diamond
    // rust: assert_eq!(ids.item.up(1), Some(1)); // stone
    // rust: assert_eq!(ids.block_state.up(13330), Some(15177)); // oak_slab type=top waterlogged=true
    // rust: assert_eq!(ids.block_state.up(3987), Some(5543)); // chest, first state
    // rust: assert_eq!(ids.block_state.up(8), Some(8)); // grass_block
    // rust: assert_eq!(ids.state_bits(), (15, 16));
}

pub fn components_the_pinned_version_dropped_are_read_past() void {
}
//         use crate::buf::{Codec, Reader, Writer};
//         use crate::item::{Component, Slot};
    // rust: let ids = crate::adapter::ServerVersion::V1_21_11.ids().unwrap();
        // A filled map (1104 in 1.21.11, 1238 in 26.3) as a 1.21.11 server sends it. Its patch adds
        // map_color (43, gone in 26.3), swing_animation (40, gone too), damage 5 (3 in both) and a
        // tooltip_display (18 in both) hiding dyed_color (42, 47 in 26.3) and swing_animation; it removes
        // map_color and potion_contents (49, 53 in 26.3). Ids read off both versions' registries reports.
    // rust: let sent = [
    // rust: 1, 0xd0, 0x08, // count, item
    // rust: 4, 2, // added, removed
    // rust: 43, 0x00, 0xff, 0x00, 0x00, // map_color: a big-endian int
    // rust: 40, 1, 6, // swing_animation: its type and duration
    // rust: 3, 5, // damage
    // rust: 18, 0, 2, 42, 40, // tooltip_display: shown, two hidden components
    // rust: 43, 49, // removed
    // rust: ];
    // rust: let stack = {
    // rust: let _up = renumbering(ids, Way::Up);
    // rust: Slot::read(&mut Reader::new(&sent)).unwrap().unwrap()
}
    // rust: assert_eq!((stack.item, stack.count), (1238, 1));
    // rust: assert_eq!(
    // rust: stack.added,
    // rust: [
    // rust: (3, Component::Int(5)),
    // rust: (
    // rust: 18,
    // rust: Component::TooltipDisplay {
    // rust: hide: false,
    // rust: hidden: vec![47],
    // rust: },
    // rust: ),
    // rust: ]
    // rust: );
    // rust: assert_eq!(stack.removed, [53]);
        // Written back to that server, the kept components take its numbers again.
    // rust: let mut w = Writer::new();
    // rust: {
    // rust: let _down = renumbering(ids, Way::Down);
    // rust: Slot::write(&Some(stack), &mut w);
}
    // rust: assert_eq!(w.data, [1, 0xd0, 0x08, 2, 1, 3, 5, 18, 0, 1, 42, 49]);
}

pub fn components_whose_layout_changed_are_read_in_the_servers() void {
}
//         use crate::buf::{Codec, Reader};
//         use crate::item::{Component, Slot};
    // rust: let ids = crate::adapter::ServerVersion::V1_21_11.ids().unwrap();
    // rust: let read = |sent: &[u8]| {
    // rust: let _up = renumbering(ids, Way::Up);
    // rust: Slot::read(&mut Reader::new(sent)).unwrap().unwrap()
}
        // A decorated pot (319 in 1.21.11, 392 in 26.3) as a 1.21.11 server sends it: pot_decorations (72)
        // lists a brick (1025) and an angler sherd (1445, 1598 in 26.3); damage_resistant (27) a tag id;
        // jukebox_playable (62) a song by holder: the flag set, then the song's id plus one.
    // rust: let mut sent = vec![1, 0xbf, 0x02, 3, 0];
    // rust: sent.extend([72, 2, 0x81, 0x08, 0xa5, 0x0b]);
    // rust: sent.extend([27, 17]);
    // rust: sent.extend(b"minecraft:is_fire");
    // rust: sent.extend([62, 1, 3]);
    // rust: let stack = read(&sent);
    // rust: assert_eq!(stack.item, 392);
    // rust: let mut resistant = vec![0, 17];
    // rust: resistant.extend(b"minecraft:is_fire");
    // rust: assert_eq!(
    // rust: stack.added,
    // rust: [
                // Only the left side holds an item: one sherd by its pinned id, no components.
    // rust: (76, Component::Raw(vec![0, 1, 0xbe, 0x0c, 1, 0, 0, 0, 0])),
    // rust: (27, Component::Raw(resistant)),
    // rust: (66, Component::Raw(vec![3])),
    // rust: ]
    // rust: );
        // A song named by its key has no pinned holder: the component goes.
    // rust: let mut sent = vec![1, 0xbf, 0x02, 1, 0, 62, 0, 13];
    // rust: sent.extend(b"minecraft:cat");
    // rust: assert_eq!(read(&sent).added, []);
}

pub fn items_inside_components_take_the_pinned_ids_and_layout() void {
}
//         use crate::buf::{Codec, Reader};
//         use crate::item::{Component, Slot};
    // rust: let ids = crate::adapter::ServerVersion::V1_21_11.ids().unwrap();
        // A shulker box (581 in 1.21.11, 656 in 26.3) as a 1.21.11 server sends it. Its container (73, 77
        // in 26.3) lists ItemStacks, a count first: two diamonds (898, 1012 in 26.3) with a map_color (43,
        // gone in 26.3), then an empty slot. Its use_remainder (25 in both) is a bowl (892, 1006).
    // rust: let sent = [
    // rust: 1, 0xc5, 0x04, 2, 0, // the box, two added components
    // rust: 73, 2, 2, 0x82, 0x07, 1, 0, 43, 0, 0, 0, 5, 0, // container
    // rust: 25, 1, 0xfc, 0x06, 0, 0, // use_remainder
    // rust: ];
    // rust: let stack = {
    // rust: let _up = renumbering(ids, Way::Up);
    // rust: Slot::read(&mut Reader::new(&sent)).unwrap().unwrap()
}
    // rust: assert_eq!(stack.item, 656);
        // Templates, the item first: the diamonds without the color, then no item.
    // rust: assert_eq!(
    // rust: stack.added,
    // rust: [
    // rust: (77, Component::Raw(vec![2, 1, 0xf4, 0x07, 2, 0, 0, 0])),
    // rust: (25, Component::Raw(vec![0xee, 0x07, 1, 0, 0])),
    // rust: ]
    // rust: );
}

pub fn an_item_stack_is_read_and_written_in_the_servers_numbering() void {
}
//         use crate::buf::{Codec, Reader, Writer};
//         use crate::item::{Slot, Stack};
    // rust: let ids = crate::adapter::ServerVersion::V26_2.ids().unwrap();
        // Three diamonds as a 26.2 server sends them: item 926, no components.
    // rust: let sent = [3, 0x9e, 0x07, 0, 0];
    // rust: let stack = {
    // rust: let _up = renumbering(ids, Way::Up);
    // rust: Slot::read(&mut Reader::new(&sent)).unwrap().unwrap()
}
    // rust: assert_eq!((stack.item, stack.count), (1012, 3));
    // rust: let mut w = Writer::new();
    // rust: {
    // rust: let _down = renumbering(ids, Way::Down);
    // rust: Slot::write(&Some(Stack::new(1012, 3)), &mut w);
}
    // rust: assert_eq!(w.data, sent);
}
}
