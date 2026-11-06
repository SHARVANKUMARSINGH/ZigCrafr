//! Transpiled from Horizon Rust crate
package horizon_port_pack_noise

import "core:fmt"
import "core:mem"
import "core:math"

// Noise parameters: 26.2's `{firstOctave, amplitudes}` as 26.3's `NormalNoise` parameters.
// use super::Report;
// use serde_json::{Map, Value, json};

// `{firstOctave, amplitudes}` to 26.3's `NormalNoise` parameters, as
// vanilla's `NormalNoise.createParity` builds them: the same octaves and
// the base amplitude that keeps 26.2's normalisation.
    // rust: pub(super) fn noise(v: &Value, report: &mut Report) -> Value {
    // rust: let (Some(first), Some(amps)) = (
    // rust: v.get("firstOctave").and_then(Value::as_i64),
    // rust: v.get("amplitudes").and_then(Value::as_array),
    // rust: ) else {
    // rust: return v.clone();
}
    // rust: let amps: Vec<f64> = amps.iter().filter_map(Value::as_f64).collect();
    // rust: if amps.is_empty() || amps.len() > 32 || amps.iter().any(|a| *a < 0.0) {
    // rust: report.lossy("noise: more than 32 octaves or negative amplitudes (left as they are)");
    // rust: return v.clone();
}
    // rust: let mut o = Map::new();
    // rust: let base = parity_base_amplitude(first as i32, &amps);
    // rust: if base != 1.0 {
    // rust: o.insert("base_amplitude".into(), json!(base));
}
    // rust: o.insert("base_octave".into(), json!(first));
    // rust: if amps.len() != 1 {
    // rust: o.insert("octave_count".into(), json!(amps.len()));
}
    // rust: if amps.iter().any(|a| *a != 1.0) {
    // rust: o.insert("amplitude_modifiers".into(), json!(amps));
}
    // rust: Value::Object(o)
}

// `NormalNoise.computeParityBaseAmplitude`.
parity_base_amplitude :: proc(base_octave: i32, amps: ^[f64]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let octaves = build_octaves(base_octave, 1.0, amps.len(), amps);
    // rust: let target: f64 = java_sum(octaves.iter().map(|a| a.abs()));
    // rust: let new = normalization_factor(target, &octaves);
    // rust: if new == 0.0 {
    // rust: return 1.0;
}
    // rust: parity_normalization_factor(1.0, amps) / new
}

// `NormalNoise.buildOctaves` with normalisation on: the octaves' signed
// amplitudes (zero-modifier octaves left out).
build_octaves :: proc(_base_octave: i32, base_amplitude: f64, count: uint, mods: ^[f64]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let n = count as i32;
    // rust: let mut amplitude = base_amplitude * (0.5f64.powi(-(n - 1)) / (0.5f64.powi(-n) - 1.0));
    // rust: let mut out = Vec::new();
    // rust: for i in 0..count {
    // rust: let m = mods.get(i).copied().unwrap_or(1.0);
    // rust: if m != 0.0 {
    // rust: out.push(amplitude * m);
}
    // rust: amplitude *= 0.5;
}
    // rust: out
}

normalization_factor :: proc(target: f64, octaves: ^[f64]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut variance = 0.0;
    // rust: for a in octaves {
    // rust: let layer = 0.2702247831245211 * a.abs();
    // rust: variance += layer * layer;
}
    // rust: let deviation = variance.sqrt();
    // rust: if deviation == 0.0 {
    // rust: return 0.0;
}
    // rust: target * 0.3333333333333333 / (deviation * 2f64.sqrt())
}

parity_normalization_factor :: proc(base_amplitude: f64, mods: ^[f64]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (mut min, mut max) = (i32::MAX, i32::MIN);
    // rust: for (i, m) in mods.iter().enumerate() {
    // rust: if *m != 0.0 {
    // rust: min = min.min(i as i32);
    // rust: max = max.max(i as i32);
}
}
    // rust: let span = max.wrapping_sub(min);
    // rust: base_amplitude * 0.5 * 0.3333333333333333 / (0.1 * (1.0 + 1.0 / f64::from(span + 1)))
}

// `DoubleStream.sum()`: Kahan summation as `Collectors.sumWithCompensation`
// and `computeFinalSum` do it.
java_sum :: proc(values: impl Iterator<Item = f64>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (mut sum, mut c, mut simple) = (0.0f64, 0.0f64, 0.0f64);
    // rust: for v in values {
    // rust: simple += v;
    // rust: let tmp = v - c;
    // rust: let velvel = sum + tmp;
    // rust: c = (velvel - sum) - tmp;
    // rust: sum = velvel;
}
    // rust: let tmp = sum - c;
    // rust: if tmp.is_nan() && simple.is_infinite() {
    // rust: simple
    // rust: } else {
    // rust: tmp
}
}

// A noise holder: an id, or inline parameters to upgrade.
    // rust: pub(super) fn noise_holder(v: &Value, report: &mut Report) -> Value {
    // rust: match v {
    // rust: Value::Object(_) => noise(v, report),
    // rust: other => other.clone(),
}
}
