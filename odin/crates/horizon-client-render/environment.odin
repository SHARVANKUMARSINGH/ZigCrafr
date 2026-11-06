//! Transpiled from Horizon Rust crate
package horizon_client_render_environment

import "core:fmt"
import "core:mem"
import "core:math"

// Data-driven environment attributes sampled from the pinned timelines
// (`KeyframeTrackSampler`, `EasingType`): sky/fog colours, sky light factor,
// celestial angles and star brightness for the overworld day cycle.
// use crate::Result;
// use serde_json::Value;
// use std::{collections::HashMap, path::Path};

Easing :: enum {
    Linear,
    Constant,
    Bezier([f32; 4]),
}
    // rust: impl Easing {
apply :: proc(self: ^Self, x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Linear => x,
    // rust: Self::Constant => 0.0,
    // rust: Self::Bezier([x1, y1, x2, y2]) => {
    // rust: let curve =
    // rust: |c1: f32, c2: f32| (3.0 * c1 - 3.0 * c2 + 1.0, -6.0 * c1 + 3.0 * c2, 3.0 * c1);
    // rust: let (ax, bx, cx) = curve(x1, x2);
    // rust: let (ay, by, cy) = curve(y1, y2);
    // rust: let sample = |(a, b, c): (f32, f32, f32), t: f32| ((a * t + b) * t + c) * t;
    // rust: let gradient = |t: f32| (3.0 * ax * t + 2.0 * bx) * t + cx;
    // rust: let mut t = x;
    // rust: let mut solved = false;
    // rust: for _ in 0..4 {
    // rust: let error = sample((ax, bx, cx), t) - x;
    // rust: if error.abs() < 1e-5 {
    // rust: solved = true;
    // rust: break;
}
    // rust: let g = gradient(t);
    // rust: if g < 1e-5 {
    // rust: break;
}
    // rust: t -= (error / g).clamp(-0.25, 0.25);
}
    // rust: if !solved {
    // rust: let (mut t0, mut t1) = (0.0f32, 1.0f32);
    // rust: while t0 < t1 {
    // rust: let error = sample((ax, bx, cx), t) - x;
    // rust: if error.abs() < 1e-5 {
    // rust: break;
}
    // rust: if error < 0.0 {
    // rust: t0 = t;
    // rust: } else {
    // rust: t1 = t;
}
    // rust: let next = (t0 + t1) / 2.0;
    // rust: if next == t {
    // rust: break;
}
    // rust: t = next;
}
}
    // rust: sample((ay, by, cy), t)
}
}
}
}
Track :: struct {
    keyframes: Vec<(i64,
    easing: Easing,
    multiply: bool,
}
parse_value :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().map(|f| [f as f32, 0.0, 0.0, 0.0]),
    // rust: Value::Bool(b) => Some([f32::from(u8::from(*b)), 0.0, 0.0, 0.0]),
    // rust: Value::String(s) => {
    // rust: let hex = s.trim_start_matches('#');
    // rust: let c = u32::from_str_radix(hex, 16).ok()?;
    // rust: let f = |shift: u32| (c >> shift & 255) as f32 / 255.0;
    // rust: Some(if hex.len() == 8 {
    // rust: [f(16), f(8), f(0), f(24)]
    // rust: } else {
    // rust: [f(16), f(8), f(0), 1.0]
    // rust: })
}
    // rust: _ => None,
}
}
    // rust: impl Track {
