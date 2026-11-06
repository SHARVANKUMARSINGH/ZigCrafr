//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_preview
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A picture of a player wearing items, drawn on the CPU (the launcher's Wardrobe): the player
//! model with its skin, at rest or posed, each item on its bone, seen from any angle and distance
//! (`Camera`). The Wardrobe's live view draws it again only when something changes
//! (`crate::viewer`). A companion floats at its anchor, an aura sits at the feet see-through, and
//! a trail shows as a few of its particles left behind.

// use crate::item::cube_faces;
// use crate::{Face, Item, Part, Slot, Texture, pose_matrix};
// use glam::{Mat4, Vec3, Vec4Swizzles};
// use std::borrow::Cow;

/// RGBA pixels, row by row, straight alpha.
pub const Image = struct {
    width: u32,
    height: u32,
    rgba: std.ArrayList(u8),
};

/// The player model's parts at rest, as vanilla's `PlayerModel` lays them out on a 64×64 skin:
/// each body part with its outer layer (`hat`, `jacket`, sleeves, pants) as a child. `slim` is the
/// three-pixel-wide arms of a slim skin.
pub fn player_model(slim: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tex = [64.0, 64.0];
    // rust: let part = |name: &str, pivot: [f32; 3], origin, size, uv, outer: (&str, [f32; 2], f32)| Part {
    // rust: name: name.into(),
    // rust: pose: [pivot[0], pivot[1], pivot[2], 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: faces: cube_faces(origin, size, uv, 0.0, false, tex),
    // rust: children: vec![Part {
    // rust: name: outer.0.into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: faces: cube_faces(origin, size, outer.1, outer.2, false, tex),
    // rust: children: Vec::new(),
    // rust: }],
}
    // rust: let (arm, arm_y, right_x) = if slim {
    // rust: ([3.0, 12.0, 4.0], 2.5, -2.0)
    // rust: } else {
    // rust: ([4.0, 12.0, 4.0], 2.0, -3.0)
}
    // rust: let leg = [4.0, 12.0, 4.0];
    // rust: Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: faces: Vec::new(),
    // rust: children: vec![
    // rust: part(
    // rust: "head",
    // rust: [0.0; 3],
    // rust: [-4.0, -8.0, -4.0],
    // rust: [8.0; 3],
    // rust: [0.0, 0.0],
    // rust: ("hat", [32.0, 0.0], 0.5),
    // rust: ),
    // rust: part(
    // rust: "body",
    // rust: [0.0; 3],
    // rust: [-4.0, 0.0, -2.0],
    // rust: [8.0, 12.0, 4.0],
    // rust: [16.0, 16.0],
    // rust: ("jacket", [16.0, 32.0], 0.25),
    // rust: ),
    // rust: part(
    // rust: "right_arm",
    // rust: [-5.0, arm_y, 0.0],
    // rust: [right_x, -2.0, -2.0],
    // rust: arm,
    // rust: [40.0, 16.0],
    // rust: ("right_sleeve", [40.0, 32.0], 0.25),
    // rust: ),
    // rust: part(
    // rust: "left_arm",
    // rust: [5.0, arm_y, 0.0],
    // rust: [-1.0, -2.0, -2.0],
    // rust: arm,
    // rust: [32.0, 48.0],
    // rust: ("left_sleeve", [48.0, 48.0], 0.25),
    // rust: ),
    // rust: part(
    // rust: "right_leg",
    // rust: [-1.9, 12.0, 0.0],
    // rust: [-2.0, 0.0, -2.0],
    // rust: leg,
    // rust: [0.0, 16.0],
    // rust: ("right_pants", [0.0, 32.0], 0.25),
    // rust: ),
    // rust: part(
    // rust: "left_leg",
    // rust: [1.9, 12.0, 0.0],
    // rust: [-2.0, 0.0, -2.0],
    // rust: leg,
    // rust: [16.0, 48.0],
    // rust: ("left_pants", [0.0, 48.0], 0.25),
    // rust: ),
    // rust: ],
}
}

/// The matrix of the part named `name` under `parent`, at rest.
pub fn rest_matrix(part: *Part, parent: Mat4, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: posed_matrix(part, parent, name, &[])
}

