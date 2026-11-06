//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_obj
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Wavefront OBJ and MTL text, as obj-loader models use them.
// use std::collections::BTreeMap;

pub const ObjVertex = struct {
    /// Block units.
    position: [f32,
    /// Texture coordinates as written, 0..1 across the sprite.
    uv: [f32,
};
/// One quad; a triangle repeats its last vertex.
pub const ObjFace = struct {
    /// Empty before any `usemtl`.
    material: []const u8,
    /// The `o` (else `g`) it belongs to, which a model's `visibility` names.
    object: []const u8,
    vertices: [ObjVertex,
};
pub const ParsedObj = struct {
    mtllib: ?[]const u8,
    faces: std.ArrayList(ObjFace),
};
pub const MtlTexture = enum {
    /// `map_Kd #name`: a texture slot of the model.
    Slot(String),
    /// `map_Kd namespace:path`: a sprite.
    Sprite(String),
};
/// A parsed OBJ with its materials.
pub const ObjModel = struct {
    faces: std.ArrayList(ObjFace),
    materials: BTreeMap<[]const u8,
};

pub fn parse_obj(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut positions: Vec<[f32; 3]> = Vec::new();
    // rust: let mut uvs: Vec<[f32; 2]> = Vec::new();
    // rust: let mut parsed = ParsedObj::default();
    // rust: let mut material = String::new();
    // rust: let mut object = String::new();
    // rust: for (number, line) in text.lines().enumerate() {
    // rust: let mut words = line.split_whitespace();
    // rust: let Some(keyword) = words.next() else {
    // rust: continue;
}
    // rust: let at = |message: &str| format!("line {}: {message}", number + 1);
    // rust: match keyword {
    // rust: _ if keyword.starts_with('#') => {}
    // rust: "v" => positions.push(floats::<3>(words).ok_or_else(|| at("bad vertex"))?),
    // rust: "vt" => {
    // rust: let mut words = words;
    // rust: let u = words.next().and_then(|w| w.parse().ok());
    // rust: let v = words.next().map_or(Some(0.0), |w| w.parse().ok());
    // rust: let (Some(u), Some(v)) = (u, v) else {
    // rust: return Err(at("bad texture coordinate"));
}
    // rust: uvs.push([u, v]);
}
    // rust: "mtllib" => parsed.mtllib = words.next().map(str::to_owned),
    // rust: "usemtl" => material = words.next().unwrap_or("").to_owned(),
    // rust: "o" | "g" => object = words.next().unwrap_or("").to_owned(),
    // rust: "f" => {
    // rust: let mut corners = Vec::new();
    // rust: for word in words {
    // rust: let mut parts = word.split('/');
    // rust: let position = index(parts.next(), positions.len())
    // rust: .ok_or_else(|| at("bad vertex index"))?;
    // rust: let uv = match parts.next() {
    // rust: None | Some("") => [0.0; 2],
    // rust: some => {
    // rust: uvs[index(some, uvs.len()).ok_or_else(|| at("bad texture index"))?]
}
}
    // rust: corners.push(ObjVertex {
    // rust: position: positions[position],
    // rust: uv,
    // rust: });
}
    // rust: if corners.len() < 3 {
    // rust: return Err(at("face needs three vertices"));
}
    // rust: let mut push = |vertices: [ObjVertex; 4]| {
    // rust: parsed.faces.push(ObjFace {
    // rust: material: material.clone(),
    // rust: object: object.clone(),
    // rust: vertices,
    // rust: });
}
    // rust: if corners.len() <= 4 {
    // rust: let last = corners[corners.len() - 1];
    // rust: push(std::array::from_fn(|i| {
    // rust: corners.get(i).copied().unwrap_or(last)
    // rust: }));
    // rust: } else {
    // rust: for i in 1..corners.len() - 1 {
    // rust: push([corners[0], corners[i], corners[i + 1], corners[i + 1]]);
}
}
}
    // rust: _ => {}
}
}
    // rust: Ok(parsed)
}
    // rust: fn floats<'a, const N: usize>(mut words: impl Iterator<Item = &'a str>) -> Option<[f32; N]> {
    // rust: let mut result = [0.0; N];
    // rust: for value in &mut result {
    // rust: *value = words.next()?.parse().ok()?;
}
    // rust: Some(result)
}
/// A 1-based index, or a negative one counted from the end.
pub fn index(word: ?[]const u8, len: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value: i64 = word?.parse().ok()?;
    // rust: let index = if value < 0 {
    // rust: len as i64 + value
    // rust: } else {
    // rust: value - 1
}
    // rust: (0..len as i64).contains(&index).then_some(index as usize)
}

/// Material name to its `map_Kd`; other statements are ignored.
pub fn parse_mtl(text: []const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut materials = BTreeMap::new();
    // rust: let mut current = None;
    // rust: for line in text.lines() {
    // rust: let mut words = line.split_whitespace();
    // rust: match words.next() {
    // rust: Some("newmtl") => current = words.next().map(str::to_owned),
    // rust: Some("map_Kd") => {
    // rust: let (Some(name), Some(value)) = (&current, words.last()) else {
    // rust: continue;
}
    // rust: let texture = match value.strip_prefix('#') {
    // rust: Some(slot) => MtlTexture::Slot(slot.to_owned()),
    // rust: None => MtlTexture::Sprite(value.to_owned()),
}
    // rust: materials.insert(name.clone(), texture);
}
    // rust: _ => {}
}
}
    // rust: materials
}

    // rust: mod tests {
//     use super::*;

pub fn quads_triangles_and_negative_indices() void {
}
    // rust: let text = "mtllib a.mtl\nv 0 0 0\nv 1 0 0\nv 1 1 0\nv 0 1 0\nvt 0 0\nvt 1 0\nvt 1 1\nvt 0 1\n\
    // rust: usemtl first\nf 1/1/1 2/2/1 3/3/1 4/4/1\nusemtl second\nf -4//1 -3//1 -2//1\n";
    // rust: let parsed = parse_obj(text).unwrap();
    // rust: assert_eq!(parsed.mtllib.as_deref(), Some("a.mtl"));
    // rust: assert_eq!(parsed.faces.len(), 2);
    // rust: assert_eq!(parsed.faces[0].material, "first");
    // rust: assert_eq!(parsed.faces[0].vertices[2].uv, [1.0, 1.0]);
    // rust: let triangle = &parsed.faces[1];
    // rust: assert_eq!(triangle.material, "second");
    // rust: assert_eq!(triangle.vertices[0].position, [0.0, 0.0, 0.0]);
    // rust: assert_eq!(triangle.vertices[3], triangle.vertices[2]);
    // rust: assert_eq!(triangle.vertices[2].position, [1.0, 1.0, 0.0]);
}
pub fn bad_indices_are_errors() void {
}
    // rust: assert!(parse_obj("v 0 0 0\nf 1 2 3\n").is_err());
    // rust: assert!(parse_obj("v 0 0 0\nv 1 0 0\nf 1 2\n").is_err());
}
pub fn mtl_maps_slots_and_sprites() void {
}
    // rust: let materials =
    // rust: parse_mtl("newmtl a\nKd 1 1 1\nmap_Kd #top\nnewmtl b\nmap_Kd mod:block/x\nnewmtl c\n");
    // rust: assert_eq!(materials["a"], MtlTexture::Slot("top".into()));
    // rust: assert_eq!(materials["b"], MtlTexture::Sprite("mod:block/x".into()));
    // rust: assert!(!materials.contains_key("c"));
}
}
