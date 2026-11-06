//! Transpiled from Horizon Rust crate
package horizon_client_model_layers

import "core:fmt"
import "core:mem"
import "core:math"

// Entity model layers built in code, as vanilla's
// `net.minecraft.client.model.geom.builders` build them: a mod's
// `createBodyLayer()` (a [`MeshDefinition`] of named parts, each a
// [`CubeListBuilder`]'s boxes at a [`PartPose`], made a [`LayerDefinition`]
// with its texture's size) bakes into a [`ModelPart`] tree
// (`LayerDefinition.bakeRoot`). A mod turns its parts each frame, as
// `setupAnim` does, and draws it with `native_draw_model_part`
// (`ModelPart.render`). Mods register their layers by id
// (`native_layer_definitions`, NeoForge's
// `EntityRenderersEvent.RegisterLayerDefinitions`), and `native_bake_layer`
// bakes one of them or a vanilla layer (`EntityModelSet.bakeLayer`).

// use super::Part;
// use horizon_core::geometry::Direction;
// use std::{collections::HashMap, sync::OnceLock};

// `CubeDeformation`: how far a box grows past its size on each side, in
// texels, with its texture unchanged: a hat or an armour layer over a head.
CubeDeformation :: struct {
    grow_x: f32,
    grow_y: f32,
    grow_z: f32,
}

    // rust: impl CubeDeformation {
NONE :: Self::xyz(0.0, 0.0, 0.0)

    // The same growth on every axis (`new CubeDeformation(grow)`).
    // rust: pub const fn new(grow: f32) -> Self {
    // rust: Self::xyz(grow, grow, grow)
}

    // rust: pub const fn xyz(grow_x: f32, grow_y: f32, grow_z: f32) -> Self {
    // rust: Self {
    // rust: grow_x,
    // rust: grow_y,
    // rust: grow_z,
}
}

    // This growth and `by` more on every axis (`extend`).
extend :: proc(self: ^Self, by: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.extend_xyz(by, by, by)
}

extend_xyz :: proc(self: ^Self, x: f32, y: f32, z: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::xyz(self.grow_x + x, self.grow_y + y, self.grow_z + z)
}
}

// `PartPose`: where a part sits in its parent, in texels from the parent's
// pivot (+y down, as a model's frame is), its rotation in radians (about z,
// then y, then x, as `ModelPart.translateAndRotate` turns it) and its scale.
PartPose :: struct {
    x: f32,
    y: f32,
    z: f32,
    x_rot: f32,
    y_rot: f32,
    z_rot: f32,
    x_scale: f32,
    y_scale: f32,
    z_scale: f32,
}

    // rust: impl Default for PartPose {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::ZERO
}
}

    // rust: impl PartPose {
ZERO :: Self::offset_and_rotation(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

    // rust: pub const fn offset(x: f32, y: f32, z: f32) -> Self {
    // rust: Self::offset_and_rotation(x, y, z, 0.0, 0.0, 0.0)
}

    // rust: pub const fn rotation(x_rot: f32, y_rot: f32, z_rot: f32) -> Self {
    // rust: Self::offset_and_rotation(0.0, 0.0, 0.0, x_rot, y_rot, z_rot)
}

    // rust: pub const fn offset_and_rotation(
    // rust: x: f32,
    // rust: y: f32,
    // rust: z: f32,
    // rust: x_rot: f32,
    // rust: y_rot: f32,
    // rust: z_rot: f32,
    // rust: ) -> Self {
    // rust: Self {
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: x_rot,
    // rust: y_rot,
    // rust: z_rot,
    // rust: x_scale: 1.0,
    // rust: y_scale: 1.0,
    // rust: z_scale: 1.0,
}
}

    // This pose moved by `x`, `y` and `z` texels (`translated`).
translated :: proc(self: ^Self, x: f32, y: f32, z: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: x: self.x + x,
    // rust: y: self.y + y,
    // rust: z: self.z + z,
    // rust: ..self
}
}

    // This pose at `scale` on every axis (`withScale`).
with_scale :: proc(self: ^Self, scale: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: x_scale: scale,
    // rust: y_scale: scale,
    // rust: z_scale: scale,
    // rust: ..self
}
}
}

