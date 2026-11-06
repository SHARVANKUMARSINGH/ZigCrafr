//! Transpiled from Horizon Rust crate
package horizon_optifine_curves

import "core:fmt"
import "core:mem"
import "core:math"

// The curves behind CEM's `ease*`, spline and `keyframe` functions: easings.net's easings
// and the splines EMF documents, on plain `f32`s.

PI :: std::f32::consts::PI

// The family of an `ease*` function.
Curve :: enum {
    Quad,
    Cubic,
    Quart,
    Quint,
    Sine,
    Expo,
    Circ,
    Back,
    Elastic,
    Bounce,
}

// Which end of the curve eases.
Ease :: enum {
    In,
    Out,
    InOut,
}

    // rust: impl Curve {
named :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
//         use Curve::*;
    // rust: Some(match name {
    // rust: "quad" => Quad,
    // rust: "cubic" => Cubic,
    // rust: "quart" => Quart,
    // rust: "quint" => Quint,
    // rust: "sine" => Sine,
    // rust: "expo" => Expo,
    // rust: "circ" => Circ,
    // rust: "back" => Back,
    // rust: "elastic" => Elastic,
    // rust: "bounce" => Bounce,
    // rust: _ => return None,
    // rust: })
}

    // The ease-in curve at `t`.
ease_in :: proc(self: ^Self, t: f32) -> f {
    // Ported from Horizon
    return {}
}
//         use Curve::*;
    // rust: let c1 = 1.70158;
    // rust: match self {
    // rust: Quad => t * t,
    // rust: Cubic => t.powi(3),
    // rust: Quart => t.powi(4),
    // rust: Quint => t.powi(5),
    // rust: Sine => 1.0 - (t * PI / 2.0).cos(),
    // rust: Expo if t == 0.0 => 0.0,
    // rust: Expo => 2f32.powf(10.0 * t - 10.0),
    // rust: Circ => 1.0 - (1.0 - t * t).sqrt(),
    // rust: Back => (c1 + 1.0) * t.powi(3) - c1 * t * t,
    // rust: Elastic if t == 0.0 || t == 1.0 => t,
    // rust: Elastic => {
    // rust: -(2f32.powf(10.0 * t - 10.0)) * ((t * 10.0 - 10.75) * (2.0 * PI / 3.0)).sin()
}
    // rust: Bounce => 1.0 - bounce_out(1.0 - t),
}
}

    // The curve at `t`, 0 at 0 and 1 at 1. Ease-out mirrors ease-in; ease-in-out runs ease-in
    // at double speed, then its mirror, except back and elastic, which have their own.
at :: proc(self: ^Self, ease: Ease, t: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (c2, c5) = (1.70158 * 1.525, 2.0 * PI / 4.5);
    // rust: match (ease, self) {
    // rust: (Ease::In, _) => self.ease_in(t),
    // rust: (Ease::Out, _) => 1.0 - self.ease_in(1.0 - t),
    // rust: (Ease::InOut, Curve::Back) if t < 0.5 => {
    // rust: (2.0 * t).powi(2) * ((c2 + 1.0) * 2.0 * t - c2) / 2.0
}
    // rust: (Ease::InOut, Curve::Back) => {
    // rust: ((2.0 * t - 2.0).powi(2) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) / 2.0
}
    // rust: (Ease::InOut, Curve::Elastic) if t == 0.0 || t == 1.0 => t,
    // rust: (Ease::InOut, Curve::Elastic) if t < 0.5 => {
    // rust: -(2f32.powf(20.0 * t - 10.0) * ((20.0 * t - 11.125) * c5).sin()) / 2.0
}
    // rust: (Ease::InOut, Curve::Elastic) => {
    // rust: 2f32.powf(-20.0 * t + 10.0) * ((20.0 * t - 11.125) * c5).sin() / 2.0 + 1.0
}
    // rust: (Ease::InOut, _) if t < 0.5 => self.ease_in(2.0 * t) / 2.0,
    // rust: (Ease::InOut, _) => 1.0 - self.ease_in(2.0 - 2.0 * t) / 2.0,
}
}
}

bounce_out :: proc(t: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (n, d) = (7.5625, 2.75);
    // rust: if t < 1.0 / d {
    // rust: n * t * t
    // rust: } else if t < 2.0 / d {
    // rust: let t = t - 1.5 / d;
    // rust: n * t * t + 0.75
    // rust: } else if t < 2.5 / d {
    // rust: let t = t - 2.25 / d;
    // rust: n * t * t + 0.9375
    // rust: } else {
    // rust: let t = t - 2.625 / d;
    // rust: n * t * t + 0.984375
}
}

lerp :: proc(k: f32, x: f32, y: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: x + k * (y - x)
}

// `keyframe(k, frames...)`: frame `i` at `k = i`, the last one past the end; `keyframeloop`
// goes from the last frame back to the first. A negative `k` counts as positive.
keyframe :: proc(k: f32, frames: ^[f32], looped: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let n = frames.len();
    // rust: let mut k = k.abs();
    // rust: if looped {
    // rust: k %= n as f32;
    // rust: } else if k >= (n - 1) as f32 {
    // rust: return frames[n - 1];
}
    // `k` is below `n` (below `n - 1` without the loop) or NaN, which converts to 0.
    // rust: let i = (k.floor() as usize).min(n - 1);
    // rust: lerp(k - i as f32, frames[i], frames[(i + 1) % n])
}

// `Mth.catmullrom(k, p0, p1, p2, p3)`: from p1 to p2.
catmullrom :: proc(k: f32, p0: f32, p1: f32, p2: f32, p3: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.5 * (2.0 * p1
    // rust: + (p2 - p0) * k
    // rust: + (2.0 * p0 - 5.0 * p1 + 4.0 * p2 - p3) * k * k
    // rust: + (3.0 * p1 - p0 - 3.0 * p2 + p3) * k * k * k)
}

// From x to y with tangents m0 and m1.
hermite :: proc(k: f32, x: f32, y: f32, m0: f32, m1: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (k2, k3) = (k * k, k * k * k);
    // rust: (2.0 * k3 - 3.0 * k2 + 1.0) * x
    // rust: + (k3 - 2.0 * k2 + k) * m0
    // rust: + (-2.0 * k3 + 3.0 * k2) * y
    // rust: + (k3 - k2) * m1
}

// From x to y through control points z and w.
cubic_bezier :: proc(k: f32, x: f32, y: f32, z: f32, w: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let j = 1.0 - k;
    // rust: j * j * j * x + 3.0 * j * j * k * z + 3.0 * j * k * k * w + k * k * k * y
}

// From x to y through control point z.
quad_bezier :: proc(k: f32, x: f32, y: f32, z: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let j = 1.0 - k;
    // rust: j * j * x + 2.0 * j * k * z + k * k * y
}
