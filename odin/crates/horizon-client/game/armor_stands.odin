//! Transpiled from Horizon Rust crate
package horizon_client_armor_stands

import "core:fmt"
import "core:mem"
import "core:math"

// Armor stands: `ArmorStandItem.useOn` placement (snapped to 45 degrees),
// falling, `interactAt` equipment swaps by clicked height, the two-hit break
// of `hurtServer` (creative breaks at once), and `ArmorStandRenderer` with
// the default pose, the hit wobble and humanoid armor layers.
// use super::entity::Entity;
// use super::{Game, InteractTarget};
// use horizon_client::{
    // rust: Result,
    // rust: cit::{Hand, Kind, Rule},
    // rust: cit_armor,
    // rust: entities::ArmorStand,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{Mob, Part, anim::Poses},
    // rust: trims::{TrimOverride, TrimRegistry, TrimTexture},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use std::{collections::HashMap, path::PathBuf, sync::Arc};

// Velocity `AbstractMinecart.push` adds: the cart, and a quarter on the stand.
CartShove :: struct {
    cart_x: f64,
    cart_z: f64,
    stand_x: f64,
    stand_z: f64,
}
// `ArmorStand.pushEntities` for one cart. `None` when the cart is not the
// plain rideable kind, the boxes miss, `distanceToSqr` is past 0.2, the
// stand is a passenger of the cart, or the horizontal gap is under
// `1.0E-4F` (where `AbstractMinecart.push` does nothing).
    // rust: fn armor_stand_cart_shove(
    // rust: stand_pos: Vec3,
    // rust: stand_box: Aabb,
    // rust: cart_pos: Vec3,
    // rust: cart_box: Aabb,
    // rust: kind: super::minecarts::CartKind,
    // rust: cart_carries_stand: bool,
    // rust: ) -> Option<CartShove> {
    // rust: if kind != super::minecarts::CartKind::Rideable
    // rust: || cart_carries_stand
    // rust: || !stand_box.intersects(cart_box)
    // rust: {
    // rust: return None;
}
    // rust: let (dx, dy, dz) = (
    // rust: stand_pos.x - cart_pos.x,
    // rust: stand_pos.y - cart_pos.y,
    // rust: stand_pos.z - cart_pos.z,
    // rust: );
    // rust: if dx * dx + dy * dy + dz * dz > 0.2 {
    // rust: return None;
}
    // rust: let (xa, za) = super::minecarts::cart_push_from(stand_pos, cart_pos)?;
    // rust: Some(CartShove {
    // rust: cart_x: -xa,
    // rust: cart_z: -za,
    // rust: stand_x: xa / 4.0,
    // rust: stand_z: za / 4.0,
    // rust: })
}
// `EquipmentLayerRenderer.getColorForLayer`: a dyeable layer (one with a
// colour when undyed) takes the stack's `minecraft:dyed_color`, else that
// colour; any other layer stays white, dyed or not. The result is in the
// renderer's byte order (R and B swapped).
layer_color :: proc(undyed: Maybe(u32), stack: Maybe(^ItemStack)) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let dyed = stack
    // rust: .and_then(|s| s.data())
    // rust: .and_then(|d| d.dyed_color)
    // rust: .map(|c| c as u32 & 0xFF_FFFF);
    // rust: undyed.map_or(0xFFFF_FFFF, |undyed| {
    // rust: let c = dyed.unwrap_or(undyed);
    // rust: 0xFF00_0000 | (c & 0xFF) << 16 | (c & 0xFF00) | (c >> 16) & 0xFF
    // rust: })
}

// Armor stand models and the humanoid layers of every equipment asset.
    // rust: pub(super) struct ArmorStandAssets {
    // Shared (`Arc`) so the GPU path (`mobs::skin`) keeps one stored copy of each.
    // rust: pub main: Option<Arc<Part>>,
    // rust: pub small: Option<Arc<Part>>,
    // (slot model suffix, small) -> model.
    // rust: pub layers: HashMap<(&'static str, bool), Arc<Part>>,
    // The player's armour models by slot (helmet, chestplate, leggings, boots).
    // rust: pub player: HashMap<&'static str, Part>,
    // asset id -> layer kind (humanoid / humanoid_leggings) -> each layer's (texture, undyed colour), in order.
    // rust: pub equipment: HashMap<String, HashMap<String, Vec<(String, Option<u32>)>>>,
    // asset id -> `trim_overrides`.
    // rust: pub trim_overrides: HashMap<String, Vec<TrimOverride>>,
    // rust: pub trims: TrimRegistry,
    // The resources the trim textures are made from.
    // rust: pub root: PathBuf,
}
    // rust: impl ArmorStandAssets {
    // rust: pub fn load(
    // rust: root: &std::path::Path,
    // rust: document: Option<&horizon_client::mobs::EntityModelDocument>,
    // rust: ) -> Self {
    // rust: let load = |key: &str| document.and_then(|document| document.model(key));
    // rust: let mut layers = HashMap::new();
    // rust: let mut player = HashMap::new();
    // rust: for slot in ["helmet", "chestplate", "leggings", "boots"] {
    // rust: if let Some(part) = load(&format!("minecraft:player#{slot}")) {
    // rust: player.insert(slot, part);
}
    // rust: for (small, model) in [(false, "armor_stand"), (true, "armor_stand_small")] {
    // rust: if let Some(part) = load(&format!("minecraft:{model}#{slot}")) {
    // rust: layers.insert((slot, small), Arc::new(part));
}
}
}
    // rust: for (key, name) in [
    // rust: ("minecraft:elytra#main", "elytra"),
    // rust: ("minecraft:elytra_baby#main", "elytra_baby"),
    // rust: ] {
    // rust: if let Some(part) = load(key) {
    // rust: player.insert(name, part);
}
}
    // rust: let mut equipment = HashMap::new();
    // rust: let mut trim_overrides = HashMap::new();
        // EquipmentAssetManager reads every namespace: vanilla's and the content mods'.
    // rust: let namespaces = std::iter::once("minecraft".to_owned())
    // rust: .chain(horizon_client::mod_content::namespaces(root));
    // rust: for namespace in namespaces {
    // rust: let Ok(entries) = std::fs::read_dir(root.join(format!("assets/{namespace}/equipment")))
    // rust: else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
    // rust: let Some(name) = path.file_stem().and_then(|s| s.to_str()) else {
    // rust: continue;
}
    // rust: let Ok(v) =
    // rust: std::fs::read(&path).map(|b| serde_json::from_slice::<serde_json::Value>(&b))
    // rust: else {
    // rust: continue;
}
    // rust: let Ok(v) = v else { continue };
    // rust: let id = format!("{namespace}:{name}");
    // rust: let mut kinds = HashMap::new();
    // rust: for kind in ["humanoid", "humanoid_leggings", "wings"] {
                    // Every layer of the kind: leather's overlay is layer 1.
    // rust: let layers: Vec<(String, Option<u32>)> = v["layers"][kind]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|layer| {
    // rust: let tex = layer["texture"].as_str().unwrap_or(&id);
    // rust: let (tex_namespace, tex) =
    // rust: tex.split_once(':').unwrap_or(("minecraft", tex));
    // rust: let sprite = match tex_namespace {
    // rust: "minecraft" => format!("entity/equipment/{kind}/{tex}"),
    // rust: other => format!("{other}:entity/equipment/{kind}/{tex}"),
}
    // rust: let undyed = layer["dyeable"]["color_when_undyed"]
    // rust: .as_i64()
    // rust: .map(|c| c as u32 & 0xFF_FFFF);
    // rust: (sprite, undyed)
    // rust: })
    // rust: .collect();
    // rust: if !layers.is_empty() {
    // rust: kinds.insert(kind.to_owned(), layers);
}
}
    // rust: trim_overrides.insert(id.clone(), TrimOverride::list(&v));
    // rust: equipment.insert(id, kinds);
}
}
    // rust: Self {
    // rust: main: load("minecraft:armor_stand#main").map(Arc::new),
    // rust: small: load("minecraft:armor_stand_small#main").map(Arc::new),
    // rust: layers,
    // rust: player,
    // rust: equipment,
    // rust: trim_overrides,
    // rust: trims: TrimRegistry::load(root),
    // rust: root: root.to_owned(),
}
}
    // Trim data of reloaded resources (the models stay).
reload_trims :: proc(self: ^Self, root: ^std::path::Path) {
}
    // rust: let fresh = Self::load(root, None);
    // rust: self.trim_overrides = fresh.trim_overrides;
    // rust: self.trims = fresh.trims;
    // rust: self.root = fresh.root;
}
    // `TrimTextureKey`: the trim texture of `stack` on its humanoid
    // layer (`humanoid` or `humanoid_leggings`), if it has a trim.