// One box of a part (`CubeDefinition`), as a [`CubeListBuilder`] adds it.
CubeDefinition :: struct {
    // Its corner at the least x, y and z, in texels from the part's pivot.
    origin: [f32,
    // Its size in texels, which is also the size of its faces on the texture.
    dimensions: [f32,
    grow: CubeDeformation,
    // Drawn with its texture flipped left to right, as a left limb draws a
    // right one's.
    mirror: bool,
    // The top left corner of its faces on the texture, in texels (`texOffs`).
    tex_coord: [i32,
    // How many of the texture's texels one of its own texels takes, 1 for most.
    tex_scale: [f32,
    // The faces it has, in [`Direction::ALL`]'s order; all six for most.
    visible_faces: [bool,
}

// `CubeListBuilder`: the boxes of one part, each placed on the texture from
// the last `tex_offs` and mirrored after `mirror`.
CubeListBuilder :: struct {
    cubes: [dynamic]CubeDefinition,
    tex: [i32,
    mirror: bool,
}

    // rust: impl CubeListBuilder {
create :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::default()
}

    // Where the next boxes' faces start on the texture, in texels (`texOffs`).
tex_offs :: proc(u: i32, v: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.tex = [u, v];
    // rust: self
}

    // The next boxes are mirrored (`mirror()`).
mirror :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.set_mirror(true)
}

    // Whether the next boxes are mirrored (`mirror(boolean)`).
set_mirror :: proc(mirror: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.mirror = mirror;
    // rust: self
}

    // A box at `origin` of `size` texels (`addBox(x, y, z, w, h, d)`).
add_box :: proc(self: ^Self, origin: [f32; 3], size: [f32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.add_box_with(origin, size, CubeDeformation::NONE)
}

    // A box grown by `grow` (`addBox(x, y, z, w, h, d, deformation)`).
add_box_with :: proc(self: ^Self, origin: [f32; 3], size: [f32; 3], grow: CubeDeformation) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.add_box_tex_scaled(origin, size, grow, [1.0, 1.0])
}

    // A box mirrored or not by `mirror`, whatever `mirror()` said
    // (`addBox(x, y, z, w, h, d, mirror)`).
add_box_mirrored :: proc(origin: [f32; 3], size: [f32; 3], mirror: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let tex = self.tex;
    // rust: self.cubes
    // rust: .push(cube(origin, size, CubeDeformation::NONE, mirror, tex));
    // rust: self
}

    // A box with only `faces` (`addBox(x, y, z, w, h, d, visibleFaces)`).
add_box_faces :: proc(origin: [f32; 3], size: [f32; 3], faces: ^[Direction]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut cube = cube(origin, size, CubeDeformation::NONE, self.mirror, self.tex);
    // rust: cube.visible_faces = Direction::ALL.map(|d| faces.contains(&d));
    // rust: self.cubes.push(cube);
    // rust: self
}

    // A box whose texels take `tex_scale` of the texture's
    // (`addBox(x, y, z, w, h, d, deformation, texScaleU, texScaleV)`).
    // rust: pub fn add_box_tex_scaled(
    // rust: mut self,
    // rust: origin: [f32; 3],
    // rust: size: [f32; 3],
    // rust: grow: CubeDeformation,
    // rust: tex_scale: [f32; 2],
    // rust: ) -> Self {
    // rust: let mut cube = cube(origin, size, grow, self.mirror, self.tex);
    // rust: cube.tex_scale = tex_scale;
    // rust: self.cubes.push(cube);
    // rust: self
}

    // A box with its own place on the texture, leaving `tex_offs` as it is
    // (`addBox(comment, x, y, z, w, h, d, deformation, texU, texV)`).
    // rust: pub fn add_box_at(
    // rust: mut self,
    // rust: origin: [f32; 3],
    // rust: size: [f32; 3],
    // rust: grow: CubeDeformation,
    // rust: tex: [i32; 2],
    // rust: ) -> Self {
    // rust: self.cubes.push(cube(origin, size, grow, self.mirror, tex));
    // rust: self
}

    // The boxes added so far (`getCubes`).
cubes :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.cubes
}
}

    // rust: fn cube(
    // rust: origin: [f32; 3],
    // rust: dimensions: [f32; 3],
    // rust: grow: CubeDeformation,
    // rust: mirror: bool,
    // rust: tex_coord: [i32; 2],
    // rust: ) -> CubeDefinition {
    // rust: CubeDefinition {
    // rust: origin,
    // rust: dimensions,
    // rust: grow,
    // rust: mirror,
    // rust: tex_coord,
    // rust: tex_scale: [1.0, 1.0],
    // rust: visible_faces: [true; 6],
}
}

    // rust: impl CubeDefinition {
    // `ModelPart.Cube`: the box's faces on a `texture` of that many texels,
    // in vanilla's order (down, up, west, north, east, south), each face's
    // corners and texture net as `Cube`'s constructor makes them.
