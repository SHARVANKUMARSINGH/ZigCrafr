//! Transpiled from Horizon Rust crate
package horizon_client_mob_blocks

import "core:fmt"
import "core:mem"
import "core:math"

// Blocks mobs carry: block items in a hand (`ItemInHandLayer`) and the
// block state an enderman holds (`CarriedBlockLayer`). Also the block
// models mobs wear (`SnowGolemHeadLayer`, `MushroomCowMushroomLayer`).
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{Mob, Species, render},
}

// `CarriedBlockLayer.submit`: block models use coordinates in [0, 1].
carried_block_matrix :: proc(base: glam::Mat4) -> g {
    // Ported from Horizon
    return {}
}
    // rust: base * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.6875, -0.75))
    // rust: * glam::Mat4::from_rotation_x(20.0f32.to_radians())
    // rust: * glam::Mat4::from_rotation_y(45.0f32.to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.25, 0.1875, 0.25))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-0.5, -0.5, 0.5))
    // rust: * glam::Mat4::from_rotation_y(90.0f32.to_radians())
}

// Drops the quads of `out[first..]` whose face normal points away from the eye, which
// is the origin of camera-relative vertices. Each quad is four vertices carrying its
// face normal in `Vertex::normal`, as `block_model_vertices` writes for diffuse faces.
cull_back_quads :: proc(out: ^[dynamic]Vertex, first: uint) {
}
    // rust: let mut kept = first;
    // rust: for quad in (first..out.len()).step_by(4) {
    // rust: let vertices = &out[quad..quad + 4];
    // rust: let n = vertices[0].normal;
    // rust: let normal = glam::Vec3::new(f32::from(n[0]), f32::from(n[1]), f32::from(n[2]));
    // rust: let centre = vertices.iter().fold(glam::Vec3::ZERO, |sum, v| {
    // rust: sum + glam::Vec3::from_array(v.pos)
    // rust: }) * 0.25;
        // The eye is at the origin: the face is seen from its front when the eye is on the
        // side its normal points to, that is when `normal . (eye - centre) > 0`.
    // rust: if normal.dot(centre) < 0.0 {
    // rust: out.copy_within(quad..quad + 4, kept);
    // rust: kept += 4;
}
}
    // rust: out.truncate(kept);
}

// `CustomHeadLayer.translateToHead` and the banner's `head` display.
banner_matrix :: proc(head: glam::Mat4) -> g {
    // Ported from Horizon
    return {}
}
    // rust: head * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.25, 0.0))
    // rust: * glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(0.625, -0.625, -0.625))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 1.0, 7.0 / 16.0))
    // rust: * glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(1.5))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.5, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(2.0 / 3.0, -2.0 / 3.0, -2.0 / 3.0))
}

// `BlockDecorationLayer.submit` and `CopperGolemModel.applyBlockOnAntennaTransform`, then the
// block model's own display transformation, which `BlockModelRenderState.submitModel` post-multiplies.
antenna_block_matrix :: proc(head: glam::Mat4, flowerbed_shift: bool) -> g {
    // Ported from Horizon
    return {}
}
    // UNIT_CUBE_BOTTOM_CENTER_TO_ANTENNA_CENTER: translation(-0.5, 0, -0.5)
    // then rotateAround(Z 180, 0.5, 0.5, 0.5), which JOML post-multiplies.
    // rust: let unit = glam::Mat4::from_translation(glam::Vec3::new(-0.5, 0.0, -0.5))
    // rust: * glam::Mat4::from_translation(glam::Vec3::splat(0.5))
    // rust: * glam::Mat4::from_rotation_z(180.0f32.to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::splat(-0.5));
    // rust: let t = head * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.75, 0.0)) * unit;
    // rust: if flowerbed_shift {
        // `BuiltInBlockModels.createFlowerBedModel`'s Transformation(0.25, 0, 0.25).
    // rust: t * glam::Mat4::from_translation(glam::Vec3::new(0.25, 0.0, 0.25))
    // rust: } else {
    // rust: t
}
}

