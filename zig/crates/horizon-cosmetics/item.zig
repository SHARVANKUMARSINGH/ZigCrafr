//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_item
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The item file: JSON with the model, its attachment and its texture (a
//! base64 PNG), checked against the limits below when read.

// use crate::pose::{Pose, pose_matrix};
// use serde::Deserialize;

/// The item file's version.
pub const FORMAT: u32 = 1;
/// Vertices one item may draw (4 per face): 21 boxes. A player's own
/// model and its outer layer are 288.
pub const MAX_VERTICES: usize = 512;
/// The largest texture side: an item's texture fits one skin slot of the
/// game's atlas.
pub const MAX_TEXTURE: u32 = 64;
/// Parts per item, the attachment's root not counted.
pub const MAX_PARTS: usize = 16;
/// How far (pixels, 1/16 block) any vertex may reach from the bone's pivot
/// at rest, animations included: an item stays near its wearer.
pub const MAX_REACH: f32 = 24.0;
/// The largest side of a name tag's mark (square, drawn before the name).
pub const MAX_MARK: u32 = 16;

/// Where an item is worn: one item per slot.
pub const Slot = enum {
    Head,
    Back,
    Shoulder,
    /// Over the body: a shirt, its sleeves on the arms (top-level parts may ride another bone,
    /// `Part`'s `bone` in the file).
    Torso,
    /// A name tag style: no model, a square mark drawn before the player's
    /// name and a line under it (`Item::tag`).
    NameTag,
    /// An emote: not worn, played (`Item::emote`); its parts are props.
    Emote,
    /// A small creature or object floating beside the player (`Item::companion`): on no bone,
    /// so it goes with a shoulder pet.
    Companion,
    /// Particles left behind while the player moves (`Item::trail`): no model.
    Trail,
    /// A see-through model around the feet or the body (`Item::aura`).
    Aura,
};

    // rust: impl Slot {
    /// A trail or an aura: what "Hide other players' trails and auras" hides.
pub fn is_effect(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Slot::Trail | Slot::Aura)
}
}

/// The part of the player model an item follows.
pub const Bone = enum {
    Head,
    Body,
    LeftArm,
    RightArm,
    LeftLeg,
    RightLeg,
};

    // rust: impl Bone {
    /// The part's name in the player model.
pub fn part(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Bone::Head => "head",
    // rust: Bone::Body => "body",
    // rust: Bone::LeftArm => "left_arm",
    // rust: Bone::RightArm => "right_arm",
    // rust: Bone::LeftLeg => "left_leg",
    // rust: Bone::RightLeg => "right_leg",
}
}

    /// The part's pivot in the player model at rest (pixels, y down): vanilla `PlayerModel`'s,
    /// with the wide arms (a slim skin's sit half a pixel lower).
pub fn rest(self: *Self) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = match self {
    // rust: Bone::Head | Bone::Body => [0.0, 0.0, 0.0],
    // rust: Bone::LeftArm => [5.0, 2.0, 0.0],
    // rust: Bone::RightArm => [-5.0, 2.0, 0.0],
    // rust: Bone::LeftLeg => [1.9, 12.0, 0.0],
    // rust: Bone::RightLeg => [-1.9, 12.0, 0.0],
}
    // rust: glam::Vec3::new(x, y, z)
}
}

pub const Axis = enum {
    X,
    Y,
    Z,
};

pub const Motion = enum {
    /// Turns back and forth: `amplitude` degrees about the axis.
    Swing,
    /// Moves back and forth: `amplitude` pixels along the axis.
    Bob,
    /// Turns all the way round once per period.
    Spin,
};

/// A looping animation of one part, on top of its rest pose: a sine of
/// `period` ticks starting `phase` (a fraction of the period) in.
pub const Animation = struct {
    part: []const u8,
    motion: Motion,
    axis: Axis,
    amplitude: f32,
    period: f32,
    phase: f32,
};

