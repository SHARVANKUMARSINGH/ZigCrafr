//! Transpiled from Horizon Rust crate
//! Module: horizon-client_shadows
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity shadows (`EntityRenderer.extractShadow` + `ShadowFeatureRenderer`):
//! `misc/shadow.png` projected onto block collision bounds under
//! an entity, faded by camera distance, depth below the entity and the light
//! at each block.
// use crate::{
    // rust: blocks::BlockFacts, hud::Rect, mesher::Vertex, mobs::Mob, text_display::TextDisplayData,
    // rust: world::World,
}
// use glam::DVec3;

/// Vanilla renderer shadow radius and strength for an entity type id.
pub fn shadow_params(entity: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = entity.strip_prefix("minecraft:").unwrap_or(entity);
    // rust: let radius = match id {
    // rust: "item" | "experience_orb" | "tropical_fish" => 0.15,
    // rust: "tadpole" => 0.14,
    // rust: "pufferfish" => 0.2,
    // rust: "slime" | "magma_cube" | "bat" => 0.25,
    // rust: "chicken" | "cod" | "parrot" | "rabbit" | "frog" | "silverfish" | "endermite" | "vex" => {
    // rust: 0.3
}
    // rust: "cat" | "ocelot" | "fox" | "bee" | "allay" | "salmon" | "armadillo" => 0.4,
    // rust: "zombie" | "husk" | "drowned" | "zombie_villager" | "zombified_piglin" | "skeleton"
    // rust: | "stray" | "wither_skeleton" | "bogged" | "creeper" | "enderman" | "villager"
    // rust: | "wandering_trader" | "witch" | "pillager" | "vindicator" | "evoker" | "illusioner"
    // rust: | "blaze" | "breeze" | "snow_golem" | "copper_golem" | "strider" | "wolf" | "axolotl"
    // rust: | "tnt" | "falling_block" | "end_crystal" => 0.5,
    // rust: "cave_spider" => 0.56,
    // rust: "creaking" => 0.6,
    // rust: "pig" | "cow" | "mooshroom" | "sheep" | "goat" | "llama" | "trader_llama"
    // rust: | "iron_golem" | "camel" | "camel_husk" | "squid" | "glow_squid" | "dolphin" | "turtle"
    // rust: | "hoglin" | "zoglin" | "nautilus" | "zombie_nautilus" | "minecart" => 0.7,
    // rust: "horse" | "donkey" | "mule" | "skeleton_horse" | "zombie_horse" | "phantom" => 0.75,
    // rust: "spider" | "boat" => 0.8,
    // rust: "polar_bear" | "panda" | "warden" => 0.9,
        // GiantMobRenderer: 0.5 times its scale of 6.
    // rust: "giant" => 3.0,
    // rust: "elder_guardian" => 1.2,
    // rust: "happy_ghast" => 2.0,
        // ShulkerRenderer: none.
    // rust: "shulker" => 0.0,
    // rust: "wither" => 1.0,
    // rust: "sniffer" | "ravager" => 1.1,
    // rust: "ghast" => 1.5,
    // rust: _ => 0.5,
}
    // rust: let strength = if matches!(id, "item" | "experience_orb") {
    // rust: 0.75
    // rust: } else {
    // rust: 1.0
}
    // rust: (radius, strength)
}

/// A living entity's shadow radius: `LivingEntityRenderer.getShadowRadius`,
/// the type's radius times `minecraft:scale` (`LivingEntity.getScale`), and
/// for a mob (all but players and mannequins, whose `AvatarRenderer` is no
/// `MobRenderer`) times `LivingEntity.getAgeScale` too. Villagers' and
/// striders' renderers halve a baby's again and the turtle's takes 0.83 of
/// it; slimes, magma cubes, sulfur cubes and pufferfish size theirs alone.
pub fn mob_shadow_radius(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::mobs::Species as S;
    // rust: let species = m.species();
    // rust: match species {
        // AbstractCubeMobRenderer: size * 0.25.
    // rust: S::Slime | S::MagmaCube | S::SulfurCube => return m.extra.size as f32 * 0.25,
        // PufferfishRenderer: 0.1 + 0.1 * puffState.
    // rust: S::Pufferfish => return 0.1 + 0.1 * m.extra.size as f32,
    // rust: _ => {}
}
    // rust: let radius = shadow_params(&m.kind.id).0 * m.model_scale();
    // rust: if matches!(&*m.kind.id, "minecraft:player" | "minecraft:mannequin") || !m.is_baby() {
    // rust: return radius;
}
    // rust: let age = match species {
    // rust: S::Armadillo | S::Camel | S::CamelHusk => 0.6,
    // rust: S::Dolphin => 0.65,
    // rust: S::Goat => 0.55,
    // rust: S::HappyGhast => 0.2375,
    // rust: S::Turtle => 0.3,
    // rust: _ => 0.5,
}
    // rust: let radius = radius * age;
    // rust: match species {
    // rust: S::Villager | S::Strider => radius * 0.5,
    // rust: S::Turtle => radius * 0.83,
    // rust: _ => radius,
}
}

