//! Transpiled from Horizon Rust crate
package horizon_client_banners

import "core:fmt"
import "core:mem"
import "core:math"

// Placed banners (`BannerBlockEntity`): the pattern layers move from the
// banner item to the block when placed and back to the dropped item when
// broken (`copy_components` in the banner loot tables).
// use super::{Game, maps::MapBanner};
// use horizon_client::{
    // rust: banner::{self, BannerLayer},
    // rust: containers::BlockEntity,
}

    // rust: impl Game<'_> {
    // The pattern textures and tints of the banner at `pos`, bottom first.
    // rust: pub(super) fn banner_layers_at(&self, pos: [i32; 3]) -> Vec<(String, u32)> {
    // rust: let Some(BlockEntity::Banner(b)) = self.world.block_entities.get(&(pos[0], pos[1], pos[2]))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: layer_textures(&self.stations().banners, &b.layers)
}
    // The banner at `pos` as a map marker source (`MapBanner.fromWorld`).
    // rust: pub(super) fn map_banner_at(&self, pos: [i32; 3]) -> Option<MapBanner> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: map_banner(
    // rust: pos,
    // rust: self.world.block_entities.get(&(pos[0], pos[1], pos[2])),
    // rust: &self.res.facts().get(state).name,
    // rust: )
}
}

// `MapBanner.fromWorld`: the banner whose block entity is `entity` at `pos`,
// with the base colour of its block (`BannerBlockEntity.getBaseColor` is
// `AbstractBannerBlock.getColor`) and its custom name; none when the block
// entity is not a banner.
    // rust: pub(super) fn map_banner(
    // rust: pos: [i32; 3],
    // rust: entity: Option<&BlockEntity>,
    // rust: block: &str,
    // rust: ) -> Option<MapBanner> {
    // rust: let Some(BlockEntity::Banner(banner)) = entity else {
    // rust: return None;
}
    // rust: let block = block.strip_prefix("minecraft:").unwrap_or(block);
    // rust: let color = block
    // rust: .strip_suffix("_wall_banner")
    // rust: .or_else(|| block.strip_suffix("_banner"))?;
    // rust: Some(MapBanner {
    // rust: pos,
    // rust: color: color.to_owned(),
    // rust: name: banner.name.clone(),
    // rust: })
}

// Texture names and tints of banner layers (`Sheets.getBannerSprite`).
    // rust: pub(super) fn layer_textures(
    // rust: banners: &banner::Banners,
    // rust: layers: &[BannerLayer],
    // rust: ) -> Vec<(String, u32)> {
    // rust: layers
    // rust: .iter()
    // rust: .map(|l| {
    // rust: (
    // rust: banners.banner_texture(&l.pattern),
    // rust: banner::dye_rgb(&l.color),
    // rust: )
    // rust: })
    // rust: .collect()
}
