//! Transpiled from Horizon Rust crate
package horizon_world_buckets

import "core:fmt"
import "core:mem"
import "core:math"

// Dispenser use of buckets: `BucketPickup.pickupBlock` for an empty bucket and
// `DispensibleContainerItem.emptyContents` for filled ones (`BucketItem`,
// `MobBucketItem`, `SolidBucketItem`), both without a player.
// use super::{
    // rust: Behaviours, Dimension, LevelAccess, Sim, Ticks,
    // rust: classes::{Class, Interface},
}
// use crate::{
    // rust: fluid::{FluidKind, FluidState},
    // rust: registry::BlockStateId,
}
// use horizon_core::{position::BlockPos, random::RandomSource};
// use std::sync::Arc;

// What a filled bucket empties into the world.
BucketContent :: enum {
    // Water or lava (mob buckets hold water).
    Fluid(FluidKind),
    // `SolidBucketItem`: the block placed into an empty space (powder snow).
    Powder,
    // `MobBucketItem` holding water: its empty sound posts no `FLUID_PLACE`.
    MobWater,
    // `MobBucketItem` without a fluid (the sulfur cube bucket): only the sound.
    Nothing,
}

    // rust: impl BucketContent {
    // `BucketItem.content == Fluids.WATER` (`MobBucketItem` holding water
    // counts too): the only content a bucket pours inside a liquid
    // container, and the only one `canBeReplaced(Fluid)` sees as water.