// `ElderGuardianParticle.lifetime`.
    // rust: pub(super) const APPARITION_TICKS: i32 = 30;

    // rust: impl Game<'_> {
    // Count the elder guardian's apparition down.
    // rust: pub(super) fn tick_apparition(&mut self) {
    // rust: self.creatures.elder_apparition = (self.creatures.elder_apparition - 1).max(0);
}
    // `ElderGuardianParticleGroup`: the ghostly elder guardian that swings
    // up in front of the camera while the curse is laid, fading in and out.
    // rust: pub(super) fn elder_apparition_geometry(&self, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let left = self.creatures.elder_apparition;
    // rust: if left <= 0 {
    // rust: return;
}
    // rust: let Some(kind) = self.res.mob_types().get("minecraft:elder_guardian") else {
    // rust: return;
}
    // rust: let Some(r) = self.gui.atlas.sprites.get("entity/guardian_elder").copied() else {
    // rust: return;
}
    // rust: let age = (APPARITION_TICKS - left) as f32 + alpha as f32;
    // rust: let t = (age / APPARITION_TICKS as f32).clamp(0.0, 1.0);
    // rust: let fade = 0.05 + 0.5 * (t * std::f32::consts::PI).sin();
    // rust: let color = (((fade * 255.0) as u32) << 24) | 0x00FF_FFFF;
    // rust: let (yaw, pitch) = (self.yaw.to_radians(), self.pitch.to_radians());
    // rust: let forward = glam::Vec3::new(
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: );
    // rust: let right = forward.cross(glam::Vec3::Y).normalize_or_zero();
    // rust: let up = right.cross(forward).normalize_or_zero();
        // The camera's rotation: local +x right, +y up, +z behind.
    // rust: let camera = glam::Mat4::from_cols(
    // rust: right.extend(0.0),
    // rust: up.extend(0.0),
    // rust: (-forward).extend(0.0),
    // rust: glam::Vec4::W,
    // rust: );
    // rust: let k = 0.425_531_92;
    // rust: let m = camera
    // rust: * glam::Mat4::from_rotation_x((60.0 - 150.0 * t).to_radians())
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(k, -k, -k))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.56, 3.5));
    // rust: let poses = horizon_client::mobs::anim::Poses::new(&kind.model);
    // rust: render::draw(
    // rust: &kind.model,
    // rust: m,
    // rust: &poses,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: color,
    // rust: 240 | 240 << 8,
    // rust: 0,
    // rust: out,
    // rust: );
}
    // The ominous banner a raid captain wears on its head: the banner model
    // with its eight pattern layers (`CustomHeadLayer`).
    // rust: fn captain_banner_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
