//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_block_sprites
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Where a block's textures are in the block sprite arrays, side by side, for drawing the block
//! somewhere the mesher does not: a native mod's own pass drawing blocks as voxels
//! (`native_block_sprites`, `WorldDrawn::block_sprites`; docs/native-mods.md). The answer is the
//! model's own faces, as the mesher bakes them: each face's sprite (its array and layer), where on
//! the block's side it lies and how its texture runs across it, and its tint source.
//!
//! Each sprite is a whole layer of a square texture array (`sprites::Sprites`), so a face's UVs run
//! 0 to 1 within its layer; the renderer's split (`Renderer::sprite_split`) layers to an array.
// use crate::{mesher::TintSource, models::catalog::BakedFace, streaming::WorkerContext};
// use horizon_assets::model::Direction;
// use horizon_core::position::BlockPos;
// use horizon_world::registry::{BlockRegistry, BlockStateId};

/// A sprite: its array (0 for every vanilla texture on most GPUs; past the first array's layers in
/// 1 to 7) and its layer in that array.
pub const SpriteRef = struct {
    array: u32,
    layer: u32,
    /// It animates (water, lava, fire, sea lanterns...): the arrays always hold the frame being shown.
    animated: bool,
    /// Some of its pixels are clear (alpha 0): leaves, glass, flowers. Draw those as holes.
    cutout: bool,
};

/// One face of a block's model on one of its sides.
pub const FaceSprite = struct {
    sprite: SpriteRef,
    /// Where the face lies on the side, in the side's two axes ([`side_axes`]), from 0 to 1 across the block:
    /// `[a0, b0, a1, b1]`. `[0, 0, 1, 1]` for a whole face.
    rect: [f32,
    /// How deep into the block the face lies from the side's own plane (0 for a cube's face, 0.5 for a slab's top).
    inset: f32,
    /// The texture across the side: the point (a, b) on it shows `uv = [u0, v0] + a * [du_u, du_v] + b * [dv_u,
    /// dv_v]` of the sprite, `[u0, v0, du_u, du_v, dv_u, dv_v]`. Rotations and mirrors (a log on its side, a
    /// model's `rotation` and `uvlock`) are in it.
    uv: [f32,
    /// Its colour source, none for an untinted face: multiply the texture by the source's colour.
    tint: ?TintSource,
    /// It has partly clear pixels: drawn sorted and blended.
    translucent: bool,
};

/// What a block draws on each side, in [`Direction::ALL`]'s order (down, up, north, south, west, east).
pub const BlockSprites = struct {
    /// The faces on each side, in the model's order: the one drawn first first (a grass block's side: its dirt
    /// and grass, then the grass overlay tinted over it). A side with none is empty. Faces that do not lie flat
    /// on a side (a flower's crossed planes, a rotated element) are left out.
    sides: [std.ArrayList(FaceSprite),
    /// The model's particle sprite (what breaking it scatters, a flower's whole picture), if it has one.
    particle: ?SpriteRef,
    /// The model is a plain cube: one whole face on each side, at its plane.
    cube: bool,
};

/// The two axes a side's `rect` and `uv` count along, as indices into (x, y, z): down and up across x then z; north
/// and south across x then y; west and east across z then y. (The block's corner at 0, 0, 0 is 0 on each.)
pub fn side_axes(side: Direction) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match side {
    // rust: Direction::Down | Direction::Up => (0, 2),
    // rust: Direction::North | Direction::South => (0, 1),
    // rust: Direction::West | Direction::East => (2, 1),
}
}

/// The axis a side faces along, and where its plane is (0 or 1).
pub fn side_plane(side: Direction) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match side {
    // rust: Direction::Down => (1, 0.0),
    // rust: Direction::Up => (1, 1.0),
    // rust: Direction::North => (2, 0.0),
    // rust: Direction::South => (2, 1.0),
    // rust: Direction::West => (0, 0.0),
    // rust: Direction::East => (0, 1.0),
}
}

/// A block state from `name[property=value,...]`, the namespace `minecraft:` when it has none; properties left
/// out take the block's default. None for a block or a property the game does not know.
pub fn parse_state(registry: *BlockRegistry, text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (name, props) = match text.trim().split_once('[') {
    // rust: Some((n, rest)) => (n, rest.strip_suffix(']')?),
    // rust: None => (text.trim(), ""),
}
    // rust: let name = if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let default = registry.default_state(&name)?;
    // rust: let mut state = registry.state(default)?.clone();
    // rust: for pair in props.split(',').map(str::trim).filter(|p| !p.is_empty()) {
    // rust: let (k, v) = pair.split_once('=')?;
    // rust: let slot = state.properties.get_mut(k.trim())?;
    // rust: *slot = v.trim().to_owned();
}
    // rust: registry.resolve(&state).ok()
}

