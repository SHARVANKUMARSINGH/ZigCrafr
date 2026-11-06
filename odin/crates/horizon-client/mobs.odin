//! Transpiled from Horizon Rust crate
package horizon_client_mobs

import "core:fmt"
import "core:mem"
import "core:math"

// Mobs: entity types (dimensions and default attributes exported from
// vanilla), models (vanilla `LayerDefinitions` baked part trees) and the
// `Mob` entity with vanilla's AI framework: goal and target selectors with
// priorities and control flags (`goals`), A* pathfinding with walk, swim,
// fly and amphibious node evaluators (`path`, `nav`), move/look/jump/body
// controls (`control`), `LivingEntity` physics (`living`) and per-species
// behaviour, models, animations and sounds.
    // rust: pub mod ai;
    // rust: pub mod allay;
    // rust: pub mod ambient;
    // rust: pub mod anim;
    // rust: pub mod animal_brain;
    // rust: pub mod aquatic;
    // rust: pub mod armadillo;
    // rust: pub mod armor;
    // rust: pub mod axolotl;
    // rust: pub mod bat;
    // rust: pub mod bee;
    // rust: pub mod body_anim;
    // rust: pub mod brain;
    // rust: pub mod breeze;
    // rust: pub mod camel;
    // rust: pub mod caravan;
    // rust: pub mod cem;
    // rust: pub mod cem_anim;
    // rust: pub mod combat;
    // rust: pub mod control;
    // rust: pub mod conversion;
    // rust: pub mod copper_golem;
    // rust: pub mod creaking;
    // rust: pub mod creaking_heart;
    // rust: pub mod cube;
    // rust: pub mod data;
    // rust: pub mod dolphin;
    // rust: pub mod doors;
    // rust: pub mod drops;
    // rust: pub mod enderman;
    // rust: pub mod equine;
    // rust: pub mod equip;
    // rust: pub mod farm;
    // rust: pub mod finalize;
    // rust: pub mod fox;
    // rust: pub mod frog;
    // rust: pub mod gear;
    // rust: pub mod goals;
    // rust: pub mod goat;
    // rust: pub mod golem;
    // rust: pub mod guardian;
    // rust: pub mod happy_ghast;
    // rust: pub mod hostile;
    // rust: pub mod illager;
    // rust: pub mod illusioner;
    // rust: pub mod item_break;
    // rust: pub mod keyframes;
    // rust: pub mod landing;
    // rust: pub mod leash;
    // rust: pub mod living;
    // rust: pub mod llama;
    // rust: pub mod model_layers;
    // rust: pub mod monster_brain;
    // rust: pub mod nautilus;
    // rust: pub mod nav;
    // rust: pub mod nether;
    // rust: pub mod panda;
    // rust: pub mod parrot;
    // rust: pub mod path;
    // rust: pub mod phantom;
    // rust: pub mod piglin;
    // rust: pub mod polar_bear;
    // rust: pub mod rabbit;
    // rust: pub mod raider;
    // rust: pub mod random_textures;
    // rust: pub mod ravager;
    // rust: pub mod render;
    // rust: pub mod riders;
    // rust: pub mod seen_grid;
    // rust: pub mod sheep_dye;
    // rust: pub mod shulker;
    // rust: pub mod skin;
    // rust: pub mod skin_layers;
    // rust: pub mod sniffer;
    // rust: pub mod spawn_rules;
    // rust: pub mod spawn_selection;
    // rust: pub mod spawner;
    // rust: pub mod spawning;
    // rust: pub mod spear_use;
    // rust: pub mod species;
    // rust: pub mod strider;
    // rust: pub mod suffocation;
    // rust: pub mod sulfur_cube;
    // rust: pub mod sync;
    // rust: pub mod tame;
    // rust: pub mod trader;
    // rust: pub mod transport_items;
    // rust: pub mod trial_spawner;
    // rust: pub mod turtle;
    // rust: pub mod undead;
    // rust: pub mod vex;
    // rust: pub mod villager;
    // rust: pub mod villager_brain;
    // rust: pub mod villager_hats;
    // rust: pub mod warden;
    // rust: pub mod warden_brain;
    // rust: pub mod witch;
    // rust: pub mod wither;
    // rust: mod world;
    // rust: pub use world::{TargetInfo, visual_clip};
    // rust: pub mod dragon_contacts;
    // rust: pub mod zombie_villager;

// use crate::{blocks::BlockFacts, mesher::Vertex, world::World};
    // rust: pub use data::MobData;
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::block_collision::BlockCollisionRegistry;
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path, sync::Arc};

Polygon :: struct {
    normal: [f32,
    vertices: [[f32,
    // The model's render type culls back faces (`entityCutoutCull`: the bat,
    // the baby turtle).
    cull_back: bool,
}
    // rust: impl Polygon {
vertex_normal :: proc(self: ^Self, pose: ModelNormals) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let n = pose.matrix * glam::Vec3::from_array(self.normal);
    // rust: let n = if pose.trusted {
    // rust: n
    // rust: } else {
    // rust: n.normalize_or_zero()
}
    // rust: let packed = n.to_array().map(|v| (v.clamp(-1.0, 1.0) * 127.0) as i8);
    // rust: let w = if self.cull_back {
    // rust: crate::mesher::SHADED_CULL_W
    // rust: } else {
    // rust: -127
}
    // rust: [packed[0], packed[1], packed[2], w]
}
}

// ModelPart uses a separate normal stack: uniform scaling keeps normal lengths,
// while nonuniform scaling requires normalization after the complete part transform.
ModelNormals :: struct {
    matrix: glam::Mat3,
    trusted: bool,
}
    // rust: impl ModelNormals {
    // shortcut: infer the root normal pose from its geometry matrix; pass an explicit
    // root normal stack when root-transform rounding is ported as well.
new :: proc(base: glam::Mat4) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let m = glam::Mat3::from_mat4(base);
    // rust: let lengths = glam::Vec3::new(m.x_axis.length(), m.y_axis.length(), m.z_axis.length());
    // rust: let uniform =
    // rust: lengths.min_element() > 0.0 && lengths.max_element() - lengths.min_element() < 1.0e-6;
    // rust: Self {
    // rust: matrix: if uniform {
    // rust: m / lengths.x
    // rust: } else {
    // rust: m.inverse().transpose()
    // rust: },
    // rust: trusted: uniform,
}
}
rotation :: proc(x: f32, y: f32, z: f32) -> g {
    // Ported from Horizon
    return {}
}
        // JOML derives cosine from the rounded sine, then retains quaternion length.
        // Assuming an exactly unit quaternion changes a packed normal by one byte.
    // rust: let sin_cos = |angle: f32| {
    // rust: let angle = angle * 0.5;
    // rust: let sin = f64::from(angle).sin() as f32;
    // rust: let cos = (1.0 - sin * sin).sqrt();
    // rust: let a = angle + std::f32::consts::FRAC_PI_2;
    // rust: let tau = std::f32::consts::TAU;
    // rust: let mut quadrant = a - (a / tau) as i32 as f32 * tau;
    // rust: if quadrant < 0.0 {
    // rust: quadrant += tau;
}
    // rust: (
    // rust: sin,
    // rust: if quadrant >= std::f32::consts::PI {
    // rust: -cos
    // rust: } else {
    // rust: cos
    // rust: },
    // rust: )
}
    // rust: let (sx, cx) = sin_cos(x);
    // rust: let (sy, cy) = sin_cos(y);
    // rust: let (sz, cz) = sin_cos(z);
    // rust: let (cycz, sysz, sycz, cysz) = (cy * cz, sy * sz, sy * cz, cy * sz);
    // rust: let (w, x, y, z) = (
    // rust: cx * cycz + sx * sysz,
    // rust: sx * cycz - cx * sysz,
    // rust: cx * sycz + sx * cysz,
    // rust: cx * cysz - sx * sycz,
    // rust: );
    // rust: let (ww, xx, yy, zz) = (w * w, x * x, y * y, z * z);
    // rust: let (xy, xz, xw, yz, yw, zw) = (x * y, x * z, x * w, y * z, y * w, z * w);
    // rust: glam::Mat3::from_cols_array(&[
    // rust: ww + xx - zz - yy,
    // rust: (xy + xy) + (zw + zw),
    // rust: (xz + xz) - (yw + yw),
    // rust: (xy + xy) - (zw + zw),
    // rust: yy - zz + ww - xx,
    // rust: (yz + yz) + (xw + xw),
    // rust: (yw + yw) + (xz + xz),
    // rust: (yz + yz) - (xw + xw),
    // rust: zz - yy - xx + ww,
    // rust: ])
}
part :: proc(pose: [f32; 9]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.matrix *= Self::rotation(pose[3], pose[4], pose[5]);
    // rust: let scale = glam::Vec3::new(pose[6], pose[7], pose[8]);
    // rust: if scale.x.abs() == scale.y.abs() && scale.x.abs() == scale.z.abs() {
    // rust: if scale.min_element() < 0.0 {
    // rust: self.matrix *= glam::Mat3::from_diagonal(scale.signum());
}
    // rust: } else {
    // rust: self.matrix *= glam::Mat3::from_diagonal(scale.recip());
    // rust: self.trusted = false;
}
    // rust: self
}
}

Part :: struct {
    name: string,
    // x, y, z, xRot, yRot, zRot, xScale, yScale, zScale
    pose: [f32,
    polygons: [dynamic]Polygon,
    children: [dynamic]Part,
}
    // rust: impl Part {
    // Marks every polygon as drawn by a back-face-culling render type.
set_cull_back :: proc(self: ^Self) {
}
    // rust: for poly in &mut self.polygons {
    // rust: poly.cull_back = true;
}
    // rust: for child in &mut self.children {
    // rust: child.set_cull_back();
}
}
parse :: proc(name: string, v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let pose: Vec<f32> = v["pose"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|x| x.as_f64().unwrap_or(0.0) as f32)
    // rust: .collect();
    // rust: let mut p = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0];
    // rust: for (i, x) in pose.iter().enumerate().take(9) {
    // rust: p[i] = *x;
}
    // rust: let polygons: Vec<Polygon> = v["polygons"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .enumerate()
    // rust: .filter_map(|(index, poly)| {
    // rust: let verts: Vec<[f32; 5]> = poly
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|vx| {
    // rust: let a: Vec<f32> = vx
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|x| x.as_f64().unwrap_or(0.0) as f32)
    // rust: .collect();
    // rust: [a[0], a[1], a[2], a[3], a[4]]
    // rust: })
    // rust: .collect();
    // rust: (verts.len() == 4).then(|| Polygon {
    // rust: normal: v["normals"][index].as_array().map_or_else(
    // rust: || {
                            // shortcut: collapsed legacy faces have no recoverable normal; re-prepare resources.
    // rust: let p = verts
    // rust: .iter()
    // rust: .map(|v| glam::Vec3::new(v[0], v[1], v[2]))
    // rust: .collect::<Vec<_>>();
    // rust: (p[1] - p[0])
    // rust: .cross(p[2] - p[0])
    // rust: .normalize_or_zero()
    // rust: .to_array()
    // rust: },
    // rust: |n| std::array::from_fn(|i| n[i].as_f64().unwrap_or(0.0) as f32),
    // rust: ),
    // rust: vertices: [verts[0], verts[1], verts[2], verts[3]],
    // rust: cull_back: false,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut children: Vec<Part> = v["children"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(k, c)| Part::parse(k, c))
    // rust: .collect();
    // rust: children.sort_by(|a, b| a.name.cmp(&b.name));
        // A model whose root holds a part also named "root" (allay, vex,
        // frog...): that inner part is what `root.getChild("root")` and the
        // keyframe bones mean, so the outer one gives up the name.
    // rust: let name = if name == "root" && children.iter().any(|c| c.name == "root") {
    // rust: ""
    // rust: } else {
    // rust: name
}
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: pose: p,
    // rust: polygons,
    // rust: children,
}
}
}
// Kept for callers of the earlier simple AI; species now select behaviour.
Brain :: enum {
    Passive,
    Chicken,
    Zombie,
    Skeleton,
    Spider,
    Creeper,
}
// Model animation family (vanilla `EntityModel.setupAnim` implementations).
    // rust: pub use anim::Anim;
    // rust: pub use species::Species;

// Per-type behaviour switches derived from vanilla classes and tags.
Flags :: struct {
    // WaterAnimal / fish: not affected by fluid physics (swims with its own control).
    aquatic_swimmer: bool,
    fall_immune: bool,
    // FlyingMob-style travel (ghast, phantom): travelFlying without gravity.
    flying: bool,
    // Spiders: onClimbable while colliding horizontally.
    climber: bool,
    // Striders stand on lava.
    lava_walker: bool,
    // LivingEntity.omnidirectionalAirMover (bees and parrots).
    omnidirectional: bool,
    fire_immune: bool,
    // EntityTypeTags.BURN_IN_DAYLIGHT
    burns_in_day: bool,
    undead: bool,
    breathes_water: bool,
    // Drowns out of water (fish, squid, dolphins after their air runs out).
    needs_water: bool,
    // Hurt by water (endermen, blazes, striders out of lava, snow golems).
    water_sensitive: bool,
    animal: bool,
}

MobType :: struct {
    id: string,
    species: Species,
    width: f64,
    height: f64,
    eye_height: f64,
    category: string,
    max_health: f32,
    speed: f64,
    flying_speed: f64,
    attack_damage: f32,
    attack_knockback: f64,
    follow_range: f64,
    step_height: f64,
    armor: f32,
    armor_toughness: f32,
    knockback_resistance: f64,
    jump_strength: f64,
    // Every default attribute value of the type (`entity-types.json`).
    attributes: Arc<HashMap<string,
    // Item defaults used when loading inventory-bearing mobs before a Game exists.
    item_stack_limits: Arc<HashMap<string,
    gravity: f64,
    safe_fall_distance: f64,
    fall_damage_multiplier: f64,
    water_efficiency: f64,
    water_slowdown: f32,
    // Air speed for travelFlying mobs (ghast 0.02, phantom 0.2).
    air_speed: f32,
    baby_scale: f64,
    head_rot_speed: f32,
    max_head_x_rot: f32,
    max_head_y_rot: f32,
    ambient_interval: i32,
    flags: Flags,
    model: ^Part,
    // Every baked layer of this entity's models keyed by `model#layer`
    // (e.g. `sheep#wool`, `zombie_baby#main`).
    layers: crate::fast_hash::FxHashMap<string,
    texture: string,
    brain: Brain,
    anim: Anim,
    // Ambient, hurt and death sound events (without the namespace).
    sounds: [^'static str,
    step_sound: Maybe(^'static str),
    // Animal.isFood items (resolved from the item tag).
    food: ^[string],
    // TemptGoal items when they differ from the food.
    tempt: ^[string],
}
    // rust: impl MobType {
inventory_stack_limit :: proc(self: ^Self, stack: ^crate::items::ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:max_stack_size"))
    // rust: .and_then(|t| match t {
    // rust: horizon_world::nbt::Tag::Int(n) => u32::try_from(*n).ok(),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or_else(|| {
    // rust: self.item_stack_limits
    // rust: .get(stack.item.as_ref())
    // rust: .copied()
    // rust: .unwrap_or(64)
    // rust: })
}

layer :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.get(key)
}

    // The vanilla entity type whose class this type's mobs are: the type
    // itself, or the template a content mod's living type copies. What a
    // class saves and syncs of its own (`Zombie.addAdditionalSaveData`, its
    // entity data) follows it; the saved and sent id stays [`Self::id`].
class_id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.id.starts_with("minecraft:") {
    // rust: &self.id
    // rust: } else {
    // rust: species::vanilla_id(self.species)
}
}
}
// Each type's default attribute values, parsed exactly (serde_json's
// default float parsing can miss the nearest double by one ulp).
    // rust: pub(crate) fn exact_attributes(bytes: &[u8]) -> HashMap<String, HashMap<String, f64>> {
//     use serde_json::value::RawValue;
    // rust: type Raw = HashMap<String, Box<RawValue>>;
    // rust: let Ok(types) = serde_json::from_slice::<Raw>(bytes) else {
    // rust: return HashMap::new();
}
    // rust: types
    // rust: .into_iter()
    // rust: .filter_map(|(id, t)| {
    // rust: let t: Raw = serde_json::from_str(t.get()).ok()?;
    // rust: let attrs: Raw = serde_json::from_str(t.get("attributes")?.get()).ok()?;
    // rust: let values = attrs
    // rust: .into_iter()
    // rust: .filter_map(|(k, v)| v.get().trim().parse::<f64>().ok().map(|v| (k, v)))
    // rust: .collect();
    // rust: Some((id, values))
    // rust: })
    // rust: .collect()
}

// The models that draw with `RenderTypes::entityCutoutCull`.
culls_back_faces :: proc(key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(key, "minecraft:bat#main" | "minecraft:turtle_baby#main")
}

MobTypes :: struct {
    types: HashMap<string,
}
    // rust: impl MobTypes {
load :: proc(root: ^Path) -> c {
    // Ported from Horizon
    return {}
}
    // rust: Self::load_with_models(root, true)
}

    // The dedicated server needs entity facts and AI, but never their render
    // geometry. Keep one empty part for the fields shared with the client
    // rather than parsing and retaining every entity-model layer.
load_for_server :: proc(root: ^Path) -> c {
    // Ported from Horizon
    return {}
}
    // rust: Self::load_with_models(root, false)
}

load_with_models :: proc(root: ^Path, models_needed: bool) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = fs::read(root.join("entity-types.json"))?;
    // rust: let types: Value = serde_json::from_slice(&bytes)?;
    // rust: let exact = exact_attributes(&bytes);
    // rust: let models = models_needed
    // rust: .then(|| -> crate::Result<Value> {
    // rust: Ok(serde_json::from_slice(&fs::read(
    // rust: root.join("entity-models.json"),
    // rust: )?)?)
    // rust: })
    // rust: .transpose()?;
    // rust: let empty_model = Arc::new(Part::parse("root", &Value::Null));
    // rust: let item_tags =
    // rust: crate::items::load_tags(root, "item", &horizon_world::loot::PackOverlay::NONE)
    // rust: .unwrap_or_default();
    // rust: sulfur_cube::load_archetype_items(&item_tags);
    // rust: let tag = |name: &str| -> Arc<[String]> {
    // rust: let mut v: Vec<String> = item_tags
    // rust: .get(&format!("minecraft:{name}"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .cloned()
    // rust: .collect();
    // rust: v.sort();
    // rust: v.into()
}
        // The Allay's InventoryCarrier loading needs item limits before a
        // Game exists. Other mob-only resource sets need no item data.
    // rust: let items: HashMap<String, Value> = if types.get("minecraft:allay").is_some() {
    // rust: serde_json::from_slice(&fs::read(root.join("items.json"))?)?
    // rust: } else {
    // rust: HashMap::new()
}
    // rust: let item_stack_limits: Arc<HashMap<String, u32>> = Arc::new(
    // rust: items
    // rust: .into_iter()
    // rust: .map(|(id, components)| {
    // rust: (
    // rust: id,
    // rust: components["minecraft:max_stack_size"]
    // rust: .as_u64()
    // rust: .unwrap_or(64) as u32,
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: let mut out = HashMap::new();
        // A content mod's living type (its row names a vanilla `template`) is
        // its template's mob under its own id: the template's model, sounds
        // and behaviour, with the attributes its row has.
    // rust: let mod_types = types
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|(id, row)| {
    // rust: let template = row["template"].as_str()?.strip_prefix("minecraft:")?;
    // rust: let def = species::ALL.iter().find(|d| d.name == template)?;
    // rust: Some((id.clone(), def))
    // rust: });
    // rust: let vanilla = species::ALL
    // rust: .iter()
    // rust: .map(|def| (format!("minecraft:{}", def.name), def));
    // rust: for (id, def) in vanilla.chain(mod_types) {
    // rust: let t = &types[&id];
    // rust: if t.is_null() {
    // rust: continue;
}
    // rust: let model_key = format!("minecraft:{}", def.model);
    // rust: let model = models.as_ref().and_then(|models| models.get(&model_key));
    // rust: if models_needed && model.is_none() {
    // rust: continue;
}
    // rust: let defaults = exact.get(&id).cloned().unwrap_or_default();
    // rust: let attr = |k: &str| defaults.get(&format!("minecraft:{k}")).copied();
    // rust: let mut layers = crate::fast_hash::FxHashMap::default();
    // rust: if let Some(all) = models.as_ref().and_then(Value::as_object) {
    // rust: for prefix in def.layer_prefixes() {
    // rust: let start = format!("minecraft:{prefix}#");
    // rust: for (k, v) in all.iter().filter(|(k, _)| k.starts_with(&start)) {
    // rust: let mut part = Part::parse("root", v);
    // rust: if culls_back_faces(k) {
    // rust: part.set_cull_back();
}
    // rust: layers.insert(
    // rust: k.trim_start_matches("minecraft:").to_owned(),
    // rust: Arc::new(part),
    // rust: );
}
}
}
    // rust: let category = t["category"].as_str().unwrap_or("creature").to_owned();
    // rust: let speed = attr("movement_speed").unwrap_or(0.25);
    // rust: let flags = def.flags(t["fire_immune"].as_bool().unwrap_or(false));
    // rust: out.insert(
    // rust: id.clone(),
    // rust: MobType {
    // rust: species: def.species,
    // rust: item_stack_limits: item_stack_limits.clone(),
    // rust: width: t["width"].as_f64().unwrap_or(0.6),
    // rust: height: t["height"].as_f64().unwrap_or(1.8),
    // rust: eye_height: t["eye_height"].as_f64().unwrap_or(1.6),
    // rust: max_health: attr("max_health").unwrap_or(10.0) as f32,
    // rust: speed,
    // rust: flying_speed: attr("flying_speed").unwrap_or(0.4),
    // rust: attack_damage: attr("attack_damage").unwrap_or(0.0) as f32,
    // rust: attack_knockback: attr("attack_knockback").unwrap_or(0.0),
    // rust: follow_range: attr("follow_range").unwrap_or(16.0),
    // rust: step_height: attr("step_height").unwrap_or(0.6),
    // rust: armor: attr("armor").unwrap_or(0.0) as f32,
    // rust: armor_toughness: attr("armor_toughness").unwrap_or(0.0) as f32,
    // rust: knockback_resistance: attr("knockback_resistance").unwrap_or(0.0),
    // rust: jump_strength: attr("jump_strength").unwrap_or(0.42),
    // rust: attributes: Arc::new(defaults.clone()),
    // rust: gravity: attr("gravity").unwrap_or(0.08),
    // rust: safe_fall_distance: attr("safe_fall_distance").unwrap_or(3.0),
    // rust: fall_damage_multiplier: attr("fall_damage_multiplier").unwrap_or(1.0),
    // rust: water_efficiency: attr("water_movement_efficiency").unwrap_or(0.0),
    // rust: water_slowdown: def.water_slowdown(),
    // rust: air_speed: def.air_speed(),
    // rust: baby_scale: def.baby_scale(),
    // rust: head_rot_speed: def.head_rot_speed(),
    // rust: max_head_x_rot: def.max_head_x_rot(),
    // rust: max_head_y_rot: def.max_head_y_rot(),
    // rust: ambient_interval: def.ambient_interval(),
    // rust: flags,
    // rust: model: model.map_or_else(
    // rust: || empty_model.clone(),
    // rust: |model| {
    // rust: Arc::new({
    // rust: let mut part = Part::parse("root", model);
    // rust: if culls_back_faces(&model_key) {
    // rust: part.set_cull_back();
}
    // rust: part
    // rust: })
    // rust: },
    // rust: ),
    // rust: layers,
    // rust: texture: def.texture.to_owned(),
    // rust: brain: def.brain(),
    // rust: anim: def.anim,
    // rust: sounds: def.sounds,
    // rust: step_sound: def.step_sound,
    // rust: food: def
    // rust: .food_tag()
    // rust: .map(tag)
    // rust: .unwrap_or_else(|| Arc::from(Vec::new())),
    // rust: tempt: def
    // rust: .tempt_tag()
    // rust: .or(def.food_tag())
    // rust: .map(tag)
    // rust: .unwrap_or_else(|| Arc::from(Vec::new())),
    // rust: category,
    // rust: id,
    // rust: },
    // rust: );
}
    // rust: Ok(Self { types: out })
}
}
    // rust: pub use horizon_client_core::who::Who;
// A native damage type's registry name and the tags consumed by mob combat.
//
// Native code supplies a static name (no interning or leaked runtime strings)
// and flags matching its data-pack damage tags. Register the same name/data for
// player damage, death messages and loot predicates. Unset tags are false.
NamedDamage :: struct {
    name: ^'static str,
    tags: u32,
}
    // rust: impl NamedDamage {
IS_FIRE :: 1 << 0
BYPASSES_ARMOR :: 1 << 1
NO_KNOCKBACK :: 1 << 2
BYPASSES_INVULNERABILITY :: 1 << 3
BYPASSES_EFFECTS :: 1 << 4
BYPASSES_RESISTANCE :: 1 << 5
PANIC_CAUSES :: 1 << 6
IS_PROJECTILE :: 1 << 7
IS_EXPLOSION :: 1 << 8
IS_FALL :: 1 << 9

    // rust: pub const fn new(name: &'static str, tags: u32) -> Self {
    // rust: Self { name, tags }
}
    // rust: pub const fn has(self, tag: u32) -> bool {
    // rust: self.tags & tag != 0
}
}
DamageKind :: enum {
    // A registered native damage type; vanilla kinds keep their existing tags.
    Named(NamedDamage),
    PlayerAttack,
    // `mace_smash`: a mace hit after a fall (the player attack tags too).
    MaceSmash,
    // `spear`: a stab of a spear (the player attack tags too).
    Spear,
    MobAttack,
    Arrow,
    Thrown,
    Fireball,
    Explosion,
    Fall,
    FallingBlock,
    FallingStalactite,
    OnFire,
    InFire,
    // `campfire`: standing in a lit campfire (`CampfireBlock.entityInside`).
    Campfire,
    Lava,
    Drown,
    // `dry_out`: an axolotl out of water for too long.
    DryOut,
    Magic,
    // `indirect_magic`: a thrown potion's hit (`DamageSources.indirectMagic`),
    // which, unlike `magic`, knocks back.
    IndirectMagic,
    Sting,
    Cactus,
    // `sweet_berry_bush`.
    SweetBerryBush,
    Generic,
    InWall,
    Thorns,
    SonicBoom,
    // `freeze`: a fully frozen mob in powder snow.
    Freeze,
    // `fell_out_of_world`: below the world's floor.
    OutOfWorld,
    // `cramming`: crushed by the mobs around it.
    Cramming,
    // `falling_anvil`: an anvil landing on it (it damages a helmet).
    FallingAnvil,
    // `fireworks`: a firework rocket's burst (an explosion for Blast Protection).
    Fireworks,
    // `generic_kill`: a kill that bypasses invulnerability.
    GenericKill,
    // `lightning_bolt`.
    LightningBolt,
    // `outside_border`: past the world border.
    OutsideBorder,
    // `spit`: a llama's spit.
    Spit,
    // `stalagmite`: a fall onto a stalagmite (a fall for Feather Falling).
    Stalagmite,
    // `starve`: no food left.
    Starve,
    // `hot_floor`: stepping on a magma block.
    HotFloor,
    // `sulfur_cube_hot`: a sulfur cube's hot floor (a fire).
    SulfurCubeHot,
    // `wind_charge`: a wind charge's burst (a projectile).
    WindCharge,
    // `wither`: the wither effect.
    Wither,
    // `wither_skull`: an owned wither skull's hit (`DamageSources.witherSkull`).
    WitherSkull,
}
    // rust: impl DamageKind {
    // DamageTypeTags.BYPASSES_INVULNERABILITY
bypasses_invulnerability :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Self::Named(named) = self {
    // rust: return named.has(NamedDamage::BYPASSES_INVULNERABILITY);
}
    // rust: matches!(self, DamageKind::OutOfWorld | DamageKind::GenericKill)
}
    // DamageTypeTags.BYPASSES_EFFECTS
bypasses_effects :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Self::Named(named) = self {
    // rust: return named.has(NamedDamage::BYPASSES_EFFECTS);
}
    // rust: matches!(self, DamageKind::Starve)
}
    // DamageTypeTags.BYPASSES_RESISTANCE
