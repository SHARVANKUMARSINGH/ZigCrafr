//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_stitch
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Where a shader pack's block atlas puts each sprite: vanilla's `Stitcher`, so every sprite keeps
//! its own size and the atlas comes out as large as the game's (`atlasSize`). Holders are sorted
//! by height, then width, then (where vanilla compares names) sprite layer.

/// The atlas a set of sprites stitches into.
    // rust: pub(super) struct Stitched {
    // rust: pub width: u32,
    // rust: pub height: u32,
    /// Each sprite's padded holder: its top left corner. The sprite itself starts `padding` in.
    // rust: pub holders: Vec<[u32; 2]>,
    // rust: pub padding: u32,
}

/// `Stitcher.smallestFittingMinTexel`.
pub fn fit(input: u32, mip_level: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let step = 1 << mip_level;
    // rust: input.div_ceil(step) * step
}

/// `Mth.smallestEncompassingPowerOfTwo` (0 stays 0).
pub fn power_of_two(input: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if input == 0 {
    // rust: 0
    // rust: } else {
    // rust: input.next_power_of_two()
}
}

/// `Stitcher.Region`.
pub const Region = struct {
    x: u32,
    y: u32,
    width: u32,
    height: u32,
    holder: bool,
    sub: std.ArrayList(Region),
};

    // rust: impl Region {
pub fn new(x: u32, y: u32, width: u32, height: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: x,
    // rust: y,
    // rust: width,
    // rust: height,
    // rust: holder: false,
    // rust: sub: Vec::new(),
}
}

    /// `Region.add`: the holder's top left corner, when it fits.
pub fn add(self: *Self, h]: [u32; 2]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.holder || w > self.width || h > self.height {
    // rust: return None;
}
    // rust: if w == self.width && h == self.height {
    // rust: self.holder = true;
    // rust: return Some([self.x, self.y]);
}
    // rust: if self.sub.is_empty() {
    // rust: let (x, y) = (self.x, self.y);
    // rust: self.sub.push(Region::new(x, y, w, h));
    // rust: let (spare_w, spare_h) = (self.width - w, self.height - h);
    // rust: if spare_h > 0 && spare_w > 0 {
    // rust: let right = self.height.max(spare_w);
    // rust: let bottom = self.width.max(spare_h);
    // rust: if right >= bottom {
    // rust: self.sub.push(Region::new(x, y + h, w, spare_h));
    // rust: self.sub.push(Region::new(x + w, y, spare_w, self.height));
    // rust: } else {
    // rust: self.sub.push(Region::new(x + w, y, spare_w, h));
    // rust: self.sub.push(Region::new(x, y + h, self.width, spare_h));
}
    // rust: } else if spare_w == 0 {
    // rust: self.sub.push(Region::new(x, y + h, w, spare_h));
    // rust: } else if spare_h == 0 {
    // rust: self.sub.push(Region::new(x + w, y, spare_w, h));
}
}
    // rust: self.sub.iter_mut().find_map(|r| r.add([w, h]))
}
}

/// `Stitcher` over square sprites of `sides` pixels, with vanilla's padding for `mip_level` and
/// `anisotropy_bit`; `None` when they don't fit in `max` by `max`.
    // rust: pub(super) fn stitch(
    // rust: sides: &[u32],
    // rust: mip_level: u32,
    // rust: anisotropy_bit: u32,
    // rust: max: u32,
    // rust: ) -> Option<Stitched> {
    // rust: let padding = (1 << mip_level) << anisotropy_bit.saturating_sub(1).min(4);
    // rust: let mut order: Vec<usize> = (0..sides.len()).collect();
    // rust: let holder = |i: usize| fit(sides[i] + padding * 2, mip_level);
    // rust: order.sort_by_key(|&i| (std::cmp::Reverse(holder(i)), i));
    // rust: let (mut storage_x, mut storage_y) = (0u32, 0u32);
    // rust: let mut storage: Vec<Region> = Vec::new();
    // rust: let mut holders = vec![[0, 0]; sides.len()];
    // rust: for i in order {
    // rust: let size = [holder(i); 2];
    // rust: if let Some(at) = storage.iter_mut().find_map(|r| r.add(size)) {
    // rust: holders[i] = at;
    // rust: continue;
}
        // `Stitcher.expand`.
    // rust: let (x_now, y_now) = (power_of_two(storage_x), power_of_two(storage_y));
    // rust: let (x_new, y_new) = (
    // rust: power_of_two(storage_x + size[0]),
    // rust: power_of_two(storage_y + size[1]),
    // rust: );
    // rust: let (x_can, y_can) = (x_new <= max, y_new <= max);
    // rust: if !x_can && !y_can {
    // rust: return None;
}
    // rust: let (x_will, y_will) = (x_can && x_now != x_new, y_can && y_now != y_new);
    // rust: let grow_x = if x_will ^ y_will {
    // rust: x_will
    // rust: } else {
    // rust: x_can && x_now <= y_now
}
    // rust: let mut slot = if grow_x {
    // rust: if storage_y == 0 {
    // rust: storage_y = y_new;
}
    // rust: let slot = Region::new(storage_x, 0, x_new - storage_x, storage_y);
    // rust: storage_x = x_new;
    // rust: slot
    // rust: } else {
    // rust: let slot = Region::new(0, storage_y, storage_x, y_new - storage_y);
    // rust: storage_y = y_new;
    // rust: slot
}
    // rust: holders[i] = slot.add(size)?;
    // rust: storage.push(slot);
}
    // rust: Some(Stitched {
    // rust: width: storage_x,
    // rust: height: storage_y,
    // rust: holders,
    // rust: padding,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

    /// Five 16 px sprites with one pixel of padding (no mipmaps), worked through vanilla's
    /// `Stitcher` by hand: 18 px holders in a 64 by 64 atlas.
pub fn equal_sprites_follow_vanillas_regions() void {
}
    // rust: let stitched = stitch(&[16; 5], 0, 0, 1 << 14).unwrap();
    // rust: assert_eq!(
    // rust: (stitched.width, stitched.height, stitched.padding),
    // rust: (64, 64, 1)
    // rust: );
    // rust: assert_eq!(
    // rust: stitched.holders,
    // rust: [[0, 0], [32, 0], [0, 32], [18, 32], [36, 32]]
    // rust: );
}

    /// The largest sprite goes first; padding and holders round up to the mip step.
pub fn larger_sprites_go_first_and_holders_round_to_the_mip_step() void {
}
        // Mip level 2: 4 px padding, holders 24 (16 + 8) and 40 (32 + 8) px.
    // rust: let stitched = stitch(&[16, 32], 2, 0, 1 << 14).unwrap();
    // rust: assert_eq!(stitched.padding, 4);
    // rust: assert_eq!(stitched.holders[1], [0, 0]);
        // 40 px grows the atlas to 64 by 64; the 24 px holder fits below the first.
    // rust: assert_eq!((stitched.width, stitched.height), (64, 64));
    // rust: assert_eq!(stitched.holders[0], [0, 40]);
        // Anisotropy 16x (bit 4) multiplies the padding by 8.
    // rust: assert_eq!(stitch(&[16], 4, 4, 1 << 14).unwrap().padding, 128);
    // rust: assert_eq!(stitch(&[16; 2], 0, 0, 16), None);
}
}
