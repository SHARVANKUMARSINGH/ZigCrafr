//! Transpiled from Horizon Rust crate
package horizon_shaders_options

import "core:fmt"
import "core:mem"
import "core:math"

// Switch options (spec 8.1), as far as program-enable expressions (3.3) need them: which are on
// by default. A switch is `#define NAME` (on) or `//#define NAME` (off) with nothing after the
// name but a comment, in any stage or included file of the pack. Packs keep their options in
// included `.glsl` files (or files of any name a source includes) and test them elsewhere
// (OQ-13), so the test the spec asks for (`#ifdef NAME` / `#ifndef NAME`) may be in any file
// of the pack.

// use std::collections::{BTreeMap, BTreeSet};

// use crate::Pack;

SOURCES :: ["vsh", "fsh", "gsh", "csh", "tcs", "tes", "glsl", "inc"]

// The switch options that are on by default.
switches_on :: proc(pack: ^Pack) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let (mut on, mut off, mut tested) = (BTreeSet::new(), BTreeSet::new(), BTreeSet::new());
    // rust: for text in option_texts(pack) {
    // rust: for line in text.lines() {
    // rust: let line = line.trim();
    // rust: let (commented, rest) = match line.strip_prefix("//") {
    // rust: Some(rest) => (true, rest.trim_start()),
    // rust: None => (false, line),
}
    // rust: let Some((directive, rest)) = rest
    // rust: .strip_prefix('#')
    // rust: .map(str::trim_start)
    // rust: .and_then(|r| r.split_once(|c: char| c.is_whitespace()))
    // rust: else {
    // rust: continue;
}
    // rust: let mut words = rest.split_whitespace();
    // rust: let Some(name) = words.next() else { continue };
    // rust: match directive {
    // rust: "ifdef" | "ifndef" if !commented => _ = tested.insert(name.to_owned()),
    // rust: "define" if words.next().is_none_or(|w| w.starts_with("//")) => {
    // rust: let set = if commented { &mut off } else { &mut on };
    // rust: set.insert(name.to_owned());
}
    // rust: _ => {}
}
}
}
    // Defined both ways is ambiguous (8.1): it keeps its default only where it is on everywhere.
    // rust: on.retain(|name| tested.contains(name) && !off.contains(name));
    // rust: on
}

// The value options and their defaults: `#define NAME VALUE // [A B C]`, a value and the list
// of the values it may take (8.1).
value_options :: proc(pack: ^Pack) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeMap::new();
    // rust: for text in option_texts(pack) {
    // rust: for line in text.lines() {
    // rust: let Some(rest) = line.trim().strip_prefix('#') else {
    // rust: continue;
}
    // rust: let Some(rest) = rest.trim_start().strip_prefix("define") else {
    // rust: continue;
}
    // rust: let Some((code, comment)) = rest.split_once("//") else {
    // rust: continue;
}
    // rust: let mut words = code.split_whitespace();
    // rust: let (Some(name), Some(value), None) = (words.next(), words.next(), words.next()) else {
    // rust: continue;
}
    // rust: if comment.contains('[') && comment.contains(']') {
    // rust: out.entry(name.to_owned())
    // rust: .or_insert_with(|| value.to_owned());
}
}
}
    // rust: out
}

// `macros` with the pack's options at their defaults: the switches that are on, and the
// value options. `shaders.properties` and the program switches test them (3.3, 8.1).
with_options :: proc(pack: ^Pack, macros: ^crate::Macros) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = macros.clone();
    // rust: for name in switches_on(pack) {
    // rust: out.define(name, "");
}
    // rust: for (name, value) in value_options(pack) {
    // rust: out.define(name, value);
}
    // rust: out
}

// The macros `shaders.properties` is read with: the pack's options over `macros`, and every
// feature Horizon has (`Macros::define_every_feature`), so a custom uniform or a screen behind
// `#ifdef IRIS_FEATURE_<name>` is there as in Iris 1.11.7.
properties_macros :: proc(pack: ^Pack, macros: ^crate::Macros) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = with_options(pack, macros);
    // rust: out.define_every_feature();
    // rust: out
}

