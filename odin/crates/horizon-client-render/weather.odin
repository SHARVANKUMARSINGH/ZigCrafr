//! Transpiled from Horizon Rust crate
package horizon_client_render_weather

import "core:fmt"
import "core:mem"
import "core:math"

// Rain and snow columns around the camera (`WeatherEffectRenderer`).
//
// Vanilla draws each column as one camera-facing quad whose texture
// coordinates run past 0..1 (`v` advances a quarter of the texture per block,
// so `rain.png` repeats every 4 blocks) and relies on a repeating sampler.
// The live renderer repeats UVs inside the atlas sprite in its shader, using
// cached coordinate-only [`Parameters`]. The reference [`tile`] path splits
// at whole repeats and remains available for CPU callers and parity probes.
// use horizon_core::random::{LegacyRandom, RandomSource};

// `WeatherEffectRenderer.ColumnInstance`.
Column :: struct {
    x: i32,
    z: i32,
    bottom_y: i32,
    top_y: i32,
    u_offset: f32,
    v_offset: f32,
    // Vanilla packed light (`LightCoordsUtil.pack`: block << 4 | sky << 20).
    light_coords: i32,
}

// One vertex of a column quad, in vanilla's emission order.
ColumnVertex :: struct {
    // Camera-relative position.
    pos: [f32,
    // Texture coordinates before wrapping (the sampler repeats).
    uv: [f32,
    // ARGB (`ARGB.white(alpha)`).
    color: u32,
    light_coords: i32,
}

// The random seed of a column (`extractRenderState`).
column_seed :: proc(x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (x.wrapping_mul(x)
    // rust: .wrapping_mul(3121)
    // rust: .wrapping_add(x.wrapping_mul(45_238_971)))
    // rust: ^ (z.wrapping_mul(z)
    // rust: .wrapping_mul(418_711)
    // rust: .wrapping_add(z.wrapping_mul(13761)))
}

// The column's random source, seeded as `random.setSeed(seed)`.
column_random :: proc(x: i32, z: i32) -> L {
    // Ported from Horizon
    return {}
}
    // rust: LegacyRandom::new(i64::from(column_seed(x, z)))
}

// Coordinate-only random values. Keep the snow bases as doubles: rounding them
// before adding the float drift changes vanilla's UVs at rounding boundaries.
Parameters :: struct {
    rain_speed: f32,
    rain_tick_offset: f32,
    snow_base: [f64,
    snow_drift: [f32,
}
    // rust: impl Parameters {
new :: proc(x: i32, z: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let rain_speed = 3.0 + column_random(x, z).next_float();
    // rust: let mut random = column_random(x, z);
    // rust: let u = random.next_double();
    // rust: let du = random.next_gaussian() as f32;
    // rust: let v = random.next_double();
    // rust: let dv = random.next_gaussian() as f32;
    // rust: Self {
    // rust: rain_speed,
    // rust: rain_tick_offset: (x
    // rust: .wrapping_mul(x)
    // rust: .wrapping_mul(3121)
    // rust: .wrapping_add(x.wrapping_mul(45_238_971))
    // rust: .wrapping_add(z.wrapping_mul(z).wrapping_mul(418_711))
    // rust: .wrapping_add(z.wrapping_mul(13761))
    // rust: & 255) as f32,
    // rust: snow_base: [u, v],
    // rust: snow_drift: [du, dv],
}
}

    // CPU reference for fixtures and GPU differential tests. The public random
    // source helpers below retain their original draw/advancement semantics.
    // rust: pub fn column(
    // rust: self,
    // rust: snow: bool,
    // rust: ticks: i64,
    // rust: x: i32,
    // rust: bottom_y: i32,
    // rust: top_y: i32,
    // rust: z: i32,
    // rust: light_coords: i32,
    // rust: partial: f32,
    // rust: ) -> Column {
    // rust: let time = (ticks & 131_071) as f32 + partial;
    // rust: let (u_offset, v_offset, light_coords) = if snow {
    // rust: let u = (self.snow_base[0] + f64::from(time * 0.01 * self.snow_drift[0])) as f32;
    // rust: let v = (self.snow_base[1] + f64::from(time * self.snow_drift[1] * 0.001)) as f32;
    // rust: let fall = -((ticks & 511) as f32 + partial) / 512.0;
    // rust: let (block, sky) = (light_coords >> 4 & 15, light_coords >> 20 & 15);
    // rust: (
    // rust: u,
    // rust: fall + v,
    // rust: ((block * 3 + 15) / 4) << 4 | ((sky * 3 + 15) / 4) << 20,
    // rust: )
    // rust: } else {
    // rust: let offset = -(((ticks & 131_071) as f32 + self.rain_tick_offset) + partial) / 32.0
    // rust: * self.rain_speed;
    // rust: (0.0, offset % 32.0, light_coords)
}
    // rust: Column {
    // rust: x,
    // rust: z,
    // rust: bottom_y,
    // rust: top_y,
    // rust: u_offset,
    // rust: v_offset,
    // rust: light_coords,
}
}
}

