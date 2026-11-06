//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_pose
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Poses as the game's model parts have them.

/// x, y, z (pixels), x, y, z rotations (radians), x, y, z scales: the
/// game's `Part::pose`.
    // rust: pub type Pose = [f32; 9];

/// `ModelPart.translateAndRotate`: the matrix a part's pose applies under
/// its parent's (the game's `mobs::render::posed`). An item's root pose is
/// its attachment, so the item sits at `bone * pose_matrix(root.pose)`.
pub fn pose_matrix(p: Pose) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: glam::Mat4::from_translation(glam::Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * glam::Mat4::from_quat(glam::Quat::from_euler(
    // rust: glam::EulerRot::ZYX,
    // rust: p[5],
    // rust: p[4],
    // rust: p[3],
    // rust: ))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(p[6], p[7], p[8]))
}

    // rust: pub(crate) mod tests {
//     use super::*;
//     use crate::{Bone, Error, Item, MAX_VERTICES, Motion, Slot, Tag};
//     use glam::{Mat4, Vec3};

    /// A `width`×`height` PNG, base64.
    // rust: pub(crate) fn png(width: u32, height: u32) -> String {
//         use base64::Engine;
    // rust: let mut bytes = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut bytes, width, height);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer
    // rust: .write_image_data(&vec![200; (width * height * 4) as usize])
    // rust: .unwrap();
    // rust: writer.finish().unwrap();
    // rust: base64::engine::general_purpose::STANDARD.encode(bytes)
}

    /// A hat: an 8×2×8 brim 8 pixels above the head's pivot, and a crown
    /// on it that swings 10° about z over 40 ticks.
pub fn hat(extra: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: r#"{{"format": 1, "id": "hat", "slot": "head", "bone": "head",
    // rust: "attach": {{"offset": [0, -8, 0]}},
    // rust: "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "brim", "cubes": [{{"origin": [-4, -2, -4], "size": [8, 2, 8], "uv": [0, 0]}}],
    // rust: "children": [{{"name": "crown", "pivot": [0, -2, 0],
    // rust: "cubes": [{{"origin": [-2, -4, -2], "size": [4, 4, 4], "uv": [0, 10]}}]}}]}}],
    // rust: "animations": [{{"part": "crown", "motion": "swing", "axis": "z", "amplitude": 10, "period": 40}}]
    // rust: {extra}}}"#,
    // rust: png(32, 32)
    // rust: )
}

    /// The posed position of a part's first face's vertex `i`.
pub fn corner(item: *Item, bone: Mat4, path: *[[]const u8], face: usize, i: usize, ticks: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut poses = std::collections::HashMap::new();
    // rust: item.animate(ticks, |n, p| {
    // rust: poses.insert(n.to_owned(), p);
    // rust: });
    // rust: let mut m = bone * pose_matrix(item.root.pose);
    // rust: let mut part = &item.root;
    // rust: for name in path {
    // rust: part = part.children.iter().find(|c| c.name == *name).unwrap();
    // rust: m *= pose_matrix(*poses.get(*name).unwrap_or(&part.pose));
}
    // rust: let v = part.faces[face].vertices[i];
    // rust: m.transform_point3(Vec3::new(v[0], v[1], v[2]) / 16.0)
}

pub fn close(a: Vec3, b: Vec3) void {
}
    // rust: assert!((a - b).abs().max_element() < 1e-5, "{a} != {b}");
}