bypasses_resistance :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Self::Named(named) = self {
    // rust: return named.has(NamedDamage::BYPASSES_RESISTANCE);
}
    // rust: matches!(self, DamageKind::OutOfWorld | DamageKind::GenericKill)
}
}
// `source.getEntity()` of a blow, as `SulfurCube.knockback` reads it: `getEyePosition()`,
// `getLookAngle()` and `position()`.
Aim :: struct {
    eye: [f64,
    look: [f64,
    feet: [f64,
}
// A damage source: its type, the attacking entity and where it came from.
Damage :: struct {
    kind: DamageKind,
    attacker: Maybe(Who),
    from: Option<[f64,
    attacker_species: Maybe(Species),
}
    // rust: impl Damage {
fall :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::Fall,
    // rust: attacker: None,
    // rust: from: None,
    // rust: attacker_species: None,
}
}
of :: proc(kind: DamageKind) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind,
    // rust: attacker: None,
    // rust: from: None,
    // rust: attacker_species: None,
}
}
player :: proc(from: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::PlayerAttack,
    // rust: attacker: Some(Who::Player),
    // rust: from: Some(from),
    // rust: attacker_species: None,
}
}
    // `DamageSources.mace`: a player's smash attack.
mace :: proc(from: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::MaceSmash,
    // rust: attacker: Some(Who::Player),
    // rust: from: Some(from),
    // rust: attacker_species: None,
}
}
    // `DamageSources.spear`: a player's stab with a spear.
spear :: proc(from: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::Spear,
    // rust: attacker: Some(Who::Player),
    // rust: from: Some(from),
    // rust: attacker_species: None,
}
}
    // `DamageSources.indirectMagic(potion, owner)`: `attacker` is the owner
    // (none for a dispenser's potion), `from` the potion's position, which
    // the knockback pushes away from.
indirect_magic :: proc(attacker: Maybe(Who), from: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::IndirectMagic,
    // rust: attacker,
    // rust: from: Some(from),
    // rust: attacker_species: None,
}
}
    // `DamageSources.fireworks(rocket, owner)`: `attacker` is the owner
    // (none for a rocket nobody fired), `from` the rocket's position, which
    // the knockback pushes away from (`calculateHorizontalHurtKnockbackDirection`).
fireworks :: proc(attacker: Maybe(Who), from: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::Fireworks,
    // rust: attacker,
    // rust: from: Some(from),
    // rust: attacker_species: None,
}
}
mob :: proc(id: u32, from: [f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: DamageKind::MobAttack,
    // rust: attacker: Some(Who::Mob(id)),
    // rust: from: Some(from),
    // rust: attacker_species: None,
}
}
with_species :: proc(species: Species) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.attacker_species = Some(species);
    // rust: self
}
    // DamageTypeTags.PANIC_CAUSES
causes_panic :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let DamageKind::Named(named) = self.kind {
    // rust: return named.has(NamedDamage::PANIC_CAUSES);
}
    // rust: !matches!(
    // rust: self.kind,
    // rust: DamageKind::Fall
    // rust: | DamageKind::Drown
    // rust: | DamageKind::DryOut
    // rust: | DamageKind::Generic
    // rust: | DamageKind::InWall
    // rust: | DamageKind::SweetBerryBush
    // rust: | DamageKind::OutOfWorld
    // rust: | DamageKind::FallingBlock
    // rust: | DamageKind::FallingAnvil
    // rust: | DamageKind::Cramming
    // rust: | DamageKind::GenericKill
    // rust: | DamageKind::OutsideBorder
    // rust: | DamageKind::Spit
    // rust: | DamageKind::Stalagmite
    // rust: | DamageKind::Starve
    // rust: | DamageKind::Campfire
    // rust: )
}
    // DamageTypeTags.BYPASSES_ARMOR
bypasses_armor :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let DamageKind::Named(named) = self.kind {
    // rust: return named.has(NamedDamage::BYPASSES_ARMOR);
}
    // rust: matches!(
    // rust: self.kind,
    // rust: DamageKind::Fall
    // rust: | DamageKind::OnFire
    // rust: | DamageKind::Drown
    // rust: | DamageKind::Magic
    // rust: | DamageKind::IndirectMagic
    // rust: | DamageKind::InWall
    // rust: | DamageKind::Generic
    // rust: | DamageKind::SonicBoom
    // rust: | DamageKind::Freeze
    // rust: | DamageKind::OutOfWorld
    // rust: | DamageKind::Cramming
    // rust: | DamageKind::GenericKill
    // rust: | DamageKind::OutsideBorder
    // rust: | DamageKind::Stalagmite
    // rust: | DamageKind::Starve
    // rust: | DamageKind::Wither
    // rust: )
}
is_fire :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let DamageKind::Named(named) = self.kind {
    // rust: return named.has(NamedDamage::IS_FIRE);
}
    // rust: matches!(
    // rust: self.kind,
    // rust: DamageKind::OnFire
    // rust: | DamageKind::InFire
    // rust: | DamageKind::Campfire
    // rust: | DamageKind::HotFloor
    // rust: | DamageKind::Lava
    // rust: | DamageKind::Fireball
    // rust: | DamageKind::SulfurCubeHot
    // rust: )
}
    // DamageTypeTags.NO_KNOCKBACK
no_knockback :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let DamageKind::Named(named) = self.kind {
    // rust: return named.has(NamedDamage::NO_KNOCKBACK);
}
    // rust: matches!(
    // rust: self.kind,
    // rust: DamageKind::Explosion
    // rust: | DamageKind::Fall
    // rust: | DamageKind::OnFire
    // rust: | DamageKind::InFire
    // rust: | DamageKind::Campfire
    // rust: | DamageKind::HotFloor
    // rust: | DamageKind::Lava
    // rust: | DamageKind::Drown
    // rust: | DamageKind::DryOut
    // rust: | DamageKind::Magic
    // rust: | DamageKind::Cactus
    // rust: | DamageKind::SweetBerryBush
    // rust: | DamageKind::Generic
    // rust: | DamageKind::InWall
    // rust: | DamageKind::Freeze
    // rust: | DamageKind::OutOfWorld
    // rust: | DamageKind::LightningBolt
    // rust: | DamageKind::Cramming
    // rust: | DamageKind::GenericKill
    // rust: | DamageKind::OutsideBorder
    // rust: | DamageKind::Stalagmite
    // rust: | DamageKind::Starve
    // rust: | DamageKind::SulfurCubeHot
    // rust: | DamageKind::Wither
    // rust: | DamageKind::Spear
    // rust: )
}
is_projectile :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let DamageKind::Named(named) = self.kind {
    // rust: return named.has(NamedDamage::IS_PROJECTILE);
}
    // rust: matches!(
    // rust: self.kind,
    // rust: DamageKind::Arrow
    // rust: | DamageKind::Thrown
    // rust: | DamageKind::Fireball
    // rust: | DamageKind::WindCharge
    // rust: | DamageKind::WitherSkull
    // rust: )
}
}
// Per-mob attribute base values (the type's defaults unless changed).
Attrs :: struct {
    speed: f64,
    attack_damage: f32,
    // `Attributes.ATTACK_KNOCKBACK`: what a melee hit adds to its push (half of it).
    attack_knockback: f64,
    max_health: f32,
    follow_range: f64,
    knockback_resistance: f64,
    spawn_reinforcements: f64,
    jump_strength: f64,
}
// `minecraft:wolf_armor`'s maximum damage.
WOLF_ARMOR_DURABILITY :: 64
// `NeutralMob.readPersistentAngerSaveData`: the anger runs until its end
// time, so a mob that is loaded again is angry for what is left of it.
anger_left :: proc(anger_end: i64, game_time: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if anger_end <= 0 {
    // rust: return 0;
}
    // rust: (anger_end - game_time).clamp(0, i64::from(i32::MAX)) as i32
}