// Direct-mapped 32x32 cache: at most 1024 coordinate keys, including after
// teleports or radius changes. Full keys disambiguate collisions and wrapping.
// Nothing world-dependent is cached, so dimension/biome/pack changes need no
// invalidation; the caller still samples heights, precipitation and light.
ParameterCache :: struct {
    entries: Box<[Option<((i32,
}
    // rust: impl Default for ParameterCache {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: entries: vec![None; 32 * 32].into_boxed_slice(),
}
}
}
    // rust: impl ParameterCache {
get :: proc(self: ^Self, x: i32, z: i32) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let index = ((z as u32 & 31) * 32 + (x as u32 & 31)) as usize;
    // rust: let entry = &mut self.entries[index];
    // rust: if let Some((key, parameters)) = entry
    // rust: && *key == (x, z)
    // rust: {
    // rust: return *parameters;
}
    // rust: let parameters = Parameters::new(x, z);
    // rust: *entry = Some(((x, z), parameters));
    // rust: parameters
}
}

// One unsplit camera-relative weather vertex. UV animation and atlas-local
// repetition happen in the weather shader, rather than rebuilding tiled quads.
Vertex :: struct {
    pos: [f32,
    uv: [f32,
    rect: [f32,
    animation: [f32,
    bases: [u32,
    color: u32,
    light: u32,
    snow: u32,
}

// Current ticks are masked on the CPU before conversion to float, including
// negative/large tick values. Do not use the renderer's unbounded game_time.
Time :: struct {
    values: [f32,
}
    // rust: impl Time {
new :: proc(ticks: i64, partial: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: values: [(ticks & 131_071) as f32, (ticks & 511) as f32, partial, 0.0],
}
}
}

// Emit a single quad, retaining column_quad's position, fade, UV rounding and
// light semantics. The zero phase leaves the shader to animate both UV axes.
    // rust: pub fn vertices(
    // rust: column: &Column,
    // rust: parameters: Parameters,
    // rust: snow: bool,
    // rust: camera: [f64; 3],
    // rust: radius: i32,
    // rust: intensity: f32,
    // rust: rect: [f32; 4],
    // rust: ) -> [Vertex; 4] {
    // rust: let quad = column_quad(
    // rust: column,
    // rust: camera,
    // rust: if snow { 0.8 } else { 1.0 },
    // rust: radius,
    // rust: intensity,
    // rust: );
    // rust: let lc = column.light_coords;
    // rust: let light = ((lc >> 20 & 15) * 16) as u32 | (((lc >> 4 & 15) * 16) as u32) << 8;
    // rust: let [u, v] = parameters.snow_base.map(f64::to_bits);
    // rust: quad.map(|q| Vertex {
    // rust: pos: q.pos,
    // rust: uv: q.uv,
    // rust: rect,
    // rust: animation: [
    // rust: parameters.rain_speed,
    // rust: parameters.rain_tick_offset,
    // rust: parameters.snow_drift[0],
    // rust: parameters.snow_drift[1],
    // rust: ],
    // rust: bases: [u as u32, (u >> 32) as u32, v as u32, (v >> 32) as u32],
    // rust: color: q.color,
    // rust: light,
    // rust: snow: u32::from(snow),
    // rust: })
}

// `createRainColumnInstance`.
    // rust: pub fn rain_column(
    // rust: random: &mut impl RandomSource,
    // rust: ticks: i64,
    // rust: x: i32,
    // rust: bottom_y: i32,
    // rust: top_y: i32,
    // rust: z: i32,
    // rust: light_coords: i32,
    // rust: partial: f32,
    // rust: ) -> Column {
    // rust: let wrapped_ticks = (ticks & 131_071) as i32;
    // rust: let tick_offset = x
    // rust: .wrapping_mul(x)
    // rust: .wrapping_mul(3121)
    // rust: .wrapping_add(x.wrapping_mul(45_238_971))
    // rust: .wrapping_add(z.wrapping_mul(z).wrapping_mul(418_711))
    // rust: .wrapping_add(z.wrapping_mul(13761))
    // rust: & 0xFF;
    // rust: let speed = 3.0 + random.next_float();
    // rust: let offset = -((wrapped_ticks + tick_offset) as f32 + partial) / 32.0 * speed;
    // rust: Column {
    // rust: x,
    // rust: z,
    // rust: bottom_y,
    // rust: top_y,
    // rust: u_offset: 0.0,
    // rust: v_offset: offset % 32.0,
    // rust: light_coords,
}
}

// `createSnowColumnInstance`: snow drifts sideways and is brightened.
    // rust: pub fn snow_column(
    // rust: random: &mut impl RandomSource,
    // rust: ticks: i64,
    // rust: x: i32,
    // rust: bottom_y: i32,
    // rust: top_y: i32,
    // rust: z: i32,
    // rust: light_coords: i32,
    // rust: partial: f32,
    // rust: ) -> Column {
    // rust: let wrapped_ticks = (ticks & 131_071) as i32;
    // rust: let time = wrapped_ticks as f32 + partial;
    // rust: let u = random.next_double();
    // rust: let u = (u + f64::from(time * 0.01 * random.next_gaussian() as f32)) as f32;
    // rust: let v = random.next_double();
    // rust: let v = (v + f64::from(time * random.next_gaussian() as f32 * 0.001)) as f32;
    // rust: let v_offset = -((ticks & 511) as f32 + partial) / 512.0;
    // rust: let (block, sky) = (light_coords >> 4 & 15, light_coords >> 20 & 15);
    // rust: Column {
    // rust: x,
    // rust: z,
    // rust: bottom_y,
    // rust: top_y,
    // rust: u_offset: u,
    // rust: v_offset: v_offset + v,
    // rust: light_coords: ((block * 3 + 15) / 4) << 4 | ((sky * 3 + 15) / 4) << 20,
}
}