/// One quad: the game's `Polygon` (model pixels, then UV in 0..1 of the
/// item's texture).
pub const Face = struct {
    normal: [f32,
    vertices: [[f32,
};

/// A part: its pose (as the game's: x, y, z in pixels, rotations in
/// radians, scales), its faces and its children.
pub const Part = struct {
    name: []const u8,
    pose: Pose,
    faces: std.ArrayList(Face),
    children: std.ArrayList(Part),
};

/// RGBA pixels, row by row.
pub const Texture = struct {
    width: u32,
    height: u32,
    rgba: std.ArrayList(u8),
};

/// A name tag style: the line drawn under the name, RGB. The mark is the
/// item's texture.
pub const Tag = struct {
    line: [u8,
};

/// A checked item. `root` is named `cosmetic` and holds the attachment as
/// its pose; the item's own parts are its children.
pub const Item = struct {
    id: []const u8,
    slot: Slot,
    bone: Bone,
    root: Part,
    texture: Texture,
    animations: std.ArrayList(Animation),
    vertices: usize,
    /// Top-level parts that ride another bone than `bone` (a shirt's sleeves on the arms), one
    /// root per bone, named `cosmetic_<bone>`, each with the item's attachment as its pose.
    limbs: Vec<(Bone,
    /// A name tag's line (`Slot::NameTag` only; it has no parts).
    tag: ?Tag,
    /// How a companion floats and follows (`Slot::Companion` only).
    companion: ?crate::Companion,
    /// What a trail leaves (`Slot::Trail` only; it has no parts).
    trail: ?crate::Trail,
    /// How an aura shows (`Slot::Aura` only).
    aura: ?crate::Aura,
    /// How high the item gets above the player model's neck (the head's and body's pivot), in
    /// pixels: its highest vertex with every bone at rest (`Bone::rest`), animations included.
    /// The game lifts its wearer's name tag over it. 0 for a name tag style (no model) and for
    /// the kinds on no bone (a companion, a trail, an aura).
    top: f32,
    /// What an emote does (`Slot::Emote` only).
    emote: ?crate::Emote,
    /// The animated parts, found once (`animate` runs every frame for every wearer).
    animated: std.ArrayList(Animated),
};

/// A part `animations` move: the index of its first animation (its name), its rest pose and
/// its animations, in the file's order.
pub const Animated = struct {
    first: usize,
    rest: Pose,
    all: std.ArrayList(usize),
};

/// Each part `animations` move, in the order of its first animation; a name no part has moves
/// nothing.
pub fn animated(roots: *[*Part], animations: *[Animation]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<Animated> = Vec::new();
    // rust: for (i, anim) in animations.iter().enumerate() {
    // rust: if let Some(a) = out
    // rust: .iter_mut()
    // rust: .find(|a| animations[a.first].part == anim.part)
    // rust: {
    // rust: a.all.push(i);
    // rust: } else if let Some(part) = roots.iter().find_map(|r| find(r, &anim.part)) {
    // rust: out.push(Animated {
    // rust: first: i,
    // rust: rest: part.pose,
    // rust: all: vec![i],
    // rust: });
}
}
    // rust: out
}

pub const Error = enum {
    Json(String),
    Format(u32),
    Texture(String),
    TooManyVertices(usize),
    TooManyParts(usize),
    TooFar(f32),
    Invalid(String),
};

    // rust: impl std::fmt::Display for Error {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Error::Json(e) => write!(f, "not an item file: {e}"),
    // rust: Error::Format(v) => write!(f, "item format {v}, this game reads {FORMAT}"),
    // rust: Error::Texture(e) => write!(f, "texture: {e}"),
    // rust: Error::TooManyVertices(n) => write!(f, "{n} vertices, at most {MAX_VERTICES}"),
    // rust: Error::TooManyParts(n) => write!(f, "{n} parts, at most {MAX_PARTS}"),
    // rust: Error::TooFar(d) => write!(
    // rust: f,
    // rust: "reaches {d:.1} pixels from its bone, at most {MAX_REACH}"
    // rust: ),
    // rust: Error::Invalid(e) => f.write_str(e),
}
}
}

    // rust: impl std::error::Error for Error {}

pub const ItemFile = struct {
    format: u32,
    id: []const u8,
    slot: Slot,
    bone: ?Bone,
    attach: AttachFile,
    /// Only an emote without props goes without.
    texture: ?TextureFile,
    parts: std.ArrayList(PartFile),
    animations: std.ArrayList(Animation),
    tag: ?TagFile,
    emote: ?crate::emote::EmoteFile,
    companion: ?crate::fx::CompanionFile,
    trail: ?crate::fx::TrailFile,
    aura: ?crate::fx::AuraFile,
};

pub const TagFile = struct {
    line: []const u8,
};

