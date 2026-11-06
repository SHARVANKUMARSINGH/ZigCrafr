//! Transpiled from Horizon Rust crate
//! Module: horizon-client_cit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! OptiFine Custom Item Textures on item models: the layer of a stack a `type=item` rule matches
//! draws the rule's model, or its own model with the rule's textures in some slots. The rules'
//! JSON models join the model library, their textures the atlas (`cit_assets`).

// use super::{ItemRenderer, corners};
// use crate::cit::{CitRules, Hand, Kind};
// use crate::cit_assets::{self, model_id, sprite_id};
// use crate::hud::cit_glint::GlintTextures;
// use crate::items::ItemStack;
// use glam::Vec3;
// use horizon_assets::{
    // rust: item_bake::{BakedItemModel, bake_resolved},
    // rust: model::{Material, TextureSlot},
    // rust: resolve::{MISSING_MODEL, ModelLibrary},
}
// use horizon_world::nbt::Tag;
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: path::Path,
    // rust: sync::{Arc, Mutex, MutexGuard, PoisonError},
}

/// A baked layer and its quad corners, as `ItemRenderer::bake` and `quad_extents` give them.
    // rust: pub(super) type Baked = (Arc<BakedItemModel>, Arc<Vec<Vec3>>);

/// What one item rule swaps, as model and sprite ids.
pub const Plan = struct {
    model: ?[]const u8,
    /// `model.<name>`, by the leaf model's [`short`] name.
    models: HashMap<[]const u8,
    texture: ?[]const u8,
    /// `texture.<name>`: a leaf, a slot or a sprite's file name, and its sprite.
    textures: Vec<([]const u8,
};

/// One swapped bake: the model and the sprite each changed slot takes, `None`
/// for a layer cleared; and the generic texture, whose quads are left untinted.
pub const CitBake = struct {
    base: []const u8,
    slots: BTreeMap<[]const u8,
    untinted: ?[]const u8,
};

/// The enabled packs' rules and what their item rules bake to.
pub const CitModels = struct {
    rules: CitRules,
    /// The enchantment rules' glint textures.
    glint_textures: GlintTextures,
    /// Per rule (an index into `rules.rules`); `None` for rules of other kinds.
    plans: std.ArrayList(?Plan),
    /// Per (rule, leaf model): its bake, `None` where the rule leaves the leaf alone.
    memo: Mutex<HashMap<(usize,
    baked: Mutex<HashMap<CitBake,
};

    // rust: fn lock<T>(m: &Mutex<T>) -> MutexGuard<'_, T> {
    // rust: m.lock().unwrap_or_else(PoisonError::into_inner)
}

/// The last segment of an id: `minecraft:item/bow_pulling_1` is `bow_pulling_1`.
pub fn short(id: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = id.rsplit_once(':').map_or(id, |(_, p)| p);
    // rust: path.rsplit('/').next().unwrap_or(path)
}

/// The 26.x name of an OptiFine sub-texture or sub-model name: the bow's
/// `bow_standby` frame is model `item/bow`, and the potions' bottle layers are
/// the files `potion`, `splash_potion` and `lingering_potion`.
pub fn legacy(name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "bow_standby" => "bow",
    // rust: "potion_bottle_drinkable" => "potion",
    // rust: "potion_bottle_splash" => "splash_potion",
    // rust: "potion_bottle_lingering" => "lingering_potion",
    // rust: other => other,
}
}

/// The `max_damage` a CIT rule's `damage` test reads: the stack's own
/// component when it holds a non-negative int, else `item_max`, its item's.
pub fn stack_max_damage(stack: *ItemStack, item_max: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack
    // rust: .data()
    // rust: .and_then(|d| match d.other("minecraft:max_damage") {
    // rust: Some(Tag::Int(v)) => u32::try_from(*v).ok(),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or(item_max)
}

/// The winning `kind` (Armor or Elytra) rule of a worn `stack` whose item has `item_max` max
/// damage, as an index into `rules.rules`. Worn items count as the main hand: OptiFine's off hand
/// is the off-hand slot alone.
pub fn worn_rule(rules: *CitRules, kind: Kind, stack: *ItemStack, item_max: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rules.select(kind, stack, Hand::Main, stack_max_damage(stack, item_max))
}