/// The matrix of the part named `name` under `parent`, its parts posed by `poses` (name → pose;
/// the rest at rest).
    // rust: pub fn posed_matrix(
    // rust: part: &Part,
    // rust: parent: Mat4,
    // rust: name: &str,
    // rust: poses: &[(String, crate::Pose)],
    // rust: ) -> Option<Mat4> {
    // rust: let m = parent * pose_matrix(pose_of(part, poses));
    // rust: if part.name == name {
    // rust: return Some(m);
}
    // rust: part.children
    // rust: .iter()
    // rust: .find_map(|c| posed_matrix(c, m, name, poses))
}

pub fn pose_of(part: *Part, poses: *[([]const u8, crate: :Pose) void {
}
    // rust: poses
    // rust: .iter()
    // rust: .find(|(n, _)| *n == part.name)
    // rust: .map_or(part.pose, |(_, p)| *p)
}

/// Where the picture looks at the player from: turned `yaw` degrees (0 shows the front), from
/// `pitch` degrees above (below when negative), `zoom` times closer. At zoom 1 the whole player
/// fits, 3 blocks to the picture's height, with room above the head for tall hats and back items;
/// closer, the view centres on the head, wholly at `MAX_ZOOM`.
pub const Camera = struct {
    yaw: f32,
    pitch: f32,
    zoom: f32,
};

    // rust: impl Camera {
    /// Where the view starts and goes back to: a little turned, a little from above.
    // rust: pub const HOME: Camera = Camera {
    // rust: yaw: 30.0,
    // rust: pitch: 10.0,
    // rust: zoom: 1.0,
}
pub const MAX_ZOOM: f32 = 3.0;
    /// How far up and down the view tilts, in degrees.
pub const MAX_PITCH: f32 = 60.0;
pub const MIN_PITCH: f32 = -30.0;
    /// Degrees turned per point dragged.
pub const DRAG: f32 = 0.6;
    /// How much closer one step of the scroll wheel comes.
pub const ZOOM_STEP: f32 = 1.15;

    /// Dragged by `dx`, `dy` points, as if the pointer held the player: right turns the front
    /// to the right, down tips the head toward the viewer.
pub fn dragged(self: *Self, dx: f32, dy: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: yaw: (self.yaw - dx * Self::DRAG).rem_euclid(360.0),
    // rust: pitch: (self.pitch + dy * Self::DRAG).clamp(Self::MIN_PITCH, Self::MAX_PITCH),
    // rust: zoom: self.zoom,
}
}

    /// `steps` of the scroll wheel closer (farther when negative), from 1 to `MAX_ZOOM`.
pub fn zoomed(self: *Self, steps: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: zoom: (self.zoom * Self::ZOOM_STEP.powf(steps)).clamp(1.0, Self::MAX_ZOOM),
    // rust: ..self
}
}

    /// Model space (blocks, y down, the front at -z, the body's pivot at 0) to the picture's
    /// pixels, `width`×`height`, depth growing away from the viewer.
pub fn view(self: *Self, width: u32, height: u32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let scale = height as f32 / 3.0 * self.zoom;
        // The head's top is 0.5 blocks above the body's pivot and the feet 1.5 below. At zoom 1
        // the picture's middle is 0.4 below the pivot (a fifth of the picture above the head),
        // at `MAX_ZOOM` the head's centre, 0.25 above.
    // rust: let near = ((self.zoom - 1.0) / (Self::MAX_ZOOM - 1.0)).clamp(0.0, 1.0);
    // rust: let focus = 0.4 + (-0.25 - 0.4) * near;
    // rust: Mat4::from_translation(Vec3::new(width as f32 / 2.0, height as f32 / 2.0, 0.0))
    // rust: * Mat4::from_scale(Vec3::splat(scale))
    // rust: * Mat4::from_rotation_x(self.pitch.to_radians())
    // rust: * Mat4::from_rotation_y(self.yaw.to_radians())
    // rust: * Mat4::from_translation(Vec3::new(0.0, -focus, 0.0))
}
}

