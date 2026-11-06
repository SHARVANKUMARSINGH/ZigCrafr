//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_macros
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Object-like macros: the ones packs test in `#if` lines and use inside property values
//! (spec 1.5, 1.5.1). The GLSL preprocessor's function-like macros are not needed here.

// use std::collections::BTreeMap;

/// The Iris feature flags (`iris.features.*`) Horizon has. `BLOCK_EMISSION_ATTRIBUTE`: terrain's
/// `at_midBlock.w` is the light its block gives. `SEPARATE_HARDWARE_SAMPLERS` (ShaderDoc,
/// "Separate Hardware Shadow Samplers"): `shadowtex0`/`shadowtex1` stay plain depth samplers when
/// hardware filtering is on, `shadowtex0HW`/`shadowtex1HW` compare; Horizon picks a comparison
/// sampler by the declared type (`sampler2DShadow`), so they always are. `HIGHER_SHADOWCOLOR`:
/// `shadowcolor2` to `shadowcolor7` beside the first two. `FADE_VARIABLE`: terrain vertex
/// programs can read the section's visibility transition as `mc_chunkFade`.
    // rust: const FEATURES: [&str; 9] = [
    // rust: "BLOCK_EMISSION_ATTRIBUTE",
    // rust: "COMPUTE_SHADERS",
    // rust: "CUSTOM_IMAGES",
    // rust: "ENTITY_TRANSLUCENT",
    // rust: "FADE_VARIABLE",
    // rust: "HIGHER_SHADOWCOLOR",
    // rust: "REVERSED_CULLING",
    // rust: "SEPARATE_HARDWARE_SAMPLERS",
    // rust: "SSBO",
    // rust: ];

/// Whether `name` is one of [`FEATURES`], in any case.
pub fn is_feature(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FEATURES.iter().any(|f| f.eq_ignore_ascii_case(name))
}

/// `MC_VERSION` of the version Horizon plays: 26.3 → 260300.
pub const MC_VERSION: u32 = mc_version(horizon_core::version::VERSION_ID);

/// The documented rule, `major * 10000 + minor * 100 + patch` (spec 1.5.1, OQ-1): `1.21` → 12100,
/// `1.7.10` → 10710. Parts that are not digits count as 0.
    // rust: pub const fn mc_version(id: &str) -> u32 {
    // rust: let bytes = id.as_bytes();
    // rust: let (mut parts, mut part, mut i) = ([0u32; 3], 0, 0);
    // rust: while i < bytes.len() && part < 3 {
    // rust: match bytes[i] {
    // rust: b'.' => part += 1,
    // rust: b @ b'0'..=b'9' => parts[part] = parts[part] * 10 + (b - b'0') as u32,
    // rust: _ => break,
}
    // rust: i += 1;
}
    // rust: parts[0] * 10000 + parts[1] * 100 + parts[2]
}

pub const Macro = struct {
    /// `None` for an object-like macro; the parameter names of a function-like one.
    params: ?std.ArrayList([]const u8),
    body: []const u8,
};

pub const Macros = struct {};

/// `MC_RENDER_STAGE_*` in the order the stages draw (spec 5.4); each is its index (OQ-7).
    // rust: pub const RENDER_STAGES: [&str; 24] = [
    // rust: "NONE",
    // rust: "SKY",
    // rust: "SUNSET",
    // rust: "CUSTOM_SKY",
    // rust: "SUN",
    // rust: "MOON",
    // rust: "STARS",
    // rust: "VOID",
    // rust: "TERRAIN_SOLID",
    // rust: "TERRAIN_CUTOUT_MIPPED",
    // rust: "TERRAIN_CUTOUT",
    // rust: "ENTITIES",
    // rust: "BLOCK_ENTITIES",
    // rust: "DESTROY",
    // rust: "OUTLINE",
    // rust: "DEBUG",
    // rust: "HAND_SOLID",
    // rust: "TERRAIN_TRANSLUCENT",
    // rust: "TRIPWIRE",
    // rust: "PARTICLES",
    // rust: "CLOUDS",
    // rust: "RAIN_SNOW",
    // rust: "WORLD_BORDER",
    // rust: "HAND_TRANSLUCENT",
    // rust: ];

