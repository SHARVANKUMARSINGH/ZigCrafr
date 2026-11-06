//! Transpiled from Horizon Rust crate
package horizon_port_pack_density

import "core:fmt"
import "core:mem"
import "core:math"

// Density functions.
// use super::{PackFile, Report, contains_type, full_id, kind, noise::noise_holder, vanilla};
// use serde_json::{Map, Value, json};
// use std::collections::{BTreeMap, BTreeSet};

// Vanilla 26.2 density functions whose value does not depend on y, which
// a pack can name without defining them.
    // rust: const VANILLA_FLAT: [&str; 13] = [
    // rust: "minecraft:zero",
    // rust: "minecraft:shift_x",
    // rust: "minecraft:shift_z",
    // rust: "minecraft:overworld/continents",
    // rust: "minecraft:overworld/erosion",
    // rust: "minecraft:overworld/ridges",
    // rust: "minecraft:overworld/ridges_folded",
    // rust: "minecraft:overworld/offset",
    // rust: "minecraft:overworld/factor",
    // rust: "minecraft:overworld/jaggedness",
    // rust: "minecraft:overworld_large_biomes/continents",
    // rust: "minecraft:overworld_large_biomes/erosion",
    // rust: "minecraft:end/sloped_cheese",
    // rust: ];

    // rust: pub(super) struct Context<'a> {
    // The pack's own density functions by id, in 26.2's form.
    // rust: functions: BTreeMap<String, &'a Value>,
    // The interpolation cell (`size_horizontal * 4`, `size_vertical * 4`)
    // of the noise settings being upgraded, which 26.3 writes on each
    // `interpolated`.
    // rust: pub(super) cell: (i64, i64),
    // The cells of the pack's noise settings that reach each of its named
    // density functions through their routers.
    // rust: cells: BTreeMap<String, BTreeSet<(i64, i64)>>,
    // The cell of every noise settings in the pack.
    // rust: all_cells: BTreeSet<(i64, i64)>,
    // Named density functions the upgrade adds, by id.
    // rust: pub(super) generated: BTreeMap<String, Value>,
    // Material rules the upgrade adds (one per noise settings), by id.
    // rust: pub(super) rules: BTreeMap<String, Value>,
}

    // rust: impl<'a> Context<'a> {
    // rust: pub(super) fn new(files: &'a BTreeMap<String, Value>) -> Self {
    // rust: let mut functions = BTreeMap::new();
    // rust: let mut settings = Vec::new();
    // rust: for (path, v) in files {
    // rust: let Some(f) = PackFile::parse(path) else {
    // rust: continue;
}
    // rust: match f.registry.as_str() {
    // rust: "worldgen/density_function" => {
    // rust: functions.insert(f.id(), v);
}
    // rust: "worldgen/noise_settings" => settings.push(v),
    // rust: _ => {}
}
}
    // rust: let mut ctx = Self {
    // rust: functions,
    // rust: cell: (4, 8),
    // rust: cells: BTreeMap::new(),
    // rust: all_cells: BTreeSet::new(),
    // rust: generated: BTreeMap::new(),
    // rust: rules: BTreeMap::new(),
}
    // rust: for s in settings {
    // rust: let cell = cell_of(s.get("noise").unwrap_or(&Value::Null));
    // rust: ctx.all_cells.insert(cell);
    // rust: let mut reached = BTreeSet::new();
    // rust: ctx.reach(s.get("noise_router").unwrap_or(&Value::Null), &mut reached);
    // rust: for id in reached {
    // rust: ctx.cells.entry(id).or_default().insert(cell);
}
}
    // rust: ctx
}

    // Every pack density function `v` names, directly or through others.