/// One model to draw: its root under `base` (model space, blocks), its parts posed by
/// `poses` (name → pose; the rest at rest), at `alpha` (1: solid, cut out as entities are).
pub const Draw = struct {
    root: Cow<'a,
    base: Mat4,
    texture: *'a Texture,
    poses: Vec<([]const u8,
    alpha: f32,
};

    // rust: impl<'a> Draw<'a> {
    /// `root` at rest, solid, where it is: the player model with its skin, say.
pub fn model(root: *'a Part, texture: *'a Texture) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: root: Cow::Borrowed(root),
    // rust: base: Mat4::IDENTITY,
    // rust: texture,
    // rust: poses: Vec::new(),
    // rust: alpha: 1.0,
}
}

    /// `item` on the player model `body`, at `ticks` of its animations: one draw per bone it
    /// rides (a shirt's sleeves are on the arms); a companion at its anchor, an aura at the feet,
    /// a trail as particles left behind.
pub fn item(item: *'a Item, body: *Part, ticks: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::item_posed(item, body, &[], ticks)
}

    /// `item` on the player model `body` posed by `body_poses` (an emote), at `ticks` of its
    /// animations: each draw follows its bone as posed.
    // rust: pub fn item_posed(
    // rust: item: &'a Item,
    // rust: body: &Part,
    // rust: body_poses: &[(String, crate::Pose)],
    // rust: ticks: f32,
    // rust: ) -> Vec<Self> {
    // rust: let mut poses = Vec::new();
    // rust: item.animate(ticks, |name, pose| poses.push((name.to_owned(), pose)));
    // rust: let at = |base: Mat4, alpha: f32| Self {
    // rust: root: Cow::Borrowed(&item.root),
    // rust: base,
    // rust: texture: &item.texture,
    // rust: poses: poses.clone(),
    // rust: alpha,
}
    // rust: match item.slot {
    // rust: Slot::Companion => {
    // rust: let anchor = item.companion.as_ref().map_or([0.0; 3], |c| c.anchor);
    // rust: return vec![at(Mat4::from_translation(Vec3::from(anchor) / 16.0), 1.0)];
}
    // rust: Slot::Aura => {
    // rust: let alpha = item.aura.as_ref().map_or(1.0, |a| a.alpha);
                // The middle of the feet: 24 pixels under the neck.
    // rust: return vec![at(Mat4::from_translation(Vec3::Y * 1.5), alpha)];
}
    // rust: Slot::Trail => {
    // rust: return trail_part(item)
    // rust: .map(|root| Self {
    // rust: root: Cow::Owned(root),
    // rust: base: Mat4::IDENTITY,
    // rust: texture: &item.texture,
    // rust: poses: Vec::new(),
    // rust: alpha: 1.0,
    // rust: })
    // rust: .into_iter()
    // rust: .collect();
}
    // rust: _ => {}
}
    // rust: item.roots()
    // rust: .filter_map(|(bone, root)| {
    // rust: Some(Self {
    // rust: root: Cow::Borrowed(root),
    // rust: base: posed_matrix(body, Mat4::IDENTITY, bone.part(), body_poses)?,
    // rust: texture: &item.texture,
    // rust: poses: poses.clone(),
    // rust: alpha: 1.0,
    // rust: })
    // rust: })
    // rust: .collect()
}
}