/// The value of `MC_RENDER_STAGE_<name>` (OQ-7: its index in `RENDER_STAGES`).
pub fn render_stage(name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: RENDER_STAGES
    // rust: .iter()
    // rust: .position(|s| *s == name)
    // rust: .unwrap_or_else(|| panic!("no render stage {name}")) as u32
}

    // rust: impl Macros {
    /// The standard macros that need no renderer (spec 1.5.1): `MC_VERSION`, this system's
    /// `MC_OS_*`, the GL and GLSL versions Iris reports, the render stages and the host
    /// settings at their defaults. The GPU vendor and family arrive with the renderer
    /// (`define_renderer`).
pub fn standard() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut m = Self::default();
    // rust: m.define("MC_VERSION", MC_VERSION.to_string());
    // rust: let os = match std::env::consts::OS {
    // rust: "windows" => "MC_OS_WINDOWS",
    // rust: "macos" => "MC_OS_MAC",
    // rust: "linux" => "MC_OS_LINUX",
    // rust: _ => "MC_OS_OTHER",
}
    // rust: m.define(os, "");
        // What Iris 1.11.7 reports on 26.3, whatever the pack's `#version` (observed with a probe
        // pack): its GL context's 3.3. Packs then take the paths they take there; the
        // translation itself reads GLSL up to 4.60.
    // rust: m.define("MC_GL_VERSION", "330");
    // rust: m.define("MC_GLSL_VERSION", "330");
    // rust: for (i, stage) in RENDER_STAGES.iter().enumerate() {
    // rust: m.define(format!("MC_RENDER_STAGE_{stage}"), i.to_string());
}
    // rust: m.define("MC_RENDER_QUALITY", "1.0");
    // rust: m.define("MC_SHADOW_QUALITY", "1.0");
    // rust: m.define("MC_HAND_DEPTH", "0.125");
    // rust: m.define("MAX_COLOR_BUFFERS", "16");
        // The normal and specular maps are on (OptiFine's shaders.txt, H: their options, on by
        // default; Iris 1.11.7 defines both too, with or without a resource pack's maps).
    // rust: m.define("MC_NORMAL_MAP", "");
    // rust: m.define("MC_SPECULAR_MAP", "");
        // Packs take Iris's extensions (compute programs, images, custom textures) where this
        // is defined.
    // rust: m.define("IS_IRIS", "");
        // Iris 1.11.7's own, as it defines them on 26.3 (observed with a probe pack): its version
        // (1.11.7 as 11107), and translucent terrain sorted back to front, as Horizon sorts it
        // (vanilla's `VertexSorting.byDistance`, `gfx/translucency.rs`).
    // rust: m.define("IRIS_VERSION", "11107");
    // rust: m.define("IRIS_HAS_TRANSLUCENCY_SORTING", "");
    // rust: m
}

    /// The macros the renderer adds: the mipmap levels terrain is drawn with (`MC_MIPMAP_LEVEL`,
    /// Iris's: it follows the Mipmap Levels option), and `OTHER` as the GL vendor and renderer
    /// (OptiFine's shaders.txt, E and F: one of each is defined). Horizon draws through wgpu, not
    /// a GL driver, so a pack's paths for one driver (an NVIDIA extension it takes behind
    /// `MC_GL_VENDOR_NVIDIA`) are not there to take.
pub fn define_renderer(self: *Self, mipmap_levels: u32) void {
}
    // rust: self.define("MC_GL_VENDOR_OTHER", "");
    // rust: self.define("MC_GL_RENDERER_OTHER", "");
    // rust: self.define("MC_MIPMAP_LEVEL", mipmap_levels.to_string());
}

    /// Every feature Horizon has, as `IRIS_FEATURE_<name>`: what `shaders.properties` itself is
    /// read with. Iris 1.11.7 defines a feature it has there whether the pack lists it as
    /// optional, as required or not at all (probe pack), while its programs see only the optional
    /// ones (`define_features`).
pub fn define_every_feature(self: *Self) void {
}
    // rust: for feature in FEATURES {
    // rust: self.define(format!("IRIS_FEATURE_{feature}"), "");
}
}

    /// `iris.features.optional`'s features Horizon has, as `IRIS_FEATURE_<name>`; a note for
    /// each feature `iris.features.required` names that it lacks. As in Iris 1.11.7, a name
    /// matches in any case, and the macro keeps the name as the pack wrote it (`ssbo` defines
    /// `IRIS_FEATURE_ssbo`).
