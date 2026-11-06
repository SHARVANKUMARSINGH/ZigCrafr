//! Transpiled from Horizon Rust crate
package horizon_client_render_shader_pack_list

import "core:fmt"
import "core:mem"
import "core:math"

// The shader packs in the `shaderpacks` folder beside `options.txt`, as Options > Horizon
// Settings > Shader Packs lists them: Horizon's own (docs/shaders.md) and those in the
// `shaders/` format, side by side.

// use std::path::{Path, PathBuf};

// use horizon_shader_api::{OptionKind, OptionPage, PackOption};

DIR :: "shaderpacks"

Kind :: enum {
    // A folder with `horizon-shaders.toml`, or a `.hshader`.
    Horizon,
    // A folder with a `shaders` folder, or a `.zip`.
    Classic,
}

Entry :: struct {
    // The folder's or file's name in `shaderpacks`: what the pick saves.
    file: string,
    // The pack's own name for Horizon's packs, else `file`.
    title: string,
    kind: Kind,
    // A Horizon pack's `[[options]]`, and the value of each the player set (`values_path`).
    options: [dynamic]PackOption,
    values: [dynamic]f64,
    // Its options page's `[[pages]]`; empty for one page of every option.
    pages: [dynamic]OptionPage,
}

    // rust: impl Entry {
    // Saves the player's option values, for the pack in the folder `dir`.
save_values :: proc(self: ^Self, dir: ^Path) {
}
    // rust: let path = dir.join(&self.file);
    // rust: if let Err(e) = save_values(&path, &self.options, &self.values) {
    // rust: log::warn!("shader pack options of {}: {e}", self.file);
}
}

    // The option `i` one value on (`back`: one before), or at its default (`reset`). Whether
    // the pack has that option.
step_option :: proc(self: ^Self, i: uint, back: bool, reset: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(o), Some(v)) = (self.options.get(i), self.values.get_mut(i)) else {
    // rust: return false;
}
    // rust: *v = if reset {
    // rust: o.kind.default_constant()
    // rust: } else {
    // rust: step_value(&o.kind, *v, back)
}
    // rust: true
}

    // Where option `i` sits on its slider, 0 to 1: float and int options are sliders.
slider_position :: proc(self: ^Self, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: slider_position(&self.options.get(i)?.kind, *self.values.get(i)?)
}

    // Option `i` at the value nearest the slider position `at`. Whether its value changed.
set_slider_position :: proc(self: ^Self, i: uint, at: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(o), Some(v)) = (self.options.get(i), self.values.get_mut(i)) else {
    // rust: return false;
}
    // rust: let Some(new) = slider_value(&o.kind, at) else {
    // rust: return false;
}
    // rust: let changed = new != *v;
    // rust: *v = new;
    // rust: changed
}

    // Option `i`'s slider one step on (`back`: one before), stopping at its ends. Whether its
    // value changed.
nudge_option :: proc(self: ^Self, i: uint, back: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(o), Some(v)) = (self.options.get(i), self.values.get_mut(i)) else {
    // rust: return false;
}
    // rust: let dir = if back { -1.0 } else { 1.0 };
    // rust: let new = match &o.kind {
    // rust: OptionKind::Float { min, max, step, .. } => {
    // rust: let (min, max, step) = (f64::from(*min), f64::from(*max), f64::from(*step));
    // rust: let n = ((*v - min) / step).round() + dir;
    // rust: on_f32((min + n * step).clamp(min, max))
}
    // rust: OptionKind::Int { min, max, .. } => {
    // rust: (v.round() + dir).clamp(f64::from(*min), f64::from(*max))
}
    // rust: _ => return false,
}
    // rust: let changed = new != *v;
    // rust: *v = new;
    // rust: changed
}

    // Every option back to its default.
reset_options :: proc(self: ^Self) {
}
    // rust: let defaults = self.options.iter().map(|o| o.kind.default_constant());
    // rust: self.values = defaults.collect();
}
}

