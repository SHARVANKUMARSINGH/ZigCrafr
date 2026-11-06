//! Transpiled from Horizon Rust crate
package horizon_client_render_sunrise_fan

import "core:fmt"
import "core:mem"
import "core:math"

// The sunrise/sunset fan (`SkyRenderer.renderSunriseAndSunset`) as the sky
// shader tests it. The fan's 16 triangles depend only on the sunrise alpha
// and the horizon the sun is on, so their vertices are built here once a
// frame instead of in every sky pixel (#3143: with the per-pixel build, four
// `sin`/`cos` per triangle, the sky pass took 10.2 ms at dawn at 1080p on an
// Intel UHD 730 against 0.6 ms by day; now 1.8 ms).
//
// Möller-Trumbore from the camera reduces to triple products: with apex A
// and rim vertices r0, r1, a ray d hits at barycentrics proportional to
// (`[d, r0, r1]`, `[A, d, r1]`, `[A, r0, d]`), each a dot of d with a
// constant normal, and their sum S is the negated determinant. A hit needs
// S on the side of `[A, r0, r1]`, so only the triangles whose rim normals'
// dots change sign there are tested in full.
// use glam::Vec3;

TRIANGLES :: 16

// One vertex per triangle corner, each as `(position, weight)`: the apex
// weighs 1, the rim 0, so the rasterizer interpolates the barycentric apex
// weight the shader used to compute per pixel.
VERTICES :: TRIANGLES * 3

// Per triangle: xyz `r0 × r1` (its dot with a ray is the apex's weight
// times S), w `[A, r0, r1]` (its sign is S's where the hit lies ahead).
// Then per rim vertex: xyz `r × A`.
normals :: proc(alpha: f32, sun: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let (apex, rim) = vertices(alpha, sun);
    // rust: let mut out = [[0.0; 4]; 2 * TRIANGLES];
    // rust: for i in 0..TRIANGLES {
    // rust: let (r0, r1) = (rim[i], rim[(i + 1) % TRIANGLES]);
    // rust: out[i] = r0.cross(r1).extend(apex.dot(r0.cross(r1))).to_array();
    // rust: out[TRIANGLES + i] = r0.cross(apex).extend(0.0).to_array();
}
    // rust: out
}

// The fan as triangle-list vertices in camera space, with the apex at
// weight 1 and each rim vertex at 0 (`VERTICES`).
mesh :: proc(alpha: f32, sun: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let (apex, rim) = vertices(alpha, sun);
    // rust: let mut out = [[0.0; 4]; VERTICES];
    // rust: for i in 0..TRIANGLES {
    // rust: out[i * 3] = apex.extend(1.0).to_array();
    // rust: out[i * 3 + 1] = rim[i].extend(0.0).to_array();
    // rust: out[i * 3 + 2] = rim[(i + 1) % TRIANGLES].extend(0.0).to_array();
}
    // rust: out
}

// The fan's apex and rim in camera space, as vanilla builds them: the
// fan turned to the horizon the sun sets on (or rises from), its rim
// tilted by the alpha.
vertices :: proc(alpha: f32, sun: Vec3) -> ( {
    // Ported from Horizon
    return {}
}
    // sin(sunAngle) < 0 flips the fan to the other horizon; sun.z = -sin(sunAngle).
    // rust: let flip = if -sun.z < 0.0 { 180f32 } else { 0.0 };
    // rust: let (s, c) = (flip + 90.0).to_radians().sin_cos();
    // rust: let rotate_x90 = |v: Vec3| Vec3::new(v.x, -v.z, v.y);
    // rust: let apex = rotate_x90(Vec3::new(-100.0 * s, 100.0 * c, 0.0));
    // rust: let rim = std::array::from_fn(|i| {
    // rust: let a = i as f32 * std::f32::consts::TAU / TRIANGLES as f32;
    // rust: let l = Vec3::new(a.sin() * 120.0, a.cos() * 120.0, -a.cos() * 40.0 * alpha);
    // rust: rotate_x90(Vec3::new(l.x * c - l.y * s, l.x * s + l.y * c, l.z))
    // rust: });
    // rust: (apex, rim)
}

    // rust: mod tests {
//     use super::*;

    // terrain.wgsl's `sunrise_weight` over the normals.
