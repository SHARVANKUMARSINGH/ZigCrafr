//! Transpiled from Horizon Rust crate
//! Module: horizon-client_beds
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Beds' `occupied` (`BedBlock.OCCUPIED`): the head of a bed someone sleeps
//! in, which the foot copies (`updateShape`). `LivingEntity.startSleeping`
//! sets it and `stopSleeping` clears it. A villager's come with its mob
//! events (`MobEvent::BedOccupied`); a player's bed is set when it lies
//! down (`try_sleep`) and freed in the level's tick once nobody sleeps in it
//! any more, whichever way they got up: waking, the Leave Bed button, death,
//! a broken bed, or leaving the game.
// use super::{Dim, Game};
// use horizon_client::Result;
// use horizon_core::geometry::Vec3;
// use horizon_world::registry::BlockStateId;

    // rust: impl Game<'_> {
    /// `setBlockAndUpdate(head, state.setValue(OCCUPIED, occupied))`, when
    /// the block at `head` is still a bed and not already so.
    // rust: pub(super) fn set_bed_occupied(&mut self, head: [i32; 3], occupied: bool) {
    // rust: let registry = &self.pack.assets.registry;
    // rust: let Some(mut state) = registry
    // rust: .state(self.world.block(head[0], head[1], head[2]))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
    // rust: let value = if occupied { "true" } else { "false" };
    // rust: if state.properties.get("occupied").is_none_or(|v| v == value) {
    // rust: return;
}
    // rust: state.properties.insert("occupied".into(), value.into());
    // rust: let Some(id) = registry.id(&state) else {
    // rust: return;
}
    // rust: if let Err(e) = self.level_set(head, id) {
    // rust: log::warn!("could not mark the bed at {head:?} occupied={value}: {e}");
}
}

    /// `LivingEntity.startSleeping` for the player in place (the host, or
    /// a guest during its turn): the bed it lies in is occupied.
    // rust: pub(super) fn occupy_bed(&mut self, head: [i32; 3]) {
    // rust: self.set_bed_occupied(head, true);
    // rust: if !self.player_beds.contains(&(self.dim, head)) {
    // rust: self.player_beds.push((self.dim, head));
}
}

    /// Whether a player in the level in place still sleeps in `head`.
pub fn player_in_bed(self: *Self, head: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sleeping == Some(head)
    // rust: || self.lan.as_ref().is_some_and(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .any(|g| g.bed == Some(head) && g.dimension == self.dim.id())
    // rust: })
}

    /// `LivingEntity.stopSleeping` for the players who got up: the beds of
    /// this level nobody sleeps in any more are free again. Runs in each
    /// level's tick, after the players' packets and sleep ticks, never inside
    /// a guest's turn (where the hub is taken out of `Game`).
    // rust: pub(super) fn free_left_beds(&mut self) {
    // rust: let dim = self.dim;
    // rust: let left: Vec<[i32; 3]> = self
    // rust: .player_beds
    // rust: .iter()
    // rust: .filter(|(d, head)| *d == dim && !self.player_in_bed(*head))
    // rust: .map(|(_, head)| *head)
    // rust: .collect();
    // rust: for head in left {
    // rust: self.player_beds.retain(|b| *b != (dim, head));
    // rust: self.set_bed_occupied(head, false);
            // AbstractBedBlock.onStopSleeping: the Overworld's straw_bed_rule
            // has destroy_on_leave, so a straw bed breaks when its sleeper gets up.
    // rust: let bed = self.world.block(head[0], head[1], head[2]);
    // rust: let straw = &*self.res.facts().get(bed).name == "minecraft:straw_bed";
    // rust: if dim == Dim::Overworld
    // rust: && straw
    // rust: && let Err(e) = self.destroy_straw_bed(head)
    // rust: {
    // rust: log::warn!("could not break the straw bed at {head:?}: {e}");
}
}
}

    /// The levels with a bed a player marked occupied: they tick until the
    /// bed is freed.
    // rust: pub(super) fn player_bed_levels(&self) -> impl Iterator<Item = Dim> + '_ {
    // rust: self.player_beds.iter().map(|(d, _)| *d)
}

    /// `PlayerList.removeAll` before the server's last save: every player
    /// leaves (`ServerPlayer.disconnect` stops its sleep), so no bed is
    /// saved occupied by a player who is not in it when the world opens
    /// again. Each bed is freed in its own level.
    // rust: pub(super) fn free_player_beds(&mut self) -> Result<()> {
    // rust: if self.player_beds.is_empty() {
    // rust: return Ok(());
}
    // rust: let back = self.dim;
    // rust: for (dim, head) in std::mem::take(&mut self.player_beds) {
    // rust: self.enter_level(None, dim)?;
            // A client holds no other levels (`enter_level`).
    // rust: if self.dim == dim {
    // rust: self.set_bed_occupied(head, false);
}
}
    // rust: self.enter_level(None, back)
}
}