/// A trail as a still shows it: fourteen of its particles left behind a player walking forward, as
/// cards facing the front, each older one farther back, fallen (or risen) as far as its age
/// says and smaller as it fades.
pub fn trail_part(item: *Item) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = item.trail.as_ref()?;
    // rust: let n = 14;
    // rust: let hash = |k: u32| ((k.wrapping_mul(2_654_435_761) >> 8) & 0xFFFF) as f32 / 65535.0;
    // rust: let spacing = (16.0 / t.rate).min(2.2);
    // rust: let ground = match t.from {
    // rust: crate::From::Feet => 22.4,
    // rust: crate::From::Body => 9.6,
}
    // rust: let faces = (0..n)
    // rust: .map(|k| {
    // rust: let life = t.lifetime as f32;
    // rust: let age = (k as f32 + 0.5) / n as f32 * life;
    // rust: let side = if k % 2 == 0 { 1.0 } else { -1.0 };
    // rust: let x = side * (2.0 + 3.0 * hash(k)) + t.drift * (age * 0.2 + k as f32).sin();
    // rust: let y = (ground + 0.5 * t.gravity * age * age * 16.0).min(24.0);
    // rust: let z = 3.0 + k as f32 * spacing;
    // rust: let mut size = t.size[0] + (t.size[1] - t.size[0]) * hash(k + 7);
    // rust: if t.fade {
    // rust: size *= (3.0 * (1.0 - age / life)).clamp(0.2, 1.0);
}
    // rust: let h = size / 2.0;
    // rust: let sprite = (k % t.sprites) as f32;
    // rust: let (u0, u1) = (sprite / t.sprites as f32, (sprite + 1.0) / t.sprites as f32);
    // rust: Face {
    // rust: normal: [0.0, 0.0, -1.0],
    // rust: vertices: [
    // rust: [x + h, y - h, z, u1, 0.0],
    // rust: [x - h, y - h, z, u0, 0.0],
    // rust: [x - h, y + h, z, u0, 1.0],
    // rust: [x + h, y + h, z, u1, 1.0],
    // rust: ],
}
    // rust: })
    // rust: .collect();
    // rust: Some(Part {
    // rust: name: "trail".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: faces,
    // rust: children: Vec::new(),
    // rust: })
}

/// Draws `draws` into a `width`×`height` picture seen from `camera`. At `Camera::HOME`'s zoom
/// the head's top is a fifth of the way down (room for a hat) and the feet 13% up.
pub fn render(draws: *[Draw], width: u32, height: u32, camera: *Camera) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = (width as usize, height as usize);
    // rust: let mut rgba = vec![0u8; w * h * 4];
    // rust: let mut depth = vec![f32::INFINITY; w * h];
    // Model space has y down and the front at -z: the camera looks along +z from the front.
    // rust: let view = camera.view(width, height);
    // Solid first; see-through over them, unsorted (an aura is one thin layer).
    // rust: let solid = draws.iter().filter(|d| d.alpha >= 1.0);
    // rust: for d in solid.chain(draws.iter().filter(|d| d.alpha < 1.0)) {
    // rust: let mut stack = vec![(&*d.root, d.base)];
    // rust: while let Some((part, parent)) = stack.pop() {
    // rust: let m = parent * pose_matrix(pose_of(part, &d.poses));
    // rust: let to_screen = view * m;
    // rust: let normal = glam::Mat3::from_mat4(view * m);
    // rust: for face in &part.faces {
    // rust: let n = (normal * Vec3::from_array(face.normal)).normalize_or_zero();
                // Seen through, a face turned away would show behind the near one: skip it.
    // rust: if d.alpha < 1.0 && n.z > 0.0 {
    // rust: continue;
}
                // Faces turned away are hidden by the depth test; the light is vanilla-like:
                // brighter facing up and toward the viewer.
    // rust: let light = (0.55 + 0.25 * (-n.y).max(0.0) + 0.2 * (-n.z).max(0.0)).min(1.0);
    // rust: let v: Vec<(Vec3, [f32; 2])> = face
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| {
    // rust: let p =
    // rust: to_screen * glam::Vec4::new(v[0] / 16.0, v[1] / 16.0, v[2] / 16.0, 1.0);
    // rust: (p.xyz(), [v[3], v[4]])
    // rust: })
    // rust: .collect();
    // rust: for tri in [[0, 1, 2], [0, 2, 3]] {
    // rust: raster(
    // rust: [v[tri[0]], v[tri[1]], v[tri[2]]],
    // rust: d.texture,
    // rust: (light, d.alpha),
    // rust: (w, h),
    // rust: &mut rgba,
    // rust: &mut depth,
    // rust: );
}
}
    // rust: for child in &part.children {
    // rust: stack.push((child, m));
}
}
}
    // rust: Image {
    // rust: width,
    // rust: height,
    // rust: rgba,
}
}

    // rust: fn raster(
    // rust: v: [(Vec3, [f32; 2]); 3],
    // rust: tex: &Texture,
    // rust: (light, alpha): (f32, f32),
    // rust: (w, h): (usize, usize),
    // rust: rgba: &mut [u8],
    // rust: depth: &mut [f32],
    // rust: ) {
    // rust: let (a, b, c) = (v[0].0, v[1].0, v[2].0);
    // rust: let area = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
    // rust: if area.abs() < 1e-6 {
    // rust: return;
}
    // rust: let x0 = a.x.min(b.x).min(c.x).floor().max(0.0) as usize;
    // rust: let x1 = (a.x.max(b.x).max(c.x).ceil() as usize).min(w);
    // rust: let y0 = a.y.min(b.y).min(c.y).floor().max(0.0) as usize;
    // rust: let y1 = (a.y.max(b.y).max(c.y).ceil() as usize).min(h);
    // rust: for y in y0..y1 {
    // rust: for x in x0..x1 {
    // rust: let (px, py) = (x as f32 + 0.5, y as f32 + 0.5);
    // rust: let w0 = ((b.x - px) * (c.y - py) - (b.y - py) * (c.x - px)) / area;
    // rust: let w1 = ((c.x - px) * (a.y - py) - (c.y - py) * (a.x - px)) / area;
    // rust: let w2 = 1.0 - w0 - w1;
    // rust: if w0 < 0.0 || w1 < 0.0 || w2 < 0.0 {
    // rust: continue;
}
    // rust: let z = w0 * a.z + w1 * b.z + w2 * c.z;
    // rust: let i = y * w + x;
    // rust: if z >= depth[i] {
    // rust: continue;
}
    // rust: let u = w0 * v[0].1[0] + w1 * v[1].1[0] + w2 * v[2].1[0];
    // rust: let t = w0 * v[0].1[1] + w1 * v[1].1[1] + w2 * v[2].1[1];
    // rust: let tx = ((u * tex.width as f32) as usize).min(tex.width as usize - 1);
    // rust: let ty = ((t * tex.height as f32) as usize).min(tex.height as usize - 1);
    // rust: let texel = &tex.rgba[(ty * tex.width as usize + tx) * 4..][..4];
            // Cutout, as entity textures draw.
    // rust: if texel[3] < 128 {
    // rust: continue;
}
    // rust: if alpha < 1.0 {
                // See-through: over what is there, without hiding what comes behind.
    // rust: let a = alpha * f32::from(texel[3]) / 255.0;
    // rust: let under = f32::from(rgba[i * 4 + 3]) / 255.0;
    // rust: let out = a + under * (1.0 - a);
    // rust: for k in 0..3 {
    // rust: let over = f32::from(texel[k]) * light;
    // rust: let was = f32::from(rgba[i * 4 + k]) * under;
    // rust: rgba[i * 4 + k] = ((over * a + was * (1.0 - a)) / out.max(1e-6)).round() as u8;
}
    // rust: rgba[i * 4 + 3] = (out * 255.0).round() as u8;
    // rust: continue;
}
    // rust: depth[i] = z;
    // rust: for k in 0..3 {
    // rust: rgba[i * 4 + k] = (f32::from(texel[k]) * light).round() as u8;
}
    // rust: rgba[i * 4 + 3] = 255;
}
}
}

    // rust: mod tests {
