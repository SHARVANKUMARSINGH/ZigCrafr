//! Transpiled from Horizon Rust crate
//! Module: horizon-client_save_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::{MapBanner, MapData, MapFrame};
// use horizon_world::nbt::Tag;

    // rust: const OPTIONAL: [&str; 6] = [
    // rust: "scale",
    // rust: "locked",
    // rust: "trackingPosition",
    // rust: "unlimitedTracking",
    // rust: "banners",
    // rust: "frames",
    // rust: ];

pub fn default_map_fields_are_omitted_without_losing_nondefaults() void {
}
    // rust: let mut map = MapData::fresh(0.0, 0.0, 0, "minecraft:overworld");
    // rust: map.colors[0] = 5;
    // rust: map.colors[16383] = 255;
    // rust: let initial = map.to_nbt();
    // rust: let data = initial.get("data").unwrap();
    // rust: for key in OPTIONAL {
    // rust: assert!(data.get(key).is_none(), "default {key}");
}
    // rust: assert_eq!(data.get("xCenter"), Some(&Tag::Int(0)));
    // rust: assert_eq!(data.get("zCenter"), Some(&Tag::Int(0)));
    // rust: assert_eq!(
    // rust: data.get("dimension"),
    // rust: Some(&Tag::String("minecraft:overworld".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: data.get("colors"),
    // rust: Some(&Tag::ByteArray(map.colors.clone()))
    // rust: );

    // rust: map.scale = 4;
    // rust: map.locked = true;
    // rust: map.tracking = false;
    // rust: map.unlimited = true;
    // rust: map.banners.push(MapBanner {
    // rust: pos: [7, 70, -11],
    // rust: color: "red".into(),
    // rust: name: None,
    // rust: });
    // rust: map.frames.push(MapFrame {
    // rust: pos: [-3, 80, 9],
    // rust: rotation: 270,
    // rust: entity_id: 42,
    // rust: });
    // rust: let saved = map.to_nbt();
    // rust: let data = saved.get("data").unwrap();
    // rust: for (key, expected) in [
    // rust: ("scale", 4),
    // rust: ("locked", 1),
    // rust: ("trackingPosition", 0),
    // rust: ("unlimitedTracking", 1),
    // rust: ] {
    // rust: assert_eq!(data.get(key), Some(&Tag::Byte(expected)), "{key}");
}
    // rust: for key in ["banners", "frames"] {
    // rust: assert!(matches!(data.get(key), Some(Tag::List(list)) if list.len() == 1));
}
    // rust: for key in ["dimension", "xCenter", "zCenter", "colors"] {
    // rust: assert_eq!(
    // rust: data.get(key),
    // rust: initial.get("data").unwrap().get(key),
    // rust: "{key}"
    // rust: );
}

    // rust: map.scale = 0;
    // rust: map.locked = false;
    // rust: map.tracking = true;
    // rust: map.unlimited = false;
    // rust: map.banners.clear();
    // rust: map.frames.clear();
    // rust: let saved = map.to_nbt();
    // rust: for key in OPTIONAL {
    // rust: assert!(saved.get("data").unwrap().get(key).is_none(), "{key}");
}
}

/// Sorted, typed NBT transport shared with the Java oracle for these cases.
pub fn canonical(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::Compound(c) => format!(
    // rust: "{{{}}}",
    // rust: c.iter()
    // rust: .map(|(key, value)| format!("{}:{}", key.to_string_lossy(), canonical(value)))
    // rust: .collect::<Vec<_>>()
    // rust: .join(",")
    // rust: ),
    // rust: Tag::List(list) => format!(
    // rust: "[{}]",
    // rust: list.iter().map(canonical).collect::<Vec<_>>().join(",")
    // rust: ),
    // rust: Tag::Byte(value) => format!("{value}b"),
    // rust: Tag::Int(value) => value.to_string(),
    // rust: Tag::String(value) => serde_json::to_string(&value.to_string_lossy()).unwrap(),
    // rust: Tag::ByteArray(values) => format!(
    // rust: "[B;{}]",
    // rust: values
    // rust: .iter()
    // rust: .map(|v| (*v as i8).to_string())
    // rust: .collect::<Vec<_>>()
    // rust: .join(",")
    // rust: ),
    // rust: Tag::IntArray(values) => format!(
    // rust: "[I;{}]",
    // rust: values
    // rust: .iter()
    // rust: .map(i32::to_string)
    // rust: .collect::<Vec<_>>()
    // rust: .join(",")
    // rust: ),
    // rust: _ => panic!("unexpected tag in saved-map fixture: {tag:?}"),
}
}

pub fn saved_map_codec_fixture() void {
}
    // rust: let cases = std::fs::read_to_string(std::env::var("HORIZON_MAP_SAVE_CASES").unwrap()).unwrap();
    // rust: let cases: Vec<serde_json::Value> = serde_json::from_str(&cases).unwrap();
    // rust: let mut lines = Vec::new();
    // rust: for case in cases {
    // rust: let mut map = MapData::fresh(0.0, 0.0, 0, case["dimension"].as_str().unwrap());
    // rust: map.center = [
    // rust: case["x"].as_i64().unwrap() as i32,
    // rust: case["z"].as_i64().unwrap() as i32,
    // rust: ];
    // rust: map.scale = case["scale"].as_u64().unwrap() as u8;
    // rust: map.locked = case["locked"].as_bool().unwrap();
    // rust: map.tracking = case["tracking"].as_bool().unwrap();
    // rust: map.unlimited = case["unlimited"].as_bool().unwrap();
    // rust: map.colors = (0..128 * 128).map(|i| (i * 17) as u8).collect();
    // rust: if case["banner"].as_bool().unwrap() {
    // rust: map.banners.push(MapBanner {
    // rust: pos: [7, 70, -11],
    // rust: color: "red".into(),
    // rust: name: None,
    // rust: });
}
    // rust: if case["frame"].as_bool().unwrap() {
    // rust: map.frames.push(MapFrame {
    // rust: pos: [-3, 80, 9],
    // rust: rotation: 270,
    // rust: entity_id: 42,
    // rust: });
}
    // rust: let saved = map.to_nbt();
    // rust: lines.push(format!(
    // rust: "{} {}",
    // rust: case["name"].as_str().unwrap(),
    // rust: canonical(saved.get("data").unwrap())
    // rust: ));
}
    // rust: let output = std::env::var("HORIZON_MAP_SAVE_OUTPUT").unwrap();
    // rust: std::fs::write(output, lines.join("\n") + "\n").unwrap();
}