/// The part of a bed a sleeper lies on: `AbstractBedBlock.getSleepHeight`
/// answers with the shape of the block it is given, and `StrawBedBlock`
/// first walks a head over to its foot, so a straw bed is slept on at its
/// foot's shape while the head's own (the pillow's) is taller.
pub const SleepOn = enum {
    /// The head itself: `BedBlock` and every other bed.
    Head,
    /// The foot the straw bed's head lies against.
    Foot,
};

/// `StrawBedBlock.getSleepHeight` then `AbstractBedBlock.getSleepHeight`: the
/// part whose shape the sleeper lies on, or no part at all. A straw bed's
/// head takes its foot's block, and only a foot of the same block will do:
/// with the foot broken, or replaced by something else, the height is empty
/// (`OptionalDouble.empty`) and `LivingEntity.startSleeping` returns false,
/// so nobody lies in the half that is left.
pub fn slept_on(bed: []const u8, part: ?[]const u8, foot: Option<([]const u8) void {
}
    // rust: if bed != "minecraft:straw_bed" || part != Some("head") {
    // rust: return Some(SleepOn::Head);
}
    // rust: match foot {
    // rust: Some(("minecraft:straw_bed", Some("foot"))) => Some(SleepOn::Foot),
    // rust: _ => None,
}
}

/// `VoxelShape.max(Axis.Y)` of the boxes the pack gives a block, in the
/// block's own coordinates: the top of the bed, `1.0` for a full cube, and
/// `None` for a shape with nothing in it (`VoxelShape.isEmpty`).
pub fn shape_top(boxes: *[[f64; 6]], base_y: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: boxes
    // rust: .iter()
    // rust: .map(|b| b[4] - base_y)
    // rust: .fold(None, |top: Option<f64>, y| {
    // rust: Some(top.map_or(y, |top| top.max(y)))
    // rust: })
}

/// `LivingEntity.setPosToBed`: the middle of the sleeper's block, `0.125`
/// above the top of the shape, which `getSleepHeight` measured from that
/// block's own y.
pub fn pos_to_bed(head: [i32; 3], height: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + height + 0.125,
    // rust: f64::from(head[2]) + 0.5,
    // rust: )
}

    // rust: impl Game<'_> {
    /// The bed's `part`: head or foot.
pub fn bed_part(self: *Self, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("part").cloned())
}
    /// `LivingEntity.startSleeping`'s height: the top of the shape the player
    /// lies on, measured from the head's own y - a straw bed's head from its
    /// foot's - or `None` when there is no such shape, in which case the
    /// player does not lie down at all.
    // rust: pub(super) fn sleep_height(&self, head: [i32; 3]) -> Option<f64> {
    // rust: let state = self.world.block(head[0], head[1], head[2]);
    // rust: let name = self.res.facts().get(state).name.to_owned();
    // rust: let part = self.bed_part(state);
    // rust: let step = self.bed_forward(state);
    // rust: let foot_at = [head[0] - step[0], head[1], head[2] - step[2]];
    // rust: let foot_state = self.world.block(foot_at[0], foot_at[1], foot_at[2]);
    // rust: let foot_name = self.res.facts().get(foot_state).name.to_owned();
    // rust: let foot_part = self.bed_part(foot_state);
    // rust: let on = slept_on(
    // rust: &name,
    // rust: part.as_deref(),
    // rust: Some((&foot_name, foot_part.as_deref())),
    // rust: )?;
    // rust: let at = match on {
    // rust: SleepOn::Head => head,
    // rust: SleepOn::Foot => foot_at,
}
    // rust: shape_top(&self.outline_boxes(at), f64::from(at[1]))
}
    /// Where the sleeper lies (`setPosToBed`), when the bed gives it a shape.
    // rust: pub(super) fn sleeping_position(&self, head: [i32; 3]) -> Option<Vec3> {
    // rust: self.sleep_height(head)
    // rust: .map(|height| pos_to_bed(head, height))
}
}

    // rust: mod tests {