trim_texture :: proc(self: ^Self, asset: string, kind: string, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (material, pattern) = stack.extra.as_ref()?.trim.as_ref()?;
    // rust: let overrides = self
    // rust: .trim_overrides
    // rust: .get(asset)
    // rust: .map_or(&[][..], Vec::as_slice);
    // rust: TrimTexture::resolve(&self.trims, overrides, material, pattern, kind)
}
}
    // rust: impl Game<'_> {
    // OptiFine CIT: the winning armour or elytra rule (`kind`) of the worn `stack`. No lookup
    // without CIT rules.
    // rust: pub(super) fn cit_worn_rule(&self, kind: Kind, stack: &ItemStack) -> Option<&Rule> {
    // rust: let rules = &self.pack.item_renderer.cit.as_ref()?.rules;
    // rust: let item_max = self.items().get(&stack.item).map_or(0, |i| i.max_damage);
    // rust: horizon_client::item_render::cit::worn_rule(rules, kind, stack, item_max)
    // rust: .and_then(|i| rules.rules.get(i))
}
    // The atlas rect of an armour layer `texture` of equipment asset `asset`, or of the one CIT
    // armour rule `cit` puts there when the atlas has it.
    // rust: fn armor_layer_rect(
    // rust: &self,
    // rust: cit: Option<&Rule>,
    // rust: asset: &str,
    // rust: kind: &str,
    // rust: texture: &str,
    // rust: ) -> Option<[f32; 4]> {
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: let r = cit_armor::worn_layer(cit, asset, kind, texture, |s| sprites.get(s))?;
    // rust: Some([r.u0, r.v0, r.u1, r.v1])
}
    // `HumanoidArmorLayer` for the player: (model, texture rect, colour,
    // overlay) of each worn piece, head to feet.
    // rust: pub(super) fn player_armor_layers(&self) -> Vec<(&Part, [f32; 4], u32, u32, bool)> {
    // rust: self.stack_armor_layers(&self.armor)
}
    // `HumanoidArmorLayer` for worn stacks (head to feet), trims included.
    // rust: pub(super) fn stack_armor_layers(
    // rust: &self,
    // rust: armor: &[Option<ItemStack>; 4],
    // rust: ) -> Vec<(&Part, [f32; 4], u32, u32, bool)> {
    // rust: self.armor_layers(
    // rust: armor
    // rust: .each_ref()
    // rust: .map(|s| s.as_ref().map(|s| (&*s.item, Some(s)))),
    // rust: )
}
    // `HumanoidArmorLayer` for another player's model: the armour it wears
    // (`extra.head` .. `extra.feet`).
    // rust: pub(super) fn worn_armor_layers(&self, m: &Mob) -> Vec<(&Part, [f32; 4], u32, u32, bool)> {
    // rust: let e = &m.extra;
    // rust: self.armor_layers(
    // rust: [
    // rust: (e.head.as_deref(), e.armor[0].as_ref()),
    // rust: (e.chest.as_deref(), e.armor[1].as_ref()),
    // rust: (e.legs.as_deref(), e.armor[2].as_ref()),
    // rust: (e.feet.as_deref(), e.armor[3].as_ref()),
    // rust: ]
    // rust: .map(|(item, stack)| item.map(|i| (i, stack))),
    // rust: )
}
    // The layers of the armour items `worn` (with their stacks when known,
    // for trims and CIT armour rules), head to feet.
    // rust: fn armor_layers(
    // rust: &self,
    // rust: worn: [Option<(&str, Option<&ItemStack>)>; 4],
    // rust: ) -> Vec<(&Part, [f32; 4], u32, u32, bool)> {
    // rust: let assets = &self.armor_stand_assets;
    // rust: let emissive = self
    // rust: .res
    // rust: .mob_data()
    // rust: .emissive
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let mut out = Vec::new();
    // rust: for (item, layer) in worn
    // rust: .into_iter()
    // rust: .zip(["helmet", "chestplate", "leggings", "boots"])
    // rust: {
    // rust: let Some((item, stack)) = item else {
    // rust: continue;
}
    // rust: let Some(asset) = self
    // rust: .res
    // rust: .items()
    // rust: .get(item)
    // rust: .and_then(|i| i.equip_asset.clone())
    // rust: else {
    // rust: continue;
}
    // rust: let kind = if layer == "leggings" {
    // rust: "humanoid_leggings"
    // rust: } else {
    // rust: "humanoid"
}
    // rust: let Some(layers) = assets.equipment.get(&asset).and_then(|k| k.get(kind)) else {
    // rust: continue;
}
    // rust: let Some(part) = assets.player.get(layer) else {
    // rust: continue;
}
            // EquipmentLayerRenderer.renderLayers: NO_OVERLAY, the armour
            // glint on the first layer and on the trim when `stack.hasFoil()`.
    // rust: let item_glint = self
    // rust: .res
    // rust: .items()
    // rust: .enchantments
    // rust: .props
    // rust: .get(item)
    // rust: .is_some_and(|p| p.glint);
    // rust: let overlay = if stack.is_some_and(|s| s.has_foil(item_glint)) {
    // rust: horizon_client::mobs::render::ARMOR_GLINT
    // rust: } else {
    // rust: 0
}
            // Every layer of the asset, the leather overlay too, then the
            // trim layer over the armour.
    // rust: let cit = stack.and_then(|s| self.cit_worn_rule(Kind::Armor, s));
    // rust: for (i, (texture, undyed)) in layers.iter().enumerate() {
    // rust: let Some(uv) = self.armor_layer_rect(cit, &asset, kind, texture) else {
    // rust: continue;
}
    // rust: let color = layer_color(*undyed, stack);
    // rust: out.push((part, uv, color, if i == 0 { overlay } else { 0 }, false));
                // The layer's OptiFine emissive overlay, full bright without the glint.
    // rust: if let Some(g) = emissive
    // rust: .overlay(texture)
    // rust: .and_then(|e| self.gui.atlas.sprites.get(e))
    // rust: {
    // rust: out.push((part, [g.u0, g.v0, g.u1, g.v1], color, 0, true));
}
}
    // rust: if let Some(r) = stack
    // rust: .and_then(|s| assets.trim_texture(&asset, kind, s))
    // rust: .and_then(|t| self.gui.atlas.sprites.get(&t.sprite()))
    // rust: {
    // rust: out.push((part, [r.u0, r.v0, r.u1, r.v1], 0xFFFF_FFFF, overlay, false));
}
}
    // rust: out
}
    // `PalettedTextureManager.getOrPrepare` for the trims drawn this frame
    // (the player's armour and the armour stands'): each generated texture
    // goes into an atlas trim slot, a free one, else the least recently
    // drawn.
    // rust: pub(super) fn prepare_trims(&mut self) {