pub fn reads_the_item_and_bakes_box_uv() void {
}
    // rust: let item = Item::parse(hat("").as_bytes()).unwrap();
    // rust: assert_eq!((item.slot, item.bone), (Slot::Head, Bone::Head));
    // rust: assert_eq!(item.vertices, 2 * 6 * 4);
    // rust: assert_eq!(
    // rust: (item.texture.width, item.texture.rgba.len()),
    // rust: (32, 32 * 32 * 4)
    // rust: );
        // The brim's down face: corners l1, l0, t0, t1 with UV (u+d, v) to
        // (u+d+w, v+d) remapped as (u1,v0) (u0,v0) (u0,v1) (u1,v1).
    // rust: let down = &item.root.children[0].faces[0];
    // rust: assert_eq!(down.normal, [0.0, -1.0, 0.0]);
    // rust: assert_eq!(
    // rust: down.vertices,
    // rust: [
    // rust: [4.0, -2.0, 4.0, 16.0 / 32.0, 0.0],
    // rust: [-4.0, -2.0, 4.0, 8.0 / 32.0, 0.0],
    // rust: [-4.0, -2.0, -4.0, 8.0 / 32.0, 8.0 / 32.0],
    // rust: [4.0, -2.0, -4.0, 16.0 / 32.0, 8.0 / 32.0],
    // rust: ]
    // rust: );
}

pub fn the_item_follows_its_bone() void {
}
    // rust: let item = Item::parse(hat("").as_bytes()).unwrap();
        // Brim face 0, vertex 2 is (-4, -2, -4) px: 8 px up from the
        // attachment, (-0.25, -0.625, -0.25) blocks from the bone's pivot.
    // rust: close(
    // rust: corner(&item, Mat4::IDENTITY, &["brim"], 0, 2, 0.0),
    // rust: Vec3::new(-0.25, -0.625, -0.25),
    // rust: );
        // The head turned 90° about y: (x, y, z) -> (z, y, -x).
    // rust: let turned = Mat4::from_rotation_y(90f32.to_radians());
    // rust: close(
    // rust: corner(&item, turned, &["brim"], 0, 2, 0.0),
    // rust: Vec3::new(-0.25, -0.625, 0.25),
    // rust: );
        // The head 1.5 blocks up and nodding 90° about x: (x, y, z) -> (x, -z, y).
    // rust: let nod = Mat4::from_translation(Vec3::new(0.0, 1.5, 0.0))
    // rust: * Mat4::from_rotation_x(90f32.to_radians());
    // rust: close(
    // rust: corner(&item, nod, &["brim"], 0, 2, 0.0),
    // rust: Vec3::new(-0.25, 1.5 + 0.25, -0.625),
    // rust: );
}

pub fn swings_on_its_period() void {
}
    // rust: let item = Item::parse(hat("").as_bytes()).unwrap();
        // The crown's down face, vertex 2: (-2, -4, -2) px from its pivot,
        // which is 10 px above the bone's.
    // rust: let rest = Vec3::new(-2.0, -14.0, -2.0) / 16.0;
    // rust: close(
    // rust: corner(&item, Mat4::IDENTITY, &["brim", "crown"], 0, 2, 0.0),
    // rust: rest,
    // rust: );
    // rust: close(
    // rust: corner(&item, Mat4::IDENTITY, &["brim", "crown"], 0, 2, 20.0),
    // rust: rest,
    // rust: );
        // A quarter period: 10° about z at the crown's pivot (0, -10, 0) px:
        // (x, y) -> (x cos - y sin, x sin + y cos) about it.
    // rust: let (s, c) = 10f32.to_radians().sin_cos();
    // rust: let (x, y) = (-2.0, -4.0);
    // rust: let swung = Vec3::new(x * c - y * s, -10.0 + x * s + y * c, -2.0) / 16.0;
    // rust: close(
    // rust: corner(&item, Mat4::IDENTITY, &["brim", "crown"], 0, 2, 10.0),
    // rust: swung,
    // rust: );
        // The same pose a period later.
    // rust: close(
    // rust: corner(&item, Mat4::IDENTITY, &["brim", "crown"], 0, 2, 50.0),
    // rust: swung,
    // rust: );
}

