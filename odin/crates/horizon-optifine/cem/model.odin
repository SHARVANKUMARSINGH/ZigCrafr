//! Transpiled from Horizon Rust crate
package horizon_optifine_model

import "core:fmt"
import "core:mem"
import "core:math"

// `.jem` entity models and the `.jpm` part models they load, baked into the geometry vanilla's
// `ModelPart` draws: quads in model pixels on vanilla's axes (y down), UVs a fraction of the
// texture.
//
// The files place parts the way Blockbench's OptiFine export writes them, and the way EMF (and
// OptiFine) build them: `invertAxis` names the axes that point the other way from vanilla's
// (`"xy"` in practice), and **every** bone — a part or a submodel — sits at its own
// `translate` (negated on the inverted axes), its boxes at the coordinates the file gives
// (mirrored on them), its submodels below it at their own translates. A part keeps the pivot
// of the vanilla part it replaces (OptiDocs, "Limitations: pivot points"): its bone rides as
// a child of the vanilla part, `translate` away from its pivot, and an export that writes the
// part's boxes where the model has them (the ground at y 0) has `translate` at minus the
// part's pivot, so they land back around it.
//
// The bones' poses are what the pack's animations write: `sub.ty` replaces the pose the bone
// starts at, which is its `translate` alone — never `translate` plus whatever its parent
// carries. Folding a parent's translate into a child's pivot places the geometry the same at
// rest, but every animation write then moves it by the folded amount: Fresh Animations parks
// a cow's `head2` at `ty = -20` under a `body` part whose translate is 14, and the head would
// fly 14 pixels off the body the moment the pack's first frame runs. EMF's
// `EMFModelPartCustom` (the part's x, y, z are its `translate`) with `EMFPartData.prepare`
// (the translate negated per inverted axis, the rotate negated about its own inverted axis
// only, `scale` per bone, `attachments` offsets flipped) is the reference.

// use super::json::{Json, get};
// use crate::paths;
// use std::{collections::HashMap, rc::Rc};

// One face of a box, as `horizon_client::mobs::Polygon` holds it: `[x, y, z, u, v]` vertices
// in model pixels, UV a fraction of the texture, and the outward normal.
Quad :: struct {
    normal: [f32,
    vertices: [[f32,
}

// A baked part model or submodel: a `ModelPart` with its boxes.
Bone :: struct {
    id: Maybe(string),
    // `ModelPart` x, y, z: the pivot in the parent's frame, vanilla pixels. A part's bone
    // hangs at its `translate` below the vanilla part's own pivot; a submodel's at its own
    // `translate` below its parent bone.
    pivot: [f32,
    // `ModelPart` xRot, yRot, zRot in radians, on vanilla's axes.
    rotation: [f32,
    // `ModelPart` xScale, yScale, zScale: `scale`, a number for all three axes or an array of
    // three (EMF's own field is a number; an array is wider than it, not narrower).
    scale: [f32,
    // The `attachments` this declaring bone carries: an item anchor's name and its offset,
    // flipped on this bone's inverted axes (EMF's `EMFPartData.getAttachments`).
    attachments: Vec<(string,
    quads: [dynamic]Quad,
    children: [dynamic]Bone,
}

// One entry of a `.jem`'s `models`.
PartModel :: struct {
    // The OptiFine part name it attaches to (`head`, `leg1`...).
    part: string,
    // True: drawn beside the vanilla part's own boxes; false: in place of them.
    attach: bool,
    // `scale`: the render scale of the part.
    scale: f32,
    // `animations`: target and expression, in file order (later ones see earlier results).
    animations: Vec<(string,
    bone: Bone,
}

// A parsed `.jem`.
EntityModel :: struct {
    // The texture every part draws with; None: the vanilla texture.
    texture: Maybe(string),
    parts: [dynamic]PartModel,
    // What was left out and why: entries whose `.jpm` is missing or broken, a `baseId` naming
    // no model, what is past the limits, per-part textures and sprites (not drawn yet).
    warnings: [dynamic]string,
}

// OptiFine's texture size when a model gives none.
DEFAULT_TEXTURE_SIZE :: [64.0, 32.0]
// What one `.jem` may make the game build, so a pack can't make loading run out of memory or
// time: its entries, the work of baking them (see [`Bake`]), and the bytes of the `.jem` and
// every `.jpm` it loads, together.
MAX_ENTRIES :: 1024
MAX_NODES :: 1 << 16
// The bytes a `.jem` and its `.jpm` files may hold together: [`parse_jem`]'s `read` should
// refuse a larger file without reading it.
MAX_BYTES :: 4 << 20

// Keys looked up in a part definition.
    // rust: trait Def {
key :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
}
    // rust: impl Def for [(String, Json)] {
key :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: get(self, key)
}
}
// An object's pairs and, for each key, the position of its last pair.
Layer :: struct {
    pairs: Vec<(string,
    index: HashMap<string,
}
    // rust: impl Layer {
new :: proc(pairs: Vec<(string) {
}
    // rust: let index = pairs.iter().enumerate().map(|(i, (k, _))| (k.clone(), i));
    // rust: Rc::new(Layer {
    // rust: index: index.collect(),
    // rust: pairs,
    // rust: })
}
}
// An entry's keys: its own, then its `.jpm`'s, then its `baseId` entry's, each layer over the
// next. Layers are shared, so inheriting a big model copies nothing.
Layers :: struct {
    // rust: impl Def for Layers {
key :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .iter()
    // rust: .find_map(|layer| Some(&layer.pairs[*layer.index.get(key)?].1))
}
}

// What a file may still build: `left` units of work. Entries can share a `.jpm` or a base, so
// what is charged is what each one walks and copies, not what the files hold: a bone costs
// one, a submodel also its keys (each lookup walks them), a part also its layers (each lookup
// tries them); a box its faces or its keys, whichever is more (at least one); any other item
// of `boxes` or `submodels` one; an item of `animations` its pairs (at least one), and a pair
// kept one more for a number or boolean. On top of that every string read or copied out of the
// files (part names, ids, animation targets and expressions, axes, numbers written as text)
// costs one per started 64 bytes, each time. `cut`: something was left out for want of them;
// `unread`: a part or submodel has a texture or sprites of its own.
Bake :: struct {
    left: uint,
    cut: bool,
    unread: bool,
}
    // rust: impl Bake {
    // Takes `cost`; when less is left, takes the rest, notes the cut and says false.
spend :: proc(self: ^Self, cost: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(left) = self.left.checked_sub(cost) else {
    // rust: (self.left, self.cut) = (0, true);
    // rust: return false;
}
    // rust: self.left = left;
    // rust: true
}
}

// What reading or copying a string of the files costs.
text_cost :: proc(s: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: s.len().div_ceil(64)
}

// A string value, paid for; None also when it doesn't fit what is left.
    // rust: fn string<'a>(v: Option<&'a Json>, bake: &mut Bake) -> Option<&'a str> {
    // rust: v?.as_str().filter(|s| bake.spend(text_cost(s)))
}

// Parses the `.jem` at resource path `path` (`assets/minecraft/optifine/cem/zombie.jem`).
// `read` returns the text of a resource path (the `.jpm` files `model` names), None when missing;
// it should return None for a file larger than [`MAX_BYTES`] rather than read it, as the `.jem`
// and the `.jpm` files it loads may not pass that together. An error means the file as a whole
// can't be read; a broken entry only adds a warning.
    // rust: pub fn parse_jem(
    // rust: path: &str,
    // rust: text: &str,
    // rust: read: &mut dyn FnMut(&str) -> Option<String>,
    // rust: ) -> Result<EntityModel, String> {
    // rust: if text.len() > MAX_BYTES {
    // rust: return Err(format!("{path}: larger than {MAX_BYTES} bytes"));
}
    // rust: let root = Json::parse(text).map_err(|e| format!("{path}: {e}"))?;
    // rust: let mut bake = Bake {
    // rust: left: MAX_NODES,
    // rust: cut: false,
    // rust: unread: false,
}
    // rust: let size = size2(root.get("textureSize"), &mut bake).unwrap_or(DEFAULT_TEXTURE_SIZE);
    // rust: let texture = root
    // rust: .get("texture")
    // rust: .and_then(Json::as_str)
    // rust: .and_then(|t| texture(path, t));
    // rust: let mut out = EntityModel {
    // rust: texture,
    // rust: ..EntityModel::default()
}
    // rust: let mut jpms: HashMap<String, Result<Rc<Layer>, String>> = HashMap::new();
    // rust: let mut bytes = text.len();
    // The first entry with an id is the one `baseId` finds.
    // rust: let mut by_id: HashMap<String, Layers> = HashMap::new();
    // rust: for (n, entry) in objects(root.get("models")).enumerate() {
    // rust: if n == MAX_ENTRIES {
    // rust: out.warnings
    // rust: .push(format!("{path}: more than {MAX_ENTRIES} models"));
    // rust: break;
}
    // rust: let mut layers = Layers(vec![Layer::new(entry.to_vec())]);
        // `model`: the part model in a `.jpm`, under this entry's own keys.
    // rust: if let Some(model) = get(entry, "model") {
    // rust: let jpm = model
    // rust: .as_str()
    // rust: .ok_or_else(|| format!("{path}: a model that isn't a file name"))
    // rust: .and_then(|m| jpm(path, m, read, &mut jpms, &mut bytes));
    // rust: match jpm {
    // rust: Ok(jpm) => layers.0.push(jpm),
    // rust: Err(e) => {
    // rust: out.warnings.push(e);
    // rust: continue;
}
}
}
        // `baseId`: the named entry's properties, under this one's and its `.jpm`'s.
    // rust: if let Some(base) = get(entry, "baseId").and_then(Json::as_str) {
    // rust: match by_id.get(base) {
                // A base sharing this entry's `.jpm` adds it once: of this entry's layers only
                // that one can be among the base's.
    // rust: Some(parent) => {
    // rust: let own = layers.0.get(1).cloned();
    // rust: let shared = |l: &&Rc<Layer>| own.as_ref().is_some_and(|o| Rc::ptr_eq(o, l));
    // rust: layers
    // rust: .0
    // rust: .extend(parent.0.iter().filter(|l| !shared(l)).cloned());
}
    // rust: None => out
    // rust: .warnings
    // rust: .push(format!("{path}: no model {base} for baseId")),
}
}
        // An id is hashed, maybe from a file other entries share: it is paid for each time.
    // rust: if let Some(id) = string(layers.key("id"), &mut bake)
    // rust: && !by_id.contains_key(id)
    // rust: {
    // rust: by_id.insert(id.to_owned(), layers.clone());
}
    // rust: let Some(part) = layers.key("part").and_then(Json::as_str) else {
    // rust: continue;
}
        // Past the limits a part is left out, not emptied or frozen: the vanilla part stays. Its
        // name, the layers each key is looked up through, its animations, all of them, and its
        // bone must fit before it is baked.
    // rust: let earlier = std::mem::replace(&mut bake.cut, false);
    // rust: let attach = boolean(layers.key("attach"), &mut bake).unwrap_or(false);
    // rust: let scale = num(layers.key("scale"), &mut bake).unwrap_or(1.0);
    // rust: if !bake.spend(text_cost(part) + layers.0.len()) {
    // rust: continue;
}
    // rust: let Some((animations, cost)) = animations(layers.key("animations"), bake.left) else {
    // rust: bake.cut = true;
    // rust: continue;
}
    // rust: bake.left -= cost;
    // rust: let bone = bone(&layers, size, &mut bake);
    // rust: let emptied = bake.cut && !has_quads(&bone);
    // rust: bake.cut |= earlier;
    // rust: if emptied {
    // rust: continue;
}
    // rust: out.parts.push(PartModel {
    // rust: part: part.to_owned(),
    // rust: attach,
    // rust: scale,
    // rust: animations,
    // rust: bone,
    // rust: });
}
    // rust: if bake.cut {
    // rust: out.warnings.push(format!(
    // rust: "{path}: more than {MAX_NODES} bones, boxes, faces and animations, the rest left out"
    // rust: ));
}
    // rust: if bake.unread {
    // rust: out.warnings.push(format!(
    // rust: "{path}: per-part textures and sprites aren't drawn yet"
    // rust: ));
}
    // rust: Ok(out)
}