//         use horizon_client::mobs::anim::Poses;
    // rust: if !horizon_client::mobs::raider::is_captain(mob) {
    // rust: return;
}
    // rust: let Some((pole, flag)) = &self.entity_models.banner else {
    // rust: return;
}
    // rust: let Some(head) =
    // rust: render::part_transform(mob, alpha as f32, camera, self.res.mob_data(), "head")
    // rust: else {
    // rust: return;
}
    // rust: let m = banner_matrix(head);
    // rust: let atlas = &self.gui.atlas;
    // rust: let uv = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
        // BannerRenderer: the flag sways with a per-banner phase.
    // rust: let phase =
    // rust: (((u64::from(mob.id) * 7 + u64::from(mob.age)) % 100) as f32 + alpha as f32) / 100.0;
    // rust: let mut flag_poses = Poses::new(flag);
    // rust: flag_poses.xrot(
    // rust: "flag",
    // rust: (-0.0125 + 0.01 * (2.0 * std::f32::consts::PI * phase).cos()) * std::f32::consts::PI,
    // rust: );
    // rust: let still = Poses::new(pole);
    // rust: let white = 0xFFFF_FFFF;
    // rust: if let Some(r) = uv("entity/banner/banner_base") {
    // rust: render::draw(pole, m, &still, r, white, light, 0, out);
    // rust: render::draw(flag, m, &flag_poses, r, white, light, 0, out);
}
    // rust: let layers =
    // rust: std::iter::once(("base", "white")).chain(horizon_client::item_data::OMINOUS_LAYERS);
    // rust: for (pattern, dye) in layers {
    // rust: let Some(r) = uv(&format!("entity/banner/{pattern}")) else {
    // rust: continue;
}
    // rust: let index = render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|n| *n == dye)
    // rust: .unwrap_or(0);
    // rust: let color = render::abgr(render::DYE[index]);
    // rust: render::draw(flag, m, &flag_poses, r, color, light, 0, out);
}
}
    // The blocks one mob holds or carries.
    // rust: pub(super) fn mob_block_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: skin: Option<&mut super::creatures::Skinned>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: self.captain_banner_geometry(mob, camera, alpha, light, out);
    // rust: self.held_item_geometry(mob, camera, alpha, light, true, skin, out);
    // rust: self.worn_block_geometry(mob, camera, alpha, light, out);
    // rust: self.head_item_geometry(mob, camera, alpha, light, true, out);
    // rust: self.golem_flower_geometry(mob, camera, alpha, light, out);
    // rust: self.antenna_block_geometry(mob, camera, alpha, light, out);
    // rust: if mob.species() == Species::Enderman
    // rust: && let Some(state) = mob.extra.carried
    // rust: {
            // CarriedBlockLayer: OverlayTexture.NO_OVERLAY, never the hurt tint;
            // the block's baked model (seed 42) on the unit cube, not centred.
    // rust: let base = render::base_transform(mob, alpha as f32, camera);
    // rust: let t = carried_block_matrix(base);
            // Preserve cross models (flowers, fungi) and state properties (facing).
    // rust: let first = out.len();
    // rust: self.block_model_vertices(state, 42, t, light, true, out);
            // The carried block uses the item cutout render type, which culls back faces
            // (RenderPipelines.ITEM_CUTOUT). Without that, both coplanar sides of a cross
            // model are drawn and flicker. CULL_BACK would drop them too, but it turns off
            // the normal lighting this model needs.
    // rust: cull_back_quads(out, first);
}
}
    // `BlockDecorationLayer.submit`: the block item in a copper golem's
    // antenna slot (a flower, or any block item), drawn at the antenna by
    // `CopperGolemModel.applyBlockOnAntennaTransform` with `NO_OVERLAY`. Only
    // the block's default state with the item's `block_state` component
    // applied (`BlockItemStateProperties.apply`).
    // rust: fn antenna_block_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if mob.species() != Species::CopperGolem || horizon_client::mobs::trader::is_invisible(mob)
    // rust: {
    // rust: return;
}
    // rust: let Some(stack) = mob.saddle_item() else {
    // rust: return;
}
    // rust: let Some(mut state) = self.pack.assets.registry.default_state(&stack.item) else {
    // rust: return;
}
        // CopperGolemRenderer.extractRenderState: blockItemState.apply, one
        // property at a time; a property the block lacks or a value it
        // cannot take leaves the state as it was.
    // rust: if let Some(horizon_world::nbt::Tag::Compound(saved)) =
    // rust: stack.data().and_then(|d| d.other("minecraft:block_state"))
    // rust: {
    // rust: for (k, v) in saved.iter() {
    // rust: let horizon_world::nbt::Tag::String(v) = v else {
    // rust: continue;
}
    // rust: let (k, v) = (k.to_string_lossy(), v.to_string_lossy());
    // rust: let has = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .is_some_and(|s| s.properties.contains_key(&*k));
    // rust: if has && let Some(next) = self.with_props(state, &[(&*k, &*v)]) {
    // rust: state = next;
}
}
}
    // rust: let Some(head) =
    // rust: render::part_transform(mob, alpha as f32, camera, self.res.mob_data(), "head")
    // rust: else {
    // rust: return;
}
        // Only wildflowers and pink petals carry the flowerbed display shift.
    // rust: let flowerbeds = matches!(
    // rust: &*stack.item,
    // rust: "minecraft:wildflowers" | "minecraft:pink_petals"
    // rust: );
    // rust: let t = antenna_block_matrix(head, flowerbeds);
    // rust: self.block_model_vertices(state, 42, t, light, true, out);
}
    // `IronGolemFlowerLayer`: the poppy in the right arm while the golem
    // offers it (`getOfferFlowerTick() > 0`), drawn with `NO_OVERLAY`.
    // rust: fn golem_flower_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