// The packs in `dir`, Horizon's first, each kind by title. A missing folder has none.
scan :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(entries) = std::fs::read_dir(dir) else {
    // rust: return Vec::new();
}
    // rust: let mut packs: Vec<Entry> = entries.flatten().filter_map(|e| entry(&e.path())).collect();
    // rust: packs.sort_by(|a, b| {
    // rust: (a.kind == Kind::Classic, a.title.to_lowercase())
    // rust: .cmp(&(b.kind == Kind::Classic, b.title.to_lowercase()))
    // rust: });
    // rust: packs
}

entry :: proc(path: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let file = path.file_name()?.to_str()?.to_owned();
    // rust: if file.starts_with('.') {
    // rust: return None;
}
    // rust: if horizon_shader_api::package::is_pack(path) {
        // Its manifest's name; a pack that can't be read is still listed, under its file
        // name: picking it says why in the chat.
    // rust: let manifest = if path.is_dir() {
    // rust: std::fs::read_to_string(path.join(horizon_shader_api::MANIFEST))
    // rust: .ok()
    // rust: .and_then(|t| horizon_shader_api::Manifest::parse(&t).ok())
    // rust: } else {
    // rust: horizon_shader_api::Pack::read(path)
    // rust: .ok()
    // rust: .map(|p| p.manifest)
}
    // rust: let (title, options, pages) = manifest.map_or_else(
    // rust: || (file.clone(), Vec::new(), Vec::new()),
    // rust: |m| (m.name, m.options, m.pages),
    // rust: );
    // rust: let values = load_values(path, &options);
    // rust: return Some(Entry {
    // rust: file,
    // rust: title,
    // rust: kind: Kind::Horizon,
    // rust: options,
    // rust: values,
    // rust: pages,
    // rust: });
}
    // rust: let zip = path.is_file()
    // rust: && path
    // rust: .extension()
    // rust: .is_some_and(|e| e.eq_ignore_ascii_case("zip"));
    // rust: (zip || path.join("shaders").is_dir()).then(|| Entry {
    // rust: title: file.clone(),
    // rust: file,
    // rust: kind: Kind::Classic,
    // rust: options: Vec::new(),
    // rust: values: Vec::new(),
    // rust: pages: Vec::new(),
    // rust: })
}

// Where the option values of the Horizon pack at `pack` are kept: `<pack>.txt` beside it,
// one `id=value` a line.
values_path :: proc(pack: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut path = pack.as_os_str().to_owned();
    // rust: path.push(".txt");
    // rust: PathBuf::from(path)
}

// The value of each of `options` saved for the pack at `pack`, else its default; a value
// out of the option's range is brought into it.
load_values :: proc(pack: ^Path, options: ^[PackOption]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let text = std::fs::read_to_string(values_path(pack)).unwrap_or_default();
    // rust: let saved: std::collections::HashMap<&str, f64> = text
    // rust: .lines()
    // rust: .filter_map(|l| l.split_once('='))
    // rust: .filter_map(|(k, v)| Some((k.trim(), v.trim().parse().ok()?)))
    // rust: .collect();
    // rust: options
    // rust: .iter()
    // rust: .map(|o| {
    // rust: saved
    // rust: .get(o.id.as_str())
    // rust: .map_or_else(|| o.kind.default_constant(), |&v| clamp(&o.kind, v))
    // rust: })
    // rust: .collect()
}

// Saves `values` of `options`; values at their defaults are left out, and with none left
// the file goes.
save_values :: proc(pack: ^Path, options: ^[PackOption], values: ^[f64]) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let text: String = options
    // rust: .iter()
    // rust: .zip(values)
    // rust: .filter(|(o, v)| o.kind.default_constant() != **v)
    // rust: .map(|(o, v)| format!("{}={v}\n", o.id))
    // rust: .collect();
    // rust: let path = values_path(pack);
    // rust: if text.is_empty() {
    // rust: match std::fs::remove_file(&path) {
    // rust: Err(e) if e.kind() != std::io::ErrorKind::NotFound => Err(e),
    // rust: _ => Ok(()),
}
    // rust: } else {
    // rust: std::fs::write(path, text)
}
}

