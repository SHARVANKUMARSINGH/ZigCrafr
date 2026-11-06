//! Transpiled from Horizon Rust crate
package horizon_core_simplex

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{GRADIENTS, GradientTable};
// use crate::{geometry::floor_i32, random::RandomSource};

SimplexNoise :: struct {
    table: GradientTable,
}

    // rust: impl SimplexNoise {
new :: proc(random: ^impl RandomSource) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::with_skipped_offsets(random, false)
}
with_skipped_offsets :: proc(random: ^impl RandomSource, skip_offsets: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: table: GradientTable::new(random, if skip_offsets { 0.0 } else { 256.0 }),
}
}
table :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.table
}
range :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [-2.0, 2.0]
}

corner :: proc(gradient: uint, point: [f64; 3], radius: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let attenuation = radius - point[0] * point[0] - point[1] * point[1] - point[2] * point[2];
        // Negative attenuation contributes zero; NaN follows the arithmetic path.
    // rust: if attenuation < 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: let squared = attenuation * attenuation;
    // rust: let g = GRADIENTS[gradient];
    // rust: squared
    // rust: * squared
    // rust: * (f64::from(g[0]) * point[0]
    // rust: + f64::from(g[1]) * point[1]
    // rust: + f64::from(g[2]) * point[2])
}
}

get2 :: proc(self: ^Self, x: f64, y: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let x = x + self.table.offsets[0];
    // rust: let y = y + self.table.offsets[1];
    // rust: let root3 = 3.0_f64.sqrt();
    // rust: let skew = 0.5 * (root3 - 1.0);
    // rust: let unskew = (3.0 - root3) / 6.0;
    // rust: let shift = (x + y) * skew;
    // rust: let i = floor_i32(x + shift);
    // rust: let j = floor_i32(y + shift);
    // rust: let shift = f64::from(i.wrapping_add(j)) * unskew;
    // rust: let dx = x - (f64::from(i) - shift);
    // rust: let dy = y - (f64::from(j) - shift);
    // rust: let (a, b) = if dx > dy { (1, 0) } else { (0, 1) };
    // rust: let i = i & 255;
    // rust: let j = j & 255;
    // rust: let grad = |a, b| (self.table.permute(i + a + self.table.permute(j + b)) % 12) as usize;
    // rust: let first = Self::corner(grad(0, 0), [dx, dy, 0.0], 0.5);
    // rust: let second = Self::corner(
    // rust: grad(a, b),
    // rust: [dx - f64::from(a) + unskew, dy - f64::from(b) + unskew, 0.0],
    // rust: 0.5,
    // rust: );
    // rust: let third = Self::corner(
    // rust: grad(1, 1),
    // rust: [dx - 1.0 + 2.0 * unskew, dy - 1.0 + 2.0 * unskew, 0.0],
    // rust: 0.5,
    // rust: );
    // rust: (70.0 * (first + second + third)) as f32
}

get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let shifted = [
    // rust: x + self.table.offsets[0],
    // rust: y + self.table.offsets[1],
    // rust: z + self.table.offsets[2],
    // rust: ];
    // rust: let skew = (shifted[0] + shifted[1] + shifted[2]) * (1.0 / 3.0);
    // rust: let cell = shifted.map(|v| floor_i32(v + skew));
    // rust: let unskew = f64::from(cell[0].wrapping_add(cell[1]).wrapping_add(cell[2])) * (1.0 / 6.0);
    // rust: let point: [f64; 3] = std::array::from_fn(|i| shifted[i] - (f64::from(cell[i]) - unskew));
    // rust: let [x, y, z] = point;
    // rust: let (a, b) = if x >= y {
    // rust: if y >= z {
    // rust: ([1, 0, 0], [1, 1, 0])
    // rust: } else if x >= z {
    // rust: ([1, 0, 0], [1, 0, 1])
    // rust: } else {
    // rust: ([0, 0, 1], [1, 0, 1])
}
    // rust: } else if y < z {
    // rust: ([0, 0, 1], [0, 1, 1])
    // rust: } else if x < z {
    // rust: ([0, 1, 0], [0, 1, 1])
    // rust: } else {
    // rust: ([0, 1, 0], [1, 1, 0])
}
    // rust: let cell = cell.map(|v| v & 255);
    // rust: let grad = |delta: [i32; 3]| {
    // rust: (self.table.permute(
    // rust: cell[0]
    // rust: + delta[0]
    // rust: + self
    // rust: .table
    // rust: .permute(cell[1] + delta[1] + self.table.permute(cell[2] + delta[2])),
    // rust: ) % 12) as usize
}
    // rust: let first = Self::corner(grad([0; 3]), point, 0.6);
    // rust: let second = Self::corner(
    // rust: grad(a),
    // rust: std::array::from_fn(|i| point[i] - f64::from(a[i]) + (1.0 / 6.0)),
    // rust: 0.6,
    // rust: );
    // rust: let third = Self::corner(
    // rust: grad(b),
    // rust: std::array::from_fn(|i| point[i] - f64::from(b[i]) + (1.0 / 3.0)),
    // rust: 0.6,
    // rust: );
    // rust: let fourth = Self::corner(grad([1; 3]), point.map(|v| v - 1.0 + 0.5), 0.6);
    // rust: (32.0 * (first + second + third + fourth)) as f32
}
}