// A pack's `shaders.properties` as the game reads it before the programs: parsed with
// `properties_macros` over `macros` (the standard set and the renderer's), after which `macros`
// gets the features the pack turns on (`iris.features.*`, `Macros::define_features`). Returns
// the properties and a note for each required feature Horizon lacks. Whatever reads a pack's
// programs (the game, the `real_packs` test) reads them with these macros.
    // rust: pub fn read_properties(
    // rust: pack: &Pack,
    // rust: macros: &mut crate::Macros,
    // rust: ) -> (crate::Properties, Vec<String>) {
    // rust: let text = pack.read_text("shaders.properties").unwrap_or_default();
    // rust: let properties = crate::Properties::parse(&text, &properties_macros(pack, macros));
    // rust: let notes = macros.define_features(&properties);
    // rust: (properties, notes)
}

// An option the player can change (8.1): a switch (`values` are `false` and `true`), a value
// option or a `const` with the list of values it may take.
PackOption :: struct {
    name: string,
    default: string,
    values: [dynamic]string,
    switch: bool,
    // A switch some file tests; value options always count as tested.
    tested: bool,
}

// A line that declares an option, as [`declaration`] reads it.
Declaration :: struct {
    name: ^'a str,
    // The value and its byte offset in the line; `None` for a switch.
    value: Option<(^'a str,
    // Behind `//`: a switch that is off.
    commented: bool,
    // The values in the comment's `[...]`.
    values: Maybe([dynamic]^'a str),
    // `const bool`: a switch written as a value.
    boolean: bool,
}

// `#define NAME`, `//#define NAME`, `#define NAME VALUE // [A B]`,
// `const TYPE NAME = VALUE; // [A B]` or `const bool NAME = true;`.
declaration :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let body = line.trim_start();
    // rust: let (commented, code) = match body.strip_prefix("//") {
    // rust: Some(rest) => (true, rest.trim_start()),
    // rust: None => (false, body),
}
    // rust: let offset = |part: &str| part.as_ptr() as usize - line.as_ptr() as usize;
    // rust: if let Some(rest) = code.strip_prefix('#') {
    // rust: let rest = rest.trim_start().strip_prefix("define")?;
    // rust: if !rest.starts_with(char::is_whitespace) {
    // rust: return None;
}
    // rust: let (code, comment) = rest.split_once("//").unwrap_or((rest, ""));
    // rust: let mut words = code.split_whitespace();
    // rust: let name = words.next()?;
    // rust: let value = words.next();
    // rust: if words.next().is_some() {
    // rust: return None;
}
    // rust: return Some(Declaration {
    // rust: name,
    // rust: value: value.map(|v| (v, offset(v))),
    // rust: commented,
    // rust: values: list_with_default(comment, value),
    // rust: boolean: false,
    // rust: });
}
    // rust: if commented {
    // rust: return None;
}
    // `const float shadowDistance = 128.0; // [64.0 128.0]`, `const bool x = true;`
    // rust: let rest = code.strip_prefix("const")?;
    // rust: let (decl, comment) = rest.split_once("//").unwrap_or((rest, ""));
    // rust: let (left, right) = decl.split_once('=')?;
    // rust: let mut words = left.split_whitespace();
    // rust: let (Some(ty), Some(name), None) = (words.next(), words.next(), words.next()) else {
    // rust: return None;
}
    // rust: let value = right.trim().strip_suffix(';')?.trim_end();
    // rust: if value.is_empty() || value.contains(char::is_whitespace) {
    // rust: return None;
}
    // rust: let boolean = ty == "bool" && matches!(value, "true" | "false");
    // rust: Some(Declaration {
    // rust: name,
    // rust: value: Some((value, offset(value))),
    // rust: commented: false,
    // rust: values: if boolean {
    // rust: Some(vec!["false", "true"])
    // rust: } else {
    // rust: Some(list_with_default(comment, Some(value))?)
    // rust: },
    // rust: boolean,
    // rust: })
}

// Keep the declared default selectable without creating an option from an empty range.
    // rust: fn list_with_default<'a>(comment: &'a str, default: Option<&'a str>) -> Option<Vec<&'a str>> {
    // rust: let mut values = list(comment)?;
    // rust: if !values.is_empty()
    // rust: && let Some(default) = default
    // rust: && !values.contains(&default)
    // rust: {
    // rust: values.insert(0, default);
}
    // rust: Some(values)
}