// Species-specific persistent state (variants, colours, taming, ageing...).
Extra :: struct {
    // Saved fish/axolotl bucket flag; tadpoles save a constant true value.
    from_bucket: bool,
    // Command-created armor instances, shared by commands and runtime damage.
    armor_attributes: Maybe(^horizon_world::attributes::entity::EntityAttributes),
    // `Mob.lootTable`: the table its death rolls instead of its type's
    // (saved as `DeathLootTable`).
    death_loot_table: Maybe(string),
    // `Mob.lootTableSeed` (`DeathLootTableSeed`): 0 for none.
    death_loot_seed: i64,
    // `Rabbit.moreCarrotTicks`: how long it is full of carrots (saved as `MoreCarrotTicks`).
    more_carrot_ticks: i32,
    // `Ocelot.DATA_TRUSTING`: it no longer runs from players.
    trusting: bool,
    // `Mannequin.DATA_IMMOVABLE`: it neither moves nor falls (`isEffectiveAi` is false).
    immovable: bool,
    // `Mannequin.DATA_DESCRIPTION`: the text under its name.
    description: MannequinDescription,
    // `LivingEntity`'s `minecraft:scale` (`getScale`), which scales its box
    // (`getDimensions`), eye height and model (`LivingEntityRenderState.scale`):
    // the local player's own, and on a server every living entity's from its
    // attribute updates; 0 is the default, 1 (`Mob::model_scale`).
    model_scale: f32,
    // Players: crouching and riding (HumanoidModel's poses).
    crouching: bool,
    // A player's or mannequin's synced pose (`Entity.DATA_POSE`), which
    // sets its box (`Avatar.POSES`).
    avatar_pose: crate::pose::Pose,
    // `Entity.isSprinting` (`Entity.DATA_SHARED_FLAGS_ID`'s flag 3): the dust a
    // player raises; a cat or ocelot dashing (`Cat/Ocelot.customServerAiStep`),
    // which `LivingEntity.setSprinting`'s speed modifier makes faster.
    sprinting: bool,
    passenger: bool,
    // AgeableMob.age: negative while a baby (a tadpole counts up to 24000).
    age: i32,
    // `AgeLocked` (tadpoles fed a slime ball... and ageable mobs).
    age_locked: bool,
    // `AgeableMob.ageLockParticleTimer` (a tadpole's too): the ticks of
    // growth particles left after a golden dandelion, and the cooldown
    // before the next one can be used. Not saved.
    age_lock_particle_timer: i32,
    // AgeableMob.forcedAge: the age fed food added, restored as the age
    // when it reaches 0 (`ForcedAge`).
    forced_age: i32,
    // AgeableMob.forcedAgeTimer: ticks of happy villager particles left.
    forced_age_timer: i32,
    in_love: i32,
    love_player: bool,
    // Texture/model variant index (cat type, horse colour, rabbit type...).
    variant: u8,
    // Secondary variant (horse markings, tropical fish pattern colours, panda hidden gene).
    variant2: u8,
    variant3: u8,
    // `MushroomCow.stewEffects`: what a brown one took from a flower, given
    // back in its next bowl of stew. `None` is vanilla's null.
    stew_effects: Option<[dynamic](Arc<str,
    // Dye colour id (sheep wool, collars).
    color: u8,
    // `Fox.DATA_TRUSTED_ID_0` and `_1`: the players a fox trusts, first free
    // slot first, and a third replaces the second (`Fox.addTrustedEntity`).
    trusted: [Option<[i32,
    // `Animal.LoveCause`: the player who fed this animal into love, which a
    // fox's breeding hands to its baby as trust (`Fox.FoxBreedGoal.breed`).
    love_cause: Option<[i32,
    sheared: bool,
    // `Mob.canPickUpLoot` (also lets dispensers equip it).
    pick_up_loot: bool,
    saddled: bool,
    // The durability a wolf's body armor (`extra.body`) has lost.
    body_damage: i32,
    // The components (dye, name...) of that armor stack.
    body_extra: Maybe(^crate::item_data::StackData),
    // `Cat.RELAX_STATE_ONE`: watching a sleeping owner before lying down.
    relax_one: bool,
    // `Cat.isLyingOnTopOfSleepingPlayer` (the client's own, from `Cat.handleLieDown`).
    on_sleeper: bool,
    // The saddle's components (name, enchantments...) when it is not a bare
    // one; `saddled` stays the gameplay flag.
    saddle_stack: Maybe(crate::items::ItemStack),
    chested: bool,
    // The chest contents of a donkey or mule (15 slots).
    items: [dynamic]Maybe(crate::items::ItemStack),
    // `Piglin.inventory` (`SimpleContainer(8)`): what it picked up and kept.
    inventory: [dynamic]crate::items::ItemStack,
    tame: bool,
    sitting: bool,
    // `Parrot.partyParrot` and `jukebox`: the playing jukebox it dances to.
    party_jukebox: Option<[i32,
    // The owner's UUID (tamed animals).
    owner: Option<[i32,
    // Slime/magma cube size (0 = not sized).
    size: i32,
    // Sheep eat-grass / iron golem attack / ravager animation ticks.
    anim_ticks: i32,
    egg_time: i32,
    anger: i32,
    // `NeutralMob.getPersistentAngerEndTime`: the absolute game time the
    // anger ends at, -1 when the mob is calm. The save keeps it, so the
    // anger goes on while the chunk is unloaded.
    anger_end: i64,
    // `NeutralMob.getPersistentAngerTarget`: the entity the mob is angry
    // at, which the save keeps with it.
    angry_at: Maybe(Who),
    // `IronGolem.isPlayerCreated` (`PlayerCreated`): built from blocks.
    player_created: bool,
    carried: Maybe(horizon_world::registry::BlockStateId),
    charged: bool,
    // Held item ids (main hand, off hand) and head item.
    main_hand: Maybe(^str),
    // Components of the current held stack; setters clear these on replacement.
    main_hand_stack: Maybe(crate::items::ItemStack),
    off_hand: Maybe(^str),
    // The head item (`getItemBySlot(HEAD)`), on every mob.
    head: Maybe(^str),
    // The body item (`getItemBySlot(BODY)`): a horse's armour, a llama's
    // carpet, a wolf's armour, a harness, a sulfur cube's swallowed block.
    body: Maybe(^str),
    // Worn armour below the head (humanoid mobs).
    chest: Maybe(^str),
    legs: Maybe(^str),
    feet: Maybe(^str),
    // The worn armour stacks (head to feet): the dyed colour and the
    // trim of a piece are on the stack, not on its id.
    armor: [Maybe(crate::items::ItemStack),
    using_item: i32,
    using_off_hand: bool,
    // `LivingEntity.recentKineticEnemies`: when the entities this mob's
    // spear stabbed in the current use were stabbed (game time). It exists
    // only while a kinetic weapon is in use.
    stabbed: Option<Vec<(Who,
    blocking: bool,
    fall_flying: bool,
    fall_fly_ticks: i32,
    // `Entity.deltaMovementOnPreviousTick`: the velocity before this tick's
    // move, which the elytra lean interpolates from (`getDeltaMovementLerped`).
    previous_velocity: Vec3,
    // `Entity.DATA_POSE` of another player, as the server sent it.
    synced_pose: u8,
    // `LivingEntity.isAutoSpinAttack` (Riptide).
    auto_spin_attack: bool,
    // `LivingEntity.DATA_ARROW_COUNT_ID`: the arrows stuck in a player
    // (`ArrowLayer`).
    arrow_count: i32,
    // `LivingEntity.DATA_STINGER_COUNT_ID`: the bee stingers stuck in a
    // player (`BeeStingerLayer`).
    stinger_count: i32,
    // `Player.DATA_SHOULDER_PARROT_LEFT` and `_RIGHT`: the variant of the
    // parrot on each shoulder (`ParrotOnShoulderLayer`).
    shoulder_parrots: [Maybe(i32),
    main_hand_left: bool,
    // The skin layers a player hides (`PlayerModelPart` bits, set to
    // `Avatar.DATA_PLAYER_MODE_CUSTOMISATION` inverted); 0 shows all.
    hidden_model_parts: u8,
    // `AvatarRenderState.isSpectator`: a player in spectator mode shows only its head.
    spectator: bool,
    elytra: ElytraAnimation,
    swim: SwimAnimation,
    // `ClientAvatarState` of a player: the cloak, bob and walked distance its cape swings with.
    avatar: crate::camera::AvatarBob,
    // The arm the current swing moves (`currentSwing.hand().asArm`): `Some(true)`
    // for the right arm.
    swing_right_arm: Maybe(bool),
    // The current swing is a STAB (`SwingAnimationType` 2): a spear's jab.
    swing_stab: bool,
    flag: bool,
    flag2: bool,
    // `AbstractHorse`'s `Bred` save flag: nothing sets it at runtime (no
    // vanilla code calls `setBred` outside `readAdditionalSaveData`), so only
    // a save or `/summon` gives it, and `followMommy` reads it.
    bred: bool,
    // `Hoglin`'s `CannotBeHunted` save flag: a bastion's own hoglins have it,
    // so its piglins leave them alone (`Hoglin.canBeHunted`).
    cannot_be_hunted: bool,
    // `AbstractHorse.allowStandSliding`: the rider's jump sets it, and a
    // horse still rearing then goes on with the rider's keys until the rear
    // ends (`tick` clears it).
    stand_sliding: bool,
    // Species scratch values (the wither's head targets and clocks).
    ints: [i32,
    counter: i32,
    counter2: i32,
    home: Option<[i32,
    // A copper golem's `openedChestPos`.
    opened_chest: Option<[i32,
    point: Option<[f64,
    // `NEAREST_REPELLENT`: the nearest repelling block a hoglin or piglin
    // sensed, looked up every 20 ticks.
    repellent: Option<[i32,
    vector: [f64,
    // Active status effects: (effect id, ticks left, amplifier).
    effects: Vec<(^'static str,
    // The effects above given with `hideParticles`: no swirls for them.
    hidden_effects: [dynamic]^'static str,
    // The effects above that are ambient (`MobEffectInstance.isAmbient`: a beacon's), whose swirls
    // are faint.
    ambient_effects: [dynamic]^'static str,
    // `LivingEntity.DATA_EFFECT_PARTICLES` and `DATA_EFFECT_AMBIENCE_ID` as a
    // server gave them: the swirls around it, and whether they are all faint.
    effect_particles: [dynamic]crate::particles::ParticleOptions,
    effect_ambient: bool,
    // An invisible illusioner's mirror images.
    illusions: Maybe(illusioner::Illusions),
    // A villager's claimed bed head and meeting bell.
    bed: Option<[i32,
    meeting: Option<[i32,
    // Villager and wandering trader offers and experience.
    trade: Maybe(^crate::merchant::Trader),
    // Who holds this mob's lead, a holder not yet found after loading, and
    // the spin the rope's torque gives it.
    leash: Maybe(leash::Holder),
    leash_pending: Maybe(leash::Pending),
    // The UUID of the player behind `Holder::Player` (host or guest).
    leash_player: Option<[i32,
    leash_spin: f64,
    // More species scratch values.
    scratch: [i32,
    // Block positions a species remembers (a sniffer's explored ground).
    positions: Vec<[i32,
    // A warden's brain, anger and vibrations.
    warden: Maybe(^warden::Warden),
    // An allay's vibration listener and liked note block.
    allay: Maybe(^allay::State),
    // A raider's patrol and raid state.
    raider: Maybe(^raider::State),
    // A villager's raid activity and gossip.
    villager: Maybe(^villager::Ext),
    // The sniffer's and the ghastling's brain.
    animal_brain: Maybe(^animal_brain::Brain),
    axolotl: axolotl::Animation,
    // The mob or boat this one rides, and the mob riding it (`getVehicle`,
    // `getFirstPassenger`).
    mount: Maybe(u32),
    rider: Maybe(u32),
    // `Entity.boardingCooldown`: ticks after leaving a boat before a boat
    // can pick this mob up again.
    boarding_cooldown: i32,
    // A chicken carrying a zombie (`IsChickenJockey`).
    jockey: bool,
    // A skeleton horse waiting to spring its trap, and how long it has waited.
    trap: bool,
    trap_time: i32,
    // Enchantments on the equipment above.
    gear: Maybe(^gear::Gear),
    // `Mob.dropChances` by `EquipmentSlot` (`drops::SLOTS` order) when set
    // explicitly; None uses the defaults of `drops::drop_chance`.
    drop_chances: Option<Box<[f32,
    // `Mob.leftHanded`.
    left_handed: bool,
    // The sound variant: index in the species' `*_sound_variant` registry
    // (`finalize::sound_variants`); None is the default, `classic`.
    sound_variant: Maybe(u8),
    // `Zombie.canBreakDoors`.
    can_break_doors: bool,
    // A goat's `IsScreamingGoat` and the horns it lost (left, right).
    screaming: bool,
    lost_horns: [bool,
    // A goat's lowered head and ram behaviours.
    goat: goat::State,
    // Attribute bases and permanent modifiers set by `finalizeSpawn`.
    attributes: Maybe(^finalize::Attributes),
    // Brain memories `finalizeSpawn` sets: (memory, value, ticks to expiry).
    memories: Vec<(^'static str,
    // A camel's `LAST_POSE_CHANGE_TICK`.
    pose_change_tick: i64,
    // Whether a camel sits (`egg_time` is then the age it sat down at).
    camel_sitting: bool,
    // `Entity.DATA_POSE` as a mob of a server has it (`sync::pose_id`).
    pose: u8,
    // The school leader a fish follows, and a tropical fish that swims alone.
    leader: Maybe(u32),
    lone: bool,
    // The fish that follow this one (`AbstractSchoolingFish.schoolSize` - 1).
    followers: i32,
    // The entity section it is in and when it entered it (a global sequence):
    // vanilla's entity queries list the entities of a section in the order they
    // entered it, the sections by x, z, y.
    section: [i32,
    section_seq: u64,
    // A breeze's or creaking's brain (`monster_brain`).
    brain: Maybe(^monster_brain::Brain),
    // A bee's nectar, anger, flower and hive state.
    bee: Maybe(^bee::Bee),
    // An armadillo's state and scare brain.
    armadillo: armadillo::State,
    // A frog's brain memories and tongue target.
    frog: frog::State,
    // A panda's flags, counters and amounts.
    panda: Maybe(^panda::State),
    // What a piglin's or hoglin's brain remembers: its avoid target, the
    // adults its sensor sees and the activity it is in.
    piglin: piglin::Memories,
    // What the native mods last heard it hold and wear
    // (`LivingEntity.lastEquipmentItems`, empty at first), by
    // `EquipmentSlot` ordinal: see `Mob::equipment_stacks`.
    equipment_heard: Maybe(Box<[Option<crate::items::ItemStack),
}
    // rust: impl Extra {
set_main_hand :: proc(self: ^Self, item: Maybe(^str)) {
}
    // rust: self.main_hand = item;
    // rust: self.main_hand_stack = None;
}
set_main_hand_stack :: proc(self: ^Self, stack: Maybe(crate::items::ItemStack)) {
}
    // rust: self.main_hand = stack.as_ref().map(|s| s.item.clone());
    // rust: self.main_hand_stack = stack;
}
main_hand_stack :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.main_hand_stack
    // rust: .as_ref()
    // rust: .filter(|s| self.main_hand.as_ref() == Some(&s.item))
}
take_main_hand :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.main_hand_stack = None;
    // rust: self.main_hand.take()
}
}

// How far the boxes of a set of mobs reach from their positions: the widest half width and the
// tallest height among them. A box query over many mobs (a vehicle's, against every mob of the
// level) tests each mob's position against this first, and works out the box ([`Mob::bounds`],
// which reads the mob's whole size) only for the mobs whose position comes close.
BoxReach :: struct {
    half_width: f64,
    height: f64,
}
    // rust: impl BoxReach {
of :: proc(mobs: ^[Mob]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: mobs.iter().fold(Self::default(), |r, m| {
    // rust: let (width, height, _) = m.dims();
    // rust: Self {
    // rust: half_width: r.half_width.max(width / 2.0),
    // rust: height: r.height.max(height),
}
    // rust: })
}
    // Whether the box of `m`, one of the mobs this was worked out for, can meet `area`: a
    // superset, the caller still tests the box.
may_meet :: proc(self: ^Self, m: ^Mob, area: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi, p) = (area.min_position(), area.max_position(), m.position);
    // rust: p.x - self.half_width <= hi.x
    // rust: && p.x + self.half_width >= lo.x
    // rust: && p.z - self.half_width <= hi.z
    // rust: && p.z + self.half_width >= lo.z
    // rust: && p.y <= hi.y
    // rust: && p.y + self.height >= lo.y
}
}

Mob :: struct {
    // When it joined its list ([`crate::join_seq`]); set by the list, not by the spawn site.
    join: crate::join_seq::JoinSeq,
    id: u32,
    kind: ^MobType,
    position: Vec3,
    previous: Vec3,
    velocity: Vec3,
    // Entity.yRot (movement facing).
    yaw: f32,
    previous_yaw: f32,
    body_yaw: f32,
    previous_body_yaw: f32,
    head_yaw: f32,
    previous_head_yaw: f32,
    // Entity.xRot
    head_pitch: f32,
    previous_head_pitch: f32,
    on_ground: bool,
    horizontal_collision: bool,
    vertical_collision_below: bool,
    // `Entity.needsSync`: knocked back, pushed or jumped since its server
    // last sent it, so the next update goes out at once.
    needs_sync: bool,
    // `getAttributeValue(KNOCKBACK_RESISTANCE)` with the modifiers of the
    // items it wears or holds, which the game works out each tick for a mob
    // that has any (the mob itself knows no item): `None` for the rest.
    gear_knockback_resistance: Maybe(f64),
    health: f32,
    hurt_time: i32,
    invulnerable: i32,
    death_time: i32,
    age: u32,
    limb_position: f32,
    limb_speed: f32,
    previous_limb_speed: f32,
    swell: i32,
    previous_swell: i32,
    // Creeper.maxSwell (`Fuse`): local NBT state, not synced entity data.
    max_swell: i32,
    ambient_timer: i32,
    fall_distance: f64,
    // `Entity.stuckSpeedMultiplier`: the next move is scaled by it.
    stuck_multiplier: Vec3,
    // `Entity.pistonDeltas` and `pistonDeltasGameTime`: how far a moving
    // block has pushed this mob this tick (0.51 at most on any axis).
    piston: horizon_world::piston_movement::PistonMovement,
    persistent: bool,
    // `CustomName` (plain text) and `CustomNameVisible`.
    custom_name: Maybe(string),
    // The styled `CustomName`, when it came from a component.
    custom_name_text: Maybe(crate::text::Text),
    name_visible: bool,
    // `Entity.DATA_SHARED_FLAGS_ID` bit 0x20: the model is hidden.
    invisible: bool,
    random: LegacyRandom,
    ai: ^ai::Ai,
    extra: Extra,
    fluids: living::Fluids,
    // Entity.wasEyeInWater: the eyes were in water before this tick's fluid
    // update (`isUnderWater` reads it).
    was_eye_in_water: bool,
    // `Entity.firstTick`: no splash for a mob that appears in water.
    first_tick: bool,
    no_gravity: bool,
    // `Entity.mainSupportingBlockPos`: the block it stood on after its last
    // move.
    supporting: Option<[i32,
    // The block under the mob's feet by name (`minecraft:grass_block`), kept for the
    // packs' random-model rules (`rule_index`); `None` without rules or off the ground.
    standing_on: Maybe(string),
    // `NoAI`: no goals and no movement.
    no_ai: bool,
    // `Silent`.
    silent: bool,
    // `Invulnerable`: immune to damage (but not to `/kill`).
    invulnerable_flag: bool,
    // The entity that causes the blow being dealt (`source.getEntity()`): its eye, view
    // direction and feet, which `SulfurCube.knockback` turns the launch by. Set by whoever deals
    // the blow (`Game::attacker_aim`) and cleared once it is dealt.
    attacker_aim: Maybe(Aim),
    // The horizontal motion `(x, z)` of the projectile that is the direct entity of the blow
    // being dealt (`Projectile.calculateHorizontalHurtKnockbackDirection`): the knock goes the
    // way it was travelling. None for any other direct entity.
    projectile_motion: Option<[f64,
    climbing: bool,
    // `LivingEntity.onClimbable` as of the last mob tick, for `isPushable`
    // checks made outside the mob world (minecarts, boats).
    on_climbable: bool,
    fire_ticks: i32,
    ticks_frozen: i32,
    glowing: bool,
    air: i32,
    last_hurt: f32,
    // `LivingEntity.getAbsorptionAmount`: golden hearts that soak damage before health.
    absorption: f32,
    // Tenths of absorbed damage a player's hit dealt, which the attack awards as
    // `Stats.DAMAGE_DEALT_ABSORBED` to the player whose turn it is (see [`Mob::soak_hit`]).
    dealt_absorbed: i32,
    last_damage: Option<(Damage,
    // `DamageSource.getDirectEntity` of `last_damage` when [`Damage`] cannot name it (a
    // thrown potion, an area effect cloud): its entity type.
    last_direct: Maybe(^'static str),
    // `LivingEntity.combatTracker`: the hits taken lately.
    combat: combat::Tracker,
    // Set by `remove`: the mob disappears without dying (conversion, despawn, pickup).
    removed: bool,
    // Client-side animation clocks (attack swing, eating, shaking...).
    anim: anim::AnimState,
    // Attribute values that differ per mob (slime size, babies, effects).
    attrs: Attrs,
    // The player riding this mob and its input.
    rider: Maybe(equine::Rider),
    // Events raised outside a tick (hurt and death sounds of damage taken
    // from the game), handed over with the next tick's events or drained
    // by the game.
    outbox: [dynamic]MobEvent,
    // The skin texture of a player mob (`PlayerInfo.getSkin`), which
    // replaces the type's default when its download is ready.
    skin: Maybe(string),
    // `PlayerSkin.model` is `SLIM`: the player model with 3-pixel arms.
    slim: bool,
    // The 3D skin layers feature's model for this player: its outer layer
    // with every painted texel extruded (`skin_layers`, off by default).
    skin_3d: Maybe(^Part),
    // `PlayerSkin.cape`: a player's cape texture, once every download of
    // its skin is ready.
    cape: Maybe(string),
    // A Horizon emote this player plays (docs/cosmetics.md), timed on `age`: it poses the bones
    // after the vanilla animation (`anim::setup`). Visual only.
    emote: Maybe(horizon_cosmetics::Playing),
    // A mannequin's `DATA_PROFILE` (ResolvableProfile): the profile's
    // `textures` property resolves to `skin` like a player's.
    profile: Maybe(horizon_protocol::entity_data::Profile),
    // The packs' random texture variants it wears (`random_textures::choose`).
    random_textures: random_textures::Choice,
}
    // rust: impl crate::entity_rules::EntityRules for Mob {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
}
// A mannequin's `description` and `hide_description` (`Mannequin.updateDescription`):
// the default `entity.minecraft.mannequin.label`, none at all, or a component.
MannequinDescription :: enum {
    Default,
    Hidden,
    Custom(horizon_world::nbt::Tag),
}
    // rust: impl MannequinDescription {
    // `Mannequin.getDescription`: the component `DATA_DESCRIPTION` holds, none when hidden.
component :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Default => Some(horizon_world::nbt::Tag::compound([(
    // rust: "translate",
    // rust: horizon_world::nbt::Tag::String("entity.minecraft.mannequin.label".into()),
    // rust: )])),
    // rust: Self::Hidden => None,
    // rust: Self::Custom(tag) => Some(tag.clone()),
}
}
    // `DATA_DESCRIPTION` as a client reads it.
from_component :: proc(tag: Maybe(^horizon_world::nbt::Tag)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: None => Self::Hidden,
    // rust: Some(tag) if Some(tag) == Self::Default.component().as_ref() => Self::Default,
    // rust: Some(tag) => Self::Custom(tag.clone()),
}
}
}
// Events a mob tick asks the game to act on.
    // rust: impl MobEvent {
    // rust: pub fn entity_sound(
    // rust: mob: &Mob,
    // rust: name: &'static str,
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Self {
    // rust: Self::EntitySound {
    // rust: mob: mob.id,
    // rust: name,
    // rust: at: [mob.position.x, mob.position.y, mob.position.z],
    // rust: volume,
    // rust: pitch,
    // rust: source,
}
}
}

MobEvent :: enum {
    // Squid.handleEntityEvent(19), resetting the remote tentacle cycle.
    SquidCycle {,
    mob: u32,
    at: [f64; 3],
    // rust: },
    // Rabbit entity event 1, sent only when a ground jump actually happens.
    RabbitHop {,
    mob: u32,
    at: [f64; 3],
    // rust: },
    // `LivingEntity.baseTick`'s drowning damage: entity event 67, the
    // clients' `makeDrownParticles`.
    Drown {,
    mob: u32,
    at: [f64; 3],
    // rust: },
    // PowderSnowBlock.entityInside's snowflake with vanilla's sampled velocity.
    PowderSnowParticle {,
    at: [f64; 3],
    velocity: [f64; 3],
    // rust: },
    // `Mob.burnUndead` in daylight on a mob wearing something in its
    // `sunProtectionSlot`: the item loses up to 1 durability (the game knows
    // the item data) instead of the mob catching fire.
    SunProtectionWear {,
    mob: u32,
    // rust: },
    // `Level.broadcastEntityEvent` for a mob: guests run its
    // `handleEntityEvent`.
    EntityEvent {,
    mob: u32,
    event: i8,
    at: [f64; 3],
    // rust: },
    // `ServerLevel.sendParticles`: drawn here and sent to the players within
    // 32 blocks, which spread and speed the way the client does for a count
    // (a count of 0 is one particle moving by speed times spread).
    LevelParticles {,
    kind: &'static str,
    at: [f64; 3],
    spread: [f64; 3],
    speed: f64,
    count: u32,
    // rust: },
    // `ServerLevel.sendParticles` of an `ItemParticleOption`: `count` crumbs of
    // `item`, drawn in this window.
    ItemParticles {,
    item: &'static str,
    at: [f64; 3],
    spread: [f64; 3],
    speed: f64,
    count: u32,
    // rust: },
    Sound(&'static str, [f64; 3], f32, f32),
    // The entity overload of `Level.playSound`: keep the emitter and the
    // call site's category rather than turning it into a positional sound.
    EntitySound {,
    mob: u32,
    name: &'static str,
    at: [f64; 3],
    volume: f32,
    pitch: f32,
    source: usize,
    // rust: },
    // `Entity.sendBubbleColumnParticles`: a mob at the top of the bubble column
    // block at `pos` (the splash and bubble particles over it).
    BubbleColumnParticles {,
    pos: [i32; 3],
    // rust: },
    // A `BlockParticleOption` of `state` drawn `count` times at `at`, each crumb
    // leaving at `speed`: the dust `LivingEntity.checkFallDamage` throws up from
    // the block a mob landed on, and the puffs `Breeze.emitGroundParticles`
    // leaves at a breeze's feet (which it draws at rest).
    LandingDust {,
    state: horizon_world::registry::BlockStateId,
    at: [f64; 3],
    count: i32,
    speed: f64,
    // rust: },
    // `UseBonemeal`: the villager's bone meal grows the crop at `pos`
    // (`BoneMealItem.growCrop`, then level event 1505).
    Bonemeal {,
    pos: [i32; 3],
    // rust: },
    // `RingBell`: the villager rings the meeting-point bell
    // (`BellBlock.attemptToRing`: the bell shakes, the sound and the game
    // event follow).
    RingBell {,
    bell: [i32; 3],
    // rust: },
    // `ChestBlockEntity.startOpen` / `stopOpen` by a copper golem: the
    // chest's opener count goes up or down (interaction range 3).
    ChestOpen {,
    chest: [i32; 3],
    open: bool,
    // rust: },
    // `BeeEnterHiveGoal.start`: the bee goes into its hive (the host stores
    // its tag with `BeehiveBlockEntity.addOccupant` and discards it).
    EnterHive {,
    mob: u32,
    hive: [i32; 3],
    // rust: },
    // `LandOnOwnersShoulderGoal`: a tame parrot touched its owner and sits
    // on their shoulder (the host stores its tag and discards it).
    ParrotToShoulder {,
    mob: u32,
    // rust: },
    // `CopperGolem.turnToStatue`.
    BecomeStatue {,
    mob: u32,
    // rust: },
    // A copper golem took from or filled a chest slot.
    ChestSlot {,
    chest: [i32; 3],
    slot: usize,
    stack: Option<crate::items::ItemStack>,
    // rust: },
    // `InfestedMobEffect.onMobHurt`: the mob was hurt while infested.
    Infested {,
    mob: u32,
    // rust: },
    // `LivingEntity.hurtArmor` (`doHurtEquipment`): a hit that landed on a mob
    // wearing body armour (a horse's) leaves the piece owing
    // `max(1, damage / 4)` durability. The host applies it: it is the one
    // that knows the item's maximum, whether it wears when hurt at all and
    // whether a fire hit leaves it alone (`ItemStack.canBeHurtBy`).
    ArmorHurt {,
    mob: u32,
    amount: f32,
    kind: DamageKind,
    // rust: },
    // `OfferFlowerGoal.stop`: the item goes to the target's antenna (saddle)
    // slot if it is empty, as a guaranteed drop.
    Gift {,
    target: u32,
    item: &'static str,
    // rust: },
    // `AnimalMakeLove`: the partner remembers this mob as its breed target
    // and walks to it and looks at it.
    BreedTarget {,
    mob: u32,
    partner: u32,
    // rust: },
    // `BehaviorUtils.lockGazeAndWalkToEachOther`'s other half: the partner
    // looks at this mob and walks to it.
    LockGaze {,
    mob: u32,
    partner: u32,
    // rust: },
    // `AbstractSchoolingFish.startFollowing` on a fish a leader recruits:
    // it follows the leader, whose school grows by one.
    StartFollowing {,
    fish: u32,
    leader: u32,
    // rust: },
    // `addFollower` / `removeFollower`: a leader's school grows or shrinks.
    SchoolSize {,
    leader: u32,
    by: i32,
    // rust: },
    // A sound event id that is not a static string (variant sounds).
    SoundId(String, [f64; 3], f32, f32),
    // `Level.playLocalSound`: a sound the client plays for itself, never
    // sent by a server (a breeze's whirl and idle sounds).
    LocalSound(&'static str, [f64; 3], f32, f32),
    // A level event's sound (`levelEvent`/`globalLevelEvent`): the client
    // plays it with its own random pitch spread (`(a - b) * spread + 1`),
    // nothing is drawn from the mob.
    LevelEventSound {,
    sound: &'static str,
    at: [f64; 3],
    volume: f32,
    spread: f32,
    // rust: },
    // `Level.gameEvent` from a mob's own movement (`GameEvent.STEP`): the
    // game's sculk layer tracks steps itself, the mob AI probe hears them
    // through the wardens (`warden::listen`).
    GameEvent {,
    event: &'static str,
    at: [f64; 3],
    source: u32,
    state: horizon_world::registry::BlockStateId,
    // rust: },
    AttackPlayer(f32, [f64; 3]),
    // `Bee.doHurtTarget` on a player: a sting that lands leaves its stinger
    // in them and poisons them for `poison_ticks` (none on easy).
    StingPlayer {,
    amount: f32,
    from: [f64; 3],
    poison_ticks: i32,
    // rust: },
    // A melee hit whose effect comes only if the hit lands (husk hunger,
    // cave spider poison, wither skeleton wither, bee and pufferfish
    // poison): a shield-blocked hit gives nothing.
    AttackPlayerWithEffect {,
    amount: f32,
    from: [f64; 3],
    effect: &'static str,
    ticks: i32,
    amplifier: i32,
    // rust: },
    // Damage of a given type to the player (guardian lasers, thorns).
    DamagePlayer {,
    amount: f32,
    from: [f64; 3],
    kind: &'static str,
    // rust: },
    // `ElderGuardian`'s curse on players within 50 blocks; a silent elder's
    // shows the apparition without the curse sound.
    ElderCurse {,
    at: [f64; 3],
    silent: bool,
    // rust: },
    // `Entity.setDeltaMovement`: replace a target's velocity.
    SetVelocity {,
    target: Who,
    velocity: [f64; 3],
    // rust: },
    // `Entity.remove(RemovalReason.KILLED)` of a mob that is no longer alive: it vanishes at once,
    // with no death animation (`ShootTongue.eatEntity`).
    RemoveKilled {,
    target: u32,
    // rust: },
    // `Entity.push`: add to a target's velocity.
    Push {,
    target: Who,
    velocity: [f64; 3],
    // rust: },
    // `SonicBoom`: 10 damage to the target, then a push along `direction`
    // (the unit vector from the warden's chest to the target's eyes) only
    // if the hit landed, less the target's knockback resistance.
    SonicBoom {,
    target: Who,
    attacker: u32,
    from: [f64; 3],
    direction: [f64; 3],
    // rust: },
    // `Entity.move(MoverType.SHULKER, delta)`: shift a target's position
    // (an opening shulker lifts what stands on its shell).
    Shift {,
    target: Who,
    delta: [f64; 3],
    // rust: },
    // `EvokerWololoSpellGoal`: a blue sheep turns red.
    Wololo {,
    mob: u32,
    // rust: },
    // `EvokerFangs` rising at a point after `delay` ticks.
    Fangs {,
    at: [f64; 3],
    yaw: f32,
    delay: i32,
    owner: u32,
    // rust: },
    Shoot([f64; 3], [f64; 3]),
    // The mob the `Explode` right after this comes from
    // (`ServerExplosion.source`), and whether it is a charged creeper: the
    // exploding creeper is already out of the mob list when the game applies
    // the blast, so its victims' loot cannot look it up, nor the death
    // message its name (`name`, `getDisplayName`).
    ExplosionSource {,
    mob: u32,
    charged: bool,
    name: crate::text::Text,
        // `Entity.isInWater` of the source: `BlockAttached.ignoreExplosion`.
    in_water: bool,
    // rust: },
    // The centre, the radius and the kind of the mob blowing up (it may be
    // gone from the list by the time the blast is handled).
    Explode([f64; 3], f32, Species),
    // `Creeper.spawnLingeringCloud`, right after its `Explode`: an `AreaEffectCloud` at the
    // creeper with its active effects `(id, remaining ticks, amplifier)`, in their mixed colour.
    LingeringCloud {,
    at: [f64; 3],
    effects: Vec<(&'static str, i32, i32)>,
        // The effects among them added hidden (`hideParticles`).
    hidden: Vec<&'static str>,
        // The effects among them that are ambient.
    ambient: Vec<&'static str>,
    color: u32,
    // rust: },
    // Melee or ranged damage to another mob.
    AttackMob {,
    target: u32,
    amount: f32,
    source: Damage,
    // rust: },
    // A melee hit on another mob whose effect rides the hit:
    // `CaveSpider`, `Husk` and `WitherSkeleton.doHurtTarget` add it inside
    // the `super.doHurtTarget` branch, to any `LivingEntity`, so a mob the
    // hit lands on gets it too.
    AttackMobWithEffect {,
    target: u32,
    amount: f32,
    source: Damage,
    effect: &'static str,
    ticks: i32,
    amplifier: i32,
    // rust: },
    // `AbstractCubeMob.dealDamage` on the player (`playerTouch`): the hit,
    // then, only when `hurtServer` let it land, the cube's
    // `entity.slime.attack` with its pitch drawn from the cube's random.
    CubeHurtPlayer {,
    cube: u32,
    amount: f32,
    from: [f64; 3],
    // rust: },
    // `AbstractCubeMob.dealDamage` on a mob (an iron golem it touches): the
    // hit, then, only when `hurtServer` let it land, the cube's
    // `entity.slime.attack` with its pitch drawn from the cube's random.
    CubeHurtMob {,
    cube: u32,
    target: u32,
    amount: f32,
    source: Damage,
    // rust: },
    // `Pufferfish.touch` on a mob (`Pufferfish.aiStep`): the hit, then, only
    // when `hurtServer` let it land, the fish's `entity.puffer_fish.sting`
    // and the poison it gives (`poison_ticks`, `60 * getPuffState()`).
    PufferfishSting {,
    mob: u32,
    target: u32,
    amount: f32,
    source: Damage,
    poison_ticks: i32,
    // rust: },
    // `LivingEntity.stabAttack`'s `target.stopRiding()`: a spear knocks the
    // target off its mount.
    StabDismount {,
    target: Who,
    // rust: },
    // `LivingEntity.knockback(power, x, z, source)`: pushed away from the
    // direction.
    Knockback {,
    target: Who,
    power: f64,
    x: f64,
    z: f64,
    source: Damage,
    // rust: },
    // Set another mob's attack target (HurtByTargetGoal alerts).
    SetTarget {,
    mob: u32,
    target: Who,
    // rust: },
    // `StartHuntingHoglin` for a nearby adult piglin: it takes the hoglin as
    // its anger target (when it has none) and starts its `HUNTED_RECENTLY` wait.
    HuntHoglin {,
    mob: u32,
    target: u32,
    ticks: i32,
    // rust: },
    // `HoglinAi.broadcastRetreat` and `PiglinAi.broadcastRetreat` for one
    // adult that sees the broadcaster: it retreats from `from`, standing at
    // `at`, or from what it already avoids or attacks if that is nearer.
    Retreat {,
    mob: u32,
    from: Who,
    at: [f64; 3],
    // rust: },
    // `Entity.startRiding` from a mob's brain (`Mount.create`): `rider` boards
    // `vehicle` if `Piglin.startRiding` and `canRide` allow it.
    StartRiding {,
    rider: u32,
    vehicle: u32,
    // rust: },
    Projectile(crate::projectiles::Projectile),
    // An arrow `mob` shot with `weapon` (`AbstractSkeleton.performRangedAttack`):
    // the game asks for the ammunition (`getProjectile`) before it flies.
    BowShot {,
    mob: u32,
    weapon: crate::items::ItemStack,
    arrow: crate::projectiles::Projectile,
    // rust: },
    // `mob` finished charging `weapon` (`CrossbowItem.onUseTick`): the game
    // asks for the ammunition (`getProjectile`), and plays the end sound
    // at `at` only when the crossbow loaded.
    CrossbowLoad {,
    mob: u32,
    weapon: crate::items::ItemStack,
    at: [f64; 3],
    pitch: f32,
    // rust: },
    // `arrow` shot from the `ammo` a mob's crossbow was charged with.
    CrossbowShot {,
    ammo: crate::items::ItemStack,
    arrow: crate::projectiles::Projectile,
    // rust: },
    // Spawn a new mob (breeding, slime splitting, chicken eggs...).
    Spawn(Box<Mob>),
    // Spawn a mob by type id at a position (conversions, splits).
    SpawnKind {,
    kind: String,
    at: [f64; 3],
    setup: SpawnSetup,
    // rust: },
    // `Mob.convertTo` with `ConversionType.SINGLE` ([`conversion::single`]):
    // a new mob of `kind` takes the place of `from` (already removed) and
    // keeps its gear, name and flags.
    Convert {,
    from: Box<Mob>,
    kind: &'static str,
    params: conversion::Params,
    // rust: },
    DropItem {,
    mob: u32,
    item: Arc<str>,
    count: u32,
    at: [f64; 3],
    // rust: },
    // `new ItemEntity(.., stack)` thrown by `mob` (`setThrower`): `Dolphin.ItemGoal.drop`.
    ThrowItem {,
    mob: u32,
    stack: crate::items::ItemStack,
    at: [f64; 3],
    motion: [f64; 3],
    pickup_delay: u32,
    // rust: },
    // `Goat.dropHorn`: a horn from goat `mob` (`Goat.createHorn` picks the
    // instrument from its UUID), thrown with `motion` as
    // `new ItemEntity(.., deltaX, deltaY, deltaZ)`.
    DropGoatHorn {,
    mob: u32,
    screaming: bool,
    at: [f64; 3],
    motion: [f64; 3],
    // rust: },
    // `Mob.dropFromGiftLootTable`: a gift loot table's items dropped at `at`.
    DropGift {,
    table: &'static str,
    at: [f64; 3],
    // rust: },
    // A leave-block goal's sampled candidate, before neighbor-shape updates.
    EndermanPlaceBlock {,
    mob: u32,
    pos: [i32; 3],
    carried: horizon_world::registry::BlockStateId,
    occupants: Vec<horizon_core::geometry::Aabb>,
    // rust: },
    SetBlock {,
    pos: [i32; 3],
    state: horizon_world::registry::BlockStateId,
    // rust: },
    // `TurtleEggBlock.decreaseEggs` after a mob's step won its 1 in 100: the
    // break sound, then one egg fewer, or the block destroyed when it was
    // the last.
    CrackTurtleEgg {,
    pos: [i32; 3],
    // rust: },
    // `LivingEntity.startSleeping` / `stopSleeping`: the bed head at `pos`
    // gets `occupied` (`setBlockAndUpdate`; the foot follows it).
    BedOccupied {,
    pos: [i32; 3],
    occupied: bool,
    // rust: },
    // `DoorBlock.setOpen` by a mob (`InteractWithDoor`): the door opens or
    // closes, both halves, with its sound and game event.
    SetDoorOpen {,
    pos: [i32; 3],
    open: bool,
    // rust: },
    // `BreakDoorGoal.tick` at its end: the door is removed (`removeBlock`),
    // then level events 1021 and 2001 with the state that is left there.
    BreakDoor {,
    mob: u32,
    pos: [i32; 3],
    // rust: },
    // `Level.destroyBlockProgress` for a mob's crack on a block (`-1`
    // clears it).
    DestroyProgress {,
    mob: u32,
    pos: [i32; 3],
    progress: i32,
    // rust: },
    // `Rabbit.RaidGardenGoal.tick`: the carrots at `pos` become `state` (`setBlock` with
    // flags 2); a crop that only lost an age shows the break particles of the state it had
    // (`levelEvent(2001, pos, old)`) and fires `BLOCK_CHANGE` for the rabbit.
    CropRaided {,
    pos: [i32; 3],
    state: horizon_world::registry::BlockStateId,
    old: Option<horizon_world::registry::BlockStateId>,
    mob: u32,
    // rust: },
    // `Level.levelEvent`: the game plays and sends the event.
    LevelEvent {,
    id: i32,
    pos: [i32; 3],
    data: i32,
    // rust: },
    // `InfestedBlock.infestedStateByHost` (`infested`) or `hostStateByInfested`
    // for the block there, keeping its axis; `poof` is the silverfish that
    // hid in it (`spawnAnim`).
    Infest {,
    pos: [i32; 3],
    infested: bool,
    poof: Option<u32>,
    // rust: },
    // `Level.destroyBlock(pos, drop)`: the block gives way to its fluid's
    // block (air when it has none). Sheep eating grass becomes dirt via SetBlock.
    BreakBlock {,
    pos: [i32; 3],
    drop: bool,
    // rust: },
    Particles {,
    kind: &'static str,
    at: [f64; 3],
    count: u32,
    // rust: },
    // Client particles about a mob's box (`particles::around_self`) and the
    // entity event `event` that shows them, sent for mob `mob`.
    AroundSelf {,
    mob: u32,
    event: i8,
    kind: &'static str,
    feet: [f64; 3],
    width: f64,
    height: f64,
    burst: crate::particles::Burst,
    // rust: },
    // One particle exactly at `at`, moving at `velocity`.
    ParticleAt {,
    kind: &'static str,
    at: [f64; 3],
    velocity: [f64; 3],
    // rust: },
    // One `minecraft:entity_effect` particle at `at` in the colour `color`
    // (`ColorParticleOption.create(ENTITY_EFFECT, r, g, b)`), standing still.
    ParticleColored {,
    at: [f64; 3],
    color: [f32; 3],
    // rust: },
    Experience {,
    at: [f64; 3],
    amount: u32,
    // rust: },
    // Regeneration support after an axolotl-assisted kill, from the axolotl `mob`.
    AxolotlSupportPlayer {,
    mob: u32,
    // rust: },
    // A dolphin that was given a fish asks the game for the nearest
    // shipwreck or ocean ruin (`DolphinSwimToTreasureGoal.start`): the game
    // sets the dolphin's `extra.home` to it, or leaves it empty.
    DolphinTreasure {,
    mob: u32,
    // rust: },
    // Apply an effect to the player (witch potions, bee stings, cave spider poison).
    EffectPlayer {,
    effect: &'static str,
    ticks: i32,
    amplifier: i32,
        // `MobEffectInstance` ambient flag (the beacon-style translucent icon).
    ambient: bool,
    // rust: },
    // Apply an effect to another mob: `IllusionerBlindnessSpellGoal.performSpellCasting`
    // blinds whatever `LivingEntity` the illusioner targets, not only a player.
    EffectMob {,
    target: u32,
    effect: &'static str,
    ticks: i32,
    amplifier: i32,
    // rust: },
    // Set an entity on fire.
    Ignite {,
    target: Who,
    seconds: i32,
    // rust: },
    // Two animals bred: the game spawns the baby and resets the partner.
    Breed {,
    parent: u32,
    partner: u32,
        // A llama's baby, drawn from the parent's random as
        // `Llama.getBreedOffspring` does.
    llama: Option<Box<super::mobs::llama::Offspring>>,
    // rust: },
    // Replace a block by name (sheep turning grass to dirt), optionally with
    // the destroy effect.
    SetBlockName {,
    mob: Option<u32>,
    pos: [i32; 3],
    name: &'static str,
    effect: bool,
    flags: i32,
    // rust: },
    // A cat hisses (phantoms flee).
    Hiss {,
    mob: u32,
    // rust: },
    // A horse's rider tamed it.
    Tamed {,
    mob: u32,
    // rust: },
    // A horse throws its rider off.
    Buck {,
    mob: u32,
    // rust: },
    // A piglin's admiring is over: barter or keep the item.
    FinishAdmiring {,
    mob: u32,
    // rust: },
    // Throw an entity upward (iron golem swings).
    Launch {,
    target: Who,
    up: f64,
    // rust: },
    // Damage the mob itself (snow golems melting).
    HurtSelf {,
    mob: u32,
    kind: DamageKind,
    amount: f32,
    // rust: },
    // Two villagers are close: swap gossip and share food and wares.
    VillagerMeet {,
    mob: u32,
    other: u32,
    // rust: },
    // `AbstractVillager.getOffers` for a villager whose offers are not made
    // yet: the level rolls them (the brain has no trade data), so the
    // behaviour that asked reads them from the next tick on.
    VillagerOffers {,
    mob: u32,
    // rust: },
    // Two villagers make a baby (`VillagerMakeLove.tryToGiveBirth`): the
    // parent has eaten and, with a bed for the child, rests; the partner
    // eats, and rests too if `child` holds the child's bed and type
    // (`None`: the biome's).
    VillagerBirth {,
    parent: u32,
    partner: u32,
    child: Option<([i32; 3], Option<u8>)>,
    // rust: },
    // `WorkAtComposter.useWorkstation`: a farmer at its composter makes
    // bread and composts seeds (the game applies it to the villager's
    // inventory and the block).
    WorkAtComposter {,
    mob: u32,
    pos: [i32; 3],
    // rust: },
    // A villager asks whether enough neighbours want an iron golem.
    GolemCheck {,
    mob: u32,
    needed: usize,
    // rust: },
    // A villager launches a firework rocket (celebrating a won raid).
    Firework {,
    at: [f64; 3],
    color: usize,
    flight: u8,
    // rust: },
    // A villager throws a hero's gift (a loot table) toward the player.
    ThrowGift {,
    table: String,
    from: [f64; 3],
    to: [f64; 3],
    // rust: },
    // A patrol leader hands its patrol target to a companion.
    PatrolTarget {,
    mob: u32,
    target: [i32; 3],
    // rust: },
    // A raider is told to attack (`HoldGroundAttackGoal` shouting).
    RaiderTarget {,
    mob: u32,
    target: Who,
    aggressive: bool,
    // rust: },
    // Drop the loot of a gift table (chicken eggs, sniffer seeds) with the
    // mob as `this` (`LivingEntity.dropFromGiftLootTable`).
    GiftLoot {,
    mob: u32,
    table: &'static str,
    at: [f64; 3],
    // rust: },
    // `Chicken.aiStep`: the egg timer ran out. The `chicken_lay` gift table
    // drops at the chicken; only when it dropped something does the egg sound
    // play (at `pitch`) and `entity_place` reach listeners.
    LayEgg {,
    mob: u32,
    at: [f64; 3],
    pitch: f32,
    // rust: },
    // `Armadillo.customServerAiStep`: the armadillo sheds a scute.
    ShedScute {,
    mob: u32,
    at: [f64; 3],
    pitch: f32,
    // rust: },
    // A lead snaps or loses its holder: the lead item drops when asked.
    LeashBreak {,
    mob: u32,
    drop: bool,
    sound: bool,
    // rust: },
    // `Leashable.whenLeashedTo`: the holder is told a quad-leashed mob hangs
    // on it (`HappyGhast.notifyLeashHolder`).
    NotifyLeashHolder {,
    holder: u32,
    // rust: },
    // A zombie villager's cure is complete: the game turns it back into a villager.
    CureZombieVillager {,
    mob: u32,
    // rust: },
    // A vibration travelling to a listener (`VibrationParticleOption`).
    Vibration {,
    from: [f64; 3],
    to: [f64; 3],
    ticks: i32,
        // `VibrationSystem.User.getPositionSource`: the listener itself.
    source: horizon_protocol::entity_data::PositionSource,
    // rust: },
    // The crumbs of the block under a digging or emerging warden.
    DigParticles {,
    at: [f64; 3],
    // rust: },
    // `Zombie.hurtServer`: a zombie hurt with a target in sight (its own,
    // else the attacker) may call a reinforcement against it on Hard.
    Reinforcements {,
    mob: u32,
    target: Who,
    // rust: },
    // `LevelEvent.PARTICLES_DESTROY_BLOCK` (2001) at `pos` for the block at
    // `block`: a turtle's digging.
    BlockBreakEffect {,
    pos: [i32; 3],
    block: [i32; 3],
    // rust: },
    // `Warden.applyDarknessAround`: darkness for survival players nearby.
    Darkness {,
    at: [f64; 3],
    radius: f64,
    // rust: },
    // A creaking bound to the heart at `home` was hurt (`creakingHurt` when a player did it).
    CreakingHurt {,
    home: [i32; 3],
    by_player: bool,
    id: u32,
    // rust: },
    // `Creaking.tearDown`: crumbling particles around the creaking.
    CreakingTearDown {,
    center: [f64; 3],
    spread: [f64; 3],
    // rust: },
    // `Panda.afterSneeze`: the grown pandas within 10 blocks start.
    PandaSneezed {,
    mob: u32,
    // rust: },
    // `Entity.propagateFallToPassengers`: the mob landed and what rides it
    // (a player or a mob) takes `causeFallDamage` of the same fall.
    FallToPassengers {,
    mob: u32,
    distance: f64,
    modifier: f32,
    // rust: },
}
// How a spawned-by-kind mob should be set up.
SpawnSetup :: struct {
    baby: bool,
    size: i32,
    yaw: f32,
    velocity: [f64,
    health: Maybe(f32),
    persistent: bool,
    variant: Maybe(u8),
    // Zombified piglins and zoglins wake up nauseous (`ConversionParams`).
    nausea: bool,
    // Vexes: the summoning mob, the bound origin and the life in ticks.
    owner_mob: Maybe(u32),
    home: Option<[i32,
    life: Maybe(i32),
}
// A snapshot of another entity mobs can see this tick.
Seen :: struct {
    in_water: bool,
    playing_dead: bool,
    last_damage: Maybe(Damage),
    id: u32,
    species: Species,
    position: Vec3,
    bounds: Aabb,
    eye_y: f64,
    alive: bool,
    baby: bool,
    in_love: bool,
    tame: bool,
    // `AbstractHorse.isBred`: the `Bred` flag (`followMommy` reads it).
    bred: bool,
    // A tamed animal's owner (`getOwner`).
    owner: Option<[i32,
    hostile: bool,
    target: Maybe(Who),
    health: f32,
    variant: u8,
    // A slime's or magma cube's size.
    size: i32,
    // Dye colour (sheep).
    color: u8,
    // A villager's claimed job site and bed.
    job: Option<[i32,
    bed: Option<[i32,
    yaw: f32,
    velocity: Vec3,
    // `Entity.getKnownSpeed`: what it moved in its last tick.
    known_speed: Vec3,
    // Who holds this mob's lead.
    leash: Maybe(leash::Holder),
    // A llama's caravan head (its id plus one, 0 when not in a caravan).
    caravan: u32,
    // A schooling fish's leader and how many fish follow it.
    school: (Maybe(u32),
    // `MobExtra::section` and `section_seq`.
    section: ([i32,
    // A wandering trader's despawn delay.
    delay: i32,
    // `getLastHurtByMob` and its timestamp.
    hurt_by: Option<(Who,
    // A raider in an active raid.
    active_raid: bool,
    // A copper golem's `openedChestPos` (`ContainerUser.hasContainerOpen`).
    opened_chest: Option<[i32,
    // `isPassenger`.
    passenger: bool,
    // The vehicle it rides (`getVehicle`): a mob's or a boat's id.
    vehicle: Maybe(u32),
    // A villager's reputation of the player (`getPlayerReputation`).
    player_rep: i32,
    // `isPushable` and pushed by others (`Entity.push(Entity)` moves it).
    pushable: bool,
    // A cold strider (`Strider.isSuffocating`).
    cold_strider: bool,
    // `MobCategory` (`monster`, `creature`, ...).
    category: ^'static str,
    // A villager's `POTENTIAL_JOB_SITE` and `MEETING_POINT`.
    potential_job: Option<[i32,
    meeting: Option<[i32,
    // `variant2`: a villager's profession (index into
    // `render::PROFESSIONS`), a llama's strength. And a villager's experience.
    profession: u8,
    xp: i32,
    // What other villagers read of a villager's state and brain.
    villager: Maybe(^villager::Seen),
    // `MAX_HEALTH`, `JUMP_STRENGTH` and `MOVEMENT_SPEED` base values (a
    // horse's breeding stock).
    stats: [f64,
    // `Wolf.isInSittingPose`.
    sitting: bool,
    // `Entity.isSilent`.
    silent: bool,
    // `Cat.isLying` or `isRelaxStateOne`.
    lying: bool,
    // `Entity.isVehicle` or `isPassenger`.
    ridden: bool,
    is_vehicle: bool,
    // `Attributes.KNOCKBACK_RESISTANCE`.
    knockback_resistance: f64,
    // The active effects, without namespace (`slowness`, `poison`...).
    effects: [dynamic]^'static str,
    // A piglin's `HUNTED_RECENTLY` memory.
    hunted_recently: bool,
    // A piglin's `HURT_BY` memory.
    hurt_recently: bool,
    // `Hoglin.canBeHunted`: an adult hoglin without `CannotBeHunted`.
    huntable: bool,
}
    // rust: impl Seen {
    // `LivingEntity.hasEffect`, by id without namespace.
has_effect :: proc(self: ^Self, effect: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.effects.contains(&effect)
}
}
    // rust: impl Mob {
    // The name used by command replies: CustomName takes precedence over the type.
command_name :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(name) = &self.custom_name {
    // rust: return crate::text::Text::literal(name);
}
        // Villager.getTypeName returns its registered profession's name.
    // rust: if self.species() == Species::Villager {
    // rust: let professions = &render::PROFESSIONS;
    // rust: let profession = professions[self.extra.variant2 as usize % professions.len()];
    // rust: return crate::text::Text::translate(
    // rust: &format!("entity.minecraft.villager.{profession}"),
    // rust: &[],
    // rust: );
}
    // rust: let id = crate::command::args::normalize(&self.kind.id);
    // rust: crate::text::Text::translate(&format!("entity.{}", id.replace(':', ".")), &[])
}

    // What the mob holds and wears, by `EquipmentSlot` ordinal: main hand,
    // off hand, feet, legs, chest, head, body and saddle
    // (`ClientboundSetEquipmentPacket`'s slots).
equipment_stacks :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
//         use crate::items::ItemStack;
    // rust: let e = &self.extra;
    // rust: let wolf = self.species() == Species::Wolf;
    // rust: let slots = [
    // rust: (0usize, &e.main_hand, e.main_hand_stack()),
    // rust: (1, &e.off_hand, None),
    // rust: (2, &e.feet, e.armor[3].as_ref()),
    // rust: (3, &e.legs, e.armor[2].as_ref()),
    // rust: (4, &e.chest, e.armor[1].as_ref()),
            // The body slot's item is no worn armour: a horse's armour, a
            // llama's carpet, a harness go out on their own (6).
    // rust: (5usize, &e.head, e.armor[0].as_ref()),
    // rust: (6, &e.body, None),
    // rust: ];
    // rust: let mut out: [Option<ItemStack>; 8] = Default::default();
    // rust: for (slot, item, worn) in slots {
    // rust: let Some(item) = item else {
    // rust: continue;
}
            // The worn armour keeps its stack: a dyed leather piece keeps
            // its colour.
    // rust: out[slot] = Some(worn.cloned().unwrap_or_else(|| ItemStack {
    // rust: item: item.clone(),
    // rust: count: 1,
                // A wolf's armor shows its cracks.
    // rust: damage: if slot == 6 && wolf {
    // rust: e.body_damage.max(0) as u32
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: extra: if slot == 6 && wolf {
    // rust: e.body_extra.clone()
    // rust: } else {
    // rust: None
    // rust: },
    // rust: }));
}
    // rust: if e.saddled {
    // rust: out[7] = Some(e.saddle_stack.clone().unwrap_or(ItemStack {
    // rust: item: Arc::from("minecraft:saddle"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: }));
}
    // rust: out
}
burning_time :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let base = finalize::value(self, finalize::Attr::BurningTime);
    // rust: let protection: u32 = gear::ARMOR
    // rust: .into_iter()
    // rust: .map(|slot| gear::level(self, slot, "minecraft:fire_protection"))
    // rust: .sum();
    // rust: (base - 0.15 * f64::from(protection)).max(0.0)
}
    // Entity.isOnFire: fire-immune mobs never count as burning, even on the
    // tick a sun or fire check set their timer before `base_tick` clears it.
is_on_fire :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.kind.flags.fire_immune && self.fire_ticks > 0
}
ignite_for_ticks :: proc(self: ^Self, ticks: i32) {
}
    // rust: self.fire_ticks = self
    // rust: .fire_ticks
    // rust: .max((f64::from(ticks) * self.burning_time()).ceil() as i32);
    // rust: self.ticks_frozen = 0;
}
    // `Entity.extinguishFire`: a burning mob first plays the extinguish sound
    // (`playEntityOnFireExtinguishedSound`: volume 0.7, pitch from two draws
    // of its random, at its feet), then `clearFire` keeps only the
    // fire-immune countdown.
extinguish_fire :: proc(self: ^Self) {
}
    // rust: if self.is_on_fire() {
    // rust: let pitch = 1.6 + (self.random.next_float() - self.random.next_float()) * 0.4;
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: self.outbox.push(MobEvent::Sound(
    // rust: "entity.generic.extinguish_fire",
    // rust: at,
    // rust: 0.7,
    // rust: pitch,
    // rust: ));
}
    // rust: self.fire_ticks = self.fire_ticks.min(0);
}
    // `Entity.isFullyFrozen`.
is_fully_frozen :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.ticks_frozen >= crate::motion::PlayerMotion::TICKS_REQUIRED_TO_FREEZE
}

    // What other mobs see of this one this tick (`player`: the player's
    // UUID, which villagers' reputation is keyed by). Inline: the game's
    // snapshot of every mob writes each one in its slot, not through a copy.
seen :: proc(self: ^Self, player: Maybe([i32; 4])) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let m = self;
    // rust: let villager = m.species() == Species::Villager;
    // rust: Seen {
    // rust: in_water: self.fluids.in_water,
    // rust: playing_dead: axolotl::is_playing_dead(self),
    // rust: last_damage: self.last_damage.map(|(d, _)| d),
    // rust: id: m.id,
    // rust: species: m.species(),
    // rust: position: m.position,
    // rust: bounds: m.bounds(),
    // rust: eye_y: m.eye_y(),
    // rust: alive: m.alive(),
    // rust: baby: m.is_baby(),
            // A villager is "in love" when it is willing to breed (`canBreed`).
    // rust: in_love: if villager {
    // rust: villager::can_breed(m)
    // rust: } else {
    // rust: m.extra.in_love > 0
    // rust: },
    // rust: tame: m.extra.tame,
    // rust: bred: m.extra.bred,
    // rust: owner: m.extra.owner,
    // rust: hostile: m.hostile(),
    // rust: target: m.ai.target,
    // rust: health: m.health,
    // rust: variant: m.extra.variant,
    // rust: size: m.extra.size,
    // rust: color: m.extra.color,
    // rust: job: villager.then_some(m.extra.home).flatten(),
    // rust: bed: villager.then_some(m.extra.bed).flatten(),
    // rust: yaw: m.yaw,
    // rust: velocity: m.velocity,
    // rust: known_speed: m.position.subtract(m.previous),
    // rust: leash: m.extra.leash,
    // rust: caravan: caravan::head_of(m),
    // rust: school: (m.extra.leader, m.extra.followers),
    // rust: section: (m.extra.section, m.extra.section_seq),
    // rust: delay: m.extra.ints[5],
    // rust: hurt_by: m.ai.last_hurt_by.map(|w| (w, m.ai.last_hurt_by_time)),
    // rust: active_raid: raider::has_active_raid(m),
    // rust: opened_chest: m.extra.opened_chest,
    // rust: passenger: m.extra.mount.is_some(),
    // rust: vehicle: m.extra.mount,
    // rust: player_rep: match (villager, player) {
    // rust: (true, Some(uuid)) => villager::ext(m).map_or(0, |e| e.gossips.reputation(uuid)),
    // rust: _ => 0,
    // rust: },
    // rust: pushable: m.pushable(),
    // rust: cold_strider: strider::suffocating(m),
    // rust: category: m.category(),
    // rust: potential_job: villager_brain::potential_job_site(m),
    // rust: meeting: villager.then_some(m.extra.meeting).flatten(),
    // rust: profession: m.extra.variant2,
    // rust: xp: villager::xp(m),
    // rust: villager: villager.then(|| Arc::new(villager::seen(m))),
    // rust: stats: [
    // rust: f64::from(m.attrs.max_health),
    // rust: m.extra.vector[0],
    // rust: m.attrs.speed,
    // rust: ],
    // rust: sitting: m.extra.sitting,
    // rust: silent: m.silent,
    // rust: lying: m.species() == Species::Cat && (m.extra.flag || m.extra.relax_one),
    // rust: ridden: m.rider.is_some() || m.extra.rider.is_some() || m.extra.mount.is_some(),
    // rust: is_vehicle: equine::is_vehicle(m),
    // rust: knockback_resistance: m.attrs.knockback_resistance,
    // rust: effects: m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .map(|e| e.0.trim_start_matches("minecraft:"))
    // rust: .collect(),
    // rust: hunted_recently: m.species() == Species::Piglin && m.extra.ints[0] > 0,
    // rust: hurt_recently: m.species() == Species::Piglin && m.extra.piglin.hurt,
    // rust: huntable: m.species() == Species::Hoglin && !m.is_baby() && !m.extra.cannot_be_hunted,
}
}
    // `EntityType.getCategory`'s name.
category :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind.category.as_str() {
    // rust: "monster" => "monster",
    // rust: "creature" => "creature",
    // rust: "ambient" => "ambient",
    // rust: "axolotls" => "axolotls",
    // rust: "underground_water_creature" => "underground_water_creature",
    // rust: "water_creature" => "water_creature",
    // rust: "water_ambient" => "water_ambient",
    // rust: _ => "misc",
}
}
}
// `Entity.push` on other mobs acts at once in vanilla: a mob ticking later
// moves with it this tick. Takes the `Push` events aimed at mobs out of
// `events[from..]` into `pending`, which the caller adds to each mob's
// velocity before its tick (and to every mob once all have ticked). The
// other events keep their order.
// The part of `Entity.canUsePortal` a mob's own state decides: it is alive,
// it is not a boss that never travels, and — over `Monster.canUsePortal` —
// it is not a creaking bound to a heart (`Creaking.canUsePortal`). The
// rides and the players a side carries are the caller's half.
mob_can_use_portal :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.alive() && m.species() != Species::Wither && creaking::can_use_portal(m)
}
take_mob_pushes :: proc(events: ^[dynamic]MobEvent, from: uint, pending: ^PendingPushes) {
}
    // One pass: a crowd's tick holds a push per neighbour, and removing each
    // in place would shift the rest every time.
    // rust: let mut kept = from;
    // rust: for i in from..events.len() {
    // rust: if let MobEvent::Push {
    // rust: target: Who::Mob(id),
    // rust: velocity,
    // rust: } = events[i]
    // rust: {
    // rust: pending.push(id, Vec3::new(velocity[0], velocity[1], velocity[2]));
    // rust: } else {
    // rust: events.swap(kept, i);
    // rust: kept += 1;
}
}
    // rust: events.truncate(kept);
}
// Pushes waiting for their mob's tick, in push order. A list while short;
// past [`PendingPushes::LIST_MAX`] (a crowd pushing each other) one list
// per mob, as scanning the whole list for each mob grows with its square.
PendingPushes :: struct {
    list: Vec<(u32,
    by_mob: crate::fast_hash::FxHashMap<u32,
}
    // rust: impl PendingPushes {
LIST_MAX :: 64
push :: proc(self: ^Self, id: u32, v: Vec3) {
}
    // rust: if self.by_mob.is_empty() && self.list.len() < Self::LIST_MAX {
    // rust: self.list.push((id, v));
    // rust: return;
}
        // Older pushes first, so each mob's stay in order.
    // rust: for (id, v) in self.list.drain(..) {
    // rust: self.by_mob.entry(id).or_default().push(v);
}
    // rust: self.by_mob.entry(id).or_default().push(v);
}
}
// `ServerLevel.sendBlockUpdated`: for each write that changed a block's collision
// shape, a mob whose path runs near it re-paths (`PathNavigation.shouldRecomputePath`).
// The writes whose shape changed are found once per tick ([`collision_changes`]).
blocks_changed :: proc(m: ^Mob, changed: ^[[i32; 3]]) {
}
    // rust: if m.ai.nav.is_done() {
    // rust: return;
}
    // rust: for &at in changed {
    // rust: if m.should_recompute_path(at) {
    // rust: m.queue_path_recompute();
    // rust: return;
}
}
}
// The writes of `writes` that changed the block's collision shape, in order:
// `sendBlockUpdated` compares the two shapes once per write, not per mob.
collision_changes :: proc(w: ^MobWorld, writes: ^[((i32) {
}
    // rust: writes
    // rust: .iter()
    // rust: .filter_map(|&((x, y, z), old, new)| {
    // rust: let at = [x, y, z];
    // rust: let shape =
    // rust: |state| w.collision_bounds_of(horizon_world::registry::BlockStateId(state), at);
    // rust: (shape(old) != shape(new)).then_some(at)
    // rust: })
    // rust: .collect()
}
// Adds the pending pushes aimed at `m` to its velocity, in push order.
apply_mob_pushes :: proc(m: ^Mob, pending: ^PendingPushes) {
}
    // Entity.push(x, y, z) sets needsSync.
    // rust: let mut add = |v: Vec3| {
    // rust: m.velocity = Vec3::new(m.velocity.x + v.x, m.velocity.y + v.y, m.velocity.z + v.z);
    // rust: m.needs_sync = true;
}
    // rust: if !pending.list.is_empty() {
    // rust: pending.list.retain(|(id, v)| {
    // rust: if *id != m.id {
    // rust: return true;
}
    // rust: add(*v);
    // rust: false
    // rust: });
}
    // rust: if !pending.by_mob.is_empty()
    // rust: && let Some(pushes) = pending.by_mob.remove(&m.id)
    // rust: {
    // rust: pushes.into_iter().for_each(add);
}
}
// Applies the brain memories a mob's tick set on other mobs (from event
// index `from` on), at once: vanilla sets them on the other entity during
// the tick, before the mobs after it tick.
apply_brain_events :: proc(mobs: ^[Mob], events: ^[dynamic]MobEvent, from: uint) {
}
    // rust: let mut i = from;
    // rust: while i < events.len() {
    // rust: match events[i] {
    // rust: MobEvent::BreedTarget { mob, partner } => {
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == mob) {
    // rust: animal_brain::set_breed_partner(m, partner);
}
    // rust: events.remove(i);
}
    // rust: MobEvent::LockGaze { mob, partner } => {
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == mob) {
    // rust: animal_brain::lock_gaze(m, partner);
    // rust: villager_brain::lock_gaze_half(m, Who::Mob(partner));
}
    // rust: events.remove(i);
}
    // rust: MobEvent::Retreat { mob, from, at } => {
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == mob) {
    // rust: piglin::receive_retreat(m, from, at);
}
    // rust: events.remove(i);
}
    // rust: MobEvent::StartRiding { rider, vehicle } => {
    // rust: riders::start_riding(mobs, rider, vehicle);
    // rust: events.remove(i);
}
    // rust: MobEvent::StartFollowing { fish, leader } => {
    // rust: aquatic::start_following(mobs, fish, leader);
    // rust: events.remove(i);
}
    // rust: MobEvent::SchoolSize { leader, by } => {
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == leader) {
    // rust: m.extra.followers += by;
}
    // rust: events.remove(i);
}
            // Animal.finalizeSpawnChildFromBreeding: the partner rests and
            // forgets it at once (the game still makes the baby).
    // rust: MobEvent::Breed {
    // rust: parent, partner, ..
    // rust: } => {
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == partner) {
    // rust: m.extra.age = 6000;
    // rust: m.extra.in_love = 0;
    // rust: animal_brain::forget_breed_target(m, parent);
}
    // rust: i += 1;
}
            // Pufferfish.touch: the poison and playSound sit inside the
            // hurtServer branch, so only a hit that landed poisons and stings.
            // In vanilla, this runs in Pufferfish.aiStep during the fish's tick,
            // so mobs ticking later in the same level tick tick their effects.
    // rust: MobEvent::PufferfishSting {
    // rust: mob,
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: poison_ticks,
    // rust: } => {
    // rust: let mut sound = None;
    // rust: let mut raised = Vec::new();
    // rust: let (aim, fish_pos, fish_silent) = mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map(|m| {
    // rust: (
    // rust: Aim {
    // rust: eye: [m.position.x, m.eye_y(), m.position.z],
    // rust: look: m.look_angle(),
    // rust: feet: [m.position.x, m.position.y, m.position.z],
    // rust: },
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.silent,
    // rust: )
    // rust: })
    // rust: .map(|(aim, pos, silent)| (Some(aim), Some(pos), silent))
    // rust: .unwrap_or((None, None, true));
    // rust: if let Some(t) = mobs.iter_mut().find(|m| m.id == target)
    // rust: && t.damage_aimed(amount, source, aim)
    // rust: {
    // rust: t.add_effect("minecraft:poison", poison_ticks, 0);
    // rust: raised = std::mem::take(&mut t.outbox);
    // rust: if !fish_silent && let Some(at) = fish_pos {
    // rust: sound = Some(MobEvent::Sound("entity.puffer_fish.sting", at, 1.0, 1.0));
}
}
    // rust: events.remove(i);
    // rust: if let Some(s) = sound {
    // rust: events.insert(i, s);
    // rust: i += 1;
}
    // rust: for e in raised {
    // rust: events.insert(i, e);
    // rust: i += 1;
}
}
    // rust: _ => i += 1,
}
}
}
// The player as mobs see it.
PlayerView :: struct {
    position: Vec3,
    bounds: Aabb,
    eye: [f64,
    alive: bool,
    creative: bool,
    sneaking: bool,
    // `Entity.isSwimming`.
    swimming: bool,
    look: [f64,
    main_hand: Maybe(^str),
    off_hand: Maybe(^str),
    head: Maybe(^str),
    // `getItemBySlot` for chest, legs and feet.
    chest: Maybe(^str),
    legs: Maybe(^str),
    feet: Maybe(^str),
    armor_cover: f32,
    // The Invisibility effect (`isInvisible`).
    invisible: bool,
    spectator: bool,
    // `PiglinAi.isWearingSafeArmor`: some golden armour.
    gold_armor: bool,
    // `getLastHurtByMob` (within 100 ticks) and when.
    hurt_by: Option<(Who,
    // `getLastHurtMob` and when.
    last_hurt: Option<(Who,
    velocity: Vec3,
    yaw: f32,
    // `Player.isSprinting` and `isPassenger` (what scares an armadillo).
    sprinting: bool,
    riding: bool,
    // The Hero of the Village effect.
    hero: bool,
    // The active effects, without namespace (`slowness`, `poison`...).
    effects: [dynamic]^'static str,
    // The player's UUID (villagers' gossip is keyed by it).
    uuid: [i32,
    // The mobs on the player's team (`isAlliedTo`): combat targeting
    // leaves the player alone.
    allies: std::sync::^std::collections::map[u32]struct{},
    // A LAN guest: its own client moves it, and touching mobs push it there
    // (`EntitySelector.pushableBy` on the client).
    remote: bool,
    // `isSleeping` and `getSleepTimer` (100 once slept through, then the
    // ticks fading out after waking up).
    sleeping: bool,
    sleep_timer: u32,
    // `isPassenger`.
    passenger: bool,
    // The vehicle entity id, including mounts without a `Vehicle` follow view.
    riding_vehicle: Maybe(u32),
    // The boat or nautilus the player rides and steers
    // (`getControllingPassenger`).
    vehicle: Maybe(Vehicle),
}
// What a player rides, for the mobs that follow it (`FollowPlayerRiddenEntityGoal`).
Vehicle :: struct {
    nautilus: bool,
    bounds: Aabb,
    // `Entity.getKnownSpeed`: what it moved in its last tick.
    velocity: Vec3,
}
    // rust: impl PlayerView {
    // Worn stacks in `EquipmentSlot.VALUES` order. A player has no body or
    // saddle slot.
worn_slots :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: ("mainhand", self.main_hand.as_deref()),
    // rust: ("offhand", self.off_hand.as_deref()),
    // rust: ("feet", self.feet.as_deref()),
    // rust: ("legs", self.legs.as_deref()),
    // rust: ("chest", self.chest.as_deref()),
    // rust: ("head", self.head.as_deref()),
    // rust: ]
}
    // `LivingEntity.getVisibilityPercent`: 1, ×0.8 while discrete
    // (`isShiftKeyDown`), ×0.7×armor cover (at least 0.1) while invisible,
    // then each worn stack's `minecraft:mob_visibility` when its equippable
    // slot matches and `targeting` is in `targetingEntityTypes`. Clamped to
    // 0..=10 (`Mth.clamp`). `targeting` is null when nobody is looking.
    // rust: pub fn visibility_percent(
    // rust: &self,
    // rust: targeting: Option<&str>,
    // rust: items: Option<&crate::items::Items>,
    // rust: ) -> f64 {
    // rust: let mut visibility = 1.0;
    // rust: if self.sneaking {
    // rust: visibility *= 0.8;
}
    // rust: if self.invisible {
    // rust: visibility *= 0.7 * f64::from(self.armor_cover).max(0.1);
}
    // rust: if let (Some(targeting), Some(items)) = (targeting, items) {
    // rust: for (slot, item) in self.worn_slots() {
    // rust: let Some(item) = item else { continue };
    // rust: if let Some(factor) = items.worn_visibility(item, slot, targeting) {
    // rust: visibility *= f64::from(factor);
}
}
}
        // `Mth.clamp`: value < min ? min : Math.min(value, max).
    // rust: if visibility < 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: visibility.min(10.0)
}
}
    // `LivingEntity.hasEffect`, by id without namespace.
has_effect :: proc(self: ^Self, effect: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.effects.contains(&effect)
}
}
MobWorld :: struct {
    world: ^'a World,
    registry: ^'a horizon_world::registry::BlockRegistry,
    facts: ^'a BlockFacts,
    // Fluid states and flow facts, for the currents that push mobs.
    fluid_tables: ^'a crate::motion::FluidResources,
    movement: ^'a horizon_world::movement_properties::BoundMovementProperties,
    collision: ^'a BlockCollisionRegistry<'a>,
    suffocation: ^'a horizon_world::suffocation::SuffocationRegistry<'a>,
    data: ^'a MobData,
    player: Maybe(PlayerView),
    // `getKnownMovement` of a mob's controlling player passenger, if any.
    controlling_player_movement: Maybe(Vec3),
    // `getNearestPlayer(mob, -1)`: where the nearest non-spectator of every
    // player in the level stands, alive or not (the despawn distance).
    nearest_player: Maybe(Vec3),
    others: ^'a [Seen],
    // The separately simulated dragon, visible to revenge and melee goals.
    dragon: Option<(u32,
    // The boats and rafts a lead can hang on (`Holder::Boat`): id and state.
    leash_boats: ^'a [(u32,
    // `others` by position, when the caller keeps one (the mob ticks).
    others_grid: Maybe(^'a seen_grid::SeenGrid),
    // Where each id stands in `others`, when the caller keeps one.
    others_index: Option<^'a crate::fast_hash::FxHashMap<u32,
    // The slots of `others` holding a villager, in order, when the caller
    // keeps them (the mob ticks: a slot keeps its mob, and its species, all
    // tick). Each zombie looking for a village read every slot.
    others_villagers: Maybe(^'a [u32]),
    daylight: bool,
    // The `gameplay/monsters_burn` attribute: the overworld day timeline's
    // step track, false in every other dimension.
    monsters_burn: bool,
    game_time: i64,
    day_time: i64,
    raining: bool,
    thundering: bool,
    nether: bool,
    block_tags: ^'a HashMap<string,
    // Each block's `fallOn` rule (the player's landing registry).
    landing: ^'a horizon_world::block_landing::BlockLandingRegistry,
    biomes: ^'a crate::biome::Biomes,
    // The `mob_griefing` game rule.
    mob_griefing: bool,
    // The `universal_anger` game rule (`NeutralMob.isAngryAtAllPlayers`).
    universal_anger: bool,
    // The `mob_drops` game rule (`shouldDropLoot`).
    mob_drops: bool,
    // The `max_entity_cramming` game rule.
    max_entity_cramming: i32,
    // `getCurrentDifficultyAt` at the mob being ticked (near the player
    // outside the mob tick).
    difficulty: spawning::LocalDifficulty,
    // The End (its dimension type's monster spawn light rules).
    end: bool,
    // The world seed (slime chunks).
    world_seed: i64,
    // `Level.getSeaLevel` (63 in the overworld, -63 in a flat world).
    sea_level: i32,
    // The scoreboard teams of the player and the mobs (collision rules),
    // shared: the mob ticks build them once a tick, not once a mob.
    teams: std::sync::^Teams<'a>,
    // Item data (max stack sizes), when the host has it.
    items: Maybe(^'a crate::items::Items),
    // `ChestBlockEntity.getOpenCount`: the players with each chest open.
    lid_openers: ^'a HashMap<(i32,
    // What a content mod's effects do, on a server (None on a client).
    mod_effects: Maybe(^'a dyn ModEffectTicks),
    // The level's world border, whose walls stop a mob's moves
    // (`Entity.collectColliders`); None: nothing stops them there.
    border: Maybe(^'a horizon_core::geometry::border::BorderGeometry),
}
// `MobEffectInstance.tickServer` for a content mod's effect: its
// `shouldApplyEffectTickThisTick` and `applyEffectTick`, which the game's
// native mods answer. False removes the effect.
    // rust: pub trait ModEffectTicks {
tick_mod_effect :: proc(self: ^Self, effect: string, mob: u32, tick_count: i32, amplifier: i32) -> b {
    // Ported from Horizon
    return {}
}
}
// `Entity.getTeam` of the player and of the mobs on a team.
Teams :: struct {
    player: Maybe(^'a crate::scoreboard::Team),
    mobs: HashMap<u32,
}
    // rust: impl<'a> Teams<'a> {
of :: proc(self: ^Self, who: Who) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match who {
    // rust: Who::Player => self.player,
    // rust: Who::Mob(id) => self.mobs.get(&id).copied(),
}
}
}
// `Entity.random` of a client's copy of entity `id` first seen at `position`: vanilla's is its
// own (`RandomSource.create()`), drawn on by nothing else; this one is seeded from the two.
entity_random :: proc(id: u32, position: Vec3) -> L {
    // Ported from Horizon
    return {}
}
    // rust: let mut random = LegacyRandom::new(
    // rust: i64::from(id).wrapping_mul(0x5DEE_CE66D)
    // rust: ^ (position.x.to_bits() as i64)
    // rust: ^ (position.z.to_bits() as i64).rotate_left(17),
    // rust: );
    // rust: let _ = random.next_int();
    // rust: random
}
    // rust: impl Mob {
new :: proc(id: u32, kind: ^MobType, position: Vec3, yaw: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let random = entity_random(id, position);
    // rust: let mut mob = Self {
    // rust: join: Default::default(),
    // rust: id,
    // rust: health: kind.max_health,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw,
    // rust: previous_yaw: yaw,
    // rust: body_yaw: yaw,
    // rust: previous_body_yaw: yaw,
    // rust: head_yaw: yaw,
    // rust: previous_head_yaw: yaw,
    // rust: head_pitch: 0.0,
    // rust: previous_head_pitch: 0.0,
    // rust: on_ground: false,
    // rust: horizontal_collision: false,
    // rust: vertical_collision_below: false,
    // rust: needs_sync: false,
    // rust: gear_knockback_resistance: None,
    // rust: hurt_time: 0,
    // rust: invulnerable: 0,
    // rust: death_time: 0,
    // rust: age: 0,
    // rust: limb_position: 0.0,
    // rust: limb_speed: 0.0,
    // rust: previous_limb_speed: 0.0,
    // rust: swell: 0,
    // rust: previous_swell: 0,
    // rust: max_swell: 30,
            // Mob.ambientSoundTime starts at 0.
    // rust: ambient_timer: 0,
    // rust: fall_distance: 0.0,
    // rust: stuck_multiplier: Vec3::ZERO,
    // rust: piston: Default::default(),
    // rust: persistent: false,
    // rust: random,
    // rust: ai: Box::default(),
    // rust: extra: Extra::default(),
    // rust: fluids: living::Fluids::default(),
    // rust: was_eye_in_water: false,
    // rust: first_tick: true,
    // rust: no_gravity: false,
    // rust: supporting: None,
    // rust: standing_on: None,
    // rust: no_ai: false,
    // rust: silent: false,
    // rust: invulnerable_flag: false,
    // rust: attacker_aim: None,
    // rust: projectile_motion: None,
    // rust: climbing: false,
    // rust: on_climbable: false,
    // rust: fire_ticks: 0,
    // rust: ticks_frozen: 0,
    // rust: glowing: false,
    // rust: air: 300,
    // rust: last_hurt: 0.0,
    // rust: absorption: 0.0,
    // rust: dealt_absorbed: 0,
    // rust: last_damage: None,
    // rust: last_direct: None,
    // rust: combat: combat::Tracker::default(),
    // rust: removed: false,
    // rust: custom_name: None,
    // rust: custom_name_text: None,
    // rust: name_visible: false,
    // rust: invisible: false,
    // rust: anim: anim::AnimState::default(),
    // rust: rider: None,
    // rust: outbox: Vec::new(),
    // rust: skin: None,
    // rust: slim: false,
    // rust: skin_3d: None,
    // rust: cape: None,
    // rust: emote: None,
    // rust: profile: None,
    // rust: random_textures: Default::default(),
    // rust: attrs: Attrs {
    // rust: speed: kind.speed,
    // rust: attack_damage: kind.attack_damage,
    // rust: attack_knockback: kind.attack_knockback,
    // rust: max_health: kind.max_health,
    // rust: follow_range: kind.follow_range,
    // rust: knockback_resistance: kind.knockback_resistance,
    // rust: spawn_reinforcements: kind
    // rust: .attributes
    // rust: .get("minecraft:spawn_reinforcements")
    // rust: .copied()
    // rust: .unwrap_or(0.0),
    // rust: jump_strength: kind.jump_strength,
    // rust: },
    // rust: kind,
}
        // setCanPickUpLoot(true) in the Villager, AbstractPiglin, Dolphin,
        // Fox and Panda constructors (an allay's is false until it holds
        // something: it overrides canPickUpLoot).
    // rust: mob.extra.pick_up_loot = matches!(
    // rust: mob.species(),
    // rust: Species::Villager
    // rust: | Species::Piglin
    // rust: | Species::PiglinBrute
    // rust: | Species::Dolphin
    // rust: | Species::Fox
    // rust: | Species::Panda
    // rust: );
        // Salmon.defineSynchedData: DATA_TYPE starts at Variant.DEFAULT (MEDIUM,
        // id 1), so a salmon finalizeSpawn never sized keeps the type's box.
    // rust: if mob.species() == Species::Salmon {
    // rust: mob.extra.variant = 1;
}
        // The PathNavigation constructor: the base follow range.
    // rust: mob.ai.nav.max_visited_nodes = (mob.kind.follow_range * 16.0).floor() as i32;
    // rust: ai::register(&mut mob);
    // rust: mob
}
    // `Mob.canPickUpLoot`, with the overrides: an allay that holds
    // something off its pickup cooldown, a sulfur cube with no block.
can_pick_up_loot :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.species() {
    // rust: Species::Allay => self.extra.main_hand.is_some() && self.extra.ints[3] <= 0,
    // rust: Species::SulfurCube => !sulfur_cube::has_body(self),
    // rust: _ => self.extra.pick_up_loot,
}
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds_at(self.position)
}
    // `Entity.makeBoundingBox(position)`.
bounds_at :: proc(self: ^Self, position: Vec3) -> A {
    // Ported from Horizon
    return {}
}
        // `width()` and `height()` in one `dims()`: every box asked for (each
        // collision, push and cart test) read the whole size twice.
    // rust: let (width, height, _) = self.dims();
    // rust: let w = f64::from(width as f32) / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(position.x - w, position.y, position.z - w),
    // rust: Vec3::new(
    // rust: position.x + w,
    // rust: position.y + f64::from(height as f32),
    // rust: position.z + w,
    // rust: ),
    // rust: )
}
    // `CombatTracker.recordDamage`: a hit that took `damage` health, with
    // the fall it ends.
record_damage :: proc(self: ^Self, source: Damage, damage: f32) {
}
    // rust: let entry = combat::Entry {
    // rust: source,
    // rust: damage,
    // rust: in_water: self.fluids.in_water,
    // rust: fall_distance: self.fall_distance as f32,
}
    // rust: self.combat.record(entry, self.age);
}
alive :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.health > 0.0
}
hostile :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.kind.category == "monster"
}
species :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.kind.species
}
    // Entity.getMaxAirSupply and the aquatic species' overrides.
max_air_supply :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self.species() {
    // rust: Species::Axolotl => axolotl::MAX_AIR,
    // rust: Species::Dolphin => 4800,
    // rust: _ => 300,
}
}
    // `Mob.getMainArm`: the left arm when the mob is left-handed, a player's
    // `mainHand` option for a player mob.
main_arm_left :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.extra.main_hand_left || self.extra.left_handed
}
    // The player hit this mob (melee): LivingEntity.hurt with knockback.
    // rust: pub fn hurt(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: from: Option<[f64; 3]>,
    // rust: _random: &mut LegacyRandom,
    // rust: ) -> bool {
    // rust: let source = match from {
    // rust: Some(f) => Damage::player(f),
    // rust: None => Damage::of(DamageKind::Generic),
}
    // rust: self.damage(amount, source)
}
    // LivingEntity.hurtServer: invulnerability frames, armor, knockback and
    // the last-hurt-by bookkeeping goals read.
    // The `armor` and `armor_toughness` modifiers of worn humanoid armour.
worn_armor :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
        // An equine keeps its horse armor in `extra.body`: the item's `armor`
        // and `armor_toughness` modifiers of the body slot.
    // rust: if equine::is_equine(self.species()) {
    // rust: return self
    // rust: .extra
    // rust: .body
    // rust: .as_deref()
    // rust: .map_or((0.0, 0.0), spawning::horse_armor_stats);
}
    // rust: [
    // rust: &self.extra.head,
    // rust: &self.extra.chest,
    // rust: &self.extra.legs,
    // rust: &self.extra.feet,
    // rust: ]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|i| spawning::armor_stats(i))
    // rust: .fold((0.0, 0.0), |(a, t), (x, y)| (a + x, t + y))
}
    // `damage` of a blow whose causing entity is `aim` (`SulfurCube.knockback` reads it).
damage_aimed :: proc(self: ^Self, amount: f32, source: Damage, aim: Maybe(Aim)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.attacker_aim = aim;
    // rust: let hurt = self.damage(amount, source);
    // rust: self.attacker_aim = None;
    // rust: hurt
}
    // `damage` of a blow dealt by a projectile (`motion`: its horizontal movement) whose owner
    // is `aim`.
    // rust: pub fn damage_projectile(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: source: Damage,
    // rust: aim: Option<Aim>,
    // rust: motion: [f64; 2],
    // rust: ) -> bool {
    // rust: self.projectile_motion = Some(motion);
    // rust: let hurt = self.damage_aimed(amount, source, aim);
    // rust: self.projectile_motion = None;
    // rust: hurt
}
damage :: proc(self: ^Self, amount: f32, source: Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.damage_with(amount, source, None)
}
    // `LivingEntity.isInvulnerableTo` and dead or removed: only #bypasses_invulnerability gets
    // past the flag. The guard every damage hook runs after (`LivingIncomingDamageEvent`).
refuses_damage :: proc(self: ^Self, source: ^Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.alive()
    // rust: || self.removed
    // rust: || (self.invulnerable_flag && !source.kind.bypasses_invulnerability())
}
    // `LivingEntity.hurtServer`'s partial mob adapter, with health reductions inline.
    // `damage` by a source with a weapon: `armor_effectiveness` runs the
    // weapon's armor-effectiveness enchantments (breach) over the armor fraction.
    // rust: pub fn damage_with(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: source: Damage,
    // rust: armor_effectiveness: Option<&mut dyn FnMut(f32) -> f32>,
    // rust: ) -> bool {
    // rust: self.damage_with_player_context(amount, source, armor_effectiveness, None)
}
    // The same damage pipeline with a verified causing-player UUID. Unresolved
    // callers keep using `damage_with`, including its legacy Allay filter.
    // rust: pub fn damage_with_player_uuid(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: source: Damage,
    // rust: uuid: [i32; 4],
    // rust: armor_effectiveness: Option<&mut dyn FnMut(f32) -> f32>,
    // rust: ) -> bool {
    // rust: self.damage_with_player_context(amount, source, armor_effectiveness, Some(uuid))
}
    // `LivingEntity.hurtServer`'s shared partial mob adapter. The optional
    // identity only selects the species filter; the health pipeline is shared.
    // rust: fn damage_with_player_context(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: source: Damage,
    // rust: armor_effectiveness: Option<&mut dyn FnMut(f32) -> f32>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: ) -> bool {
    // rust: axolotl::before_damage(self, amount, &source);
    // rust: raider::note_hurt(self);
        // SulfurCube.hurtServer: the priming and a block's immune knockback
        // come before LivingEntity's checks, so a primed (invulnerable) cube
        // is still knocked about.
    // rust: if self.species() == Species::SulfurCube
    // rust: && !sulfur_cube::accepts_damage(self, &source, amount)
    // rust: {
            // `SulfurCube.hurtServer` returns true for the blows it shrugs off and only knocks
            // about, so `Player.attack` goes on with its extra knockback and its aftermath.
    // rust: return sulfur_cube::immune_to(&source);
}
    // rust: if self.refuses_damage(&source) {
    // rust: return false;
}
        // Ghast.isReflectedFireball: a fireball a player turned back is
        // no fire to it, and kills it (Ghast.hurtServer: 1000 damage).
    // rust: let reflected = &*self.kind.id == "minecraft:ghast"
    // rust: && source.kind == DamageKind::Fireball
    // rust: && source.attacker == Some(Who::Player);
    // rust: if source.is_fire() && (self.kind.flags.fire_immune) && !reflected {
    // rust: return false;
}
    // rust: let accepts = match player_uuid {
    // rust: Some(uuid) => ai::accepts_damage_from_player(self, &source, amount, uuid),
    // rust: None => ai::accepts_damage(self, &source, amount),
}
    // rust: if !accepts {
    // rust: return false;
}
        // LivingEntity.hurtServer refuses fire before hooks and damage processing.
    // rust: if source.is_fire() && self.has_effect("minecraft:fire_resistance") {
            // Ghast.hurtServer reports success for a reflected fireball even
            // when LivingEntity refuses its health damage.
    // rust: return reflected;
}
        // IronGolem.hurtServer: the crack level before the damage, compared after.
    // rust: let crackiness = (self.species() == Species::IronGolem).then(|| golem::crackiness(self));
    // rust: let mut amount = if reflected { 1000.0 } else { amount };
    // rust: if self.species() == Species::Armadillo {
    // rust: amount = armadillo::reduce_damage(self, amount);
}
        // LivingEntity.hurtServer, past its guards: a native mod's hook.
    // rust: if crate::health::hurt_server_canceled(
    // rust: crate::health::Hurting::Mob(self, &source),
    // rust: &mut amount,
    // rust: ) {
            // Ghast.hurtServer: true for a reflected fireball whatever
            // super.hurtServer did.
    // rust: return reflected;
}
    // rust: if amount < 0.0 {
    // rust: amount = 0.0;
}
        // #damages_helmet: falling anvils, blocks and stalactites.
    // rust: if matches!(
    // rust: source.kind,
    // rust: DamageKind::FallingBlock | DamageKind::FallingAnvil | DamageKind::FallingStalactite
    // rust: ) && !species::body_slot(self.species())
    // rust: && self.extra.head.is_some()
    // rust: {
    // rust: amount *= 0.75;
}
        // LivingEntity.hurtServer: `#freeze_hurts_extra_types` take five times.
    // rust: if source.kind == DamageKind::Freeze
    // rust: && matches!(
    // rust: self.species(),
    // rust: Species::Strider | Species::Blaze | Species::MagmaCube
    // rust: )
    // rust: {
    // rust: amount *= 5.0;
}
    // rust: if !amount.is_finite() {
    // rust: amount = f32::MAX;
}
        // LivingEntity.getDamageAfterArmorAbsorb asks `hurtArmor` *before*
        // `CombatRules.getDamageAfterAbsorb`, so a worn piece wears by the
        // damage the armour, toughness and enchantment reductions have not
        // touched yet, and only a hit outside `#bypasses_armor` asks at all.
    // rust: let armor_hit = (!source.bypasses_armor() && amount > 0.0).then_some(amount);
    // rust: if !source.bypasses_armor() {
    // rust: let (armor, armor_toughness) = armor::values(self);
    // rust: if armor > 0.0 {
                // CombatRules.getDamageAfterAbsorb
    // rust: let toughness = 2.0 + armor_toughness / 4.0;
    // rust: let effective = (armor - amount / toughness).clamp(armor * 0.2, 20.0);
    // rust: let mut fraction = effective / 25.0;
    // rust: if let Some(modify) = armor_effectiveness {
    // rust: fraction = modify(fraction).clamp(0.0, 1.0);
}
    // rust: amount *= 1.0 - fraction;
}
}
        // CombatRules.getDamageAfterMagicAbsorb: enchantment protection.
    // rust: let epf = gear::protection(self, source.kind);
    // rust: if epf > 0.0 {
    // rust: amount *= 1.0 - epf / 25.0;
}
        // LivingEntity.getDamageAfterMagicAbsorb: Resistance takes 20% per level off
        // (`#bypasses_resistance` and `#bypasses_effects` skip it).
    // rust: if !source.kind.bypasses_effects()
    // rust: && !source.kind.bypasses_resistance()
    // rust: && let Some(&(_, _, amp)) = self
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == "minecraft:resistance")
    // rust: {
    // rust: let remainder = 25i32.wrapping_sub(amp.wrapping_add(1).wrapping_mul(5));
    // rust: amount = (amount * remainder as f32 / 25.0).max(0.0);
            // actuallyHurt is void: zero health damage still lets hurtServer set hurt state.
}
        // Witch.getDamageAfterMagicAbsorb: none from its own doing, else
        // 85% less from `#witch_resistant_to`.
    // rust: if self.species() == Species::Witch {
    // rust: if source.attacker == Some(Who::Mob(self.id)) {
    // rust: amount = 0.0;
    // rust: } else if matches!(
    // rust: source.kind,
    // rust: DamageKind::Magic
    // rust: | DamageKind::IndirectMagic
    // rust: | DamageKind::SonicBoom
    // rust: | DamageKind::Thorns
    // rust: ) {
    // rust: amount *= 0.15;
}
}
        // Wolf.actuallyHurt: wolf armor takes the damage instead of the wolf.
    // rust: let absorbed = self.wolf_armor_absorbs(&source);
    // rust: let mut knock = true;
    // rust: let dealt = if self.invulnerable as f32 > 10.0 {
    // rust: if amount <= self.last_hurt {
    // rust: return false;
}
    // rust: let dealt = amount - self.last_hurt;
    // rust: if absorbed {
    // rust: self.hurt_wolf_armor(dealt);
    // rust: } else {
    // rust: let dealt = self.soak_hit(dealt, &source);
    // rust: self.health -= dealt;
}
    // rust: self.last_hurt = amount;
    // rust: knock = false;
    // rust: dealt
    // rust: } else {
    // rust: self.last_hurt = amount;
    // rust: self.invulnerable = 20;
    // rust: if absorbed {
    // rust: self.hurt_wolf_armor(amount);
    // rust: } else {
    // rust: let through = self.soak_hit(amount, &source);
    // rust: self.health -= through;
}
    // rust: self.hurt_time = 10;
    // rust: amount
}
        // LivingEntity.actuallyHurt: a hit that reaches the health is
        // recorded (`CombatTracker.recordDamage`), with the fall it ends;
        // Wolf.actuallyHurt keeps a hit its armor takes out of it.
    // rust: if !absorbed && dealt != 0.0 {
    // rust: self.record_damage(source, dealt);
}
        // LivingEntity.hurtArmor: `Horse` is the only mob that overrides it, and
        // it hands `doHurtEquipment` the body slot alone. A wolf's armour has
        // its own rule (`Wolf.actuallyHurt`, `hurt_wolf_armor`) and a player's
        // four pieces theirs, so the other "body slot" species — donkey, mule,
        // llama, camel, the skeleton and zombie horses — wear nothing.
    // rust: if let Some(damage) = armor_hit
    // rust: && self.species() == Species::Horse
    // rust: && self.extra.body.is_some()
    // rust: {
    // rust: self.outbox.push(MobEvent::ArmorHurt {
    // rust: mob: self.id,
    // rust: amount: damage,
    // rust: kind: source.kind,
    // rust: });
}
        // Animal.actuallyHurt: damage taken ends love mode (`resetLove`).
    // rust: if drops::is_animal(self.species()) {
    // rust: self.extra.in_love = 0;
}
    // rust: self.last_damage = Some((source, i64::from(self.age)));
    // rust: self.last_direct = None;
    // rust: if let Some(who) = source.attacker {
    // rust: self.ai.last_hurt_by = Some(who);
    // rust: self.ai.last_hurt_by_time = self.age as i32;
    // rust: if who == Who::Player {
    // rust: self.ai.last_hurt_by_player = 100;
}
}
        // dealDefaultKnockback, unless the damage type is tagged no_knockback;
        // a source without a position knocks in a random direction.
    // rust: if knock && !source.no_knockback() {
            // dealDefaultKnockback: a projectile knocks the way it travelled
            // (`calculateHorizontalHurtKnockbackDirection`), else from the source's position.
    // rust: let (dx, dz) = match self.projectile_motion {
    // rust: Some([x, z]) => (-x, -z),
    // rust: None => source.from.map_or((0.0, 0.0), |f| {
    // rust: (f[0] - self.position.x, f[2] - self.position.z)
    // rust: }),
}
    // rust: self.knockback(f64::from(0.4f32), dx, dz, &source);
}
    // rust: ai::after_hurt(self, &source);
    // rust: if self.health <= 0.0 {
    // rust: self.health = 0.0;
            // `LivingEntity.hurtServer`: a killing blow is taken by a
            // `death_protection` item in either hand instead of dying.
    // rust: self.use_death_protection(&source);
}
    // rust: if knock {
            // playHurtSound (Mob: also resets the ambient sound clock) or the
            // death sound: makeSound draws the voice pitch whenever there is a sound.
    // rust: let dead = !self.alive();
            // Wolf.getHurtSound: the armor's own sound when it takes the hit.
    // rust: let sound = if absorbed {
    // rust: "item.wolf_armor.damage"
    // rust: } else {
    // rust: ai::voice_sounds(self)[if dead { 2 } else { 1 }]
}
    // rust: if !dead {
    // rust: self.ambient_timer = -self.ambient_interval();
}
    // rust: if !sound.is_empty() {
    // rust: let pitch = self.voice_pitch();
    // rust: if !self.silent {
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: self.outbox
    // rust: .push(MobEvent::Sound(sound, at, ai::sound_volume(self), pitch));
}
}
}
        // IronGolem.hurtServer: a new crack level plays the damage sound.
    // rust: if let Some(before) = crackiness
    // rust: && before != golem::crackiness(self)
    // rust: && !self.silent
    // rust: {
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: self.outbox
    // rust: .push(MobEvent::Sound("entity.iron_golem.damage", at, 1.0, 1.0));
}
    // rust: if self.has_effect("minecraft:infested") {
    // rust: self.outbox.push(MobEvent::Infested { mob: self.id });
}
        // Squid.hurtServer: a squid hurt after a living entity hit it squirts ink.
    // rust: if matches!(self.species(), Species::Squid | Species::GlowSquid)
    // rust: && self.ai.last_hurt_by.is_some()
    // rust: {
    // rust: aquatic::spawn_ink(self);
}
        // AbstractHorse.hurtServer: the rear roll after the hurt.
    // rust: if equine::is_equine(self.species()) {
    // rust: equine::after_hurt_server(self);
}
        // GlowSquid.hurtServer dims the squid only when Squid.hurtServer took the
        // hit, which it reports only for a living entity's blow: environmental
        // damage (suffocation, a campfire, drying out) leaves the glow alone.
    // rust: if self.species() == Species::GlowSquid && self.ai.last_hurt_by.is_some() {
    // rust: aquatic::hurt_server(self);
}
    // rust: true
}
    // `damage` by a source whose direct entity is `direct` (an entity type id), which `source`
    // cannot carry: `DamageSources.indirectMagic(potion or cloud, owner)`.
damage_by :: proc(self: ^Self, amount: f32, source: Damage, direct: ^'static str) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let hurt = self.damage(amount, source);
    // rust: if hurt {
    // rust: self.last_direct = Some(direct);
}
    // rust: hurt
}
    // `Wolf.canArmorAbsorb`: it wears wolf armor and the damage type is not
    // in `#bypasses_wolf_armor` (drowning, magic, thorns, in a wall, out of
    // the world and the untyped kills).
wolf_armor_absorbs :: proc(self: ^Self, source: ^Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.species() == Species::Wolf
    // rust: && self.extra.body.as_deref() == Some("minecraft:wolf_armor")
    // rust: && !matches!(
    // rust: source.kind,
    // rust: DamageKind::Drown
    // rust: | DamageKind::Magic
    // rust: | DamageKind::IndirectMagic
    // rust: | DamageKind::InWall
    // rust: | DamageKind::Thorns
    // rust: | DamageKind::OutOfWorld
    // rust: | DamageKind::Cramming
    // rust: | DamageKind::Generic
    // rust: | DamageKind::GenericKill
    // rust: | DamageKind::OutsideBorder
    // rust: | DamageKind::Starve
    // rust: | DamageKind::Wither
    // rust: )
}
    // `Wolf.actuallyHurt`: the armor loses `ceil(damage)` durability, cracks
    // at `Crackiness.WOLF_ARMOR` steps and breaks at its maximum.
hurt_wolf_armor :: proc(self: ^Self, damage: f32) {
}
    // rust: let crack = |lost: i32| {
    // rust: let left = (WOLF_ARMOR_DURABILITY - lost) as f32 / WOLF_ARMOR_DURABILITY as f32;
    // rust: [0.95_f32, 0.69, 0.32].iter().filter(|t| left < **t).count()
}
    // rust: let before = self.extra.body_damage;
    // rust: let after = before + damage.ceil() as i32;
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: if after >= WOLF_ARMOR_DURABILITY {
    // rust: self.extra.body = None;
    // rust: self.extra.body_damage = 0;
    // rust: self.extra.body_extra = None;
    // rust: self.outbox
    // rust: .push(MobEvent::Sound("item.wolf_armor.break", at, 1.0, 1.0));
    // rust: } else {
    // rust: self.extra.body_damage = after;
    // rust: if crack(before) != crack(after) {
    // rust: self.outbox
    // rust: .push(MobEvent::Sound("item.wolf_armor.crack", at, 1.0, 1.0));
                // Twenty scutes fly off, a block above the wolf's feet.
    // rust: self.outbox.push(MobEvent::ItemParticles {
    // rust: item: "minecraft:armadillo_scute",
    // rust: at: [at[0], at[1] + 1.0, at[2]],
    // rust: spread: [0.2, 0.1, 0.2],
    // rust: speed: 0.1,
    // rust: count: 20,
    // rust: });
}
}
}
    // LivingEntity.knockback(power, xd, zd, source) towards the negative
    // direction. `Creaking.knockback`: a creaking that cannot move is not
    // shoved. The native knockback hook runs once the knockback resistance
    // took its share, before the motion changes and the draws of a random
    // direction.
knockback :: proc(self: ^Self, power: f64, xd: f64, zd: f64, source: ^Damage) {
}
    // rust: self.knockback_by(power, xd, zd, source, None);
}
    // `LivingEntity.knockback(power, xd, zd, source, damage, comesFromEffect = true)`: an extra
    // push of a blow (sprint, the Knockback enchantment). A sulfur cube with a block turns it
    // into its own launch (`SulfurCube.knockback`), scaled by `power * 0.25` and `sqrt(damage)`.
knockback_effect :: proc(self: ^Self, power: f64, xd: f64, zd: f64, source: ^Damage, damage: f32) {
}
    // rust: self.knockback_by(power, xd, zd, source, Some(damage));
}
    // `getAttributeValue(KNOCKBACK_RESISTANCE)`: the mob's own, and what its gear adds.
knockback_resistance :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.gear_knockback_resistance
    // rust: .unwrap_or(self.attrs.knockback_resistance)
}
knockback_by :: proc(self: ^Self, power: f64, xd: f64, zd: f64, source: ^Damage, effect: Maybe(f32)) {
}
    // rust: if let Some(damage) = effect
    // rust: && self.species() == Species::SulfurCube
    // rust: && sulfur_cube::has_body(self)
    // rust: && source.attacker.is_some()
    // rust: && sulfur_cube::knockback(self, (xd, zd), source.from, damage, Some(power))
    // rust: {
    // rust: return;
}
    // rust: if creaking::is_creaking(self) && !creaking::can_move(self) {
    // rust: return;
}
        // The native hook runs first, on the raw strength (NeoForge's `LivingKnockBackEvent` fires
        // at the start of `LivingEntity.knockback`), then the resistance scales what it left.
    // rust: let mut knock = crate::health::Knock {
    // rust: strength: power,
    // rust: x: xd,
    // rust: z: zd,
}
    // rust: if crate::health::knockback_canceled(crate::health::Hurting::Mob(self, source), &mut knock)
    // rust: {
    // rust: return;
}
    // rust: let crate::health::Knock {
    // rust: strength: power,
    // rust: x: mut xd,
    // rust: z: mut zd,
    // rust: } = knock;
    // rust: let power = power * (1.0 - self.knockback_resistance());
    // rust: if power <= 0.0 {
    // rust: return;
}
    // rust: self.needs_sync = true;
    // rust: while xd * xd + zd * zd < f64::from(1.0e-5_f32) {
    // rust: xd = (self.random.next_double() - self.random.next_double()) * 0.01;
    // rust: zd = (self.random.next_double() - self.random.next_double()) * 0.01;
}
    // rust: let len = (xd * xd + zd * zd).sqrt();
    // rust: let (kx, kz) = (xd / len * power, zd / len * power);
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x / 2.0 - kx,
    // rust: if self.on_ground {
    // rust: (self.velocity.y / 2.0 + power).min(0.4)
    // rust: } else {
    // rust: self.velocity.y
    // rust: },
    // rust: self.velocity.z / 2.0 - kz,
    // rust: );
}
    // One game tick. Returns false once the mob should be removed.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> bool {
    // rust: self.track_section();
        // LivingEntity.tick: CombatTracker.recheckStatus.
    // rust: let alive = self.alive();
    // rust: self.combat.recheck(alive, self.age);
    // rust: ai::tick(self, w, level_random, events)
}
    // The section the mob is in, noted when it changes (`EntitySection` lists).
track_section :: proc(self: ^Self) {
}
SEQUENCE :: std::sync::atomic::AtomicU64::new(1)
    // rust: let section = [
    // rust: (self.position.x.floor() as i32) >> 4,
    // rust: (self.position.y.floor() as i32) >> 4,
    // rust: (self.position.z.floor() as i32) >> 4,
    // rust: ];
    // rust: if self.extra.section_seq == 0 || section != self.extra.section {
    // rust: self.extra.section = section;
    // rust: self.extra.section_seq = SEQUENCE.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
}
}
distance_to :: proc(self: ^Self, p: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let d = [
    // rust: p[0] - self.position.x,
    // rust: p[1] - self.position.y,
    // rust: p[2] - self.position.z,
    // rust: ];
    // rust: (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt()
}
distance_sqr :: proc(self: ^Self, p: Vec3) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (p.x - self.position.x).powi(2)
    // rust: + (p.y - self.position.y).powi(2)
    // rust: + (p.z - self.position.z).powi(2)
}
    // Movement speed attribute bonus (baby zombies, sprinting modifiers).
    // MOVEMENT_SPEED including effects (speed +20%/level, slowness -15%/level).
movement_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = strider::movement_speed(
    // rust: self,
    // rust: witch::speed(self, self.attrs.speed) + enderman::attacking_speed(self),
    // rust: ) * self.speed_bonus();
        // LivingEntity.SPEED_MODIFIER_SPRINTING: 0.3F, ADD_MULTIPLIED_TOTAL.
    // rust: if self.extra.sprinting {
    // rust: v *= 1.0 + f64::from(0.3f32);
}
    // rust: for (e, _, amp) in &self.extra.effects {
    // rust: match *e {
    // rust: "minecraft:speed" => v *= 1.0 + 0.2 * f64::from(amp + 1),
    // rust: "minecraft:slowness" => v *= (1.0 - 0.15 * f64::from(amp + 1)).max(0.0),
    // rust: _ => {}
}
}
    // rust: v
}
has_effect :: proc(self: ^Self, effect: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.extra.effects.iter().any(|e| e.0 == effect)
}
    // `LivingEntity.isCurrentlyGlowing`: the Glowing effect or the `Glowing` tag (on a
    // server's client, `glowing` holds shared flag 6 instead).
is_currently_glowing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.glowing || self.has_effect("minecraft:glowing")
}
    // `Entity.isInvisible`: the shared flag 0x20 a server sends (`invisible`),
    // or the Invisibility effect on a mob this game ticks itself.
is_invisible :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.invisible || self.has_effect("minecraft:invisibility")
}
    // `LivingEntity.addEffect` of a `MobEffectInstance` with its flags: the effect as
    // `add_effect` has it, and `MobEffectInstance.update`'s rules for the flags of one already
    // there: it takes the new ambient flag when the new one is not ambient or the effect
    // changed, and always the new visibility. Returns whether the active instance or its
    // flags changed (`MobEffectInstance.update` does not count a hidden-chain-only update).
    // rust: pub fn add_effect_with(
    // rust: &mut self,
    // rust: effect: &'static str,
    // rust: ticks: i32,
    // rust: amplifier: i32,
    // rust: ambient: bool,
    // rust: visible: bool,
    // rust: ) -> bool {
    // rust: let effect = horizon_client_core::potions::namespaced(effect);
    // rust: let was_visible = !self.extra.hidden_effects.contains(&effect);
    // rust: let before = self
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == effect)
    // rust: .map(|e| (e.1, e.2));
    // rust: self.add_effect(effect, ticks, amplifier);
    // rust: let after = self
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == effect)
    // rust: .map(|e| (e.1, e.2));
    // rust: let present_ambient = self.extra.ambient_effects.contains(&effect);
        // A new effect takes its flags as they are; one already there by update's rules.
    // rust: let take_ambient = match before {
    // rust: None => true,
    // rust: Some(_) => (!ambient && present_ambient) || before != after,
}
    // rust: if take_ambient {
    // rust: self.extra.ambient_effects.retain(|h| *h != effect);
    // rust: if ambient {
    // rust: self.extra.ambient_effects.push(effect);
}
}
    // rust: self.extra.hidden_effects.retain(|h| *h != effect);
    // rust: if !visible {
    // rust: self.extra.hidden_effects.push(effect);
}
    // rust: after.is_some()
    // rust: && (before != after
    // rust: || present_ambient != self.extra.ambient_effects.contains(&effect)
    // rust: || was_visible != visible)
}
    // [`Mob::soak_absorption`] for a hit from `source`: `LivingEntity.actuallyHurt`
    // credits a `ServerPlayer` attacker with the absorbed damage in tenths.
soak_hit :: proc(self: ^Self, damage: f32, source: ^Damage) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let through = self.soak_absorption(damage);
    // rust: let absorbed = damage - through;
    // rust: if absorbed > 0.0
    // rust: && absorbed < 3.402_823_5e37
    // rust: && matches!(source.attacker, Some(Who::Player))
    // rust: {
    // rust: self.dealt_absorbed = self
    // rust: .dealt_absorbed
    // rust: .saturating_add((absorbed * 10.0).round() as i32);
}
    // rust: through
}
    // `LivingEntity.actuallyHurt`: the absorption amount takes the damage first;
    // what is left reaches the health.
soak_absorption :: proc(self: ^Self, damage: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let through = (damage - self.absorption).max(0.0);
    // rust: self.absorption = (self.absorption - (damage - through)).max(0.0);
    // rust: through
}
    // `LivingEntity.checkTotemDeathProtection`: the first hand with a
    // `death_protection` item uses it up, the mob survives at 1 health with
    // the totem's effects, and entity event 35 tells the clients.
use_death_protection :: proc(self: ^Self, source: ^Damage) -> b {
    // Ported from Horizon
    return {}
}
        // `DamageTypeTags.BYPASSES_INVULNERABILITY`: the void and /kill take it.
    // rust: if source.kind.bypasses_invulnerability() {
    // rust: return false;
}
        // `getItemInHand`: the main hand first. The totem is the only item in
        // the shipped data with `minecraft:death_protection`.
TOTEM :: "minecraft:totem_of_undying"
    // rust: let main = self.extra.main_hand.as_deref() == Some(TOTEM);
    // rust: let off = !main && self.extra.off_hand.as_deref() == Some(TOTEM);
    // rust: if !main && !off {
    // rust: return false;
}
    // rust: if main {
    // rust: self.extra.set_main_hand(None);
    // rust: } else {
    // rust: self.extra.off_hand = None;
}
        // `setHealth(1.0F)`, then `DeathProtection.TOTEM_EFFECTS`.
    // rust: self.health = 1.0;
    // rust: for (effect, ticks, amplifier) in [
    // rust: ("regeneration", 900, 1),
    // rust: ("absorption", 100, 1),
    // rust: ("fire_resistance", 800, 0),
    // rust: ] {
    // rust: self.add_effect(effect, ticks, amplifier);
}
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: self.outbox.push(MobEvent::EntityEvent {
    // rust: mob: self.id,
    // rust: event: 35,
    // rust: at,
    // rust: });
    // rust: true
}
    // `LivingEntity.heal`, with the native heal hook.
heal :: proc(self: ^Self, mut amount: f32) {
}
    // rust: let mut cancel = false;
    // rust: crate::hunger::native_living_heal(self.id, &mut amount, &mut cancel);
    // rust: if !cancel && self.health > 0.0 {
    // rust: self.health = (self.health + amount).clamp(0.0, self.attrs.max_health);
}
}
    // `HealOrHarmMobEffect.applyInstantenousEffect`: a harming effect hurts a
    // living mob (6 << amplifier, magic) and heals an undead one, a healing effect
    // the reverse (4 << amplifier), both scaled by `scale`.
apply_heal_or_harm :: proc(self: ^Self, harm: bool, inverted: bool, amplifier: i32, scale: f64) {
}
    // rust: let amp = amplifier.clamp(0, 30);
    // rust: if harm != inverted {
    // rust: self.damage(
    // rust: (scale * f64::from(6i32 << amp)) as i32 as f32,
    // rust: Damage::of(DamageKind::Magic),
    // rust: );
    // rust: } else {
    // rust: let heal = (scale * f64::from(4i32 << amp)) as i32 as f32;
    // rust: self.heal(heal);
}
}
    // `LivingEntity.canBeAffected`: whether an effect of this kind may be added at
    // all, asked by `addEffect` before it stores anything. Five classes narrow the
    // rule first — a spider (a cave spider with it) and a nautilus refuse poison, a
    // wither and a wither skeleton the wither effect, a parched weakness — and the
    // entity type tags answer for the rest: `immune_to_infested` keeps infested off
    // a silverfish, `immune_to_oozing` keeps oozing off a slime, and
    // `ignores_poison_and_regen` (which is `#minecraft:undead`) keeps poison and
    // regeneration off a zombie, a skeleton, a phantom, a wither and the rest.
can_be_affected :: proc(self: ^Self, effect: ^'static str) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let effect = horizon_client_core::potions::namespaced(effect);
    // rust: let refused = match self.species() {
    // rust: Species::Spider | Species::CaveSpider | Species::Nautilus | Species::ZombieNautilus => {
    // rust: effect == "minecraft:poison"
}
    // rust: Species::Wither | Species::WitherSkeleton => effect == "minecraft:wither",
    // rust: Species::Parched => effect == "minecraft:weakness",
    // rust: Species::Silverfish => effect == "minecraft:infested",
    // rust: Species::Slime => effect == "minecraft:oozing",
    // rust: _ => false,
}
    // rust: if refused {
    // rust: return false;
}
    // rust: !(self.kind.flags.undead && matches!(effect, "minecraft:poison" | "minecraft:regeneration"))
}
add_effect :: proc(self: ^Self, effect: ^'static str, ticks: i32, amplifier: i32) {
}
    // rust: let effect = horizon_client_core::potions::namespaced(effect);
        // LivingEntity.addEffect: an effect the mob refuses is never added, so it
        // never joins the list the client draws or an effect tick reads.
        // WitherBoss.addEffect returns false for every effect.
    // rust: if self.species() == Species::Wither || !self.can_be_affected(effect) {
    // rust: return;
}
        // AbsorptionMobEffect.addAttributeModifiers: at least 4 hearts-halves per level.
    // rust: if effect == "minecraft:absorption"
    // rust: && self
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == effect)
    // rust: .is_none_or(|e| amplifier > e.2)
    // rust: {
    // rust: self.absorption = self.absorption.max(4.0 * (amplifier + 1) as f32);
}
    // rust: if let Some(e) = self.extra.effects.iter_mut().find(|e| e.0 == effect) {
            // MobEffectInstance.update: a stronger effect replaces with its
            // own duration, an equal one only extends it; a weaker one is
            // ignored (vanilla keeps it hidden behind the active one).
    // rust: if amplifier > e.2 {
    // rust: e.1 = ticks;
    // rust: e.2 = amplifier;
    // rust: } else if amplifier == e.2 && e.1 != -1 && (ticks == -1 || e.1 < ticks) {
    // rust: e.1 = ticks;
}
    // rust: } else {
    // rust: self.extra.effects.push((effect, ticks, amplifier));
}
}
speed_bonus :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ai::speed_bonus(self)
}
center :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: self.position.x,
    // rust: self.position.y + f64::from(self.height()) / 2.0,
    // rust: self.position.z,
    // rust: ]
}
sound :: proc(self: ^Self, event: ^'static str, events: ^[dynamic]MobEvent) {
}
    // rust: let at = [self.position.x, self.eye_y(), self.position.z];
    // rust: events.push(MobEvent::Sound(event, at, 1.0, 1.0));
}
    // `Mob.getAmbientSoundInterval`; `HappyGhast` waits six times as long
    // while it carries a passenger.