sample :: proc(self: ^Self, ticks: i64, period: i64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let k = &self.keyframes;
    // rust: if k.len() == 1 {
    // rust: return k[0].1;
}
    // rust: let t = ticks.rem_euclid(period);
    // rust: let (first, last) = (k[0], k[k.len() - 1]);
    // rust: let mut segments = vec![(last.1, last.0 - period, first.1, first.0)];
    // rust: for pair in k.windows(2) {
    // rust: segments.push((pair[0].1, pair[0].0, pair[1].1, pair[1].0));
}
    // rust: segments.push((last.1, last.0, first.1, first.0 + period));
    // rust: let segment = segments
    // rust: .iter()
    // rust: .find(|s| t < s.3)
    // rust: .copied()
    // rust: .unwrap_or(segments[segments.len() - 1]);
    // rust: let (from, from_t, to, to_t) = segment;
    // rust: if t <= from_t {
    // rust: return from;
}
    // rust: if t >= to_t {
    // rust: return to;
}
    // rust: let alpha = self
    // rust: .easing
    // rust: .apply((t - from_t) as f32 / (to_t - from_t) as f32);
    // rust: std::array::from_fn(|i| from[i] + (to[i] - from[i]) * alpha)
}
}
Environment :: struct {
    period: i64,
    tracks: HashMap<string,
    base: HashMap<string,
}
Sky :: struct {
    sky_color: [f32,
    fog_color: [f32,
    sky_light_factor: f32,
    sky_light_color: [f32,
    block_light_tint: [f32,
    ambient_light_color: [f32,
    sun_angle: f32,
    moon_angle: f32,
    star_angle: f32,
    star_brightness: f32,
    sunrise_color: [f32,
    cloud_color: [f32,
    // `gameplay/sky_light_level`, the server-side sky darkening.
    sky_light_level: f32,
    // Environmental fog (`visual/fog_start_distance` / `fog_end_distance`).
    fog_start: f32,
    fog_end: f32,
    // `visual/cloud_fog_end_distance`.
    cloud_fog_end: f32,
    // `visual/cloud_height`.
    cloud_height: f32,
}
    // rust: impl Environment {
load :: proc(root: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::load_dimension(root, "overworld", true)
}
    // A dimension's base attributes, optionally driven by the day timeline.
load_dimension :: proc(root: ^Path, dimension: string, day_cycle: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let timeline: Value = if day_cycle {
    // rust: horizon_world::json_file::read(&root.join("data/minecraft/timeline/day.json"))?
    // rust: } else {
    // rust: serde_json::json!({"period_ticks": 24000, "tracks": {}})
}
    // rust: let dimension: Value = horizon_world::json_file::read(
    // rust: &root.join(format!("data/minecraft/dimension_type/{dimension}.json")),
    // rust: )?;
    // rust: let mut tracks = HashMap::new();
    // rust: for (name, track) in timeline["tracks"].as_object().ok_or("invalid timeline")? {
    // rust: let easing = match &track["ease"] {
    // rust: Value::String(s) if s == "constant" => Easing::Constant,
    // rust: Value::Object(o) => match o.get("cubic_bezier").and_then(Value::as_array) {
    // rust: Some(a) if a.len() == 4 => {
    // rust: Easing::Bezier(std::array::from_fn(|i| a[i].as_f64().unwrap_or(0.0) as f32))
}
    // rust: _ => Easing::Linear,
    // rust: },
    // rust: _ => Easing::Linear,
}
    // rust: let keyframes: Vec<_> = track["keyframes"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|k| Some((k["ticks"].as_i64()?, parse_value(&k["value"])?)))
    // rust: .collect();
    // rust: if keyframes.is_empty() {
    // rust: continue;
}
    // rust: tracks.insert(
    // rust: name.clone(),
    // rust: Track {
    // rust: keyframes,
    // rust: easing,
    // rust: multiply: track["modifier"].as_str() == Some("multiply"),
    // rust: },
    // rust: );
}
    // rust: let mut base: HashMap<String, [f32; 4]> = [
    // rust: ("minecraft:visual/block_light_tint", "#ffd88c"),
    // rust: ("minecraft:visual/sky_light_color", "#ffffff"),
    // rust: ("minecraft:visual/ambient_light_color", "#000000"),
    // rust: ]
    // rust: .into_iter()
    // rust: .filter_map(|(k, v)| Some((k.to_owned(), parse_value(&Value::String(v.into()))?)))
    // rust: .collect();
    // rust: base.insert(
    // rust: "minecraft:visual/sky_light_factor".into(),
    // rust: [1.0, 0.0, 0.0, 0.0],
    // rust: );
        // Sky light level in light levels (the timeline multiplies it).
    // rust: base.insert(
    // rust: "minecraft:gameplay/sky_light_level".into(),
    // rust: [15.0, 0.0, 0.0, 0.0],
    // rust: );
    // rust: for (k, v) in dimension["attributes"].as_object().into_iter().flatten() {
    // rust: if let Some(v) = parse_value(v) {
    // rust: base.insert(k.clone(), v);
}
}
    // rust: Ok(Self {
    // rust: period: timeline["period_ticks"].as_i64().unwrap_or(24000),
    // rust: tracks,
    // rust: base,
    // rust: })
}
value :: proc(self: ^Self, name: string, base: [f32; 4], ticks: i64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match self.tracks.get(name) {
    // rust: Some(track) => {
    // rust: let v = track.sample(ticks, self.period);
    // rust: if track.multiply {
    // rust: std::array::from_fn(|i| base[i] * v[i])
    // rust: } else {
    // rust: v
}
}
    // rust: None => base,
}
}
base :: proc(self: ^Self, name: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.base.get(name).copied().unwrap_or([0.0, 0.0, 0.0, 1.0])
}
    // The dimension's value of an RGB attribute (what biomes without it keep).