//         use horizon_client::hud::TRIM_SLOTS;
    // rust: let assets = &self.armor_stand_assets;
    // rust: let items = self.items();
    // rust: let mut wanted: Vec<TrimTexture> = Vec::new();
    // rust: let guests = self.lan.iter().flat_map(|host| host.hub.guests.iter());
    // rust: let stacks = self
    // rust: .armor
    // rust: .iter()
    // rust: .chain(guests.flat_map(|g| g.armor.iter()))
    // rust: .chain(self.mobs.iter().flat_map(|m| m.extra.armor.iter()))
    // rust: .zip(
    // rust: ["helmet", "chestplate", "leggings", "boots"]
    // rust: .into_iter()
    // rust: .cycle(),
    // rust: )
    // rust: .chain(self.armor_stands.iter().flat_map(|a| {
    // rust: [5usize, 4, 3, 2]
    // rust: .map(|slot| &a.equipment[slot])
    // rust: .into_iter()
    // rust: .zip(["helmet", "chestplate", "leggings", "boots"])
    // rust: }));
    // rust: for (stack, layer) in stacks {
    // rust: let Some(stack) = stack.as_ref().filter(|s| s.extra.is_some()) else {
    // rust: continue;
}
    // rust: let Some(asset) = items
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_asset.as_deref())
    // rust: else {
    // rust: continue;
}
    // rust: let kind = if layer == "leggings" {
    // rust: "humanoid_leggings"
    // rust: } else {
    // rust: "humanoid"
}
    // rust: if let Some(t) = assets.trim_texture(asset, kind, stack)
    // rust: && !wanted.contains(&t)
    // rust: {
    // rust: wanted.push(t);
}
}
    // rust: for t in wanted {
    // rust: let name = t.sprite();
            // Entries the atlas no longer has (rebuilt by a resource reload) are free.
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: self.trim_slots.retain(|(n, _)| sprites.contains_key(n));
    // rust: if let Some(i) = self.trim_slots.iter().position(|e| e.0 == name) {
    // rust: let e = self.trim_slots.remove(i);
    // rust: self.trim_slots.push(e);
    // rust: continue;
}
    // rust: let Some((w, h, rgba)) = t.generate(&self.armor_stand_assets.root) else {
    // rust: continue;
}
    // rust: let used: Vec<usize> = self.trim_slots.iter().map(|e| e.1).collect();
    // rust: let slot = match (0..TRIM_SLOTS).find(|i| !used.contains(i)) {
    // rust: Some(free) => free,
    // rust: None => {
    // rust: let (old, slot) = self.trim_slots.remove(0);
    // rust: self.gui.atlas.sprites.remove(&old);
    // rust: slot
}
}
    // rust: let Some(area) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(&format!("horizon/trim{slot}"))
    // rust: .copied()
    // rust: else {
    // rust: continue;
}
    // rust: if w > area.w || h > area.h {
    // rust: continue;
}
    // rust: let (aw, ah) = (self.gui.atlas.width as f32, self.gui.atlas.height as f32);
    // rust: let (x, y) = ((area.u0 * aw).round(), (area.v0 * ah).round());
    // rust: self.map_patches.push(horizon_client::font::Patch {
    // rust: x: x as u32,
    // rust: y: y as u32,
    // rust: width: w,
    // rust: height: h,
    // rust: rgba,
    // rust: });
    // rust: let rect = horizon_client::hud::Rect {
    // rust: u0: area.u0,
    // rust: v0: area.v0,
    // rust: u1: (x + w as f32) / aw,
    // rust: v1: (y + h as f32) / ah,
    // rust: w,
    // rust: h,
}
    // rust: self.gui.atlas.sprites.insert(name.clone(), rect);
    // rust: self.trim_slots.push((name, slot));
}
}
    // `ArmorStandItem.useOn`.
    // `ArmorStandItem.useOn` up to its `FAIL`s, which a client checks too:
    // not on a bottom face, and nothing in the new stand's box. The block it
    // stands in and the stand.
    // rust: pub(super) fn armor_stand_spawn(
    // rust: &self,
    // rust: hit: &super::Hit,
    // rust: stack: &ItemStack,
    // rust: ) -> Option<([i32; 3], ArmorStand)> {
    // rust: if hit.face == [0, -1, 0] {
    // rust: return None;
}
        // BlockPlaceContext: a replaceable clicked block is replaced.
    // rust: let clicked = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]));
    // rust: let pos = if clicked.replaceable {
    // rust: hit.pos
    // rust: } else {
    // rust: std::array::from_fn(|i| hit.pos[i] + hit.face[i])
}
    // rust: let foot = Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
    // rust: let yaw =
    // rust: (((self.yaw - 180.0 + 180.0).rem_euclid(360.0) - 180.0 + 22.5) / 45.0).floor() * 45.0;
    // rust: let mut stand = ArmorStand::new(self.next_entity + 1, foot, yaw);
        // Entity.applyImplicitComponents: a name from an anvil names the stand.
    // rust: if let Some(name) = stack.custom_name() {
    // rust: stand.custom_name = Some(horizon_client::text::Text::literal(name));
}
    // rust: let b = stand.bounds();
        // Touching the floor is not a collision.
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let e = 1.0e-7;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(lo.x + e, lo.y + e, lo.z + e),
    // rust: Vec3::new(hi.x - e, hi.y - e, hi.z - e),
    // rust: );
    // rust: let mut scene = horizon_client::collisions::SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if !scene.unobstructed(bounds).unwrap_or(false)
    // rust: || self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .any(|o| overlaps(o.bounds(), bounds))
    // rust: {
    // rust: return None;
}
    // rust: Some((pos, stand))
}
    // rust: pub(super) fn place_armor_stand(&mut self, hit: &super::Hit, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:armor_stand" {
    // rust: return false;
}
    // rust: let Some((pos, mut stand)) = self.armor_stand_spawn(hit, stack) else {
    // rust: return false;
}
        // EntityType.create(.., tryMoveDown, movedUp): the new stand falls onto what is under it,
        // up to two blocks (a bottom slab, the block under replaced grass).
    // rust: let drop = self.drop_offset_from(0.5, 1.975, (pos[0], pos[1], pos[2]), true);
    // rust: stand.position.y = f64::from(pos[1]) + drop;
    // rust: stand.previous = stand.position;
    // rust: let foot = stand.position;
        // EntityType.create's spawn yaw, `level.getRandom().nextFloat() * 360`, before
        // ArmorStandItem.useOn turns the stand to face the player.
    // rust: self.world.random.next_float();
    // rust: self.next_entity += 1;
    // rust: self.audio.play(
    // rust: "minecraft:entity.armor_stand.place",
    // rust: Some([foot.x, foot.y, foot.z]),
    // rust: 0.75,
    // rust: 0.8,
    // rust: );
        // ArmorStandItem.useOn: the stand's ENTITY_PLACE, by the player.
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:entity_place", [foot.x, foot.y, foot.z], ctx);
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: self.armor_stands.push(stand);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
        // ItemStack.useOn counts the use.
    // rust: self.award_stat("used", &stack.item, 1);
        // ArmorStandItem.useOn returns SUCCESS: the hand swings.
    // rust: self.swing_arm();
    // rust: true
}
    // The armor stand under the crosshair, its distance and the hit point.
    // rust: pub(super) fn armor_stand_hit(&self) -> Option<(usize, f64, [f64; 3])> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(usize, f64, [f64; 3])> = None;
    // rust: for (i, a) in self.armor_stands.iter().enumerate() {
    // rust: if a.marker {
    // rust: continue;
}
    // rust: let b = a.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let (lo, hi) = ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: let (mut t0, mut t1) = (0.0f64, reach);
    // rust: let mut hit = true;
    // rust: for k in 0..3 {
    // rust: if dir[k].abs() < 1e-9 {
    // rust: hit &= eye[k] >= lo[k] && eye[k] <= hi[k];
    // rust: continue;
}
    // rust: let (mut ta, mut tb) = ((lo[k] - eye[k]) / dir[k], (hi[k] - eye[k]) / dir[k]);
    // rust: if ta > tb {
    // rust: std::mem::swap(&mut ta, &mut tb);
}
    // rust: t0 = t0.max(ta);
    // rust: t1 = t1.min(tb);
}
    // rust: if hit && t0 <= t1 && best.is_none_or(|b| t0 < b.1) {
    // rust: best = Some((i, t0, std::array::from_fn(|k| eye[k] + dir[k] * t0)));
}
}
    // rust: best
}
equipment_slot :: proc(self: ^Self, stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_slot.as_deref())
    // rust: {
    // rust: Some("feet") => 2,
    // rust: Some("legs") => 3,
    // rust: Some("chest") => 4,
    // rust: Some("head") => 5,
    // rust: Some("offhand") => 1,
    // rust: _ => 0,
}
}
    // `ArmorStand.interactAt` for the stand under the crosshair, or for the
    // stand a guest's interact packet named (its client's click point).
    // rust: pub(super) fn interact_armor_stand(&mut self, target: Option<InteractTarget>) -> bool {
    // rust: let Some((i, d, point)) = (match target {
            // interactAt gets the packet's location, measured from the stand's
            // position, so getClickedSlot reads the height the client clicked.
    // rust: Some(t) => Self::named_entity(&self.armor_stands, t.id, |a| a.id).map(|i| {
    // rust: let p = self.armor_stands[i].position;
    // rust: (
    // rust: i,
    // rust: 0.0,
    // rust: [
    // rust: p.x + t.location[0],
    // rust: p.y + t.location[1],
    // rust: p.z + t.location[2],
    // rust: ],
    // rust: )
    // rust: }),
    // rust: None => self.armor_stand_hit(),
    // rust: }) else {
    // rust: return false;
}
        // Only a client's own pick is stopped by a block: the range check passed.
    // rust: if target.is_none() && !self.before_block(d) {
    // rust: return false;
}
    // rust: let held = self.held().cloned();
    // rust: if let Some(stack) = held.as_ref().filter(|h| &*h.item == "minecraft:name_tag") {
    // rust: let stand = &mut self.armor_stands[i];
    // rust: let alive = stand.health > 0.0;
    // rust: if !stand.name_with_tag(stack) {
    // rust: return false;
}
    // rust: let id = stand.id;
    // rust: let name = stand.custom_name.as_ref().map(|name| name.plain());
    // rust: if alive {
                // NameTagItem shrinks the stack even with infinite materials.
    // rust: let mut rest = stack.clone();
    // rust: rest.count -= 1;
    // rust: *self.held_mut() = (rest.count > 0).then_some(rest);
    // rust: if let (Some(player), Some(player_name), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone(), name)
    // rust: {
    // rust: self.native_player_name_entity(player, &player_name, id, &name);
}
}
    // rust: self.swing_arm();
    // rust: return true;
}
    // rust: let a = &self.armor_stands[i];
    // rust: let slot = match &held {
    // rust: Some(h) => {
    // rust: let slot = self.equipment_slot(h);
                // ArmorStand.interactAt: a disabled slot, or a hand without
                // arms, is FAIL.
    // rust: if a.is_disabled(slot) {
    // rust: return true;
}
    // rust: slot
}
    // rust: None => {
                // getClickedSlot by the height of the click.
    // rust: let y = (point[1] - a.position.y) / if a.small { 0.5 } else { 1.0 };
    // rust: let has = |s: usize| a.equipment[s].is_some();
    // rust: let small = a.small;
    // rust: if y >= 0.1 && y < 0.1 + if small { 0.8 } else { 0.45 } && has(2) {
    // rust: 2
    // rust: } else if y >= 0.9 + if small { 0.3 } else { 0.0 }
    // rust: && y < 0.9 + if small { 1.0 } else { 0.7 }
    // rust: && has(4)
    // rust: {
    // rust: 4
    // rust: } else if y >= 0.4 && y < 0.4 + if small { 1.0 } else { 0.8 } && has(3) {
    // rust: 3
    // rust: } else if y >= 1.6 && has(5) {
    // rust: 5
    // rust: } else if !has(0) && has(1) {
    // rust: 1
    // rust: } else {
    // rust: 0
}
}
}
        // An empty hand takes from the main hand when the clicked slot is
        // disabled (`isDisabled(clickedSlot) ? slot : clickedSlot`).
    // rust: let slot = if held.is_none() && a.is_disabled(slot) {
    // rust: 0
    // rust: } else {
    // rust: slot
}
        // ArmorStand.swapItem: taking from a filled slot or putting into an
        // empty one can be disabled; the click then passes.
    // rust: if a.swap_locked(slot) {
    // rust: return false;
}
    // rust: let current = self.armor_stands[i].equipment[slot].clone();
    // rust: if held.is_none() && current.is_none() {
    // rust: return false;
}
        // A server's mods hear the swap before it happens, and may stop it.
        // A stack of several on an occupied slot goes nowhere (below).
    // rust: let moves = held
    // rust: .as_ref()
    // rust: .is_none_or(|h| h.count <= 1 || current.is_none());
    // rust: if moves
    // rust: && target.is_some()
    // rust: && let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: let stand = self.armor_stands[i].id as i32;
    // rust: let slot_name = ["mainhand", "offhand", "feet", "legs", "chest", "head"][slot];
    // rust: let mut cancel = false;
    // rust: self.native_armor_stand_manipulate(player, &name, stand, slot_name, &mut cancel);
    // rust: if cancel {
    // rust: return true;
}
}
        // ArmorStand.swapItem.
    // rust: match held {
            // A player with infinite materials puts a copy of one on an empty
            // slot and keeps the stack.
    // rust: Some(h) if self.creative && current.is_none() => {
    // rust: self.armor_stands[i].equipment[slot] = Some(ItemStack { count: 1, ..h });
}
    // rust: Some(h) if h.count > 1 => {
    // rust: if current.is_some() {
    // rust: return true;
}
    // rust: self.armor_stands[i].equipment[slot] = Some(ItemStack {
    // rust: count: 1,
    // rust: ..h.clone()
    // rust: });
    // rust: *self.held_mut() = Some(ItemStack {
    // rust: count: h.count - 1,
    // rust: ..h
    // rust: });
}
    // rust: h => {
    // rust: self.armor_stands[i].equipment[slot] = h;
    // rust: *self.held_mut() = current;
}
}
    // rust: let p = self.armor_stands[i].position;
    // rust: self.world
    // rust: .modified
    // rust: .insert(((p.x.floor() as i32) >> 4, (p.z.floor() as i32) >> 4));
    // rust: self.swing_arm();
    // rust: true
}
    // `ArmorStand.hurtServer` from a player attack.
    // rust: pub(super) fn attack_armor_stand(&mut self) -> bool {
    // rust: let Some((i, d, _)) = self.armor_stand_hit() else {
    // rust: return false;
}
    // rust: if !self.before_block(d) || self.mob_hit().is_some_and(|m| m.1 < d) {
    // rust: return false;
}
    // rust: let (_, _, crit, magic) = self.melee_damage("minecraft:armor_stand", true);
    // rust: let hurt = self.hit_armor_stand(i, |g, area, id| {
    // rust: g.attack_effects(
    // rust: area,
    // rust: Some(id as i32),
    // rust: crit,
    // rust: super::mace::Spared::Stand(id),
    // rust: magic.then_some(id as i32),
    // rust: );
    // rust: });
        // Player.onAttack: the hit starts the attack strength again, hurt or
        // not (skipAttackInteraction only asks mayInteract).
    // rust: self.attack_ticks = 0;
    // rust: if hurt {
    // rust: self.swing_arm();
}
    // rust: hurt
}
    // A player's attack on the stand `i` once it is picked: the stand's own
    // hurt, `before_weapon` (the attack's sounds and particles, given the
    // stand's box and id) and `Player.itemAttackInteraction`, which treats
    // the stand as a living target: the held weapon's hit and post-attack
    // effects.
    // rust: pub(super) fn hit_armor_stand(
    // rust: &mut self,
    // rust: i: usize,
    // rust: before_weapon: impl FnOnce(&mut Self, Aabb, u32),
    // rust: ) -> bool {
        // The stand's box, id and place, before the hit may remove it.
    // rust: let (area, id) = (self.armor_stands[i].bounds(), self.armor_stands[i].id);
    // rust: let (center, on_ground) = (
    // rust: self.armor_stands[i].position,
    // rust: self.armor_stands[i].on_ground,
    // rust: );
    // rust: let hurt = self.punch_armor_stand(i);
    // rust: if hurt {
    // rust: before_weapon(self, area, id);
    // rust: self.weapon_hit_stand(id, center, on_ground);
}
    // rust: hurt
}
    // `ArmorStand.showBreakingParticles`: ten oak plank crumbs from the box,
    // spread by a quarter of its width and height, sent like `sendParticles`.