//         use glam::{Mat4, Vec3};
    // rust: if mob.species() != Species::IronGolem
    // rust: || mob.extra.counter <= 0
    // rust: || horizon_client::mobs::trader::is_invisible(mob)
    // rust: {
    // rust: return;
}
    // rust: let Some(state) = self.pack.assets.registry.default_state("minecraft:poppy") else {
    // rust: return;
}
    // rust: let Some(arm) =
    // rust: render::part_transform(mob, alpha as f32, camera, self.res.mob_data(), "right_arm")
    // rust: else {
    // rust: return;
}
    // rust: let t = arm
    // rust: * Mat4::from_translation(Vec3::new(-1.1875, 1.0625, -0.9375))
    // rust: * Mat4::from_translation(Vec3::splat(0.5))
    // rust: * Mat4::from_scale(Vec3::splat(0.5))
    // rust: * Mat4::from_rotation_x((-90.0f32).to_radians())
    // rust: * Mat4::from_translation(Vec3::splat(-0.5));
    // rust: self.block_model_vertices(state, 42, t, light, true, out);
}
    // `SnowGolemHeadLayer` and `MushroomCowMushroomLayer`: the carved pumpkin
    // on a snow golem's head, and the mushrooms on an adult mooshroom's back
    // and head, as baked block models.
    // rust: fn worn_block_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