/// `#rrggbb`.
pub fn colour(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hex = text.strip_prefix('#').filter(|h| h.len() == 6)?;
    // rust: let byte = |i: usize| u8::from_str_radix(hex.get(i..i + 2)?, 16).ok();
    // rust: Some([byte(0)?, byte(2)?, byte(4)?])
}

pub const AttachFile = struct {
    offset: [f32,
    rotation: [f32,
    scale: f32,
};

    // rust: impl Default for AttachFile {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: offset: [0.0; 3],
    // rust: rotation: [0.0; 3],
    // rust: scale: 1.0,
}
}
}

pub fn one() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1.0
}

pub const TextureFile = struct {
    png: []const u8,
};

pub const PartFile = struct {
    name: []const u8,
    /// A top-level part only: the bone it rides, if not the item's.
    bone: ?Bone,
    pivot: [f32,
    /// Degrees.
    rotation: [f32,
    cubes: std.ArrayList(CubeFile),
    children: std.ArrayList(PartFile),
};

pub const CubeFile = struct {
    origin: [f32,
    size: [f32,
    uv: [f32,
    inflate: f32,
    mirror: bool,
};

pub fn invalid(text: impl Into<[]const u8>) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Error::Invalid(text.into())
}

pub fn finite(values: *[f32], what: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if values.iter().all(|v| v.is_finite()) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(invalid(format!("{what} is not a number")))
}
}

    // rust: impl Item {
    /// Reads and checks an item file.
pub fn parse(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file: ItemFile =
    // rust: serde_json::from_slice(bytes).map_err(|e| Error::Json(e.to_string()))?;
    // rust: if file.format != FORMAT {
    // rust: return Err(Error::Format(file.format));
}
    // rust: if file.id.is_empty()
    // rust: || file.id.len() > 64
    // rust: || !file
    // rust: .id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')
    // rust: {
    // rust: return Err(invalid("the id is 1 to 64 of a-z, 0-9 and _"));
}
    // rust: let texture = match (&file.texture, file.slot) {
    // rust: (Some(t), _) => decode_png(&t.png)?,
            // Nothing is drawn from it: no skin slot is taken.
    // rust: (None, Slot::Emote) if file.parts.is_empty() => Texture {
    // rust: width: 1,
    // rust: height: 1,
    // rust: rgba: vec![0; 4],
    // rust: },
    // rust: (None, _) => return Err(Error::Texture("no texture".into())),
}
    // rust: let tag = match (file.slot, &file.tag) {
    // rust: (Slot::NameTag, Some(t)) => {
    // rust: if !file.parts.is_empty() || !file.animations.is_empty() {
    // rust: return Err(invalid("a name tag has no parts or animations"));
}
    // rust: if texture.width != texture.height || texture.width > MAX_MARK {
    // rust: return Err(Error::Texture(format!(
    // rust: "a name tag's mark is square, at most {MAX_MARK}x{MAX_MARK}"
    // rust: )));
}
    // rust: let line = colour(&t.line).ok_or_else(|| invalid("tag.line is #rrggbb"))?;
    // rust: Some(Tag { line })
}
    // rust: (Slot::NameTag, None) => return Err(invalid("a name tag needs its tag")),
    // rust: (_, Some(_)) => return Err(invalid("only a name tag has a tag")),
    // rust: (_, None) => None,
}
    // rust: let on_bone = !matches!(file.slot, Slot::Companion | Slot::Trail | Slot::Aura);
    // rust: if !on_bone && file.bone.is_some() {
    // rust: return Err(invalid("a companion, a trail or an aura rides no bone"));
}
    // rust: let trail = match (file.slot, file.trail) {
    // rust: (Slot::Trail, Some(t)) => {
    // rust: if !file.parts.is_empty() || !file.animations.is_empty() {
    // rust: return Err(invalid("a trail has no parts or animations"));
}
    // rust: Some(t.check(texture.width, texture.height)?)
}
    // rust: (Slot::Trail, None) => return Err(invalid("a trail needs its trail")),
    // rust: (_, Some(_)) => return Err(invalid("only a trail has a trail")),
    // rust: (_, None) => None,
}
    // rust: if file.slot == Slot::Companion && file.companion.is_none() {
    // rust: return Err(invalid("a companion needs its companion"));
}
    // rust: if file.slot == Slot::Aura && file.aura.is_none() {
    // rust: return Err(invalid("an aura needs its aura"));
}
    // rust: if (file.slot != Slot::Companion && file.companion.is_some())
    // rust: || (file.slot != Slot::Aura && file.aura.is_some())
    // rust: {
    // rust: return Err(invalid("only a companion has a companion, an aura an aura"));
}
    // rust: let bone = file.bone.unwrap_or_default();
    // rust: let a = &file.attach;
    // rust: finite(&a.offset, "attach.offset")?;
    // rust: finite(&a.rotation, "attach.rotation")?;
    // rust: if !(a.scale > 0.0 && a.scale <= 2.0) {
    // rust: return Err(invalid("attach.scale is above 0 and at most 2"));
}
    // rust: let [rx, ry, rz] = a.rotation.map(f32::to_radians);
    // rust: let pose = [
    // rust: a.offset[0],
    // rust: a.offset[1],
    // rust: a.offset[2],
    // rust: rx,
    // rust: ry,
    // rust: rz,
    // rust: a.scale,
    // rust: a.scale,
    // rust: a.scale,
    // rust: ];
    // rust: let size = [texture.width as f32, texture.height as f32];
    // rust: let mut names = Vec::new();
    // rust: let mut children = Vec::new();
    // rust: let mut limbs: Vec<(Bone, Part)> = Vec::new();
    // rust: for p in &file.parts {
    // rust: let part = bake(p, size, &mut names, true)?;
    // rust: if !on_bone && p.bone.is_some() {
    // rust: return Err(invalid(format!("{:?} rides no bone: no part does", p.name)));
}
    // rust: match p.bone.filter(|b| *b != bone) {
    // rust: None => children.push(part),
    // rust: Some(bone) => match limbs.iter_mut().find(|(b, _)| *b == bone) {
    // rust: Some((_, limb)) => limb.children.push(part),
    // rust: None => limbs.push((
    // rust: bone,
    // rust: Part {
    // rust: name: format!("cosmetic_{}", bone.part()),
    // rust: pose,
    // rust: faces: Vec::new(),
    // rust: children: vec![part],
    // rust: },
    // rust: )),
    // rust: },
}
}
    // rust: if names.len() > MAX_PARTS {
    // rust: return Err(Error::TooManyParts(names.len()));
}
    // rust: let emote = match (file.slot, file.emote) {
    // rust: (Slot::Emote, Some(e)) => Some(e.check(&names)?),
    // rust: (Slot::Emote, None) => return Err(invalid("an emote needs its emote")),
    // rust: (_, Some(_)) => return Err(invalid("only an emote has an emote")),
    // rust: (_, None) => None,
}
    // rust: let root = Part {
    // rust: name: "cosmetic".into(),
    // rust: pose,
    // rust: faces: Vec::new(),
    // rust: children,
}
    // rust: let vertices = count(&root) + limbs.iter().map(|(_, l)| count(l)).sum::<usize>();
    // rust: if vertices > MAX_VERTICES {
    // rust: return Err(Error::TooManyVertices(vertices));
}
    // rust: for anim in &file.animations {
    // rust: finite(&[anim.amplitude, anim.period, anim.phase], "an animation")?;
    // rust: if !names.contains(&anim.part) {
    // rust: return Err(invalid(format!(
    // rust: "an animation moves no part {:?}",
    // rust: anim.part
    // rust: )));
}
    // rust: let limit = match anim.motion {
    // rust: Motion::Swing => 45.0,
    // rust: Motion::Bob => 4.0,
    // rust: Motion::Spin => 0.0,
}
    // rust: if anim.amplitude.abs() > limit || anim.period < 4.0 || anim.period > 1200.0 {
    // rust: return Err(invalid(format!(
    // rust: "the animation of {:?} is out of bounds",
    // rust: anim.part
    // rust: )));
}
}
    // rust: let mut roots = vec![&root];
    // rust: roots.extend(limbs.iter().map(|(_, l)| l));
    // rust: let animated = animated(&roots, &file.animations);
    // rust: let item = Item {
    // rust: id: file.id,
    // rust: slot: file.slot,
    // rust: bone,
    // rust: root,
    // rust: texture,
    // rust: animations: file.animations,
    // rust: vertices,
    // rust: limbs,
    // rust: tag,
    // rust: top: 0.0,
    // rust: emote,
    // rust: companion: None,
    // rust: trail,
    // rust: aura: None,
    // rust: animated,
}
    // rust: let extent = item.extent();
    // rust: let companion = match file.companion {
    // rust: Some(c) => Some(c.check(&names, extent.reach)?),
    // rust: None if extent.reach > MAX_REACH => return Err(Error::TooFar(extent.reach)),
    // rust: None => None,
}
    // rust: let aura = match file.aura {
    // rust: Some(a) => Some(a.check(extent.low, extent.high)?),
    // rust: None => None,
}
    // rust: let top = if on_bone { extent.top } else { 0.0 };
    // rust: Ok(Item {
    // rust: top,
    // rust: companion,
    // rust: aura,
    // rust: ..item
    // rust: })
}

    /// The item's roots and the bone each rides: `root` on `bone`, then the `limbs`.