weight :: proc(normals: ^[[f32; 4]; 2 * TRIANGLES], d: Vec3) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let n = |i: usize| Vec3::from_slice(&normals[i][..3]);
    // rust: let mut best = 0.0f32;
    // rust: let mut k0 = d.dot(n(TRIANGLES));
    // rust: for (i, triangle) in normals.iter().take(TRIANGLES).enumerate() {
    // rust: let k1 = d.dot(n(TRIANGLES + (i + 1) % TRIANGLES));
    // rust: let w = triangle[3];
    // rust: if k0 * w <= 0.0 && k1 * w >= 0.0 {
    // rust: let apex = d.dot(n(i));
    // rust: let s = apex + k1 - k0;
    // rust: if s.abs() >= 1e-6
    // rust: && s * w > 0.0
    // rust: && apex * s >= 0.0
    // rust: && k1 * s >= 0.0
    // rust: && k0 * s <= 0.0
    // rust: {
    // rust: best = best.max(apex / s);
}
}
    // rust: k0 = k1;
}
    // rust: best
}

    // Projecting the fan onto the YZ plane leaves uniformly spaced rim
    // angles after undoing its Y squash. Test both ray directions because
    // the projection plane goes through the camera.
sector_weight :: proc(alpha: f32, sun: Vec3, d: Vec3) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let normals = normals(alpha, sun);
    // rust: if d.y * d.y + d.z * d.z < 1e-10 {
    // rust: return weight(&normals, d);
}
    // rust: let n = |i: usize| Vec3::from_slice(&normals[i][..3]);
    // rust: let apex = d.dot(n(0));
    // rust: if apex * normals[0][3] < -1e-4 {
    // rust: return 0.0;
}
    // rust: let y = d.dot(n(16));
    // rust: let x = -d.dot(n(20));
    // rust: let ax = x.abs();
    // rust: let ay = y.abs();
    // rust: let t = std::f32::consts::SQRT_2 - 1.0;
    // rust: let q = if ay > ax {
    // rust: if ax < ay * t { 3 } else { 2 }
    // rust: } else if ay > ax * t {
    // rust: 1
    // rust: } else {
    // rust: 0
}
    // rust: let sector = if x >= 0.0 {
    // rust: if y >= 0.0 { q } else { 15 - q }
    // rust: } else if y >= 0.0 {
    // rust: 7 - q
    // rust: } else {
    // rust: 8 + q
}
    // rust: let mut best = 0.0f32;
    // rust: let k0 = d.dot(n(16 + sector as usize));
    // rust: let k1 = d.dot(n(16 + ((sector + 1) % 16) as usize));
    // rust: let offsets: &[i32] = if k0.abs().min(k1.abs()) < ax.max(ay) * 0.001 {
    // rust: &[0, 8, -1, 1, 7, 9]
    // rust: } else {
    // rust: &[0, 8]
}
    // rust: for &offset in offsets {
    // rust: let i = (sector + offset).rem_euclid(16) as usize;
    // rust: let k0 = d.dot(n(16 + i));
    // rust: let k1 = d.dot(n(16 + (i + 1) % 16));
    // rust: let w = normals[i][3];
    // rust: let apex = d.dot(n(i));
    // rust: let sum = apex + k1 - k0;
    // rust: if sum.abs() >= 1e-6
    // rust: && sum * w > 0.0
    // rust: && apex * sum >= 0.0
    // rust: && k1 * sum >= 0.0
    // rust: && k0 * sum <= 0.0
    // rust: {
    // rust: best = best.max(apex / sum);
}
}
    // rust: best
}
angular_sector_matches_random_and_exact_rim_directions :: proc() {
}
    // rust: let mut state = 19u32;
    // rust: let mut random = || {
    // rust: state = state.wrapping_mul(1664525).wrapping_add(1013904223);
    // rust: (state >> 8) as f32 / 16777216.0
}
    // rust: for _ in 0..1000 {
    // rust: let alpha = 0.0011 + random() * 0.9989;
    // rust: let z = if random() > 0.5 { 0.3 } else { -0.2 };
    // rust: let sun = Vec3::new(0.0, (1.0f32 - z * z).sqrt(), z);
    // rust: let normals = normals(alpha, sun);
    // rust: let (_, rim) = vertices(alpha, sun);
    // rust: let random_ray = Vec3::new(
    // rust: random() * 2.0 - 1.0,
    // rust: random() * 2.0 - 1.0,
    // rust: random() * 2.0 - 1.0,
    // rust: )
    // rust: .normalize();
    // rust: for ray in rim.into_iter().chain([random_ray]) {
    // rust: let d = ray.normalize();
    // rust: let (got, want) = (sector_weight(alpha, sun, d), weight(&normals, d));
    // rust: assert!(
    // rust: (got - want).abs() < 1e-4,
    // rust: "{alpha} {sun} {d}: {got} != {want}"
    // rust: );
}
}
}

