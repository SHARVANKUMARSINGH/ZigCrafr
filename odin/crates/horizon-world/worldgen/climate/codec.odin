//! Transpiled from Horizon Rust crate
package horizon_world_codec

import "core:fmt"
import "core:mem"
import "core:math"

// use super::super::{DecodeError, Object, RawValue, number_text, required};
// use super::{Parameter, ParameterPoint, quantize};

float :: proc(raw: ^RawValue, min: f32, max: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value: f32 = number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("climate float"))?;
    // rust: if value.total_cmp(&min).is_lt() || value.total_cmp(&max).is_gt() {
    // rust: return Err(DecodeError::Field("climate float bounds"));
}
    // rust: Ok(value)
}
parameter :: proc(raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (min, max) = if raw.get().starts_with('[') {
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.len() != 2 {
    // rust: return Err(DecodeError::Field("climate interval length"));
}
    // rust: (float(&values[0], -2., 2.)?, float(&values[1], -2., 2.)?)
    // rust: } else if raw.get().starts_with('{') {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: (
    // rust: float(required(&object, "min")?, -2., 2.)?,
    // rust: float(required(&object, "max")?, -2., 2.)?,
    // rust: )
    // rust: } else {
    // rust: let value = float(raw, -2., 2.)?;
    // rust: (value, value)
}
    // rust: if min.total_cmp(&max).is_gt() {
    // rust: return Err(DecodeError::Field("climate interval order"));
}
    // rust: Ok(Parameter::new(quantize(min), quantize(max)))
}
// Vanilla's scalar, two-element list or min/max object climate interval codec.
decode_parameter :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: parameter(&raw)
}
// Six required climate intervals and a required offset in [0,1].
decode_parameter_point :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let mut coordinates = [Parameter::new(0, 0); 6];
    // rust: for (coordinate, name) in coordinates.iter_mut().zip([
    // rust: "temperature",
    // rust: "humidity",
    // rust: "continentalness",
    // rust: "erosion",
    // rust: "depth",
    // rust: "weirdness",
    // rust: ]) {
    // rust: *coordinate = parameter(required(&object, name)?)?;
}
    // rust: let offset = quantize(float(required(&object, "offset")?, 0., 1.)?);
    // rust: Ok(ParameterPoint {
    // rust: coordinates,
    // rust: offset,
    // rust: })
}