clamp :: proc(kind: ^OptionKind, v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: OptionKind::Bool { .. } => f64::from(u8::from(v != 0.0)),
    // rust: OptionKind::Float { min, max, .. } => v.clamp(f64::from(*min), f64::from(*max)),
    // rust: OptionKind::Int { min, max, .. } => v.round().clamp(f64::from(*min), f64::from(*max)),
    // rust: OptionKind::Choice { values, .. } => v.round().clamp(0.0, values.len() as f64 - 1.0),
}
}

// The option's next value (`back`: the one before), wrapping around at the ends.
step_value :: proc(kind: ^OptionKind, v: f64, back: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let dir = if back { -1.0 } else { 1.0 };
    // rust: match kind {
    // rust: OptionKind::Bool { .. } => f64::from(u8::from(v == 0.0)),
    // rust: OptionKind::Float { min, max, step, .. } => {
    // rust: let (min, max, step) = (f64::from(*min), f64::from(*max), f64::from(*step));
    // rust: if !back && v >= max - step * 0.01 {
    // rust: min
    // rust: } else if back && v <= min + step * 0.01 {
    // rust: max
    // rust: } else {
                // On the grid of steps from the minimum, so float error never piles up.
    // rust: let n = ((v - min) / step).round() + dir;
    // rust: (min + n * step).clamp(min, max)
}
}
    // rust: OptionKind::Int { min, max, .. } => {
    // rust: let (min, max) = (f64::from(*min), f64::from(*max));
    // rust: let n = v.round() + dir;
    // rust: if n > max {
    // rust: min
    // rust: } else if n < min {
    // rust: max
    // rust: } else {
    // rust: n
}
}
    // rust: OptionKind::Choice { values, .. } => {
    // rust: let n = values.len() as f64;
    // rust: (v.round() + dir).rem_euclid(n)
}
}
}

// Where `v` sits between the option's minimum and maximum, 0 to 1; `None` for the options
// that are buttons.
slider_position :: proc(kind: ^OptionKind, v: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (min, max) = match kind {
    // rust: OptionKind::Float { min, max, .. } => (f64::from(*min), f64::from(*max)),
    // rust: OptionKind::Int { min, max, .. } => (f64::from(*min), f64::from(*max)),
    // rust: _ => return None,
}
    // rust: Some(((v - min) / (max - min)).clamp(0.0, 1.0) as f32)
}

// The option's value nearest the slider position `at`: a float on its steps from the
// minimum (the last one the maximum, when the range isn't a whole number of steps), an int
// whole.
slider_value :: proc(kind: ^OptionKind, at: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let at = f64::from(at.clamp(0.0, 1.0));
    // rust: match kind {
    // rust: OptionKind::Float { min, max, step, .. } => {
    // rust: let (min, max, step) = (f64::from(*min), f64::from(*max), f64::from(*step));
    // rust: let steps = ((max - min) / step - 1e-6).ceil();
    // rust: Some(on_f32((min + (at * steps).round() * step).min(max)))
}
    // rust: OptionKind::Int { min, max, .. } => {
    // rust: let (min, max) = (f64::from(*min), f64::from(*max));
    // rust: Some((min + at * (max - min)).round())
}
    // rust: _ => None,
}
}

// `v` as the `f32` the pack's `override` gets: a step of 0.05 is no f32, and 20 of them would
// otherwise miss a default of 1 by a hair.
on_f32 :: proc(v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(v as f32)
}