/// The rules at `root` and `library` with their models, or `library` alone without rules.
    // rust: pub(super) fn load(
    // rust: root: &Path,
    // rust: library: Arc<ModelLibrary>,
    // rust: ) -> (Arc<ModelLibrary>, Option<CitModels>) {
    // rust: let rules = CitRules::load(root);
    // A `cit.properties` alone can still turn vanilla's glint off.
    // rust: if rules.is_empty() && rules.global.use_glint {
    // rust: return (library, None);
}
    // rust: let extra = cit_assets::load_models(root, &rules.rules);
    // rust: let library = if extra.is_empty() {
    // rust: library
    // rust: } else {
    // rust: match library.overlaid(extra) {
    // rust: Ok(over) => Arc::new(over),
    // rust: Err(e) => {
    // rust: log::warn!("custom item textures: models left out: {e}");
    // rust: library
}
}
}
    // rust: let mut models = CitModels::new(rules);
    // rust: models.glint_textures = GlintTextures::load(root, &models.rules.rules);
    // An enchantment rule whose texture has no slot draws nothing, so it must not take its
    // layer (or vanilla's glint) from the stack either.
    // rust: let slots = &models.glint_textures.slot_of;
    // rust: models
    // rust: .rules
    // rust: .keep_glints(|i| slots.get(i).copied().flatten().is_some());
    // rust: (library, Some(models))
}

    // rust: impl CitModels {
pub fn new(rules: CitRules) S {
    // Implementation ported from Horizon
    return undefined;
}
        // By 26.x name, in file order. A 26.x name beats OptiFine's old name
        // for the same thing (`texture.bow` over `texture.bow_standby`)
        // wherever either stands; of two alike, the later wins.
    // rust: let pairs = |list: &[(String, String)], id: fn(&str) -> Option<String>| {
    // rust: let mut out: Vec<(String, String, bool)> = Vec::new();
    // rust: for (name, path) in list {
    // rust: let Some(asset) = id(path) else { continue };
    // rust: let (old, new) = (short(name), legacy(short(name)));
    // rust: let modern = old == new;
    // rust: match out.iter_mut().find(|(n, ..)| n.as_str() == new) {
    // rust: Some(entry) if modern || !entry.2 => *entry = (new.to_owned(), asset, modern),
    // rust: Some(_) => {}
    // rust: None => out.push((new.to_owned(), asset, modern)),
}
}
    // rust: out.into_iter()
    // rust: .map(|(name, asset, _)| (name, asset))
    // rust: .collect::<Vec<_>>()
}
    // rust: let plans = rules
    // rust: .rules
    // rust: .iter()
    // rust: .map(|r| {
    // rust: (r.kind == Kind::Item).then(|| Plan {
    // rust: model: r.model.as_deref().and_then(model_id),
    // rust: models: pairs(&r.models, model_id).into_iter().collect(),
    // rust: texture: r.texture.as_deref().and_then(sprite_id),
    // rust: textures: pairs(&r.textures, sprite_id),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: rules,
    // rust: glint_textures: GlintTextures::default(),
    // rust: plans,
    // rust: memo: Mutex::default(),
    // rust: baked: Mutex::default(),
}
}
}

    // rust: impl ItemRenderer {
    /// The layer whose model is `leaf` as item rule `rule` draws it; `None` draws it as usual.
    // rust: pub(super) fn cit_layer(&self, rule: usize, leaf: &str) -> Option<Baked> {
    // rust: let cit = self.cit.as_ref()?;
    // rust: let key = (rule, leaf.to_owned());
    // rust: let known = lock(&cit.memo).get(&key).cloned();
    // rust: let bake = match known {
    // rust: Some(bake) => bake,
    // rust: None => {
    // rust: let bake = self.cit_plan(cit, rule, leaf);
    // rust: lock(&cit.memo).insert(key, bake.clone());
    // rust: bake
}
    // rust: }?;
    // rust: if let Some(hit) = lock(&cit.baked).get(&bake) {
    // rust: return Some(hit.clone());
}
    // rust: let baked = self.cit_bake(&bake);
    // rust: lock(&cit.baked).insert(bake, baked.clone());
    // rust: Some(baked)
}

    /// The model choice for one leaf, as CIT Resewn's wiki (CIT Item) gives it:
    /// `model.<leaf>` draws that model. `texture.<leaf>` replaces the leaf
    /// with the item generated from it (on a model with elements, its every
    /// face); on a leaf of several layers, one of
    /// which is a slot or a sprite file named `<leaf>` (the 26.x potion's
    /// bottle is `layer1`, file `potion`), it is that layer's texture instead.
    /// Else `model` (or the leaf) with `texture` in every slot of a model, or
    /// the item generated from `texture`. Each `texture.<name>` goes to the
    /// slot `name` and to every slot whose sprite's file is `name`
    /// (`potion_overlay`); the generic `texture` takes the layers none of
    /// them claims. A model that did not load, or whose parents do not,
    /// leaves the leaf as it is.
