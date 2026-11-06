//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_wgsl_prefix
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Copies of the renderer's own WGSL that run beside a shader pack's code in one module (the
//! sky and material stages of Horizon's packs, docs/shaders.md): every name such a copy
//! declares takes a prefix starting with `horizon_`, which the pack check refuses in a pack,
//! so no pack name can meet one of Horizon's.

/// terrain.wgsl, which the copies are taken from.
pub const TERRAIN: []const u8 = include_str!("../terrain.wgsl");

/// The text of `source` from the line starting with `start` up to (not including) the one
/// starting with `end`.
    // rust: pub fn section<'a>(source: &'a str, start: &str, end: &str) -> &'a str {
    // rust: let from = source
    // rust: .find(&format!("\n{start}"))
    // rust: .expect("the source has the section")
    // rust: + 1;
    // rust: let to = from
    // rust: + source[from..]
    // rust: .find(&format!("\n{end}"))
    // rust: .expect("the source ends the section")
    // rust: + 1;
    // rust: &source[from..to]
}

/// The names `text` declares at its top level: functions, structs, constants, overrides and
/// module variables (bindings).
pub fn declared(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut names = Vec::new();
    // rust: for line in text.lines() {
        // Top level only: a function's own `var` and `let` stay as they are.
    // rust: if line.starts_with(char::is_whitespace) {
    // rust: continue;
}
    // rust: let mut line = line;
    // rust: while let Some(rest) = line.strip_prefix('@') {
            // An attribute: `@vertex`, `@group(0)`, `@binding(1)`.
    // rust: let end = rest.find(' ').unwrap_or(rest.len());
    // rust: line = rest[end..].trim_start();
}
    // rust: let rest = ["fn ", "struct ", "const ", "override ", "var "]
    // rust: .iter()
    // rust: .find_map(|k| line.strip_prefix(k))
    // rust: .or_else(|| {
                // `var<uniform> name`, `var<storage, read> name`.
    // rust: let rest = line.strip_prefix("var<")?;
    // rust: Some(rest[rest.find('>')? + 1..].trim_start())
    // rust: });
    // rust: if let Some(rest) = rest {
    // rust: let end = rest
    // rust: .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
    // rust: .unwrap_or(rest.len());
    // rust: names.push(&rest[..end]);
}
}
    // rust: names
}

/// `text` with every name it declares at its top level, and every use of one, prefixed by
/// `prefix`. Comments are rewritten too, which is harmless.
pub fn prefixed(text: []const u8, prefix: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = declared(text);
    // rust: let mut out = String::with_capacity(text.len() * 2);
    // rust: let mut word = String::new();
    // rust: let flush = |word: &mut String, out: &mut String| {
    // rust: if names.contains(&word.as_str()) {
    // rust: out.push_str(prefix);
}
    // rust: out.push_str(word);
    // rust: word.clear();
}
    // rust: for c in text.chars() {
    // rust: if c.is_ascii_alphanumeric() || c == '_' {
    // rust: word.push(c);
    // rust: } else {
    // rust: flush(&mut word, &mut out);
    // rust: out.push(c);
}
}
    // rust: flush(&mut word, &mut out);
    // rust: out
}

    // rust: mod tests {
//     use super::*;

pub fn prefixes_top_level_names_and_their_uses_only() void {
}
    // rust: let text = "struct S { a: f32, }\n\
    // rust: @group(0) @binding(0) var<uniform> g: S;\n\
    // rust: @group(1) @binding(2) var<storage, read> list: array<u32>;\n\
    // rust: override N: u32 = 1u;\n\
pub const K: f32 = 2.0;
    // rust: @fragment fn f(x: f32) -> @location(0) vec4<f32> {\n    \
    // rust: var a = g.a * K;\n    \
    // rust: return vec4(a + f32(list[N]) + x);\n\
    // rust: }\n";
    // rust: let out = prefixed(text, "p_");
    // rust: assert_eq!(
    // rust: out,
    // rust: "struct p_S { a: f32, }\n\
    // rust: @group(0) @binding(0) var<uniform> p_g: p_S;\n\
    // rust: @group(1) @binding(2) var<storage, read> p_list: array<u32>;\n\
    // rust: override p_N: u32 = 1u;\n\
pub const p_K: f32 = 2.0;
    // rust: @fragment fn p_f(x: f32) -> @location(0) vec4<f32> {\n    \
    // rust: var a = p_g.a * p_K;\n    \
    // rust: return vec4(a + f32(p_list[p_N]) + x);\n\
    // rust: }\n"
    // rust: );
        // Every top-level declaration of terrain.wgsl is found.
    // rust: let names = declared(TERRAIN);
    // rust: for name in [
    // rust: "Globals",
    // rust: "globals",
    // rust: "sprites_7",
    // rust: "SPRITE_SPLIT",
    // rust: "block_slots",
    // rust: "fs_sky",
    // rust: ] {
    // rust: assert!(names.contains(&name), "{name}");
}
    // rust: assert!(!names.contains(&"out"));
}
}