// The `.jpm` that `model` (in the `.jem` at `path`) names, read and parsed once per file.
// `bytes`: what the model's files read so far hold, refused ones included.
    // rust: fn jpm(
    // rust: path: &str,
    // rust: model: &str,
    // rust: read: &mut dyn FnMut(&str) -> Option<String>,
    // rust: cache: &mut HashMap<String, Result<Rc<Layer>, String>>,
    // rust: bytes: &mut usize,
    // rust: ) -> Result<Rc<Layer>, String> {
    // rust: let Some(file) = paths::resolve(path, model) else {
    // rust: return Err(format!("{path}: {model} is outside the pack"));
}
    // rust: cache
    // rust: .entry(file.clone())
    // rust: .or_insert_with(|| {
    // rust: let text = read(&file).ok_or_else(|| format!("{path}: missing {file}"))?;
    // rust: *bytes = bytes.saturating_add(text.len());
    // rust: if *bytes > MAX_BYTES {
    // rust: return Err(format!(
    // rust: "{file}: the model's files are larger than {MAX_BYTES} bytes together"
    // rust: ));
}
    // rust: match Json::parse(&text).map_err(|e| format!("{file}: {e}"))? {
    // rust: Json::Obj(pairs) => Ok(Layer::new(pairs)),
    // rust: _ => Err(format!("{file}: not an object")),
}
    // rust: })
    // rust: .clone()
}

// An entry's animations and what they cost, None when they don't fit in `left` with one to
// spare for the bone. Every pair costs one, skipped or not, and every other item one; a pair
// kept also its target and expression, paid before they are copied.
animations :: proc(v: Maybe(^Json), left: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut cost = 0;
    // rust: for item in items(v) {
    // rust: let pairs = item.as_object().unwrap_or_default();
    // rust: cost += pairs.len().max(1);
    // rust: if cost >= left {
    // rust: return None;
}
    // rust: for (k, v) in pairs {
    // rust: cost += text_cost(k)
    // rust: + match v {
    // rust: Json::Str(s) => text_cost(s),
    // rust: Json::Num(_) | Json::Bool(_) => 1,
    // rust: _ => continue,
}
    // rust: if cost >= left {
    // rust: return None;
}
    // rust: let expr = match v {
    // rust: Json::Str(s) => s.clone(),
    // rust: Json::Num(n) => n.to_string(),
    // rust: Json::Bool(b) => b.to_string(),
    // rust: _ => continue,
}
    // rust: out.push((k.clone(), expr));
}
}
    // rust: (cost < left).then_some((out, cost))
}

has_quads :: proc(bone: ^Bone) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !bone.quads.is_empty() || bone.children.iter().any(has_quads)
}

// The items of an array value.
items :: proc(v: Maybe(^Json)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v.and_then(Json::as_array).into_iter().flatten()
}

// The objects of an array value.
objects :: proc(v: Maybe(^Json)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: items(v).filter_map(Json::as_object)
}

// A texture value as a resource path with its `.png`; None for one outside the pack.
texture :: proc(path: string, value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let resolved = paths::resolve(path, value)?;
    // rust: Some(if resolved.ends_with(".png") {
    // rust: resolved
    // rust: } else {
    // rust: resolved + ".png"
    // rust: })
}

// A finite number, also when written as a string (paid for).
num :: proc(v: Maybe(^Json), bake: ^Bake) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = match v? {
    // rust: Json::Num(n) => *n as f32,
    // rust: Json::Str(_) => string(v, bake)?.trim().parse().ok()?,
    // rust: _ => return None,
}
    // rust: n.is_finite().then_some(n)
}

boolean :: proc(v: Maybe(^Json), bake: ^Bake) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v? {
    // rust: Json::Bool(b) => Some(*b),
    // rust: Json::Str(_) => string(v, bake)?.trim().parse().ok(),
    // rust: _ => None,
}
}

    // rust: fn nums<const N: usize>(v: Option<&Json>, bake: &mut Bake) -> Option<[f32; N]> {
    // rust: let a = v?.as_array()?;
    // rust: (a.len() >= N).then(|| std::array::from_fn(|i| num(a.get(i), bake).unwrap_or(0.0)))
}

