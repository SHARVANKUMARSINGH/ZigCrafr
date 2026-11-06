//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_options_fixes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The `OPTIONS` data fixers of 26.3 (`DataFixTypes.OPTIONS`), applied to the
//! raw key/value strings of an `options.txt` older than the current version.
// use std::collections::HashMap;

/// A fixer threw an exception; vanilla abandons loading the file.
pub const FixFailed = struct {};

    // rust: pub type Raw = HashMap<String, String>;

/// OptionsKeyLwjgl3Fix.MAP: GLFW 2 key codes to key names.
    // rust: const LWJGL3: &[(i32, &str)] = &[
    // rust: (0, "key.unknown"),
    // rust: (11, "key.0"),
    // rust: (2, "key.1"),
    // rust: (3, "key.2"),
    // rust: (4, "key.3"),
    // rust: (5, "key.4"),
    // rust: (6, "key.5"),
    // rust: (7, "key.6"),
    // rust: (8, "key.7"),
    // rust: (9, "key.8"),
    // rust: (10, "key.9"),
    // rust: (30, "key.a"),
    // rust: (40, "key.apostrophe"),
    // rust: (48, "key.b"),
    // rust: (43, "key.backslash"),
    // rust: (14, "key.backspace"),
    // rust: (46, "key.c"),
    // rust: (58, "key.caps.lock"),
    // rust: (51, "key.comma"),
    // rust: (32, "key.d"),
    // rust: (211, "key.delete"),
    // rust: (208, "key.down"),
    // rust: (18, "key.e"),
    // rust: (207, "key.end"),
    // rust: (28, "key.enter"),
    // rust: (13, "key.equal"),
    // rust: (1, "key.escape"),
    // rust: (33, "key.f"),
    // rust: (59, "key.f1"),
    // rust: (68, "key.f10"),
    // rust: (87, "key.f11"),
    // rust: (88, "key.f12"),
    // rust: (100, "key.f13"),
    // rust: (101, "key.f14"),
    // rust: (102, "key.f15"),
    // rust: (103, "key.f16"),
    // rust: (104, "key.f17"),
    // rust: (105, "key.f18"),
    // rust: (113, "key.f19"),
    // rust: (60, "key.f2"),
    // rust: (61, "key.f3"),
    // rust: (62, "key.f4"),
    // rust: (63, "key.f5"),
    // rust: (64, "key.f6"),
    // rust: (65, "key.f7"),
    // rust: (66, "key.f8"),
    // rust: (67, "key.f9"),
    // rust: (34, "key.g"),
    // rust: (41, "key.grave.accent"),
    // rust: (35, "key.h"),
    // rust: (199, "key.home"),
    // rust: (23, "key.i"),
    // rust: (210, "key.insert"),
    // rust: (36, "key.j"),
    // rust: (37, "key.k"),
    // rust: (82, "key.keypad.0"),
    // rust: (79, "key.keypad.1"),
    // rust: (80, "key.keypad.2"),
    // rust: (81, "key.keypad.3"),
    // rust: (75, "key.keypad.4"),
    // rust: (76, "key.keypad.5"),
    // rust: (77, "key.keypad.6"),
    // rust: (71, "key.keypad.7"),
    // rust: (72, "key.keypad.8"),
    // rust: (73, "key.keypad.9"),
    // rust: (78, "key.keypad.add"),
    // rust: (83, "key.keypad.decimal"),
    // rust: (181, "key.keypad.divide"),
    // rust: (156, "key.keypad.enter"),
    // rust: (141, "key.keypad.equal"),
    // rust: (55, "key.keypad.multiply"),
    // rust: (74, "key.keypad.subtract"),
    // rust: (38, "key.l"),
    // rust: (203, "key.left"),
    // rust: (56, "key.left.alt"),
    // rust: (26, "key.left.bracket"),
    // rust: (29, "key.left.control"),
    // rust: (42, "key.left.shift"),
    // rust: (219, "key.left.win"),
    // rust: (50, "key.m"),
    // rust: (12, "key.minus"),
    // rust: (49, "key.n"),
    // rust: (69, "key.num.lock"),
    // rust: (24, "key.o"),
    // rust: (25, "key.p"),
    // rust: (209, "key.page.down"),
    // rust: (201, "key.page.up"),
    // rust: (197, "key.pause"),
    // rust: (52, "key.period"),
    // rust: (183, "key.print.screen"),
    // rust: (16, "key.q"),
    // rust: (19, "key.r"),
    // rust: (205, "key.right"),
    // rust: (184, "key.right.alt"),
    // rust: (27, "key.right.bracket"),
    // rust: (157, "key.right.control"),
    // rust: (54, "key.right.shift"),
    // rust: (220, "key.right.win"),
    // rust: (31, "key.s"),
    // rust: (70, "key.scroll.lock"),
    // rust: (39, "key.semicolon"),
    // rust: (53, "key.slash"),
    // rust: (57, "key.space"),
    // rust: (20, "key.t"),
    // rust: (15, "key.tab"),
    // rust: (22, "key.u"),
    // rust: (200, "key.up"),
    // rust: (47, "key.v"),
    // rust: (17, "key.w"),
    // rust: (45, "key.x"),
    // rust: (21, "key.y"),
    // rust: (44, "key.z"),
    // rust: ];