// The values in a comment's `[...]`.
list :: proc(comment: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (_, rest) = comment.split_once('[')?;
    // rust: let (inner, _) = rest.split_once(']')?;
    // rust: Some(inner.split_whitespace().collect())
}

// Every option of the pack, by name, at its default.
options :: proc(pack: ^Pack) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: BTreeMap<String, PackOption> = BTreeMap::new();
    // rust: let (mut on, mut off, mut tested) = (BTreeSet::new(), BTreeSet::new(), BTreeSet::new());
    // rust: for text in option_texts(pack) {
        // `#ifndef NAME` just before `#define NAME`: an include guard, not an option.
    // rust: let mut guard: Option<&str> = None;
    // rust: for line in text.lines() {
    // rust: let trimmed = line.trim();
    // rust: let opened = guard_name(trimmed);
    // rust: for directive in ["#ifdef", "#ifndef"] {
    // rust: if let Some(name) = trimmed.strip_prefix(directive).map(str::trim) {
    // rust: tested.insert(name.split_whitespace().next().unwrap_or("").to_owned());
}
}
    // rust: if trimmed.starts_with("#if") || trimmed.starts_with("#elif") {
    // rust: tested.extend(defined_names(trimmed));
}
    // rust: let Some(d) = declaration(line) else {
    // rust: if opened.is_some() || !(trimmed.is_empty() || trimmed.starts_with("//")) {
    // rust: guard = opened;
}
    // rust: continue;
}
    // rust: if guard.take() == Some(d.name) && d.value.is_none() && !d.commented {
    // rust: continue;
}
    // rust: match (d.value, d.values) {
    // rust: (None, _) => {
    // rust: let set = if d.commented { &mut off } else { &mut on };
    // rust: set.insert(d.name.to_owned());
}
    // rust: (Some((value, _)), Some(values)) if !d.commented && !values.is_empty() => {
                    // A `const bool` is often the pack's own setting rather than the player's:
                    // it shows where a screen names it, not with `*`.
    // rust: out.entry(d.name.to_owned()).or_insert_with(|| PackOption {
    // rust: name: d.name.to_owned(),
    // rust: default: value.to_owned(),
    // rust: values: values.iter().map(|v| (*v).to_owned()).collect(),
    // rust: switch: d.boolean,
    // rust: tested: !d.boolean,
    // rust: });
}
    // rust: _ => {}
}
}
}
    // rust: for name in on.iter().chain(&off) {
    // rust: if out.contains_key(name) {
    // rust: continue;
}
        // Defined both ways is ambiguous (8.1): on only where it is on everywhere.
    // rust: let default = on.contains(name) && !off.contains(name);
    // rust: out.insert(
    // rust: name.clone(),
    // rust: PackOption {
    // rust: name: name.clone(),
    // rust: default: default.to_string(),
    // rust: values: vec!["false".into(), "true".into()],
    // rust: switch: true,
    // rust: tested: tested.contains(name),
    // rust: },
    // rust: );
}
    // rust: out
}

// The name an `#ifndef NAME` or `#if !defined NAME` line tests.
guard_name :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rest = match line.strip_prefix("#ifndef") {
    // rust: Some(rest) => rest,
    // rust: None => line
    // rust: .strip_prefix("#if")?
    // rust: .trim_start()
    // rust: .strip_prefix('!')?
    // rust: .trim_start()
    // rust: .strip_prefix("defined")?,
}
    // rust: let rest = rest.trim_start().trim_start_matches('(').trim_start();
    // rust: let end = rest
    // rust: .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
    // rust: .unwrap_or(rest.len());
    // rust: (end > 0).then(|| &rest[..end])
}

// The names `defined NAME` and `defined(NAME)` test in an `#if` line.
defined_names :: proc(line: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: line.split("defined")
    // rust: .skip(1)
    // rust: .filter_map(|rest| {
    // rust: let rest = rest.trim_start().trim_start_matches('(').trim_start();
    // rust: let end = rest
    // rust: .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
    // rust: .unwrap_or(rest.len());
    // rust: (end > 0).then(|| rest[..end].to_owned())
    // rust: })
    // rust: .collect()
}