size2 :: proc(v: Maybe(^Json), bake: ^Bake) -> O {
    // Ported from Horizon
    return {}
}
    // rust: nums::<2>(v, bake).filter(|s| s[0] > 0.0 && s[1] > 0.0)
}

// Bakes a part model definition, a part or a submodel the same way: the bone sits at its own
// `translate` (negated on the inverted axes), its boxes at the file's coordinates mirrored on
// them, its submodels at their own translates below it — the poses the pack's animation
// writes replace. The bone costs one of `bake.left`, which the caller makes sure is left, as
// it pays for the walk of its keys; its strings, boxes and submodels what [`Bake`] says.
bone :: proc(def: ^(impl Def + ?Sized) {
}
    // rust: bake.left -= 1;
    // rust: bake.unread |= def.key("texture").is_some() || def.key("sprites").is_some();
    // rust: let axes = string(def.key("invertAxis"), bake).unwrap_or("");
    // rust: let invert = [axes.contains('x'), axes.contains('y'), axes.contains('z')];
    // rust: let sign = |i: usize| if invert[i] { -1.0 } else { 1.0 };
    // rust: let size = size2(def.key("textureSize"), bake).unwrap_or(size);
    // rust: let mirror = string(def.key("mirrorTexture"), bake).unwrap_or("");
    // rust: let translate = nums::<3>(def.key("translate"), bake).unwrap_or_default();
    // rust: let translate: [f32; 3] = std::array::from_fn(|i| sign(i) * translate[i]);
    // A rotation seen through flipped axes: about a flipped axis it turns the other way, and
    // that is all — EMF negates per axis, and an odd number of flips is not a mirror to turn
    // every rotation around.
    // rust: let rotate = nums::<3>(def.key("rotate"), bake).unwrap_or_default();
    // `scale`: a number for all three axes, or an array of three.
    // rust: let scale = match def.key("scale") {
    // rust: Some(Json::Num(s)) => {
    // rust: let s = *s as f32;
    // rust: [if s.is_finite() { s } else { 1.0 }; 3]
}
    // rust: Some(Json::Arr(a)) if a.len() >= 3 => {
    // rust: std::array::from_fn(|i| num(a.get(i), bake).unwrap_or(1.0))
}
    // rust: _ => [1.0; 3],
}
    // `attachments`: the item anchors this declaring bone carries (`right_handheld_item`,
    // `fox_item`...), each offset flipped on the inverted axes, as EMF's part data does —
    // the file's frame is y up, the baked tree's y down.
    // rust: let attachments = def
    // rust: .key("attachments")
    // rust: .and_then(Json::as_object)
    // rust: .map(|pairs| {
    // rust: pairs
    // rust: .iter()
    // rust: .filter_map(|(name, v)| {
    // rust: let at = nums::<3>(Some(v), bake)?;
    // rust: Some((name.clone(), std::array::from_fn(|i| sign(i) * at[i])))
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let mut out = Bone {
    // rust: id: string(def.key("id"), bake).map(str::to_owned),
    // rust: pivot: translate,
    // rust: rotation: std::array::from_fn(|i| sign(i) * rotate[i].to_radians()),
    // rust: scale,
    // rust: attachments,
    // rust: ..Bone::default()
}
    // rust: let shape = Shape {
    // rust: invert,
    // rust: mirror_u: mirror.contains('u'),
    // rust: mirror_v: mirror.contains('v'),
    // rust: size,
}
    // rust: for b in items(def.key("boxes")) {
    // rust: if bake.left == 0 {
    // rust: bake.cut = true;
    // rust: break;
}
    // rust: let Some(b) = b.as_object() else {
    // rust: bake.left -= 1;
    // rust: continue;
}
        // Baking a box reads through its keys: it costs them, so junk keys can't be read again
        // by every entry that inherits the box.
    // rust: if b.len() > bake.left {
    // rust: bake.left = 0;
    // rust: bake.cut = true;
    // rust: break;
}
        // Its strings are paid as they are read; one that doesn't fit leaves nothing for faces.
    // rust: let before = out.quads.len();
    // rust: shape.bake(b, &mut out.quads, bake);
    // rust: let made = out.quads.len() - before;
    // rust: if made > bake.left {
    // rust: out.quads.truncate(before + bake.left);
    // rust: bake.cut = true;
}
    // rust: bake.left = bake.left.saturating_sub(made.max(b.len()).max(1));
}
    // rust: let one = def.key("submodel").filter(|s| s.as_object().is_some());
    // rust: for sub in one.into_iter().chain(items(def.key("submodels"))) {
    // rust: if bake.left == 0 {
    // rust: bake.cut = true;
    // rust: break;
}
    // rust: let Some(sub) = sub.as_object() else {
    // rust: bake.left -= 1;
    // rust: continue;
}
        // Its keys are looked up one by one: it costs them, with one left for its bone.
    // rust: if sub.len() >= bake.left {
    // rust: bake.left = 0;
    // rust: bake.cut = true;
    // rust: break;
}
    // rust: bake.left -= sub.len();
    // rust: out.children.push(bone(sub, size, bake));
}
    // rust: out
}

Shape :: struct {
    invert: [bool,
    mirror_u: bool,
    mirror_v: bool,
    size: [f32,
}

// A box's faces in `ModelPart.Cube`'s order of corners, keyed by the per-face UV name for the
// files' frame (up is vanilla's -y, north -z). `uvWest` is the min-x face and `uvEast` the
// max-x one, as in `ModelPart.Cube` and EMF (whose west face takes the middle row's first
// strip, its east the third): packs name the sides by the model's own frame, and Fresh
// Animations draws 54 models' side art through these two keys.
    // rust: const FACES: [(&str, &str, [usize; 4], [f32; 3]); 6] = [
    // rust: ("uvUp", "", [5, 4, 0, 1], [0.0, -1.0, 0.0]),
    // rust: ("uvDown", "", [2, 3, 7, 6], [0.0, 1.0, 0.0]),
    // rust: ("uvWest", "uvLeft", [0, 4, 7, 3], [-1.0, 0.0, 0.0]),
    // rust: ("uvNorth", "uvFront", [1, 0, 3, 2], [0.0, 0.0, -1.0]),
    // rust: ("uvEast", "uvRight", [5, 1, 2, 6], [1.0, 0.0, 0.0]),
    // rust: ("uvSouth", "uvBack", [4, 5, 6, 7], [0.0, 0.0, 1.0]),
    // rust: ];
// `ModelPart.Cube`'s corners: which of x, y, z take the box's max.
    // rust: const CORNER: [[bool; 3]; 8] = [
    // rust: [false, false, false],
    // rust: [true, false, false],
    // rust: [true, true, false],
    // rust: [false, true, false],
    // rust: [false, false, true],
    // rust: [true, false, true],
    // rust: [true, true, true],
    // rust: [false, true, true],
    // rust: ];

    // rust: impl Shape {
    // Adds the box's faces to `out`; none when its corners or UVs aren't finite.
bake :: proc(self: ^Self, b: ^[(string) {
}
    // rust: let start = out.len();
    // rust: let Some(c) = nums::<6>(get(b, "coordinates"), bake) else {
    // rust: return;
}
        // `sizeAddX/Y/Z` over `sizesAdd` over `sizeAdd`.
    // rust: let all = num(get(b, "sizeAdd"), bake).unwrap_or(0.0);
    // rust: let mut grow = nums::<3>(get(b, "sizesAdd"), bake).unwrap_or([all; 3]);
    // rust: for (i, key) in ["sizeAddX", "sizeAddY", "sizeAddZ"].iter().enumerate() {
    // rust: if let Some(g) = num(get(b, key), bake) {
    // rust: grow[i] = g;
}
}
    // rust: let dims = [c[3], c[4], c[5]];
    // rust: let mut lo = [0.0; 3];
    // rust: let mut hi = [0.0; 3];
    // rust: for i in 0..3 {
    // rust: let min = if self.invert[i] {
    // rust: -(c[i] + dims[i])
    // rust: } else {
    // rust: c[i]
}
    // rust: lo[i] = min - grow[i];
    // rust: hi[i] = min + dims[i] + grow[i];
}
    // rust: let boxed = nums::<2>(get(b, "textureOffset"), bake);
        // A box-UV box mirrored in u is `ModelPart.Cube` with `mirror`: its x sides trade
        // places, and each face winds the other way to keep facing out. `mirrorTexture` is
        // ignored on a box that names its own face rects — EMF hands its custom-UV cube no
        // mirror flags ("it seems optifine ignores these flags on custom uv's") — so Fresh
        // Animations' flat eye quads on mirrored parts stay where the pack drew them.
    // rust: let box_mirror = boxed.is_some() && self.mirror_u;
    // rust: let box_mirror_v = boxed.is_some() && self.mirror_v;
    // rust: if box_mirror {
    // rust: std::mem::swap(&mut lo[0], &mut hi[0]);
}
    // rust: let corner = |i: usize| -> [f32; 3] {
    // rust: std::array::from_fn(|a| if CORNER[i][a] { hi[a] } else { lo[a] })
}
    // rust: let rects = match boxed {
    // rust: Some(t) => box_rects(t, dims).map(Some),
    // rust: None => FACES.map(|(key, alias, ..)| {
    // rust: nums::<4>(get(b, key).or_else(|| get(b, alias)), bake)
    // rust: .filter(|r| r[0] != r[2] || r[1] != r[3])
    // rust: }),
}
    // rust: for ((_, _, corners, normal), rect) in FACES.iter().zip(rects) {
    // rust: let Some(mut r) = rect else {
    // rust: continue;
}
    // rust: if box_mirror_v {
    // rust: r.swap(1, 3);
}
    // rust: let [u1, v1, u2, v2] = r;
    // rust: let uv = [(u2, v1), (u1, v1), (u1, v2), (u2, v2)];
    // rust: let mut vertices: [[f32; 5]; 4] = std::array::from_fn(|k| {
    // rust: let [x, y, z] = corner(corners[k]);
    // rust: [x, y, z, uv[k].0 / self.size[0], uv[k].1 / self.size[1]]
    // rust: });
    // rust: if vertices.iter().flatten().any(|x| !x.is_finite()) {
    // rust: out.truncate(start);
    // rust: return;
}
    // rust: let mut normal = *normal;
    // rust: if box_mirror {
    // rust: vertices.reverse();
    // rust: normal[0] = -normal[0];
}
    // rust: out.push(Quad { normal, vertices });
}
}
}