angular_sector_matches_all_triangle_search :: proc() {
}
    // rust: for alpha in [0.0011f32, 0.05, 0.6, 1.0] {
    // rust: for z in [-0.2f32, 0.3] {
    // rust: let sun = Vec3::new(0.0, (1.0 - z * z).sqrt(), z);
    // rust: let normals = normals(alpha, sun);
    // rust: for yaw in 0..360 {
    // rust: for pitch in -89..90 {
    // rust: let (y, p) = ((yaw as f32).to_radians(), (pitch as f32).to_radians());
    // rust: let d = Vec3::new(y.cos() * p.cos(), p.sin(), y.sin() * p.cos());
    // rust: let (got, want) = (sector_weight(alpha, sun, d), weight(&normals, d));
    // rust: assert!(
    // rust: (got - want).abs() < 1e-4,
    // rust: "alpha={alpha} z={z} d={d} {got} != {want}"
    // rust: );
}
}
}
}
}

    // The shader's former per-pixel Möller-Trumbore over the same vertices.
reference :: proc(alpha: f32, sun: Vec3, d: Vec3) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (apex, rim) = vertices(alpha, sun);
    // rust: let mut best = 0.0f32;
    // rust: for i in 0..TRIANGLES {
    // rust: let e1 = rim[i] - apex;
    // rust: let e2 = rim[(i + 1) % TRIANGLES] - apex;
    // rust: let pv = d.cross(e2);
    // rust: let det = e1.dot(pv);
    // rust: if det.abs() < 1e-6 {
    // rust: continue;
}
    // rust: let tv = -apex;
    // rust: let u = tv.dot(pv) / det;
    // rust: let qv = tv.cross(e1);
    // rust: let v = d.dot(qv) / det;
    // rust: let t = e2.dot(qv) / det;
    // rust: if u >= 0.0 && v >= 0.0 && u + v <= 1.0 && t > 0.0 {
    // rust: best = best.max(1.0 - u - v);
}
}
    // rust: best
}

mesh_puts_the_apex_weight_on_the_apex_of_every_triangle :: proc() {
}
    // rust: let (apex, rim) = vertices(0.7, Vec3::new(0.0, 0.6, -0.8));
    // rust: let mesh = mesh(0.7, Vec3::new(0.0, 0.6, -0.8));
    // rust: assert_eq!(mesh.len(), VERTICES);
    // rust: for i in 0..TRIANGLES {
    // rust: assert_eq!(&mesh[i * 3][..3], apex.to_array());
    // rust: assert_eq!(mesh[i * 3][3], 1.0);
    // rust: assert_eq!(&mesh[i * 3 + 1][..3], rim[i].to_array());
    // rust: assert_eq!(mesh[i * 3 + 1][3], 0.0);
    // rust: assert_eq!(&mesh[i * 3 + 2][..3], rim[(i + 1) % TRIANGLES].to_array());
    // rust: assert_eq!(mesh[i * 3 + 2][3], 0.0);
}
}

normals_weigh_every_ray_as_the_per_pixel_fan_did :: proc() {
}
    // rust: let mut hits = 0;
    // rust: for (alpha, sun_z) in [(1.0f32, -0.2f32), (0.6, 0.3), (0.05, -0.9), (0.9, 0.05)] {
    // rust: let sun = Vec3::new(0.0, (1.0 - sun_z * sun_z).sqrt(), sun_z);
    // rust: let normals = normals(alpha, sun);
    // rust: for yaw in 0..180 {
    // rust: for pitch in -45..=45 {
    // rust: let (yaw, pitch) = (
    // rust: (yaw as f32 * 2.0).to_radians(),
    // rust: (pitch as f32 * 2.0).to_radians(),
    // rust: );
    // rust: let d = Vec3::new(
    // rust: yaw.cos() * pitch.cos(),
    // rust: pitch.sin(),
    // rust: yaw.sin() * pitch.cos(),
    // rust: );
    // rust: let (got, want) = (weight(&normals, d), reference(alpha, sun, d));
    // rust: assert!(
    // rust: (got - want).abs() < 1e-4,
    // rust: "{alpha} {sun_z} {d}: {got} vs {want}"
    // rust: );
    // rust: hits += usize::from(want > 0.0);
}
}
}
        // The fan covers part of the sky, not none of it.
    // rust: assert!(hits > 1000, "{hits}");
}
}