base_rgb :: proc(self: ^Self, name: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.base(name);
    // rust: [b[0], b[1], b[2]]
}
    // Sky state for a time of day, with the biomes' (blended) sky and fog
    // colours as base values.
    // rust: pub fn sample(
    // rust: &self,
    // rust: ticks: i64,
    // rust: biome_sky: Option<[f32; 3]>,
    // rust: biome_fog: Option<[f32; 3]>,
    // rust: ) -> Sky {
    // rust: let rgb = |c: [f32; 3]| [c[0], c[1], c[2], 1.0];
    // rust: let v = |name: &str, base: [f32; 4]| self.value(name, base, ticks);
    // rust: let three = |a: [f32; 4]| [a[0], a[1], a[2]];
    // rust: let scalar = |name: &str| {
    // rust: let b = self.base(name);
    // rust: let b = if self.base.contains_key(name) {
    // rust: b
    // rust: } else {
    // rust: [1.0, 0.0, 0.0, 0.0]
}
    // rust: let t = self.tracks.get(name);
    // rust: match t {
    // rust: Some(t) if t.multiply => b[0] * t.sample(ticks, self.period)[0],
    // rust: Some(t) => t.sample(ticks, self.period)[0],
    // rust: None => b[0],
}
}
    // rust: let angle = |name: &str| {
    // rust: self.tracks
    // rust: .get(name)
    // rust: .map_or(0.0, |t| t.sample(ticks, self.period)[0])
}
    // rust: Sky {
    // rust: sky_color: three(v(
    // rust: "minecraft:visual/sky_color",
    // rust: biome_sky.map_or_else(|| self.base("minecraft:visual/sky_color"), rgb),
    // rust: )),
    // rust: fog_color: three(v(
    // rust: "minecraft:visual/fog_color",
    // rust: biome_fog.map_or_else(|| self.base("minecraft:visual/fog_color"), rgb),
    // rust: )),
    // rust: sky_light_factor: scalar("minecraft:visual/sky_light_factor"),
    // rust: sky_light_color: three(v(
    // rust: "minecraft:visual/sky_light_color",
    // rust: self.base("minecraft:visual/sky_light_color"),
    // rust: )),
    // rust: block_light_tint: three(self.base("minecraft:visual/block_light_tint")),
    // rust: ambient_light_color: three(self.base("minecraft:visual/ambient_light_color")),
    // rust: sun_angle: angle("minecraft:visual/sun_angle"),
    // rust: moon_angle: angle("minecraft:visual/moon_angle"),
    // rust: star_angle: angle("minecraft:visual/star_angle"),
    // rust: star_brightness: angle("minecraft:visual/star_brightness"),
    // rust: sunrise_color: self
    // rust: .tracks
    // rust: .get("minecraft:visual/sunrise_sunset_color")
    // rust: .map_or([0.0; 4], |t| t.sample(ticks, self.period)),
    // rust: cloud_color: v(
    // rust: "minecraft:visual/cloud_color",
    // rust: self.base
    // rust: .get("minecraft:visual/cloud_color")
    // rust: .copied()
    // rust: .unwrap_or([0.0; 4]),
    // rust: ),
    // rust: sky_light_level: scalar("minecraft:gameplay/sky_light_level") / 15.0,
    // rust: fog_start: self
    // rust: .base
    // rust: .get("minecraft:visual/fog_start_distance")
    // rust: .map_or(0.0, |v| v[0]),
    // rust: fog_end: self
    // rust: .base
    // rust: .get("minecraft:visual/fog_end_distance")
    // rust: .map_or(1024.0, |v| v[0]),
    // rust: cloud_fog_end: self
    // rust: .base
    // rust: .get("minecraft:visual/cloud_fog_end_distance")
    // rust: .map_or(2048.0, |v| v[0]),
    // rust: cloud_height: self
    // rust: .base
    // rust: .get("minecraft:visual/cloud_height")
    // rust: .map_or(crate::clouds::CLOUD_HEIGHT as f32, |v| v[0]),
}
}
}
// WeatherAttributes: rain then thunder layers lerped by their levels
// (rain counts only the part not covered by thunder).
apply_weather :: proc(sky: ^Sky, rain: f32, thunder: f32) {
}
    // rust: let grey = |c: [f32; 3]| c[0] * 0.3 + c[1] * 0.59 + c[2] * 0.11;
    // rust: let lerp3 = |t: f32, a: [f32; 3], b: [f32; 3]| -> [f32; 3] {
    // rust: std::array::from_fn(|i| a[i] + (b[i] - a[i]) * t)
}
    // rust: let lerp4 = |t: f32, a: [f32; 4], b: [f32; 4]| -> [f32; 4] {
    // rust: std::array::from_fn(|i| a[i] + (b[i] - a[i]) * t)
}
    // rust: let lerp = |t: f32, a: f32, b: f32| a + (b - a) * t;
    // Vanilla stores these colours as 8-bit ARGB (`ARGB.colorFromFloat` floors).
    // rust: let q = |v: f32| (v * 255.0).floor() / 255.0;
    // rust: let night = [q(0.48), q(0.48), 1.0];
    // (level, sky gray (brightness, factor), fog multiplier, cloud gray, alpha, sunrise multiplier)
    // rust: let layers = [
    // rust: (
    // rust: rain - thunder,
    // rust: (0.6, 0.75),
    // rust: [q(0.5), q(0.5), q(0.6)],
    // rust: (0.24, 0.5),
    // rust: 0.3125,
    // rust: [q(0.5), q(0.5), q(0.6)],
    // rust: ),
    // rust: (
    // rust: thunder,
    // rust: (0.24, 0.94),
    // rust: [q(0.25), q(0.25), q(0.3)],
    // rust: (0.095, 0.94),
    // rust: 0.527_343_75,
    // rust: [q(0.25), q(0.25), q(0.3)],
    // rust: ),
    // rust: ];
    // rust: for (level, (sb, sf), fog, (cb, cf), alpha, sunrise) in layers {
    // rust: if level <= 0.0 {
    // rust: continue;
}
    // rust: let g = grey(sky.sky_color) * sb;
    // rust: let target = lerp3(sf, sky.sky_color, [g; 3]);
    // rust: sky.sky_color = lerp3(level, sky.sky_color, target);
    // rust: let fogged = std::array::from_fn(|i| sky.fog_color[i] * fog[i]);
    // rust: sky.fog_color = lerp3(level, sky.fog_color, fogged);
    // rust: let cloud3 = [sky.cloud_color[0], sky.cloud_color[1], sky.cloud_color[2]];
    // rust: let g = grey(cloud3) * cb;
    // rust: let c = lerp3(cf, cloud3, [g; 3]);
    // rust: sky.cloud_color = lerp4(
    // rust: level,
    // rust: sky.cloud_color,
    // rust: [c[0], c[1], c[2], sky.cloud_color[3]],
    // rust: );
        // sky_light_level is a fraction of 15 here; the layer blends towards level 4.
    // rust: let target_level = lerp(alpha, sky.sky_light_level * 15.0, 4.0) / 15.0;
    // rust: sky.sky_light_level = lerp(level, sky.sky_light_level, target_level);
    // rust: sky.sky_light_color = lerp3(
    // rust: level,
    // rust: sky.sky_light_color,
    // rust: lerp3(q(alpha), sky.sky_light_color, night),
    // rust: );
    // rust: sky.sky_light_factor = lerp(
    // rust: level,
    // rust: sky.sky_light_factor,
    // rust: lerp(alpha, sky.sky_light_factor, 0.24),
    // rust: );
    // rust: sky.star_brightness = lerp(level, sky.star_brightness, 0.0);
    // rust: let s = sky.sunrise_color;
    // rust: sky.sunrise_color = lerp4(
    // rust: level,
    // rust: s,
    // rust: [
    // rust: s[0] * sunrise[0],
    // rust: s[1] * sunrise[1],
    // rust: s[2] * sunrise[2],
    // rust: s[3],
    // rust: ],
    // rust: );
}
}

sky_darken :: proc(environment: ^Environment, day_time: i64, rain: f32, thunder: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut sky = environment.sample(day_time, None, None);
    // rust: apply_weather(&mut sky, rain, thunder);
    // Level.updateSkyBrightness: darkening from the sky light level.
    // rust: (15.0 - 15.0 * sky.sky_light_level).round() as i32
}

    // rust: mod tests {
//     use super::*;

overworld :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: root.join("data/minecraft/timeline/day.json")
    // rust: .exists()
    // rust: .then(|| Environment::load(&root).unwrap())
}

dark_outside_follows_time_and_weather_levels :: proc() {
}
    // rust: let Some(env) = overworld() else {
    // rust: return;
}
    // rust: let dark = |time, rain, thunder| sky_darken(&env, time, rain, thunder) >= 4;
    // rust: assert!(!dark(6000, 0.0, 0.0), "clear noon");
    // rust: assert!(!dark(6000, 1.0, 0.0), "rainy noon");
    // rust: assert!(dark(6000, 1.0, 1.0), "thunderstorm at noon");
    // rust: assert!(dark(18000, 0.0, 0.0), "clear midnight");
    // rust: assert!(!dark(1000, 0.0, 0.0), "clear morning");
}
}