// `ModelPart.Cube`'s box UV: the faces' `[u1, v1, u2, v2]` around `textureOffset`, in
// `FACES` order (top strip: up then down; then east, north, west, south).
box_rects :: proc(v]: [f32; 2], d]: [f32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let (u1, u2, u3, u4, u5) = (
    // rust: u + d,
    // rust: u + d + w,
    // rust: u + d + w + w,
    // rust: u + d + w + d,
    // rust: u + 2.0 * (d + w),
    // rust: );
    // rust: let (v1, v2) = (v + d, v + d + h);
    // rust: [
    // rust: [u1, v, u2, v1],
    // rust: [u2, v1, u3, v],
    // rust: [u, v1, u1, v2],
    // rust: [u1, v1, u2, v2],
    // rust: [u2, v1, u4, v2],
    // rust: [u4, v1, u5, v2],
    // rust: ]
}

    // rust: mod tests {
//     use super::*;

JEM :: "assets/minecraft/optifine/cem/zombie.jem"

parse :: proc(text: string) -> E {
    // Ported from Horizon
    return {}
}
    // rust: parse_jem(JEM, text, &mut |_| None).unwrap()
}
face :: proc(bone: ^Bone, normal: [f32; 3]) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: bone.quads.iter().find(|q| q.normal == normal).unwrap()
}
positions :: proc(q: ^Quad) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: q.vertices.map(|v| [v[0], v[1], v[2]])
}

    // The zombie's head and right leg as an export writes them: vanilla's head has its pivot at
    // 0 and a box from (-4, -8, -4); the right leg its pivot at (-1.9, 12, 0) and a box from
    // (-2, 0, -2), 4 x 12 x 4.
    // rust: const ZOMBIE: &str = r#"{
    // rust: "textureSize": [64, 64],
    // rust: "models": [
    // rust: {"part": "head", "id": "head", "invertAxis": "xy", "translate": [0, -24, 0],
    // rust: "boxes": [{"coordinates": [-4, 24, -4, 8, 8, 8], "textureOffset": [0, 0]}]},
    // rust: {"part": "right_leg", "id": "right_leg", "invertAxis": "xy", "translate": [-1.9, -12, 0],
    // rust: "boxes": [{"coordinates": [-0.1, 0, -2, 4, 12, 4], "textureOffset": [0, 16]}]}
    // rust: ]
    // rust: }"#;

parts_land_where_vanilla_has_them_relative_to_their_pivots :: proc() {
}
    // rust: let model = parse(ZOMBIE);
        // The bone hangs at its translate (minus the part's pivot, the file's y up against
        // vanilla's y down) and the box at the file's coordinates mirrored, the two landing
        // the geometry back around the vanilla pivot.
    // rust: let head = &model.parts[0].bone;
    // rust: assert_eq!(head.pivot, [0.0, 24.0, 0.0]);
        // The face, at the head's front (-z), with the skin's face square (8, 8)-(16, 16):
        // 8 pixels above the pivot, as vanilla has it.
    // rust: let north = face(head, [0.0, 0.0, -1.0]);
    // rust: let net = |q: &Quad| {
    // rust: q.vertices.map(|v| {
    // rust: [
    // rust: v[0] + head.pivot[0],
    // rust: v[1] + head.pivot[1],
    // rust: v[2] + head.pivot[2],
    // rust: ]
    // rust: })
}
    // rust: assert_eq!(
    // rust: net(north),
    // rust: [
    // rust: [4.0, -8.0, -4.0],
    // rust: [-4.0, -8.0, -4.0],
    // rust: [-4.0, 0.0, -4.0],
    // rust: [4.0, 0.0, -4.0]
    // rust: ]
    // rust: );
    // rust: let uv = north.vertices.map(|v| [v[3] * 64.0, v[4] * 64.0]);
    // rust: assert_eq!(uv, [[16.0, 8.0], [8.0, 8.0], [8.0, 16.0], [16.0, 16.0]]);
        // The leg's box spans x -2..2 and y 0..12 around the vanilla pivot: the bone at its
        // translate and the box mirrored below it, summed here as they draw.
    // rust: let leg = &model.parts[1].bone;
    // rust: let mut lo = [f32::MAX; 3];
    // rust: let mut hi = [f32::MIN; 3];
    // rust: for v in leg.quads.iter().flat_map(|q| q.vertices) {
    // rust: for a in 0..3 {
    // rust: lo[a] = lo[a].min(v[a] + leg.pivot[a]);
    // rust: hi[a] = hi[a].max(v[a] + leg.pivot[a]);
}
}
    // rust: let close = |a: [f32; 3], b: [f32; 3]| a.iter().zip(b).all(|(x, y)| (x - y).abs() < 1e-5);
    // rust: assert!(
    // rust: close(lo, [-2.0, 0.0, -2.0]) && close(hi, [2.0, 12.0, 2.0]),
    // rust: "{lo:?} {hi:?}"
    // rust: );
        // Leg texture: the top at (4, 16)-(8, 20), the west side (vanilla +x) at (8, 20)-(12, 32).
    // rust: let uv = |q: &Quad| q.vertices.map(|v| [v[3] * 64.0, v[4] * 64.0]);
    // rust: assert_eq!(uv(face(leg, [0.0, -1.0, 0.0]))[1], [4.0, 16.0]);
    // rust: assert_eq!(uv(face(leg, [0.0, -1.0, 0.0]))[3], [8.0, 20.0]);
    // rust: assert_eq!(uv(face(leg, [1.0, 0.0, 0.0]))[1], [8.0, 20.0]);
    // rust: assert_eq!(uv(face(leg, [1.0, 0.0, 0.0]))[3], [12.0, 32.0]);
}