//     use super::{SleepOn, pos_to_bed, shape_top, slept_on};

    /// `StrawBedBlock.getSleepHeight`: a straw bed's head is slept on at its
    /// foot, and one whose foot is gone - or is not a straw bed's foot any
    /// more - has no height, so `startSleeping` gives up on it.
pub fn a_straw_beds_head_is_slept_on_at_its_foot() void {
}
    // rust: let straw = "minecraft:straw_bed";
    // rust: assert_eq!(
    // rust: slept_on(straw, Some("head"), Some((straw, Some("foot")))),
    // rust: Some(SleepOn::Foot)
    // rust: );
    // rust: assert_eq!(
    // rust: slept_on(straw, Some("head"), Some((straw, Some("head")))),
    // rust: None,
    // rust: "a head facing another head"
    // rust: );
    // rust: assert_eq!(
    // rust: slept_on(straw, Some("head"), Some(("minecraft:oak_planks", None))),
    // rust: None,
    // rust: "the foot was replaced"
    // rust: );
    // rust: assert_eq!(
    // rust: slept_on(
    // rust: straw,
    // rust: Some("head"),
    // rust: Some(("minecraft:red_bed", Some("foot")))
    // rust: ),
    // rust: None,
    // rust: "the foot is another bed"
    // rust: );
    // rust: assert_eq!(
    // rust: slept_on(straw, Some("foot"), None),
    // rust: Some(SleepOn::Head),
    // rust: "a straw bed's foot sleeps on its own shape"
    // rust: );
    // rust: assert_eq!(
    // rust: slept_on("minecraft:red_bed", Some("head"), None),
    // rust: Some(SleepOn::Head),
    // rust: "an ordinary bed's head is its own shape"
    // rust: );
}

    /// `AbstractBedBlock.getSleepHeight`: the tallest box of the shape, from
    /// the block's own y; a shape with nothing in it has no height.
pub fn the_height_is_the_top_of_the_shape() void {
}
        // The boxes are the pack's, in world space, as `outline_boxes` gives them.
    // rust: let bed = [[10.0, 70.0, 5.0, 11.0, 70.5625, 6.0]];
    // rust: assert_eq!(shape_top(&bed, 70.0), Some(0.5625));
    // rust: let pillow = [[10.0, 70.0, 5.0, 11.0, 70.6875, 6.0]];
    // rust: assert_eq!(shape_top(&pillow, 70.0), Some(0.6875));
    // rust: let two = [
    // rust: [10.0, 70.0, 5.0, 11.0, 70.5625, 6.0],
    // rust: [10.0, 70.0, 5.0, 10.5, 70.25, 5.5],
    // rust: ];
    // rust: assert_eq!(shape_top(&two, 70.0), Some(0.5625), "the tallest box");
    // rust: assert_eq!(shape_top(&[], 70.0), None, "a bed with no shape");
}

    /// `setPosToBed`: `0.125` above the height, in the middle of the block.
    /// A straw bed's head slept on a foot `7/16` tall at y 70 puts the player
    /// at 70.5625, where the head's own `9/16` (or the flat 0.5625 every bed
    /// was given) had them at 70.6875.
pub fn the_sleeper_lies_an_eighth_above_the_shape() void {
}
    // rust: let at = pos_to_bed([10, 70, 5], 0.4375);
    // rust: assert_eq!((at.x, at.y, at.z), (10.5, 70.5625, 5.5));
    // rust: assert_eq!(pos_to_bed([10, 70, 5], 0.5625).y, 70.6875);
}
}