// `text` with the options in `chosen` at their chosen values: switches commented out or in,
// values replaced. Lines keep their place.
apply :: proc(text: string, chosen: ^BTreeMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len() + 64);
    // rust: for line in text.split_inclusive('\n') {
    // rust: let content = line.trim_end_matches(['\r', '\n']);
    // rust: let end = &line[content.len()..];
    // rust: let replaced = declaration(content).and_then(|d| {
    // rust: let want = chosen.get(d.name)?;
    // rust: match (d.value, d.values) {
    // rust: (None, _) => {
    // rust: let on = want == "true";
    // rust: if on != d.commented {
    // rust: return None;
}
    // rust: let body = content.trim_start();
    // rust: let indent = &content[..content.len() - body.len()];
    // rust: Some(if on {
    // rust: format!("{indent}{}", body.trim_start_matches('/').trim_start())
    // rust: } else {
    // rust: format!("{indent}//{body}")
    // rust: })
}
    // rust: (Some((value, at)), Some(_)) if !d.commented => Some(format!(
    // rust: "{}{want}{}",
    // rust: &content[..at],
    // rust: &content[at + value.len()..]
    // rust: )),
    // rust: _ => None,
}
    // rust: });
    // rust: out.push_str(replaced.as_deref().unwrap_or(content));
    // rust: out.push_str(end);
}
    // rust: out
}

// The file the player's choices for pack `name` are kept in, beside it in `shaderpacks/`.
chosen_file :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{name}.txt")
}

// `NAME=value` lines; blank lines and `#` comments are skipped.
parse_chosen :: proc(text: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: text.lines()
    // rust: .map(str::trim)
    // rust: .filter(|l| !l.is_empty() && !l.starts_with('#'))
    // rust: .filter_map(|l| l.split_once('='))
    // rust: .map(|(k, v)| (k.trim().to_owned(), v.trim().to_owned()))
    // rust: .collect()
}

chosen_text :: proc(chosen: ^BTreeMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: chosen.iter().map(|(k, v)| format!("{k}={v}\n")).collect()
}

// The texts of the pack's sources and of the files they include.
option_texts :: proc(pack: ^Pack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let files = pack.all_files();
    // rust: let source = |path: &str| SOURCES.contains(&path.rsplit_once('.').map_or("", |(_, e)| e));
    // rust: let texts: Vec<(&String, String)> = files
    // rust: .iter()
    // rust: .filter(|p| source(p))
    // rust: .filter_map(|p| Some((p, pack.read_text(p)?)))
    // rust: .collect();
    // Files of other names count when a source includes them (`#include "shaders.settings"`).
    // rust: let included: BTreeSet<&str> = texts
    // rust: .iter()
    // rust: .flat_map(|(_, t)| t.lines())
    // rust: .filter_map(|l| l.trim().strip_prefix("#include"))
    // rust: .map(|r| r.trim().trim_matches(|c| c == '"' || c == '<' || c == '>'))
    // rust: .map(|r| r.rsplit('/').next().unwrap_or(r))
    // rust: .collect();
    // rust: let extra: Vec<(&String, String)> = files
    // rust: .iter()
    // rust: .filter(|p| !source(p) && included.contains(p.rsplit('/').next().unwrap_or(p)))
    // rust: .filter_map(|p| Some((p, pack.read_text(p)?)))
    // rust: .collect();
    // rust: texts.into_iter().chain(extra).map(|(_, t)| t).collect()
}

    // rust: mod tests {
//     use super::*;

    // `shaders.properties` read as the game reads it: its conditionals see the pack's options
    // and the macros given (the renderer's vendor here), and the features it turns on are then
    // defined for the programs, with a note for a required one Horizon lacks.
