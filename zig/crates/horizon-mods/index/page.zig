//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_page
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A project page's rules (docs/design/registry-v2.md): its categories, tags,
//! description and images. Shared by the registry's CI ([`super::registry`]),
//! the submission service and the index's readers.
// use super::Kind;

/// At most this many categories, at least one ([`check_required`]).
pub const MAX_CATEGORIES: usize = 3;
pub const MAX_TAGS: usize = 10;
pub const MAX_TAG: usize = 24;
pub const MAX_SCREENSHOTS: usize = 8;
pub const MIN_DESCRIPTION: usize = 50;
pub const MAX_DESCRIPTION: usize = 10_000;
/// The biggest screenshot file.
pub const MAX_SCREENSHOT: u64 = 1 << 20;
/// A screenshot's smallest and biggest size, in pixels.
pub const SCREENSHOT_MIN: (u32, u32) = (320, 180);
pub const SCREENSHOT_MAX: (u32, u32) = (3840, 2160);
/// An icon is square, this many pixels a side.
pub const ICON_SIDE: std::ops::RangeInclusive<u32> = 64..=1024;

    // rust: const MODS: &[&str] = &[
    // rust: "adventure",
    // rust: "decoration",
    // rust: "economy",
    // rust: "equipment",
    // rust: "food",
    // rust: "game-mechanics",
    // rust: "library",
    // rust: "magic",
    // rust: "management",
    // rust: "minigame",
    // rust: "mobs",
    // rust: "optimization",
    // rust: "social",
    // rust: "storage",
    // rust: "technology",
    // rust: "transportation",
    // rust: "utility",
    // rust: "worldgen",
    // rust: ];
    // rust: const MODPACKS: &[&str] = &[
    // rust: "adventure",
    // rust: "challenging",
    // rust: "combat",
    // rust: "kitchen-sink",
    // rust: "lightweight",
    // rust: "magic",
    // rust: "multiplayer",
    // rust: "optimization",
    // rust: "quests",
    // rust: "technology",
    // rust: ];
    // rust: const RESOURCE_PACKS: &[&str] = &[
    // rust: "8x",
    // rust: "16x",
    // rust: "32x",
    // rust: "48x",
    // rust: "64x",
    // rust: "128x",
    // rust: "256x",
    // rust: "512x",
    // rust: "audio",
    // rust: "blocks",
    // rust: "combat",
    // rust: "core-shaders",
    // rust: "decoration",
    // rust: "entities",
    // rust: "environment",
    // rust: "equipment",
    // rust: "fonts",
    // rust: "gui",
    // rust: "items",
    // rust: "locale",
    // rust: "models",
    // rust: "realistic",
    // rust: "simplistic",
    // rust: "themed",
    // rust: "tweaks",
    // rust: "utility",
    // rust: "vanilla-like",
    // rust: ];
    // rust: const SHADERS: &[&str] = &[
    // rust: "cartoon",
    // rust: "fantasy",
    // rust: "realistic",
    // rust: "semi-realistic",
    // rust: "vanilla-like",
    // rust: "atmosphere",
    // rust: "bloom",
    // rust: "colored-lighting",
    // rust: "foliage",
    // rust: "path-tracing",
    // rust: "pbr",
    // rust: "reflections",
    // rust: "shadows",
    // rust: "potato",
    // rust: "low",
    // rust: "medium",
    // rust: "high",
    // rust: "screenshot",
    // rust: ];

/// Words a tag may not hold: no listing is about gambling (Mojang's Usage
/// Guidelines name it for every use).
    // rust: const REFUSED_TAG_WORDS: &[&str] = &[
    // rust: "casino",
    // rust: "gambl",
    // rust: "slot-machine",
    // rust: "lottery",
    // rust: "betting",
    // rust: "jackpot",
    // rust: "roulette",
    // rust: "poker",
    // rust: ];

/// The categories a project of `kind` picks from: Modrinth's lists, without
/// `cursed`. Empty for a kind this build doesn't know.
pub fn categories(kind: *Kind) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: Kind::Mod | Kind::NativeMod | Kind::DataPack => MODS,
    // rust: Kind::Modpack => MODPACKS,
    // rust: Kind::ResourcePack => RESOURCE_PACKS,
    // rust: Kind::Shader | Kind::ShaderPack => SHADERS,
    // rust: Kind::Other(_) => &[],
}
}

/// `[a-z0-9][a-z0-9-]*`, at most [`MAX_TAG`] long.
pub fn plain_tag(tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.len() <= MAX_TAG
    // rust: && tag
    // rust: .bytes()
    // rust: .next()
    // rust: .is_some_and(|b| b.is_ascii_lowercase() || b.is_ascii_digit())
    // rust: && tag
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'-')
}