/// The sprites `context`'s resources hold, `split` layers to an array (`Renderer::sprite_split`).
pub const Lookup = struct {
    context: *'a WorkerContext,
    split: u32,
};

    // rust: impl<'a> Lookup<'a> {
pub fn new(context: *'a WorkerContext, split: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: context,
    // rust: split: split.max(1),
}
}
    /// The sprite at `layer` of all the layers.
pub fn sprite(self: *Self, layer: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let render = &self.context.render;
    // rust: SpriteRef {
    // rust: array: layer / self.split,
    // rust: layer: layer % self.split,
    // rust: animated: render.animations.iter().any(|a| a.layer == layer),
    // rust: cutout: render
    // rust: .sprite_mips
    // rust: .get(layer as usize)
    // rust: .is_some_and(|m| m.has_transparent),
}
}

    /// A texture by name (`minecraft:block/stone`, `block/stone`); none for one no model uses (the arrays hold only
    /// the textures models and the game's own drawing name).
pub fn texture(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let layers = &self.context.render.sprite_layers;
    // rust: let layer = layers
    // rust: .get(name)
    // rust: .or_else(|| layers.get(&format!("minecraft:{name}")))?;
    // rust: Some(self.sprite(*layer))
}

    /// What block `name` (`minecraft:oak_log[axis=x]`; properties left out take the default) draws on each side;
    /// none for a block the game does not know.
pub fn block(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = parse_state(self.context.assets.registry, name)?;
    // rust: Some(self.state(state))
}

    /// What `state` draws on each side. A fluid has its still texture on all six; a block drawn only as a block
    /// entity (a chest, a sign) or not at all (air) has empty sides, and its particle sprite if any.
pub fn state(self: *Self, state: BlockStateId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let render = &self.context.render;
    // rust: let catalog = &render.model_catalog;
    // rust: let mut sides: [Vec<FaceSprite>; 6] = Default::default();
    // rust: let block = self
    // rust: .context
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map_or("", |s| s.name.as_str());
    // rust: let fluid = match block {
    // rust: "minecraft:water" | "minecraft:bubble_column" => {
    // rust: Some(("block/water_still", Some(TintSource::Water), true))
}
    // rust: "minecraft:lava" => Some(("block/lava_still", None, false)),
    // rust: _ => None,
}
    // rust: if let Some((texture, tint, translucent)) = fluid {
    // rust: let sprite = self.texture(texture);
    // rust: if let Some(sprite) = sprite {
    // rust: for side in &mut sides {
    // rust: side.push(FaceSprite {
    // rust: sprite,
    // rust: rect: [0.0, 0.0, 1.0, 1.0],
    // rust: inset: 0.0,
    // rust: uv: [0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
    // rust: tint,
    // rust: translucent,
    // rust: });
}
}
    // rust: return BlockSprites {
    // rust: sides,
    // rust: particle: sprite,
    // rust: cube: sprite.is_some(),
}
}
    // rust: let models = catalog
    // rust: .collect(state, BlockPos::new(0, 0, 0))
    // rust: .unwrap_or_default();
    // rust: let mut all = 0;
    // rust: for face in models.iter().flat_map(|(_, m)| &m.faces) {
    // rust: all += 1;
    // rust: let Some((side, sprite)) = self.face(state, face) else {
    // rust: continue;
}
    // rust: sides[side as usize].push(sprite);
}
    // rust: let particle = catalog
    // rust: .particle(state)
    // rust: .or_else(|| {
    // rust: models
    // rust: .iter()
    // rust: .flat_map(|(_, m)| &m.faces)
    // rust: .map(|f| f.layer)
    // rust: .next()
    // rust: })
    // rust: .map(|layer| self.sprite(layer));
        // a cube: every side has a whole face at its plane (and perhaps overlays laid on it), and the model has no
        // other faces
    // rust: let whole = |f: &FaceSprite| f.rect == [0.0, 0.0, 1.0, 1.0] && f.inset == 0.0;
    // rust: let cube = all == sides.iter().map(Vec::len).sum::<usize>()
    // rust: && sides.iter().all(|s| !s.is_empty() && s.iter().all(whole));
    // rust: BlockSprites {
    // rust: sides,
    // rust: particle,
    // rust: cube,
}
}

    /// A model face as it lies on its side; none when it does not lie flat on one.