properties_are_read_with_the_options_then_define_the_features :: proc() {
}
    // rust: let bytes = crate::pack::tests::zip(&[
    // rust: (
    // rust: "shaders/options.glsl",
    // rust: "#define LEVEL 2 // [1 2]
    // rust: ",
    // rust: ),
    // rust: (
    // rust: "shaders/shaders.properties",
    // rust: "#if LEVEL == 2
    // rust: screen = x
    // rust: #endif
    // rust: #ifdef MC_GL_VENDOR_OTHER
    // rust: vendor = other
    // rust: #endif
    // rust: iris.features.optional = SSBO
    // rust: iris.features.required = NOT_A_FEATURE
    // rust: ",
    // rust: ),
    // rust: ]);
    // rust: let pack = Pack::from_zip_bytes("p.zip", bytes).unwrap();
    // rust: let mut macros = crate::Macros::standard();
    // rust: macros.define_renderer(4);
    // rust: let (properties, notes) = read_properties(&pack, &mut macros);
    // rust: assert_eq!(properties.get("screen"), Some("x"));
    // rust: assert_eq!(properties.get("vendor"), Some("other"));
    // rust: assert!(macros.is_defined("IRIS_FEATURE_SSBO"));
    // rust: assert_eq!(
    // rust: notes,
    // rust: ["the pack requires `NOT_A_FEATURE`, which is not supported yet"]
    // rust: );
}

    // `shaders.properties` sees every feature Horizon has, listed or not, as Iris 1.11.7 reads
    // it (probe pack, measured there: a custom uniform behind each `#ifdef IRIS_FEATURE_<name>`
    // was set for an optional, a required and an unlisted feature, the optional list written on
    // the last line). The programs still get only the optional ones, as there.
properties_see_every_feature_and_programs_only_the_optional_ones :: proc() {
}
    // rust: let bytes = crate::pack::tests::zip(&[(
    // rust: "shaders/shaders.properties",
    // rust: "iris.features.required = COMPUTE_SHADERS\n\
    // rust: #ifdef IRIS_FEATURE_CUSTOM_IMAGES\nuniform.float.optional = 1.0\n#endif\n\
    // rust: #ifdef IRIS_FEATURE_COMPUTE_SHADERS\nuniform.float.required = 1.0\n#endif\n\
    // rust: #ifdef IRIS_FEATURE_SSBO\nuniform.float.unlisted = 1.0\n#endif\n\
    // rust: #ifdef IRIS_FEATURE_NOT_A_FEATURE\nuniform.float.unknown = 1.0\n#endif\n\
    // rust: iris.features.optional = CUSTOM_IMAGES\n",
    // rust: )]);
    // rust: let pack = Pack::from_zip_bytes("p.zip", bytes).unwrap();
    // rust: let mut macros = crate::Macros::standard();
    // rust: let (properties, notes) = read_properties(&pack, &mut macros);
    // rust: let read = |name: &str| properties.get(&format!("uniform.float.{name}")).is_some();
    // rust: assert!(read("optional") && read("required") && read("unlisted"));
    // rust: assert!(!read("unknown"));
    // rust: assert!(notes.is_empty());
    // rust: assert!(macros.is_defined("IRIS_FEATURE_CUSTOM_IMAGES"));
    // rust: assert!(!macros.is_defined("IRIS_FEATURE_COMPUTE_SHADERS"));
    // rust: assert!(!macros.is_defined("IRIS_FEATURE_SSBO"));
}

declared_defaults_remain_selectable_and_apply :: proc() {
}
    // rust: for (source, selected) in [
    // rust: (
    // rust: "#define QUALITY 0 // [1 2]\n",
    // rust: "#define QUALITY 2 // [1 2]\n",
    // rust: ),
    // rust: (
    // rust: "const int QUALITY = 0; // [1 2]\n",
    // rust: "const int QUALITY = 2; // [1 2]\n",
    // rust: ),
    // rust: ] {
    // rust: let bytes = crate::pack::tests::zip(&[("shaders/options.glsl", source)]);
    // rust: let pack = Pack::from_zip_bytes("options.zip", bytes).unwrap();
    // rust: let available = options(&pack);
    // rust: let option = &available["QUALITY"];
    // rust: assert_eq!(option.default, "0");
    // rust: assert_eq!(option.values, ["0", "1", "2"]);
    // rust: let chosen = pack.with_chosen(BTreeMap::from([("QUALITY".into(), "2".into())]));
    // rust: assert_eq!(chosen.read_text("options.glsl").unwrap(), selected);
    // rust: let reset = chosen.with_chosen(BTreeMap::from([("QUALITY".into(), "0".into())]));
    // rust: assert_eq!(reset.read_text("options.glsl").unwrap(), source);
}
}

