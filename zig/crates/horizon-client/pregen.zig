//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pregen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pregeneration (`/pregen`): every chunk of a square or a circle generated,
//! lit and saved ahead of the players. The area is cut into strips of columns
//! and each strip is swept north to south by a [`Band`] a few rows deep:
//! streaming generates the band's chunks and keeps them until they are lit,
//! then the band moves on and the rows behind it unload and are saved, so
//! memory stays bounded whatever the radius.
// use crate::streaming::Band;

/// The opt-in command's report-format tree, beside vanilla's exported report.
/// The server sends this to clients so they can complete the command too.
pub fn command_tree() s {
    // Implementation ported from Horizon
    return undefined;
}
//     use serde_json::json;
    // rust: let center = json!({"type": "argument", "parser": "minecraft:vec2", "executable": true});
    // rust: let shape = json!({"type": "literal", "executable": true, "children": {"center": center}});
    // rust: let mut children = serde_json::Map::new();
    // rust: children.insert(
    // rust: "start".into(),
    // rust: json!({
    // rust: "type": "literal", "children": {"radius": {
    // rust: "type": "argument", "parser": "brigadier:integer",
    // rust: "properties": {"min": 0, "max": 30_000_000}, "executable": true,
    // rust: "children": {"square": shape, "circle": shape}
    // rust: }}
    // rust: }),
    // rust: );
    // rust: for name in ["status", "pause", "continue", "cancel"] {
    // rust: children.insert(name.into(), json!({"type": "literal", "executable": true}));
}
    // rust: json!({"type": "root", "children": {"pregen": {
    // rust: "type": "literal",
    // rust: "permissions": {"type": "require", "permission": {"level": "gamemasters"}},
    // rust: "children": children
    // rust: }}})
}

pub const Shape = enum {
    Square,
    Circle,
};

/// The widest strip, in chunks. Strips are swept one after another; the few
/// columns along the edge between two are generated with both.
pub const STRIP_WIDTH: i32 = 256;
/// How many chunks a band holds at least: enough to keep every worker busy
/// while the rows before it finish.
pub const BAND_CHUNKS: i32 = 1024;

pub const Pregen = struct {
    /// The centre chunk and the radius in chunks.
    center: (i32,
    radius: i32,
    shape: Shape,
    /// The strips' columns, west to east.
    strips: Vec<(i32,
    strip: usize,
    /// The band's first row: every row of the strip before it is done.
    row: i32,
    /// Chunks of the area lit so far, and in all.
    done: u64,
    total: u64,
};

    // rust: impl Pregen {
pub fn new(center: (i32) void {
}
    // rust: let radius = radius.max(0);
    // rust: let (x0, width) = (center.0 - radius, 2 * radius + 1);
    // rust: let count = (width + STRIP_WIDTH - 1) / STRIP_WIDTH;
        // The columns `i * width / count` on, in i64: the product overflows
        // for a radius of a few hundred thousand chunks.
    // rust: let edge = |i: i32| x0 + (i64::from(width) * i64::from(i) / i64::from(count)) as i32;
    // rust: let strips = (0..count).map(|i| (edge(i), edge(i + 1) - 1)).collect();
    // rust: let mut pregen = Self {
    // rust: center,
    // rust: radius,
    // rust: shape,
    // rust: strips,
    // rust: strip: 0,
    // rust: row: 0,
    // rust: done: 0,
    // rust: total: 0,
}
    // rust: pregen.total = (center.1 - radius..=center.1 + radius)
    // rust: .map(|z| pregen.row_chunks(x0, x0 + width - 1, z))
    // rust: .sum();
    // rust: pregen.row = pregen.rows().map_or(0, |r| r.0);
    // rust: pregen
}

    /// How far from the centre column the area reaches at `d` chunks from
    /// the centre row (or, the same, from the centre column), if it does.
pub fn half_width(self: *Self, d: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (r, d) = (i64::from(self.radius), i64::from(d));
    // rust: match self.shape {
    // rust: Shape::Square => (d.abs() <= r).then_some(self.radius),
    // rust: Shape::Circle => (d * d <= r * r).then(|| (r * r - d * d).isqrt() as i32),
}
}

pub fn contains(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.half_width(z - self.center.1)
    // rust: .is_some_and(|h| (x - self.center.0).abs() <= h)
}

    /// The area's chunks in columns `x0..=x1` of row `z`.