bake_into :: proc(self: ^Self, texture: [f32; 2], out: ^[dynamic]ModelPolygon) {
}
    // rust: let [w, h, d] = self.dimensions;
    // rust: let [mut x0, mut y0, mut z0] = self.origin;
    // rust: let (mut x1, mut y1, mut z1) = (x0 + w, y0 + h, z0 + d);
    // rust: let g = self.grow;
    // rust: x0 -= g.grow_x;
    // rust: y0 -= g.grow_y;
    // rust: z0 -= g.grow_z;
    // rust: x1 += g.grow_x;
    // rust: y1 += g.grow_y;
    // rust: z1 += g.grow_z;
    // rust: if self.mirror {
    // rust: std::mem::swap(&mut x0, &mut x1);
}
        // The constructor's eight vertices, v7 v v1 v2 v3 v4 v5 v6.
    // rust: let corner = [
    // rust: [x0, y0, z0],
    // rust: [x1, y0, z0],
    // rust: [x1, y1, z0],
    // rust: [x0, y1, z0],
    // rust: [x0, y0, z1],
    // rust: [x1, y0, z1],
    // rust: [x1, y1, z1],
    // rust: [x0, y1, z1],
    // rust: ];
    // rust: let tex_w = texture[0] * self.tex_scale[0];
    // rust: let tex_h = texture[1] * self.tex_scale[1];
    // rust: let [u, v] = self.tex_coord.map(|t| t as f32);
    // rust: let (u1, u2, u3) = (u + d, u + d + w, u + d + w + w);
    // rust: let (u4, u5) = (u + d + w + d, u + d + w + d + w);
    // rust: let (v1, v2) = (v + d, v + d + h);
    // rust: let faces = [
    // rust: (Direction::Down, [5, 4, 0, 1], [u1, v, u2, v1]),
    // rust: (Direction::Up, [2, 3, 7, 6], [u2, v1, u3, v]),
    // rust: (Direction::West, [0, 4, 7, 3], [u, v1, u1, v2]),
    // rust: (Direction::North, [1, 0, 3, 2], [u1, v1, u2, v2]),
    // rust: (Direction::East, [5, 1, 2, 6], [u2, v1, u4, v2]),
    // rust: (Direction::South, [4, 5, 6, 7], [u4, v1, u5, v2]),
    // rust: ];
    // rust: for (direction, corners, [ua, va, ub, vb]) in faces {
    // rust: let shown = Direction::ALL
    // rust: .iter()
    // rust: .position(|d| *d == direction)
    // rust: .is_some_and(|i| self.visible_faces[i]);
    // rust: if !shown {
    // rust: continue;
}
            // `Polygon`'s remap: right top, left top, left bottom, right bottom.
    // rust: let uv = [(ub, va), (ua, va), (ua, vb), (ub, vb)];
    // rust: let mut vertices = std::array::from_fn(|k| ModelVertex {
    // rust: pos: corner[corners[k]],
    // rust: u: uv[k].0 / tex_w,
    // rust: v: uv[k].1 / tex_h,
    // rust: });
    // rust: let [nx, ny, nz] = direction.normal();
    // rust: let mut normal = [nx as f32, ny as f32, nz as f32];
    // rust: if self.mirror {
    // rust: vertices.reverse();
    // rust: normal[0] = -normal[0];
}
    // rust: out.push(ModelPolygon { vertices, normal });
}
}
}

// A part of a [`MeshDefinition`], as `add_or_replace_child` gives it
// (`PartDefinition`): a handle into that mesh only.
PartId :: struct {

PartNode :: struct {
    cubes: [dynamic]CubeDefinition,
    pose: PartPose,
    children: Vec<(string,
}

// `MeshDefinition`: a model's parts, from a root part with no boxes.
MeshDefinition :: struct {
    parts: [dynamic]PartNode,
}

    // rust: impl Default for MeshDefinition {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}

    // rust: impl MeshDefinition {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: parts: vec![PartNode {
    // rust: cubes: Vec::new(),
    // rust: pose: PartPose::ZERO,
    // rust: children: Vec::new(),
    // rust: }],
}
}

    // The root part (`getRoot`).
root :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PartId(0)
}

    // Adds part `name` to `parent`, with `cubes` at `pose`
    // (`PartDefinition.addOrReplaceChild`). A part of that name already
    // there is replaced and its children kept.
    // rust: pub fn add_or_replace_child(
    // rust: &mut self,
    // rust: parent: PartId,
    // rust: name: &str,
    // rust: cubes: CubeListBuilder,
    // rust: pose: PartPose,
    // rust: ) -> PartId {
    // rust: let node = PartNode {
    // rust: cubes: cubes.cubes,
    // rust: pose,
    // rust: children: Vec::new(),
}
    // rust: if let Some(at) = self.child(parent, name) {
    // rust: let old = std::mem::replace(&mut self.parts[at.0], node);
    // rust: self.parts[at.0].children = old.children;
    // rust: return at;
}
    // rust: self.parts.push(node);
    // rust: let at = self.parts.len() - 1;
    // rust: self.parts[parent.0].children.push((name.to_owned(), at));
    // rust: PartId(at)
}

    // `parent`'s part `name` (`getChild`).