//         use glam::{Mat4, Vec3};
    // rust: let species = mob.species();
    // rust: let on_head = match species {
    // rust: Species::SnowGolem => !mob.extra.sheared,
    // rust: Species::Mooshroom => !mob.is_baby(),
    // rust: _ => false,
}
        // The layers draw nothing on an invisible mob (the glow outline is not drawn).
    // rust: if !on_head || horizon_client::mobs::trader::is_invisible(mob) {
    // rust: return;
}
    // rust: let registry = &self.pack.assets.registry;
    // rust: let block = match species {
    // rust: Species::SnowGolem => "minecraft:carved_pumpkin",
    // rust: _ if mob.extra.variant == 1 => "minecraft:brown_mushroom",
    // rust: _ => "minecraft:red_mushroom",
}
    // rust: let Some(state) = registry.default_state(block) else {
    // rust: return;
}
    // rust: let alpha = alpha as f32;
    // rust: let Some(head) = render::part_transform(mob, alpha, camera, self.res.mob_data(), "head")
    // rust: else {
    // rust: return;
}
    // rust: let unit = Mat4::from_translation(Vec3::splat(-0.5));
    // rust: let flip = Mat4::from_scale(Vec3::new(-1.0, -1.0, 1.0));
    // rust: let at = |x: f32, y: f32, z: f32| Mat4::from_translation(Vec3::new(x, y, z));
    // rust: let spin = |degrees: f32| Mat4::from_rotation_y(degrees.to_radians());
    // rust: let transforms = if species == Species::SnowGolem {
    // rust: vec![
    // rust: head * at(0.0, -0.34375, 0.0)
    // rust: * spin(180.0)
    // rust: * Mat4::from_scale(Vec3::new(0.625, -0.625, -0.625))
    // rust: * unit,
    // rust: ]
    // rust: } else {
    // rust: let base = render::base_transform(mob, alpha, camera);
    // rust: vec![
    // rust: base * at(0.2, -0.35, 0.5) * spin(-48.0) * flip * unit,
    // rust: base * at(0.2, -0.35, 0.5)
    // rust: * spin(42.0)
    // rust: * at(0.1, 0.0, -0.6)
    // rust: * spin(-48.0)
    // rust: * flip
    // rust: * unit,
    // rust: head * at(0.0, -0.7, -0.2) * spin(-78.0) * flip * unit,
    // rust: ]
}
        // The hurt tint reaches these blocks as it does the body.
    // rust: let overlay = horizon_client::overlay::living(0.0, mob.hurt_time > 0 || mob.death_time > 0);
    // rust: for t in transforms {
    // rust: let start = out.len();
    // rust: self.block_model_vertices(state, 0, t, light, true, out);
    // rust: for vertex in &mut out[start..] {
    // rust: vertex.layer = overlay;
}
}
}
    // `ItemInHandLayer`: both hands through the item model pipeline; `lit`
    // applies the level's diffuse lighting (off for GUI previews, which
    // light the projected quads themselves).
    // `skin`: the mob's GPU path draws, which a lit item joins when it can.
    // rust: pub(super) fn held_item_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: lit: bool,
    // rust: mut skin: Option<&mut super::creatures::Skinned>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
        // ItemInHandLayer submits with OverlayTexture.NO_OVERLAY: no hurt tint.
    // rust: for (item, off_hand) in [(&mob.extra.main_hand, false), (&mob.extra.off_hand, true)] {
    // rust: let Some(item) = item else { continue };
    // rust: let left = off_hand != mob.main_arm_left();
            // PlayerItemInHandLayer.submitArmWithItem (avatars only): a spyglass
            // in use, with no swing in progress, is held to the eye (`heldOnHead`).
    // rust: let spyglass_to_eye = &**item == "minecraft:spyglass"
    // rust: && (&*mob.kind.id == "minecraft:player" || mob.species() == Species::Mannequin)
    // rust: && off_hand == mob.extra.using_off_hand
    // rust: && mob.extra.using_item > 0
    // rust: && horizon_client::mobs::anim::state(mob, alpha as f32).swing < 1.0e-5;
    // rust: let t = if spyglass_to_eye {
    // rust: render::held_to_eye_matrix(mob, alpha as f32, camera, self.res.mob_data(), left)
    // rust: } else {
    // rust: render::held_item_transform(mob, alpha as f32, camera, self.res.mob_data(), left)
}
    // rust: let Some(t) = t else {
    // rust: continue;
}
    // rust: let slot = if off_hand {
    // rust: horizon_client::mobs::gear::OFF
    // rust: } else {
    // rust: horizon_client::mobs::gear::MAIN
}
    // rust: let local_player = self
    // rust: .player_model
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.id == mob.id && p.kind.id == mob.kind.id);
    // rust: let mut stack = if local_player {
    // rust: let Some(stack) = self.stack_in(if off_hand {
    // rust: super::shield::OFFHAND_SLOT
    // rust: } else {
    // rust: self.selected
    // rust: }) else {
    // rust: continue;
}
    // rust: stack.clone()
    // rust: } else if mob.species() == Species::Witch
    // rust: && horizon_client::mobs::witch::holds_potion(item)
    // rust: && &**item != "minecraft:potion"
    // rust: {
                // A drinking witch's main hand holds the potion's type, drawn as a potion item.
    // rust: ItemStack::new("minecraft:potion", 1).with_potion(item)
    // rust: } else {
                // The stack the equipment packet (or the mob's own AI) left:
                // its components are what the item model reads, a loaded
                // crossbow's `charged_projectiles` included.
    // rust: let Some(stack) = render::held_item_stack(&mob.extra, off_hand) else {
    // rust: continue;
}
    // rust: stack
}
    // rust: if !local_player && horizon_client::mobs::gear::enchanted(mob, slot) {
                // The gear's enchantments are not tracked, only that it has some.
    // rust: stack.enchant("minecraft:unbreaking", 1);
}
    // rust: if &**item == "minecraft:crossbow" && mob.extra.flag2 {
    // rust: stack.data_mut().charged = vec![ItemStack::new("minecraft:arrow", 1)];
}
    // rust: let mut owner = super::item_draw::owner_at(
    // rust: [mob.position.x, mob.position.y, mob.position.z],
    // rust: mob.body_yaw,
    // rust: &mob.kind.id,
    // rust: );
            // The local player's rod while its hook is out.
    // rust: owner.fishing_cast_with_this_item = self.cast_rod().is_some()
    // rust: && self.main_hand_rod() != off_hand
    // rust: && self
    // rust: .player_model
    // rust: .as_ref()
    // rust: .is_some_and(|p| std::ptr::eq(p, mob));
    // rust: owner.main_arm_left = mob.main_arm_left();
    // rust: if off_hand == mob.extra.using_off_hand && mob.extra.using_item > 0 {
    // rust: owner.using_this_item = true;
    // rust: owner.use_duration = 72_000;
    // rust: owner.use_item_remaining_ticks = 72_000 - mob.extra.using_item;
    // rust: owner.crossbow_charge_duration = 25;
}
//             use horizon_assets::item_model::DisplayContext as Context;
            // PandaHoldsItemLayer, FoxHeldItemLayer and DolphinCarryingItemLayer
            // show the item as it lies on the ground.
    // rust: let (context, ordinal) = match (mob.species(), left) {
                // The spyglass held to the eye is the HEAD display.
    // rust: _ if spyglass_to_eye => (Context::Head, 5),
    // rust: (Species::Panda | Species::Fox | Species::Witch | Species::Dolphin, _) => {
    // rust: (Context::Ground, 7)
}
    // rust: (_, true) => (Context::ThirdPersonLeftHand, 1),
    // rust: (_, false) => (Context::ThirdPersonRightHand, 2),
}
            // `updateForLiving`: seeded by the entity id plus the context ordinal.
    // rust: let seed = mob.id as i32 + ordinal;
    // rust: let hand = if off_hand {
    // rust: horizon_client::cit::Hand::Off
    // rust: } else {
    // rust: horizon_client::cit::Hand::Main
}
    // rust: let state = self.resolve_item_in_hand(&stack, context, Some(&owner), seed, hand);
    // rust: if lit
    // rust: && let Some(skinned) = skin.as_deref_mut()
    // rust: && self.skin_item_into(&state, t, light, skinned)
    // rust: {
    // rust: continue;
}
    // rust: if lit {
    // rust: self.submit_item_world(&state, t, light, out);
    // rust: } else {
    // rust: self.submit_item_unlit(&state, t, light, out);
}
}
}
    // `CustomHeadLayer`: non-armour items worn in the head slot (carved
    // pumpkins, mob skulls and player heads, or custom blocks) on players
    // and mobs.
    // rust: pub(super) fn head_item_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: light: u32,
    // rust: lit: bool,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
        // The layer also draws on an invisible mob.
    // rust: let species = mob.species();
    // rust: if species == Species::SnowGolem
    // rust: || horizon_client::mobs::species::body_slot(species)
    // rust: || horizon_client::mobs::equine::is_equine(species)
    // rust: || horizon_client::mobs::raider::is_captain(mob)
    // rust: {
    // rust: return;
}
    // rust: let local_player = self
    // rust: .player_model
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.id == mob.id && p.kind.id == mob.kind.id);
    // rust: let mut stack = if local_player {
    // rust: let Some(stack) = &self.armor[0] else { return };
    // rust: stack.clone()
    // rust: } else if let Some(stack) = &mob.extra.armor[0] {
    // rust: stack.clone()
    // rust: } else if let Some(head) = &mob.extra.head {
    // rust: ItemStack::new(head, 1)
    // rust: } else {
    // rust: return;
}
        // Helmets are drawn by HumanoidArmorLayer, not CustomHeadLayer.
    // rust: if self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_asset.as_ref())
    // rust: .is_some()
    // rust: {
    // rust: return;
}
    // rust: if !local_player
    // rust: && horizon_client::mobs::gear::enchanted(mob, horizon_client::mobs::gear::HEAD)
    // rust: {
    // rust: stack.enchant("minecraft:unbreaking", 1);
}
    // rust: let Some(head) =
    // rust: render::part_transform(mob, alpha as f32, camera, self.res.mob_data(), "head")
    // rust: else {
    // rust: return;
}
    // rust: if let Some(kind) = super::armor_stands::skull_kind(&stack.item) {
            // Only the renderers that add a `CustomHeadLayer` draw a skull:
            // the humanoid mobs, the illagers, the villagers, the copper golem
            // and the avatars.
    // rust: if !(&*mob.kind.id == "minecraft:player"
    // rust: || matches!(
    // rust: species,
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::WitherSkeleton
    // rust: | Species::Piglin
    // rust: | Species::PiglinBrute
    // rust: | Species::ZombifiedPiglin
    // rust: | Species::Pillager
    // rust: | Species::Vindicator
    // rust: | Species::Evoker
    // rust: | Species::Illusioner
    // rust: | Species::Villager
    // rust: | Species::WanderingTrader
    // rust: | Species::CopperGolem
    // rust: | Species::Mannequin
    // rust: ))
    // rust: {
    // rust: return;
}
            // translateToHead, the renderer's `skullYOffset` (the villager's
            // `CUSTOM_HEAD_TRANSFORMS`), then the skull's SKULL_SCALE.
    // rust: let y_offset = if species == Species::Villager {
    // rust: -0.074_218_75
    // rust: } else {
    // rust: 0.0
}
    // rust: let pose = head
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, y_offset, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(1.1875));
    // rust: let special = horizon_assets::item_model::SpecialModel {
    // rust: kind: if kind == "player" {
    // rust: horizon_assets::item_model::SpecialKind::PlayerHead
    // rust: } else {
    // rust: horizon_assets::item_model::SpecialKind::Head {
    // rust: kind: kind.to_owned(),
    // rust: texture: None,
    // rust: animation: worn_head_animation(
    // rust: mob,
                            // The local player's synthetic mob carries no `mount`.
    // rust: mob.extra
    // rust: .mount
    // rust: .or(if local_player { self.riding } else { None }),
    // rust: &self.mobs,
    // rust: alpha as f32,
    // rust: ),
}
    // rust: },
}
    // rust: let mut sink = horizon_client::item_render::WorldSink {
    // rust: out,
    // rust: light,
    // rust: lights: if lit {
    // rust: Some(horizon_client::block_entity_render::diffuse_lights(
    // rust: self.dim == super::Dim::Nether,
    // rust: ))
    // rust: } else {
    // rust: None
    // rust: },
    // rust: glint: self.glint(),
    // rust: tier: 0,
}
    // rust: let profile = stack
    // rust: .extra
    // rust: .as_deref()
    // rust: .and_then(|d| d.other.iter().find(|(k, _)| k == "minecraft:profile"))
    // rust: .map(|(_, t)| horizon_client::scoreboard::tag_to_json(t))
    // rust: .unwrap_or(serde_json::Value::Null);
    // rust: let has_foil = stack.data().is_some_and(|d| !d.enchantments.is_empty());
    // rust: self.pack.item_renderer.submit_special(
    // rust: &special,
    // rust: &profile,
    // rust: has_foil,
    // rust: pose,
    // rust: &self.gui.atlas.sprites,
    // rust: &self.item_host(),
    // rust: &mut sink,
    // rust: );
    // rust: return;
}
//         use horizon_assets::item_model::DisplayContext;
    // rust: let pose = head
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.25, 0.0))
    // rust: * glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(0.625, -0.625, -0.625));
    // rust: let owner = super::item_draw::owner_at(
    // rust: [mob.position.x, mob.position.y, mob.position.z],
    // rust: mob.body_yaw,
    // rust: &mob.kind.id,
    // rust: );
    // rust: let seed = mob.id as i32 + 5;
    // rust: let state = self.resolve_item(&stack, DisplayContext::Head, Some(&owner), seed);
    // rust: if lit {
    // rust: self.submit_item_world(&state, pose, light, out);
    // rust: } else {
    // rust: self.submit_item_unlit(&state, pose, light, out);
}
}
}