// The constructor's 32x32 table of horizontal column half-widths, indexed
// relative to the camera block. The camera's own column divides 0 by 0.
column_size :: proc(index: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: static SIZES: std::sync::LazyLock<[(f32, f32); 32 * 32]> = std::sync::LazyLock::new(|| {
    // rust: std::array::from_fn(|index| {
    // rust: let delta_x = (index % 32) as f32 - 16.0;
    // rust: let delta_z = (index / 32) as f32 - 16.0;
    // rust: let distance = f64::from(delta_x * delta_x + delta_z * delta_z).sqrt() as f32;
    // rust: (-delta_z / distance, delta_x / distance)
    // rust: })
    // rust: });
    // rust: SIZES[index]
}

// `prepareInstances` for one column: rain uses `max_alpha` 1, snow 0.8.
    // rust: pub fn column_quad(
    // rust: column: &Column,
    // rust: camera: [f64; 3],
    // rust: max_alpha: f32,
    // rust: radius: i32,
    // rust: intensity: f32,
    // rust: ) -> [ColumnVertex; 4] {
    // rust: let radius_sq = (radius * radius) as f32;
    // rust: let relative_x = (f64::from(column.x) + 0.5 - camera[0]) as f32;
    // rust: let relative_z = (f64::from(column.z) + 0.5 - camera[2]) as f32;
    // rust: let distance_sq = relative_x * relative_x + relative_z * relative_z;
    // rust: let t = (distance_sq / radius_sq).min(1.0);
    // rust: let alpha = (max_alpha + t * (0.5 - max_alpha)) * intensity;
    // rust: let color = ((alpha * 255.0).floor() as i32 as u32) << 24 | 0xFF_FFFF;
    // rust: let index = (column.z - camera[2].floor() as i32 + 16) * 32
    // rust: + (column.x - camera[0].floor() as i32 + 16);
    // rust: let (size_x, size_z) = column_size(index as usize);
    // rust: let (half_x, half_z) = (size_x / 2.0, size_z / 2.0);
    // rust: let (x0, x1) = (relative_x - half_x, relative_x + half_x);
    // rust: let y1 = (f64::from(column.top_y) - camera[1]) as f32;
    // rust: let y0 = (f64::from(column.bottom_y) - camera[1]) as f32;
    // rust: let (z0, z1) = (relative_z - half_z, relative_z + half_z);
    // rust: let (u0, u1) = (column.u_offset, column.u_offset + 1.0);
    // rust: let v0 = column.bottom_y as f32 * 0.25 + column.v_offset;
    // rust: let v1 = column.top_y as f32 * 0.25 + column.v_offset;
    // rust: let vertex = |pos, uv| ColumnVertex {
    // rust: pos,
    // rust: uv,
    // rust: color,
    // rust: light_coords: column.light_coords,
}
    // rust: [
    // rust: vertex([x0, y1, z0], [u0, v0]),
    // rust: vertex([x1, y1, z1], [u1, v0]),
    // rust: vertex([x1, y0, z1], [u1, v1]),
    // rust: vertex([x0, y0, z0], [u0, v1]),
    // rust: ]
}

