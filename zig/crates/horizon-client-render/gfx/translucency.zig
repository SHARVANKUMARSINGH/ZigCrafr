//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_translucency
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla 26.3 MeshData.SortState / VertexSorting.byDistance.
//! Keep vertex order intact; only the quad indices change as the camera moves.

/// MeshData.decodeQuadCentroids uses the opposite corners, not all four vertices.
pub fn quad_center(a: [f32; 3], b: [f32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|i| (a[i] + b[i]) / 2.0)
}

pub const Sorter = struct {
    order: Vec<(u32,
    indices: std.ArrayList(u32),
};

    // rust: impl Sorter {
pub fn sort(self: *Self, centers: *[[f32; 3]], camera: [f32; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.order.clear();
    // rust: self.order.extend(centers.iter().enumerate().map(|(i, c)| {
    // rust: let [x, y, z] = std::array::from_fn(|j| camera[j] - c[j]);
    // rust: (i as u32, x * x + y * y + z * z)
    // rust: }));
        // VertexSorting uses a stable merge sort, preserving mesh order for ties.
    // rust: self.order.sort_by(|a, b| b.1.total_cmp(&a.1));
    // rust: self.indices.clear();
    // rust: for &(quad, _) in &self.order {
    // rust: let v = quad * 4;
    // rust: self.indices.extend([v, v + 1, v + 2, v + 2, v + 3, v]);
}
    // rust: &self.indices
}
}

pub const SortState = struct {
    centers: Vec<[f32,
    last: Option<([i32,
};

    // rust: impl SortState {
pub fn new(centers: std.ArrayList([f32; 3])) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: centers,
    // rust: last: None,
}
}

pub fn is_sorted(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.last.is_some()
}

    /// Large tiles cannot use the section viewpoint shortcut: the camera may
    /// cross a quad's plane while remaining on the same side of the first 16³.
    // rust: pub fn update_lod<'a>(
    // rust: &mut self,
    // rust: camera: [f64; 3],
    // rust: origin: [i32; 3],
    // rust: sorter: &'a mut Sorter,
    // rust: ) -> Option<&'a [u32]> {
    // rust: let block = camera.map(|v| v.floor() as i32);
    // rust: if self.last.is_some_and(|(last, _)| last == block) {
    // rust: return None;
}
    // rust: self.last = Some((block, [0; 3]));
    // rust: Some(sorter.sort(
    // rust: &self.centers,
    // rust: std::array::from_fn(|i| (camera[i] - f64::from(origin[i])) as f32),
    // rust: ))
}

    /// TranslucencyPointOfView and ResortTransparencyTask: diagonal views keep
    /// their ordering until the point of view changes; aligned views also
    /// resort on crossing a block boundary. Sub-block movement needs no upload.
    // rust: pub fn update<'a>(
    // rust: &mut self,
    // rust: camera: [f64; 3],
    // rust: origin: [i32; 3],
    // rust: sorter: &'a mut Sorter,
    // rust: ) -> Option<&'a [u32]> {
    // rust: let block = camera.map(|v| v.floor() as i32);
    // rust: let pov = std::array::from_fn(|i| ((block[i] >> 4) - (origin[i] >> 4)).clamp(-1, 1));
    // rust: if let Some((last_block, last_pov)) = self.last
    // rust: && last_pov == pov
    // rust: && (last_block == block || !pov.contains(&0))
    // rust: {
    // rust: return None;
}
    // rust: self.last = Some((block, pov));
    // rust: Some(sorter.sort(
    // rust: &self.centers,
    // rust: std::array::from_fn(|i| (camera[i] - f64::from(origin[i])) as f32),
    // rust: ))
}
}

    // rust: mod tests {
//     use super::*;

pub fn equal_distances_keep_mesh_order_and_triangle_winding() void {
}
    // rust: let mut sorter = Sorter::default();
    // rust: assert_eq!(
    // rust: sorter.sort(
    // rust: &[[1.0, 0.0, 0.0], [-1.0, 0.0, 0.0], [4.0, 0.0, 0.0]],
    // rust: [0.0; 3]
    // rust: ),
    // rust: &[8, 9, 10, 10, 11, 8, 0, 1, 2, 2, 3, 0, 4, 5, 6, 6, 7, 4]
    // rust: );
    // rust: assert!(sorter.sort(&[], [0.0; 3]).is_empty());
}

pub fn movement_reverses_faces_without_moving_vertices() void {
}
    // rust: let centers = [[0.5, 0.5, 0.0], [0.5, 0.5, 1.0]];
    // rust: let mut sorter = Sorter::default();
    // rust: assert_eq!(sorter.sort(&centers, [0.5, 0.5, -2.0])[0], 4);
    // rust: assert_eq!(sorter.sort(&centers, [0.5, 0.5, 3.0])[0], 0);
}

pub fn cached_viewpoint_handles_negative_and_large_coordinates() void {
}
    // rust: let origin = [-30_000_000, -64, 30_000_000];
    // rust: let mut state = SortState::new(vec![[0.5; 3]]);
    // rust: let mut sorter = Sorter::default();
    // rust: let camera = [-29_999_999.5, -63.5, 30_000_000.5];
    // rust: assert!(state.update(camera, origin, &mut sorter).is_some());
    // rust: assert!(state.update(camera, origin, &mut sorter).is_none());
    // rust: assert!(
    // rust: state
    // rust: .update([-29_999_999.1, -63.1, 30_000_000.9], origin, &mut sorter)
    // rust: .is_none()
    // rust: );
    // rust: assert!(
    // rust: state
    // rust: .update([-29_999_998.9, -63.1, 30_000_000.9], origin, &mut sorter)
    // rust: .is_some()
    // rust: );
}
pub fn large_tiles_resort_inside_the_same_section_viewpoint() void {
}
    // rust: let mut state = SortState::new(vec![[32.0, 0.0, 0.0], [96.0, 0.0, 0.0]]);
    // rust: let mut sorter = Sorter::default();
    // rust: assert_eq!(
    // rust: state
    // rust: .update_lod([48.0, 20.0, 20.0], [0; 3], &mut sorter)
    // rust: .unwrap()[0],
    // rust: 4
    // rust: );
    // rust: assert!(
    // rust: state
    // rust: .update_lod([48.5, 20.0, 20.0], [0; 3], &mut sorter)
    // rust: .is_none()
    // rust: );
        // Both views have positive x/y/z signs relative to the first section,
        // so the section-sized shortcut would incorrectly keep the old order.
    // rust: assert_eq!(
    // rust: state
    // rust: .update_lod([80.0, 20.0, 20.0], [0; 3], &mut sorter)
    // rust: .unwrap()[0],
    // rust: 0
    // rust: );
}
}