pub fn define_features(self: *Self, properties: *crate::Properties) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let words = |key: &str| {
    // rust: properties
    // rust: .get(key)
    // rust: .map(|v| v.split_whitespace().map(str::to_owned).collect::<Vec<_>>())
    // rust: .unwrap_or_default()
}
    // rust: for feature in words("iris.features.optional") {
    // rust: if is_feature(&feature) {
    // rust: self.define(format!("IRIS_FEATURE_{feature}"), "");
}
}
    // rust: words("iris.features.required")
    // rust: .into_iter()
    // rust: .filter(|f| !is_feature(f))
    // rust: .map(|f| format!("the pack requires `{f}`, which is not supported yet"))
    // rust: .collect()
}

pub fn define(self: *Self, name: impl Into<[]const u8>, value: impl Into<[]const u8>) void {
}
    // rust: let body = value.into();
    // rust: self.0.insert(name.into(), Macro { params: None, body });
}

    /// The rest of a `#define` line: `NAME body`, or `NAME(a, b) body` (no space before the `(`)
    /// for a function-like macro.
    // rust: pub(crate) fn define_line(&mut self, rest: &str) -> Result<(), String> {
    // rust: let len = rest
    // rust: .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
    // rust: .unwrap_or(rest.len());
    // rust: let (name, tail) = rest.split_at(len);
    // rust: if name.is_empty() {
    // rust: return Err("`#define` without a name".into());
}
    // rust: if let Some(params) = tail.strip_prefix('(') {
    // rust: let Some((params, body)) = params.split_once(')') else {
    // rust: return Err(format!("`#define {name}(` without `)`"));
}
    // rust: let params = params
    // rust: .split(',')
    // rust: .map(|p| p.trim().to_owned())
    // rust: .filter(|p| !p.is_empty())
    // rust: .collect();
    // rust: self.define_function(name, params, body.trim());
    // rust: } else {
    // rust: self.define(name, tail.trim());
}
    // rust: Ok(())
}

pub fn define_function(self: *Self, name: []const u8, params: std.ArrayList([]const u8), body: []const u8) void {
}
    // rust: let body = body.to_owned();
    // rust: self.0.insert(
    // rust: name.to_owned(),
    // rust: Macro {
    // rust: params: Some(params),
    // rust: body,
    // rust: },
    // rust: );
}

pub fn undef(self: *Self, name: []const u8) void {
}
    // rust: self.0.remove(name);
}

pub fn is_defined(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.contains_key(name)
}

    /// The value of an object-like macro.
pub fn get(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
    // rust: .get(name)
    // rust: .filter(|m| m.params.is_none())
    // rust: .map(|m| m.body.as_str())
}

    /// Whether upcoming source lines continue a call, including one whose expanded name
    /// ends `text` and whose opening parenthesis is on the next nonempty line.
    // rust: pub(crate) fn unfinished_call(&self, text: &str, upcoming: &[&str]) -> bool {
    // rust: let (tokens, unfinished) = self.expand_tokens(expansion_tokens(text));
    // rust: unfinished
    // rust: || (tokens.iter().rfind(|t| !t.blank()).is_some_and(|t| {
    // rust: self.0.get_key_value(&t.text).is_some_and(|(name, m)| {
    // rust: m.params.is_some() && !t.hidden.contains(&name.as_str())
    // rust: })
    // rust: }) && upcoming
    // rust: .iter()
    // rust: .map(|line| line.trim_start())
    // rust: .find(|line| !line.is_empty())
    // rust: .is_some_and(|line| line.starts_with('(')))
}

    /// `text` with every macro expanded, repeatedly; a macro is not expanded again inside its own
    /// expansion, so `A` defined as `A + 1` stops. Function-like macros take their arguments
    /// (expanded first, raw beside `##`, which pastes) when a `(` follows their name.