show_breaking_particles :: proc(self: ^Self, at: [f64; 3], width: f64, height: f64) {
}
    // rust: let Some(state) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:oak_planks")
    // rust: else {
    // rust: return;
}
    // rust: let block = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, block) else {
    // rust: return;
}
    // rust: let options = horizon_client::particles::ParticleOptions::block(
    // rust: horizon_client::particles::ParticleType::Block,
    // rust: sprite,
    // rust: tint,
    // rust: );
        // Entity.getY(2/3): the box's height is scaled by 2/3 from the feet.
    // rust: let centre = [at[0], at[1] + height * (2.0 / 3.0), at[2]];
    // rust: let spread = [width / 4.0, height / 4.0, width / 4.0];
    // rust: self.particles
    // rust: .send_particles(&options, centre, spread, 0.05, 10);
    // rust: self.lan_level_particles(None, &options, centre, spread, 0.05, 10, Some(state));
}
    // `ArmorStand.hurtServer` for a player's attack (also a sweep's): a
    // creative player breaks it, otherwise the first hit wobbles it and a
    // second within five ticks breaks it.
    // rust: pub(super) fn punch_armor_stand(&mut self, i: usize) -> bool {
    // rust: let time = self.world.game_time;
    // rust: let at = self.armor_stands[i].position;
    // rust: let at = [at.x, at.y, at.z];
    // rust: if self.creative {
    // rust: let (width, height) = stand_box(&self.armor_stands[i]);
    // rust: self.armor_stands.remove(i);
    // rust: self.audio
    // rust: .play("minecraft:entity.armor_stand.break", Some(at), 1.0, 1.0);
    // rust: self.show_breaking_particles(at, f64::from(width), f64::from(height));
    // rust: return true;
}
    // rust: if time - self.armor_stands[i].last_hit > 5 {
            // First hit: entity event 32, the wobble and the hit sound.
    // rust: self.armor_stands[i].last_hit = time;
    // rust: self.audio
    // rust: .play("minecraft:entity.armor_stand.hit", Some(at), 0.3, 1.0);
    // rust: return true;
}
        // brokenByPlayer: the stand item, then brokenByAnything: the equipment.
    // rust: let a = self.armor_stands.remove(i);
    // rust: let (width, height) = stand_box(&a);
    // rust: self.audio
    // rust: .play("minecraft:entity.armor_stand.break", Some(at), 1.0, 1.0);
    // rust: self.show_breaking_particles(at, f64::from(width), f64::from(height));
    // rust: let center = [at[0], at[1] + if a.small { 0.4875 } else { 0.9875 }, at[2]];
    // rust: let stand = ItemStack {
    // rust: item: Arc::from("minecraft:armor_stand"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: self.spawn_item(stand, center, [0.0; 3], 10);
    // rust: for stack in a.equipment.into_iter().flatten() {
    // rust: let r = &mut self.world.random;
    // rust: let v = [
    // rust: f64::from(r.next_float()) * 0.2 - 0.1,
    // rust: 0.2,
    // rust: f64::from(r.next_float()) * 0.2 - 0.1,
    // rust: ];
    // rust: self.spawn_item(stack, center, v, 10);
}
    // rust: self.world
    // rust: .modified
    // rust: .insert(((at[0].floor() as i32) >> 4, (at[2].floor() as i32) >> 4));
    // rust: true
}
    // rust: pub(super) fn tick_armor_stands(&mut self) -> Result<()> {
    // rust: let mut dead = Vec::new();
        // ServerLevel.tick: only entities in entity-ticking chunks tick.
    // rust: let ticking = self.entity_ticking_area();
    // rust: for i in 0..self.armor_stands.len() {
    // rust: let at = self.armor_stands[i].position;
    // rust: if !ticking(at.x.floor() as i32, at.z.floor() as i32) {
    // rust: self.armor_stands[i].previous = at;
    // rust: self.armor_stands[i].previous_yaw = self.armor_stands[i].yaw;
    // rust: continue;
}
    // rust: self.armor_stand_location_effects(i, false);
    // rust: let a = &mut self.armor_stands[i];
    // rust: a.previous = a.position;
    // rust: a.previous_yaw = a.yaw;
            // Entity.baseTick clears firstTick only when the entity actually ticks.
    // rust: a.first_tick = false;
            // aiStep's freezing step (removeFrost) makes the speed instance.
    // rust: a.speed_instance = true;
    // rust: let (water_height, lava_height) =
    // rust: a.push_by_fluid(&self.world, &self.res.motion().fluids);
    // rust: let in_water = water_height > 0.0;
    // rust: let medium =
    // rust: horizon_client::entities::StandMedium::from_heights(water_height, lava_height);
    // rust: let (world, registry, facts, collision) = (
    // rust: &self.world,
    // rust: self.pack.assets.registry,
    // rust: self.res.facts(),
    // rust: self.collision,
    // rust: );
    // rust: let mut scene = horizon_client::collisions::SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let mut tops: Vec<BlockPos> = Vec::new();
    // rust: if let Some(step) = a.tick_move(
    // rust: &mut scene,
    // rust: facts,
    // rust: &self.res.motion().climbing,
    // rust: in_water,
    // rust: Some(self.border.geometry()),
    // rust: ) {
                // LivingEntity.aiStep: `travel` first, then the blocks' push.
    // rust: a.tick_settle(medium, step);
    // rust: a.push_by_bubble_column_over(world, registry, facts, collision, |pos| {
    // rust: tops.push(pos)
    // rust: });
}
    // rust: for pos in tops {
    // rust: self.bubble_column_particles(pos);
}
    // rust: let a = &mut self.armor_stands[i];
    // rust: if in_water {
    // rust: a.enchantment_fall_distance = 0.0;
    // rust: } else {
                // Entity.checkFallDamage narrows each movement before adding to the double.
    // rust: a.enchantment_fall_distance +=
    // rust: f64::from((a.previous.y - a.position.y).max(0.0) as f32);
}
    // rust: let landed = a.on_ground && a.enchantment_fall_distance > 0.0;
    // rust: if a.on_ground {
    // rust: a.enchantment_fall_distance = 0.0;
}
            // LivingEntity.checkFallDamage: onChangedBlock before the block's
            // fallOn, then aiStep's applyEffectsFromBlocks (stepOn, then the
            // blocks it is inside).
    // rust: if landed {
    // rust: self.armor_stand_location_effects(i, true);
}
    // rust: self.armor_stand_turtle_eggs(i, landed)?;
    // rust: if landed {
    // rust: let stand = &self.armor_stands[i];
    // rust: let (position, bounds) = (stand.position, stand.bounds());
    // rust: self.post_landing_event(position, bounds, true);
}
    // rust: self.armor_stands[i].apply_honey_slide(&self.world, self.res.facts());
    // rust: let a = &self.armor_stands[i];
    // rust: if !a.marker && !a.no_gravity {
    // rust: self.entity_powder_snow_particles(
    // rust: a.previous,
    // rust: a.position,
    // rust: a.bounds(),
    // rust: a.velocity,
    // rust: true,
    // rust: );
}
            // LivingEntity.aiStep calls pushEntities after travel. The stand's
            // own doPush is empty; only this shove runs.
    // rust: self.push_rideable_minecarts(i);
    // rust: let a = &mut self.armor_stands[i];
    // rust: if !a.environment_tick(&self.world, self.res.facts(), self.pack.assets.registry) {
    // rust: dead.push(i);
}
}
    // rust: for i in dead.into_iter().rev() {
    // rust: self.break_armor_stand_by_anything(i);
}
    // rust: Ok(())
}
    // `ArmorStand.pushEntities`: a plain minecart (`RIDABLE_MINECARTS`,
    // `AbstractMinecart.isRideable`) whose box meets the stand's is shoved
    // when `distanceToSqr` is at most 0.2. `AbstractMinecart.push` of a
    // non-cart adds the push to the cart and a quarter of it to the stand
    // (`Entity.push(double)` does not consult `isPushable`). A stand with no
    // physics (`Marker` or `NoGravity`, `ArmorStand.hasPhysics` / `noPhysics`)
    // or one riding that cart does not shove it.