pub fn roots(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::iter::once((self.bone, &self.root)).chain(self.limbs.iter().map(|(b, p)| (*b, p)))
}

    /// The farthest any vertex gets from its bone's pivot, the highest above the neck with the
    /// bones at rest, and the box around every vertex in the root's space (pixels): at rest, at
    /// 32 points of each animation's period, and through an emote's props' keys.
pub fn extent(self: *Self) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut times = vec![0.0];
    // rust: for anim in &self.animations {
    // rust: times.extend((0..32).map(|k| anim.period * k as f32 / 32.0));
}
    // rust: if let Some(emote) = &self.emote {
    // rust: times.extend(emote.sample_times());
}
    // rust: let mut far = 0.0_f32;
    // rust: let mut top = 0.0_f32;
    // rust: let (mut low, mut high) = (glam::Vec3::splat(f32::MAX), glam::Vec3::splat(f32::MIN));
    // rust: let mut poses = std::collections::HashMap::new();
    // rust: for ticks in times {
    // rust: poses.clear();
    // rust: self.animate(ticks, |name, pose| {
    // rust: poses.insert(name.to_owned(), pose);
    // rust: });
    // rust: if let Some(emote) = &self.emote {
    // rust: let mut props = Vec::new();
    // rust: emote.pose_props(
    // rust: ticks,
    // rust: |name| self.rest(name),
    // rust: |name, pose| props.push((name.to_owned(), pose)),
    // rust: );
    // rust: poses.extend(props);
}
    // rust: for (bone, root) in self.roots() {
    // rust: let pivot = bone.rest();
    // rust: walk(root, glam::Mat4::IDENTITY, &poses, &mut |p| {
    // rust: far = far.max(p.length() * 16.0);
                    // y points down.
    // rust: top = top.max(-(pivot.y + p.y * 16.0));
    // rust: low = low.min(p * 16.0);
    // rust: high = high.max(p * 16.0);
    // rust: });
}
}
    // rust: if low.x > high.x {
    // rust: (low, high) = (glam::Vec3::ZERO, glam::Vec3::ZERO);
}
    // rust: Extent {
    // rust: reach: far,
    // rust: top,
    // rust: low,
    // rust: high,
}
}

    /// The rest pose of the part named `name`.