ambient_interval :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let ridden = self.rider.is_some() || self.extra.rider.is_some();
    // rust: if self.species() == Species::HappyGhast && ridden {
    // rust: self.kind.ambient_interval * 6
    // rust: } else {
    // rust: self.kind.ambient_interval
}
}
    // LivingEntity.getVoicePitch.
voice_pitch :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
        // HappyGhast.getVoicePitch: always 1.0, babies and all.
    // rust: if self.species() == Species::HappyGhast {
    // rust: return 1.0;
}
        // Parrot.getVoicePitch: `getPitch(random)`, the plain range, so a baby
        // parrot does not take the 1.5 that AgeableMob raises a baby by.
    // rust: if self.species() == Species::Parrot {
    // rust: return (self.random.next_float() - self.random.next_float()) * 0.2 + 1.0;
}
        // ZombieVillager.getVoicePitch: babies are 2.0, not 1.5.
    // rust: let baby = if self.species() == Species::ZombieVillager {
    // rust: 2.0
    // rust: } else {
    // rust: 1.5
}
    // rust: let pitch = (self.random.next_float() - self.random.next_float()) * 0.2
    // rust: + if self.is_baby() { baby } else { 1.0 };
        // Bat.getVoicePitch: a little lower.
    // rust: if self.species() == Species::Bat {
    // rust: pitch * 0.95
    // rust: } else {
    // rust: pitch
}
}
    // Mob.playSound with LivingEntity.getVoicePitch.