faces_wind_outward_mirrored_or_not :: proc() {
}
    // rust: for mirror in ["", "u"] {
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "mirrorTexture": "{mirror}",
    // rust: "boxes": [{{"coordinates": [1, 2, 3, 4, 5, 6], "textureOffset": [0, 0]}}]}}]}}"#
    // rust: ));
    // rust: let quads = &model.parts[0].bone.quads;
    // rust: assert_eq!(quads.len(), 6);
    // rust: let mut normals: Vec<[f32; 3]> = quads.iter().map(|q| q.normal).collect();
    // rust: normals.sort_by(|a, b| a.partial_cmp(b).unwrap());
    // rust: normals.dedup();
    // rust: assert_eq!(normals.len(), 6, "{mirror}: every side once");
    // rust: for q in quads {
    // rust: let [a, b, c, _] = positions(q);
    // rust: let e1 = [b[0] - a[0], b[1] - a[1], b[2] - a[2]];
    // rust: let e2 = [c[0] - a[0], c[1] - a[1], c[2] - a[2]];
    // rust: let cross = [
    // rust: e1[1] * e2[2] - e1[2] * e2[1],
    // rust: e1[2] * e2[0] - e1[0] * e2[2],
    // rust: e1[0] * e2[1] - e1[1] * e2[0],
    // rust: ];
    // rust: let dot: f32 = cross.iter().zip(q.normal).map(|(x, n)| x * n).sum();
    // rust: assert!(dot > 0.0, "{mirror}: {q:?}");
                // The face sits on the side its normal points to (box 1..5, 2..7, 3..9).
    // rust: let axis = q.normal.iter().position(|n| *n != 0.0).unwrap();
    // rust: let side = if q.normal[axis] > 0.0 {
    // rust: [5.0, 7.0, 9.0]
    // rust: } else {
    // rust: [1.0, 2.0, 3.0]
}
    // rust: assert!(
    // rust: q.vertices.iter().all(|v| v[axis] == side[axis]),
    // rust: "{mirror}: {q:?}"
    // rust: );
}
}
}

mirrored_box_puts_the_first_strip_on_the_other_side :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "body", "mirrorTexture": "u",
    // rust: "boxes": [{"coordinates": [0, 0, 0, 2, 2, 2], "textureOffset": [0, 0]}]}]}"#,
    // rust: );
        // Unmirrored, (0, 2)-(2, 4) is the -x side; mirrored it is the +x side.
    // rust: let east = face(&model.parts[0].bone, [1.0, 0.0, 0.0]);
    // rust: let us: Vec<f32> = east.vertices.iter().map(|v| v[3] * 64.0).collect();
    // rust: assert!(us.iter().all(|u| (0.0..=2.0).contains(u)), "{us:?}");
}

submodels_pivot_in_their_parents_frame_and_rotate_on_vanilla_axes :: proc() {
}
        // A brim on the head pivoting at the head's pivot, and a feather 2 px above it.
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "invertAxis": "xy", "translate": [0, -24, 0],
    // rust: "submodels": [{"id": "brim", "invertAxis": "xy", "translate": [0, 24, 0],
    // rust: "rotate": [90, 0, 45],
    // rust: "boxes": [{"coordinates": [-1, 0, -1, 2, 2, 2], "textureOffset": [0, 0]}],
    // rust: "submodels": [{"id": "feather", "invertAxis": "xy", "translate": [0, 2, 0]}]}]}]}"#,
    // rust: );
        // The part's bone at its translate, the submodel's at its own, alone: what a
        // `brim.ty` write replaces, whatever the parent carries.
    // rust: assert_eq!(model.parts[0].bone.pivot, [0.0, 24.0, 0.0]);
    // rust: let brim = &model.parts[0].bone.children[0];
    // rust: assert_eq!(brim.id.as_deref(), Some("brim"));
    // rust: assert_eq!(brim.pivot, [0.0, -24.0, 0.0]);
    // rust: let r = std::f32::consts::FRAC_PI_2;
    // rust: assert_eq!(brim.rotation, [-r, 0.0, r / 2.0]);
    // rust: let ys: Vec<f32> = brim
    // rust: .quads
    // rust: .iter()
    // rust: .flat_map(|q| q.vertices.map(|v| v[1]))
    // rust: .collect();
    // rust: assert!(ys.iter().all(|y| (-2.0..=0.0).contains(y)), "{ys:?}");
    // rust: assert_eq!(brim.children[0].pivot, [0.0, -2.0, 0.0]);
}

uvs :: proc(q: ^Quad, w: f32, h: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: q.vertices.map(|v| [v[3] * w, v[4] * h])
}
bounds :: proc(bone: ^Bone) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut lo = [f32::MAX; 3];
    // rust: let mut hi = [f32::MIN; 3];
    // rust: for v in bone.quads.iter().flat_map(|q| q.vertices) {
    // rust: for a in 0..3 {
    // rust: lo[a] = lo[a].min(v[a]);
    // rust: hi[a] = hi[a].max(v[a]);
}
}
    // rust: (lo, hi)
}

each_inverted_axis_flips_position_and_rotation :: proc() {
}
    // rust: let part = |axes: &str| {
    // rust: parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "invertAxis": "{axes}",
    // rust: "translate": [1, 2, 3], "rotate": [30, 60, 90],
    // rust: "boxes": [{{"coordinates": [1, 2, 3, 1, 1, 1], "textureOffset": [0, 0]}}]}}]}}"#
    // rust: ))
    // rust: .parts
    // rust: .remove(0)
    // rust: .bone
}
        // The geometry lands where it did: the bone at its translate, the box below it, the
        // translate never doubled in. The bones' poses are their own translates.
    // rust: let net = |b: &Bone| {
    // rust: let mut lo = [f32::MAX; 3];
    // rust: let mut hi = [f32::MIN; 3];
    // rust: for v in b.quads.iter().flat_map(|q| q.vertices) {
    // rust: for a in 0..3 {
    // rust: lo[a] = lo[a].min(v[a] + b.pivot[a]);
    // rust: hi[a] = hi[a].max(v[a] + b.pivot[a]);
}
}
    // rust: (lo, hi)
}
    // rust: assert_eq!(net(&part("xyz")), ([-3.0, -5.0, -7.0], [-2.0, -4.0, -6.0]));
    // rust: assert_eq!(net(&part("")), ([2.0, 4.0, 6.0], [3.0, 5.0, 7.0]));
    // rust: assert_eq!(part("").pivot, [1.0, 2.0, 3.0]);
    // rust: assert_eq!(part("xyz").pivot, [-1.0, -2.0, -3.0]);
        // Degrees to radians; a flipped axis turns the other way, and only that axis: an odd
        // number of flips is not a mirror (EMF negates each axis on its own).
    // rust: let deg = |r: [f32; 3]| r.map(|a| (a.to_degrees() * 1000.0).round() / 1000.0);
    // rust: assert_eq!(deg(part("").rotation), [30.0, 60.0, 90.0]);
    // rust: assert_eq!(deg(part("xy").rotation), [-30.0, -60.0, 90.0]);
    // rust: assert_eq!(deg(part("xyz").rotation), [-30.0, -60.0, -90.0]);
    // rust: assert_eq!(deg(part("x").rotation), [-30.0, 60.0, 90.0]);
}