is_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::Fluid(FluidKind::Water) | Self::MobWater)
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // `BucketPickup.pickupBlock(user, level, pos, state)`: the filled bucket
    // that results, None when the block gives nothing. `creative` is whether
    // `user` is a creative player (only barriers care).
    // rust: pub(crate) fn bucket_pickup(&mut self, pos: BlockPos, creative: bool) -> Option<&'static str> {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: let item = if b.instance_of(state, Class::Liquid) {
    // rust: match b.fluid(state).kind() {
    // rust: FluidKind::Water | FluidKind::FlowingWater => "minecraft:water_bucket",
    // rust: FluidKind::Lava | FluidKind::FlowingLava => "minecraft:lava_bucket",
    // rust: FluidKind::Empty => return None,
}
    // rust: } else if b.implements(state, Interface::SimpleWaterlogged)
    // rust: && b.table.has(state, b.props.waterlogged)
    // rust: {
    // rust: "minecraft:water_bucket"
    // rust: } else if b.is_block(state, b.named.powder_snow) {
    // rust: "minecraft:powder_snow_bucket"
    // rust: } else if b.is_block(state, b.named.bubble_column) {
    // rust: "minecraft:water_bucket"
    // rust: } else {
    // rust: return None;
}
    // rust: self.pickup_block(pos, state, creative).then_some(item)
}
    // `BucketItem.emptyContents(user, level, pos, hitResult)`: where the
    // contents went, None when nothing was emptied. `beside` is
    // `hitResult.getBlockPos().relative(hitResult.getDirection())` (None for
    // a dispenser, which has no hit result). `sound` is the bucket's empty
    // sound (mob buckets have their own); `sneaking` is
    // `user.isShiftKeyDown()`, which only counts with a hit result;
    // `creative` is whether that user is a creative player.
    // rust: pub(crate) fn bucket_empty(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: beside: Option<BlockPos>,
    // rust: content: BucketContent,
    // rust: sound: &str,
    // rust: sneaking: bool,
    // rust: creative: bool,
    // rust: ) -> Option<BlockPos> {
    // rust: let b = self.b;
    // rust: let fluid = match content {
    // rust: BucketContent::Powder => {
    // rust: if self.is_in_valid_bounds(pos) && b.is_air(self.state(pos)) {
    // rust: let snow = b.table.default_state(b.named.powder_snow);
    // rust: self.set_block_and_update(pos, snow);
                    // SolidBucketItem.emptyContents: one FLUID_PLACE, then the place sound.
    // rust: self.game_event(pos, "minecraft:fluid_place");
    // rust: let sound: Arc<str> = sound.into();
    // rust: self.sound(pos, &sound, 1.0, 1.0);
    // rust: return Some(pos);
}
    // rust: return None;
}
    // rust: BucketContent::Nothing => {
    // rust: let sound: Arc<str> = sound.into();
    // rust: self.sound(pos, &sound, 1.0, 1.0);
    // rust: return Some(pos);
}
    // rust: BucketContent::MobWater => FluidKind::Water,
    // rust: BucketContent::Fluid(fluid) => fluid,
}
    // rust: let mob = content == BucketContent::MobWater;
    // rust: let state = self.state(pos);
        // canBeReplaced(fluid): replaceable or not solid (portals refuse).
    // rust: let may_replace = !b.instance_of(state, Class::EndPortal)
    // rust: && !b.instance_of(state, Class::EndGateway)
    // rust: && (b.is_replaceable(state) || !b.is_solid(state));
    // rust: let liquid_container = self.is_liquid_container(state);
    // rust: let container = liquid_container && self.can_place_liquid(state, fluid, creative);
    // rust: let place_liquid = may_replace || container;
        // `canPlaceFluidInsideBlock`: air always takes the fluid; a block that
        // merely holds it (a waterloggable block, a replaceable plant) only
        // when the player is not sneaking or there is no hit result (a
        // dispenser, or the retry below).
    // rust: if !(b.is_air(state) || place_liquid && (!sneaking || beside.is_none())) {
            // A refused click (a double slab, or Shift on a waterloggable
            // block) pours into the block beside the clicked face instead,
            // without a hit result.
    // rust: return beside.and_then(|beside| {
    // rust: self.bucket_empty(beside, None, content, sound, sneaking, creative)
    // rust: });
}
    // rust: let water = matches!(fluid, FluidKind::Water | FluidKind::FlowingWater);
    // rust: if water && self.level.dimension() == Dimension::Nether {
            // WATER_EVAPORATES: the water hisses away.
    // rust: let pitch = 2.6 + (self.random().next_float() - self.random().next_float()) * 0.8;
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.fire.extinguish".into(),
    // rust: volume: 0.5,
    // rust: pitch,
    // rust: });
    // rust: return Some(pos);
}
    // rust: if liquid_container && water {
    // rust: self.place_liquid(
    // rust: pos,
    // rust: state,
    // rust: FluidState::new(FluidKind::Water, 8, false),
    // rust: creative,
    // rust: );
    // rust: self.empty_sound(pos, sound, mob);
    // rust: return Some(pos);
}
        // `BlockState.liquid()`: water, lava and the bubble column. A bubble
        // column is not a `LiquidBlock`, and breaking it first spills break
        // particles and a `block_destroy` a sculk sensor hears.
    // rust: if may_replace && !b.liquid(state) {
    // rust: self.destroy_block(pos, true, super::flags::UPDATE_LIMIT);
}
    // rust: let source = FluidState::new(
    // rust: if water {
    // rust: FluidKind::Water
    // rust: } else {
    // rust: FluidKind::Lava
    // rust: },
    // rust: 8,
    // rust: false,
    // rust: );
    // rust: let legacy: BlockStateId = b.legacy_block(source);
    // rust: if !self.set_block(pos, legacy, super::flags::UPDATE_ALL_IMMEDIATE)
    // rust: && !self.fluid_at(pos).is_source()
    // rust: {
    // rust: return None;
}
    // rust: self.empty_sound(pos, sound, mob);
    // rust: Some(pos)
}
    // `playEmptySound`: `MobBucketItem` overrides it without the game event.
empty_sound :: proc(self: ^Self, pos: BlockPos, sound: string, mob: bool) {
}
    // rust: let sound: Arc<str> = sound.into();
    // rust: self.sound(pos, &sound, 1.0, 1.0);
    // rust: if !mob {
    // rust: self.game_event(pos, "minecraft:fluid_place");
}
}
}

    // rust: impl Behaviours {
    // `BucketPickup.pickupBlock(user, level, pos, state)`: the filled bucket
    // item. A dispenser has no user (`false`).
    // rust: pub fn bucket_pickup<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: creative: bool,
    // rust: ) -> Option<&'static str> {
    // rust: self.sim(level, ticks).bucket_pickup(pos, creative)
}
    // `DispensibleContainerItem.emptyContents(user, level, pos, hitResult)`:
    // where the contents went. `beside` is the block beside the clicked
    // face, tried when `pos` refuses (None without a hit result).
    // rust: pub fn bucket_empty<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: beside: Option<BlockPos>,
    // rust: content: BucketContent,
    // rust: sound: &str,
    // rust: sneaking: bool,
    // rust: creative: bool,
    // rust: ) -> Option<BlockPos> {
    // rust: self.sim(level, ticks)
    // rust: .bucket_empty(pos, beside, content, sound, sneaking, creative)
}
}