voice :: proc(self: ^Self, event: ^'static str, events: ^[dynamic]MobEvent) {
}
        // Java evaluates the arguments of `playSound(event, getSoundVolume(),
        // getVoicePitch())` before the call, so the pitch is drawn even for a
        // silent entity, whose `Entity.playSound` then plays nothing.
    // rust: let pitch = self.voice_pitch();
    // rust: if self.silent {
    // rust: return;
}
        // Entity.playSound: at the entity's feet.
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: events.push(MobEvent::Sound(event, at, ai::sound_volume(self), pitch));
}
}
// Model geometry for a mob, posed for its animation state, as camera-relative
// vertices textured from the shared atlas.
    // rust: pub fn render(
    // rust: mob: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: render::render_single(mob, alpha, camera, uv, light, out);
}
// A parsed `entity-models.json` document, shared while loading model batches.
// Each lookup still constructs an independent part tree for the caller.
EntityModelDocument :: struct {

    // rust: impl EntityModelDocument {
load :: proc(root: ^Path) -> c {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self(serde_json::from_slice(&fs::read(
    // rust: root.join("entity-models.json"),
    // rust: )?)?))
}

model :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.get(key).map(|m| Part::parse("root", m))
}

keys :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flat_map(|all| all.keys().map(String::as_str))
}
}

// Load one baked model layer from `entity-models.json` (e.g. `minecraft:chest#main`).
// Batch loaders should share an `EntityModelDocument` instead.
load_model :: proc(root: ^Path, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: EntityModelDocument::load(root).ok()?.model(key)
}
// ModelPart.render: translate, rotate ZYX, scale, then children.
    // rust: pub fn render_model(
    // rust: part: &Part,
    // rust: base: glam::Mat4,
    // rust: pose_for: &dyn Fn(&Part) -> [f32; 9],
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: visit(
    // rust: part,
    // rust: base,
    // rust: ModelNormals::new(base),
    // rust: pose_for,
    // rust: uv,
    // rust: light,
    // rust: overlay,
    // rust: out,
    // rust: );
    // rust: fn visit(
    // rust: part: &Part,
    // rust: parent: glam::Mat4,
    // rust: normals: ModelNormals,
    // rust: pose_for: &dyn Fn(&Part) -> [f32; 9],
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let p = pose_for(part);
    // rust: let m = parent
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * glam::Mat4::from_quat(glam::Quat::from_euler(
    // rust: glam::EulerRot::ZYX,
    // rust: p[5],
    // rust: p[4],
    // rust: p[3],
    // rust: ))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(p[6], p[7], p[8]));
    // rust: let normals = normals.part(p);
    // rust: for poly in &part.polygons {
    // rust: let normal = poly.vertex_normal(normals);
    // rust: for v in poly.vertices {
    // rust: let pos = m.transform_point3(glam::Vec3::new(v[0], v[1], v[2]) / 16.0);
    // rust: out.push(Vertex {
    // rust: normal,
    // rust: pos: pos.to_array(),
    // rust: uv: [
    // rust: uv[0] + (uv[2] - uv[0]) * v[3],
    // rust: uv[1] + (uv[3] - uv[1]) * v[4],
    // rust: ],
    // rust: layer: overlay,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,
                    // The armour glint scrolls the model UV in the shader.
    // rust: glint_uv: if overlay == render::ARMOR_GLINT {
    // rust: [v[3], v[4]]
    // rust: } else {
    // rust: [0.0, 0.0]
    // rust: },
    // rust: });
}
}
    // rust: for c in &part.children {
    // rust: visit(c, m, normals, pose_for, uv, light, overlay, out);
}
}
}

    // rust: impl Mob {
    // The saddle worn, with its components.