child :: proc(self: ^Self, parent: PartId, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.parts[parent.0]
    // rust: .children
    // rust: .iter()
    // rust: .find(|(n, _)| n == name)
    // rust: .map(|&(_, at)| PartId(at))
}

bake :: proc(self: ^Self, at: uint, texture: [f32; 2]) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let node = &self.parts[at];
    // rust: let mut polygons = Vec::new();
    // rust: for cube in &node.cubes {
    // rust: cube.bake_into(texture, &mut polygons);
}
    // rust: let children = node
    // rust: .children
    // rust: .iter()
    // rust: .map(|(name, child)| (name.clone(), self.bake(*child, texture)))
    // rust: .collect();
    // rust: ModelPart::new(polygons, children, node.pose)
}
}

// `LayerDefinition`: a mesh and the size of the texture its boxes are on.
LayerDefinition :: struct {
    mesh: MeshDefinition,
    texture_width: u32,
    texture_height: u32,
}

    // rust: impl LayerDefinition {
    // `LayerDefinition.create(mesh, 64, 64)`.
create :: proc(mesh: MeshDefinition, texture_width: u32, texture_height: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: mesh,
    // rust: texture_width,
    // rust: texture_height,
}
}

    // The part tree, each part at its pose (`bakeRoot`).
bake_root :: proc(self: ^Self) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let texture = [self.texture_width as f32, self.texture_height as f32];
    // rust: self.mesh.bake(0, texture)
}
}

// A corner of a baked face (`ModelPart.Vertex`): in texels in its part's
// frame, and where it falls on the texture, 0 to 1 across it.
ModelVertex :: struct {
    pos: [f32,
    u: f32,
    v: f32,
}

// A baked face (`ModelPart.Polygon`), with the normal it faces in its
// part's frame.
ModelPolygon :: struct {
    vertices: [ModelVertex,
    normal: [f32,
}

// `ModelPart`: a baked part, its children by name, and the pose a mod sets
// each frame before drawing it (`setupAnim`), from the pose it was baked
// with (`reset_pose`).
ModelPart :: struct {
    // Where it sits in its parent, in texels.
    x: f32,
    y: f32,
    z: f32,
    // Its rotation in radians, applied about z, then y, then x.
    x_rot: f32,
    y_rot: f32,
    z_rot: f32,
    x_scale: f32,
    y_scale: f32,
    z_scale: f32,
    // False draws neither it nor its children.
    visible: bool,
    // True draws its children but not its own faces (`skipDraw`).
    skip_draw: bool,
    // Its boxes' faces.
    polygons: [dynamic]ModelPolygon,
    children: Vec<(string,
    initial_pose: PartPose,
}

    // rust: impl ModelPart {
    // A part with `polygons` and `children` at `pose`, which it is reset to.
    // rust: pub fn new(
    // rust: polygons: Vec<ModelPolygon>,
    // rust: children: Vec<(String, ModelPart)>,
    // rust: pose: PartPose,
    // rust: ) -> Self {
    // rust: let mut part = Self {
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: z: 0.0,
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: z_rot: 0.0,
    // rust: x_scale: 1.0,
    // rust: y_scale: 1.0,
    // rust: z_scale: 1.0,
    // rust: visible: true,
    // rust: skip_draw: false,
    // rust: polygons,
    // rust: children,
    // rust: initial_pose: pose,
}
    // rust: part.load_pose(pose);
    // rust: part
}

    // A vanilla layer's part tree from `entity-models.json`.
from_part :: proc(part: ^Part) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let p = part.pose;
    // rust: let pose = PartPose {
    // rust: x: p[0],
    // rust: y: p[1],
    // rust: z: p[2],
    // rust: x_rot: p[3],
    // rust: y_rot: p[4],
    // rust: z_rot: p[5],
    // rust: x_scale: p[6],
    // rust: y_scale: p[7],
    // rust: z_scale: p[8],
}
    // rust: let polygons = part
    // rust: .polygons
    // rust: .iter()
    // rust: .map(|poly| ModelPolygon {
    // rust: vertices: poly.vertices.map(|v| ModelVertex {
    // rust: pos: [v[0], v[1], v[2]],
    // rust: u: v[3],
    // rust: v: v[4],
    // rust: }),
    // rust: normal: poly.normal,
    // rust: })
    // rust: .collect();
    // rust: let children = part
    // rust: .children
    // rust: .iter()
    // rust: .map(|c| (c.name.clone(), Self::from_part(c)))
    // rust: .collect();
    // rust: Self::new(polygons, children, pose)
}

    // Its part `name` (`getChild`).