pub fn cit_plan(self: *Self, cit: *CitModels, rule: usize, leaf: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let plan = cit.plans.get(rule)?.as_ref()?;
    // rust: let sub = short(leaf);
    // rust: if let Some(model) = plan.models.get(sub) {
    // rust: return self.library.resolves(model).then(|| CitBake {
    // rust: base: model.clone(),
    // rust: slots: BTreeMap::new(),
    // rust: untinted: None,
    // rust: });
}
    // rust: let resolved = |name: &str| self.library.resolve(name).ok();
    // rust: let matches = |name: &str, slot: &str, material: &Material| {
    // rust: slot == name || short(&material.sprite) == name
}
    // rust: let layer = |slot: &str| {
    // rust: slot.strip_prefix("layer")
    // rust: .and_then(|n| n.parse::<u32>().ok())
}
    // rust: let leaf_model = resolved(leaf);
    // rust: let leaf_textures = leaf_model
    // rust: .as_ref()
    // rust: .map(|m| m.textures.clone())
    // rust: .unwrap_or_default();
        // `texture.<leaf>` swaps the leaf (`texture.bow_pulling_1`). On a leaf
        // of several layers, one of which answers to the name (`potion`'s
        // bottle), it is that layer's swap instead, done below, and leaves
        // `model` and `texture` to the rule.
    // rust: let layers = leaf_textures.keys().filter(|s| layer(s).is_some()).count();
    // rust: let named = plan
    // rust: .textures
    // rust: .iter()
    // rust: .find(|(n, _)| n == sub)
    // rust: .map(|(_, s)| s)
    // rust: .filter(|_| {
    // rust: layers < 2
    // rust: || !leaf_textures
    // rust: .iter()
    // rust: .any(|(slot, m)| matches(sub, slot.as_str(), m))
    // rust: });
    // rust: let base = match (named, &plan.model) {
    // rust: (None, Some(model)) => model.clone(),
    // rust: _ => leaf.to_owned(),
}
    // rust: if base != leaf && !self.library.resolves(&base) {
    // rust: return None;
}
    // rust: let base_model = if base == leaf {
    // rust: leaf_model
    // rust: } else {
    // rust: resolved(&base)
}
    // rust: let generated = base_model.as_ref().is_some_and(|m| m.uses_item_generator());
    // rust: let textures = base_model.map(|m| m.textures).unwrap_or_default();
        // The slots each `texture.<name>` claims, by name or by sprite file.
    // rust: let mut claimed = BTreeMap::new();
    // rust: for (name, sprite) in &plan.textures {
    // rust: for (slot, material) in &textures {
    // rust: if matches(name.as_str(), slot.as_str(), material) {
    // rust: claimed.insert(slot.clone(), sprite.clone());
}
}
}
    // rust: let mut slots = BTreeMap::new();
    // rust: let mut untinted = None;
    // rust: match named.or(plan.texture.as_ref()) {
            // A model's elements (a block item, a 3D model) draw the sprite
            // on every face, as does the rule's `model` with `texture`.
    // rust: Some(sprite) if (named.is_none() && plan.model.is_some()) || !generated => {
    // rust: for slot in textures.keys() {
    // rust: slots.insert(slot.clone(), Some(sprite.clone()));
}
}
            // The item generated from the sprite, drawn once and untinted: a
            // pack's art holds its own colours (OptiFine's doc: a potion's
            // replacement includes "the colored liquid"), and the tinted layer
            // is the bottom one on potions but the top one on maps, firework
            // stars and dyed wolf armour. It is `layer0`, or the lowest layer no
            // `texture.<name>` claims (`texture.potion_overlay` with `texture`:
            // the bottle), and fills the unclaimed layers up to the highest
            // claimed one, so they stay contiguous; the leaf's layers above are
            // cleared (`bake_resolved` stops at the first layer without one).
    // rust: Some(sprite) => {
    // rust: untinted = Some(sprite.clone());
    // rust: let first_free = (0..)
    // rust: .find(|n| !claimed.contains_key(&format!("layer{n}")))
    // rust: .unwrap_or(0);
    // rust: let top = claimed
    // rust: .keys()
    // rust: .filter_map(|s| layer(s))
    // rust: .max()
    // rust: .unwrap_or(0)
    // rust: .max(first_free);
    // rust: slots.insert("layer0".to_owned(), Some(sprite.clone()));
    // rust: for slot in textures.keys() {
    // rust: match layer(slot) {
    // rust: Some(n) if n <= top => {
    // rust: slots.insert(slot.clone(), Some(sprite.clone()));
}
    // rust: Some(_) => {
    // rust: slots.insert(slot.clone(), None);
}
    // rust: None => {}
}
}
}
    // rust: None => {}
}
    // rust: slots.extend(
    // rust: claimed
    // rust: .into_iter()
    // rust: .map(|(slot, sprite)| (slot, Some(sprite))),
    // rust: );
    // rust: (base != leaf || !slots.is_empty()).then_some(CitBake {
    // rust: base,
    // rust: slots,
    // rust: untinted,
    // rust: })
}