declared_defaults_keep_authored_order_and_empty_ranges_stay_hidden :: proc() {
}
    // rust: let bytes = crate::pack::tests::zip(&[(
    // rust: "shaders/options.glsl",
    // rust: "#define QUALITY 1 // [0 1 2]\n#define IGNORED 0 // []\n",
    // rust: )]);
    // rust: let pack = Pack::from_zip_bytes("options.zip", bytes).unwrap();
    // rust: let available = options(&pack);
    // rust: assert_eq!(available["QUALITY"].default, "1");
    // rust: assert_eq!(available["QUALITY"].values, ["0", "1", "2"]);
    // rust: assert!(!available.contains_key("IGNORED"));
}
//     use crate::pack::tests::zip;

switches_need_a_test_and_no_value :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: (
    // rust: "shaders/lib/settings.glsl",
    // rust: "  #define AO // ambient occlusion\n//#define BLOOM\n#define LEVEL 2 //[1 2]\n\
    // rust: #define SPLIT\n#define UNTESTED\n",
    // rust: ),
    // rust: (
    // rust: "shaders/world0/deferred.fsh",
    // rust: "#ifdef AO\n#endif\n#ifndef BLOOM\n#endif\n#ifdef SPLIT\n#endif\n#ifdef LEVEL\n#endif\n",
    // rust: ),
    // rust: ("shaders/world-1/deferred.fsh", "//#define SPLIT\n"),
    // rust: (
    // rust: "shaders/final.fsh",
    // rust: "#include \"shaders.settings\"\n#ifdef GODRAYS\n#endif\n",
    // rust: ),
    // rust: ("shaders/shaders.settings", "    #define GODRAYS //Toggle\n"),
    // rust: ("shaders/notes.settings", "#define NOT_INCLUDED\n#ifdef NOT_INCLUDED\n"),
    // rust: ("shaders/shaders.properties", "#define NOT_SOURCE\n#ifdef NOT_SOURCE\n"),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: switches_on(&pack),
    // rust: BTreeSet::from(["AO".to_owned(), "GODRAYS".to_owned()])
    // rust: );
}

options_read_switches_values_and_consts :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: (
    // rust: "shaders/lib/settings.glsl",
    // rust: "#define AO\n//#define BLOOM // glow\n#define LEVEL 2 //[1 2 3]\n\
    // rust: #define FIXED 4\nconst int shadowMapResolution = 2048; // [1024 2048]\n\
                     //#define OFF_VALUE 1 // [1 2]\n",
    // rust: ),
    // rust: (
    // rust: "shaders/final.fsh",
    // rust: "#ifdef AO\n#endif\n#if defined(BLOOM) && LEVEL > 1\n#endif\n",
    // rust: ),
    // rust: (
    // rust: "shaders/lib/common.glsl",
    // rust: "#ifndef COMMON_GLSL\n#define COMMON_GLSL\n#endif\n\
    // rust: #if !defined(INCLUDE_SKY)\n\n#define INCLUDE_SKY\n#endif\n",
    // rust: ),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let options = options(&pack);
    // rust: let names: Vec<&str> = options.keys().map(String::as_str).collect();
    // rust: assert_eq!(names, ["AO", "BLOOM", "LEVEL", "shadowMapResolution"]);
    // rust: assert_eq!(options["AO"].default, "true");
    // rust: assert!(options["BLOOM"].switch && options["BLOOM"].tested);
    // rust: assert_eq!(options["BLOOM"].default, "false");
    // rust: assert_eq!(options["LEVEL"].values, ["1", "2", "3"]);
    // rust: assert_eq!(options["shadowMapResolution"].default, "2048");
}