get_child :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.children
    // rust: .iter()
    // rust: .find(|(n, _)| n == name)
    // rust: .map(|(_, c)| c)
}

get_child_mut :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.children
    // rust: .iter_mut()
    // rust: .find(|(n, _)| n == name)
    // rust: .map(|(_, c)| c)
}

    // Its parts by name, in the order they draw.
children :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.children.iter().map(|(n, c)| (n.as_str(), c))
}

children_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.children.iter_mut().map(|(n, c)| (n.as_str(), c))
}

    // Whether it has no faces of its own (`isEmpty`).
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.polygons.is_empty()
}

    // Its pose now (`storePose`).
store_pose :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PartPose {
    // rust: x: self.x,
    // rust: y: self.y,
    // rust: z: self.z,
    // rust: x_rot: self.x_rot,
    // rust: y_rot: self.y_rot,
    // rust: z_rot: self.z_rot,
    // rust: x_scale: self.x_scale,
    // rust: y_scale: self.y_scale,
    // rust: z_scale: self.z_scale,
}
}

    // Puts it at `pose` (`loadPose`).
load_pose :: proc(self: ^Self, pose: PartPose) {
}
    // rust: self.x = pose.x;
    // rust: self.y = pose.y;
    // rust: self.z = pose.z;
    // rust: self.x_rot = pose.x_rot;
    // rust: self.y_rot = pose.y_rot;
    // rust: self.z_rot = pose.z_rot;
    // rust: self.x_scale = pose.x_scale;
    // rust: self.y_scale = pose.y_scale;
    // rust: self.z_scale = pose.z_scale;
}

    // The pose it was baked with, unless set since (`getInitialPose`).
initial_pose :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.initial_pose
}

set_initial_pose :: proc(self: ^Self, pose: PartPose) {
}
    // rust: self.initial_pose = pose;
}

    // Puts it back at its initial pose (`resetPose`), its children as they are.
reset_pose :: proc(self: ^Self) {
}
    // rust: self.load_pose(self.initial_pose);
}

    // Puts it and every part under it back at their initial poses, as
    // `Model.resetPose` does before each frame's `setupAnim`.
reset_all_poses :: proc(self: ^Self) {
}
    // rust: self.reset_pose();
    // rust: for (_, child) in &mut self.children {
    // rust: child.reset_all_poses();
}
}

    // Takes `other`'s position, rotation and scale (`copyFrom`).
copy_from :: proc(self: ^Self, other: ^ModelPart) {
}
    // rust: self.load_pose(other.store_pose());
}

set_pos :: proc(self: ^Self, x: f32, y: f32, z: f32) {
}
    // rust: (self.x, self.y, self.z) = (x, y, z);
}

set_rotation :: proc(self: ^Self, x_rot: f32, y_rot: f32, z_rot: f32) {
}
    // rust: (self.x_rot, self.y_rot, self.z_rot) = (x_rot, y_rot, z_rot);
}

    // Moves it by `by` texels (`offsetPos`), as keyframe animations do.
offset_pos :: proc(self: ^Self, by: [f32; 3]) {
}
    // rust: self.x += by[0];
    // rust: self.y += by[1];
    // rust: self.z += by[2];
}

    // Turns it by `by` radians (`offsetRotation`).
offset_rotation :: proc(self: ^Self, by: [f32; 3]) {
}
    // rust: self.x_rot += by[0];
    // rust: self.y_rot += by[1];
    // rust: self.z_rot += by[2];
}

    // Scales it by `by` more (`offsetScale`: added, as vanilla adds it).
offset_scale :: proc(self: ^Self, by: [f32; 3]) {
}
    // rust: self.x_scale += by[0];
    // rust: self.y_scale += by[1];
    // rust: self.z_scale += by[2];
}
}

REGISTERED :: OnceLock::new()

// Keeps the layers native mods registered (`native_layer_definitions`),
// once at start. An id is `<namespace>:<path>#<layer>` (NeoForge's
// `ModelLayerLocation`) in a namespace other than vanilla's; one that isn't,
// or that another layer has already, is logged and left out.
register :: proc(layers: Vec<(string) {
}
    // rust: let mut kept = HashMap::new();
    // rust: for (id, layer) in layers {
    // rust: if !is_mod_layer_id(&id) {
    // rust: log::warn!("model layer {id:?} is not <namespace>:<path>#<layer> in a mod's namespace");
    // rust: continue;
}
    // rust: if kept.contains_key(&id) {
    // rust: log::warn!("model layer {id} is registered twice; the first is kept");
    // rust: continue;
}
    // rust: kept.insert(id, layer);
}
    // rust: if REGISTERED.set(kept).is_err() {
    // rust: log::warn!("model layers were registered already; these are left out");
}
}