pub fn rest(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.roots()
    // rust: .find_map(|(_, r)| find(r, name))
    // rust: .map(|p| p.pose)
}

    /// The animated parts' poses at `ticks` (game ticks, any start): each
    /// is the part's rest pose with its animations added.
pub fn animate(self: *Self, ticks: f32, mut set: impl FnMut([]const u8) void {
}
    // rust: for part in &self.animated {
    // rust: let mut pose = part.rest;
    // rust: for a in part.all.iter().map(|&i| &self.animations[i]) {
    // rust: let turns = ticks / a.period + a.phase;
    // rust: let axis = a.axis as usize;
    // rust: match a.motion {
    // rust: Motion::Swing => {
    // rust: let wave = (turns * std::f32::consts::TAU).sin();
    // rust: pose[3 + axis] += (a.amplitude * wave).to_radians();
}
    // rust: Motion::Bob => {
    // rust: pose[axis] += a.amplitude * (turns * std::f32::consts::TAU).sin();
}
    // rust: Motion::Spin => {
    // rust: pose[3 + axis] += turns.rem_euclid(1.0) * std::f32::consts::TAU;
}
}
}
    // rust: set(&self.animations[part.first].part, pose);
}
}
}

/// What `Item::extent` finds (pixels).
pub const Extent = struct {
    reach: f32,
    top: f32,
    low: glam::Vec3,
    high: glam::Vec3,
};