// Split a column quad (vertices as [`column_quad`] emits them: top edge
// `u0..u1` at `v0`, bottom edge at `v1`) at every whole texture repeat.
// Each piece gets positions on the quad and texture coordinates in `0..=1`
// of one repeat, ready to map onto an atlas sprite.
tile :: proc(quad: ^[ColumnVertex; 4], mut emit: impl FnMut([[f32; 3]; 4]) {
}
    // rust: let [u0, v0] = quad[0].uv;
    // rust: let [u1, v1] = quad[2].uv;
    // rust: let (top_left, top_right) = (quad[0].pos, quad[1].pos);
    // rust: let (bottom_right, bottom_left) = (quad[2].pos, quad[3].pos);
    // rust: let lerp3 = |a: [f32; 3], b: [f32; 3], t: f32| -> [f32; 3] {
    // rust: std::array::from_fn(|i| a[i] + (b[i] - a[i]) * t)
}
    // Position at fraction s across (u) and t down (v) the quad.
    // rust: let at = |s: f32, t: f32| {
    // rust: lerp3(
    // rust: lerp3(top_left, top_right, s),
    // rust: lerp3(bottom_left, bottom_right, s),
    // rust: t,
    // rust: )
}
    // rust: if !(u1 > u0 && v1 > v0) {
    // rust: return;
}
    // rust: for (va, vb) in pieces(v0, v1) {
    // rust: let repeat_v = va.floor();
    // rust: let (ta, tb) = ((va - v0) / (v1 - v0), (vb - v0) / (v1 - v0));
    // rust: let (la, lb) = (va - repeat_v, vb - repeat_v);
    // rust: for (ua, ub) in pieces(u0, u1) {
    // rust: let repeat_u = ua.floor();
    // rust: let (sa, sb) = ((ua - u0) / (u1 - u0), (ub - u0) / (u1 - u0));
    // rust: let (ka, kb) = (ua - repeat_u, ub - repeat_u);
    // rust: emit(
    // rust: [at(sa, ta), at(sb, ta), at(sb, tb), at(sa, tb)],
    // rust: [[ka, la], [kb, la], [kb, lb], [ka, lb]],
    // rust: );
}
}
}