per_face_uvs_by_name_and_mirrored_boxes_keep_their_rects :: proc() {
}
    // rust: let face_of = |key: &str, mirror: &str| {
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "textureSize": [16, 16], "mirrorTexture": "{mirror}",
    // rust: "boxes": [{{"coordinates": [0, 0, 0, 2, 2, 2], "{key}": [0, 0, 2, 2]}}]}}]}}"#
    // rust: ));
    // rust: let quads = &model.parts[0].bone.quads;
    // rust: assert_eq!(quads.len(), 1, "{key}");
    // rust: quads[0].clone()
}
        // `uvEast` is the max-x face and `uvWest` the min-x one, as `ModelPart.Cube` and
        // EMF name them: Fresh Animations draws its side art by these names.
    // rust: let east = face_of("uvEast", "");
    // rust: assert_eq!(east.normal, [1.0, 0.0, 0.0]);
    // rust: assert!(east.vertices.iter().all(|v| v[0] == 2.0));
    // rust: assert_eq!(
    // rust: uvs(&east, 16.0, 16.0),
    // rust: [[2.0, 0.0], [0.0, 0.0], [0.0, 2.0], [2.0, 2.0]]
    // rust: );
        // `uvRight` is `uvEast`'s other name; `mirrorTexture` is ignored on a box that
        // names its own face rects (EMF hands its custom-UV cube no mirror flags), so the
        // mirrored variant keeps the pack's rect.
    // rust: assert_eq!(
    // rust: uvs(&face_of("uvRight", "uv"), 16.0, 16.0),
    // rust: [[2.0, 0.0], [0.0, 0.0], [0.0, 2.0], [2.0, 2.0]]
    // rust: );
    // rust: let west = face_of("uvWest", "");
    // rust: assert_eq!(west.normal, [-1.0, 0.0, 0.0]);
    // rust: assert!(west.vertices.iter().all(|v| v[0] == 0.0));
}

size_adds_grow_positions_per_axis :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "body", "boxes": [{"coordinates": [0, 0, 0, 2, 2, 2],
    // rust: "textureOffset": [0, 0], "sizeAdd": 9, "sizesAdd": [1, 0, 0], "sizeAddY": 0.5}]}]}"#,
    // rust: );
    // rust: let bone = &model.parts[0].bone;
    // rust: assert_eq!(bounds(bone), ([-1.0, -0.5, 0.0], [3.0, 2.5, 2.0]));
        // The UVs keep the box's own size: the north face spans u 2..4 of the default 64 x 32.
    // rust: assert_eq!(
    // rust: uvs(face(bone, [0.0, 0.0, -1.0]), 64.0, 32.0),
    // rust: [[4.0, 2.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0]]
    // rust: );
}

texture_size_reaches_a_single_submodel :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "invertAxis": "xy", "translate": [0, -24, 0], "textureSize": [16, 16],
    // rust: "submodel": {"boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "uvUp": [0, 0, 1, 1]}]}}]}"#,
    // rust: );
    // rust: let child = &model.parts[0].bone.children[0];
    // rust: assert_eq!(child.pivot, [0.0, 0.0, 0.0]);
    // rust: let max_u = child.quads[0]
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v[3])
    // rust: .fold(0.0, f32::max);
    // rust: assert_eq!(max_u, 1.0 / 16.0);
}

animations_keep_file_order :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "attach": "true",
    // rust: "animations": [{"var.a": "1", "head.rx": "var.a"}, {"this.tx": 0}]}]}"#,
    // rust: );
    // rust: let head = &model.parts[0];
    // rust: assert!(head.attach);
    // rust: assert_eq!(
    // rust: head.animations,
    // rust: [("var.a", "1"), ("head.rx", "var.a"), ("this.tx", "0")]
    // rust: .map(|(a, b)| (a.to_owned(), b.to_owned()))
    // rust: );
}

part_files_and_bases :: proc() {
}
    // rust: let file = |boxes: &str| {
    // rust: format!(
    // rust: r#"{{"textureSize": [32, 32], "boxes": [{{"coordinates": [{boxes}], "uvFront": [0, 0, 4, 2]}}]}}"#
    // rust: )
}
    // rust: let mut asked = Vec::new();
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: r#"{"texture": "textures/entity/zombie/green", "models": [
    // rust: {"id": "base", "part": "head", "model": "hat.jpm", "scale": 1.5},
    // rust: {"baseId": "base", "part": "headwear", "attach": true},
    // rust: {"baseId": "base", "part": "body", "model": "./parts/vest.jpm"},
    // rust: {"part": "left_arm", "model": "hat.jpm"}
    // rust: ]}"#,
    // rust: &mut |p| {
    // rust: asked.push(p.to_owned());
    // rust: Some(file(if p.ends_with("vest.jpm") {
    // rust: "0, 0, 0, 8, 8, 8"
    // rust: } else {
    // rust: "0, 0, 0, 4, 2, 4"
    // rust: }))
    // rust: },
    // rust: )
    // rust: .unwrap();
        // Each file is read once, however many entries name it.
    // rust: assert_eq!(
    // rust: asked,
    // rust: [
    // rust: "assets/minecraft/optifine/cem/hat.jpm",
    // rust: "assets/minecraft/optifine/cem/parts/vest.jpm"
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: model.texture.as_deref(),
    // rust: Some("assets/minecraft/textures/entity/zombie/green.png")
    // rust: );
    // rust: let [head, headwear, body, arm] = &model.parts[..] else {
    // rust: panic!("{:?}", model.parts);
}
    // rust: assert_eq!((head.scale, head.attach), (1.5, false));
    // rust: assert_eq!(head.bone.quads.len(), 1);
    // rust: assert_eq!(bounds(&head.bone), ([0.0, 0.0, 0.0], [4.0, 2.0, 0.0]));
        // The second entry inherits the first's part model under its own part and attach.
    // rust: assert_eq!(
    // rust: (headwear.part.as_str(), headwear.attach, headwear.scale),
    // rust: ("headwear", true, 1.5)
    // rust: );
    // rust: assert_eq!(headwear.bone.quads, head.bone.quads);
        // Its own part file wins over the inherited one.
    // rust: assert_eq!(bounds(&body.bone), ([0.0, 0.0, 0.0], [8.0, 8.0, 0.0]));
    // rust: assert_eq!(arm.bone.quads, head.bone.quads);
    // rust: assert!(model.warnings.is_empty(), "{:?}", model.warnings);
}

broken_entries_are_left_out_with_a_warning :: proc() {
}
    // rust: let mut asked = Vec::new();
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: "\u{feff}{\"models\": [ // a hand-edited file\n
    // rust: {\"part\": \"head\", \"model\": \"missing.jpm\"},
    // rust: {\"part\": \"head\", \"model\": \"../../../../etc/passwd\"},
    // rust: {\"part\": \"body\", \"baseId\": \"nope\", \"boxes\": [{\"coordinates\": [0, 0, 0, 1, 1, 1], \"textureOffset\": [0, 0]}]},
    // rust: {\"part\": \"tail\", \"scale\": \"NaN\"},
    // rust: ]}",
    // rust: &mut |p| {
    // rust: asked.push(p.to_owned());
    // rust: None
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(asked, ["assets/minecraft/optifine/cem/missing.jpm"]);
    // rust: let names: Vec<&str> = model.parts.iter().map(|p| p.part.as_str()).collect();
    // rust: assert_eq!(names, ["body", "tail"]);
    // rust: assert_eq!(model.parts[0].bone.quads.len(), 6);
    // rust: assert_eq!(model.parts[1].scale, 1.0);
    // rust: assert_eq!(model.warnings.len(), 3, "{:?}", model.warnings);
    // rust: assert!(model.warnings[1].contains("outside the pack"));
    // rust: assert!(parse_jem(JEM, "{", &mut |_| None).is_err());
}