// The value as the settings page shows it.
show_value :: proc(kind: ^OptionKind, v: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: OptionKind::Bool { .. } => crate::lang::get(if v != 0.0 {
    // rust: "options.on"
    // rust: } else {
    // rust: "options.off"
    // rust: }),
    // rust: OptionKind::Float { step, .. } => {
    // rust: let digits = if *step >= 1.0 {
    // rust: 0
    // rust: } else if *step >= 0.1 {
    // rust: 1
    // rust: } else {
    // rust: 2
}
    // rust: format!("{v:.digits$}")
}
    // rust: OptionKind::Int { .. } => format!("{v:.0}"),
    // rust: OptionKind::Choice { values, .. } => {
    // rust: values.get(v.round() as usize).cloned().unwrap_or_default()
}
}
}

    // rust: mod tests {
//     use super::*;

lists_both_kinds_horizon_first_and_skips_the_rest :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-shader-list-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let d = dir.as_path();
    // rust: let manifest = "schema = 1\nid = \"warm\"\nname = \"Warm Light\"\nversion = \"1\"\n\
    // rust: api = \"0.1\"\n[[post]]\nfile = \"p.wgsl\"\n";
    // rust: std::fs::create_dir(d.join("warm")).unwrap();
    // rust: std::fs::write(d.join("warm").join(horizon_shader_api::MANIFEST), manifest).unwrap();
    // rust: std::fs::create_dir_all(d.join("Classic Folder/shaders")).unwrap();
    // rust: std::fs::write(d.join("archive.zip"), b"").unwrap();
    // rust: std::fs::write(d.join("notes.txt"), b"").unwrap();
    // rust: std::fs::create_dir(d.join("empty")).unwrap();
    // rust: std::fs::create_dir_all(d.join(".hidden/shaders")).unwrap();
    // rust: let packs = scan(d);
    // rust: let listed: Vec<(&str, &str, Kind)> = packs
    // rust: .iter()
    // rust: .map(|e| (e.file.as_str(), e.title.as_str(), e.kind))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: listed,
    // rust: [
    // rust: ("warm", "Warm Light", Kind::Horizon),
    // rust: ("archive.zip", "archive.zip", Kind::Classic),
    // rust: ("Classic Folder", "Classic Folder", Kind::Classic),
    // rust: ]
    // rust: );
    // rust: assert!(scan(&d.join("missing")).is_empty());
    // rust: std::fs::remove_dir_all(d).unwrap();
}

option :: proc(id: string, kind: OptionKind) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PackOption {
    // rust: id: id.into(),
    // rust: name: id.into(),
    // rust: description: String::new(),
    // rust: kind,
}
}

values_step_wrap_and_round_trip :: proc() {
}
    // rust: let float = OptionKind::Float {
    // rust: default: 1.0,
    // rust: min: 0.0,
    // rust: max: 2.0,
    // rust: step: 0.5,
}
    // rust: assert_eq!(step_value(&float, 1.0, false), 1.5);
    // rust: assert_eq!(step_value(&float, 2.0, false), 0.0);
    // rust: assert_eq!(step_value(&float, 0.0, true), 2.0);
    // rust: assert_eq!(show_value(&float, 1.5), "1.5");
    // rust: let choice = OptionKind::Choice {
    // rust: values: vec!["a".into(), "b".into(), "c".into()],
    // rust: default: 0,
}
    // rust: assert_eq!(step_value(&choice, 2.0, false), 0.0);
    // rust: assert_eq!(step_value(&choice, 0.0, true), 2.0);
    // rust: assert_eq!(show_value(&choice, 1.0), "b");
    // rust: let int = OptionKind::Int {
    // rust: default: 0,
    // rust: min: -1,
    // rust: max: 1,
}
    // rust: assert_eq!(step_value(&int, 1.0, false), -1.0);
    // rust: let on = OptionKind::Bool { default: true };
    // rust: assert_eq!(step_value(&on, 1.0, false), 0.0);

    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-shader-values-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let pack = dir.join("p.hshader");
    // rust: let options = [option("a", float), option("b", choice)];
        // Only what differs from the defaults is written; out of range comes back clamped.
    // rust: save_values(&pack, &options, &[1.0, 2.0]).unwrap();
    // rust: let text = std::fs::read_to_string(values_path(&pack)).unwrap();
    // rust: assert_eq!(text, "b=2\n");
    // rust: std::fs::write(values_path(&pack), "a=9\nb=1\nzzz=4\n").unwrap();
    // rust: assert_eq!(load_values(&pack, &options), [2.0, 1.0]);
    // rust: save_values(&pack, &options, &[1.0, 0.0]).unwrap();
    // rust: assert!(!values_path(&pack).exists());
    // rust: assert_eq!(load_values(&pack, &options), [1.0, 0.0]);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