pub fn cit_bake(self: *Self, bake: *CitBake) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let child = bake
    // rust: .slots
    // rust: .iter()
    // rust: .map(|(slot, sprite)| {
    // rust: let texture = match sprite {
    // rust: Some(sprite) => TextureSlot::Material(Material {
    // rust: sprite: sprite.clone(),
    // rust: force_translucent: false,
    // rust: }),
                    // A slot referring to itself resolves to nothing
                    // (`ModelLibrary::resolve_with_textures` stops at the loop).
    // rust: None => TextureSlot::Reference(slot.clone()),
}
    // rust: (slot.clone(), texture)
    // rust: })
    // rust: .collect();
    // rust: let baked = self
    // rust: .library
    // rust: .resolve_with_textures(&bake.base, &child)
    // rust: .and_then(|model| bake_resolved(&model, &self.sprites))
    // rust: .map(|mut baked| {
    // rust: if let Some(sprite) = &bake.untinted {
    // rust: for quad in baked
    // rust: .quads
    // rust: .iter_mut()
    // rust: .filter(|q| &q.material.sprite == sprite)
    // rust: {
    // rust: quad.tint_index = -1;
}
}
    // rust: Arc::new(baked)
    // rust: })
    // rust: .unwrap_or_else(|_| self.bake(MISSING_MODEL));
    // rust: let extents = Arc::new(corners(&baked));
    // rust: (baked, extents)
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_assets::item_model::{DisplayContext, NoEnv, StackView};
//     use std::{collections::BTreeSet, fs, path::PathBuf};

pub const CIT: []const u8 = "assets/minecraft/optifine/cit";

pub fn png(path: *Path) void {
}
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let file = std::io::BufWriter::new(fs::File::create(path).unwrap());
    // rust: let mut encoder = png::Encoder::new(file, 2, 2);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&[255; 16]).unwrap();
    // rust: writer.finish().unwrap();
}

    /// A stick, a bow's frames and a potion; with `cit`, rules over them.