a_file_builds_at_most_its_limits :: proc() {
}
        // Faces: the part and its bone, then boxes of six, the last one cut to the faces left.
    // rust: let one = r#"{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}"#;
    // rust: let boxes = vec![one; MAX_NODES / 6 + 10].join(",");
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "boxes": [{boxes}]}}]}}"#
    // rust: ));
    // rust: let quads = model.parts[0].bone.quads.len();
    // rust: assert!((MAX_NODES - 8..MAX_NODES).contains(&quads), "{quads}");
    // rust: assert_eq!(model.warnings.len(), 1);
        // Bones count too: empty submodels can't multiply for free. A part after the cut is left
        // out rather than replacing its vanilla part with nothing.
    // rust: let empty = vec!["{}"; MAX_NODES].join(",");
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "boxes": [{one}], "submodels": [{empty}]}},
    // rust: {{"part": "head"}}]}}"#
    // rust: ));
    // rust: assert_eq!(model.parts.len(), 1);
    // rust: let children = model.parts[0].bone.children.len();
    // rust: assert!(children > 0 && children < MAX_NODES, "{children}");
    // rust: assert_eq!(model.warnings.len(), 1);
        // Boxes without faces count, and so do items that aren't boxes; a part they cut down to
        // nothing is left out too. A box of two keys costs both.
    // rust: for (junk, n) in [
    // rust: ("{}", MAX_NODES),
    // rust: ("0", MAX_NODES),
    // rust: (r#"{"a": 1, "b": 2}"#, MAX_NODES / 2 + 1),
    // rust: ] {
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "boxes": [{}, {one}]}}, {{"part": "head"}}]}}"#,
    // rust: vec![junk; n].join(",")
    // rust: ));
    // rust: assert!(model.parts.is_empty(), "{junk}: {:?}", model.parts);
    // rust: assert_eq!(model.warnings.len(), 1, "{junk}");
}
        // So do submodels that aren't objects.
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "submodels": [{}, {{"boxes": [{one}]}}]}}]}}"#,
    // rust: vec!["[]"; MAX_NODES].join(",")
    // rust: ));
    // rust: assert!(model.parts.is_empty(), "{:?}", model.parts);
        // A box's keys cost even when it has no faces, so one of junk keys spends what is left
        // and isn't read again by the entries that inherit it.
    // rust: let keys: Vec<String> = (0..MAX_NODES).map(|i| format!(r#""k{i}": 0"#)).collect();
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"id": "a", "boxes": [{{{}}}]}}, {{"part": "head", "baseId": "a"}},
    // rust: {{"part": "body", "boxes": [{one}]}}]}}"#,
    // rust: keys.join(",")
    // rust: ));
    // rust: assert!(model.parts.is_empty(), "{:?}", model.parts);
    // rust: assert_eq!(model.warnings.len(), 1);
        // Animations: an entry whose list doesn't fit what is left is left out whole, before it
        // spends anything, rather than drawn frozen. Pairs skipped as not scalar count too, and
        // so do items that aren't objects.
    // rust: let pairs = |pair: &str| format!("{{{}}}", vec![pair; MAX_NODES].join(","));
    // rust: for list in [
    // rust: pairs(r#""var.a": "1""#),
    // rust: pairs(r#""var.a": [1]"#),
    // rust: vec!["0"; MAX_NODES].join(","),
    // rust: ] {
    // rust: let model = parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "boxes": [{one}], "animations": [{list}]}},
    // rust: {{"part": "head", "boxes": [{one}]}}]}}"#
    // rust: ));
    // rust: let names: Vec<&str> = model.parts.iter().map(|p| p.part.as_str()).collect();
    // rust: assert_eq!(names, ["head"], "{}", &list[..20]);
    // rust: assert_eq!(model.parts[0].bone.quads.len(), 6);
    // rust: assert_eq!(model.warnings.len(), 1);
}
        // Entries count whether or not they name a part.
    // rust: let ids = vec![r#"{"id": "x"}"#; MAX_ENTRIES].join(",");
    // rust: let model = parse(&format!(r#"{{"models": [{ids}, {{"part": "late"}}]}}"#));
    // rust: assert!(model.parts.is_empty());
    // rust: assert!(model.warnings[0].contains("models"));
}

the_last_nodes_still_take_a_box_and_using_them_all_is_no_cut :: proc() {
}
        // The first part spends all but `left`: its name, its layer, its bone and its empty
        // submodels. The second costs three the same way, then its box: one face and two keys
        // cost two.
    // rust: let after = |left: usize, faces: &str| {
    // rust: let empty = vec!["{}"; MAX_NODES - left - 3].join(",");
    // rust: parse(&format!(
    // rust: r#"{{"models": [{{"part": "body", "submodels": [{empty}]}},
    // rust: {{"part": "head", "boxes": [{{"coordinates": [0, 0, 0, 1, 1, 1], {faces}}}]}}]}}"#
    // rust: ))
}
        // One face, with 5 left: it fits exactly.
    // rust: let model = after(5, r#""uvUp": [0, 0, 1, 1]"#);
    // rust: assert_eq!(model.parts[1].bone.quads.len(), 1);
    // rust: assert!(model.warnings.is_empty(), "{:?}", model.warnings);
        // Six faces with 6 left: the part keeps three of them.
    // rust: let model = after(6, r#""textureOffset": [0, 0]"#);
    // rust: assert_eq!(model.parts[1].bone.quads.len(), 3);
    // rust: assert_eq!(model.warnings.len(), 1);
        // With 3 left the bone takes the last and its box is cut: the part is left out, not
        // emptied.
    // rust: let model = after(3, r#""textureOffset": [0, 0]"#);
    // rust: let names: Vec<&str> = model.parts.iter().map(|p| p.part.as_str()).collect();
    // rust: assert_eq!(names, ["body"]);
    // rust: assert_eq!(model.warnings.len(), 1);
}

a_key_repeated_in_an_entry_takes_its_last_value :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "textureSize": [16, 16], "textureSize": [32, 32],
    // rust: "boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "uvUp": [0, 0, 1, 1]}]}]}"#,
    // rust: );
    // rust: let max_u = model.parts[0].bone.quads[0]
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v[3])
    // rust: .fold(0.0, f32::max);
    // rust: assert_eq!(max_u, 1.0 / 32.0);
}

boxes_off_the_numbers_are_skipped :: proc() {
}
        // The first box's corners overflow, the second's UVs (u runs to twice its depth).
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "boxes": [
    // rust: {"coordinates": [3e38, 0, 0, 3e38, 1, 1], "textureOffset": [0, 0]},
    // rust: {"coordinates": [0, 0, 0, 1, 1, 3e38], "textureOffset": [0, 0]},
    // rust: {"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}]}]}"#,
    // rust: );
    // rust: let quads = &model.parts[0].bone.quads;
    // rust: assert_eq!(quads.len(), 6);
    // rust: assert!(
    // rust: quads
    // rust: .iter()
    // rust: .flat_map(|q| q.vertices)
    // rust: .flatten()
    // rust: .all(f32::is_finite)
    // rust: );
}

files_over_the_byte_limit :: proc() {
}
        // Valid JSON, so only its size can refuse it.
    // rust: let padded = |json: &str, len: usize| format!("{json}{}", " ".repeat(len - json.len()));
    // rust: let big = padded(r#"{"models": []}"#, MAX_BYTES + 1);
    // rust: let err = parse_jem(JEM, &big, &mut |_| None).unwrap_err();
    // rust: assert!(err.contains("larger"), "{err}");
    // rust: let big = padded("{}", MAX_BYTES + 1);
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: r#"{"models": [{"part": "head", "model": "big.jpm"}, {"part": "body"}]}"#,
    // rust: &mut |_| Some(big.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(model.parts.len(), 1);
    // rust: assert_eq!(model.parts[0].part, "body");
    // rust: assert_eq!(model.warnings.len(), 1);
    // rust: assert!(model.warnings[0].contains("larger"), "{:?}", model.warnings);
        // The files count together: two that fit alone don't fit both, and one read again from
        // the cache counts once.
    // rust: let half = padded(
    // rust: r#"{"boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}]}"#,
    // rust: MAX_BYTES / 2 + 1,
    // rust: );
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: r#"{"models": [{"part": "head", "model": "a.jpm"}, {"part": "body", "model": "b.jpm"},
    // rust: {"part": "tail", "model": "a.jpm"}]}"#,
    // rust: &mut |_| Some(half.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: let names: Vec<&str> = model.parts.iter().map(|p| p.part.as_str()).collect();
    // rust: assert_eq!(names, ["head", "tail"]);
    // rust: assert_eq!(model.warnings.len(), 1);
    // rust: assert!(model.warnings[0].contains("larger"), "{:?}", model.warnings);
        // The `.jem`'s own bytes count with them.
    // rust: let most = padded("{}", MAX_BYTES - 8);
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: r#"{"models": [{"part": "head", "model": "a.jpm"}]}"#,
    // rust: &mut |_| Some(most.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(model.parts.is_empty(), "{:?}", model.parts);
    // rust: assert!(model.warnings[0].contains("larger"), "{:?}", model.warnings);
}