pub fn expand(self: *Self, text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.expand_tokens(expansion_tokens(text))
    // rust: .0
    // rust: .iter()
    // rust: .map(|t| t.text.as_str())
    // rust: .collect()
}

    // rust: fn expand_tokens<'a>(
    // rust: &'a self,
    // rust: mut tokens: Vec<ExpansionToken<'a>>,
    // rust: ) -> (Vec<ExpansionToken<'a>>, bool) {
    // rust: let mut i = 0;
    // rust: let mut unfinished = false;
    // rust: while i < tokens.len() {
    // rust: let Some((name, m)) = self.0.get_key_value(tokens[i].text.as_str()) else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: if tokens[i].hidden.contains(&name.as_str()) {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let mut hidden = tokens[i].hidden.clone();
    // rust: let (mut body, next) = match &m.params {
    // rust: None => (expansion_tokens(&m.body), i + 1),
    // rust: Some(params) => {
    // rust: let Some((args, next)) = arguments(&tokens, i + 1) else {
    // rust: unfinished |= tokens[i + 1..]
    // rust: .iter()
    // rust: .find(|t| !t.blank())
    // rust: .is_some_and(|t| t.text == "(");
    // rust: i += 1;
    // rust: continue;
}
                    // A call can cross a replacement boundary. Only disabling shared by
                    // its name and closing parenthesis carries into the new replacement.
    // rust: hidden.retain(|h| tokens[next - 1].hidden.contains(h));
    // rust: (self.substitute(params, &args, &m.body), next)
}
}
    // rust: hidden.push(name);
    // rust: for token in &mut body {
    // rust: for h in &hidden {
    // rust: if !token.hidden.contains(h) {
    // rust: token.hidden.push(h);
}
}
}
            // Rescan the replacement together with the remaining source. Its final name
            // may consume a call there; source tokens keep their own disabling context.
    // rust: tokens.splice(i..next, body);
}
    // rust: (tokens, unfinished)
}

    /// A function-like macro's body with its parameters replaced.
    // rust: fn substitute<'a>(
    // rust: &'a self,
    // rust: params: &[String],
    // rust: args: &[Vec<ExpansionToken<'a>>],
    // rust: body: &str,
    // rust: ) -> Vec<ExpansionToken<'a>> {
    // rust: let tokens = lex(body);
    // rust: let pasted = |at: usize, step: isize| {
    // rust: let mut j = at as isize + step;
    // rust: while (0..tokens.len() as isize).contains(&j) && tokens[j as usize].trim().is_empty() {
    // rust: j += step;
}
    // rust: (0..tokens.len() as isize).contains(&j) && tokens[j as usize] == "##"
}
    // rust: let mut out = Vec::new();
    // rust: for (at, token) in tokens.iter().enumerate() {
    // rust: match params.iter().position(|p| p == token) {
    // rust: Some(k) => {
    // rust: let arg = args.get(k).map_or(&[][..], |a| a.as_slice());
    // rust: let from = arg.iter().position(|t| !t.blank()).unwrap_or(arg.len());
    // rust: let end = arg.iter().rposition(|t| !t.blank()).map_or(from, |n| n + 1);
    // rust: let arg = arg[from..end].to_vec();
    // rust: if pasted(at, -1) || pasted(at, 1) {
    // rust: if arg.is_empty() {
                            // An empty paste operand must not capture the preceding token.
    // rust: out.push(ExpansionToken::new(""));
    // rust: } else {
    // rust: out.extend(arg);
}
    // rust: } else {
    // rust: out.extend(self.expand_tokens(arg).0);
}
}
    // rust: None => out.push(ExpansionToken::new(token)),
}
}
        // `a ## b` → `ab`.
    // rust: let mut joined: Vec<ExpansionToken<'a>> = Vec::new();
    // rust: let mut paste = false;
    // rust: for token in out {
    // rust: if token.text == "##" {
    // rust: while joined.last().is_some_and(|t| t.blank()) {
    // rust: joined.pop();
}
    // rust: paste = true;
    // rust: } else if paste && token.blank() {
    // rust: continue;
    // rust: } else if paste {
    // rust: if let Some(mut left) = joined.pop() {
                    // An empty operand leaves the other token, including its hiding, intact.
    // rust: if left.text.is_empty() {
    // rust: left = token;
    // rust: } else if !token.text.is_empty() {
    // rust: left.text.push_str(&token.text);
    // rust: left.hidden.retain(|h| token.hidden.contains(h));
}
    // rust: joined.push(left);
    // rust: } else {
    // rust: joined.push(token);
}
    // rust: paste = false;
    // rust: } else {
    // rust: joined.push(token);
}
}
    // rust: joined.retain(|t| !t.text.is_empty());
    // rust: joined
}
}