push_rideable_minecarts :: proc(self: ^Self, i: uint) {
}
    // rust: let stand = &self.armor_stands[i];
    // rust: if stand.marker || stand.no_gravity {
    // rust: return;
}
    // rust: let stand_pos = stand.position;
    // rust: let stand_box = stand.bounds();
    // rust: let vehicle = stand.vehicle;
    // rust: let mut applied = Vec::new();
    // rust: for (j, cart) in self.carts.iter().enumerate() {
    // rust: let Some(shove) = armor_stand_cart_shove(
    // rust: stand_pos,
    // rust: stand_box,
    // rust: cart.position,
    // rust: cart.bounds(),
    // rust: cart.kind,
    // rust: vehicle == Some(cart.id),
    // rust: ) else {
    // rust: continue;
}
    // rust: applied.push((j, shove));
}
    // rust: let mut stand_x = 0.0;
    // rust: let mut stand_z = 0.0;
    // rust: for (j, shove) in applied {
    // rust: let cart = &mut self.carts[j];
    // rust: cart.velocity.x += shove.cart_x;
    // rust: cart.velocity.z += shove.cart_z;
    // rust: stand_x += shove.stand_x;
    // rust: stand_z += shove.stand_z;
}
    // rust: if stand_x != 0.0 || stand_z != 0.0 {
    // rust: let stand = &mut self.armor_stands[i];
    // rust: stand.velocity.x += stand_x;
    // rust: stand.velocity.z += stand_z;
}
}
    // An armor stand is a `LivingEntity`, so the egg under it
    // (`getOnPosLegacy`) cracks like under a mob: `TurtleEggBlock.fallOn` one
    // landing in 3 (`Entity.move`'s `checkFallDamage`), then `stepOn` one tick
    // in 100 while it is on the ground (`LivingEntity.aiStep`'s
    // `applyEffectsFromBlocks`, after `travel`, so a marker that has landed
    // still steps). `canDestroyEgg` wants mob griefing before the level's roll.
armor_stand_turtle_eggs :: proc(self: ^Self, i: uint, landed: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let stand = &self.armor_stands[i];
    // rust: if !stand.on_ground || self.remote.is_some() || self.options.execution_role.is_client() {
    // rust: return Ok(());
}
    // rust: let p = stand.on_pos_legacy(|p| {
    // rust: let name = &self.res.facts().get(self.world.block(p.x, p.y, p.z)).name;
    // rust: let tags = &self.res.items().block_tags;
    // rust: [
    // rust: "minecraft:fences",
    // rust: "minecraft:walls",
    // rust: "minecraft:fence_gates",
    // rust: ]
    // rust: .iter()
    // rust: .any(|t| tags.get(*t).is_some_and(|s| s.contains(&**name)))
    // rust: });
    // rust: for chance in [landed.then_some(3), Some(100)].into_iter().flatten() {
    // rust: let egg = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(self.world.block(p.x, p.y, p.z))
    // rust: .is_some_and(|s| s.name == "minecraft:turtle_egg");
    // rust: if egg
    // rust: && self.ui.rules.bool("mob_griefing")
    // rust: && self.world.random.next_int_bound(chance).unwrap_or(1) == 0
    // rust: {
    // rust: self.crack_turtle_egg([p.x, p.y, p.z])?;
}
}
    // rust: Ok(())
}
    // `ArmorStand.brokenByAnything`, then `kill`, as burning out or a blast
    // breaks a stand: its equipment pops above its block, the stand item does
    // not drop.
    // rust: pub(super) fn break_armor_stand_by_anything(&mut self, i: usize) {
    // rust: let a = self.armor_stands.remove(i);
    // rust: let at = [a.position.x, a.position.y, a.position.z];
    // rust: let (pos, drops) = broken_armor_stand_equipment(a);
    // rust: for stack in drops {
    // rust: self.pop_resource(pos, stack);
}
    // rust: self.audio
    // rust: .play("minecraft:entity.armor_stand.break", Some(at), 1.0, 1.0);
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
}
    // ArmorStandRenderer: the stand with its default pose, then armor layers.
    // rust: pub(super) fn armor_stand_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
        // The stands' models posed on the GPU path (`mobs::skin`), when it runs this frame.
    // rust: let skinning = self.skinning();
    // rust: for a in &self.armor_stands {
            // ArmorStand.shouldRenderAtSqrDistance: 256 times the box's mean
            // edge (4 for a marker's empty box), whatever the entity distance.
            // LivingEntityRenderer grows the culling box by 0.5 for a dragon head.
    // rust: let (width, height) = match (a.marker, a.small) {
    // rust: (true, _) => (0.0, 0.0),
    // rust: (false, true) => (0.25, 0.9875),
    // rust: (false, false) => (0.5, 1.975),
}
    // rust: let edge = (width + height + width) / 3.0 * 4.0;
            // 26.3 compares the size with RenderSystem.DEFAULT_DEPTH_CLEAR_VALUE,
            // which is 0.0 (reverse Z; the bytecode is `dconst_0`): an empty
            // marker box falls back to 4, so a visible marker stand draws.
            // Holograms stay hidden through the invisible flag instead.
    // rust: let range = if edge == 0.0 { 4.0 } else { edge } * 64.0;
    // rust: let dragon = a.equipment[5]
    // rust: .as_ref()
    // rust: .is_some_and(|i| &*i.item == "minecraft:dragon_head");
    // rust: if !self.standing_entity_in_view(
    // rust: camera,
    // rust: super::entity_culling::at(a.previous),
    // rust: super::entity_culling::at(a.position),
    // rust: alpha,
    // rust: width,
    // rust: height,
    // rust: range,
    // rust: if dragon { 0.5 } else { 0.0 },
    // rust: ) {
    // rust: continue;
}
    // rust: let culling = self.entity_cull_decision(a, alpha);
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let entity_start = out.len();
            // EntityRenderer: drawn between last tick's position and this one's.
    // rust: let at = a.render_position(alpha);
    // rust: let p = super::entity_culling::at(at) - camera;
            // setupRotations: 180 - body yaw, plus the wobble for 5 ticks after a hit.
    // rust: let wiggle = (self.world.game_time - a.last_hit) as f32 + alpha as f32;
    // rust: let wobble = if wiggle < 5.0 {
    // rust: (wiggle / 1.5 * std::f32::consts::PI).sin() * 3.0
    // rust: } else {
    // rust: 0.0
}
    // rust: let base = glam::Mat4::from_translation(p.as_vec3())
    // rust: * glam::Mat4::from_rotation_y(
    // rust: (180.0 - a.render_yaw(alpha as f32) + wobble).to_radians(),
    // rust: )
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.501, 0.0));
    // rust: let light = self.world.light(
    // rust: at.x.floor() as i32,
    // rust: (at.y + 0.5).floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let skinned = if skinning {
    // rust: let mut models = self.skin_models.borrow_mut();
    // rust: let mut frame = self.skin_frame.borrow_mut();
    // rust: let mark = frame.mark();
    // rust: let mut skin = horizon_client::mobs::skin::Skin::new(&mut models, &mut frame);
    // rust: self.armor_stand_vertices(a, base, packed, Some(&mut skin), out);
    // rust: Some((mark, skin.bounds))
    // rust: } else {
    // rust: self.armor_stand_vertices(a, base, packed, None, out);
    // rust: None
}
    // rust: if !self.entity_glowing(a.id) {
    // rust: self.cull_skinned(out, entity_start, skinned);
}
}
}
    // `ArmorStandRenderer.submit` for stand `a` under `base` (its
    // `setupRotations`): the body, the hand and head items, the armour and
    // the wings, at packed light `packed`. With `skin`, the stand's own models
    // (body and armour) are posed on the GPU; items and wings stay here.
    // rust: fn armor_stand_vertices(
    // rust: &self,
    // rust: a: &ArmorStand,
    // rust: base: glam::Mat4,
    // rust: packed: u32,
    // rust: mut skin: Option<&mut horizon_client::mobs::skin::Skin>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