saddle_item :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.extra.saddled.then(|| {
    // rust: self.extra
    // rust: .saddle_stack
    // rust: .clone()
    // rust: .unwrap_or_else(|| crate::items::ItemStack::new("minecraft:saddle", 1))
    // rust: })
}
    // Wear (or take off) a saddle stack, keeping its components.
set_saddle :: proc(self: ^Self, saddle: Maybe(crate::items::ItemStack)) {
}
    // rust: self.extra.saddled = saddle.is_some();
        // A plain saddle is implied by `saddled`; anything else (a copper
        // golem's antenna flower) is kept as it is.
    // rust: self.extra.saddle_stack = saddle
    // rust: .map(|s| crate::items::ItemStack { count: 1, ..s })
    // rust: .filter(|s| s.damage != 0 || s.extra.is_some() || &*s.item != "minecraft:saddle");
}
}

    // rust: mod lighting_tests {
//     use super::*;
//     use glam::{Mat4, Vec3};
//     use serde_json::json;

plane :: proc(normal: [f32; 3]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Part::parse(
    // rust: "root",
    // rust: &json!({
    // rust: "polygons": [[[0,0,0,0,0], [0,0,0,1,0], [0,0,0,1,1], [0,0,0,0,1]]],
    // rust: "normals": [normal]
    // rust: }),
    // rust: )
}

exported_normals_survive_collapsed_faces_and_mirroring :: proc() {
}
    // rust: let part = plane([1.0, 0.0, 0.0]);
    // rust: assert_eq!(
    // rust: part.polygons[0].vertex_normal(ModelNormals::new(Mat4::IDENTITY)),
    // rust: [127, 0, 0, -127]
    // rust: );
    // rust: assert_eq!(
    // rust: part.polygons[0].vertex_normal(ModelNormals::new(Mat4::from_scale(Vec3::new(
    // rust: -1.0, -1.0, 1.0
    // rust: )))),
    // rust: [-127, 0, 0, -127]
    // rust: );
}

normal_matrix_includes_parent_scale_and_child_rotation :: proc() {
}
    // rust: let mut child = plane([1.0, 0.0, 0.0]);
    // rust: child.pose[5] = std::f32::consts::FRAC_PI_4;
    // rust: let parent = Part {
    // rust: name: "parent".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 1.0, 0.5],
    // rust: polygons: Vec::new(),
    // rust: children: vec![child],
}
    // rust: let mut animated = Vec::new();
    // rust: render::draw(
    // rust: &parent,
    // rust: Mat4::IDENTITY,
    // rust: &anim::Poses::new(&parent),
    // rust: [0.0, 0.0, 1.0, 1.0],
    // rust: 0x80402010,
    // rust: 240,
    // rust: 1,
    // rust: &mut animated,
    // rust: );
    // rust: let mut direct = Vec::new();
    // rust: render_model(
    // rust: &parent,
    // rust: Mat4::IDENTITY,
    // rust: &|p| p.pose,
    // rust: [0.0, 0.0, 1.0, 1.0],
    // rust: 240,
    // rust: 1,
    // rust: &mut direct,
    // rust: );
    // rust: assert_eq!(animated.len(), 4);
    // rust: for (a, b) in animated.iter().zip(&direct) {
    // rust: assert_eq!(a.normal, [56, 113, 0, -127]);
    // rust: assert_eq!(a.normal, b.normal);
    // rust: assert_eq!(a.pos, b.pos);
    // rust: assert_eq!(a.uv, b.uv);
    // rust: assert_eq!((a.color, a.light, a.layer), (0x80402010, 240, 1));
}
}

trusted_rotation_retains_native_quaternion_rounding :: proc() {
}
    // rust: let mut part = plane([1.0, 0.0, 0.0]);
    // rust: part.pose[3] = std::f32::consts::FRAC_PI_2;
    // rust: let mut vertices = Vec::new();
    // rust: render::draw(
    // rust: &part,
    // rust: Mat4::IDENTITY,
    // rust: &anim::Poses::new(&part),
    // rust: [0.0, 0.0, 1.0, 1.0],
    // rust: 0xffffffff,
    // rust: 240,
    // rust: 0,
    // rust: &mut vertices,
    // rust: );
    // rust: assert_eq!(vertices[0].normal, [126, 0, 0, -127]);
}

legacy_models_infer_non_degenerate_face_normals :: proc() {
}
    // rust: let part = Part::parse(
    // rust: "root",
    // rust: &json!({"polygons": [
    // rust: [[0,0,0,0,0], [1,0,0,1,0], [1,1,0,1,1], [0,1,0,0,1]]
    // rust: ]}),
    // rust: );
    // rust: assert_eq!(part.polygons[0].normal, [0.0, 0.0, 1.0]);
}

packed_normal_uses_native_snorm_bytes_without_changing_vertex_offsets :: proc() {
}
    // rust: assert_eq!(std::mem::offset_of!(Vertex, normal), 32);
    // rust: assert_eq!(std::mem::size_of::<Vertex>(), 44);
    // rust: let part = plane([0.0, 1.0, 0.0]);
    // rust: assert_eq!(
    // rust: part.polygons[0].vertex_normal(ModelNormals::new(Mat4::from_scale(Vec3::ZERO))),
    // rust: [0, 0, 0, -127]
    // rust: );
}
}

// `LivingEntity.elytraAnimationState`: eased wing angles and render interpolation.
ElytraAnimation :: struct {
    old: [f32,
    angles: [f32,
}
    // rust: impl ElytraAnimation {
    // The angles `ElytraAnimationState` eases to when not gliding or crouching.
    // rust: pub const RESTING: [f32; 3] = [
    // rust: std::f32::consts::PI / 12.0,
    // rust: 0.0,
    // rust: -std::f32::consts::PI / 12.0,
    // rust: ];
tick :: proc(self: ^Self, flying: bool, crouching: bool, velocity: horizon_core::geometry::Vec3) {
}
//         use std::f32::consts::PI;
    // rust: self.old = self.angles;
    // rust: let target = if flying {
    // rust: let length =
    // rust: (velocity.x * velocity.x + velocity.y * velocity.y + velocity.z * velocity.z)
    // rust: .sqrt();
    // rust: let ratio = if velocity.y < 0.0 && length > 0.0 {
    // rust: 1.0 - horizon_core::jmath::pow(-velocity.y / length, 1.5) as f32
    // rust: } else {
    // rust: 1.0
}
    // rust: [
    // rust: PI / 12.0 + (PI / 9.0 - PI / 12.0) * ratio,
    // rust: 0.0,
    // rust: -PI / 12.0 + (-PI / 2.0 + PI / 12.0) * ratio,
    // rust: ]
    // rust: } else if crouching {
    // rust: [PI * 2.0 / 9.0, 0.08726646, -PI / 4.0]
    // rust: } else {
    // rust: Self::RESTING
}
    // rust: for (angle, target) in self.angles.iter_mut().zip(target) {
    // rust: *angle += (target - *angle) * 0.3;
}
}
angles :: proc(self: ^Self, partial: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| self.old[i] + (self.angles[i] - self.old[i]) * partial)
}
}

// `LivingEntity.swimAmount` and the render state the swimming pose reads
// (`isVisuallySwimming`, `isInWater`).
SwimAnimation :: struct {
    old: f32,
    amount: f32,
    // `isVisuallySwimming`: in the swimming pose (or still in the gliding
    // pose after a glide ended).
    visually: bool,
    in_water: bool,
}
    // rust: impl SwimAnimation {
    // `LivingEntity.updateSwimAmount`.
tick :: proc(self: ^Self, visually: bool, in_water: bool) {
}
    // rust: self.old = self.amount;
    // rust: self.amount = if visually {
    // rust: (self.amount + 0.09).min(1.0)
    // rust: } else {
    // rust: (self.amount - 0.09).max(0.0)
}
    // rust: self.visually = visually;
    // rust: self.in_water = in_water;
}
    // `LivingEntity.getSwimAmount`.
amount :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.old + partial * (self.amount - self.old)
}
}

    // rust: impl Mob {
    // The part of `LivingEntity.tick` and `aiStep` that animates another
    // player from its synched pose and flags: the glide count, the wings
    // (`elytraAnimationState`) and the swim amount (`updateSwimAmount`).
tick_avatar_pose :: proc(self: ^Self, in_water: bool) {
}
    // rust: let (p, v) = (self.previous, self.velocity);
    // rust: let on_ground_alive = self.on_ground && self.alive();
    // rust: let e = &mut self.extra;
    // rust: e.fall_fly_ticks = if e.fall_flying {
    // rust: e.fall_fly_ticks + 1
    // rust: } else {
    // rust: 0
}
        // LivingEntity.isVisuallySwimming: the swimming pose, or the gliding
        // pose after the glide ended.
    // rust: let visually = e.synced_pose == 3 || (!e.fall_flying && e.synced_pose == 1);
    // rust: e.elytra.tick(e.fall_flying, e.crouching, self.velocity);
    // rust: e.swim.tick(visually, in_water);
        // AbstractClientPlayer.tick's ClientAvatarState.tick (from where the
        // player was before this tick's move), RemotePlayer.aiStep's
        // updateBob and rideTick's resetBob.
    // rust: e.avatar.tick([p.x, p.y, p.z]);
    // rust: if e.passenger {
    // rust: e.avatar.reset_bob();
    // rust: } else {
    // rust: let swimming = e.synced_pose == 3;
    // rust: e.avatar
    // rust: .update_bob(on_ground_alive && !swimming, [v.x, v.y, v.z]);
}
}
}

    // rust: mod elytra_tests {