pub fn root(name: []const u8, cit: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-cit-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let write = |rel: &str, text: &str| {
    // rust: let path = root.join(rel);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: write(
    // rust: "items.json",
    // rust: r#"{"minecraft:stick":{"minecraft:item_model":"minecraft:stick"}}"#,
    // rust: );
    // rust: write(
    // rust: "assets/minecraft/items/stick.json",
    // rust: r#"{"model":{"type":"minecraft:model","model":"minecraft:item/stick"}}"#,
    // rust: );
    // rust: let models = "assets/minecraft/models/item";
    // rust: write(
    // rust: &format!("{models}/generated.json"),
    // rust: r#"{"parent":"builtin/generated"}"#,
    // rust: );
    // rust: let flat = |name: &str, layers: &[&str]| {
    // rust: let textures: Vec<String> = layers
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, l)| format!(r#""layer{i}":"item/{l}""#))
    // rust: .collect();
    // rust: write(
    // rust: &format!("{models}/{name}.json"),
    // rust: &format!(
    // rust: r#"{{"parent":"item/generated","textures":{{{}}}}}"#,
    // rust: textures.join(",")
    // rust: ),
    // rust: );
    // rust: for l in layers {
    // rust: png(&root.join(format!("assets/minecraft/textures/item/{l}.png")));
}
}
    // rust: flat("stick", &["stick"]);
    // rust: flat("bow", &["bow"]);
    // rust: flat("bow_pulling_0", &["bow_pulling_0"]);
    // rust: flat("bow_pulling_1", &["bow_pulling_1"]);
    // rust: flat("potion", &["potion_overlay", "potion"]);
        // A block item: one cube whose faces all draw `#all`.
    // rust: let faces: Vec<String> = ["down", "up", "north", "south", "west", "east"]
    // rust: .iter()
    // rust: .map(|f| format!(r##""{f}":{{"texture":"#all"}}"##))
    // rust: .collect();
    // rust: write(
    // rust: "assets/minecraft/models/block/cube_fixture.json",
    // rust: &format!(
    // rust: r##"{{"textures":{{"particle":"#all","all":"block/cube_fixture"}},"elements":[{{"from":[0,0,0],"to":[16,16,16],"faces":{{{}}}}}]}}"##,
    // rust: faces.join(",")
    // rust: ),
    // rust: );
    // rust: png(&root.join("assets/minecraft/textures/block/cube_fixture.png"));
    // rust: if cit {
    // rust: for t in ["a", "b", "blade", "hilt"] {
    // rust: png(&root.join(format!("{CIT}/{t}.png")));
}
    // rust: write(
    // rust: &format!("{CIT}/sword.json"),
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"./blade","layer1":"./hilt"}}"#,
    // rust: );
    // rust: write(
    // rust: &format!("{CIT}/other.json"),
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"./hilt"}}"#,
    // rust: );
    // rust: write(&format!("{CIT}/bad.json"), "{not json");
    // rust: let rules = [
    // rust: ("plain", "items=bow\ntexture.bow_pulling_1=a"),
    // rust: (
    // rust: "mix",
    // rust: "items=bow\nmodel=sword\ntexture=a\ntexture.bow_pulling_1=b\nmodel.bow_pulling_0=other",
    // rust: ),
    // rust: (
    // rust: "potion",
    // rust: "items=potion\ntexture.potion_overlay=a\ntexture.layer1=b",
    // rust: ),
    // rust: ("stick", "items=stick\nmodel=sword"),
    // rust: ("bottle", "items=potion\ntexture.potion=a"),
    // rust: (
    // rust: "drinkable",
    // rust: "items=potion\ntexture.potion_bottle_drinkable=b",
    // rust: ),
    // rust: ("whole", "items=potion\ntexture=a"),
    // rust: ("standby", "items=bow\ntexture.bow_standby=b"),
    // rust: ("broken", "items=bow\nmodel=bad\nmodel.bow_pulling_0=sword"),
    // rust: ("bad_sub", "items=bow\ntexture=a\nmodel.bow_pulling_1=bad"),
    // rust: (
    // rust: "overlay_and_generic",
    // rust: "items=potion\ntexture=a\ntexture.potion_overlay=b",
    // rust: ),
    // rust: ("block", "items=stone\ntexture=a"),
    // rust: (
    // rust: "overlay_and_bottle",
    // rust: "items=potion\ntexture=a\ntexture.potion=b",
    // rust: ),
    // rust: (
    // rust: "bottle_on_model",
    // rust: "items=potion\nmodel=sword\ntexture.potion=b",
    // rust: ),
    // rust: (
    // rust: "old_first",
    // rust: "items=bow\ntexture.bow_standby=b\ntexture.bow=a",
    // rust: ),
    // rust: (
    // rust: "new_first",
    // rust: "items=bow\ntexture.bow=a\ntexture.bow_standby=b",
    // rust: ),
    // rust: (
    // rust: "old_model_first",
    // rust: "items=bow\nmodel.bow_standby=other\nmodel.bow=sword",
    // rust: ),
    // rust: (
    // rust: "new_model_first",
    // rust: "items=bow\nmodel.bow=sword\nmodel.bow_standby=other",
    // rust: ),
    // rust: ];
    // rust: for (name, text) in rules {
    // rust: write(&format!("{CIT}/{name}.properties"), text);
}
}
    // rust: root
}