/// The mobs that cast a shadow, at their feet position interpolated by
/// `alpha`, with their type's shadow radius and strength.
/// `EntityRenderer.extractShadow` skips an entity whose
/// `EntityRenderState.isInvisible` is set (`Entity.isInvisible`).
pub fn mob_casters(mobs: *[Mob], alpha: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mobs.iter().filter(|m| !m.is_invisible()).map(move |m| {
    // rust: let (p, q) = (m.previous, m.position);
    // rust: let pos = DVec3::new(
    // rust: p.x + (q.x - p.x) * alpha,
    // rust: p.y + (q.y - p.y) * alpha,
    // rust: p.z + (q.z - p.z) * alpha,
    // rust: );
    // rust: (pos, mob_shadow_radius(m), shadow_params(&m.kind.id).1)
    // rust: })
}

/// `DisplayRenderer.getShadowRadius` and `DisplayRenderer.getShadowStrength`:
/// the display's radius and strength interpolated by `t`, the two fields of
/// its render state. `EntityRenderer.extractShadow` draws nothing at a radius
/// of 0 or less, and text, block and item displays all go through this renderer.
    // rust: pub fn display_caster(
    // rust: pos: DVec3,
    // rust: from: &TextDisplayData,
    // rust: shown: &TextDisplayData,
    // rust: t: f32,
    // rust: ) -> Option<(DVec3, f32, f32)> {
    // rust: let d = shown.blend(from, t);
    // rust: (d.shadow_radius > 0.0).then_some((pos, d.shadow_radius, d.shadow_strength))
}

/// `EntityRenderer.extractShadow`'s gates: the radius clamped to
/// `MAX_SHADOW_RADIUS` (32) and the strength faded over 256 blocks squared
/// from the camera. None when either is 0 or less, so no shadow is drawn.
pub fn shadow_gates(radius: f32, strength: f32, dist_sq: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let radius = radius.min(32.0);
    // rust: if radius <= 0.0 {
    // rust: return None;
}
    // rust: let pow = ((1.0 - dist_sq / 256.0) * f64::from(strength)) as f32;
    // rust: (pow > 0.0).then_some((radius, pow))
}