/// Every vertex of `part`'s subtree under `parent`, as posed by `poses`
/// (else the parts' rest poses), in blocks.
    // rust: fn walk(
    // rust: part: &Part,
    // rust: parent: glam::Mat4,
    // rust: poses: &std::collections::HashMap<String, Pose>,
    // rust: each: &mut impl FnMut(glam::Vec3),
    // rust: ) {
    // rust: let m = parent * pose_matrix(*poses.get(&part.name).unwrap_or(&part.pose));
    // rust: for face in &part.faces {
    // rust: for v in face.vertices {
    // rust: each(m.transform_point3(glam::Vec3::new(v[0], v[1], v[2]) / 16.0));
}
}
    // rust: for child in &part.children {
    // rust: walk(child, m, poses, each);
}
}

    // rust: fn find<'a>(part: &'a Part, name: &str) -> Option<&'a Part> {
    // rust: if part.name == name {
    // rust: return Some(part);
}
    // rust: part.children.iter().find_map(|c| find(c, name))
}

pub fn count(part: *Part) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: part.faces.len() * 4 + part.children.iter().map(count).sum::<usize>()
}

    // rust: fn bake(
    // rust: file: &PartFile,
    // rust: size: [f32; 2],
    // rust: names: &mut Vec<String>,
    // rust: top: bool,
    // rust: ) -> Result<Part, Error> {
    // rust: if file.name.is_empty() || file.name.starts_with("cosmetic") || names.contains(&file.name) {
    // rust: return Err(invalid(format!("part names are unique: {:?}", file.name)));
}
    // rust: if !top && file.bone.is_some() {
    // rust: return Err(invalid(format!(
    // rust: "only a top-level part rides its own bone: {:?}",
    // rust: file.name
    // rust: )));
}
    // rust: names.push(file.name.clone());
    // rust: finite(&file.pivot, "a pivot")?;
    // rust: finite(&file.rotation, "a rotation")?;
    // rust: let mut faces = Vec::new();
    // rust: for cube in &file.cubes {
    // rust: finite(&cube.origin, "a cube")?;
    // rust: finite(&cube.size, "a cube")?;
    // rust: finite(&cube.uv, "a cube")?;
    // rust: if cube.size.iter().any(|s| *s < 0.0) || !(0.0..=4.0).contains(&cube.inflate) {
    // rust: return Err(invalid("a cube's size is negative"));
}
    // rust: let [w, h, d] = cube.size;
        // Box UV: the unfolded box spans 2(d + w) by d + h texels.
    // rust: if cube.uv[0] < 0.0
    // rust: || cube.uv[1] < 0.0
    // rust: || cube.uv[0] + 2.0 * (d + w) > size[0]
    // rust: || cube.uv[1] + d + h > size[1]
    // rust: {
    // rust: return Err(invalid("a cube's UV leaves the texture"));
}
    // rust: faces.extend(box_faces(cube, size));
}
    // rust: let [rx, ry, rz] = file.rotation.map(f32::to_radians);
    // rust: let [x, y, z] = file.pivot;
    // rust: let children = file
    // rust: .children
    // rust: .iter()
    // rust: .map(|c| bake(c, size, names, false))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: Ok(Part {
    // rust: name: file.name.clone(),
    // rust: pose: [x, y, z, rx, ry, rz, 1.0, 1.0, 1.0],
    // rust: faces,
    // rust: children,
    // rust: })
}

/// `box_faces` of a box given field by field.
    // rust: pub(crate) fn cube_faces(
    // rust: origin: [f32; 3],
    // rust: size: [f32; 3],
    // rust: uv: [f32; 2],
    // rust: inflate: f32,
    // rust: mirror: bool,
    // rust: texture: [f32; 2],
    // rust: ) -> Vec<Face> {
    // rust: let cube = CubeFile {
    // rust: origin,
    // rust: size,
    // rust: uv,
    // rust: inflate,
    // rust: mirror,
}
    // rust: box_faces(&cube, texture)
}