//     use super::*;

    /// A 64×64 skin in one colour per region: what lands where shows which face was drawn.
pub fn skin() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rgba = vec![0u8; 64 * 64 * 4];
    // rust: for y in 0..64 {
    // rust: for x in 0..64 {
    // rust: let c: [u8; 4] = match (x, y) {
                    // The head's front (box UV: u+d, v+d, 8×8 from (0, 0)).
    // rust: (8..16, 8..16) => [200, 0, 0, 255],
    // rust: (0..32, 0..16) => [0, 200, 0, 255],
                    // The hat layer: transparent.
    // rust: (32..64, 0..16) => [0, 0, 0, 0],
    // rust: _ => [0, 0, 200, 255],
}
    // rust: rgba[(y * 64 + x) * 4..][..4].copy_from_slice(&c);
}
}
    // rust: Texture {
    // rust: width: 64,
    // rust: height: 64,
    // rust: rgba,
}
}

    /// Straight at the front, level, the whole player.
    // rust: const FRONT: Camera = Camera {
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: zoom: 1.0,
}

    /// Where the model-space point `p` (blocks) lands in a 100×100 picture.
pub fn screen(camera: Camera, p: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: camera.view(100, 100).transform_point3(p)
}

pub fn at(img: *Image, x: u32, y: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: img.rgba[((y * img.width + x) * 4) as usize..][..4]
    // rust: .try_into()
    // rust: .unwrap()
}

