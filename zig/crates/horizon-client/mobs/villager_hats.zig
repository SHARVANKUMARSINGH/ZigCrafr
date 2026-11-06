//! Transpiled from Horizon Rust crate
//! Module: horizon-client_villager_hats
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! VillagerProfessionLayer's cached texture metadata and type-layer head visibility.
// use super::{
    // rust: anim::Poses,
    // rust: render::{PROFESSIONS, VILLAGER_TYPES},
}
// use std::{collections::HashMap, fs, path::Path};

pub const Hat = enum {
    None,
    Partial,
    Full,
};

pub const VillagerHats = struct {};

    // rust: impl VillagerHats {
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut hats = HashMap::new();
    // rust: for folder in ["villager", "zombie_villager"] {
    // rust: for (group, names) in [
    // rust: ("type", VILLAGER_TYPES.as_slice()),
    // rust: ("profession", PROFESSIONS.as_slice()),
    // rust: ] {
    // rust: for name in names {
    // rust: let texture = format!("entity/{folder}/{group}/{name}");
    // rust: let path = root.join(format!("assets/minecraft/textures/{texture}.png.mcmeta"));
    // rust: let metadata = fs::read(path)
    // rust: .ok()
    // rust: .and_then(|bytes| serde_json::from_slice::<serde_json::Value>(&bytes).ok());
    // rust: let hat = match metadata
    // rust: .as_ref()
    // rust: .and_then(|v| v["villager"]["hat"].as_str())
    // rust: {
    // rust: Some("partial") => Hat::Partial,
    // rust: Some("full") => Hat::Full,
    // rust: _ => Hat::None,
}
    // rust: hats.insert(texture, hat);
}
}
}
    // rust: Self(hats)
}

pub fn apply(self: *Self, folder: []const u8, variant: []const u8, profession: []const u8, poses: *mut Poses) void {
}
    // rust: let hat = |group, name| {
    // rust: self.0
    // rust: .get(&format!("{folder}/{group}/{name}"))
    // rust: .copied()
    // rust: .unwrap_or_default()
}
    // rust: let visible = match hat("profession", profession) {
    // rust: Hat::None => true,
    // rust: Hat::Partial => hat("type", variant) != Hat::Full,
    // rust: Hat::Full => false,
}
        // VillagerModel.createNoHatModel clears the head and every child.
    // rust: poses.visible("head", visible);
}
}

    // rust: mod tests {
//     use super::*;

pub fn metadata_head_visibility_matches_exported_no_hat_models() void {
}
//         use crate::mobs::{load_model, render::draw};
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES");
    // rust: let mut hats = VillagerHats::load(Path::new(&root));
    // rust: assert_eq!(hats.0["entity/villager/profession/farmer"], Hat::Full);
    // rust: assert_eq!(hats.0["entity/villager/type/plains"], Hat::None);
    // rust: for (name, folder) in [
    // rust: ("villager", "entity/villager"),
    // rust: ("villager_baby", "entity/villager"),
    // rust: ("zombie_villager", "entity/zombie_villager"),
    // rust: ("zombie_villager_baby", "entity/zombie_villager"),
    // rust: ] {
    // rust: let model = load_model(Path::new(&root), &format!("minecraft:{name}#main")).unwrap();
    // rust: let no_hat =
    // rust: load_model(Path::new(&root), &format!("minecraft:{name}_no_hat#main")).unwrap();
    // rust: for (type_hat, profession_hat, hidden) in [
    // rust: (Hat::None, Hat::Full, true),
    // rust: (Hat::Full, Hat::Partial, true),
    // rust: (Hat::Partial, Hat::Partial, false),
    // rust: (Hat::Full, Hat::None, false),
    // rust: ] {
    // rust: hats.0.insert(format!("{folder}/type/plains"), type_hat);
    // rust: hats.0
    // rust: .insert(format!("{folder}/profession/farmer"), profession_hat);
    // rust: let mut poses = Poses::new(&model);
    // rust: hats.apply(folder, "plains", "farmer", &mut poses);
    // rust: let mut actual = Vec::new();
    // rust: draw(
    // rust: &model,
    // rust: glam::Mat4::IDENTITY,
    // rust: &poses,
    // rust: [0.0, 0.0, 1.0, 1.0],
    // rust: u32::MAX,
    // rust: 0,
    // rust: 0,
    // rust: &mut actual,
    // rust: );
    // rust: let expected_model = if hidden { &no_hat } else { &model };
    // rust: let mut expected = Vec::new();
    // rust: draw(
    // rust: expected_model,
    // rust: glam::Mat4::IDENTITY,
    // rust: &Poses::new(expected_model),
    // rust: [0.0, 0.0, 1.0, 1.0],
    // rust: u32::MAX,
    // rust: 0,
    // rust: 0,
    // rust: &mut expected,
    // rust: );
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&actual),
    // rust: bytemuck::cast_slice::<_, u8>(&expected),
    // rust: "{name}: {type_hat:?}/{profession_hat:?}"
    // rust: );
}
}
}
}