pub fn face(self: *Self, state: BlockStateId, face: *BakedFace) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = &face.quad;
    // rust: let side = q.facing;
    // rust: let (normal, plane) = side_plane(side);
    // rust: let depth = q.positions[0][normal];
    // rust: if q.positions.iter().any(|p| (p[normal] - depth).abs() > 1e-4) {
    // rust: return None;
}
    // rust: let (a, b) = side_axes(side);
    // rust: let ab: [[f32; 2]; 4] = q.positions.map(|p| [p[a], p[b]]);
    // rust: let uv = affine(&ab, &q.uv)?;
    // rust: let (mut a0, mut b0, mut a1, mut b1) = (f32::MAX, f32::MAX, f32::MIN, f32::MIN);
    // rust: for [x, y] in ab {
    // rust: a0 = a0.min(x);
    // rust: b0 = b0.min(y);
    // rust: a1 = a1.max(x);
    // rust: b1 = b1.max(y);
}
    // rust: let snap = |v: f32| {
    // rust: let r = (v * 4096.0).round() / 4096.0;
    // rust: if r == 0.0 { 0.0 } else { r }
}
    // rust: Some((
    // rust: side,
    // rust: FaceSprite {
    // rust: sprite: self.sprite(face.layer),
    // rust: rect: [a0, b0, a1, b1].map(snap),
    // rust: inset: snap((depth - plane).abs()),
    // rust: uv: uv.map(snap),
    // rust: tint: self.context.tables.tint_source(state, q.tint_index),
    // rust: translucent: face.translucent,
    // rust: },
    // rust: ))
}
}