// The layer a native mod registered as `id`.
registered :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: REGISTERED.get()?.get(id)
}

is_mod_layer_id :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((location, layer)) = id.split_once('#') else {
    // rust: return false;
}
    // rust: let Some((namespace, path)) = location.split_once(':') else {
    // rust: return false;
}
    // rust: let ok = |s: &str, extra: &[char]| {
    // rust: !s.is_empty()
    // rust: && s.chars().all(|c| {
    // rust: c.is_ascii_lowercase()
    // rust: || c.is_ascii_digit()
    // rust: || "_.-".contains(c)
    // rust: || extra.contains(&c)
    // rust: })
}
    // rust: namespace != "minecraft"
    // rust: && ok(namespace, &[])
    // rust: && ok(path, &['/'])
    // rust: && !layer.is_empty()
    // rust: && !layer.contains(['#', ':'])
}

    // rust: mod tests {
//     use super::*;

polygon :: proc(part: ^ModelPart, i: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let p = &part.polygons[i];
    // rust: (
    // rust: p.vertices.map(|v| v.pos),
    // rust: p.vertices.map(|v| [v.u, v.v]),
    // rust: p.normal,
    // rust: )
}

    // One 8-texel head box on a 64 by 64 texture (`HumanoidModel`'s head),
    // worked out by hand from `ModelPart.Cube`'s constructor: its top face
    // is the net's first strip, 8 to 16 across and 0 to 8 down, at the
    // box's least y (a model's +y is down).
a_box_bakes_its_faces_on_the_texture_as_vanilla_cubes_do :: proc() {
}
    // rust: let mut mesh = MeshDefinition::new();
    // rust: let root = mesh.root();
    // rust: let cubes = CubeListBuilder::create()
    // rust: .tex_offs(0, 0)
    // rust: .add_box([-4.0, -8.0, -4.0], [8.0, 8.0, 8.0]);
    // rust: mesh.add_or_replace_child(root, "head", cubes, PartPose::offset(0.0, 2.0, 0.0));
    // rust: let baked = LayerDefinition::create(mesh, 64, 64).bake_root();
    // rust: let head = baked.get_child("head").unwrap();
    // rust: assert_eq!(head.polygons.len(), 6);
    // rust: assert_eq!((head.x, head.y, head.z), (0.0, 2.0, 0.0));

    // rust: let (pos, uv, normal) = polygon(head, 0);
    // rust: assert_eq!(normal, [0.0, -1.0, 0.0]);
    // rust: assert_eq!(
    // rust: pos,
    // rust: [
    // rust: [4.0, -8.0, 4.0],
    // rust: [-4.0, -8.0, 4.0],
    // rust: [-4.0, -8.0, -4.0],
    // rust: [4.0, -8.0, -4.0]
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: uv,
    // rust: [[0.25, 0.0], [0.125, 0.0], [0.125, 0.125], [0.25, 0.125]]
    // rust: );

        // The face, north (-z): 8 to 16 across, 8 to 16 down.
    // rust: let (pos, uv, normal) = polygon(head, 3);
    // rust: assert_eq!(normal, [0.0, 0.0, -1.0]);
    // rust: assert_eq!(
    // rust: pos,
    // rust: [
    // rust: [4.0, -8.0, -4.0],
    // rust: [-4.0, -8.0, -4.0],
    // rust: [-4.0, 0.0, -4.0],
    // rust: [4.0, 0.0, -4.0]
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: uv,
    // rust: [[0.25, 0.125], [0.125, 0.125], [0.125, 0.25], [0.25, 0.25]]
    // rust: );

        // The back, south: the net's last strip, 24 to 32 across.
    // rust: let (_, uv, normal) = polygon(head, 5);
    // rust: assert_eq!(normal, [0.0, 0.0, 1.0]);
    // rust: assert_eq!(
    // rust: uv,
    // rust: [[0.5, 0.125], [0.375, 0.125], [0.375, 0.25], [0.5, 0.25]]
    // rust: );
}