/// Shadow quads for an entity at `pos` (interpolated feet position).
    // rust: pub fn shadow(
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: collision_bounds: &impl Fn(
    // rust: horizon_world::registry::BlockStateId,
    // rust: ) -> Option<horizon_core::geometry::Aabb>,
    // rust: sprite: Rect,
    // rust: camera: DVec3,
    // rust: pos: DVec3,
    // rust: radius: f32,
    // rust: strength: f32,
    // rust: ambient_light: f32,
    // rust: sky_darken: i32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some((radius, pow)) = shadow_gates(radius, strength, pos.distance_squared(camera)) else {
    // rust: return;
}
    // rust: let r = f64::from(radius);
    // rust: let (x0, x1) = ((pos.x - r).floor() as i32, (pos.x + r).floor() as i32);
    // rust: let (z0, z1) = ((pos.z - r).floor() as i32, (pos.z + r).floor() as i32);
    // rust: let depth = (pow / 0.5 - 1.0).min(radius);
    // rust: let (y0, y1) = (
    // rust: (pos.y - f64::from(depth)).floor() as i32,
    // rust: pos.y.floor() as i32,
    // rust: );
    // rust: for z in z0..=z1 {
    // rust: for x in x0..=x1 {
    // rust: for y in y0..=y1.saturating_add(1) {
    // rust: let state = world.block(x, y - 1, z);
    // rust: let below = facts.get(state);
    // rust: if below.render_shape == crate::blocks::RenderShape::Invisible {
    // rust: continue;
}
                // extractShadowPiece: only a block whose collision shape is a full
                // block takes a shadow (hoppers, cauldrons, slabs, farmland... take none).
    // rust: if !below.full_collision {
    // rust: continue;
}
    // rust: let Some(bounds) = collision_bounds(state) else {
    // rust: continue;
}
    // rust: let top = f64::from(y - 1) + bounds.max_position().y;
    // rust: if top > pos.y + 1e-6 {
    // rust: continue;
}
    // rust: let packed = world.light(x, y, z);
    // rust: let raw = (i32::from(packed >> 4) - sky_darken).max(i32::from(packed & 15));
    // rust: if raw <= 3 {
    // rust: continue;
}
    // rust: let power_at_depth = pow - (pos.y - top) as f32 * 0.5;
    // rust: let alpha = (power_at_depth
    // rust: * 0.5
    // rust: * crate::screen_effects::lightmap_brightness(ambient_light, raw as u8))
    // rust: .clamp(0.0, 1.0);
                // The block top, clipped to the shadow square so the UVs stay inside the sprite.
    // rust: let (bx0, bx1) = (
    // rust: (f64::from(x) + bounds.min_position().x).max(pos.x - r),
    // rust: (f64::from(x) + bounds.max_position().x).min(pos.x + r),
    // rust: );
    // rust: let (bz0, bz1) = (
    // rust: (f64::from(z) + bounds.min_position().z).max(pos.z - r),
    // rust: (f64::from(z) + bounds.max_position().z).min(pos.z + r),
    // rust: );
    // rust: if bx1 <= bx0 || bz1 <= bz0 {
    // rust: continue;
}
    // rust: let u = |wx: f64| (-((wx - pos.x) as f32) / 2.0 / radius + 0.5).clamp(0.0, 1.0);
    // rust: let v = |wz: f64| (-((wz - pos.z) as f32) / 2.0 / radius + 0.5).clamp(0.0, 1.0);
    // rust: let a = (alpha * 255.0) as u32;
    // rust: let color = a << 24 | 0x00FF_FFFF;
                // ShadowFeatureRenderer: relativeY + shapeBelow.minY, the block top
                // itself. A model's feet sit 0.001 above it (LivingEntityRenderer's
                // translate(0, -1.501, 0)), so a lifted shadow fights with them.
    // rust: for (wx, wz) in [(bx0, bz0), (bx0, bz1), (bx1, bz1), (bx1, bz0)] {
    // rust: let p = DVec3::new(wx, top, wz) - camera;
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.as_vec3().to_array(),
    // rust: uv: [
    // rust: sprite.u0 + (sprite.u1 - sprite.u0) * u(wx),
    // rust: sprite.v0 + (sprite.v1 - sprite.v0) * v(wz),
    // rust: ],
    // rust: layer: crate::gfx::SHADOW_OVERLAY,
    // rust: color,
    // rust: light: 240 | 240 << 8,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
}

    // rust: mod tests {