//         use horizon_client::mobs::render::put;
    // rust: let assets = &self.armor_stand_assets;
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: let uv_of = |name: &str| sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
        // A texture's OptiFine emissive overlay. The lock is read per lookup and let go:
        // `wings_geometry` below reads it too.
    // rust: let glow_of = |texture: &str| {
    // rust: let emissive = self
    // rust: .res
    // rust: .mob_data()
    // rust: .emissive
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: emissive.overlay(texture).and_then(uv_of)
}
    // rust: let Some(wood) = uv_of("entity/armorstand/armorstand") else {
    // rust: return;
}
    // rust: let Some(model) = (if a.small { &assets.small } else { &assets.main }) else {
    // rust: return;
}
    // rust: let mut poses = Poses::new(model);
        // ArmorStandModel.setupAnim: the stand's pose and part visibility.
    // rust: apply_pose(&mut poses, &a.pose);
        // Item layers pose from the hidden arms too (`visible` only skips drawing).
    // rust: let posed = poses.clone();
    // rust: let mut hide = |name: &str| {
    // rust: if poses.has(name) {
    // rust: let pose = poses.get(name);
    // rust: pose[6] = 0.0;
    // rust: pose[7] = 0.0;
    // rust: pose[8] = 0.0;
}
}
    // rust: if !a.show_arms {
    // rust: hide("left_arm");
    // rust: hide("right_arm");
}
    // rust: if a.no_base_plate {
    // rust: hide("base_plate");
}
        // LivingEntityRenderer.submit: an invisible stand has no body render type, but its
        // layers (held items, custom head, armour) are submitted all the same.
    // rust: if !a.invisible {
    // rust: put(
    // rust: &mut skin,
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: wood,
    // rust: 0.0,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: if let Some(glow) = glow_of("entity/armorstand/armorstand") {
    // rust: let full = horizon_client::mobs::render::FULL_BRIGHT;
    // rust: put(
    // rust: &mut skin,
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: glow,
    // rust: 0.0,
    // rust: 0xFFFF_FFFF,
    // rust: full,
    // rust: 0,
    // rust: out,
    // rust: );
}
}
    // rust: self.armor_stand_items(a, model, base, &posed, packed, skin.as_deref_mut(), out);
        // HumanoidArmorLayer: head, chest, legs, feet. One pose map for every layer
        // (`reset` keeps its capacity).
    // rust: let mut layer_poses = Poses::default();
    // rust: for (slot, layer) in [
    // rust: (5usize, "helmet"),
    // rust: (4, "chestplate"),
    // rust: (3, "leggings"),
    // rust: (2, "boots"),
    // rust: ] {
    // rust: let Some(stack) = &a.equipment[slot] else {
    // rust: continue;
}
    // rust: let Some(asset) = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_asset.clone())
    // rust: else {
    // rust: continue;
}
    // rust: let kind = if layer == "leggings" {
    // rust: "humanoid_leggings"
    // rust: } else {
    // rust: "humanoid"
}
    // rust: let Some(layers) = assets.equipment.get(&asset).and_then(|k| k.get(kind)) else {
    // rust: continue;
}
    // rust: let Some(part) = assets.layers.get(&(layer, a.small)) else {
    // rust: continue;
}
            // ArmorStandRenderer's HumanoidArmorLayer: the armour glint
            // when `stack.hasFoil()`, as on a living entity.
    // rust: let item_glint = self
    // rust: .res
    // rust: .items()
    // rust: .enchantments
    // rust: .props
    // rust: .get(&stack.item)
    // rust: .is_some_and(|p| p.glint);
    // rust: let overlay = if stack.has_foil(item_glint) {
    // rust: horizon_client::mobs::render::ARMOR_GLINT
    // rust: } else {
    // rust: 0
}
            // ArmorStandArmorModel.setupAnim: the same pose as the stand.
    // rust: layer_poses.reset(part);
    // rust: apply_pose(&mut layer_poses, &a.pose);
            // EquipmentLayerRenderer: every layer of the asset, the leather overlay
            // too; the shader glint goes on the first layer only (renderShaderGlint).
    // rust: let cit = self.cit_worn_rule(Kind::Armor, stack);
    // rust: for (i, (texture, undyed)) in layers.iter().enumerate() {
    // rust: let Some(uv) = self.armor_layer_rect(cit, &asset, kind, texture) else {
    // rust: continue;
}
    // rust: let color = layer_color(*undyed, Some(stack));
    // rust: put(
    // rust: &mut skin,
    // rust: part,
    // rust: base,
    // rust: &layer_poses,
    // rust: uv,
    // rust: 0.0,
    // rust: color,
    // rust: packed,
    // rust: if i == 0 { overlay } else { 0 },
    // rust: out,
    // rust: );
                // The layer's OptiFine emissive overlay, full bright without the glint.
    // rust: if let Some(glow) = glow_of(texture) {
    // rust: put(
    // rust: &mut skin,
    // rust: part,
    // rust: base,
    // rust: &layer_poses,
    // rust: glow,
    // rust: 0.0,
    // rust: color,
    // rust: horizon_client::mobs::render::FULL_BRIGHT,
    // rust: 0,
    // rust: out,
    // rust: );
}
}
            // EquipmentLayerRenderer: the trim layer over the armour.
    // rust: if let Some(trim) = assets
    // rust: .trim_texture(&asset, kind, stack)
    // rust: .and_then(|t| uv_of(&t.sprite()))
    // rust: {
    // rust: put(
    // rust: &mut skin,
    // rust: part,
    // rust: base,
    // rust: &layer_poses,
    // rust: trim,
    // rust: 0.0,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: overlay,
    // rust: out,
    // rust: );
}
}
        // WingsLayer: ArmorStandRenderer adds it after the armour layers. A stand
        // never crouches or glides, so its wings rest folded.
    // rust: self.wings_geometry(
    // rust: a.equipment[4].as_ref().map(|s| &*s.item),
    // rust: a.equipment[4].as_ref(),
    // rust: None,
    // rust: a.small,
    // rust: base,
    // rust: horizon_client::mobs::ElytraAnimation::RESTING,
    // rust: false,
    // rust: packed,
    // rust: self.wings_overlay(a.equipment[4].as_ref()),
    // rust: out,
    // rust: );
}
    // `SmithingScreen`'s armour stand: `updateArmorStandPreview` puts the
    // result on a stand without its base plate and with its arms, turned to
    // 210 degrees, and `extractEntityInInventory` draws it at scale 25 in
    // the box (x0, y0) to (x1, y1), moved up 1 and tilted by `ARMOR_STAND_ANGLE`.
    // rust: pub(super) fn draw_smithing_armor_stand(
    // rust: &self,
    // rust: batch: &mut horizon_client::hud::HudBatch,
    // rust: result: Option<&ItemStack>,
    // rust: [x0, y0, x1, y1]: [f32; 4],
    // rust: ) {
    // rust: let mut stand = ArmorStand::new(0, Vec3::ZERO, 210.0);
    // rust: stand.no_base_plate = true;
    // rust: stand.show_arms = true;
    // rust: if let Some(stack) = result {
    // rust: let equip = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_slot.clone());
    // rust: stand.equipment[preview_slot(equip.as_deref())] = Some(stack.clone());
}
        // LivingEntityRenderer: setupRotations (180 - body yaw), the flip and
        // the 1.501 drop, at full light.
    // rust: let base = glam::Mat4::from_rotation_y((180.0 - stand.yaw).to_radians())
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.501, 0.0));
    // rust: let mut verts = Vec::new();
    // rust: self.armor_stand_vertices(&stand, base, 240 | 240 << 8, None, &mut verts);
        // ARMOR_STAND_ANGLE: rotationXYZ(0.43633232, 0, PI).
    // rust: let gui =
    // rust: glam::Mat4::from_translation(glam::Vec3::new((x0 + x1) / 2.0, (y0 + y1) / 2.0, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(25.0, 25.0, -25.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 1.0, 0.0))
    // rust: * glam::Mat4::from_rotation_x(0.436_332_32)
    // rust: * glam::Mat4::from_rotation_z(std::f32::consts::PI);
    // rust: let quads =
    // rust: super::perspective::player_preview_quads(verts, gui, None, &self.gui.atlas.sprites);
    // rust: let start = batch.vertices.len();
    // rust: for (_, p, uv, color) in quads {
    // rust: batch.quad_3d(p, uv, color);
}
    // rust: batch.depth_since(start, [x0, y0, x1, y1]);
}
}
// The stand's slot (`ArmorStand::SLOTS` order) for an item whose
// `equippable` slot is `equip` (`SmithingScreen.updateArmorStandPreview`):
// worn in a head, chest, legs or feet slot, else (no `equippable`, or any
// other slot: main hand, off hand, body, saddle) held in the left hand.
preview_slot :: proc(equip: Maybe(string)) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match equip {
    // rust: Some("feet") => 2,
    // rust: Some("legs") => 3,
    // rust: Some("chest") => 4,
    // rust: Some("head") => 5,
    // rust: _ => 1,
}
}
// The `Pose` rotations on the parts of an armor stand model or its armor
// (`ArmorStandArmorModel.setupAnim`); the body also turns the sticks.
apply_pose :: proc(poses: ^Poses, pose: ^[[f32; 3]; 6]) {
}
    // rust: let parts: [&[&str]; 6] = [
    // rust: &["head"],
    // rust: &[
    // rust: "body",
    // rust: "right_body_stick",
    // rust: "left_body_stick",
    // rust: "shoulder_stick",
    // rust: ],
    // rust: &["left_arm"],
    // rust: &["right_arm"],
    // rust: &["left_leg"],
    // rust: &["right_leg"],
    // rust: ];
    // rust: for (names, rotation) in parts.into_iter().zip(pose) {
    // rust: for name in names {
    // rust: if poses.has(name) {
    // rust: let part = poses.get(name);
    // rust: part[3] = rotation[0].to_radians();
    // rust: part[4] = rotation[1].to_radians();
    // rust: part[5] = rotation[2].to_radians();
}
}
}
}
overlaps :: proc(a: Aabb, b: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (a0, a1, b0, b1) = (
    // rust: a.min_position(),
    // rust: a.max_position(),
    // rust: b.min_position(),
    // rust: b.max_position(),
    // rust: );
    // rust: a0.x < b1.x && b0.x < a1.x && a0.y < b1.y && b0.y < a1.y && a0.z < b1.z && b0.z < a1.z
}
// What `Equippable.swapWithEquipmentSlot` leaves once it has passed its
// checks: the piece worn in the slot, the hand, and the old piece bound for
// the inventory.
ArmorSwap :: struct {
    worn: ItemStack,
    hand: Maybe(ItemStack),
    to_inventory: Maybe(ItemStack),
}
// `Equippable.swapWithEquipmentSlot` after its checks. A single item swaps
// with the worn piece: the hand gets the worn piece (`copyAndClear`), or
// keeps the item in creative when nothing was worn; creative wears a copy
// (`copy` instead of `copyAndClear`). From a larger stack one item is worn
// (`consumeAndReturn`, which takes none in creative) and the worn piece goes
// to the inventory.
    // rust: fn swap_with_equipment_slot(
    // rust: stack: &ItemStack,
    // rust: current: Option<ItemStack>,
    // rust: creative: bool,
    // rust: ) -> ArmorSwap {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: if stack.count <= 1 {
    // rust: let hand = match current {
    // rust: Some(old) => Some(old),
    // rust: None if creative => Some(stack.clone()),
    // rust: None => None,
}
    // rust: return ArmorSwap {
    // rust: worn: one,
    // rust: hand,
    // rust: to_inventory: None,
}
}
    // rust: let mut held = stack.clone();
    // rust: if !creative {
    // rust: held.count -= 1;
}
    // rust: ArmorSwap {
    // rust: worn: one,
    // rust: hand: Some(held),
    // rust: to_inventory: current,
}
}
    // rust: impl Game<'_> {
    // `Equippable.swapWithEquipmentSlot`: right-clicking armor swaps it into
    // its slot (the worn piece comes back to the hand). It runs on a client
    // too (`Item.use`), as the prediction the server's slot packets confirm.
    // rust: pub(super) fn equip_from_hand(&mut self, stack: &ItemStack) -> bool {
    // rust: let Some(info) = self.items().get(&stack.item) else {
    // rust: return false;
}
    // rust: let (index, slot) = match info.equip_slot.as_deref() {
    // rust: Some("head") => (0, "head"),
    // rust: Some("chest") => (1, "chest"),
    // rust: Some("legs") => (2, "legs"),
    // rust: Some("feet") => (3, "feet"),
    // rust: _ => return false,
}
    // rust: if !info.swappable {
    // rust: return false;
}
    // rust: let current = self.armor[index].clone();
        // PREVENT_ARMOR_CHANGE (Curse of Binding) outside creative, or the same item.
    // rust: if current.as_ref().is_some_and(|c| {
    // rust: (c.enchantment_level("minecraft:binding_curse") > 0 && !self.creative)
    // rust: || c.same_item_same_components(stack)
    // rust: }) {
    // rust: return true;
}
        // Counted on the server only, before the swap.
    // rust: if self.remote.is_none() {
    // rust: self.award_stat("used", &stack.item, 1);
}
    // rust: let swap = swap_with_equipment_slot(stack, current, self.creative);
    // rust: self.armor[index] = Some(swap.worn.clone());
        // Player.setItemSlot: onEquipItem plays the equip sound.
    // rust: self.player_equipped(slot, Some(&swap.worn));
    // rust: *self.held_mut() = swap.hand;
        // Inventory.add, else Player.drop (in creative a full inventory
        // takes it anyway: hasInfiniteMaterials empties the stack).
    // rust: if let Some(old) = swap.to_inventory
    // rust: && let Some(rest) = self.give(old)
    // rust: && !self.creative
            // Player.drop is the server's on a client: it spawns the item.
    // rust: && self.remote.is_none()
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
            // Player.drop(stack, false): thrown from the eyes, no thrower.
    // rust: self.throw_from_eyes(rest, eye, false);
}
        // The attribute modifiers of a worn piece come from the server's
        // ClientboundUpdateAttributesPacket on a client.
    // rust: if self.remote.is_none() {
    // rust: self.apply_equipment();
}
    // rust: self.swing_arm();
    // rust: true
}
}
    // rust: impl Game<'_> {
    // `ItemInHandLayer` and `CustomHeadLayer` of an armour stand: the hand
    // items in the third-person contexts, and a non-armour head item on the
    // head (`translateToHead`: down a quarter, turned, 0.625 scale). With
    // `skin`, items that can are posed on the GPU with the stand.
    // rust: fn armor_stand_items(
    // rust: &self,
    // rust: a: &ArmorStand,
    // rust: model: &Part,
    // rust: base: glam::Mat4,
    // rust: poses: &Poses,
    // rust: light: u32,
    // rust: mut skin: Option<&mut horizon_client::mobs::skin::Skin>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let lights =
    // rust: horizon_client::block_entity_render::diffuse_lights(self.dim == super::Dim::Nether);
    // rust: let mut submit = |state: &horizon_client::item_render::ItemRenderState,
    // rust: pose: glam::Mat4,
    // rust: out: &mut Vec<Vertex>| {
    // rust: let on_gpu = skin
    // rust: .as_deref_mut()
    // rust: .is_some_and(|skin| self.skin_item(state, pose, light, lights, skin));
    // rust: if !on_gpu {
    // rust: self.submit_item_world(state, pose, light, out);
}
}
//         use horizon_assets::item_model::DisplayContext;
//         use horizon_client::mobs::render::part_matrix;
    // rust: let owner = super::item_draw::owner_at(
    // rust: [a.position.x, a.position.y, a.position.z],
    // rust: a.yaw,
    // rust: "minecraft:armor_stand",
    // rust: );
        // `useBabyOffset`: small stands use the baby hand offsets.
    // rust: let (ox, oy, oz) = if a.small {
    // rust: (0.0, 1.0, -4.5)
    // rust: } else {
    // rust: (1.0, 2.0, -10.0)
}
    // rust: for (slot, left, context) in [
    // rust: (0usize, false, DisplayContext::ThirdPersonRightHand),
    // rust: (1, true, DisplayContext::ThirdPersonLeftHand),
    // rust: ] {
    // rust: let Some(stack) = &a.equipment[slot] else {
    // rust: continue;
}
    // rust: let arm = if left { "left_arm" } else { "right_arm" };
    // rust: let Some(hand) = part_matrix(model, base, poses, arm, 0.0) else {
    // rust: continue;
}
    // rust: let pose = hand
    // rust: * glam::Mat4::from_rotation_x((-90.0f32).to_radians())
    // rust: * glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(
    // rust: if left { -ox } else { ox } / 16.0,
    // rust: oy / 16.0,
    // rust: oz / 16.0,
    // rust: ));
    // rust: let seed = a.id as i32 + if left { 1 } else { 2 };
            // OptiFine CIT `hand=off` rules: slot 1 is the off hand.
    // rust: let state = if left {
    // rust: self.resolve_item_in_hand(stack, context, Some(&owner), seed, Hand::Off)
    // rust: } else {
    // rust: self.resolve_item(stack, context, Some(&owner), seed)
}
    // rust: submit(&state, pose, out);
}
        // `CustomHeadLayer`: a worn skull draws the skull model.
    // rust: if let Some(stack) = &a.equipment[5]
    // rust: && let Some(kind) = skull_kind(&stack.item)
    // rust: && let Some(head) = part_matrix(model, base, poses, "head", 0.0)
    // rust: {
    // rust: let pose = head * glam::Mat4::from_scale(glam::Vec3::splat(1.1875));
    // rust: let special = horizon_assets::item_model::SpecialModel {
    // rust: kind: if kind == "player" {
    // rust: horizon_assets::item_model::SpecialKind::PlayerHead
    // rust: } else {
    // rust: horizon_assets::item_model::SpecialKind::Head {
    // rust: kind: kind.to_owned(),
    // rust: texture: None,
    // rust: animation: 0.0,
}
    // rust: },
}
    // rust: let mut sink = horizon_client::item_render::WorldSink {
    // rust: out,
    // rust: light,
    // rust: lights: Some(horizon_client::block_entity_render::diffuse_lights(
    // rust: self.dim == super::Dim::Nether,
    // rust: )),
    // rust: glint: self.glint(),
    // rust: tier: 0,
}
    // rust: let profile = stack
    // rust: .extra
    // rust: .as_deref()
    // rust: .and_then(|d| d.other.iter().find(|(k, _)| k == "minecraft:profile"))
    // rust: .map(|(_, t)| horizon_client::scoreboard::tag_to_json(t))
    // rust: .unwrap_or(serde_json::Value::Null);
    // rust: self.pack.item_renderer.submit_special(
    // rust: &special,
    // rust: &profile,
    // rust: false,
    // rust: pose,
    // rust: &self.gui.atlas.sprites,
    // rust: &self.item_host(),
    // rust: &mut sink,
    // rust: );
    // rust: return;
}
        // A head item that is not worn armour.
    // rust: if let Some(stack) = &a.equipment[5]
    // rust: && self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_none_or(|i| i.equip_asset.is_none())
    // rust: && let Some(head) = part_matrix(model, base, poses, "head", 0.0)
    // rust: {
    // rust: let pose = head
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.25, 0.0))
    // rust: * glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(0.625, -0.625, -0.625));
            // `updateForLiving`: seeded by the entity id plus HEAD's ordinal.
    // rust: let state =
    // rust: self.resolve_item(stack, DisplayContext::Head, Some(&owner), a.id as i32 + 5);
    // rust: submit(&state, pose, out);
}
}
}
// `ArmorStand.getBbWidth` and `getBbHeight`: a marker has no box, a small stand is half size.
stand_box :: proc(a: ^ArmorStand) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match (a.marker, a.small) {
    // rust: (true, _) => (0.0, 0.0),
    // rust: (false, true) => (0.25, 0.9875),
    // rust: (false, false) => (0.5, 1.975),
}
}
// `AbstractSkullBlock.getType` of a skull item.
    // rust: pub(super) fn skull_kind(item: &str) -> Option<&'static str> {
    // rust: Some(match item {
    // rust: "minecraft:skeleton_skull" => "skeleton",
    // rust: "minecraft:wither_skeleton_skull" => "wither_skeleton",
    // rust: "minecraft:zombie_head" => "zombie",
    // rust: "minecraft:creeper_head" => "creeper",
    // rust: "minecraft:dragon_head" => "dragon",
    // rust: "minecraft:piglin_head" => "piglin",
    // rust: "minecraft:player_head" => "player",
    // rust: _ => return None,
    // rust: })
}