pub fn spins_once_per_period_and_bobs() void {
}
    // rust: let spin = hat("").replace(
    // rust: r#""motion": "swing", "axis": "z", "amplitude": 10"#,
    // rust: r#""motion": "spin", "axis": "y""#,
    // rust: );
    // rust: let item = Item::parse(spin.as_bytes()).unwrap();
    // rust: assert_eq!(item.animations[0].motion, Motion::Spin);
    // rust: let mut got = None;
    // rust: item.animate(10.0, |_, p| got = Some(p));
    // rust: assert!((got.unwrap()[4] - std::f32::consts::FRAC_PI_2).abs() < 1e-6);
    // rust: let bob = hat("").replace(
    // rust: r#""motion": "swing", "axis": "z", "amplitude": 10"#,
    // rust: r#""motion": "bob", "axis": "y", "amplitude": 1.5"#,
    // rust: );
    // rust: let item = Item::parse(bob.as_bytes()).unwrap();
    // rust: item.animate(10.0, |_, p| got = Some(p));
        // The crown's pivot y is -2; a quarter period adds the amplitude.
    // rust: assert!((got.unwrap()[1] - (-2.0 + 1.5)).abs() < 1e-6);
}

pub fn each_animated_part_is_posed_once_with_all_its_animations() void {
}
        // The crown swings and spins, the brim bobs: one pose each, in the order of their first
        // animation, the crown's adding both of its own.
    // rust: let item = hat("").replace(
    // rust: r#"{"part": "crown", "motion": "swing", "axis": "z", "amplitude": 10, "period": 40}"#,
    // rust: r#"{"part": "crown", "motion": "swing", "axis": "z", "amplitude": 10, "period": 40},
    // rust: {"part": "brim", "motion": "bob", "axis": "y", "amplitude": 1.5, "period": 40},
    // rust: {"part": "crown", "motion": "spin", "axis": "y", "period": 40}"#,
    // rust: );
    // rust: let item = Item::parse(item.as_bytes()).unwrap();
    // rust: let mut got = Vec::new();
    // rust: item.animate(10.0, |n, p| got.push((n.to_owned(), p)));
    // rust: let names: Vec<&str> = got.iter().map(|(n, _)| n.as_str()).collect();
    // rust: assert_eq!(names, ["crown", "brim"]);
        // A quarter period: the swing at its 10 degrees, a quarter turn, the bob at 1.5.
    // rust: let crown = got[0].1;
    // rust: assert_eq!(crown[..3], [0.0, -2.0, 0.0]);
    // rust: assert!((crown[5] - 10f32.to_radians()).abs() < 1e-6, "{crown:?}");
    // rust: assert!(
    // rust: (crown[4] - std::f32::consts::FRAC_PI_2).abs() < 1e-6,
    // rust: "{crown:?}"
    // rust: );
    // rust: let brim = got[1].1;
    // rust: assert!(
    // rust: (brim[1] - 1.5).abs() < 1e-6 && brim[3..6] == [0.0; 3],
    // rust: "{brim:?}"
    // rust: );
}