//     use super::*;
pub fn shadows_lie_on_the_block_top_under_model_feet() void {
}
//         use crate::chunk::Chunk;
//         use horizon_world::level::data;
//         use std::{path::PathBuf, sync::Arc};
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("gameplay-facts.json").exists() {
    // rust: eprintln!("skipping resource-backed shadow check: {}", root.display());
    // rust: return;
}
    // rust: let registry = data::load_registry(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, &registry).unwrap();
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let mut world = World::new(facts.air, 0);
    // rust: world.chunks.insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
    // rust: world.set(x, 63, z, stone).unwrap();
}
}
    // rust: let (camera, pos) = (DVec3::new(8.5, 66.0, 4.0), DVec3::new(8.5, 64.0, 8.5));
    // rust: let mut out = Vec::new();
    // rust: let sprite = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: shadow(
    // rust: &world,
    // rust: &facts,
    // rust: &|_| {
    // rust: Some(horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: horizon_core::geometry::Vec3::new(1.0, 1.0, 1.0),
    // rust: ))
    // rust: },
    // rust: sprite,
    // rust: camera,
    // rust: pos,
    // rust: 0.3,
    // rust: 1.0,
    // rust: 0.0,
    // rust: 0,
    // rust: &mut out,
    // rust: );
    // rust: assert_eq!(out.len(), 4);
    // rust: let feet = (pos.y + (1.501 - 24.0 / 16.0) - camera.y) as f32;
    // rust: for v in &out {
    // rust: assert_eq!(v.pos[1], (pos.y - camera.y) as f32);
    // rust: assert!(v.pos[1] < feet);
}
    // rust: let [v0, v1, v2] = [out[0].pos, out[1].pos, out[2].pos].map(glam::Vec3::from);
    // rust: assert!(
    // rust: (v1 - v0).cross(v2 - v0).y > 0.0,
    // rust: "shadow quad winds upward (+Y) so back-face culling hides it from below"
    // rust: );
        // Blocks whose collision top is not a flat full block take no shadow
        // (vanilla's isCollisionShapeFullBlock gate), even when their collision
        // bounds reach y=1 like a hopper's rim.
    // rust: for name in [
    // rust: "minecraft:hopper",
    // rust: "minecraft:cauldron",
    // rust: "minecraft:composter",
    // rust: "minecraft:farmland",
    // rust: "minecraft:oak_slab",
    // rust: "minecraft:soul_sand",
    // rust: "minecraft:snow",
    // rust: "minecraft:chest",
    // rust: "minecraft:oak_fence",
    // rust: "minecraft:oak_stairs",
    // rust: ] {
    // rust: let state = registry.default_state(name).unwrap();
    // rust: assert!(!facts.get(state).full_collision, "{name}");
    // rust: world.set(8, 63, 8, state).unwrap();
    // rust: out.clear();
    // rust: shadow(
    // rust: &world,
    // rust: &facts,
    // rust: &|_| {
    // rust: Some(horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: horizon_core::geometry::Vec3::new(1.0, 1.0, 1.0),
    // rust: ))
    // rust: },
    // rust: sprite,
    // rust: camera,
    // rust: DVec3::new(8.5, 64.0, 8.5),
    // rust: 0.3,
    // rust: 1.0,
    // rust: 0.0,
    // rust: 0,
    // rust: &mut out,
    // rust: );
    // rust: assert!(out.is_empty(), "{name} took a shadow");
}
}