/// Disabling belongs to each token: rescanning a boundary must neither revive a recursive
/// replacement token nor hide an independent invocation in the surrounding source.
pub const ExpansionToken = struct {
    text: []const u8,
    hidden: std.ArrayList(*'a str),
};

    // rust: impl ExpansionToken<'_> {
pub fn new(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: text: text.into(),
    // rust: hidden: Vec::new(),
}
}

pub fn blank(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.text.is_empty() && self.text.trim().is_empty()
}
}

pub fn expansion_tokens(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lex(text).into_iter().map(ExpansionToken::new).collect()
}

/// The arguments of a call whose `(` is the next non-blank token from `i`, split at top-level
/// commas, and the index after its `)`. `None` when no `(` follows or it never closes.
    // rust: fn arguments<'a>(
    // rust: tokens: &[ExpansionToken<'a>],
    // rust: mut i: usize,
    // rust: ) -> Option<(Vec<Vec<ExpansionToken<'a>>>, usize)> {
    // rust: while tokens.get(i)?.blank() {
    // rust: i += 1;
}
    // rust: if tokens[i].text != "(" {
    // rust: return None;
}
    // rust: let (mut depth, mut args, mut from) = (0, Vec::new(), i + 1);
    // rust: for (j, t) in tokens.iter().enumerate().skip(i + 1) {
    // rust: match t.text.as_str() {
    // rust: "(" => depth += 1,
    // rust: ")" if depth == 0 => {
    // rust: args.push(tokens[from..j].to_vec());
    // rust: return Some((args, j + 1));
}
    // rust: ")" => depth -= 1,
    // rust: "," if depth == 0 => {
    // rust: args.push(tokens[from..j].to_vec());
    // rust: from = j + 1;
}
    // rust: _ => {}
}
}
    // rust: None
}

/// Preprocessing tokens: identifiers, numbers (with their suffixes and exponents), runs of
/// white space, `##`, and single characters. Concatenated they give back `text`.
    // rust: pub(crate) fn lex(text: &str) -> Vec<&str> {
    // rust: let bytes = text.as_bytes();
    // rust: let mut out = Vec::new();
    // rust: let mut i = 0;
    // rust: while i < bytes.len() {
    // rust: let c = bytes[i] as char;
    // rust: let start = i;
    // rust: i += 1;
    // rust: if is_ident_start(c) {
    // rust: while i < bytes.len() && is_ident(bytes[i] as char) {
    // rust: i += 1;
}
    // rust: } else if c.is_ascii_digit() || (c == '.' && bytes.get(i).is_some_and(u8::is_ascii_digit)) {
    // rust: while i < bytes.len() {
    // rust: let d = bytes[i] as char;
    // rust: let exp_sign = (d == '+' || d == '-') && matches!(bytes[i - 1], b'e' | b'E');
    // rust: if !(is_ident(d) || d == '.' || exp_sign) {
    // rust: break;
}
    // rust: i += 1;
}
    // rust: } else if c.is_whitespace() {
    // rust: while i < bytes.len() && (bytes[i] as char).is_whitespace() {
    // rust: i += 1;
}
    // rust: } else if c == '#' && bytes.get(i) == Some(&b'#') {
    // rust: i += 1;
    // rust: } else {
    // rust: while !text.is_char_boundary(i) {
    // rust: i += 1;
}
}
    // rust: out.push(&text[start..i]);
}
    // rust: out
}

    // rust: pub(crate) fn is_ident_start(c: char) -> bool {
    // rust: c.is_ascii_alphabetic() || c == '_'
}

    // rust: pub(crate) fn is_ident(c: char) -> bool {
    // rust: c.is_ascii_alphanumeric() || c == '_'
}

    // rust: mod tests {
//     use super::*;

    /// Whether `fsh` translates with `m`: a program that declares what it reads only under
    /// a macro's condition translates when the condition holds.