pub fn the_front_of_the_head_faces_the_viewer() void {
}
    // rust: let body = player_model(false);
    // rust: let tex = skin();
    // rust: let draw = Draw::model(&body, &tex);
    // rust: let img = render(&[draw], 100, 100, &FRONT);
        // A third of 100 px a block: the head's top at row 20, its bottom (the pivot) at 36.7;
        // its middle at row 28, column 50.
    // rust: let face = at(&img, 50, 28);
    // rust: assert_eq!(face[3], 255);
    // rust: assert!(face[0] > 100 && face[1] == 0 && face[2] == 0, "{face:?}");
        // Above the head, nothing (the transparent hat layer doesn't hide it).
    // rust: assert_eq!(at(&img, 50, 10)[3], 0);
        // Turned round: the back of the head (green region), not the face.
    // rust: let back = render(
    // rust: &[Draw::model(&body, &tex)],
    // rust: 100,
    // rust: 100,
    // rust: &Camera {
    // rust: yaw: 180.0,
    // rust: ..FRONT
    // rust: },
    // rust: );
    // rust: let c = at(&back, 50, 28);
    // rust: assert!(c[1] > 100 && c[0] == 0, "{c:?}");
}

pub fn an_item_sits_on_its_bone() void {
}
    // rust: let file = format!(
    // rust: r#"{{"format": 1, "id": "cap", "slot": "head", "bone": "head",
    // rust: "attach": {{"offset": [0, -8, 0]}}, "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "c", "cubes": [{{"origin": [-4, -4, -4], "size": [8, 4, 8], "uv": [0, 0]}}]}}]}}"#,
    // rust: crate::pose::tests::png(32, 32)
    // rust: );
    // rust: let item = Item::parse(file.as_bytes()).unwrap();
    // rust: let body = player_model(false);
    // rust: let tex = skin();
    // rust: let mut draws = vec![Draw::model(&body, &tex)];
    // rust: let bare = render(&draws, 100, 100, &FRONT);
    // rust: draws.extend(Draw::item(&item, &body, 0.0));
    // rust: let worn = render(&draws, 100, 100, &FRONT);
        // The cap spans 8 to 12 model pixels above the head's pivot: rows 11.7 to 20, over the
        // head's top at row 20.
    // rust: assert_eq!(at(&bare, 50, 15)[3], 0);
    // rust: let cap = at(&worn, 50, 15);
    // rust: assert_eq!(cap[3], 255);
        // Grey (200 lit), not the skin's colours.
    // rust: assert!(cap[0] == cap[1] && cap[1] == cap[2], "{cap:?}");
        // The face is still the face.
    // rust: assert_eq!(at(&worn, 50, 28), at(&bare, 50, 28));
}

pub fn dragging_turns_the_player_as_if_held() void {
}
        // The nose: the middle of the head's front face.
    // rust: let nose = Vec3::new(0.0, -0.25, -0.25);
    // rust: let ahead = screen(FRONT, nose);
    // rust: assert!((ahead.x - 50.0).abs() < 1e-3, "{ahead}");
        // Dragged right, the face turns right.
    // rust: let right = screen(FRONT.dragged(30.0, 0.0), nose);
    // rust: assert!(right.x > 52.0, "{right}");
    // rust: let left = screen(FRONT.dragged(-30.0, 0.0), nose);
    // rust: assert!(left.x < 48.0, "{left}");
        // A full turn's drag comes back round, the yaw kept within one turn.
    // rust: let round = FRONT.dragged(360.0 / Camera::DRAG, 0.0);
    // rust: assert!(
    // rust: round.yaw.abs() < 1e-3 || (round.yaw - 360.0).abs() < 1e-3,
    // rust: "{round:?}"
    // rust: );
        // Dragged down, the top of the head turns toward the viewer (its normal points at -z,
        // where the viewer is); up, away.
    // rust: let top = |c: Camera| c.view(100, 100).transform_vector3(Vec3::NEG_Y).z;
    // rust: assert!(top(FRONT.dragged(0.0, 20.0)) < 0.0);
    // rust: assert!(top(FRONT.dragged(0.0, -20.0)) > 0.0);
    // rust: assert!(top(Camera::HOME) < 0.0, "home looks from a little above");
        // The tilt stops at its limits.
    // rust: assert_eq!(FRONT.dragged(0.0, 1e4).pitch, Camera::MAX_PITCH);
    // rust: assert_eq!(FRONT.dragged(0.0, -1e4).pitch, Camera::MIN_PITCH);
}