// `ArmorStand.ignoreExplosion` (an invisible stand), and `hurtServer`
// refusing an invisible or marker stand: such a stand outlasts any blast.
    // rust: pub(super) fn spared_by_blast(a: &ArmorStand) -> bool {
    // rust: a.invisible || a.marker
}

// `ArmorStand.brokenByAnything`: the equipment, less what curse of vanishing
// keeps (`PREVENT_EQUIPMENT_DROP`), popped at `blockPosition().above()`.
broken_armor_stand_equipment :: proc(a: ArmorStand) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let pos = [
    // rust: a.position.x.floor() as i32,
    // rust: a.position.y.floor() as i32 + 1,
    // rust: a.position.z.floor() as i32,
    // rust: ];
    // rust: let drops = a
    // rust: .equipment
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|stack| stack.enchantment_level("minecraft:vanishing_curse") == 0)
    // rust: .collect();
    // rust: (pos, drops)
}
    // rust: mod swap_tests {
//     use super::*;
stack :: proc(item: string, count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack::new(item, count)
}
disabled_slots_lock_by_filter_flag :: proc() {
}
    // rust: let mut a = ArmorStand::new(1, horizon_core::geometry::Vec3::ZERO, 0.0);
        // Hands need arms.
    // rust: assert!(a.is_disabled(0) && a.is_disabled(1));
    // rust: a.show_arms = true;
    // rust: assert!(!a.is_disabled(0) && !a.is_disabled(1));
        // Bit 4 locks the head (equipment index 5), bit 5 the off hand (1).
    // rust: a.disabled_slots = (1 << 4) | (1 << 5);
    // rust: assert!(a.is_disabled(5) && a.is_disabled(1));
    // rust: assert!(!a.is_disabled(4) && !a.is_disabled(0));
        // Taking (+8) from a filled slot and putting (+16) into an empty one.
    // rust: a.disabled_slots = (1 << (3 + 8)) | (1 << (1 + 16));
    // rust: assert!(!a.swap_locked(4), "an empty chest slot is not take-locked");
    // rust: a.equipment[4] = Some(stack("minecraft:iron_chestplate", 1));
    // rust: assert!(a.swap_locked(4));
    // rust: assert!(a.swap_locked(2), "an empty feet slot is put-locked");
    // rust: a.equipment[2] = Some(stack("minecraft:iron_boots", 1));
    // rust: assert!(!a.swap_locked(2));
}
creative_swap_gives_the_worn_piece_to_the_hand :: proc() {
}
    // rust: let swap = swap_with_equipment_slot(
    // rust: &stack("minecraft:diamond_chestplate", 1),
    // rust: Some(stack("minecraft:iron_chestplate", 1)),
    // rust: true,
    // rust: );
    // rust: assert_eq!(swap.worn, stack("minecraft:diamond_chestplate", 1));
    // rust: assert_eq!(swap.hand, Some(stack("minecraft:iron_chestplate", 1)));
    // rust: assert_eq!(swap.to_inventory, None);
}
creative_equip_with_nothing_worn_keeps_the_hand :: proc() {
}
    // rust: let swap = swap_with_equipment_slot(&stack("minecraft:diamond_helmet", 1), None, true);
    // rust: assert_eq!(swap.worn, stack("minecraft:diamond_helmet", 1));
    // rust: assert_eq!(swap.hand, Some(stack("minecraft:diamond_helmet", 1)));
}
survival_swap_gives_the_worn_piece_or_empties_the_hand :: proc() {
}
    // rust: let worn = Some(stack("minecraft:iron_boots", 1));
    // rust: let swap = swap_with_equipment_slot(&stack("minecraft:diamond_boots", 1), worn, false);
    // rust: assert_eq!(swap.hand, Some(stack("minecraft:iron_boots", 1)));
    // rust: let swap = swap_with_equipment_slot(&stack("minecraft:diamond_boots", 1), None, false);
    // rust: assert_eq!(swap.hand, None);
}
a_larger_stack_wears_one_and_sends_the_old_piece_to_the_inventory :: proc() {
}
        // Armour stacks past one only with a max_stack_size component.
    // rust: let worn = Some(stack("minecraft:leather_helmet", 1));
    // rust: let swap =
    // rust: swap_with_equipment_slot(&stack("minecraft:golden_helmet", 3), worn.clone(), false);
    // rust: assert_eq!(swap.worn, stack("minecraft:golden_helmet", 1));
    // rust: assert_eq!(swap.hand, Some(stack("minecraft:golden_helmet", 2)));
    // rust: assert_eq!(swap.to_inventory, worn);
    // rust: let swap =
    // rust: swap_with_equipment_slot(&stack("minecraft:golden_helmet", 3), worn.clone(), true);
    // rust: assert_eq!(swap.hand, Some(stack("minecraft:golden_helmet", 3)));
    // rust: assert_eq!(swap.to_inventory, worn);
}
}
    // rust: mod burn_drop_tests {