//     use super::*;
wings_ease_between_ground_flight_and_crouch :: proc() {
}
    // rust: let mut wings = ElytraAnimation::default();
    // rust: wings.tick(false, false, Vec3::ZERO);
    // rust: assert!((wings.angles[0] - std::f32::consts::PI / 12.0 * 0.3).abs() < 0.000001);
    // rust: assert_eq!(wings.angles(0.0), wings.old);
    // rust: assert_eq!(wings.angles(1.0), wings.angles);
    // rust: for _ in 0..40 {
    // rust: wings.tick(true, false, Vec3::new(1.0, 0.0, 0.0));
}
    // rust: assert!((wings.angles[2] + std::f32::consts::FRAC_PI_2).abs() < 0.00001);
    // rust: for _ in 0..40 {
    // rust: wings.tick(false, true, Vec3::ZERO);
}
    // rust: assert!((wings.angles[1] - 0.08726646).abs() < 0.00001);
}
    // An armour stand never glides or crouches: its wings stay at the angles
    // a standing wearer eases to.
resting_wings_are_the_standing_target :: proc() {
}
    // rust: let mut wings = ElytraAnimation::default();
    // rust: for _ in 0..80 {
    // rust: wings.tick(false, false, Vec3::ZERO);
}
    // rust: for (angle, resting) in wings.angles.iter().zip(ElytraAnimation::RESTING) {
    // rust: assert!((angle - resting).abs() < 0.00001);
}
}
}
    // rust: mod spear_knockback_tests {
//     use super::sensor_scan_tests::kind;
//     use super::*;
//     use horizon_core::geometry::Vec3;

    // `spear` is in `#no_knockback`: the stab's hurt deals no default
    // knockback (the spear pushes with `causeExtraKnockback` itself).
a_spear_stab_hurts_without_the_default_knockback :: proc() {
}
    // rust: let mut m = Mob::new(1, kind(), Vec3::ZERO, 0.0);
    // rust: let health = m.health;
    // rust: assert!(m.damage(1.0, Damage::spear([2.0, 0.0, 0.0])));
    // rust: assert_eq!(m.health, health - 1.0);
    // rust: let v = m.velocity;
    // rust: assert_eq!([v.x, v.y, v.z], [0.0; 3]);
}

    // a plain player hit still knocks the mob away from the attacker.
a_player_hit_still_knocks_back :: proc() {
}
    // rust: let mut m = Mob::new(1, kind(), Vec3::ZERO, 0.0);
    // rust: assert!(m.damage(1.0, Damage::player([2.0, 0.0, 0.0])));
    // rust: assert!(m.velocity.x < 0.0, "velocity {:?}", m.velocity);
}
}
    // rust: mod teams_tests {
//     use super::*;
//     use crate::save::uuid_text;
//     use crate::scoreboard::{Scoreboard, Team};

    // A board where every other mob is on the player's team, as with a
    // datapack that colours its mobs' names.
board :: proc(mobs: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut board = Scoreboard::default();
    // rust: board.add_team("red");
    // rust: board.add_to_team("Steve", "red");
    // rust: let uuids: HashMap<u32, [i32; 4]> = (0..mobs)
    // rust: .map(|id| (id, [id as i32, 7, -(id as i32), 11]))
    // rust: .collect();
    // rust: for (id, uuid) in &uuids {
    // rust: if id % 2 == 0 {
    // rust: board.add_to_team(&uuid_text(*uuid), "red");
}
}
    // rust: (board, uuids)
}
    // `Game::mob_teams` as built for each mob before: owned clones of the teams.
owned :: proc(board: ^Scoreboard, uuids: ^HashMap<u32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: uuids
    // rust: .iter()
    // rust: .filter_map(|(id, u)| Some((*id, board.players_team(&uuid_text(*u))?.clone())))
    // rust: .collect()
}
    // rust: fn borrowed<'a>(board: &'a Scoreboard, uuids: &HashMap<u32, [i32; 4]>) -> Teams<'a> {
    // rust: Teams {
    // rust: player: board.players_team("Steve"),
    // rust: mobs: uuids
    // rust: .iter()
    // rust: .filter_map(|(id, u)| Some((*id, board.players_team(&uuid_text(*u))?)))
    // rust: .collect(),
}
}

borrowed_teams_answer_as_the_clones :: proc() {
}
    // rust: let (board, uuids) = board(40);
    // rust: let teams = borrowed(&board, &uuids);
    // rust: let old = owned(&board, &uuids);
    // rust: for id in 0..41 {
    // rust: assert_eq!(teams.of(Who::Mob(id)), old.get(&id), "mob {id}");
}
    // rust: assert_eq!(teams.of(Who::Player).map(|t| t.name.as_str()), Some("red"));
}

    // One tick's worth of team building: once per mob (before) against once.
teams_cost :: proc() {
}
    // rust: for mobs in [100u32, 250, 500] {
    // rust: let (board, uuids) = board(mobs);
    // rust: let t = std::time::Instant::now();
    // rust: for _ in 0..mobs {
    // rust: std::hint::black_box(owned(&board, &uuids));
}
    // rust: let before = t.elapsed();
    // rust: let t = std::time::Instant::now();
    // rust: let reps = 20;
    // rust: for _ in 0..reps {
    // rust: std::hint::black_box(borrowed(&board, &uuids));
}
    // rust: let after = t.elapsed() / reps;
    // rust: println!(
    // rust: "{mobs} mobs, half on a team: per tick {:.3} ms -> {:.3} ms",
    // rust: before.as_secs_f64() * 1e3,
    // rust: after.as_secs_f64() * 1e3
    // rust: );
}
}
}
    // rust: pub(crate) mod sensor_scan_tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;
//     use serde_json::json;

    // rust: pub(crate) fn kind() -> Arc<MobType> {
    // rust: Arc::new(MobType {
    // rust: id: "minecraft:cow".into(),
    // rust: species: Species::Cow,
    // rust: width: 0.9,
    // rust: height: 1.4,
    // rust: eye_height: 1.3,
    // rust: category: "creature".into(),
    // rust: max_health: 10.0,
    // rust: speed: 0.2,
    // rust: flying_speed: 0.4,
    // rust: attack_damage: 0.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 16.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Arc::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 120,
    // rust: flags: Flags {
    // rust: animal: true,
    // rust: ..Default::default()
    // rust: },
    // rust: model: Arc::new(Part::parse("root", &json!({}))),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Rabbit,
    // rust: sounds: [""; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
    // rust: })
}
    // `n` mobs in pens of 20 spread over a square of `side` blocks, as on a
    // server's farms; their snapshot and its grid.
herd :: proc(n: u32, side: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let kind = kind();
    // rust: let mut seed = 0x9e37_79b9_7f4a_7c15u64;
    // rust: let mut next = |range: f64| {
    // rust: seed = seed.wrapping_mul(6_364_136_223_846_793_005).wrapping_add(1);
    // rust: (seed >> 11) as f64 / (1u64 << 53) as f64 * range
}
    // rust: let mut pen = Vec3::ZERO;
    // rust: let seen: Vec<Seen> = (0..n)
    // rust: .map(|id| {
    // rust: if id % 20 == 0 {
    // rust: pen = Vec3::new(next(side), 64.0, next(side));
}
    // rust: let at = Vec3::new(pen.x + next(8.0), 64.0, pen.z + next(8.0));
    // rust: Mob::new(id, kind.clone(), at, 0.0).seen(None)
    // rust: })
    // rust: .collect();
    // rust: let grid = seen_grid::SeenGrid::new(seen.iter().map(|s| s.bounds));
    // rust: (seen, grid)
}
    // `NearestLivingEntitySensor` over every mob, as the brains ran it.
scan :: proc(seen: ^[Seen], me: ^Seen, area: Aabb) -> V {
    // Ported from Horizon
    return {}
}
    // rust: seen.iter()
    // rust: .filter(|o| o.id != me.id && o.alive && o.bounds.intersects(area))
    // rust: .map(|o| o.id)
    // rust: .collect()
}
indexed :: proc(seen: ^[Seen], grid: ^seen_grid::SeenGrid, me: ^Seen, area: Aabb) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut near = Vec::new();
    // rust: assert!(grid.candidates(area, &mut near));
    // rust: near.iter()
    // rust: .map(|&i| &seen[i as usize])
    // rust: .filter(|o| o.id != me.id && o.alive && o.bounds.intersects(area))
    // rust: .map(|o| o.id)
    // rust: .collect()
}

the_grid_finds_what_the_scan_finds :: proc() {
}
    // rust: let (seen, grid) = herd(600, 160.0);
    // rust: for me in &seen {
    // rust: let area = me.bounds.inflate(Vec3::new(16.0, 16.0, 16.0));
    // rust: assert_eq!(indexed(&seen, &grid, me, area), scan(&seen, me, area));
}
}

    // `MobWorld::seen` once per mob (a target, a breeding partner...), by
    // scan as before and by the tick's id index.
lookup_cost :: proc() {
}
    // rust: for n in [500u32, 1000, 2000] {
    // rust: let (seen, _) = herd(n, 256.0);
    // rust: let index: crate::fast_hash::FxHashMap<u32, u32> = seen
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, s)| (s.id, i as u32))
    // rust: .collect();
    // rust: let wanted: Vec<u32> = (0..n).map(|i| (i * 7919) % n).collect();
    // rust: let t = std::time::Instant::now();
    // rust: let a: usize = wanted
    // rust: .iter()
    // rust: .filter_map(|&id| seen.iter().find(|s| s.id == id))
    // rust: .map(|s| s.id as usize)
    // rust: .sum();
    // rust: let before = t.elapsed().as_secs_f64() * 1e3;
    // rust: let t = std::time::Instant::now();
    // rust: let b: usize = wanted
    // rust: .iter()
    // rust: .filter_map(|&id| index.get(&id).map(|&i| &seen[i as usize]))
    // rust: .map(|s| s.id as usize)
    // rust: .sum();
    // rust: let after = t.elapsed().as_secs_f64() * 1e3;
    // rust: assert_eq!(a, b);
    // rust: println!(
    // rust: "{n} lookups over {n} mobs ({} B each): {before:.3} ms -> {after:.3} ms",
    // rust: std::mem::size_of::<Seen>()
    // rust: );
}
}

    // Natural spawning's `isUnobstructed` box test against every mob (real
    // `Mob`s), by scan and by a grid built once for the pass.
spawn_box_cost :: proc() {
}
    // rust: let kind = kind();
    // rust: for n in [500u32, 1000, 2000] {
    // rust: let (seen, _) = herd(n, 384.0);
    // rust: let mobs: Vec<Mob> = seen
    // rust: .iter()
    // rust: .map(|s| Mob::new(s.id, kind.clone(), s.position, 0.0))
    // rust: .collect();
    // rust: let mut seed = 7u64;
    // rust: let mut next = |range: f64| {
    // rust: seed = seed.wrapping_mul(6_364_136_223_846_793_005).wrapping_add(1);
    // rust: (seed >> 11) as f64 / (1u64 << 53) as f64 * range
}
    // rust: let queries: Vec<Aabb> = (0..100)
    // rust: .map(|_| {
    // rust: let (x, z) = (next(384.0), next(384.0));
    // rust: Aabb::new(Vec3::new(x, 64.0, z), Vec3::new(x + 0.9, 65.4, z + 0.9))
    // rust: })
    // rust: .collect();
    // rust: let t = std::time::Instant::now();
    // rust: let a: Vec<bool> = queries
    // rust: .iter()
    // rust: .map(|&q| {
    // rust: mobs.iter()
    // rust: .any(|m| m.alive() && !m.removed && m.bounds().intersects(q))
    // rust: })
    // rust: .collect();
    // rust: let before = t.elapsed().as_secs_f64() * 1e3;
    // rust: let t = std::time::Instant::now();
    // rust: let boxes: Vec<Aabb> = mobs.iter().map(|m| m.bounds()).collect();
    // rust: let grid = seen_grid::SeenGrid::new(boxes.iter().copied());
    // rust: let build = t.elapsed().as_secs_f64() * 1e3;
    // rust: let mut near = Vec::new();
    // rust: let b: Vec<bool> = queries
    // rust: .iter()
    // rust: .map(|&q| {
    // rust: assert!(grid.candidates(q, &mut near));
    // rust: near.iter().any(|&i| boxes[i as usize].intersects(q))
    // rust: })
    // rust: .collect();
    // rust: let after = t.elapsed().as_secs_f64() * 1e3;
    // rust: assert_eq!(a, b);
    // rust: println!(
    // rust: "{n} mobs, 100 spawn box tests: {before:.3} ms -> {after:.3} ms (grid build {build:.3} ms included)"
    // rust: );
}
}

    // One tick of sensing: a twentieth of the mobs fire their sensor.
sensor_cost :: proc() {
}
    // rust: for (n, side) in [(500u32, 256.0), (1000, 384.0), (2000, 512.0)] {
    // rust: let (seen, grid) = herd(n, side);
    // rust: let time = |f: &dyn Fn(&Seen, Aabb) -> usize| {
    // rust: let t = std::time::Instant::now();
    // rust: let mut found = 0;
    // rust: for me in &seen {
    // rust: found += f(me, me.bounds.inflate(Vec3::new(16.0, 16.0, 16.0)));
}
    // rust: (t.elapsed().as_secs_f64() * 1e3 / 20.0, found)
}
    // rust: let (before, a) = time(&|me, area| scan(&seen, me, area).len());
    // rust: let (after, b) = time(&|me, area| indexed(&seen, &grid, me, area).len());
    // rust: assert_eq!(a, b);
    // rust: println!("{n} mobs: per tick {before:.3} ms -> {after:.3} ms");
}
}
}
    // rust: mod push_tests {
//     use super::sensor_scan_tests::kind;
//     use super::*;
//     use horizon_core::geometry::Vec3;

    // The pending pushes as one list, scanned for each mob, as before.
take_old :: proc(events: ^[dynamic]MobEvent, from: uint, pending: ^Vec<(u32) {
}
    // rust: let mut i = from;
    // rust: while i < events.len() {
    // rust: if let MobEvent::Push {
    // rust: target: Who::Mob(id),
    // rust: velocity,
    // rust: } = events[i]
    // rust: {
    // rust: pending.push((id, Vec3::new(velocity[0], velocity[1], velocity[2])));
    // rust: events.remove(i);
    // rust: } else {
    // rust: i += 1;
}
}
}
apply_old :: proc(velocity: ^Vec3, id: u32, pending: ^Vec<(u32) {
}
    // rust: pending.retain(|(to, v)| {
    // rust: if *to != id {
    // rust: return true;
}
    // rust: *velocity = Vec3::new(velocity.x + v.x, velocity.y + v.y, velocity.z + v.z);
    // rust: false
    // rust: });
}
mobs :: proc(n: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let kind = kind();
    // rust: (0..n)
    // rust: .map(|id| Mob::new(id, kind.clone(), Vec3::ZERO, 0.0))
    // rust: .collect()
}
    // A crowd tick: each mob takes its pushes, then pushes every other
    // mob (and the player, and hisses now and then); then all take theirs.
    // rust: fn crowd_tick(
    // rust: n: u32,
    // rust: tick: u32,
    // rust: mut on_push: impl FnMut(&mut Vec<MobEvent>, usize),
    // rust: mut on_apply: impl FnMut(u32),
    // rust: ) -> Vec<MobEvent> {
    // rust: let mut events = Vec::new();
    // rust: for i in 0..n {
    // rust: on_apply(i);
    // rust: let from = events.len();
    // rust: for j in 0..n {
    // rust: if j != i && !(i * 31 + j * 17 + tick).is_multiple_of(5) {
    // rust: let f = f64::from(i * 7 + j + tick) * 0.001;
    // rust: events.push(MobEvent::Push {
    // rust: target: Who::Mob(j),
    // rust: velocity: [f, -f * 0.5, f * 0.25],
    // rust: });
}
    // rust: if j.is_multiple_of(9) {
    // rust: events.push(MobEvent::Hiss { mob: j });
}
}
    // rust: events.push(MobEvent::Push {
    // rust: target: Who::Player,
    // rust: velocity: [0.1, 0.0, 0.1],
    // rust: });
    // rust: on_push(&mut events, from);
}
    // rust: for i in 0..n {
    // rust: on_apply(i);
}
    // rust: events
}

pushes_land_as_with_the_list :: proc() {
}
    // rust: for n in [1u32, 3, 8, 20, 60] {
    // rust: let mut new_mobs = mobs(n);
    // rust: let mut old_v = vec![Vec3::ZERO; n as usize];
    // rust: let mut pending = PendingPushes::default();
    // rust: let mut old_pending = Vec::new();
    // rust: for tick in 0..4 {
    // rust: let new_events = {
    // rust: let pending = std::cell::RefCell::new(&mut pending);
    // rust: let mobs = std::cell::RefCell::new(&mut new_mobs);
    // rust: crowd_tick(
    // rust: n,
    // rust: tick,
    // rust: |e, from| take_mob_pushes(e, from, &mut pending.borrow_mut()),
    // rust: |i| {
    // rust: apply_mob_pushes(
    // rust: &mut mobs.borrow_mut()[i as usize],
    // rust: &mut pending.borrow_mut(),
    // rust: )
    // rust: },
    // rust: )
}
    // rust: let old_events = {
    // rust: let pending = std::cell::RefCell::new(&mut old_pending);
    // rust: let v = std::cell::RefCell::new(&mut old_v);
    // rust: crowd_tick(
    // rust: n,
    // rust: tick,
    // rust: |e, from| take_old(e, from, &mut pending.borrow_mut()),
    // rust: |i| {
    // rust: apply_old(
    // rust: &mut v.borrow_mut()[i as usize],
    // rust: i,
    // rust: &mut pending.borrow_mut(),
    // rust: )
    // rust: },
    // rust: )
}
    // rust: assert_eq!(format!("{new_events:?}"), format!("{old_events:?}"));
    // rust: for i in 0..n as usize {
    // rust: let (a, b) = (new_mobs[i].velocity, old_v[i]);
    // rust: assert_eq!(
    // rust: (a.x.to_bits(), a.y.to_bits(), a.z.to_bits()),
    // rust: (b.x.to_bits(), b.y.to_bits(), b.z.to_bits()),
    // rust: "{n} mobs, tick {tick}, mob {i}"
    // rust: );
}
}
}
}

    // One tick of a pen of `n` mobs pushing each other.
push_cost :: proc() {
}
    // rust: for n in [10u32, 30, 100, 200] {
    // rust: let mut ms = mobs(n);
    // rust: let mut v = vec![Vec3::ZERO; n as usize];
    // rust: let t = std::time::Instant::now();
    // rust: {
    // rust: let pending = std::cell::RefCell::new(Vec::new());
    // rust: let v = std::cell::RefCell::new(&mut v);
    // rust: crowd_tick(
    // rust: n,
    // rust: 0,
    // rust: |e, from| take_old(e, from, &mut pending.borrow_mut()),
    // rust: |i| {
    // rust: apply_old(
    // rust: &mut v.borrow_mut()[i as usize],
    // rust: i,
    // rust: &mut pending.borrow_mut(),
    // rust: )
    // rust: },
    // rust: );
}
    // rust: let before = t.elapsed().as_secs_f64() * 1e3;
    // rust: let t = std::time::Instant::now();
    // rust: {
    // rust: let pending = std::cell::RefCell::new(PendingPushes::default());
    // rust: let ms = std::cell::RefCell::new(&mut ms);
    // rust: crowd_tick(
    // rust: n,
    // rust: 0,
    // rust: |e, from| take_mob_pushes(e, from, &mut pending.borrow_mut()),
    // rust: |i| {
    // rust: apply_mob_pushes(
    // rust: &mut ms.borrow_mut()[i as usize],
    // rust: &mut pending.borrow_mut(),
    // rust: )
    // rust: },
    // rust: );
}
    // rust: let after = t.elapsed().as_secs_f64() * 1e3;
    // rust: println!("{n} mobs pushing each other: {before:.3} ms -> {after:.3} ms");
}
}
}

    // rust: mod held_stack_tests {
//     use super::*;

replacing_even_the_same_item_clears_its_old_components :: proc() {
}
    // rust: let mut extra = Extra::default();
    // rust: let mut named = crate::items::ItemStack::new("minecraft:diamond_sword", 1);
    // rust: named.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("Old Sword".into()));
    // rust: extra.set_main_hand_stack(Some(named.clone()));
    // rust: assert_eq!(
    // rust: extra.main_hand_stack().unwrap().custom_name().as_deref(),
    // rust: Some("Old Sword")
    // rust: );
    // rust: extra.set_main_hand(Some(named.item.clone()));
    // rust: assert!(extra.main_hand_stack().is_none());
    // rust: extra.set_main_hand_stack(Some(named));
    // rust: extra.take_main_hand();
    // rust: assert!(extra.main_hand.is_none());
    // rust: assert!(extra.main_hand_stack().is_none());
}
}

    // rust: mod fire_resistance_damage_tests {
//     use super::*;

pig :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = super::sensor_scan_tests::kind();
    // rust: let def = Arc::make_mut(&mut kind);
    // rust: def.id = "minecraft:pig".into();
    // rust: def.species = Species::Pig;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

fire_resistance_rejects_fire_before_health_and_hurt_cooldown :: proc() {
}
    // rust: for kind in [
    // rust: DamageKind::Campfire,
    // rust: DamageKind::Fireball,
    // rust: DamageKind::HotFloor,
    // rust: DamageKind::InFire,
    // rust: DamageKind::Lava,
    // rust: DamageKind::OnFire,
    // rust: DamageKind::SulfurCubeHot,
    // rust: ] {
    // rust: let mut mob = pig();
    // rust: mob.add_effect("minecraft:fire_resistance", -1, 0);
    // rust: assert!(!mob.damage(1.0, Damage::of(kind)), "{kind:?}");
    // rust: assert_eq!(mob.health, 10.0, "{kind:?}");
    // rust: assert_eq!(
    // rust: (mob.hurt_time, mob.invulnerable, mob.last_hurt),
    // rust: (0, 0, 0.0)
    // rust: );
    // rust: assert!(mob.last_damage.is_none());
    // rust: assert!(mob.outbox.is_empty());
            // A refused fire hit must not prevent the next ordinary hit.
    // rust: assert!(mob.damage(1.0, Damage::of(DamageKind::Cactus)));
    // rust: assert_eq!(mob.health, 9.0);

    // rust: let mut bare = pig();
    // rust: assert!(bare.damage(1.0, Damage::of(kind)));
    // rust: assert_eq!(bare.health, 9.0);
    // rust: assert!(
    // rust: !bare.damage(1.0, Damage::of(kind)),
    // rust: "equal hit during cooldown"
    // rust: );
    // rust: assert!(
    // rust: bare.damage(2.0, Damage::of(kind)),
    // rust: "stronger hit during cooldown"
    // rust: );
    // rust: assert_eq!(bare.health, 8.0);

    // rust: let mut resistant = pig();
    // rust: resistant.add_effect("minecraft:resistance", -1, 0);
    // rust: assert!(resistant.damage(1.0, Damage::of(kind)));
    // rust: assert_eq!(resistant.health, 9.2);

    // rust: let mut invulnerable = pig();
    // rust: invulnerable.invulnerable_flag = true;
    // rust: assert!(!invulnerable.damage(1.0, Damage::of(kind)));
    // rust: assert_eq!(invulnerable.health, 10.0);
}
}

species_hurt_callbacks_still_run_before_the_living_fire_guard :: proc() {
}
    // rust: let mut mob = pig();
    // rust: let kind = Arc::make_mut(&mut mob.kind);
    // rust: kind.id = "minecraft:bat".into();
    // rust: kind.species = Species::Bat;
    // rust: bat::set_resting(&mut mob, true);
    // rust: mob.add_effect("minecraft:fire_resistance", -1, 0);
    // rust: assert!(!mob.damage(1.0, Damage::of(DamageKind::InFire)));
    // rust: assert!(!bat::resting(&mob));
    // rust: assert_eq!(mob.health, 10.0);
    // rust: assert_eq!(mob.invulnerable, 0);
}

reflected_ghast_fireball_still_reports_success_when_fire_resistance_refuses_health_damage :: proc() {
}
    // rust: let mut mob = pig();
    // rust: let kind = Arc::make_mut(&mut mob.kind);
    // rust: kind.id = "minecraft:ghast".into();
    // rust: kind.species = Species::Ghast;
    // rust: kind.flags.fire_immune = true;
    // rust: mob.add_effect("minecraft:fire_resistance", -1, 0);
    // rust: let source = Damage {
    // rust: kind: DamageKind::Fireball,
    // rust: attacker: Some(Who::Player),
    // rust: from: None,
    // rust: attacker_species: None,
}
    // rust: assert!(mob.damage(1.0, source));
    // rust: assert_eq!(mob.health, 10.0);
    // rust: assert_eq!(mob.invulnerable, 0);
}
}

    // rust: mod magic_absorb_tests {
//     use super::sensor_scan_tests::kind;
//     use super::*;
//     use horizon_core::geometry::Vec3;

witch :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:witch".into();
    // rust: k.species = Species::Witch;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `MobEffectInstance.update` for the flags of an effect a mob has: a new instance that is
    // not ambient takes the ambient flag off an ambient one, one that is ambient does not unless
    // the effect itself changes, and visibility is always the new instance's.
an_effect_added_again_updates_its_ambient_and_visible_flags_as_vanilla :: proc() {
}
    // rust: let mut m = witch();
    // rust: let speed = "minecraft:speed";
        // A new effect takes its flags as they are.
    // rust: assert!(m.add_effect_with("speed", 600, 0, true, false));
    // rust: assert!(
    // rust: m.extra.ambient_effects.contains(&speed) && m.extra.hidden_effects.contains(&speed)
    // rust: );
        // The same effect, no stronger and no longer, ambient again and visible: ambient stays
        // (nothing changed), the visibility follows.
    // rust: assert!(m.add_effect_with("speed", 100, 0, true, true));
    // rust: assert_eq!(m.extra.effects, vec![(speed, 600, 0)]);
    // rust: assert!(
    // rust: m.extra.ambient_effects.contains(&speed) && !m.extra.hidden_effects.contains(&speed)
    // rust: );
        // Not ambient: it takes the flag off, though nothing else changed.
    // rust: assert!(m.add_effect_with("speed", 100, 0, false, true));
    // rust: assert!(!m.extra.ambient_effects.contains(&speed));
        // Ambient over a not ambient one that does not change: not taken; one that changes: taken.
    // rust: assert!(!m.add_effect_with("speed", 100, 0, true, true));
    // rust: assert!(!m.extra.ambient_effects.contains(&speed));
    // rust: assert!(m.add_effect_with("speed", 900, 0, true, true));
    // rust: assert!(m.extra.ambient_effects.contains(&speed));
    // rust: assert_eq!(m.extra.effects, vec![(speed, 900, 0)]);
}

    // `Witch.getDamageAfterMagicAbsorb`: `#witch_resistant_to` (`magic`,
    // `indirect_magic`, `sonic_boom`, `thorns`) takes 15% of the hit, which
    // leaves a 10 health witch on 7 of a 20 hit it would not survive whole.
a_witch_takes_15_percent_of_a_witch_resistant_hit :: proc() {
}
    // rust: for resistant in [
    // rust: DamageKind::Magic,
    // rust: DamageKind::IndirectMagic,
    // rust: DamageKind::SonicBoom,
    // rust: DamageKind::Thorns,
    // rust: ] {
    // rust: let mut m = witch();
    // rust: assert!(m.damage(20.0, Damage::of(resistant)));
    // rust: assert_eq!(m.health, 7.0, "{resistant:?} is in #witch_resistant_to");
}
}

    // A hit outside the tag (`mob_attack`) takes all of it.
a_witch_takes_all_of_a_physical_hit :: proc() {
}
    // rust: let mut m = witch();
    // rust: m.damage(4.0, Damage::of(DamageKind::MobAttack));
    // rust: assert_eq!(m.health, 6.0);
}

    // `Witch.getDamageAfterMagicAbsorb`: a source whose entity is the witch
    // itself takes nothing, so its own harming potion cannot hurt it.
a_witch_takes_nothing_from_its_own_hit :: proc() {
}
    // rust: let mut m = witch();
    // rust: let own = Damage {
    // rust: kind: DamageKind::IndirectMagic,
    // rust: attacker: Some(Who::Mob(m.id)),
    // rust: from: None,
    // rust: attacker_species: Some(Species::Witch),
}
    // rust: m.damage(20.0, own);
    // rust: assert_eq!(m.health, 10.0);
}

    // `damage_by` with a thrown potion's `indirectMagic(potion, owner)`: the
    // hit keeps the potion as its direct entity and is the thrower's (a
    // player's sets `lastHurtByPlayer`, a dispenser's names nobody); the next
    // hit that names no direct entity forgets it.