mirroring_swaps_the_sides_and_growing_keeps_the_texture :: proc() {
}
    // rust: let plain = CubeListBuilder::create()
    // rust: .tex_offs(40, 16)
    // rust: .add_box([-1.0, -2.0, -2.0], [4.0, 12.0, 4.0]);
    // rust: let mirrored = CubeListBuilder::create()
    // rust: .tex_offs(40, 16)
    // rust: .mirror()
    // rust: .add_box([-1.0, -2.0, -2.0], [4.0, 12.0, 4.0]);
    // rust: let grown = CubeListBuilder::create().tex_offs(40, 16).add_box_with(
    // rust: [-1.0, -2.0, -2.0],
    // rust: [4.0, 12.0, 4.0],
    // rust: CubeDeformation::new(0.25),
    // rust: );
    // rust: let bake = |cubes| {
    // rust: let mut mesh = MeshDefinition::new();
    // rust: let root = mesh.root();
    // rust: mesh.add_or_replace_child(root, "arm", cubes, PartPose::ZERO);
    // rust: LayerDefinition::create(mesh, 64, 64)
    // rust: .bake_root()
    // rust: .get_child("arm")
    // rust: .unwrap()
    // rust: .clone()
}
    // rust: let (plain, mirrored, grown) = (bake(plain), bake(mirrored), bake(grown));

        // West (index 2): mirrored, its corners sit at the other x and
        // wind the other way, and it faces east; its net stays the same.
    // rust: let (pos, uv, normal) = polygon(&plain, 2);
    // rust: let (mpos, muv, mnormal) = polygon(&mirrored, 2);
    // rust: assert_eq!(normal, [-1.0, 0.0, 0.0]);
    // rust: assert_eq!(mnormal, [1.0, 0.0, 0.0]);
    // rust: assert_eq!(pos[0], [-1.0, -2.0, -2.0]);
    // rust: assert_eq!(mpos[3], [3.0, -2.0, -2.0]);
    // rust: assert_eq!(muv, [uv[3], uv[2], uv[1], uv[0]]);

        // Grown a quarter texel on each side, with the same texture.
    // rust: let (gpos, guv, _) = polygon(&grown, 2);
    // rust: assert_eq!(gpos[0], [-1.25, -2.25, -2.25]);
    // rust: assert_eq!(guv, uv);
}

hidden_faces_and_texture_scale_change_what_bakes :: proc() {
}
    // rust: let cubes = CubeListBuilder::create()
    // rust: .tex_offs(0, 0)
    // rust: .add_box_faces([0.0; 3], [2.0, 2.0, 2.0], &[Direction::North])
    // rust: .add_box_tex_scaled([0.0; 3], [2.0, 2.0, 2.0], CubeDeformation::NONE, [2.0, 2.0]);
    // rust: let mut mesh = MeshDefinition::new();
    // rust: let root = mesh.root();
    // rust: mesh.add_or_replace_child(root, "p", cubes, PartPose::ZERO);
    // rust: let part = LayerDefinition::create(mesh, 16, 16).bake_root();
    // rust: let part = part.get_child("p").unwrap();
        // One face of the first box, six of the second.
    // rust: assert_eq!(part.polygons.len(), 7);
    // rust: assert_eq!(part.polygons[0].normal, [0.0, 0.0, -1.0]);
        // North of the second: 2 to 4 across, on a texture taken as 32 wide.
    // rust: let (_, uv, _) = polygon(part, 4);
    // rust: assert_eq!(uv[0], [4.0 / 32.0, 2.0 / 32.0]);
}

a_replaced_part_keeps_its_children_and_poses_reset :: proc() {
}
    // rust: let mut mesh = MeshDefinition::new();
    // rust: let root = mesh.root();
    // rust: let body =
    // rust: mesh.add_or_replace_child(root, "body", CubeListBuilder::create(), PartPose::ZERO);
    // rust: mesh.add_or_replace_child(
    // rust: body,
    // rust: "arm",
    // rust: CubeListBuilder::create(),
    // rust: PartPose::offset(5.0, 2.0, 0.0),
    // rust: );
    // rust: let again = mesh.add_or_replace_child(
    // rust: root,
    // rust: "body",
    // rust: CubeListBuilder::create().add_box([0.0; 3], [1.0; 3]),
    // rust: PartPose::rotation(0.5, 0.0, 0.0),
    // rust: );
    // rust: assert_eq!(again, body);
    // rust: assert!(mesh.child(body, "arm").is_some());

    // rust: let mut model = LayerDefinition::create(mesh, 64, 32).bake_root();
    // rust: let body = model.get_child_mut("body").unwrap();
    // rust: assert_eq!(body.polygons.len(), 6);
    // rust: assert_eq!(body.x_rot, 0.5);
    // rust: body.x_rot = 1.5;
    // rust: let arm = body.get_child_mut("arm").unwrap();
    // rust: arm.offset_pos([1.0, 0.0, 0.0]);
    // rust: assert_eq!(arm.x, 6.0);
    // rust: model.reset_all_poses();
    // rust: let body = model.get_child("body").unwrap();
    // rust: assert_eq!(body.x_rot, 0.5);
    // rust: assert_eq!(body.get_child("arm").unwrap().x, 5.0);
}