pub fn invisible_mobs_cast_no_shadow() void {
}
//         use horizon_core::geometry::Vec3;
    // rust: let kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let mut seen = Mob::new(1, kind.clone(), Vec3::new(1.0, 64.0, 1.0), 0.0);
    // rust: seen.previous = Vec3::new(0.0, 64.0, 1.0);
        // A server's invisible mob (shared flag 0x20) and one ticked here
        // with the Invisibility effect.
    // rust: let mut flagged = Mob::new(2, kind.clone(), Vec3::ZERO, 0.0);
    // rust: flagged.invisible = true;
    // rust: let mut potion = Mob::new(3, kind, Vec3::ZERO, 0.0);
    // rust: potion.add_effect("minecraft:invisibility", 600, 0);
    // rust: let mobs = [seen, flagged, potion];
    // rust: let casters: Vec<_> = mob_casters(&mobs, 0.5).collect();
    // rust: assert_eq!(
    // rust: casters,
    // rust: vec![(DVec3::new(0.5, 64.0, 1.0), 0.7, 1.0)],
    // rust: "only the visible mob casts a shadow"
    // rust: );
}
pub fn mob(id: []const u8, species: crate::mobs::Species) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = id.into();
    // rust: kind.species = species;
    // rust: Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(kind),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: )
}
pub fn babies_cast_their_age_scaled_shadow() void {
}
//         use crate::mobs::Species as S;
    // rust: let mut cow = mob("minecraft:cow", S::Cow);
    // rust: cow.extra.age = -24000;
        // MobRenderer: 0.7 * ageScale 0.5.
    // rust: assert_eq!(mob_shadow_radius(&cow), 0.35);
    // rust: let mut villager = mob("minecraft:villager", S::Villager);
    // rust: assert_eq!(mob_shadow_radius(&villager), 0.5);
    // rust: villager.extra.age = -24000;
        // VillagerRenderer halves MobRenderer's 0.5 * 0.5 again.
    // rust: assert_eq!(mob_shadow_radius(&villager), 0.125);
    // rust: let mut goat = mob("minecraft:goat", S::Goat);
    // rust: goat.extra.age = -24000;
        // Goat.getAgeScale: 0.55.
    // rust: assert_eq!(mob_shadow_radius(&goat), 0.7 * 0.55);
    // rust: let mut strider = mob("minecraft:strider", S::Strider);
    // rust: strider.extra.age = -24000;
        // StriderRenderer halves AgeableMobRenderer's 0.5 * 0.5 again.
    // rust: assert_eq!(mob_shadow_radius(&strider), 0.125);
    // rust: let mut turtle = mob("minecraft:turtle", S::Turtle);
    // rust: turtle.extra.age = -24000;
        // TurtleRenderer takes 0.83 of the 0.7 * 0.3 age-scaled radius.
    // rust: assert!((mob_shadow_radius(&turtle) - 0.7 * 0.3 * 0.83).abs() < 1e-6);
}
pub fn scaled_players_cast_a_scaled_shadow() void {
}
//         use crate::mobs::Species as S;
    // rust: let mut player = mob("minecraft:player", S::Zombie);
    // rust: assert_eq!(mob_shadow_radius(&player), 0.5);
    // rust: player.extra.model_scale = 2.0;
    // rust: assert_eq!(mob_shadow_radius(&player), 1.0);
    // rust: let mut mannequin = mob("minecraft:mannequin", S::Zombie);
    // rust: mannequin.extra.model_scale = 0.25;
    // rust: assert_eq!(mob_shadow_radius(&mannequin), 0.125);
        // AvatarRenderer is no MobRenderer: no age scale.
    // rust: mannequin.extra.age = -1;
    // rust: assert_eq!(mob_shadow_radius(&mannequin), 0.125);
}
pub fn sized_mobs_keep_their_own_radius() void {
}
//         use crate::mobs::Species as S;
    // rust: let mut slime = mob("minecraft:slime", S::Slime);
    // rust: slime.extra.size = 4;
    // rust: slime.extra.model_scale = 2.0;
    // rust: assert_eq!(mob_shadow_radius(&slime), 1.0);
    // rust: let mut puffer = mob("minecraft:pufferfish", S::Pufferfish);
    // rust: puffer.extra.size = 2;
    // rust: assert_eq!(mob_shadow_radius(&puffer), 0.3);
}
pub fn items_and_orbs_keep_their_radius() void {
}
        // Not living: the caller takes the type's radius as it is.
    // rust: assert_eq!(shadow_params("minecraft:item").0, 0.15);
    // rust: assert_eq!(shadow_params("minecraft:experience_orb").0, 0.15);
}
pub fn vanilla_radii() void {
}
    // rust: assert_eq!(shadow_params("minecraft:zombie"), (0.5, 1.0));
    // rust: assert_eq!(shadow_params("minecraft:item"), (0.15, 0.75));
    // rust: assert_eq!(shadow_params("minecraft:spider"), (0.8, 1.0));
}
    /// `DisplayRenderer.getShadowRadius`/`getShadowStrength` behind
    /// `EntityRenderer.extractShadow`: a display casts a shadow only above a
    /// radius of 0, with the radius clamped to 32 and the strength faded by
    /// the camera distance.
pub fn displays_cast_a_gated_shadow() void {
}
    // rust: let pos = DVec3::new(4.0, 64.0, 4.0);
    // rust: let empty = TextDisplayData::default();
    // rust: assert_eq!(display_caster(pos, &empty, &empty, 0.5), None);
    // rust: let shown = TextDisplayData {
    // rust: shadow_radius: 40.0,
    // rust: shadow_strength: 0.5,
    // rust: ..TextDisplayData::default()
}
        // Halfway from the default (no radius, full strength).
    // rust: assert_eq!(
    // rust: display_caster(pos, &empty, &shown, 0.5),
    // rust: Some((pos, 20.0, 0.75))
    // rust: );
    // rust: let (_, radius, strength) = display_caster(pos, &empty, &shown, 1.0).unwrap();
    // rust: assert_eq!((radius, strength), (40.0, 0.5));
        // Math.min(radius, 32) and (1 - distanceSq / 256) * strength.
    // rust: assert_eq!(shadow_gates(radius, strength, 64.0), Some((32.0, 0.375)));
    // rust: assert_eq!(shadow_gates(radius, strength, 256.0), None);
    // rust: assert_eq!(shadow_gates(radius, 0.0, 0.0), None);
}
}