sliders_take_the_nearest_step_and_stop_at_the_ends :: proc() {
}
    // rust: let float = |default, max, step| OptionKind::Float {
    // rust: default,
    // rust: min: 0.0,
    // rust: max,
    // rust: step,
}
    // rust: let int = OptionKind::Int {
    // rust: default: 2,
    // rust: min: 0,
    // rust: max: 10,
}
    // rust: let mut entry = Entry {
    // rust: file: "p".into(),
    // rust: title: "P".into(),
    // rust: kind: Kind::Horizon,
    // rust: options: vec![
    // rust: option("a", float(1.0, 2.0, 0.05)),
    // rust: option("b", int),
    // rust: option("c", OptionKind::Bool { default: true }),
    // rust: option("d", float(0.0, 1.0, 0.3)),
    // rust: ],
    // rust: values: vec![1.0, 2.0, 1.0, 0.0],
    // rust: pages: Vec::new(),
}
    // rust: assert_eq!(entry.slider_position(0), Some(0.5));
    // rust: assert_eq!(entry.slider_position(1), Some(0.2));
        // A bool (and a choice) stays a button.
    // rust: assert_eq!(entry.slider_position(2), None);
    // rust: assert!(!entry.set_slider_position(2, 0.0));
    // rust: assert_eq!(entry.values[2], 1.0);
        // 0.26 of 0..2 is 0.52: the step below.
    // rust: assert!(entry.set_slider_position(0, 0.26));
    // rust: assert_eq!(show_value(&entry.options[0].kind, entry.values[0]), "0.50");
        // Twenty steps of 0.05 are the default of 1 exactly, so it isn't saved.
    // rust: assert!(entry.set_slider_position(0, 0.5));
    // rust: assert_eq!(entry.values[0], 1.0);
    // rust: assert!(!entry.set_slider_position(0, 0.505));
        // 5.7 of 0..10 is 6.
    // rust: assert!(entry.set_slider_position(1, 0.57));
    // rust: assert_eq!(entry.values[1], 6.0);
        // A range that isn't a whole number of steps still reaches its maximum.
    // rust: entry.set_slider_position(3, 1.0);
    // rust: assert_eq!(entry.values[3], 1.0);
    // rust: entry.set_slider_position(3, 0.6);
    // rust: assert_eq!(entry.values[3], f64::from(0.6_f32));

        // The arrow keys: a step at a time, not round past the ends.
    // rust: entry.values[0] = 2.0;
    // rust: assert!(!entry.nudge_option(0, false));
    // rust: assert_eq!(entry.values[0], 2.0);
    // rust: assert!(entry.nudge_option(0, true));
    // rust: assert_eq!(entry.values[0], f64::from(1.95_f32));
    // rust: entry.values[1] = 0.0;
    // rust: assert!(!entry.nudge_option(1, true));
    // rust: assert!(entry.nudge_option(1, false));
    // rust: assert_eq!(entry.values[1], 1.0);
    // rust: assert!(!entry.nudge_option(2, false));
}
}