pub fn refuses_items_past_the_limits() void {
}
    // rust: let big = hat("").replace(r#""size": [4, 4, 4]"#, r#""size": [4, 4, 4], "inflate": 0"#);
    // rust: assert!(Item::parse(big.as_bytes()).is_ok());
        // 22 boxes of 24 vertices are past the budget.
    // rust: let cube = r#"{"origin": [0, 0, 0], "size": [1, 1, 1], "uv": [0, 0]}"#;
    // rust: let many = vec![cube; MAX_VERTICES / 24 + 1].join(",");
    // rust: let file = hat("").replace(
    // rust: r#""cubes": [{"origin": [-4, -2, -4], "size": [8, 2, 8], "uv": [0, 0]}]"#,
    // rust: &format!(r#""cubes": [{many}]"#),
    // rust: );
    // rust: assert_eq!(
    // rust: Item::parse(file.as_bytes()),
    // rust: Err(Error::TooManyVertices(23 * 24))
    // rust: );
        // Far from the head.
    // rust: let far = hat("").replace(r#""offset": [0, -8, 0]"#, r#""offset": [0, -30, 0]"#);
    // rust: assert!(matches!(Item::parse(far.as_bytes()), Err(Error::TooFar(_))));
        // A texture past 64x64.
    // rust: let wide = hat("").replace(&png(32, 32), &png(128, 32));
    // rust: assert!(matches!(
    // rust: Item::parse(wide.as_bytes()),
    // rust: Err(Error::Texture(_))
    // rust: ));
        // UV off the texture, an animation of no part, a wild swing.
    // rust: for (from, to) in [
    // rust: (r#""uv": [0, 10]"#, r#""uv": [20, 10]"#),
    // rust: (r#""part": "crown""#, r#""part": "tail""#),
    // rust: (r#""amplitude": 10"#, r#""amplitude": 90"#),
    // rust: (r#""id": "hat""#, r#""id": "Hat!""#),
    // rust: ] {
    // rust: assert!(
    // rust: Item::parse(hat("").replace(from, to).as_bytes()).is_err(),
    // rust: "{to}"
    // rust: );
}
    // rust: assert!(Item::parse(hat(r#", "glow": true"#).as_bytes()).is_err());
}

    /// A name tag: an 8×8 mark and a violet line, no parts.
pub fn name_tag(extra: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: r##"{{"format": 1, "id": "tag", "slot": "name_tag", "texture": {{"png": "{}"}},
    // rust: "parts": [], "tag": {{"line": "#a98fFF"}}{extra}}}"##,
    // rust: png(8, 8)
    // rust: )
}

pub fn a_name_tag_is_a_mark_and_a_line_without_a_model() void {
}
    // rust: let item = Item::parse(name_tag("").as_bytes()).unwrap();
    // rust: assert_eq!(item.slot, Slot::NameTag);
    // rust: assert_eq!(
    // rust: item.tag,
    // rust: Some(Tag {
    // rust: line: [0xa9, 0x8f, 0xff]
    // rust: })
    // rust: );
    // rust: assert_eq!(item.vertices, 0);
    // rust: assert_eq!((item.texture.width, item.texture.height), (8, 8));
        // A model item never has a line.
    // rust: assert_eq!(Item::parse(hat("").as_bytes()).unwrap().tag, None);
}

pub fn refuses_name_tags_with_a_model_or_a_big_mark() void {
}
    // rust: let cube =
    // rust: r#"{"name": "box", "cubes": [{"origin": [0, 0, 0], "size": [1, 1, 1], "uv": [0, 0]}]}"#;
    // rust: let boxed = name_tag("").replace(r#""parts": []"#, &format!(r#""parts": [{cube}]"#));
    // rust: let wide = name_tag("").replace(&png(8, 8), &png(32, 32));
    // rust: let oblong = name_tag("").replace(&png(8, 8), &png(16, 8));
    // rust: let no_line = name_tag("").replace(r##", "tag": {"line": "#a98fFF"}"##, "");
    // rust: let bad_line = name_tag("").replace("#a98fFF", "violet");
    // rust: for file in [boxed, wide, oblong, no_line, bad_line] {
    // rust: assert!(Item::parse(file.as_bytes()).is_err(), "{file}");
}
    // rust: let hat_with_tag = hat(r##", "tag": {"line": "#ffffff"}"##);
    // rust: assert!(Item::parse(hat_with_tag.as_bytes()).is_err());
}

    /// A shirt: the body's box, and a sleeve that rides the right arm.
pub fn shirt(sleeve: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: r#"{{"format": 1, "id": "shirt", "slot": "torso", "bone": "body",
    // rust: "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "chest", "cubes": [{{"origin": [-4, 0, -2], "size": [8, 12, 4], "uv": [0, 0]}}]}},
    // rust: {{"name": "sleeve", {sleeve}
    // rust: "cubes": [{{"origin": [-3, -2, -2], "size": [4, 4, 4], "uv": [0, 16]}}]}}]}}"#,
    // rust: png(32, 32)
    // rust: )
}