layer_ids_are_a_mods_own_model_and_layer :: proc() {
}
    // rust: assert!(is_mod_layer_id("mymod:golem#main"));
    // rust: assert!(is_mod_layer_id("my_mod:mobs/golem.v2#outer_armor"));
    // rust: for bad in [
    // rust: "minecraft:zombie#main",
    // rust: "mymod:golem",
    // rust: "golem#main",
    // rust: "mymod:#main",
    // rust: "mymod:golem#",
    // rust: "MyMod:golem#main",
    // rust: "mymod:golem#a#b",
    // rust: ] {
    // rust: assert!(!is_mod_layer_id(bad), "{bad}");
}
}

    // `HumanoidModel.createMesh(CubeDeformation.NONE, 0)` built with these
    // builders bakes what vanilla baked for the zombie
    // (`minecraft:zombie#main` in the prepared `entity-models.json`):
    // `cargo test -p horizon-client-lib --lib model_layers -- --ignored`
    // with HORIZON_RESOURCES set to the prepared resources.
the_humanoid_mesh_bakes_as_vanillas_zombie :: proc() {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_RESOURCES").map(std::path::PathBuf::from) else {
    // rust: return;
}
    // rust: let vanilla =
    // rust: super::super::load_model(&root, "minecraft:zombie#main").expect("zombie#main");
    // rust: let vanilla = ModelPart::from_part(&vanilla);

        // `HumanoidModel.createMesh`: (part, parent, texOffs, mirror, origin, size, grow, pose).
    // rust: let half = CubeDeformation::new(0.5);
    // rust: let none = CubeDeformation::NONE;
    // rust: let (z4, limb) = ([-4.0, -8.0, -4.0], [4.0, 12.0, 4.0]);
    // rust: let parts = [
    // rust: ("head", "", (0, 0), false, z4, [8.0; 3], none, [0.0; 3]),
    // rust: ("hat", "head", (32, 0), false, z4, [8.0; 3], half, [0.0; 3]),
    // rust: ("body", "", (16, 16), false, [-4.0, 0.0, -2.0], [8.0, 12.0, 4.0], none, [0.0; 3]),
    // rust: ("right_arm", "", (40, 16), false, [-3.0, -2.0, -2.0], limb, none, [-5.0, 2.0, 0.0]),
    // rust: ("left_arm", "", (40, 16), true, [-1.0, -2.0, -2.0], limb, none, [5.0, 2.0, 0.0]),
    // rust: ("right_leg", "", (0, 16), false, [-2.0, 0.0, -2.0], limb, none, [-1.9, 12.0, 0.0]),
    // rust: ("left_leg", "", (0, 16), true, [-2.0, 0.0, -2.0], limb, none, [1.9, 12.0, 0.0]),
    // rust: ];
    // rust: let mut mesh = MeshDefinition::new();
    // rust: for (name, parent, (u, v), mirror, origin, size, grow, [x, y, z]) in parts {
    // rust: let parent = mesh.child(mesh.root(), parent).unwrap_or(mesh.root());
    // rust: let cubes = CubeListBuilder::create()
    // rust: .tex_offs(u, v)
    // rust: .set_mirror(mirror)
    // rust: .add_box_with(origin, size, grow);
    // rust: mesh.add_or_replace_child(parent, name, cubes, PartPose::offset(x, y, z));
}
    // rust: let ours = LayerDefinition::create(mesh, 64, 64).bake_root();

same :: proc(path: string, ours: ^ModelPart, vanilla: ^ModelPart) {
}
    // rust: assert_eq!(ours.store_pose(), vanilla.store_pose(), "{path} pose");
    // rust: assert_eq!(ours.polygons, vanilla.polygons, "{path} faces");
    // rust: let mut names: Vec<_> = ours.children().map(|(n, _)| n).collect();
    // rust: let mut theirs: Vec<_> = vanilla.children().map(|(n, _)| n).collect();
    // rust: names.sort_unstable();
    // rust: theirs.sort_unstable();
    // rust: assert_eq!(names, theirs, "{path} children");
    // rust: for (name, child) in ours.children() {
    // rust: same(
    // rust: &format!("{path}/{name}"),
    // rust: child,
    // rust: vanilla.get_child(name).unwrap(),
    // rust: );
}
}
    // rust: same("root", &ours, &vanilla);
}
}