pub fn zooming_closes_in_on_the_head() void {
}
        // The whole player at zoom 1: the head's top a fifth down, the feet above the bottom.
    // rust: let head_top = screen(FRONT, Vec3::new(0.0, -0.5, 0.0));
    // rust: let feet = screen(FRONT, Vec3::new(0.0, 1.5, 0.0));
    // rust: assert!((head_top.y - 20.0).abs() < 1e-3, "{head_top}");
    // rust: assert!(80.0 < feet.y && feet.y < 90.0, "{feet}");
    // rust: assert_eq!(FRONT.zoomed(100.0).zoom, Camera::MAX_ZOOM);
    // rust: assert_eq!(FRONT.zoomed(-100.0).zoom, 1.0);
    // rust: assert!((FRONT.zoomed(2.0).zoomed(-2.0).zoom - 1.0).abs() < 1e-5);
        // All the way in, the head's centre is the picture's and it is three times the size.
    // rust: let near = FRONT.zoomed(100.0);
    // rust: let head = screen(near, Vec3::new(0.0, -0.25, 0.0));
    // rust: assert!(
    // rust: (head.x - 50.0).abs() < 1e-3 && (head.y - 50.0).abs() < 1e-3,
    // rust: "{head}"
    // rust: );
    // rust: let chin = screen(near, Vec3::new(0.0, 0.0, 0.0));
    // rust: assert!((chin.y - head.y - 0.25 * 100.0).abs() < 1e-3, "{chin}");
        // On the way, the picture's middle moves from the body's middle up to the head.
    // rust: let middle = |c: Camera| {
    // rust: c.view(100, 100)
    // rust: .inverse()
    // rust: .transform_point3(Vec3::new(50.0, 50.0, 0.0))
}
    // rust: assert!((middle(FRONT).y - 0.4).abs() < 1e-4);
    // rust: let half = middle(FRONT.zoomed(4.0)).y;
    // rust: assert!(-0.25 < half && half < 0.4, "{half}");
}

pub fn an_item_follows_its_bone_as_posed() void {
}
    // rust: let file = format!(
    // rust: r#"{{"format": 1, "id": "band", "slot": "torso", "bone": "right_arm",
    // rust: "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "b", "cubes": [{{"origin": [-3, 8, -2], "size": [4, 2, 4], "uv": [0, 0]}}]}}]}}"#,
    // rust: crate::pose::tests::png(32, 32)
    // rust: );
    // rust: let item = Item::parse(file.as_bytes()).unwrap();
    // rust: let body = player_model(false);
        // Ten pixels down the arm, where the band is.
    // rust: let wrist = |draws: &[Draw]| {
    // rust: draws[0]
    // rust: .base
    // rust: .transform_point3(Vec3::new(0.0, 10.0 / 16.0, 0.0))
}
    // rust: let rest = wrist(&Draw::item(&item, &body, 0.0));
        // At rest the arm hangs: the wrist is below the shoulder.
    // rust: assert!(rest.y > 0.5 && rest.z.abs() < 1e-4, "{rest}");
        // Raised straight ahead (vanilla's -90° about x), the band comes forward with it.
    // rust: let raised = [(
    // rust: "right_arm".to_owned(),
    // rust: [
    // rust: -5.0,
    // rust: 2.0,
    // rust: 0.0,
    // rust: -std::f32::consts::FRAC_PI_2,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: 1.0,
    // rust: 1.0,
    // rust: ],
    // rust: )];
    // rust: let up = wrist(&Draw::item_posed(&item, &body, &raised, 0.0));
    // rust: assert!(up.z < -0.5 && (up.y - 2.0 / 16.0).abs() < 1e-4, "{up}");
}