/// `Integer.parseInt(String)`.
pub fn java_parse_int(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let digits = text.strip_prefix(['+', '-']).unwrap_or(text);
    // rust: if digits.is_empty() || !digits.chars().all(|c| c.is_ascii_digit()) {
    // rust: return None;
}
    // rust: text.parse::<i32>().ok()
}

pub const Number = enum {
    Special(f64),
    Decimal(bool, &'a str),
};

pub fn java_number(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = text.trim_matches(|c: char| c <= ' ');
    // rust: let (negative, body) = match t.strip_prefix('-') {
    // rust: Some(rest) => (true, rest),
    // rust: None => (false, t.strip_prefix('+').unwrap_or(t)),
}
    // rust: match body {
    // rust: "NaN" => return Some(Number::Special(f64::NAN)),
    // rust: "Infinity" => {
    // rust: return Some(Number::Special(if negative {
    // rust: f64::NEG_INFINITY
    // rust: } else {
    // rust: f64::INFINITY
    // rust: }));
}
    // rust: _ => {}
}
    // rust: let body = body.strip_suffix(['f', 'F', 'd', 'D']).unwrap_or(body);
    // rust: if body.is_empty()
    // rust: || !body
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_digit() || matches!(c, '.' | 'e' | 'E' | '+' | '-'))
    // rust: || !body.chars().any(|c| c.is_ascii_digit())
    // rust: {
    // rust: return None;
}
    // rust: Some(Number::Decimal(negative, body))
}

/// `Double.parseDouble(String)` for decimal and special forms.
pub fn java_parse_double(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match java_number(text)? {
    // rust: Number::Special(v) => Some(v),
    // rust: Number::Decimal(negative, body) => body
    // rust: .parse::<f64>()
    // rust: .ok()
    // rust: .map(|v| if negative { -v } else { v }),
}
}

/// `Float.parseFloat(String)`.
pub fn java_parse_float(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match java_number(text)? {
    // rust: Number::Special(v) => Some(v as f32),
    // rust: Number::Decimal(negative, body) => body
    // rust: .parse::<f32>()
    // rust: .ok()
    // rust: .map(|v| if negative { -v } else { v }),
}
}

