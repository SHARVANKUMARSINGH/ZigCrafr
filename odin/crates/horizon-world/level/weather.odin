//! Transpiled from Horizon Rust crate
package horizon_world_weather

import "core:fmt"
import "core:mem"
import "core:math"

// Biome weather queries for a live level: `ServerLevel.tickPrecipitation`'s
// inputs (`Biome.shouldFreeze`, `shouldSnow`, `getPrecipitationAt`) and
// `Level.isRainingAt`, from the biome temperatures of the worldgen bundle.
// use super::{Behaviours, Dimension, LevelAccess, Precipitation, PrecipitationKind};
// use crate::{
    // rust: fluid::FluidKind,
    // rust: worldgen::biome_temperature::{BiomeTemperatureSettings, Precipitation as BiomePrecipitation},
}
// use horizon_core::{geometry::Direction, position::BlockPos};

    // rust: fn sea_level<L: LevelAccess + ?Sized>(level: &L) -> i32 {
    // rust: match level.dimension() {
    // rust: Dimension::Nether => 32,
    // rust: Dimension::End => 0,
    // rust: Dimension::Overworld => 63,
}
}

    // rust: impl Behaviours {
    // rust: fn biome_settings<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &L,
    // rust: pos: BlockPos,
    // rust: ) -> Option<BiomeTemperatureSettings> {
    // rust: let features = self.live_features()?;
    // rust: let biome = features.biome_id(level.biome_name(pos)?)?;
    // rust: features.biome_temperature(biome)
}
    // `Biome.getPrecipitationAt(pos, seaLevel)`.
    // rust: fn precipitation_kind(
    // rust: settings: BiomeTemperatureSettings,
    // rust: pos: BlockPos,
    // rust: sea: i32,
    // rust: ) -> BiomePrecipitation {
    // rust: if !settings.has_precipitation {
    // rust: BiomePrecipitation::None
    // rust: } else if settings.height_adjusted(pos, sea) < 0.15 {
    // rust: BiomePrecipitation::Snow
    // rust: } else {
    // rust: BiomePrecipitation::Rain
}
}
    // `getHeightmapPos(MOTION_BLOCKING, pos)`, scanning down from the
    // world surface (air neither blocks motion nor holds a fluid).
    // rust: pub fn motion_blocking_top<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &L,
    // rust: pos: BlockPos,
    // rust: ) -> BlockPos {
    // rust: let blocks = self.tag("minecraft:blocks_motion_in_heightmap");
    // rust: let top = level.world_surface(pos.x, pos.z).min(level.max_y());
    // rust: for y in (level.min_y()..top).rev() {
    // rust: let state = level.block_state(BlockPos::new(pos.x, y, pos.z));
    // rust: let fluid = self.fluid(state).kind() != FluidKind::Empty;
    // rust: if fluid || blocks.is_some_and(|t| t.contains(self.block(state))) {
    // rust: return BlockPos::new(pos.x, y + 1, pos.z);
}
}
    // rust: BlockPos::new(pos.x, level.min_y(), pos.z)
}
    // Answers for one `ServerLevel.tickPrecipitation` at the column of `pos`;
    // None without live features or a biome.
    // rust: pub fn precipitation_info<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &L,
    // rust: pos: BlockPos,
    // rust: ) -> Option<Precipitation> {
    // rust: let top = self.motion_blocking_top(level, pos);
    // rust: let below = BlockPos::new(top.x, top.y - 1, top.z);
    // rust: let settings = self.biome_settings(level, top)?;
    // rust: let sea = sea_level(level);
    // rust: let inside = |p: BlockPos| p.y >= level.min_y() && p.y < level.max_y();
        // Biome.shouldFreeze(level, below, true)
    // rust: let freezes_below = settings.height_adjusted(below, sea) < 0.15
    // rust: && inside(below)
    // rust: && level.block_light(below) < 10
    // rust: && {
    // rust: let state = level.block_state(below);
    // rust: self.block(state) == self.named.water && self.fluid(state).is_source()
}
    // rust: && [
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: ]
    // rust: .into_iter()
    // rust: .any(|d| {
    // rust: let n = super::update::rel(below, d);
    // rust: !self.is_water_fluid(self.fluid(level.block_state(n)).kind())
    // rust: });
        // Biome.shouldSnow(level, top)
    // rust: let snows_at_top = Self::precipitation_kind(settings, top, sea) == BiomePrecipitation::Snow
    // rust: && inside(top)
    // rust: && level.block_light(top) < 10
    // rust: && {
    // rust: let state = level.block_state(top);
    // rust: (self.is_air(state) || self.block(state) == self.named.snow)
    // rust: && self.snow_survives(level, top)
}
    // rust: let kind = match Self::precipitation_kind(settings, below, sea) {
    // rust: BiomePrecipitation::None => PrecipitationKind::None,
    // rust: BiomePrecipitation::Rain => PrecipitationKind::Rain,
    // rust: BiomePrecipitation::Snow => PrecipitationKind::Snow,
}
    // rust: Some(Precipitation {
    // rust: top,
    // rust: freezes_below,
    // rust: snows_at_top,
    // rust: kind,
    // rust: })
}
    // `SnowLayerBlock.canSurvive` for a default snow layer at `pos`.
    // rust: fn snow_survives<L: LevelAccess + ?Sized>(&self, level: &L, pos: BlockPos) -> bool {
    // rust: let below = level.block_state(BlockPos::new(pos.x, pos.y - 1, pos.z));
    // rust: let block = self.block(below);
    // rust: if self.tags.cannot_support_snow_layer.contains(block) {
    // rust: return false;
}
    // rust: if self.tags.support_override_snow_layer.contains(block) {
    // rust: return true;
}
    // rust: self.collision_face_full(below, Direction::Up)
    // rust: || (block == self.named.snow && self.table.int(below, self.props.layers) == 8)
}
    // `Level.isRainingAt(pos)`.
    // rust: pub fn is_raining_at<L: LevelAccess + ?Sized>(&self, level: &L, pos: BlockPos) -> bool {
    // rust: if !level.is_raining() || level.sky_light(pos) < 15 {
    // rust: return false;
}
    // rust: if self.motion_blocking_top(level, pos).y > pos.y {
    // rust: return false;
}
    // rust: self.biome_settings(level, pos).is_some_and(|s| {
    // rust: Self::precipitation_kind(s, pos, sea_level(level)) == BiomePrecipitation::Rain
    // rust: })
}
}