// `LivingEntityRenderer.extractRenderState`'s `wornHeadAnimationPos`: the
// walk position of the living mob `mount` carries the wearer on (a boat or
// minecart is no mob, so it is not found), else the wearer's own.
worn_head_animation :: proc(wearer: ^Mob, mount: Maybe(u32), mobs: ^[Mob], alpha: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: mount
    // rust: .and_then(|id| mobs.iter().find(|m| m.id == id))
    // rust: .map_or_else(
    // rust: || horizon_client::mobs::anim::state(wearer, alpha).pos,
    // rust: |v| horizon_client::mobs::anim::walk_position(v, alpha),
    // rust: )
}

    // rust: mod tests {
//     use super::*;
//     use glam::{Mat4, Vec3};

    // A mob of the prepared resources' type `kind` (None without them).
mob :: proc(id: u32, kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let types = horizon_client::mobs::MobTypes::load(&root).ok()?;
    // rust: let t = std::sync::Arc::new(types.types.get(kind)?.clone());
    // rust: Some(horizon_client::mobs::Mob::new(
    // rust: id,
    // rust: t,
    // rust: horizon_core::geometry::Vec3::new(0.0, 0.0, 0.0),
    // rust: 0.0,
    // rust: ))
}

a_worn_head_follows_the_living_vehicle :: proc() {
}
    // rust: let (Some(mut wearer), Some(mut horse)) =
    // rust: (mob(1, "minecraft:zombie"), mob(2, "minecraft:horse"))
    // rust: else {
    // rust: return;
}
    // rust: wearer.limb_position = 1.0;
    // rust: wearer.limb_speed = 0.5;
    // rust: horse.limb_position = 4.0;
    // rust: horse.limb_speed = 1.0;
    // rust: let mobs = [horse];
        // Walking on its own: its own position (1 - 0.5 * 0.5).
    // rust: assert_eq!(worn_head_animation(&wearer, None, &mobs, 0.5), 0.75);
        // A mount that is no mob (boat, minecart) or unknown: still its own.
    // rust: assert_eq!(worn_head_animation(&wearer, Some(99), &mobs, 0.5), 0.75);
        // Riding the horse (a passenger's own position is 0): the horse's.
    // rust: wearer.extra.passenger = true;
    // rust: assert_eq!(worn_head_animation(&wearer, None, &mobs, 0.5), 0.0);
    // rust: assert_eq!(worn_head_animation(&wearer, Some(2), &mobs, 0.5), 3.5);
        // Dead wearer, living vehicle: the vehicle's.
    // rust: wearer.health = 0.0;
    // rust: assert_eq!(worn_head_animation(&wearer, Some(2), &mobs, 0.5), 3.5);
}