// `a..b` cut at every whole number in between, as consecutive pairs
// (without allocating: this runs for every column of every frame).
pieces :: proc(a: f32, b: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let first = a.floor() + 1.0;
    // rust: let cuts = move || {
    // rust: std::iter::once(a)
    // rust: .chain(
    // rust: (0..)
    // rust: .map(move |k| first + k as f32)
    // rust: .take_while(move |&k| k < b),
    // rust: )
    // rust: .chain(std::iter::once(b))
}
    // rust: cuts().zip(cuts().skip(1))
}

    // rust: mod tests {
//     use super::*;

column_size_table_matches_original_arithmetic :: proc() {
}
    // rust: for z in 0..32 {
    // rust: for x in 0..32 {
    // rust: let delta_x = x as f32 - 16.0;
    // rust: let delta_z = z as f32 - 16.0;
    // rust: let distance = f64::from(delta_x * delta_x + delta_z * delta_z).sqrt() as f32;
    // rust: let expected = [-delta_z / distance, delta_x / distance];
    // rust: let actual = column_size(z * 32 + x);
    // rust: for (actual, expected) in [actual.0, actual.1].into_iter().zip(expected) {
    // rust: if x == 16 && z == 16 {
    // rust: assert!(expected.is_nan());
    // rust: assert!(actual.is_nan());
    // rust: } else {
    // rust: assert_eq!(actual.to_bits(), expected.to_bits(), "column ({x}, {z})");
}
}
}
}
}

cached_parameters_match_original_random_draws :: proc() {
}
    // rust: let mut cache = ParameterCache::default();
    // rust: for i in 0..2048i32 {
    // rust: let x = i.wrapping_mul(45_238_971);
    // rust: let z = i.wrapping_mul(-418_711).wrapping_add(i32::MIN);
    // rust: for ticks in [i64::MIN, -1, 0, 511, 512, 131_071, 131_072, i64::MAX] {
    // rust: for partial in [0.0, 0.5, 0.999] {
    // rust: for snow in [false, true] {
    // rust: let mut random = column_random(x, z);
    // rust: let reference = if snow {
    // rust: snow_column(&mut random, ticks, x, -64, 320, z, 0xf000f0, partial)
    // rust: } else {
    // rust: rain_column(&mut random, ticks, x, -64, 320, z, 0xf000f0, partial)
}
    // rust: assert_eq!(
    // rust: cache
    // rust: .get(x, z)
    // rust: .column(snow, ticks, x, -64, 320, z, 0xf000f0, partial),
    // rust: reference
    // rust: );
}
}
}
}
}

parameter_cache_reuses_full_keys_and_stays_bounded :: proc() {
}
    // rust: let mut cache = ParameterCache::default();
    // rust: let expected = cache.get(-1, i32::MAX);
        // A changed entry proves that a hit does not regenerate random values.
    // rust: let index = 31 * 32 + 31;
    // rust: cache.entries[index].as_mut().unwrap().1.rain_speed = 123.0;
    // rust: assert_eq!(cache.get(-1, i32::MAX).rain_speed, 123.0);
        // Colliding positions must replace the entry, rather than reuse it.
    // rust: cache.get(31, -1);
    // rust: assert_eq!(cache.get(-1, i32::MAX).rain_speed, expected.rain_speed);
    // rust: for i in 0..100_000i32 {
    // rust: cache.get(i.wrapping_mul(3121), i.wrapping_mul(418_711));
}
    // rust: assert_eq!(cache.entries.len(), 1024);
    // rust: assert!(cache.entries.iter().flatten().count() <= 1024);
}