pub fn renderer(root: *Path) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let library = crate::model_library::ParsedModels::load(root).into_item_library();
    // rust: ItemRenderer::load_with_library(root, library).unwrap()
}

pub fn rule(r: *ItemRenderer, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = format!("{CIT}/{name}.properties");
    // rust: let rules = &r.cit.as_ref().unwrap().rules.rules;
    // rust: rules.iter().position(|r| r.path == path).unwrap()
}

pub fn sprites(baked: *BakedItemModel) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: baked
    // rust: .quads
    // rust: .iter()
    // rust: .map(|q| q.material.sprite.clone())
    // rust: .collect()
}

    /// Each quad's layer (its tint index) with the sprite it draws.
pub fn layers(baked: *BakedItemModel) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: baked
    // rust: .quads
    // rust: .iter()
    // rust: .map(|q| (q.tint_index, q.material.sprite.clone()))
    // rust: .collect()
}

pub fn cit(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("horizon_cit:minecraft/optifine/cit/{name}")
}

pub fn rules_pick_a_model_or_textures_per_leaf() void {
}
    // rust: let root = root("plans", true);
    // rust: let r = renderer(&root);
    // rust: let layer = |rule: &str, leaf: &str| {
    // rust: r.cit_layer(self::rule(&r, rule), &format!("minecraft:item/{leaf}"))
    // rust: .map(|(baked, _)| sprites(&baked).into_iter().collect::<Vec<_>>())
}
        // `texture.<leaf>` swaps that leaf only.
    // rust: assert_eq!(layer("plain", "bow_pulling_1"), Some(vec![cit("a")]));
    // rust: assert_eq!(layer("plain", "bow_pulling_0"), None);
    // rust: assert_eq!(layer("plain", "bow"), None);
        // `model.<leaf>` first, then `texture.<leaf>` (a one-layer frame: the whole leaf), then
        // `model` with `texture` in every slot.
    // rust: assert_eq!(layer("mix", "bow_pulling_0"), Some(vec![cit("hilt")]));
    // rust: assert_eq!(layer("mix", "bow_pulling_1"), Some(vec![cit("b")]));
    // rust: assert_eq!(layer("mix", "bow"), Some(vec![cit("a")]));
        // A model alone keeps its own (relative) textures.
    // rust: assert_eq!(
    // rust: layer("stick", "stick"),
    // rust: Some(vec![cit("blade"), cit("hilt")])
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn potion_textures_go_to_the_layer_they_name() void {
}
    // rust: let root = root("potion", true);
    // rust: let r = renderer(&root);
    // rust: let layer = |rule: &str| {
    // rust: let (baked, _) = r.cit_layer(self::rule(&r, rule), "minecraft:item/potion")?;
    // rust: Some(layers(&baked))
}
    // rust: let vanilla = |i: i32, name: &str| (i, format!("minecraft:item/{name}"));
        // By sprite file name (the overlay) and by slot name (the bottle).
    // rust: assert_eq!(
    // rust: layer("potion"),
    // rust: Some(BTreeSet::from([(0, cit("a")), (1, cit("b"))]))
    // rust: );
        // `texture.potion` names the bottle's file, not the leaf's `layer0`.
    // rust: assert_eq!(
    // rust: layer("bottle"),
    // rust: Some(BTreeSet::from([
    // rust: vanilla(0, "potion_overlay"),
    // rust: (1, cit("a"))
    // rust: ]))
    // rust: );
        // OptiFine's name for the same bottle.
    // rust: assert_eq!(
    // rust: layer("drinkable"),
    // rust: Some(BTreeSet::from([
    // rust: vanilla(0, "potion_overlay"),
    // rust: (1, cit("b"))
    // rust: ]))
    // rust: );
        // A plain `texture` is drawn once, untinted: the pack's whole picture, no vanilla
        // bottle over it and no potion colour on it.
    // rust: assert_eq!(layer("whole"), Some(BTreeSet::from([(-1, cit("a"))])));
        // ... unless a `texture.<name>` fills the bottle, even one named like the leaf.
    // rust: assert_eq!(
    // rust: layer("overlay_and_bottle"),
    // rust: Some(BTreeSet::from([(-1, cit("a")), (1, cit("b"))]))
    // rust: );
        // A slot named like the leaf leaves the rule's `model` the base.
    // rust: let (baked, _) = r
    // rust: .cit_layer(rule(&r, "bottle_on_model"), "minecraft:item/potion")
    // rust: .unwrap();
    // rust: assert_eq!(sprites(&baked), BTreeSet::from([cit("blade"), cit("hilt")]));
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn the_generic_texture_takes_the_layers_no_named_texture_claims() void {
}
    // rust: let root = root("generic", true);
    // rust: let r = renderer(&root);
    // rust: let (baked, _) = r
    // rust: .cit_layer(rule(&r, "overlay_and_generic"), "minecraft:item/potion")
    // rust: .unwrap();
        // `texture.potion_overlay` claims `layer0`; `texture` is the bottle.
    // rust: assert_eq!(
    // rust: layers(&baked),
    // rust: BTreeSet::from([(0, cit("b")), (-1, cit("a"))])
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn a_plain_texture_covers_every_face_of_a_block_item() void {
}
    // rust: let root = root("block", true);
    // rust: let r = renderer(&root);
    // rust: let (baked, _) = r
    // rust: .cit_layer(rule(&r, "block"), "minecraft:block/cube_fixture")
    // rust: .unwrap();
    // rust: assert_eq!(baked.quads.len(), 6);
    // rust: assert_eq!(sprites(&baked), BTreeSet::from([cit("a")]));
    // rust: assert_eq!(baked.particle.sprite, cit("a"));
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn the_26x_name_beats_optifines_old_one_in_any_order() void {
}
    // rust: let root = root("aliases", true);
    // rust: let r = renderer(&root);
    // rust: let bow = |rule: &str| {
    // rust: let (baked, _) = r
    // rust: .cit_layer(self::rule(&r, rule), "minecraft:item/bow")
    // rust: .unwrap();
    // rust: sprites(&baked)
}
    // rust: for name in ["old_first", "new_first"] {
    // rust: assert_eq!(bow(name), BTreeSet::from([cit("a")]), "{name}");
}
    // rust: for name in ["old_model_first", "new_model_first"] {
    // rust: assert_eq!(
    // rust: bow(name),
    // rust: BTreeSet::from([cit("blade"), cit("hilt")]),
    // rust: "{name}"
    // rust: );
}
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn bow_standby_is_the_resting_bow() void {
}
    // rust: let root = root("standby", true);
    // rust: let r = renderer(&root);
    // rust: let standby = rule(&r, "standby");
    // rust: let (baked, _) = r.cit_layer(standby, "minecraft:item/bow").unwrap();
    // rust: assert_eq!(layers(&baked), BTreeSet::from([(-1, cit("b"))]));
    // rust: assert!(
    // rust: r.cit_layer(standby, "minecraft:item/bow_pulling_0")
    // rust: .is_none()
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn a_model_that_did_not_load_leaves_the_leaf_vanilla() void {
}
    // rust: let root = root("broken", true);
    // rust: let r = renderer(&root);
    // rust: let broken = rule(&r, "broken");
    // rust: assert!(r.cit_layer(broken, "minecraft:item/bow").is_none());
        // The rule's other model still loads and draws.
    // rust: let (baked, _) = r.cit_layer(broken, "minecraft:item/bow_pulling_0").unwrap();
    // rust: assert_eq!(sprites(&baked), BTreeSet::from([cit("blade"), cit("hilt")]));
        // A broken `model.<leaf>` leaves that leaf vanilla, not drawn from the rule's `texture`.
    // rust: let bad_sub = rule(&r, "bad_sub");
    // rust: assert!(
    // rust: r.cit_layer(bad_sub, "minecraft:item/bow_pulling_1")
    // rust: .is_none()
    // rust: );
    // rust: let (baked, _) = r.cit_layer(bad_sub, "minecraft:item/bow").unwrap();
    // rust: assert_eq!(sprites(&baked), BTreeSet::from([cit("a")]));
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn max_damage_is_the_stacks_component_else_the_items() void {
}
    // rust: let with = |tag: Option<Tag>| {
    // rust: let mut stack = ItemStack::new("minecraft:bow", 1);
    // rust: if let Some(tag) = tag {
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:max_damage", Some(tag));
}
    // rust: stack_max_damage(&stack, 384)
}
    // rust: assert_eq!(with(Some(Tag::Int(20))), 20);
    // rust: assert_eq!(with(Some(Tag::Int(0))), 0);
    // rust: assert_eq!(with(None), 384);
    // rust: assert_eq!(with(Some(Tag::Int(-1))), 384);
    // rust: assert_eq!(with(Some(Tag::String("20".into()))), 384);
}