//     use super::*;
only_visible_non_marker_stands_are_broken_by_blasts :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: assert!(!spared_by_blast(&stand));
    // rust: stand.invisible = true;
    // rust: assert!(spared_by_blast(&stand));
    // rust: stand.invisible = false;
    // rust: stand.marker = true;
    // rust: assert!(spared_by_blast(&stand));
}
burnt_equipment_drops_above_the_block_and_vanishing_items_do_not_drop :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(-0.1, 4.8, 0.0), 0.0);
    // rust: let kept = ItemStack::new("minecraft:diamond_boots", 1);
    // rust: let mut vanished = ItemStack::new("minecraft:diamond_helmet", 1);
    // rust: vanished
    // rust: .data_mut()
    // rust: .enchantments
    // rust: .push(("minecraft:vanishing_curse".into(), 1));
    // rust: stand.equipment[0] = Some(kept.clone());
    // rust: stand.equipment[1] = Some(vanished);
    // rust: let (pos, drops) = broken_armor_stand_equipment(stand);
    // rust: assert_eq!(pos, [-1, 5, 0]);
    // rust: assert_eq!(drops, vec![kept]);
}
}
    // rust: mod push_tests {
//     use super::super::minecarts::{CartKind, Minecart};
//     use super::*;

boxes :: proc(kind: CartKind, cart_at: Vec3) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let stand = ArmorStand::new(1, Vec3::ZERO, 0.0);
    // rust: let cart = Minecart::new(2, kind, cart_at);
    // rust: (stand.bounds(), cart.bounds())
}

a_rideable_minecart_inside_the_0_2_gate_is_shoved :: proc() {
}
        // 0.25² is inside the 0.2 gate; 0.5² is not. The function's Some/None is the check.
    // rust: let near = Vec3::new(0.25, 0.0, 0.0);
    // rust: let far = Vec3::new(0.5, 0.0, 0.0);
    // rust: let (stand_box, cart_box) = boxes(CartKind::Rideable, near);
    // rust: let shove = armor_stand_cart_shove(
    // rust: Vec3::ZERO,
    // rust: stand_box,
    // rust: near,
    // rust: cart_box,
    // rust: CartKind::Rideable,
    // rust: false,
    // rust: )
    // rust: .expect("a rideable cart 0.25 away is shoved");
        // AbstractMinecart.push: gap 0.25, length 0.25, pow capped at 1, then 0.1F * 0.5.
        // The cart moves east, away from the stand; the stand takes a quarter west.
    // rust: let scale = f64::from(0.1_f32) * 0.5;
    // rust: assert_eq!(shove.cart_x, scale);
    // rust: assert_eq!(shove.cart_z, 0.0);
    // rust: assert_eq!(shove.stand_x, -scale / 4.0);
    // rust: assert_eq!(shove.stand_z, 0.0);

    // rust: let (stand_box, cart_box) = boxes(CartKind::Rideable, far);
    // rust: assert!(
    // rust: armor_stand_cart_shove(
    // rust: Vec3::ZERO,
    // rust: stand_box,
    // rust: far,
    // rust: cart_box,
    // rust: CartKind::Rideable,
    // rust: false
    // rust: )
    // rust: .is_none(),
    // rust: "past 0.2 the cart stays"
    // rust: );
    // rust: for kind in [
    // rust: CartKind::Chest,
    // rust: CartKind::Hopper,
    // rust: CartKind::Furnace,
    // rust: CartKind::Tnt,
    // rust: CartKind::CommandBlock,
    // rust: CartKind::Spawner,
    // rust: ] {
    // rust: let (stand_box, cart_box) = boxes(kind, near);
    // rust: assert!(
    // rust: armor_stand_cart_shove(Vec3::ZERO, stand_box, near, cart_box, kind, false)
    // rust: .is_none(),
    // rust: "{} is not a rideable minecart",
    // rust: kind.id()
    // rust: );
}
    // rust: let (stand_box, cart_box) = boxes(CartKind::Rideable, near);
    // rust: assert!(
    // rust: armor_stand_cart_shove(
    // rust: Vec3::ZERO,
    // rust: stand_box,
    // rust: near,
    // rust: cart_box,
    // rust: CartKind::Rideable,
    // rust: true
    // rust: )
    // rust: .is_none(),
    // rust: "a cart does not shove the stand riding it"
    // rust: );
}
}
    // rust: mod layer_color_tests {
//     use super::*;
the_smithing_preview_wears_armour_and_holds_the_rest_in_its_off_hand :: proc() {
}
    // rust: assert_eq!(preview_slot(Some("head")), 5);
    // rust: assert_eq!(preview_slot(Some("chest")), 4);
    // rust: assert_eq!(preview_slot(Some("legs")), 3);
    // rust: assert_eq!(preview_slot(Some("feet")), 2);
        // A netherite sword has no equippable slot; a saddle or a
        // main-hand item falls to the same default branch.
    // rust: for other in [
    // rust: None,
    // rust: Some("mainhand"),
    // rust: Some("offhand"),
    // rust: Some("body"),
    // rust: Some("saddle"),
    // rust: ] {
    // rust: assert_eq!(preview_slot(other), 1);
}
}

a_dyed_stack_overrides_the_undyed_leather_colour :: proc() {
}
    // rust: let mut dyed = ItemStack::new("minecraft:leather_helmet", 1);
    // rust: dyed.data_mut().dyed_color = Some(0x1E_90FF);
        // Dyed blue, R and B swapped into the renderer's order, opaque.
    // rust: assert_eq!(layer_color(Some(0xA06540), Some(&dyed)), 0xFFFF_901E);
        // An undyed stack keeps the asset's brown.
    // rust: let plain = ItemStack::new("minecraft:leather_helmet", 1);
    // rust: assert_eq!(layer_color(Some(0xA06540), Some(&plain)), 0xFF40_65A0);
        // No dye and no undyed colour: white.
    // rust: assert_eq!(layer_color(None, Some(&plain)), 0xFFFF_FFFF);
        // A layer that isn't dyeable stays white even on a dyed stack.
    // rust: assert_eq!(layer_color(None, Some(&dyed)), 0xFFFF_FFFF);
}
}