/// Every problem with a page's description, categories and tags, each a
/// sentence a submitter can act on.
    // rust: pub fn check(
    // rust: kind: &Kind,
    // rust: description: &str,
    // rust: categories: &[String],
    // rust: tags: &[String],
    // rust: ) -> Vec<String> {
    // rust: let mut errors = Vec::new();
    // rust: let length = description.trim().chars().count();
    // rust: if length > MAX_DESCRIPTION {
    // rust: errors.push(format!(
    // rust: "the description is {length} characters: at most {MAX_DESCRIPTION}"
    // rust: ));
}
    // rust: let known = self::categories(kind);
    // rust: if categories.len() > MAX_CATEGORIES {
    // rust: errors.push(format!(
    // rust: "{} categories: pick at most {MAX_CATEGORIES}",
    // rust: categories.len()
    // rust: ));
}
    // rust: for (i, c) in categories.iter().enumerate() {
    // rust: if !known.contains(&c.as_str()) {
    // rust: errors.push(format!(
    // rust: "{c:?} is not a category of a {}: {}",
    // rust: kind.name(),
    // rust: known.join(", ")
    // rust: ));
    // rust: } else if categories[..i].contains(c) {
    // rust: errors.push(format!("category {c:?} is listed twice"));
}
}
    // rust: if tags.len() > MAX_TAGS {
    // rust: errors.push(format!("{} tags: at most {MAX_TAGS}", tags.len()));
}
    // rust: for (i, t) in tags.iter().enumerate() {
    // rust: if !plain_tag(t) {
    // rust: errors.push(format!(
    // rust: "tag {t:?}: lowercase letters, digits and '-', at most {MAX_TAG} characters"
    // rust: ));
    // rust: } else if REFUSED_TAG_WORDS.iter().any(|w| t.contains(w)) {
    // rust: errors.push(format!(
    // rust: "tag {t:?}: the registry lists nothing about gambling"
    // rust: ));
    // rust: } else if tags[..i].contains(t) {
    // rust: errors.push(format!("tag {t:?} is listed twice"));
}
}
    // rust: errors
}

/// What every listed page must have: a description of [`MIN_DESCRIPTION`] characters or more, a
/// category, and an icon kept in the registry (`icons/`), screenshots too: the site and the launcher
/// load images only from the registry's own host.
    // rust: pub fn check_required(
    // rust: id: &str,
    // rust: description: &str,
    // rust: categories: &[String],
    // rust: icon: Option<&str>,
    // rust: screenshots: &[String],
    // rust: ) -> Vec<String> {
    // rust: let mut errors = Vec::new();
    // rust: let length = description.trim().chars().count();
    // rust: if length < MIN_DESCRIPTION {
    // rust: errors.push(format!(
    // rust: "the description is {length} characters: write at least {MIN_DESCRIPTION} (what it does, how to use it)"
    // rust: ));
}
    // rust: if categories.is_empty() {
    // rust: errors.push(format!("pick 1 to {MAX_CATEGORIES} categories"));
}
    // rust: match icon {
    // rust: None => errors.push("has no icon: icons/<id>.png, a square PNG".into()),
    // rust: Some(icon) if icon != format!("icons/{id}.png") => errors.push(format!(
    // rust: "its icon {icon:?} must be kept in the registry as icons/{id}.png"
    // rust: )),
    // rust: Some(_) => {}
}
    // rust: for s in screenshots
    // rust: .iter()
    // rust: .filter(|s| !s.starts_with("screenshots/"))
    // rust: {
    // rust: errors.push(format!(
    // rust: "screenshot {s:?} must be kept in the registry, screenshots/<id>/"
    // rust: ));
}
    // rust: errors
}

/// An image's format.
pub const Image = enum {
    Png,
    Jpeg,
};

    // rust: impl Image {
    /// The extensions its files carry.
pub fn extensions(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Image::Png => &["png"],
    // rust: Image::Jpeg => &["jpg", "jpeg"],
}
}
}

