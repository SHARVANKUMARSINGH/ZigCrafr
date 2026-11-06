//! Transpiled from Horizon Rust crate
//! Module: horizon-world_collision_context
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Collision queries over a captured entity state. Entity lifecycle, mutable
//! inventory ownership and experimental minecart contexts are supplied separately.
// use crate::{entity_obstruction::EntityIdentity, fluid::FluidState};
// use horizon_core::{
    // rust: geometry::{Axis, VoxelShape},
    // rust: position::BlockPos,
}

/// A main-hand stack snapshot. Item names must be canonical registry identifiers.
pub const CollisionItem = struct {
    item: *'a str,
    count: i32,
};
    // rust: impl CollisionItem<'_> {
    // rust: pub const EMPTY: Self = Self {
    // rust: item: "minecraft:air",
    // rust: count: 0,
}

pub fn is_item(self: *Self, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
        // ItemStack.typeHolder substitutes AIR for every empty stack, including
        // stacks whose stored item is non-air but whose count is nonpositive.
    // rust: let held = if self.count <= 0 {
    // rust: "minecraft:air"
    // rust: } else {
    // rust: self.item
}
    // rust: held == item
}
}

pub const CollisionEntity = struct {
    identity: EntityIdentity,
    /// Entity.getY(), not the minimum Y of its bounding box.
    y: f64,
    descending: bool,
    /// None for nonliving entities; Some(EMPTY) for an empty-handed living one.
    main_hand: ?CollisionItem<'a>,
};

pub const Height = enum {
    Default,
    Bottom(f64),
};

pub const CollisionContext = struct {
    height: Height,
    descending: bool,
    placement: bool,
    always_fluid: bool,
    held: CollisionItem<'a>,
    entity: ?EntityIdentity,
    living: bool,
    position_only: bool,
};
    // rust: impl<'a> CollisionContext<'a> {
    // rust: pub const fn empty(always_fluid: bool) -> Self {
    // rust: Self {
    // rust: height: Height::Default,
    // rust: descending: false,
    // rust: placement: false,
    // rust: always_fluid,
    // rust: held: CollisionItem::EMPTY,
    // rust: entity: None,
    // rust: living: false,
    // rust: position_only: false,
}
}

    // rust: pub const fn position(y: f64) -> Self {
    // rust: Self {
    // rust: height: Height::Bottom(y),
    // rust: position_only: true,
    // rust: ..Self::empty(false)
}
}

    /// The same context for an entity that is (or is not) sneaking. Only block
    /// shapes that read `isDescending` (scaffolding) see the difference.
    // rust: pub const fn with_descending(mut self, descending: bool) -> Self {
    // rust: self.descending = descending;
    // rust: self
}

    /// Ordinary EntityCollisionContext. The native factory overload taking an
    /// explicit fluid flag also uses this path for experimental minecarts.
pub fn for_entity(entity: CollisionEntity<'a>, always_fluid: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: height: Height::Bottom(entity.y),
    // rust: descending: entity.descending,
    // rust: placement: false,
    // rust: always_fluid,
    // rust: held: entity.main_hand.unwrap_or(CollisionItem::EMPTY),
    // rust: entity: Some(entity.identity),
    // rust: living: entity.main_hand.is_some(),
    // rust: position_only: false,
}
}

    /// `player`, when present, must describe a player (and thus a living entity).
pub fn placement(player: ?CollisionEntity<'a>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let y = player.map_or(-f64::MAX, |player| player.y);
    // rust: Self::with_position(player, y)
}

    /// Native withPosition is a placement context. A missing entity ignores y.
pub fn with_position(entity: ?CollisionEntity<'a>, y: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut context = entity.map_or_else(
    // rust: || Self {
    // rust: height: Height::Bottom(-f64::MAX),
    // rust: ..Self::empty(false)
    // rust: },
    // rust: |entity| Self {
    // rust: height: Height::Bottom(y),
    // rust: ..Self::for_entity(entity, false)
    // rust: },
    // rust: );
    // rust: context.placement = true;
    // rust: context
}

pub fn entity(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity
}
pub fn living_entity(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity.filter(|_| self.living)
}
pub fn is_descending(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.descending
}
pub fn is_placement(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.placement
}
pub fn always_collide_with_fluid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.always_fluid
}
pub fn is_holding_item(self: *Self, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.position_only && self.held.is_item(item)
}

pub fn is_above(self: *Self, shape: *VoxelShape, position: BlockPos, default: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.height {
    // rust: Height::Default => default,
    // rust: Height::Bottom(bottom) => {
    // rust: bottom > (f64::from(position.y) + shape.max(Axis::Y) - f64::from(1.0e-5f32))
}
}
}

    /// The living-entity callback receives the second fluid even when both fluid
    /// types belong to the same family. Preserve its side effects and failures.
    // rust: pub fn can_stand_on_fluid<E>(
    // rust: &self,
    // rust: first: FluidState,
    // rust: second: FluidState,
    // rust: mut entity_can_stand: impl FnMut(EntityIdentity, FluidState) -> Result<bool, E>,
    // rust: ) -> Result<bool, E> {
    // rust: if !self.living {
    // rust: return Ok(false);
}
    // rust: Ok(
    // rust: entity_can_stand(self.entity.expect("living context has an entity"), second)?
    // rust: && !first.kind().same_family(second.kind()),
    // rust: )
}
}