pub fn worn(file: []const u8, x: u32, y: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let item = Item::parse(file.as_bytes()).unwrap();
    // rust: let body = player_model(false);
    // rust: let tex = skin();
    // rust: let mut draws = vec![Draw::model(&body, &tex)];
    // rust: let bare = render(&draws, 100, 100, &FRONT);
    // rust: draws.extend(Draw::item(&item, &body, 0.0));
    // rust: let worn = render(&draws, 100, 100, &FRONT);
    // rust: (at(&bare, x, y), at(&worn, x, y))
}

pub fn a_companion_floats_at_its_anchor_beside_the_head() void {
}
        // A 4-pixel cube 14 pixels to the player's right of the neck, 6 up: a third of 100 px a
        // block, the picture's middle 0.4 blocks under the neck, puts its middle at column
        // 50 - 0.875 * 33.3 = 20.8, row 50 - (0.375 + 0.4) * 33.3 = 24.2.
    // rust: let file = format!(
    // rust: r#"{{"format": 1, "id": "pal", "slot": "companion", "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "c", "cubes": [{{"origin": [-2, -2, -2], "size": [4, 4, 4], "uv": [0, 0]}}]}}],
    // rust: "companion": {{"anchor": [-14, -6, 8]}}}}"#,
    // rust: crate::pose::tests::png(16, 16)
    // rust: );
    // rust: let (bare, worn) = worn(&file, 21, 24);
    // rust: assert_eq!(bare[3], 0);
    // rust: assert_eq!(worn[3], 255);
}

pub fn an_aura_at_the_feet_lets_the_legs_show_through() void {
}
        // A wall 24 pixels wide and 6 high, 12 in front of the feet, at half opacity: rows 74.2
        // to 86.7 of the picture (1.125 to 1.5 blocks under the neck), columns 25 to 75.
    // rust: let file = format!(
    // rust: r#"{{"format": 1, "id": "glow", "slot": "aura", "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "c", "cubes": [{{"origin": [-12, -6, -12], "size": [24, 6, 1], "uv": [0, 0]}}]}}],
    // rust: "aura": {{"at": "feet", "alpha": 0.5}}}}"#,
    // rust: crate::pose::tests::png(64, 16)
    // rust: );
        // The test texture is grey 200 at 200 of 255 opaque, lit 0.75 facing the viewer: 150,
        // covering 0.5 * 200 / 255 of what is behind.
    // rust: let a = 0.5 * 200.0 / 255.0;
    // rust: let (bare, aura) = worn(&file, 30, 80);
    // rust: assert_eq!(bare[3], 0);
    // rust: assert_eq!(aura, [150, 150, 150, (a * 255.0_f32).round() as u8]);
        // Over a leg: the leg's blue (150 lit) still shows through the grey.
    // rust: let (leg, over) = worn(&file, 45, 80);
    // rust: assert_eq!(leg, [0, 0, 150, 255]);
    // rust: assert_eq!(
    // rust: over,
    // rust: [
    // rust: (150.0 * a).round() as u8,
    // rust: (150.0 * a).round() as u8,
    // rust: 150,
    // rust: 255
    // rust: ]
    // rust: );
}

pub fn a_trail_leaves_particles_behind_on_the_ground() void {
}
    // rust: let file = format!(
    // rust: r#"{{"format": 1, "id": "leaves", "slot": "trail", "texture": {{"png": "{}"}}, "parts": [],
    // rust: "trail": {{"sprites": 4, "rate": 2, "lifetime": 30, "size": [2, 3], "gravity": 0.01, "fade": true}}}}"#,
    // rust: crate::pose::tests::png(32, 8)
    // rust: );
    // rust: let item = Item::parse(file.as_bytes()).unwrap();
    // rust: let part = trail_part(&item).unwrap();
    // rust: assert_eq!(part.faces.len(), 14);
        // Each farther behind than the last (+z), none under the ground (24 pixels down).
    // rust: let z: Vec<f32> = part.faces.iter().map(|f| f.vertices[0][2]).collect();
    // rust: assert!(z.windows(2).all(|w| w[1] > w[0]), "{z:?}");
    // rust: assert!(
    // rust: part.faces
    // rust: .iter()
    // rust: .flat_map(|f| f.vertices)
    // rust: .all(|v| v[1] <= 24.0 + 1.5)
    // rust: );
}
}