/// The format and size in pixels of a PNG or a JPEG, read from its header;
/// None for anything else.
pub fn image_size(bytes: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
pub const PNG: []const u8 = b"\x89PNG\r\n\x1a\n";
    // rust: if bytes.starts_with(PNG) && bytes.get(12..16) == Some(b"IHDR") {
    // rust: let w = u32::from_be_bytes(bytes.get(16..20)?.try_into().ok()?);
    // rust: let h = u32::from_be_bytes(bytes.get(20..24)?.try_into().ok()?);
    // rust: return Some((Image::Png, w, h));
}
    // rust: if !bytes.starts_with(&[0xff, 0xd8]) {
    // rust: return None;
}
    // JPEG: walk the segments to the first start-of-frame.
    // rust: let mut at = 2;
    // rust: loop {
    // rust: while *bytes.get(at)? == 0xff && *bytes.get(at + 1)? == 0xff {
    // rust: at += 1;
}
    // rust: if *bytes.get(at)? != 0xff {
    // rust: return None;
}
    // rust: let marker = *bytes.get(at + 1)?;
    // rust: let length = u16::from_be_bytes([*bytes.get(at + 2)?, *bytes.get(at + 3)?]) as usize;
    // rust: let frame = matches!(marker, 0xc0..=0xcf) && !matches!(marker, 0xc4 | 0xc8 | 0xcc);
    // rust: if frame {
    // rust: let h = u16::from_be_bytes([*bytes.get(at + 5)?, *bytes.get(at + 6)?]);
    // rust: let w = u16::from_be_bytes([*bytes.get(at + 7)?, *bytes.get(at + 8)?]);
    // rust: return Some((Image::Jpeg, u32::from(w), u32::from(h)));
}
    // rust: if length < 2 {
    // rust: return None;
}
    // rust: at += 2 + length;
}
}

/// Checks an icon's bytes: a square PNG of [`ICON_SIDE`] pixels.
pub fn check_icon(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match image_size(bytes) {
    // rust: Some((Image::Png, w, h)) if w == h && ICON_SIDE.contains(&w) => Ok(()),
    // rust: Some((Image::Png, w, h)) => Err(format!(
    // rust: "the icon is {w}×{h}: make it square, {} to {} pixels a side",
    // rust: ICON_SIDE.start(),
    // rust: ICON_SIDE.end()
    // rust: )),
    // rust: _ => Err("the icon must be a PNG".into()),
}
}

/// Checks a screenshot's bytes and its file name's extension: a PNG or a
/// JPEG within [`SCREENSHOT_MIN`] and [`SCREENSHOT_MAX`], at most
/// [`MAX_SCREENSHOT`] bytes.
pub fn check_screenshot(name: []const u8, bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if bytes.len() as u64 > MAX_SCREENSHOT {
    // rust: return Err(format!(
    // rust: "{name}: {} KiB, at most {} KiB",
    // rust: bytes.len() >> 10,
    // rust: MAX_SCREENSHOT >> 10
    // rust: ));
}
    // rust: let Some((format, w, h)) = image_size(bytes) else {
    // rust: return Err(format!("{name}: not a PNG or a JPEG"));
}
    // rust: let extension = name.rsplit_once('.').map(|(_, e)| e.to_ascii_lowercase());
    // rust: if !extension.is_some_and(|e| format.extensions().contains(&e.as_str())) {
    // rust: return Err(format!(
    // rust: "{name}: its extension isn't .{}",
    // rust: format.extensions()[0]
    // rust: ));
}
    // rust: let ((min_w, min_h), (max_w, max_h)) = (SCREENSHOT_MIN, SCREENSHOT_MAX);
    // rust: if w < min_w || h < min_h || w > max_w || h > max_h {
    // rust: return Err(format!(
    // rust: "{name}: {w}×{h} pixels, from {min_w}×{min_h} to {max_w}×{max_h}"
    // rust: ));
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

pub fn strings(list: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: list.iter().map(|s| (*s).to_owned()).collect()
}

pub fn categories_are_the_kinds_own() void {
}
    // rust: let ok = check(&Kind::Mod, "", &strings(&["magic", "mobs"]), &[]);
    // rust: assert!(ok.is_empty(), "{ok:?}");
        // A shader category on a mod, a repeat, and one too many.
    // rust: let wrong = check(&Kind::Mod, "", &strings(&["bloom"]), &[]);
    // rust: assert!(wrong[0].contains("not a category of a mod"), "{wrong:?}");
    // rust: let twice = check(&Kind::Shader, "", &strings(&["pbr", "pbr"]), &[]);
    // rust: assert_eq!(twice, ["category \"pbr\" is listed twice"]);
    // rust: let many = check(
    // rust: &Kind::Mod,
    // rust: "",
    // rust: &strings(&["magic", "mobs", "food", "storage"]),
    // rust: &[],
    // rust: );
    // rust: assert_eq!(many, ["4 categories: pick at most 3"]);
    // rust: assert!(categories(&Kind::Other("world".into())).is_empty());
}

pub fn tags_are_plain_and_never_about_gambling() void {
}
    // rust: let ok = check(&Kind::Mod, "", &[], &strings(&["bosses", "1-21"]));
    // rust: assert!(ok.is_empty(), "{ok:?}");
    // rust: for bad in ["Bosses", "two words", "-x", "", &"a".repeat(25)] {
    // rust: assert_eq!(
    // rust: check(&Kind::Mod, "", &[], &[bad.to_owned()]).len(),
    // rust: 1,
    // rust: "{bad:?}"
    // rust: );
}
    // rust: let casino = check(&Kind::Mod, "", &[], &strings(&["casino-games"]));
    // rust: assert!(casino[0].contains("gambling"), "{casino:?}");
    // rust: let eleven: Vec<String> = (0..11).map(|i| format!("t{i}")).collect();
    // rust: assert_eq!(check(&Kind::Mod, "", &[], &eleven), ["11 tags: at most 10"]);
}