entries_sharing_a_part_file_pay_for_what_each_reads :: proc() {
}
    // rust: let jem: Vec<String> = (0..MAX_ENTRIES)
    // rust: .map(|i| format!(r#"{{"part": "p{i}", "model": "a.jpm"}}"#))
    // rust: .collect();
    // rust: let jem = format!(r#"{{"models": [{}]}}"#, jem.join(","));
    // rust: let one = r#"{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}"#;
        // Each part copies the expression it inherits, so only a few of a megabyte fit.
    // rust: let jpm = format!(
    // rust: r#"{{"boxes": [{one}], "animations": [{{"this.rx": "{}"}}]}}"#,
    // rust: "1".repeat(1 << 20)
    // rust: );
    // rust: let model = parse_jem(JEM, &jem, &mut |_| Some(jpm.clone())).unwrap();
    // rust: let copied: usize = model
    // rust: .parts
    // rust: .iter()
    // rust: .flat_map(|p| &p.animations)
    // rust: .map(|(_, e)| e.len())
    // rust: .sum();
    // rust: assert!(!model.parts.is_empty() && copied <= MAX_BYTES, "{copied}");
    // rust: assert_eq!(model.warnings.len(), 1, "{:?}", model.warnings);
    // rust: assert!(model.warnings[0].contains("left out"));
        // Each part looks keys up through its submodel's, so junk ones can't be read by all.
    // rust: let keys: Vec<String> = (0..200_000).map(|i| format!(r#""k{i}": 0"#)).collect();
    // rust: let jpm = format!(
    // rust: r#"{{"submodel": {{{}, "boxes": [{one}]}}}}"#,
    // rust: keys.join(",")
    // rust: );
    // rust: let model = parse_jem(JEM, &jem, &mut |_| Some(jpm.clone())).unwrap();
    // rust: assert!(model.parts.len() < MAX_ENTRIES);
    // rust: assert_eq!(model.warnings.len(), 1, "{:?}", model.warnings);
    // rust: assert!(model.warnings[0].contains("left out"));
}

a_missing_file_is_asked_for_once_and_warned_per_entry :: proc() {
}
    // rust: let mut asked = 0;
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: r#"{"models": [{"part": "head", "model": "gone.jpm"}, {"part": "body", "model": "gone.jpm"}]}"#,
    // rust: &mut |_| {
    // rust: asked += 1;
    // rust: None
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(asked, 1);
    // rust: assert!(model.parts.is_empty());
    // rust: assert_eq!(model.warnings.len(), 2, "{:?}", model.warnings);
}

own_keys_win_over_the_part_file_also_in_a_base :: proc() {
}
        // The part file's box spans u 0..4; at its own 32 wide that would end at 4/32.
    // rust: let jpm = r#"{"textureSize": [32, 32],
    // rust: "boxes": [{"coordinates": [0, 0, 0, 4, 2, 0], "uvFront": [0, 0, 4, 2]}]}"#;
    // rust: let model = parse_jem(
    // rust: JEM,
    // rust: r#"{"models": [
    // rust: {"part": "head", "model": "a.jpm", "textureSize": [64, 64]},
    // rust: {"id": "base", "model": "a.jpm", "textureSize": [64, 64]},
    // rust: {"part": "body", "baseId": "base"}
    // rust: ]}"#,
    // rust: &mut |_| Some(jpm.to_owned()),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(model.parts.len(), 2);
    // rust: for part in &model.parts {
    // rust: let max_u = part.bone.quads[0]
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v[3])
    // rust: .fold(0.0, f32::max);
    // rust: assert_eq!(max_u, 4.0 / 64.0, "{}", part.part);
}
}

bases_chain_and_the_first_id_wins :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [
    // rust: {"id": "a", "scale": 2, "boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}]},
    // rust: {"id": "a", "scale": 9},
    // rust: {"id": "b", "baseId": "a", "attach": true},
    // rust: {"baseId": "b", "part": "head"}
    // rust: ]}"#,
    // rust: );
    // rust: let head = &model.parts[0];
    // rust: assert_eq!(
    // rust: (head.scale, head.attach, head.bone.quads.len()),
    // rust: (2.0, true, 6)
    // rust: );
}

a_submodels_pose_is_its_own_translate_whatever_the_parent_carries :: proc() {
}
        // Fresh Animations parks a cow's `head2` at `head2.ty = -20` under a `body` part
        // whose translate is 14: every bone's pose is its own translate alone, or each
        // animation write moves the geometry by the parent's amount and the head flies off
        // the body on the pack's first frame.
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "body", "invertAxis": "xy", "translate": [0, -14, -1],
    // rust: "submodels": [{"id": "head2", "invertAxis": "xy", "translate": [0, 20, -8],
    // rust: "boxes": [{"coordinates": [-4, 14, -4, 8, 8, 8], "textureOffset": [0, 0]}],
    // rust: "submodels": [{"id": "snout", "invertAxis": "xy", "translate": [0, -2, -6]}]}]}]}"#,
    // rust: );
    // rust: let body = &model.parts[0].bone;
    // rust: assert_eq!(body.pivot, [0.0, 14.0, -1.0]);
    // rust: let head = &body.children[0];
    // rust: assert_eq!(head.pivot, [0.0, -20.0, -8.0]);
    // rust: assert_eq!(head.children[0].pivot, [0.0, 2.0, -6.0]);
        // The chain of pivots lands the head where the model has it: 6 up and 9 forward of
        // the vanilla body's pivot, the box hanging 22..14 below the head's own pivot.
    // rust: assert_eq!(
    // rust: [
    // rust: body.pivot[0] + head.pivot[0],
    // rust: body.pivot[1] + head.pivot[1],
    // rust: body.pivot[2] + head.pivot[2]
    // rust: ],
    // rust: [0.0, -6.0, -9.0]
    // rust: );
    // rust: let lo = head
    // rust: .quads
    // rust: .iter()
    // rust: .flat_map(|q| q.vertices)
    // rust: .map(|v| v[1])
    // rust: .fold(f32::MAX, f32::min);
    // rust: let hi = head
    // rust: .quads
    // rust: .iter()
    // rust: .flat_map(|q| q.vertices)
    // rust: .map(|v| v[1])
    // rust: .fold(f32::MIN, f32::max);
    // rust: assert!(
    // rust: (lo - -22.0).abs() < 1e-5 && (hi - -14.0).abs() < 1e-5,
    // rust: "{lo} {hi}"
    // rust: );
}

bones_carry_scale_and_attachments :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "invertAxis": "xy", "scale": 1.5,
    // rust: "attachments": {"right_handheld_item": [1, -2, 3]},
    // rust: "submodels": [{"id": "arm", "invertAxis": "xyz", "scale": [1, 2, 4],
    // rust: "attachments": {"fox_item": [0, 6, -1]}}]}]}"#,
    // rust: );
    // rust: assert_eq!(model.parts[0].bone.scale, [1.5; 3]);
        // The offsets flip on the declaring bone's inverted axes.
    // rust: assert_eq!(
    // rust: model.parts[0].bone.attachments,
    // rust: [("right_handheld_item".to_owned(), [-1.0, 2.0, 3.0])]
    // rust: );
    // rust: let arm = &model.parts[0].bone.children[0];
    // rust: assert_eq!(arm.scale, [1.0, 2.0, 4.0]);
    // rust: assert_eq!(arm.attachments, [("fox_item".to_owned(), [0.0, -6.0, 1.0])]);
}

unread_keys_are_named_once :: proc() {
}
    // rust: let model = parse(
    // rust: r#"{"models": [{"part": "head", "texture": "a"}, {"part": "body", "sprites": []}]}"#,
    // rust: );
    // rust: assert_eq!(model.warnings.len(), 1);
    // rust: assert!(model.warnings[0].contains("textures and sprites"));
    // rust: let model = parse(r#"{"models": [{"part": "head", "submodels": [{"texture": "a"}]}]}"#);
    // rust: assert_eq!(model.warnings.len(), 1);
    // rust: assert!(model.warnings[0].contains("textures and sprites"));
}
}