pub fn armor_rules(text: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let props = horizon_optifine::Properties::parse_equals_first(text);
    // rust: let path = "assets/minecraft/optifine/cit/worn.properties";
    // rust: CitRules::new(vec![
    // rust: crate::cit::Rule::parse(path, &props, |_| true).unwrap(),
    // rust: ])
}

pub fn worn_armor_counts_as_the_main_hand() void {
}
    // rust: let rules = armor_rules("type=armor\nitems=diamond_chestplate\ntexture=x\nhand=main\n");
    // rust: let stack = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: assert_eq!(worn_rule(&rules, Kind::Armor, &stack, 528), Some(0));
    // rust: let off = armor_rules("type=armor\nitems=diamond_chestplate\ntexture=x\nhand=off\n");
    // rust: assert_eq!(worn_rule(&off, Kind::Armor, &stack, 528), None);
}

pub fn worn_damage_reads_the_stacks_max_damage() void {
}
    // rust: let rules = armor_rules("type=armor\nitems=diamond_chestplate\ntexture=x\ndamage=50%\n");
    // rust: let mut stack = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: stack.damage = 5;
        // 5 of the item's 528 is under 1%.
    // rust: assert_eq!(worn_rule(&rules, Kind::Armor, &stack, 528), None);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:max_damage", Some(Tag::Int(10)));
    // rust: assert_eq!(worn_rule(&rules, Kind::Armor, &stack, 528), Some(0));
}