pub fn a_sleeve_rides_its_own_bone() void {
}
    // rust: let item = Item::parse(shirt(r#""bone": "right_arm","#).as_bytes()).unwrap();
    // rust: assert_eq!((item.slot, item.bone), (Slot::Torso, Bone::Body));
    // rust: assert_eq!(item.vertices, 2 * 6 * 4);
    // rust: let roots: Vec<_> = item.roots().map(|(b, r)| (b, r.children.len())).collect();
    // rust: assert_eq!(roots, [(Bone::Body, 1), (Bone::RightArm, 1)]);
        // The sleeve's root sits at the arm's pivot with the item's attachment (none here): its
        // down face's vertex 2 is the cube's (-3, -2, -2) corner, under whatever matrix the arm
        // has.
    // rust: let (_, limb) = &item.limbs[0];
    // rust: let arm = Mat4::from_translation(Vec3::new(-5.0, 2.0, 0.0) / 16.0)
    // rust: * Mat4::from_rotation_x(40f32.to_radians());
    // rust: let v = limb.children[0].faces[0].vertices[2];
    // rust: let at = arm * pose_matrix(limb.pose) * pose_matrix(limb.children[0].pose);
    // rust: close(
    // rust: at.transform_point3(Vec3::new(v[0], v[1], v[2]) / 16.0),
    // rust: arm.transform_point3(Vec3::new(-3.0, -2.0, -2.0) / 16.0),
    // rust: );
        // On the item's own bone it stays with the chest.
    // rust: let same = Item::parse(shirt(r#""bone": "body","#).as_bytes()).unwrap();
    // rust: assert!(same.limbs.is_empty());
    // rust: assert_eq!(same.root.children.len(), 2);
}

pub fn the_top_is_the_highest_point_above_the_neck_at_rest() void {
}
        // The hat's crown: a 4-pixel box on a pivot 10 pixels up, swinging 10° about z. Its top
        // corners (±2, 4 up from the pivot) rise to 10 + 4 cos 10° + 2 sin 10° at the swing's end.
    // rust: let (s, c) = 10f32.to_radians().sin_cos();
    // rust: let item = Item::parse(hat("").as_bytes()).unwrap();
    // rust: assert!(
    // rust: (item.top - (10.0 + 4.0 * c + 2.0 * s)).abs() < 1e-4,
    // rust: "{}",
    // rust: item.top
    // rust: );
        // Each root counts from its own bone's rest pivot: a sleeve 2 pixels above the body's
        // pivot (the neck) reaches 2 up; on the right arm, whose pivot is 2 below, the neck.
    // rust: let on_body = Item::parse(shirt(r#""bone": "body","#).as_bytes()).unwrap();
    // rust: assert!((on_body.top - 2.0).abs() < 1e-5, "{}", on_body.top);
    // rust: let on_arm = Item::parse(shirt(r#""bone": "right_arm","#).as_bytes()).unwrap();
    // rust: assert!(on_arm.top.abs() < 1e-5, "{}", on_arm.top);
        // A name tag style has no model.
    // rust: assert_eq!(Item::parse(name_tag("").as_bytes()).unwrap().top, 0.0);
}

pub fn only_a_top_level_part_rides_another_bone() void {
}
    // rust: let nested = hat("").replace(
    // rust: r#""name": "crown","#,
    // rust: r#""name": "crown", "bone": "left_arm","#,
    // rust: );
    // rust: assert!(matches!(
    // rust: Item::parse(nested.as_bytes()),
    // rust: Err(Error::Invalid(_))
    // rust: ));
    // rust: let named = shirt("").replace(r#""name": "sleeve""#, r#""name": "cosmetic_right_arm""#);
    // rust: assert!(Item::parse(named.as_bytes()).is_err());
}
}