reach :: proc(self: ^Self, v: ^Value, out: ^BTreeSet<string>) {
}
    // rust: match v {
    // rust: Value::String(id) => {
    // rust: let id = full_id(id);
    // rust: if let Some(f) = self.functions.get(&id)
    // rust: && out.insert(id)
    // rust: {
    // rust: self.reach(f, out);
}
}
    // rust: Value::Object(o) => o.values().for_each(|x| self.reach(x, out)),
    // rust: Value::Array(a) => a.iter().for_each(|x| self.reach(x, out)),
    // rust: _ => {}
}
}

    // A named density function file in 26.3's form, with the cell of the
    // noise settings that use it: vanilla's overworld cell when none of the
    // pack's do, the pack's own when it has one.
    // rust: pub(super) fn named_function(&mut self, id: &str, v: &Value, report: &mut Report) -> Value {
    // rust: let cells = self.cells.get(id).cloned().unwrap_or_default();
    // rust: self.cell = match (cells.len(), self.all_cells.len()) {
    // rust: (1, _) => *cells.iter().next().unwrap_or(&(4, 8)),
    // rust: (0, 1) => *self.all_cells.iter().next().unwrap_or(&(4, 8)),
    // rust: (0, _) => (4, 8),
    // rust: _ => {
    // rust: if contains_type(v, "interpolated") {
    // rust: report.lossy("density: an interpolated function shared by noise settings with different cells");
}
    // rust: *cells.iter().next().unwrap_or(&(4, 8))
}
}
    // rust: self.density(v, report)
}

    // One density function (a number, an id, or an object) in 26.3's form.
    // rust: pub(super) fn density(&mut self, v: &Value, report: &mut Report) -> Value {
    // rust: let Value::Object(o) = v else {
    // rust: return v.clone();
}
    // rust: let Some(t) = kind(v) else {
    // rust: return v.clone();
}
    // rust: let arg = |name: &str| o.get(name).cloned().unwrap_or(Value::Null);
    // rust: let unary = |this: &mut Self, report: &mut Report, to: &str| {
    // rust: let input = this.density(&arg("argument"), report);
    // rust: json!({"type": format!("minecraft:{to}"), "input": input})
}
    // rust: match t {
    // rust: "abs" | "square" | "cube" | "half_negative" | "quarter_negative" | "squeeze"
    // rust: | "blend_density" => unary(self, report, t),
    // rust: "invert" => unary(self, report, "reciprocal"),
    // rust: "add" | "mul" | "min" | "max" => {
    // rust: let left = self.density(&arg("argument1"), report);
    // rust: let right = self.density(&arg("argument2"), report);
    // rust: json!({"type": format!("minecraft:{t}"), "left": left, "right": right})
}
    // rust: "interpolated" => {
    // rust: let input = self.density(&arg("argument"), report);
    // rust: json!({"type": "minecraft:interpolated", "cell_size_xz": self.cell.0,
    // rust: "cell_size_y": self.cell.1, "input": input})
}
            // 26.2's flat cache holds the value at y = 0 of each column
            // inside the chunk; 26.3's cache only memoises.
    // rust: "flat_cache" => {
    // rust: let raw = arg("argument");
    // rust: let input = self.density(&raw, report);
    // rust: let input = if self.depends_on_y(&raw, &mut BTreeSet::new()) {
    // rust: json!({"type": "minecraft:slice", "axis": "y", "coordinate": 0, "input": input})
    // rust: } else {
    // rust: input
}
    // rust: json!({"type": "minecraft:cache", "input": input})
}
    // rust: "cache_2d" | "cache_once" | "cache_all_in_cell" => {
    // rust: let raw = arg("argument");
    // rust: if t == "cache_2d" && self.depends_on_y(&raw, &mut BTreeSet::new()) {
    // rust: report.lossy("density: cache_2d around a function of y");
}
    // rust: let input = self.density(&raw, report);
    // rust: json!({"type": "minecraft:cache", "input": input})
}
    // rust: "y_clamped_gradient" => {
    // rust: let (from, to) = (arg("from_y"), arg("to_y"));
    // rust: if from == to {
                    // A step at that y: clampedMap's NaN at the step itself
                    // has no 26.3 form.
    // rust: report.lossy("density: y_clamped_gradient with from_y == to_y");
    // rust: let y = from.as_f64().unwrap_or_default();
    // rust: return json!({"type": "minecraft:range_choice", "input": "minecraft:y",
    // rust: "min_inclusive": -1_000_000.0, "max_exclusive": y,
    // rust: "when_in_range": arg("from_value"), "when_out_of_range": arg("to_value")});
}
    // rust: json!({"type": "minecraft:gradient", "axis": "y", "from_coordinate": from,
    // rust: "to_coordinate": to, "from_value": arg("from_value"),
    // rust: "to_value": arg("to_value")})
}
    // rust: "noise" => {
    // rust: let mut n = o.clone();
    // rust: n.insert("noise".into(), noise_holder(&arg("noise"), report));
    // rust: Value::Object(n)
}
    // rust: "shifted_noise" => {
    // rust: let mut n = Map::new();
    // rust: n.insert("type".into(), vanilla("noise"));
    // rust: n.insert("noise".into(), noise_holder(&arg("noise"), report));
    // rust: n.insert("xz_scale".into(), arg("xz_scale"));
    // rust: n.insert("y_scale".into(), arg("y_scale"));
    // rust: n.insert("shift_x".into(), self.density(&arg("shift_x"), report));
    // rust: let shift_y = arg("shift_y");
    // rust: if !shift_y.as_f64().is_some_and(|y| y == 0.0) {
    // rust: n.insert("shift_y".into(), self.density(&shift_y, report));
}
    // rust: n.insert("shift_z".into(), self.density(&arg("shift_z"), report));
    // rust: Value::Object(n)
}
    // rust: "shift_a" | "shift_b" | "shift" => {
    // rust: json!({"type": format!("minecraft:{t}"), "noise": noise_holder(&arg("argument"), report)})
}
    // rust: "end_islands" => json!({"type": "minecraft:end_outer_islands"}),
    // rust: "constant" => arg("argument"),
    // rust: "clamp" | "range_choice" | "find_top_surface" | "interval_select" => {
    // rust: let mut n = o.clone();
    // rust: for key in [
    // rust: "input",
    // rust: "when_in_range",
    // rust: "when_out_of_range",
    // rust: "density",
    // rust: "upper_bound",
    // rust: ] {
    // rust: if let Some(x) = o.get(key) {
    // rust: n.insert(key.into(), self.density(x, report));
}
}
    // rust: if let Some(Value::Array(fs)) = o.get("functions") {
    // rust: let fs = fs.iter().map(|f| self.density(f, report)).collect();
    // rust: n.insert("functions".into(), Value::Array(fs));
}
    // rust: Value::Object(n)
}
    // rust: "spline" => {
    // rust: let spline = self.spline(&arg("spline"), report);
    // rust: json!({"type": "minecraft:spline", "spline": spline})
}
    // rust: "old_blended_noise" | "blend_alpha" | "blend_offset" | "beardifier" => v.clone(),
    // rust: other => {
    // rust: report.unknown(format!("density function {other}"));
    // rust: v.clone()
}
}
}

    // A cubic spline: a number, or a coordinate and points whose values are
    // splines themselves.