pub fn rename(raw: *mut Raw, from: []const u8, to: []const u8, fix: impl FnOnce([]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(old) = raw.remove(from) {
    // rust: let value = fix(&old);
    // rust: raw.insert(to.to_owned(), value);
}
}

/// `OPTIONS` fixers from `version` up to the current data version.
pub fn update(raw: *mut Raw, version: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if version < 816
    // rust: && let Some(lang) = raw.get_mut("lang")
    // rust: {
    // rust: *lang = lang.to_lowercase();
}
    // rust: if version < 1344 {
    // rust: let keys: Vec<String> = raw
    // rust: .keys()
    // rust: .filter(|k| k.starts_with("key_"))
    // rust: .cloned()
    // rust: .collect();
    // rust: for key in keys {
    // rust: let old = java_parse_int(&raw[&key]).ok_or(FixFailed)?;
    // rust: let name = if old < 0 {
    // rust: match old + 100 {
    // rust: 0 => "key.mouse.left".to_owned(),
    // rust: 1 => "key.mouse.right".to_owned(),
    // rust: 2 => "key.mouse.middle".to_owned(),
    // rust: button => format!("key.mouse.{}", button + 1),
}
    // rust: } else {
    // rust: LWJGL3
    // rust: .iter()
    // rust: .find(|(v, _)| *v == old)
    // rust: .map_or("key.unknown", |(_, n)| n)
    // rust: .to_owned()
}
    // rust: raw.insert(key, name);
}
}
    // rust: if version < 1446 {
    // rust: let keys: Vec<String> = raw
    // rust: .keys()
    // rust: .filter(|k| k.starts_with("key_"))
    // rust: .cloned()
    // rust: .collect();
    // rust: for key in keys {
    // rust: let old = raw[&key].clone();
    // rust: if !old.starts_with("key.mouse") && !old.starts_with("scancode.") {
                // substring(4) on a shorter value throws.
    // rust: let rest: String = old.chars().skip(4).collect();
    // rust: if old.chars().count() < 4 {
    // rust: return Err(FixFailed);
}
    // rust: raw.insert(key, format!("key.keyboard.{rest}"));
}
}
}
    // rust: if version < 1936
    // rust: && let Some(opacity) = raw.get("chatOpacity")
    // rust: {
    // rust: let background = java_parse_double(opacity).map_or(0.5, |v| (0.9 * v + 0.1) / 2.0);
    // rust: raw.insert(
    // rust: "textBackgroundOpacity".into(),
    // rust: crate::java_text::double_to_string(background),
    // rust: );
}
    // rust: if version < 2556 {
    // rust: rename(raw, "fancyGraphics", "graphicsMode", |v| {
    // rust: if v == "true" { "1" } else { "0" }.to_owned()
    // rust: });
}
    // rust: if version < 2558
    // rust: && let Some(v) = raw.remove("key_key.swapHands")
    // rust: {
    // rust: raw.insert("key_key.swapOffhand".into(), v);
}
    // rust: if version < 3201 {
    // rust: for key in ["resourcePacks", "incompatibleResourcePacks"] {
    // rust: if let Some(v) = raw.get_mut(key) {
    // rust: *v = v.replace("\"programer_art\"", "\"programmer_art\"");
}
}
}
    // rust: if version < 3214
    // rust: && let Some(ao) = raw.get_mut("ao")
    // rust: {
    // rust: match ao.as_str() {
    // rust: "0" => *ao = "false".into(),
    // rust: "1" | "2" => *ao = "true".into(),
    // rust: _ => {}
}
}
    // rust: if version < 3319 {
    // rust: raw.insert("onboardAccessibility".into(), "false".into());
}
    // rust: if version < 3943
    // rust: && let Some(v) = raw.get_mut("menuBackgroundBlurriness")
    // rust: {
    // rust: let value = java_parse_float(v).map_or(5, |d| ((d * 10.0) + 0.5).floor() as i32);
    // rust: *v = value.to_string();
}
    // rust: if version < 4651 {
    // rust: let mode = raw.get("graphicsMode").cloned();
    // rust: for (name, fast, fancy, fabulous) in [
    // rust: ("cutoutLeaves", "false", "true", "true"),
    // rust: ("weatherRadius", "5", "10", "10"),
    // rust: ("vignette", "false", "true", "true"),
    // rust: ("improvedTransparency", "false", "false", "true"),
    // rust: ] {
    // rust: let value = match mode.as_deref() {
    // rust: Some("2") => fabulous,
    // rust: Some("0") => fast,
    // rust: _ => fancy,
}
    // rust: raw.insert(name.into(), value.into());
}
    // rust: raw.insert("graphicsPreset".into(), "custom".into());
}
    // rust: if version < 4661 {
    // rust: rename(raw, "showNowPlayingToast", "musicToast", |v| {
    // rust: if v == "false" {
    // rust: "never"
    // rust: } else {
    // rust: "pause_and_toast"
}
    // rust: .to_owned()
    // rust: });
}
    // rust: if version < 4892 {
    // rust: raw.insert("preferredGraphicsBackend".into(), "default".into());
}
    // rust: Ok(())
}