unsplit_vertices_keep_live_geometry_light_and_atlas_inputs :: proc() {
}
    // rust: let x = i32::MAX - 5;
    // rust: let z = i32::MIN + 5;
    // rust: let parameters = Parameters::new(x, z);
    // rust: let camera = [f64::from(x) - 2.25, 80.75, f64::from(z) + 0.25];
    // rust: for (bottom_y, top_y, light_coords, radius, intensity, rect) in [
    // rust: (64, 90, 0, 5, 0.25, [0.1, 0.2, 0.03, 0.04]),
    // rust: (85, 95, 0xf000f0, 10, 1.0, [0.5, 0.5, 0.1, 0.2]),
    // rust: ] {
    // rust: let column = Column {
    // rust: x,
    // rust: z,
    // rust: bottom_y,
    // rust: top_y,
    // rust: light_coords,
    // rust: u_offset: 0.0,
    // rust: v_offset: 0.0,
}
    // rust: let quad = column_quad(&column, camera, 1.0, radius, intensity);
    // rust: let vertices = vertices(&column, parameters, false, camera, radius, intensity, rect);
    // rust: for (a, b) in vertices.iter().zip(quad) {
    // rust: assert_eq!(a.pos, b.pos);
    // rust: assert_eq!(a.uv, b.uv);
    // rust: assert_eq!(a.color, b.color);
    // rust: assert_eq!(a.rect, rect);
    // rust: assert_eq!(a.light, if light_coords == 0 { 0 } else { 0xf0f0 });
}
}
}

rain_repeats_every_four_blocks :: proc() {
}
    // rust: let column = Column {
    // rust: x: 3,
    // rust: z: 0,
    // rust: bottom_y: 60,
    // rust: top_y: 80,
    // rust: u_offset: 0.0,
    // rust: v_offset: 0.0,
    // rust: light_coords: 15 << 20,
}
    // rust: let quad = column_quad(&column, [0.5, 70.0, 0.5], 1.0, 10, 1.0);
        // 20 blocks of rain: five repeats of the texture, split at each seam.
    // rust: let mut pieces = Vec::new();
    // rust: tile(&quad, |pos, uv| pieces.push((pos, uv)));
    // rust: assert_eq!(pieces.len(), 5);
    // rust: for (pos, uv) in &pieces {
    // rust: assert!(((pos[0][1] - pos[3][1]) - 4.0).abs() < 1e-4);
    // rust: assert_eq!(uv[0], [0.0, 0.0]);
    // rust: assert_eq!(uv[2], [1.0, 1.0]);
}
}

snow_drifts_across_one_seam :: proc() {
}
    // rust: let column = Column {
    // rust: x: 3,
    // rust: z: 2,
    // rust: bottom_y: 64,
    // rust: top_y: 66,
    // rust: u_offset: 0.25,
    // rust: v_offset: 0.0,
    // rust: light_coords: 0,
}
    // rust: let quad = column_quad(&column, [0.5, 70.0, 0.5], 0.8, 10, 1.0);
    // rust: let mut pieces = Vec::new();
    // rust: tile(&quad, |pos, uv| pieces.push((pos, uv)));
    // rust: assert_eq!(pieces.len(), 2);
    // rust: assert_eq!(pieces[0].1[0], [0.25, 0.0]);
    // rust: assert_eq!(pieces[1].1[2], [0.25, 0.5]);
}

pieces_cut_at_whole_numbers :: proc() {
}
    // rust: let all = |a, b| pieces(a, b).collect::<Vec<_>>();
    // rust: assert_eq!(all(0.25, 2.5), [(0.25, 1.0), (1.0, 2.0), (2.0, 2.5)]);
    // rust: assert_eq!(all(1.0, 2.0), [(1.0, 2.0)]);
    // rust: assert_eq!(all(-0.5, 0.5), [(-0.5, 0.0), (0.0, 0.5)]);
    // rust: assert_eq!(all(3.25, 3.75), [(3.25, 3.75)]);
}

camera_column_is_degenerate :: proc() {
}
    // rust: let column = Column {
    // rust: x: 0,
    // rust: z: 0,
    // rust: bottom_y: 60,
    // rust: top_y: 80,
    // rust: u_offset: 0.0,
    // rust: v_offset: 0.0,
    // rust: light_coords: 0,
}
    // rust: let quad = column_quad(&column, [0.5, 70.0, 0.5], 1.0, 10, 1.0);
    // rust: for vertex in quad {
    // rust: assert!(vertex.pos[0].is_nan());
    // rust: assert!(vertex.pos[2].is_nan());
    // rust: assert!(vertex.pos[1].is_finite());
}
}
}