/// `ModelPart.Cube`: six faces with box UV, in vanilla's order (down, up,
/// west, north, east, south), grown by `inflate`, mirrored in x on request.
pub fn box_faces(cube: *CubeFile, th]: [f32; 2]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [w, h, d] = cube.size;
    // rust: let g = cube.inflate;
    // rust: let (mut x0, y0, z0) = (cube.origin[0] - g, cube.origin[1] - g, cube.origin[2] - g);
    // rust: let (mut x1, y1, z1) = (
    // rust: cube.origin[0] + w + g,
    // rust: cube.origin[1] + h + g,
    // rust: cube.origin[2] + d + g,
    // rust: );
    // rust: if cube.mirror {
    // rust: std::mem::swap(&mut x0, &mut x1);
}
    // rust: let t0 = [x0, y0, z0];
    // rust: let t1 = [x1, y0, z0];
    // rust: let t2 = [x1, y1, z0];
    // rust: let t3 = [x0, y1, z0];
    // rust: let l0 = [x0, y0, z1];
    // rust: let l1 = [x1, y0, z1];
    // rust: let l2 = [x1, y1, z1];
    // rust: let l3 = [x0, y1, z1];
    // rust: let [u, v] = cube.uv;
    // rust: let (u1, u2, u22) = (u + d, u + d + w, u + d + w + w);
    // rust: let (u3, u4) = (u + d + w + d, u + d + w + d + w);
    // rust: let (v1, v2) = (v + d, v + d + h);
    // rust: let faces: [([[f32; 3]; 4], [f32; 4], [f32; 3]); 6] = [
    // rust: ([l1, l0, t0, t1], [u1, v, u2, v1], [0.0, -1.0, 0.0]),
    // rust: ([t2, t3, l3, l2], [u2, v1, u22, v], [0.0, 1.0, 0.0]),
    // rust: ([t0, l0, l3, t3], [u, v1, u1, v2], [-1.0, 0.0, 0.0]),
    // rust: ([t1, t0, t3, t2], [u1, v1, u2, v2], [0.0, 0.0, -1.0]),
    // rust: ([l1, t1, t2, l2], [u2, v1, u3, v2], [1.0, 0.0, 0.0]),
    // rust: ([l0, l1, l2, l3], [u3, v1, u4, v2], [0.0, 0.0, 1.0]),
    // rust: ];
    // rust: faces
    // rust: .into_iter()
    // rust: .map(|(corners, [a, b, c, e], mut normal)| {
            // Polygon's remap: (u1, v0), (u0, v0), (u0, v1), (u1, v1).
    // rust: let uvs = [[c, b], [a, b], [a, e], [c, e]];
    // rust: let mut vertices: [[f32; 5]; 4] = std::array::from_fn(|i| {
    // rust: let [x, y, z] = corners[i];
    // rust: [x, y, z, uvs[i][0] / tw, uvs[i][1] / th]
    // rust: });
    // rust: if cube.mirror {
    // rust: vertices.reverse();
    // rust: normal[0] = -normal[0];
}
    // rust: Face { normal, vertices }
    // rust: })
    // rust: .collect()
}

pub fn decode_png(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use base64::Engine;
    // rust: let bytes = base64::engine::general_purpose::STANDARD
    // rust: .decode(text)
    // rust: .map_err(|e| Error::Texture(e.to_string()))?;
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(bytes));
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder
    // rust: .read_info()
    // rust: .map_err(|e| Error::Texture(e.to_string()))?;
    // rust: let (width, height) = (reader.info().width, reader.info().height);
    // rust: if width == 0 || height == 0 || width > MAX_TEXTURE || height > MAX_TEXTURE {
    // rust: return Err(Error::Texture(format!(
    // rust: "{width}x{height}, at most {MAX_TEXTURE}x{MAX_TEXTURE}"
    // rust: )));
}
    // rust: let mut buf = vec![0; reader.output_buffer_size().unwrap_or(0)];
    // rust: let frame = reader
    // rust: .next_frame(&mut buf)
    // rust: .map_err(|e| Error::Texture(e.to_string()))?;
    // rust: let pixels = &buf[..frame.buffer_size()];
    // rust: let rgba = match frame.color_type {
    // rust: png::ColorType::Rgba => pixels.to_vec(),
    // rust: png::ColorType::Rgb => pixels
    // rust: .chunks(3)
    // rust: .flat_map(|p| [p[0], p[1], p[2], 255])
    // rust: .collect(),
    // rust: png::ColorType::GrayscaleAlpha => pixels
    // rust: .chunks(2)
    // rust: .flat_map(|p| [p[0], p[0], p[0], p[1]])
    // rust: .collect(),
    // rust: png::ColorType::Grayscale => pixels.iter().flat_map(|&g| [g, g, g, 255]).collect(),
    // rust: png::ColorType::Indexed => return Err(Error::Texture("unexpanded palette".into())),
}
    // rust: Ok(Texture {
    // rust: width,
    // rust: height,
    // rust: rgba,
    // rust: })
}