pub fn row_chunks(self: *Self, x0: i32, x1: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.half_width(z - self.center.1).map_or(0, |h| {
    // rust: let (lo, hi) = (x0.max(self.center.0 - h), x1.min(self.center.0 + h));
    // rust: (i64::from(hi) - i64::from(lo) + 1).max(0) as u64
    // rust: })
}

    /// The first and last rows of the current strip that hold chunks of the
    /// area.
pub fn rows(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let &(x0, x1) = self.strips.get(self.strip)?;
    // rust: let nearest = (x0 - self.center.0).max(self.center.0 - x1).max(0);
    // rust: let h = self.half_width(nearest)?;
    // rust: Some((self.center.1 - h, self.center.1 + h))
}

    /// The band streaming should hold now; none once every strip is done.
pub fn band(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let &(x0, x1) = self.strips.get(self.strip)?;
    // rust: let (_, last) = self.rows()?;
    // rust: let rows = (BAND_CHUNKS + (x1 - x0)) / (x1 - x0 + 1);
    // rust: Some(Band {
    // rust: x0,
    // rust: x1,
    // rust: z0: self.row,
    // rust: z1: (self.row + rows - 1).min(last),
    // rust: circle: (self.shape == Shape::Circle).then_some((self.center, self.radius)),
    // rust: })
}

    /// Move past the band's first rows once all their chunks are `lit`.
    /// Returns whether the band moved.
pub fn advance(self: *Self, lit: impl Fn(i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut moved = false;
    // rust: while let (Some(&(x0, x1)), Some((_, last))) = (self.strips.get(self.strip), self.rows()) {
    // rust: let z = self.row;
    // rust: if !(x0..=x1).all(|x| !self.contains(x, z) || lit(x, z)) {
    // rust: break;
}
    // rust: self.done += self.row_chunks(x0, x1, z);
    // rust: self.row += 1;
    // rust: if self.row > last {
    // rust: self.strip += 1;
    // rust: self.row = self.rows().map_or(self.row, |r| r.0);
}
    // rust: moved = true;
}
    // rust: moved
}

    /// The chunks of the band's first row, which it waits for.
pub fn first_row(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(&(x0, x1)) = self.strips.get(self.strip) else {
    // rust: return Vec::new();
}
    // rust: (x0..=x1)
    // rust: .filter(|&x| self.contains(x, self.row))
    // rust: .map(|x| (x, self.row))
    // rust: .collect()
}

pub fn finished(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.strip >= self.strips.len()
}
}

    // rust: mod tests {
//     use super::*;

pub fn sweeps_every_chunk_of_the_area_once() void {
}
    // rust: for shape in [Shape::Square, Shape::Circle] {
    // rust: for (center, radius) in [((0, 0), 0), ((3, -7), 5), ((-40, 12), 130), ((0, 0), 300)] {
    // rust: let mut p = Pregen::new(center, radius, shape);
    // rust: let r = i64::from(radius);
    // rust: let area = (-radius..=radius)
    // rust: .flat_map(|dz| (-radius..=radius).map(move |dx| (dx, dz)))
    // rust: .filter(|&(dx, dz)| {
    // rust: shape == Shape::Square
    // rust: || i64::from(dx).pow(2) + i64::from(dz).pow(2) <= r * r
    // rust: })
    // rust: .count() as u64;
    // rust: assert_eq!(p.total, area, "{shape:?} {radius}");
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: while !p.finished() {
    // rust: let band = p.band().unwrap();
    // rust: assert!(band.z0 <= band.z1);
    // rust: let row = p.first_row();
    // rust: for &(x, z) in &row {
    // rust: assert!(seen.insert((x, z)), "{x} {z} twice");
}
    // rust: assert!(
    // rust: p.advance(|x, z| z == band.z0 && row.contains(&(x, z))) || row.is_empty()
    // rust: );
}
    // rust: assert_eq!(
    // rust: (p.done, seen.len() as u64),
    // rust: (area, area),
    // rust: "{shape:?} {radius}"
    // rust: );
}
}
}

pub fn a_huge_area_is_planned_at_once() void {
}
    // rust: let started = std::time::Instant::now();
    // rust: let p = Pregen::new((0, 0), 30_000_000 >> 4, Shape::Circle);
    // rust: assert!(p.total > 11_000_000_000_000);
    // rust: assert!(started.elapsed() < std::time::Duration::from_secs(5));
}
}