pub fn a_listed_page_is_complete_and_its_images_are_ours() void {
}
    // rust: let text = "x".repeat(MIN_DESCRIPTION);
    // rust: let ok = check_required(
    // rust: "a",
    // rust: &text,
    // rust: &strings(&["mobs"]),
    // rust: Some("icons/a.png"),
    // rust: &strings(&["screenshots/a/1.png"]),
    // rust: );
    // rust: assert!(ok.is_empty(), "{ok:?}");
    // rust: let all = check_required("a", "short", &[], None, &[]);
    // rust: assert_eq!(all.len(), 3, "{all:?}");
    // rust: let far = check_required(
    // rust: "a",
    // rust: &text,
    // rust: &strings(&["mobs"]),
    // rust: Some("https://x.test/i.png"),
    // rust: &strings(&["https://x.test/1.png"]),
    // rust: );
    // rust: assert_eq!(far.len(), 2, "{far:?}");
    // rust: let other_icon = check_required("a", &text, &strings(&["mobs"]), Some("icons/b.png"), &[]);
    // rust: assert_eq!(other_icon.len(), 1, "{other_icon:?}");
}

pub fn a_description_has_a_ceiling() void {
}
    // rust: let long = "x".repeat(MAX_DESCRIPTION + 1);
    // rust: assert_eq!(check(&Kind::Mod, &long, &[], &[]).len(), 1);
    // rust: assert!(check(&Kind::Mod, &"x".repeat(MAX_DESCRIPTION), &[], &[]).is_empty());
}

pub fn png(w: u32, h: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut b = b"\x89PNG\r\n\x1a\n\0\0\0\rIHDR".to_vec();
    // rust: b.extend(w.to_be_bytes());
    // rust: b.extend(h.to_be_bytes());
    // rust: b.extend([8, 6, 0, 0, 0]);
    // rust: b
}

pub fn jpeg(w: u16, h: u16) V {
    // Implementation ported from Horizon
    return undefined;
}
        // SOI, an APP0 segment of 16 bytes, then a baseline SOF0.
    // rust: let mut b = vec![0xff, 0xd8, 0xff, 0xe0, 0, 16];
    // rust: b.extend([0; 14]);
    // rust: b.extend([0xff, 0xc0, 0, 17, 8]);
    // rust: b.extend(h.to_be_bytes());
    // rust: b.extend(w.to_be_bytes());
    // rust: b.extend([3; 12]);
    // rust: b
}

pub fn image_headers_give_their_size() void {
}
    // rust: assert_eq!(image_size(&png(256, 128)), Some((Image::Png, 256, 128)));
    // rust: assert_eq!(
    // rust: image_size(&jpeg(1920, 1080)),
    // rust: Some((Image::Jpeg, 1920, 1080))
    // rust: );
    // rust: assert_eq!(image_size(b"GIF89a"), None);
    // rust: assert_eq!(image_size(&[0xff, 0xd8, 0xff]), None);
}

pub fn icons_are_square_pngs() void {
}
    // rust: assert!(check_icon(&png(256, 256)).is_ok());
    // rust: assert!(check_icon(&png(256, 128)).unwrap_err().contains("square"));
    // rust: assert!(check_icon(&png(32, 32)).is_err());
    // rust: assert!(check_icon(&jpeg(256, 256)).unwrap_err().contains("PNG"));
}

pub fn screenshots_are_bounded() void {
}
    // rust: assert!(check_screenshot("1.jpg", &jpeg(1920, 1080)).is_ok());
    // rust: assert!(check_screenshot("1.png", &png(1280, 720)).is_ok());
    // rust: assert!(
    // rust: check_screenshot("1.png", &jpeg(1920, 1080))
    // rust: .unwrap_err()
    // rust: .contains(".jpg")
    // rust: );
    // rust: assert!(
    // rust: check_screenshot("1.png", &png(100, 100))
    // rust: .unwrap_err()
    // rust: .contains("pixels")
    // rust: );
    // rust: assert!(check_screenshot("1.png", &png(7680, 4320)).is_err());
    // rust: let mut big = png(1920, 1080);
    // rust: big.resize(MAX_SCREENSHOT as usize + 1, 0);
    // rust: assert!(check_screenshot("1.png", &big).unwrap_err().contains("KiB"));
}
}