carried_block_vertices_match_vanilla_block_coordinates :: proc() {
}
        // Captured from 26.3 CarriedBlockLayer.submit with an identity PoseStack:
        // origin, three unit axes, opposite corner, and the block's center.
    // rust: let samples = [
    // rust: (Vec3::ZERO, Vec3::new(0.3535534, 0.8636924, -0.68587124)),
    // rust: (Vec3::X, Vec3::new(0.0, 0.9846148, -1.0181028)),
    // rust: (Vec3::Y, Vec3::new(0.3535534, 0.3938461, -0.8568813)),
    // rust: (Vec3::Z, Vec3::new(0.0, 0.74277, -0.35363975)),
    // rust: (Vec3::ONE, Vec3::new(-0.3535534, 0.3938461, -0.85688126)),
    // rust: (Vec3::splat(0.5), Vec3::new(0.0, 0.6287693, -0.77137625)),
    // rust: ];
    // rust: let bases = [
    // rust: Mat4::IDENTITY,
    // rust: Mat4::from_translation(Vec3::new(3.0, 2.0, -7.0))
    // rust: * Mat4::from_rotation_y(1.2)
    // rust: * Mat4::from_scale(Vec3::new(-1.0, -1.0, 1.0)),
    // rust: ];
    // rust: for base in bases {
    // rust: let block = carried_block_matrix(base);
    // rust: for (point, expected) in samples {
    // rust: let actual = block.transform_point3(point);
    // rust: let expected = base.transform_point3(expected);
    // rust: assert!(
    // rust: actual.abs_diff_eq(expected, 1e-6),
    // rust: "{actual:?} != {expected:?}"
    // rust: );
}
}
        // `antenna_block_matrix` with an identity head, from the 26.3 expressions:
        // `UNIT_CUBE_BOTTOM_CENTER_TO_ANTENNA_CENTER` (`translate(-0.5, 0, -0.5)`
        // then `rotateAround(Z 180, 0.5, 0.5, 0.5)`) sends (x, y, z) to
        // (0.5 - x, 1 - y, z - 0.5), the antenna drops it 1.75, and
        // `createFlowerBedModel`'s quarter block lands on (-0.25, 0, 0.25) because
        // the Z-180 turn flips it.
    // rust: let antenna = [
    // rust: (Vec3::ZERO, Vec3::new(0.5, -0.75, -0.5)),
    // rust: (Vec3::X, Vec3::new(-0.5, -0.75, -0.5)),
    // rust: (Vec3::Y, Vec3::new(0.5, -1.75, -0.5)),
    // rust: (Vec3::Z, Vec3::new(0.5, -0.75, 0.5)),
    // rust: (Vec3::ONE, Vec3::new(-0.5, -1.75, 0.5)),
    // rust: (Vec3::splat(0.5), Vec3::new(0.0, -1.25, 0.0)),
    // rust: ];
    // rust: for (shifted, shift) in [(false, Vec3::ZERO), (true, Vec3::new(-0.25, 0.0, 0.25))] {
    // rust: for base in bases {
    // rust: let m = antenna_block_matrix(base, shifted);
    // rust: for (point, expected) in antenna {
    // rust: let actual = m.transform_point3(point);
    // rust: let expected = base.transform_point3(expected + shift);
    // rust: assert!(
    // rust: actual.abs_diff_eq(expected, 1e-6),
    // rust: "{actual:?} != {expected:?}"
    // rust: );
}
}
}
}
}