spline :: proc(self: ^Self, v: ^Value, report: ^Report) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Value::Object(o) = v else {
    // rust: return v.clone();
}
    // rust: let mut n = o.clone();
    // rust: if let Some(c) = o.get("coordinate") {
    // rust: n.insert("coordinate".into(), self.density(c, report));
}
    // rust: if let Some(Value::Array(points)) = o.get("points") {
    // rust: let points = points
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let mut p = p.clone();
    // rust: if let Some(value) = p.get("value").cloned() {
    // rust: p["value"] = self.spline(&value, report);
}
    // rust: p
    // rust: })
    // rust: .collect();
    // rust: n.insert("points".into(), Value::Array(points));
}
    // rust: Value::Object(n)
}

    // Whether a 26.2 density function's value can change with y, through
    // the pack's own functions; unknown ids count as depending on y.
depends_on_y :: proc(self: ^Self, v: ^Value, visiting: ^BTreeSet<string>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Number(_) => false,
    // rust: Value::String(id) => {
    // rust: let id = if id.contains(':') {
    // rust: id.clone()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: if id == "minecraft:y" {
    // rust: return true;
}
    // rust: if let Some(f) = self.functions.get(&id) {
    // rust: return visiting.insert(id.clone()) && {
    // rust: let r = self.depends_on_y(f, visiting);
    // rust: visiting.remove(&id);
    // rust: r
}
}
    // rust: !VANILLA_FLAT.contains(&id.as_str())
}
    // rust: Value::Object(o) => match kind(v) {
    // rust: Some("y_clamped_gradient" | "old_blended_noise" | "beardifier" | "shift") => true,
    // rust: Some("flat_cache" | "end_islands" | "find_top_surface" | "constant") => false,
    // rust: Some("blend_alpha" | "blend_offset" | "shift_a" | "shift_b") => false,
    // rust: Some("noise") => o.get("y_scale").and_then(Value::as_f64) != Some(0.0),
    // rust: Some("shifted_noise") => {
    // rust: o.get("y_scale").and_then(Value::as_f64) != Some(0.0)
    // rust: || ["shift_x", "shift_y", "shift_z"]
    // rust: .iter()
    // rust: .any(|k| o.get(*k).is_some_and(|x| self.depends_on_y(x, visiting)))
}
    // rust: Some("spline") => self.spline_depends_on_y(&o["spline"], visiting),
    // rust: _ => o
    // rust: .iter()
    // rust: .filter(|(k, _)| *k != "type")
    // rust: .any(|(_, x)| match x {
    // rust: Value::Array(a) => a.iter().any(|x| self.depends_on_y(x, visiting)),
    // rust: x => self.depends_on_y(x, visiting),
    // rust: }),
    // rust: },
    // rust: _ => false,
}
}

spline_depends_on_y :: proc(self: ^Self, v: ^Value, visiting: ^BTreeSet<string>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Value::Object(o) = v else {
    // rust: return false;
}
    // rust: o.get("coordinate")
    // rust: .is_some_and(|c| self.depends_on_y(c, visiting))
    // rust: || o.get("points").and_then(Value::as_array).is_some_and(|ps| {
    // rust: ps.iter().any(|p| {
    // rust: p.get("value")
    // rust: .is_some_and(|x| self.spline_depends_on_y(x, visiting))
    // rust: })
    // rust: })
}
}

// The interpolation cell of 26.2 `noise` settings.
    // rust: pub(super) fn cell_of(noise: &Value) -> (i64, i64) {
    // rust: let size = |k: &str, d: i64| noise.get(k).and_then(Value::as_i64).unwrap_or(d) * 4;
    // rust: (size("size_horizontal", 1), size("size_vertical", 2))
}