pub fn translates(fsh: []const u8, m: *Macros) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let vsh = "#version 330\nvoid main() { gl_Position = vec4(0.0); }\n";
    // rust: let pack = crate::Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: crate::pack::tests::zip(&[
    // rust: ("shaders/composite.vsh", vsh),
    // rust: ("shaders/composite.fsh", fsh),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: crate::translate_composite(
    // rust: &crate::preprocess(&pack, "composite.vsh", m),
    // rust: &crate::preprocess(&pack, "composite.fsh", m),
    // rust: crate::Target::Buffers,
    // rust: )
    // rust: .map(|_| ())
    // rust: .map_err(|e| format!("{e:?}"))
}

    /// Packs see what Iris 1.11.7 defines on 26.3: GL and GLSL 3.3, its version and its sorted
    /// translucent terrain, so they take the paths they take there.
pub fn programs_see_the_versions_iris_reports() void {
}
    // rust: let fsh = "#version 330\nout vec4 c;\n\
    // rust: #if MC_GL_VERSION == 330 && MC_GLSL_VERSION == 330 && IRIS_VERSION >= 11107 \\\n\
    // rust: && defined IRIS_HAS_TRANSLUCENCY_SORTING\nconst float v = 1.0;\n#endif\n\
    // rust: void main() { c = vec4(v); }\n";
    // rust: translates(fsh, &Macros::standard()).unwrap();
}

    /// With the renderer's macros a pack sees one GL vendor and renderer, `OTHER`, and the
    /// mipmap levels terrain is drawn with.
pub fn programs_see_the_renderers_vendor_and_mipmap_levels() void {
}
    // rust: let fsh = "#version 330\nout vec4 c;\n\
    // rust: #if defined MC_GL_VENDOR_OTHER && defined MC_GL_RENDERER_OTHER && MC_MIPMAP_LEVEL == 2\n\
    // rust: const float v = 1.0;\n#endif\n\
    // rust: #if defined MC_GL_VENDOR_NVIDIA || defined MC_GL_RENDERER_GEFORCE\nconst float v = 2.0;\n#endif\n\
    // rust: void main() { c = vec4(v); }\n";
    // rust: let mut m = Macros::standard();
    // rust: m.define_renderer(2);
    // rust: translates(fsh, &m).unwrap();
}

    /// Packs take their normal- and specular-map branches, as they do with the maps on: a
    /// declaration made only there is seen.
pub fn programs_take_the_normal_and_specular_map_branches() void {
}
    // rust: let fsh = "#version 330\nout vec4 c;\n\
    // rust: #ifdef MC_NORMAL_MAP\nconst float bump = 1.0;\n#endif\n\
    // rust: #ifdef MC_SPECULAR_MAP\nconst float shine = 2.0;\n#endif\n\
    // rust: void main() { c = vec4(bump, shine, 0.0, 1.0); }\n";
    // rust: translates(fsh, &Macros::standard()).unwrap();
}

    /// `BLOCK_EMISSION_ATTRIBUTE` (terrain's `at_midBlock.w` is its block's light) is one
    /// Horizon has: defined when optional, no note when required.
pub fn block_emission_attribute_is_a_feature() void {
}
    // rust: let properties = crate::Properties::parse(
    // rust: "iris.features.optional = BLOCK_EMISSION_ATTRIBUTE\n\
    // rust: iris.features.required = BLOCK_EMISSION_ATTRIBUTE\n",
    // rust: &Macros::standard(),
    // rust: );
    // rust: let mut m = Macros::standard();
    // rust: assert!(m.define_features(&properties).is_empty());
    // rust: assert!(m.is_defined("IRIS_FEATURE_BLOCK_EMISSION_ATTRIBUTE"));
}