a_potion_hit_keeps_its_direct_entity_and_owner :: proc() {
}
    // rust: let mut m = Mob::new(1, kind(), Vec3::ZERO, 0.0);
    // rust: let thrown = Damage::indirect_magic(Some(Who::Player), [0.0, 1.0, 0.0]);
    // rust: assert!(m.damage_by(1.0, thrown, "minecraft:splash_potion"));
    // rust: assert_eq!(m.last_direct, Some("minecraft:splash_potion"));
    // rust: let (last, _) = m.last_damage.unwrap();
    // rust: assert_eq!(last.kind, DamageKind::IndirectMagic);
    // rust: assert_eq!(last.attacker, Some(Who::Player));
    // rust: assert_eq!(m.ai.last_hurt_by_player, 100);
    // rust: m.invulnerable = 0;
    // rust: assert!(m.damage(1.0, Damage::of(DamageKind::Generic)));
    // rust: assert_eq!(m.last_direct, None);

    // rust: let mut m = Mob::new(1, kind(), Vec3::ZERO, 0.0);
    // rust: let dispensed = Damage::indirect_magic(None, [0.0, 1.0, 0.0]);
    // rust: assert!(m.damage_by(1.0, dispensed, "minecraft:area_effect_cloud"));
    // rust: assert_eq!(m.last_direct, Some("minecraft:area_effect_cloud"));
    // rust: assert_eq!(m.ai.last_hurt_by_player, 0);
}

    // A harming potion's hit on a witch through `damage_by` is cut to 15%
    // once (`getDamageAfterMagicAbsorb`), not again by the potion code.
a_witch_takes_15_percent_of_a_potion_hit :: proc() {
}
    // rust: let mut m = witch();
    // rust: let thrown = Damage::indirect_magic(Some(Who::Player), [0.0, 1.0, 0.0]);
    // rust: assert!(m.damage_by(20.0, thrown, "minecraft:splash_potion"));
    // rust: assert_eq!(m.health, 7.0);
}
}

    // rust: mod armor_hurt_tests {
//     use super::sensor_scan_tests::kind;
//     use super::*;
//     use horizon_core::geometry::Vec3;

horse :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: mob("minecraft:horse", Species::Horse)
}

mob :: proc(id: string, species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = id.into();
    // rust: k.species = species;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `LivingEntity.hurtArmor` (`doHurtEquipment`): a hit that lands on a mob
    // wearing body armour leaves the piece owing a wear, which the host
    // applies with the item's own maximum and fire rules.
a_hurt_horse_reports_the_body_armour_wear :: proc() {
}
    // rust: let hit = Damage {
    // rust: kind: DamageKind::MobAttack,
    // rust: attacker: None,
    // rust: from: None,
    // rust: attacker_species: None,
}
    // rust: let mut m = horse();
    // rust: m.extra.body = Some("minecraft:diamond_horse_armor".into());
    // rust: assert!(m.damage(6.0, hit), "the hit landed");
    // rust: let owed = m.outbox.iter().find_map(|e| match e {
    // rust: MobEvent::ArmorHurt { amount, .. } => Some(*amount),
    // rust: _ => None,
    // rust: });
    // rust: assert!(
    // rust: owed.is_some_and(|amount| amount > 0.0),
    // rust: "the worn armour owes a wear: {owed:?}"
    // rust: );
        // A horse with no body armour owes nothing.
    // rust: let mut bare = horse();
    // rust: assert!(bare.damage(6.0, hit));
    // rust: assert!(
    // rust: !bare
    // rust: .outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::ArmorHurt { .. }))
    // rust: );
}

    // `Horse` is the only mob that overrides `LivingEntity.hurtArmor` (the
    // base one is empty, `LivingEntity.java:1887`), so a donkey wearing a body
    // item — `/item replace entity @e[type=minecraft:donkey,limit=1]
    // armor.body with minecraft:wolf_armor` — wears nothing, even though
    // vanilla only gives a horse's body piece the wear.
a_donkey_wearing_a_body_item_wears_nothing :: proc() {
}
    // rust: let mut donkey = mob("minecraft:donkey", Species::Donkey);
    // rust: donkey.extra.body = Some("minecraft:wolf_armor".into());
    // rust: assert!(
    // rust: donkey.damage(6.0, Damage::of(DamageKind::MobAttack)),
    // rust: "the hit landed"
    // rust: );
    // rust: assert!(
    // rust: !donkey
    // rust: .outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::ArmorHurt { .. })),
    // rust: "only a horse's own override wears its body piece"
    // rust: );
}

    // Vanilla holds a head item and a body item at once on the mobs with a
    // body slot (`LivingEntity.setItemSlot` over `EntityEquipment`): the
    // packet keeps the helmet on 5 and the armour on 6, `/item` reads each
    // back, and the armour value is the body piece's.
a_horse_holds_a_helmet_and_its_body_armour_at_once :: proc() {
}
//         use horizon_world::player_inventory::EquipmentSlot;
    // rust: let mut m = horse();
    // rust: m.extra.head = Some("minecraft:iron_helmet".into());
    // rust: m.extra.body = Some("minecraft:diamond_horse_armor".into());
    // rust: let gear = m.equipment_stacks();
    // rust: assert_eq!(
    // rust: gear[5].as_ref().map(|s| s.item.as_ref().to_owned()),
    // rust: Some("minecraft:iron_helmet".to_owned())
    // rust: );
    // rust: assert_eq!(
    // rust: gear[6].as_ref().map(|s| s.item.as_ref().to_owned()),
    // rust: Some("minecraft:diamond_horse_armor".to_owned())
    // rust: );
    // rust: let slot = |s| m.item_by_slot(s).map(|i| i.item.as_ref().to_owned());
    // rust: assert_eq!(
    // rust: slot(EquipmentSlot::Head),
    // rust: Some("minecraft:iron_helmet".to_owned())
    // rust: );
    // rust: assert_eq!(
    // rust: slot(EquipmentSlot::Body),
    // rust: Some("minecraft:diamond_horse_armor".to_owned())
    // rust: );
    // rust: let (armor, _) = m.worn_armor();
    // rust: assert!(armor > 0.0, "the body piece armors the horse");
        // Death keeps both (`Mob.dropCustomDeathLoot` by slot).
    // rust: let body = crate::mobs::drops::slot_item(&m, "body").unwrap();
    // rust: let head = crate::mobs::drops::slot_item(&m, "head").unwrap();
    // rust: assert_eq!(body.item, "minecraft:diamond_horse_armor");
    // rust: assert_eq!(head.item, "minecraft:iron_helmet");
}

    // `getDamageAfterArmorAbsorb` asks `hurtArmor` only when the damage type
    // is not in `#bypasses_armor` (`LivingEntity.java:1907-1909`), so a horse
    // that falls keeps its body piece whole.
a_fall_does_not_wear_the_body_piece :: proc() {
}
    // rust: let mut m = horse();
    // rust: m.extra.body = Some("minecraft:diamond_horse_armor".into());
    // rust: assert!(
    // rust: m.damage(6.0, Damage::of(DamageKind::Fall)),
    // rust: "the fall landed"
    // rust: );
    // rust: assert!(
    // rust: !m.outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::ArmorHurt { .. })),
    // rust: "a #bypasses_armor hit asks for no wear"
    // rust: );
}

    // The wear is measured by the damage `hurtArmor` is handed, which is the
    // one the armour, toughness and enchantment reductions have not touched
    // yet: 8 raw damage is `8 / 4 = 2` durability even though plate leaves far
    // less than 8 through to the health.
the_wear_is_the_damage_before_the_armour_reduction :: proc() {
}
    // rust: let mut m = horse();
    // rust: let k = Arc::make_mut(&mut m.kind);
    // rust: k.armor = 20.0;
    // rust: m.extra.body = Some("minecraft:diamond_horse_armor".into());
    // rust: let before = m.health;
    // rust: assert!(m.damage(8.0, Damage::of(DamageKind::MobAttack)));
    // rust: assert!(m.health < before, "the hit reached the health");
    // rust: let owed = m.outbox.iter().find_map(|e| match e {
    // rust: MobEvent::ArmorHurt { amount, .. } => Some(*amount),
    // rust: _ => None,
    // rust: });
    // rust: assert_eq!(
    // rust: owed,
    // rust: Some(8.0),
    // rust: "the pre-reduction damage, not the damage the health took"
    // rust: );
}
}

    // rust: mod allay_damage_identity_tests {
//     use super::*;

ACTUAL :: [101, 102, 103, 104]
OTHER :: [10, 20, 30, 40]

allay :: proc(liked: Maybe([i32; 4])) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = (*super::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:allay".into();
    // rust: kind.species = Species::Allay;
    // rust: kind.max_health = 20.0;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.tame = liked.is_some();
    // rust: m.extra.owner = liked;
    // rust: m
}

verified_player_damage_compares_live_liked_uuid :: proc() {
}
    // rust: for liked in [Some(ACTUAL), Some(OTHER), None] {
    // rust: let mut m = allay(liked);
    // rust: let accepted = m.damage_with_player_uuid(2.0, Damage::player([0.0; 3]), ACTUAL, None);
    // rust: assert_eq!(accepted, liked != Some(ACTUAL), "liked={liked:?}");
    // rust: assert_eq!(m.health, if accepted { 18.0 } else { 20.0 });
    // rust: assert_eq!(m.hurt_time, if accepted { 10 } else { 0 });
    // rust: assert_eq!(m.extra.owner, liked);
}
        // A UUID context alone must not turn a source without a player into its liked player.
    // rust: let mut m = allay(Some(ACTUAL));
    // rust: assert!(m.damage_with_player_uuid(2.0, Damage::of(DamageKind::Generic), ACTUAL, None));
    // rust: assert_eq!(m.health, 18.0);
}

unresolved_player_and_projectile_entrypoints_keep_legacy_behavior :: proc() {
}
    // rust: for liked in [Some(ACTUAL), Some(OTHER), None] {
    // rust: let mut m = allay(liked);
    // rust: assert_eq!(m.damage(2.0, Damage::player([0.0; 3])), liked.is_none());
    // rust: assert_eq!(m.health, if liked.is_none() { 18.0 } else { 20.0 });
            // This is compatibility coverage, not UUID attribution parity for projectiles.
    // rust: let mut m = allay(liked);
    // rust: let arrow = Damage {
    // rust: kind: DamageKind::Arrow,
    // rust: ..Damage::player([0.0; 3])
}
    // rust: assert_eq!(
    // rust: m.damage_projectile(2.0, arrow, None, [1.0, 0.0]),
    // rust: liked.is_none()
    // rust: );
    // rust: assert_eq!(m.health, if liked.is_none() { 18.0 } else { 20.0 });
    // rust: assert!(m.projectile_motion.is_none());
}
    // rust: let mut m = allay(Some(ACTUAL));
    // rust: assert!(m.damage(2.0, Damage::of(DamageKind::Generic)));
}
}

    // rust: mod totem_tests {
//     use super::*;

fox :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: t.species = Species::Fox;
    // rust: t.max_health = 10.0;
    // rust: Mob::new(1, Arc::new(t), Vec3::ZERO, 0.0)
}

    // `LivingEntity.checkTotemDeathProtection`: a totem in the mouth takes
    // the killing blow, the fox stays at 1 health with the totem's effects,
    // and entity event 35 tells the clients to draw it.
a_totem_in_the_mouth_saves_a_fox :: proc() {
}
    // rust: let mut m = fox();
    // rust: m.extra
    // rust: .set_main_hand(Some("minecraft:totem_of_undying".into()));
    // rust: assert!(m.damage(1000.0, Damage::of(DamageKind::Generic)));
    // rust: assert!(m.alive(), "the totem kept it alive");
    // rust: assert_eq!(m.health, 1.0);
    // rust: assert_eq!(m.extra.main_hand, None, "the totem was used up");
        // DeathProtection.TOTEM_EFFECTS.
    // rust: assert_eq!(
    // rust: m.extra.effects,
    // rust: vec![
    // rust: ("minecraft:regeneration", 900, 1),
    // rust: ("minecraft:absorption", 100, 1),
    // rust: ("minecraft:fire_resistance", 800, 0),
    // rust: ]
    // rust: );
    // rust: assert!(
    // rust: m.outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::EntityEvent { event: 35, .. }))
    // rust: );
}

    // `getItemInHand` asks the main hand first, then the off hand.
a_totem_in_the_off_hand_saves_a_fox_too :: proc() {
}
    // rust: let mut m = fox();
    // rust: m.extra.off_hand = Some("minecraft:totem_of_undying".into());
    // rust: assert!(m.damage(1000.0, Damage::of(DamageKind::Generic)));
    // rust: assert!(m.alive());
    // rust: assert_eq!(m.health, 1.0);
    // rust: assert_eq!(m.extra.off_hand, None);
}

    // Without one in either hand the blow kills it as before.
without_a_totem_the_blow_kills :: proc() {
}
    // rust: let mut m = fox();
    // rust: m.extra
    // rust: .set_main_hand(Some("minecraft:sweet_berries".into()));
    // rust: assert!(m.damage(1000.0, Damage::of(DamageKind::Generic)));
    // rust: assert!(!m.alive());
}

    // `DamageTypeTags.BYPASSES_INVULNERABILITY` (`/kill`, the void) is not
    // something a totem answers.
a_bypassing_killing_blow_ignores_the_totem :: proc() {
}
    // rust: let mut m = fox();
    // rust: m.extra
    // rust: .set_main_hand(Some("minecraft:totem_of_undying".into()));
    // rust: assert!(m.damage(1000.0, Damage::of(DamageKind::GenericKill)));
    // rust: assert!(!m.alive());
    // rust: assert_eq!(
    // rust: m.extra.main_hand.as_deref(),
    // rust: Some("minecraft:totem_of_undying"),
    // rust: "the totem is still in the mouth"
    // rust: );
}
}
    // rust: mod effect_refusal_tests {
//     use super::*;

    // A mob of a real type, from the extracted data (`entity-types.json`), so the
    // `undead`, `MobCategory` and species facts are the ones the game has.
mob :: proc(types: ^MobTypes, id: string) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let kind = Arc::new(types.types.get(id).expect(id).clone());
    // rust: Mob::new(1, kind, Vec3::new(0.0, 64.0, 0.0), 0.0)
}
    // `LivingEntity.addEffect` asks `canBeAffected` before it stores anything: an
    // effect the mob's type refuses never joins the list, so the cloud on its head,
    // the `/effect` reply and an effect tick never see it. The refused ones are the
    // `ignores_poison_and_regen` tag (which is `#minecraft:undead`), a silverfish's
    // infested and a slime's oozing, the classes that override the rule, and the
    // wither, whose `addEffect` refuses every effect.
an_effect_the_mobs_type_refuses_is_never_added :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let types = MobTypes::load_for_server(&root).unwrap();
    // rust: let refused = |id: &str, effect: &'static str| {
    // rust: let mut m = mob(&types, id);
    // rust: m.add_effect(effect, 200, 0);
    // rust: let listed = m.has_effect(effect);
    // rust: (listed, m.extra.effects.len())
}
        // `#minecraft:undead` is the `ignores_poison_and_regen` tag: a zombie, a
        // skeleton and a phantom turn both poison and regeneration away.
    // rust: for undead in [
    // rust: "minecraft:zombie",
    // rust: "minecraft:skeleton",
    // rust: "minecraft:phantom",
    // rust: "minecraft:zombie_horse",
    // rust: ] {
    // rust: for effect in ["minecraft:poison", "minecraft:regeneration"] {
    // rust: assert_eq!(refused(undead, effect), (false, 0), "{undead} {effect}");
}
            // Every other effect still lands on it.
    // rust: assert_eq!(refused(undead, "minecraft:strength"), (true, 1), "{undead}");
}
        // The tag's other two effects, each refused by the one type in it.
    // rust: assert_eq!(
    // rust: refused("minecraft:silverfish", "minecraft:infested"),
    // rust: (false, 0)
    // rust: );
    // rust: assert_eq!(
    // rust: refused("minecraft:silverfish", "minecraft:poison"),
    // rust: (true, 1)
    // rust: );
    // rust: assert_eq!(refused("minecraft:slime", "minecraft:oozing"), (false, 0));
        // A magma cube is not in `immune_to_oozing`, so oozing takes.
    // rust: assert_eq!(
    // rust: refused("minecraft:magma_cube", "minecraft:oozing"),
    // rust: (true, 1)
    // rust: );
        // Spider.canBeAffected and CaveSpider's inheritance: poison is refused, and a
        // nautilus refuses it too (AbstractNautilus.canBeAffected), the zombie one
        // through the same override, an ordinary mob not at all.
    // rust: for spider in [
    // rust: "minecraft:spider",
    // rust: "minecraft:cave_spider",
    // rust: "minecraft:nautilus",
    // rust: ] {
    // rust: assert_eq!(refused(spider, "minecraft:poison"), (false, 0), "{spider}");
}
    // rust: assert_eq!(refused("minecraft:cow", "minecraft:poison"), (true, 1));
        // WitherBoss.addEffect returns false: the boss takes no effect at all.
    // rust: for effect in [
    // rust: "minecraft:wither",
    // rust: "minecraft:strength",
    // rust: "minecraft:speed",
    // rust: "minecraft:poison",
    // rust: ] {
    // rust: assert_eq!(
    // rust: refused("minecraft:wither", effect),
    // rust: (false, 0),
    // rust: "wither {effect}"
    // rust: );
}
        // WitherSkeleton.canBeAffected refuses the wither effect only, which a
        // zombie takes.
    // rust: assert_eq!(
    // rust: refused("minecraft:wither_skeleton", "minecraft:wither"),
    // rust: (false, 0)
    // rust: );
    // rust: assert_eq!(
    // rust: refused("minecraft:wither_skeleton", "minecraft:strength"),
    // rust: (true, 1)
    // rust: );
    // rust: assert_eq!(refused("minecraft:zombie", "minecraft:wither"), (true, 1));
        // Parched.canBeAffected: weakness only, slowness takes.
    // rust: assert_eq!(
    // rust: refused("minecraft:parched", "minecraft:weakness"),
    // rust: (false, 0)
    // rust: );
    // rust: assert_eq!(
    // rust: refused("minecraft:parched", "minecraft:slowness"),
    // rust: (true, 1)
    // rust: );
}

    // Squid.hurtServer reports a hit only when a living entity dealt it, so
    // environmental damage leaves a glow squid glowing; a mob's blow dims it.
only_a_mobs_blow_dims_a_glow_squid :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let types = MobTypes::load_for_server(&root).unwrap();
    // rust: let mut burned = mob(&types, "minecraft:glow_squid");
    // rust: burned.health = 10.0;
    // rust: assert!(burned.damage(1.0, Damage::of(DamageKind::Campfire)));
    // rust: assert_eq!(aquatic::dark_ticks(&burned), 0);
    // rust: let mut struck = mob(&types, "minecraft:glow_squid");
    // rust: struck.health = 10.0;
    // rust: assert!(struck.damage(1.0, Damage::mob(2, [0.0, 64.0, 0.0])));
    // rust: assert_eq!(aquatic::dark_ticks(&struck), 100);
}
}
    // rust: crate::impl_joined!(Mob);

    // rust: mod named_damage_tests {
//     use super::*;

pig :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = super::sensor_scan_tests::kind();
    // rust: let def = Arc::make_mut(&mut kind);
    // rust: def.id = "minecraft:pig".into();
    // rust: def.species = Species::Pig;
    // rust: def.armor = 20.0;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}
fire :: proc(tags: u32) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Damage::of(DamageKind::Named(NamedDamage::new(
    // rust: "example:fan_fire",
    // rust: NamedDamage::IS_FIRE | NamedDamage::BYPASSES_ARMOR | tags,
    // rust: )))
}
named_fire_uses_normal_immunity_and_protection_without_becoming_on_fire :: proc() {
}
    // rust: let mut resistant = pig();
    // rust: resistant.add_effect("minecraft:fire_resistance", -1, 0);
    // rust: assert!(!resistant.damage(2.0, fire(0)));
    // rust: assert_eq!((resistant.health, resistant.invulnerable), (10.0, 0));
    // rust: let mut immune = pig();
    // rust: Arc::make_mut(&mut immune.kind).flags.fire_immune = true;
    // rust: assert!(!immune.damage(2.0, fire(0)));
    // rust: let mut bare = pig();
    // rust: assert!(bare.damage(2.0, fire(0)));
    // rust: assert_eq!(bare.health, 8.0); // bypasses the 20 armor points
    // rust: assert!(bare.velocity.x != 0.0 || bare.velocity.z != 0.0);
    // rust: assert_eq!(bare.last_damage.unwrap().0.kind, fire(0).kind);
    // rust: let mut protected = pig();
    // rust: gear::set(
    // rust: &mut protected,
    // rust: gear::CHEST,
    // rust: vec![("minecraft:fire_protection".into(), 4)],
    // rust: );
    // rust: assert!(protected.damage(2.0, fire(0)));
    // rust: assert!((protected.health - 8.64).abs() < 0.00001);
    // rust: let mut still = pig();
    // rust: assert!(still.damage(2.0, fire(NamedDamage::NO_KNOCKBACK)));
    // rust: assert_eq!(still.velocity, Vec3::ZERO);
}
named_tags_control_resistance_and_specialist_enchantments :: proc() {
}
    // rust: let mut mob = pig();
    // rust: mob.add_effect("minecraft:resistance", -1, 0);
    // rust: assert!(mob.damage(2.0, fire(0)));
    // rust: assert!((mob.health - 8.4).abs() < 0.00001);
    // rust: let mut bypass = pig();
    // rust: bypass.add_effect("minecraft:resistance", -1, 0);
    // rust: assert!(bypass.damage(2.0, fire(NamedDamage::BYPASSES_RESISTANCE)));
    // rust: assert_eq!(bypass.health, 8.0);
    // rust: let mut no_effects = pig();
    // rust: no_effects.add_effect("minecraft:resistance", -1, 0);
    // rust: gear::set(
    // rust: &mut no_effects,
    // rust: gear::CHEST,
    // rust: vec![("minecraft:fire_protection".into(), 4)],
    // rust: );
    // rust: assert!(no_effects.damage(2.0, fire(NamedDamage::BYPASSES_EFFECTS)));
    // rust: assert_eq!(no_effects.health, 8.0);
    // rust: let mut armor = gear::Gear::default();
    // rust: armor.slots[gear::FEET] = vec![("minecraft:feather_falling".into(), 4)];
    // rust: armor.slots[gear::CHEST] = vec![("minecraft:blast_protection".into(), 4)];
    // rust: let kind = |tags| DamageKind::Named(NamedDamage::new("example:impact", tags));
    // rust: assert_eq!(gear::protection_points(&armor, kind(0)), 0.0);
    // rust: assert_eq!(
    // rust: gear::protection_points(&armor, kind(NamedDamage::IS_FALL)),
    // rust: 12.0
    // rust: );
    // rust: assert_eq!(
    // rust: gear::protection_points(&armor, kind(NamedDamage::IS_EXPLOSION)),
    // rust: 8.0
    // rust: );
}
}

    // rust: mod silent_voice_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    // The sounds `Mob::voice` plays for `ambient_sound` of one mob, with
    // `silent` set on it, and the random state it leaves behind.
ambient :: proc(silent: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = None;
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:cow"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.silent = silent;
    // rust: let mut events = Vec::new();
    // rust: crate::mobs::ai::ambient_sound(&mut m, w, &mut events);
    // rust: let heard = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(s, _, volume, pitch) => Some((*s, *volume, *pitch)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: out = Some((heard, m.random.next_float()));
    // rust: });
    // rust: ran.then_some(out).flatten()
}

    // `Mob.playAmbientSound` plays through `Entity.playSound`, which returns
    // early for a silent entity, so a mob summoned with `Silent:1b` makes no
    // ambient sound. The pitch is still drawn first, as Java evaluates the
    // arguments of `playSound(event, getSoundVolume(), getVoicePitch())`
    // before the call, so the random state is the same either way. Without
    // the check the silent cow plays `entity.cow.ambient` like the loud one,
    // and without drawing first its random state falls two draws behind.
a_silent_mob_makes_no_ambient_sound :: proc() {
}
    // rust: let Some((loud, loud_next)) = ambient(false) else {
    // rust: return;
}
    // rust: let (quiet, quiet_next) = ambient(true).expect("same data");
        // Cow.getSoundVolume is 0.4 and the pitch is the voice pitch.
    // rust: assert_eq!(loud.len(), 1);
    // rust: assert_eq!(loud[0].0, "entity.cow.ambient");
    // rust: assert_eq!(loud[0].1, 0.4);
    // rust: assert!((0.8..=1.2).contains(&loud[0].2), "{}", loud[0].2);
    // rust: assert!(quiet.is_empty(), "{quiet:?}");
    // rust: assert_eq!(quiet_next, loud_next, "the pitch is drawn either way");
}
}

    // rust: mod visibility_percent_tests {
//     use super::*;
//     use serde_json::json;

    // The four heads `Items` registers, with the component JSON vanilla writes.
heads :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut items = crate::items::Items::for_tests(HashMap::new());
    // rust: items.insert_mob_visibility_component(
    // rust: "minecraft:skeleton_skull",
    // rust: &json!({
    // rust: "minecraft:equippable": {"slot": "head", "swappable": false},
    // rust: "minecraft:mob_visibility": {
    // rust: "targeting_entity_types": "minecraft:skeleton",
    // rust: "visibility": 0.5
}
    // rust: }),
    // rust: );
    // rust: items.insert_mob_visibility_component(
    // rust: "minecraft:zombie_head",
    // rust: &json!({
    // rust: "minecraft:equippable": {"slot": "head"},
    // rust: "minecraft:mob_visibility": {
    // rust: "targeting_entity_types": "minecraft:zombie",
    // rust: "visibility": 0.5
}
    // rust: }),
    // rust: );
    // rust: items.insert_mob_visibility_component(
    // rust: "minecraft:creeper_head",
    // rust: &json!({
    // rust: "minecraft:equippable": {"slot": "head"},
    // rust: "minecraft:mob_visibility": {
    // rust: "targeting_entity_types": "minecraft:creeper",
    // rust: "visibility": 0.5
}
    // rust: }),
    // rust: );
    // rust: items.insert_mob_visibility_component(
    // rust: "minecraft:piglin_head",
    // rust: &json!({
    // rust: "minecraft:equippable": {"slot": "head"},
    // rust: "minecraft:mob_visibility": {
    // rust: "targeting_entity_types": ["minecraft:piglin", "minecraft:piglin_brute"],
    // rust: "visibility": 0.5
}
    // rust: }),
    // rust: );
    // rust: items
}

    // `LivingEntity.getVisibilityPercent` halves the range for the mob named
    // on the worn head, and leaves every other mob at full range. A skull
    // held in the hand does not count: its equippable slot is the head.
worn_mob_heads_halve_that_mobs_detection_range :: proc() {
}
    // rust: let items = heads();
    // rust: let see = |head: &str, mob: &str| {
    // rust: let mut player = world::test_player(Vec3::ZERO);
    // rust: player.head = Some(Arc::from(head));
    // rust: player.visibility_percent(Some(mob), Some(&items))
}
    // rust: assert_eq!(see("minecraft:skeleton_skull", "minecraft:skeleton"), 0.5);
    // rust: assert_eq!(see("minecraft:zombie_head", "minecraft:zombie"), 0.5);
    // rust: assert_eq!(see("minecraft:creeper_head", "minecraft:creeper"), 0.5);
    // rust: assert_eq!(see("minecraft:piglin_head", "minecraft:piglin"), 0.5);
    // rust: assert_eq!(see("minecraft:piglin_head", "minecraft:piglin_brute"), 0.5);
    // rust: assert_eq!(see("minecraft:skeleton_skull", "minecraft:zombie"), 1.0);
    // rust: assert_eq!(
    // rust: see("minecraft:piglin_head", "minecraft:zombified_piglin"),
    // rust: 1.0
    // rust: );
    // rust: assert_eq!(
    // rust: see(
    // rust: "minecraft:wither_skeleton_skull",
    // rust: "minecraft:wither_skeleton"
    // rust: ),
    // rust: 1.0
    // rust: );

    // rust: let mut held = world::test_player(Vec3::ZERO);
    // rust: held.main_hand = Some(Arc::from("minecraft:skeleton_skull"));
    // rust: assert_eq!(
    // rust: held.visibility_percent(Some("minecraft:skeleton"), Some(&items)),
    // rust: 1.0
    // rust: );

    // rust: let mut sneaking = world::test_player(Vec3::ZERO);
    // rust: sneaking.head = Some(Arc::from("minecraft:skeleton_skull"));
    // rust: sneaking.sneaking = true;
    // rust: assert_eq!(
    // rust: sneaking.visibility_percent(Some("minecraft:skeleton"), Some(&items)),
    // rust: 0.4
    // rust: );
}
}