/// The affine map from a face's points on its side to its UVs, `[u0, v0, du_u, du_v, dv_u, dv_v]`, from three of
/// its corners that are not in a line (a model's faces are parallelograms on their side).
pub fn affine(ab: *[[f32; 2]; 4], uv: *[[f32; 2]; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for [i, j, k] in [[0, 1, 2], [0, 1, 3], [0, 2, 3], [1, 2, 3]] {
    // rust: let d1 = [ab[j][0] - ab[i][0], ab[j][1] - ab[i][1]];
    // rust: let d2 = [ab[k][0] - ab[i][0], ab[k][1] - ab[i][1]];
    // rust: let det = d1[0] * d2[1] - d1[1] * d2[0];
    // rust: if det.abs() < 1e-6 {
    // rust: continue;
}
    // rust: let e1 = [uv[j][0] - uv[i][0], uv[j][1] - uv[i][1]];
    // rust: let e2 = [uv[k][0] - uv[i][0], uv[k][1] - uv[i][1]];
        // e1 = d1.a * du + d1.b * dv, e2 = d2.a * du + d2.b * dv
    // rust: let du = [
    // rust: (e1[0] * d2[1] - e2[0] * d1[1]) / det,
    // rust: (e1[1] * d2[1] - e2[1] * d1[1]) / det,
    // rust: ];
    // rust: let dv = [
    // rust: (e2[0] * d1[0] - e1[0] * d2[0]) / det,
    // rust: (e2[1] * d1[0] - e1[1] * d2[0]) / det,
    // rust: ];
    // rust: let o = [
    // rust: uv[i][0] - ab[i][0] * du[0] - ab[i][1] * dv[0],
    // rust: uv[i][1] - ab[i][0] * du[1] - ab[i][1] * dv[1],
    // rust: ];
    // rust: return Some([o[0], o[1], du[0], du[1], dv[0], dv[1]]);
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;

pub fn a_faces_texture_runs_across_its_side() void {
}
        // a whole face, the texture upright: u along a, v along b
    // rust: let ab = [[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0]];
    // rust: assert_eq!(
    // rust: affine(&ab, &[[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0]]),
    // rust: Some([0.0, 0.0, 1.0, 0.0, 0.0, 1.0])
    // rust: );
        // turned a quarter (a log on its side): u runs down b, v back along a
    // rust: let turned = affine(&ab, &[[0.0, 1.0], [0.0, 0.0], [1.0, 0.0], [1.0, 1.0]]).unwrap();
    // rust: assert_eq!(turned, [0.0, 1.0, 0.0, -1.0, 1.0, 0.0]);
        // a slab's side: the lower half of the block, the lower half of the texture (v counts down)
    // rust: let half = [[0.0, 0.0], [1.0, 0.0], [1.0, 0.5], [0.0, 0.5]];
    // rust: let m = affine(&half, &[[0.0, 1.0], [1.0, 1.0], [1.0, 0.5], [0.0, 0.5]]).unwrap();
    // rust: assert_eq!(m, [0.0, 1.0, 1.0, 0.0, 0.0, -1.0]);
        // a face seen edge on has no map
    // rust: assert_eq!(affine(&[[0.0, 0.0]; 4], &[[0.0, 0.0]; 4]), None);
}

    /// The game's own blocks from real prepared resources: a cube, a grass block's tinted top and overlaid sides, a
    /// log on its side (its texture turned), leaves (cut out, foliage), water, a slab and a flower.
pub fn real_blocks_name_their_sprites() c {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::{
    // rust: assets::Assets, biome::Biomes, blocks::BlockFacts, light::LightTables,
    // rust: mesher::MeshTables,
}
//         use std::sync::Arc;
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: let assets = Arc::new(Assets::load(&root)?);
    // rust: let render = Arc::new(assets.reload(&root)?);
    // rust: let facts = BlockFacts::load(&root, assets.registry)?;
    // rust: let tables = Arc::new(MeshTables::new(
    // rust: &assets,
    // rust: &render,
    // rust: &facts,
    // rust: crate::models::load_visibility(&root, assets.registry)?,
    // rust: )?);
    // rust: let context = WorkerContext {
    // rust: light: Arc::new(LightTables::load(&root, assets.registry, &facts)?),
    // rust: tables,
    // rust: assets: assets.clone(),
    // rust: render,
    // rust: biomes: Arc::new(Biomes::load(&root)?),
}
    // rust: let lookup = Lookup::new(&context, 2048);
    // rust: let whole = [0.0, 0.0, 1.0, 1.0];
    // rust: let upright = [0.0, 0.0, 1.0, 0.0, 0.0, 1.0];

    // rust: let stone = lookup.block("minecraft:stone").unwrap();
    // rust: assert!(stone.cube);
    // rust: let top = stone.sides[Direction::Up as usize][0];
    // rust: assert_eq!(
    // rust: (top.rect, top.inset, top.tint, top.sprite.array),
    // rust: (whole, 0.0, None, 0)
    // rust: );
    // rust: assert_eq!(lookup.texture("minecraft:block/stone"), Some(top.sprite));
    // rust: assert_eq!(lookup.texture("block/stone"), Some(top.sprite));
    // rust: assert!(!top.sprite.animated && !top.sprite.cutout);

    // rust: let grass = lookup.block("grass_block").unwrap();
    // rust: assert!(grass.cube);
    // rust: assert_eq!(
    // rust: grass.sides[Direction::Up as usize][0].tint,
    // rust: Some(TintSource::Grass)
    // rust: );
    // rust: assert_eq!(grass.sides[Direction::Down as usize][0].tint, None);
    // rust: let side = &grass.sides[Direction::North as usize];
    // rust: assert_eq!(side.len(), 2, "the side and its overlay");
    // rust: assert_eq!(
    // rust: (side[0].tint, side[1].tint),
    // rust: (None, Some(TintSource::Grass))
    // rust: );
    // rust: assert_eq!(
    // rust: lookup.texture("block/grass_block_side_overlay"),
    // rust: Some(side[1].sprite)
    // rust: );

        // seen from outside, a side's texture runs from its top left: on the north side (looking south, east on
        // the left) u falls with x and v with y; on top, u and v run with x and z (stone's first variant is turned)
    // rust: let planks = lookup.block("oak_planks").unwrap();
    // rust: let uv = |b: &BlockSprites, d: Direction| b.sides[d as usize][0].uv;
    // rust: let north = uv(&planks, Direction::North);
    // rust: assert_eq!(north, [1.0, 1.0, -1.0, 0.0, 0.0, -1.0]);
    // rust: assert_eq!(uv(&planks, Direction::Up), upright);
    // rust: assert_eq!(
    // rust: uv(&planks, Direction::South),
    // rust: [0.0, 1.0, 1.0, 0.0, 0.0, -1.0]
    // rust: );
    // rust: assert_eq!(
    // rust: uv(&planks, Direction::Down),
    // rust: [0.0, 1.0, 1.0, 0.0, 0.0, -1.0]
    // rust: );
        // an upright log's side runs as stone's; on its side (axis x) the texture is turned a quarter
    // rust: let log = lookup.block("oak_log").unwrap();
    // rust: let log_x = lookup.block("minecraft:oak_log[axis=x]").unwrap();
    // rust: assert_eq!(log.sides[Direction::North as usize][0].uv, north);
    // rust: let turned = log_x.sides[Direction::North as usize][0].uv;
    // rust: assert_eq!(
    // rust: (turned[2], turned[5]),
    // rust: (0.0, 0.0),
    // rust: "u runs along y, v along x: {turned:?}"
    // rust: );
    // rust: assert_eq!(
    // rust: log_x.sides[Direction::West as usize][0].sprite,
    // rust: log.sides[Direction::Up as usize][0].sprite,
    // rust: "its end faces west"
    // rust: );

    // rust: let leaves = lookup.block("oak_leaves").unwrap();
    // rust: let leaf = leaves.sides[Direction::Up as usize][0];
    // rust: assert!(leaf.sprite.cutout);
    // rust: assert_eq!(leaf.tint, Some(TintSource::Foliage));
    // rust: assert!(matches!(
    // rust: lookup.block("spruce_leaves").unwrap().sides[0][0].tint,
    // rust: Some(TintSource::Fixed(0x61_9961))
    // rust: ));

    // rust: let water = lookup.block("water").unwrap();
    // rust: let w = water.sides[Direction::Up as usize][0];
    // rust: assert!(w.sprite.animated && w.translucent);
    // rust: assert_eq!(w.tint, Some(TintSource::Water));

    // rust: let slab = lookup.block("stone_slab").unwrap();
    // rust: assert!(!slab.cube);
    // rust: assert_eq!(slab.sides[Direction::Up as usize][0].inset, 0.5);
    // rust: assert_eq!(
    // rust: slab.sides[Direction::North as usize][0].rect,
    // rust: [0.0, 0.0, 1.0, 0.5]
    // rust: );

    // rust: let flower = lookup.block("dandelion").unwrap();
    // rust: assert!(!flower.cube && flower.sides.iter().all(Vec::is_empty));
    // rust: assert!(flower.particle.is_some_and(|p| p.cutout));

    // rust: assert_eq!(lookup.block("minecraft:no_such_block"), None);
    // rust: assert_eq!(lookup.block("stone[no_such=1]"), None);
    // rust: assert!(lookup.block("air").unwrap().sides.iter().all(Vec::is_empty));
    // rust: Ok(())
}
}