pub fn iris_features_are_defined_or_noted() void {
}
    // rust: let properties = crate::Properties::parse(
    // rust: "iris.features.optional = COMPUTE_SHADERS SEPARATE_HARDWARE_SAMPLERS NOT_A_FEATURE\n\
    // rust: iris.features.required = ENTITY_TRANSLUCENT SEPARATE_HARDWARE_SAMPLERS NOT_A_FEATURE\n",
    // rust: &Macros::standard(),
    // rust: );
    // rust: let mut m = Macros::standard();
    // rust: let notes = m.define_features(&properties);
    // rust: assert!(m.is_defined("IRIS_FEATURE_COMPUTE_SHADERS"));
    // rust: assert!(m.is_defined("IRIS_FEATURE_SEPARATE_HARDWARE_SAMPLERS"));
    // rust: assert!(!m.is_defined("IRIS_FEATURE_NOT_A_FEATURE"));
    // rust: assert_eq!(
    // rust: notes,
    // rust: ["the pack requires `NOT_A_FEATURE`, which is not supported yet"]
    // rust: );
        // HIGHER_SHADOWCOLOR: Iris 1.11.7 defines it for `iris.features.optional` (probe p7951c).
    // rust: let mut m = Macros::default();
    // rust: let notes = m.define_features(&crate::Properties::parse(
    // rust: "iris.features.optional = HIGHER_SHADOWCOLOR\n\
    // rust: iris.features.required = HIGHER_SHADOWCOLOR\n",
    // rust: &Macros::default(),
    // rust: ));
    // rust: assert!(m.is_defined("IRIS_FEATURE_HIGHER_SHADOWCOLOR") && notes.is_empty());
}

    /// Iris 1.11.7, with probe packs of our own (#8996): a feature name matches in any case, and
    /// an optional one defines the macro with the name as written, not in upper case.
pub fn feature_names_match_in_any_case() void {
}
    // rust: let mut m = Macros::standard();
    // rust: let notes = m.define_features(&crate::Properties::parse(
    // rust: "iris.features.optional = ssbo Custom_Images\n\
    // rust: iris.features.required = compute_shaders ssbo custom_images Not_A_Feature\n",
    // rust: &Macros::standard(),
    // rust: ));
    // rust: assert!(m.is_defined("IRIS_FEATURE_ssbo"));
    // rust: assert!(m.is_defined("IRIS_FEATURE_Custom_Images"));
    // rust: for absent in [
    // rust: "IRIS_FEATURE_SSBO",
    // rust: "IRIS_FEATURE_CUSTOM_IMAGES",
    // rust: "IRIS_FEATURE_compute_shaders",
    // rust: "IRIS_FEATURE_COMPUTE_SHADERS",
    // rust: ] {
    // rust: assert!(!m.is_defined(absent), "{absent}");
}
    // rust: assert_eq!(
    // rust: notes,
    // rust: ["the pack requires `Not_A_Feature`, which is not supported yet"]
    // rust: );
}

pub fn versions_follow_the_documented_rule() void {
}
    // rust: assert_eq!(mc_version("1.21"), 12100);
    // rust: assert_eq!(mc_version("1.21.0"), 12100);
    // rust: assert_eq!(mc_version("1.7.10"), 10710);
    // rust: assert_eq!(mc_version("26.3"), 260300);
    // rust: assert_eq!(MC_VERSION, 260300);
    // rust: assert_eq!(Macros::standard().get("MC_VERSION"), Some("260300"));
}

pub fn expansion_replaces_whole_words_and_stops_on_recursion() void {
}
    // rust: let mut m = Macros::default();
    // rust: m.define("RES", "SIZE");
    // rust: m.define("SIZE", "512");
    // rust: m.define("LOOP", "LOOP + 1");
    // rust: assert_eq!(m.expand("RES RES 0.5"), "512 512 0.5");
    // rust: assert_eq!(
    // rust: m.expand("RESOLUTION colortex4 LOOP"),
    // rust: "RESOLUTION colortex4 LOOP + 1"
    // rust: );
    // rust: m.define("e5", "x");
    // rust: assert_eq!(m.expand("1e5"), "1e5");
}

pub fn function_like_macros_take_arguments_and_paste() void {
}
    // rust: let mut m = Macros::default();
    // rust: m.define("N", "4");
    // rust: m.define_function("SQ", vec!["x".into()], "((x) * (x))");
    // rust: m.define_function("CAT", vec!["a".into(), "b".into()], "a ## b");
    // rust: m.define_function("PI", vec![], "3.14");
    // rust: assert_eq!(m.expand("SQ(N + 1)"), "((4 + 1) * (4 + 1))");
    // rust: assert_eq!(m.expand("SQ(min(N, 2))"), "((min(4, 2)) * (min(4, 2)))");
    // rust: assert_eq!(m.expand("CAT(N, 2) CAT(col, ortex4)"), "N2 colortex4");
    // rust: assert_eq!(m.expand("PI() SQ SQ(1"), "3.14 SQ SQ(1");
    // rust: assert_eq!(m.get("SQ"), None);
}
}