pub fn a_bake_is_shared_by_its_rule_and_leaf_only() void {
}
    // rust: let root = root("cache", true);
    // rust: let r = renderer(&root);
    // rust: let leaf = "minecraft:item/bow_pulling_1";
    // rust: let (plain, mix) = (rule(&r, "plain"), rule(&r, "mix"));
    // rust: let first = r.cit_layer(plain, leaf).unwrap();
    // rust: let again = r.cit_layer(plain, leaf).unwrap();
    // rust: assert!(Arc::ptr_eq(&first.0, &again.0));
    // rust: assert!(Arc::ptr_eq(&first.1, &again.1));
    // rust: assert!(!Arc::ptr_eq(&first.0, &r.cit_layer(mix, leaf).unwrap().0));
    // rust: assert!(!Arc::ptr_eq(&first.0, &r.bake(leaf)));
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn a_matched_stack_resolves_to_the_rule_model() void {
}
    // rust: let root = root("resolve", true);
    // rust: let r = renderer(&root);
    // rust: let view = StackView::new("minecraft:stick", 1);
    // rust: let resolve = |rule| {
    // rust: let state =
    // rust: r.resolve_with_rule(&view, DisplayContext::Gui, None, None, 0, &NoEnv, rule);
    // rust: match &state.layers[0].geometry {
    // rust: super::super::LayerGeometry::Quads(baked) => sprites(baked),
    // rust: other => panic!("{other:?}"),
}
}
    // rust: let stick = rule(&r, "stick");
    // rust: assert_eq!(
    // rust: resolve(Some(stick)),
    // rust: BTreeSet::from([cit("blade"), cit("hilt")])
    // rust: );
    // rust: assert_eq!(
    // rust: resolve(None),
    // rust: BTreeSet::from(["minecraft:item/stick".to_owned()])
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn without_rules_nothing_changes() void {
}
    // rust: let root = root("none", false);
    // rust: let r = renderer(&root);
    // rust: assert!(r.cit.is_none());
    // rust: let view = StackView::new("minecraft:stick", 1);
    // rust: let state = |rule| {
    // rust: let s = r.resolve_with_rule(&view, DisplayContext::Gui, None, None, 0, &NoEnv, rule);
    // rust: format!("{s:?}")
}
    // rust: let plain = format!(
    // rust: "{:?}",
    // rust: r.resolve(&view, DisplayContext::Gui, None, None, 0, &NoEnv)
    // rust: );
    // rust: assert_eq!(state(Some(0)), plain);
    // rust: assert_eq!(state(None), plain);
    // rust: assert!(plain.contains("minecraft:item/stick"));
    // rust: let _ = fs::remove_dir_all(&root);
}
}