const_bools_are_switches_screens_name :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[(
    // rust: "shaders/lib/settings.glsl",
    // rust: "const bool shadowHardwareFiltering = true;\nconst bool generateShadowMipmap = false; // mips\n\
    // rust: const bool notABool = 1;\n",
    // rust: )]),
    // rust: )
    // rust: .unwrap();
    // rust: let options = options(&pack);
    // rust: let filtering = &options["shadowHardwareFiltering"];
    // rust: assert!(filtering.switch && !filtering.tested);
    // rust: assert_eq!(filtering.default, "true");
    // rust: assert_eq!(options["generateShadowMipmap"].default, "false");
    // rust: assert!(!options.contains_key("notABool"));
    // rust: let chosen = parse_chosen("shadowHardwareFiltering=false\n");
    // rust: assert_eq!(
    // rust: apply("const bool shadowHardwareFiltering = true;\n", &chosen),
    // rust: "const bool shadowHardwareFiltering = false;\n"
    // rust: );
}

chosen_values_rewrite_their_lines :: proc() {
}
    // rust: let chosen = parse_chosen("AO=false\nBLOOM=true\nLEVEL=3\nshadowMapResolution=1024\n");
    // rust: let text = "  #define AO // occlusion\r\n//#define BLOOM\n#define LEVEL 2 //[1 2 3]\n\
    // rust: #define LEVEL 9\nconst int shadowMapResolution = 2048; // [1024 2048]\n";
    // rust: assert_eq!(
    // rust: apply(text, &chosen),
    // rust: "  //#define AO // occlusion\r\n#define BLOOM\n#define LEVEL 3 //[1 2 3]\n\
    // rust: #define LEVEL 9\nconst int shadowMapResolution = 1024; // [1024 2048]\n"
    // rust: );
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: ("shaders/lib/settings.glsl", "#define LEVEL 2 //[1 2 3]\n"),
    // rust: ("shaders/shaders.properties", "#define LEVEL 2 //[1 2 3]\n"),
    // rust: ]),
    // rust: )
    // rust: .unwrap()
    // rust: .with_chosen(chosen.clone());
    // rust: assert_eq!(value_options(&pack)["LEVEL"], "3");
    // rust: assert_eq!(
    // rust: pack.read_text("shaders.properties").unwrap(),
    // rust: "#define LEVEL 2 //[1 2 3]\n"
    // rust: );
    // rust: assert_eq!(parse_chosen(&chosen_text(&chosen)), chosen);
}

    // A custom uniform's or variable's line has the macros expanded: a value option, a
    // `#define` of `shaders.properties` (function-like too), a standard macro, and a macro in
    // the uniform's name. Our probe pack's shape; Iris 1.11.7 drew p0..p5 as 127, 191, 64, 255,
    // 127 and 255 of 255 with the option at its default.
custom_uniform_lines_read_the_options_and_macros :: proc() {
}
    // rust: let bytes = crate::pack::tests::zip(&[
    // rust: ("shaders/final.fsh", "#define MY_OPT 2 // [1 2 3]\n"),
    // rust: (
    // rust: "shaders/shaders.properties",
    // rust: "#define PROP_DEF 3\n#define HALF(x) ((x) * 0.5)\n#define KEYNAME p5\n\
    // rust: uniform.float.p0 = MY_OPT * 0.25\n\
    // rust: uniform.float.p1 = PROP_DEF * 0.25\n\
    // rust: variable.float.v2 = MY_OPT * 0.125\nuniform.float.p2 = v2\n\
    // rust: uniform.float.p3 = if(MC_VERSION > 10000, 1.0, 0.0)\n\
    // rust: uniform.float.p4 = HALF(MY_OPT) * 0.5\n\
    // rust: uniform.float.KEYNAME = 1.0\n",
    // rust: ),
    // rust: ]);
    // rust: for (chosen, p0) in [(None, 0.5), (Some("3"), 0.75)] {
    // rust: let mut pack = Pack::from_zip_bytes("p.zip", bytes.clone()).unwrap();
    // rust: if let Some(value) = chosen {
    // rust: pack = pack.with_chosen(BTreeMap::from([("MY_OPT".into(), value.into())]));
}
    // rust: let (properties, _) = read_properties(&pack, &mut crate::Macros::standard());
    // rust: assert!(properties.notes.is_empty(), "{:?}", properties.notes);
    // rust: let mut custom = crate::Custom::parse(&properties);
    // rust: let values: Vec<f64> = custom
    // rust: .eval(0.016, &|_| None)
    // rust: .iter()
    // rust: .map(|v| v.v[0])
    // rust: .collect();
    // rust: let p4 = if chosen.is_some() { 0.75 } else { 0.5 };
    // rust: assert_eq!(values, [p0, 0.75, p0 / 2.0, 1.0, p4, 1.0]);
    // rust: let names: Vec<_> = custom.uniforms().map(|(name, _)| name.to_owned()).collect();
    // rust: assert_eq!(names, ["p0", "p1", "p2", "p3", "p4", "p5"]);
    // rust: assert!(custom.notes.is_empty(), "{:?}", custom.notes);
}
}
}
