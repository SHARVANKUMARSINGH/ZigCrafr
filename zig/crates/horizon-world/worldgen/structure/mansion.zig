//! Transpiled from Horizon Rust crate
//! Module: horizon-world_mansion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Woodland mansions (WoodlandMansionStructure, WoodlandMansionPieces).
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources,
    // rust: legacy::{
    // rust: HORIZONTAL, PieceContext, Result, TemplateHandler, TemplatePiece, clockwise,
    // rust: counter_clockwise, create_chest, direction_name, offset, opposite,
    // rust: },
    // rust: processor::ProcessorList,
}
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::sync::Arc;

pub const CORRIDOR_FLAG: i32 = 8_388_608;
pub const STAIRS_FLAG: i32 = 4_194_304;
pub const DOOR_FLAG: i32 = 2_097_152;
pub const ORIGIN_FLAG: i32 = 1_048_576;
pub const TYPE_MASK: i32 = 983_040;
pub const ID_MASK: i32 = 65_535;
pub const ROOM_1X1: i32 = 65_536;
pub const ROOM_1X2: i32 = 131_072;
pub const ROOM_2X2: i32 = 262_144;

pub const Grid = struct {
    cells: std.ArrayList(i32),
    width: i32,
    height: i32,
    outside: i32,
};
    // rust: impl Grid {
pub fn new(width: i32, height: i32, outside: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: cells: vec![0; (width * height) as usize],
    // rust: width,
    // rust: height,
    // rust: outside,
}
}
pub fn set(self: *Self, x: i32, y: i32, value: i32) void {
}
    // rust: if x >= 0 && x < self.width && y >= 0 && y < self.height {
    // rust: self.cells[(x * self.height + y) as usize] = value;
}
}
pub fn fill(self: *Self, x0: i32, y0: i32, x1: i32, y1: i32, value: i32) void {
}
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: self.set(x, y, value);
}
}
}
pub fn get(self: *Self, x: i32, y: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if x >= 0 && x < self.width && y >= 0 && y < self.height {
    // rust: self.cells[(x * self.height + y) as usize]
    // rust: } else {
    // rust: self.outside
}
}
pub fn set_if(self: *Self, x: i32, y: i32, if_value: i32, value: i32) void {
}
    // rust: if self.get(x, y) == if_value {
    // rust: self.set(x, y, value);
}
}
pub fn edges_to(self: *Self, x: i32, y: i32, value: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(x - 1, y) == value
    // rust: || self.get(x + 1, y) == value
    // rust: || self.get(x, y + 1) == value
    // rust: || self.get(x, y - 1) == value
}
}
pub fn is_house(grid: *Grid, x: i32, y: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(grid.get(x, y), 1..=4)
}
pub fn step(d: Direction) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = d.normal();
    // rust: (n[0], n[2])
}
pub fn from_2d(value: i32) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: ][value as usize & 3]
}
    // rust: fn shuffle<T>(list: &mut [T], random: &mut impl RandomSource) {
    // rust: for i in (2..=list.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: list.swap(i - 1, j);
}
}

pub const MansionGrid = struct {
    base: Grid,
    third: Grid,
    rooms: [Grid,
    entrance_x: i32,
    entrance_y: i32,
};
    // rust: impl MansionGrid {
pub fn new(r: *mut impl RandomSource) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ex, ey) = (7, 4);
    // rust: let mut base = Grid::new(11, 11, 5);
    // rust: base.fill(ex, ey, ex + 1, ey + 1, 3);
    // rust: base.fill(ex - 1, ey, ex - 1, ey + 1, 2);
    // rust: base.fill(ex + 2, ey - 2, ex + 3, ey + 3, 5);
    // rust: base.fill(ex + 1, ey - 2, ex + 1, ey - 1, 1);
    // rust: base.fill(ex + 1, ey + 2, ex + 1, ey + 3, 1);
    // rust: base.set(ex - 1, ey - 1, 1);
    // rust: base.set(ex - 1, ey + 2, 1);
    // rust: base.fill(0, 0, 11, 1, 5);
    // rust: base.fill(0, 9, 11, 11, 5);
    // rust: corridor(&mut base, r, ex, ey - 2, Direction::West, 6);
    // rust: corridor(&mut base, r, ex, ey + 3, Direction::West, 6);
    // rust: corridor(&mut base, r, ex - 2, ey - 1, Direction::West, 3);
    // rust: corridor(&mut base, r, ex - 2, ey + 2, Direction::West, 3);
    // rust: while clean_edges(&mut base) {}
    // rust: let mut rooms = [
    // rust: Grid::new(11, 11, 5),
    // rust: Grid::new(11, 11, 5),
    // rust: Grid::new(11, 11, 5),
    // rust: ];
    // rust: identify_rooms(&base, &mut rooms[0], r);
    // rust: identify_rooms(&base, &mut rooms[1], r);
    // rust: rooms[0].fill(ex + 1, ey, ex + 1, ey + 1, CORRIDOR_FLAG);
    // rust: rooms[1].fill(ex + 1, ey, ex + 1, ey + 1, CORRIDOR_FLAG);
    // rust: let mut grid = Self {
    // rust: third: Grid::new(base.width, base.height, 5),
    // rust: base,
    // rust: rooms,
    // rust: entrance_x: ex,
    // rust: entrance_y: ey,
}
    // rust: grid.setup_third_floor(r);
    // rust: let mut third_rooms = std::mem::replace(&mut grid.rooms[2], Grid::new(0, 0, 0));
    // rust: identify_rooms(&grid.third, &mut third_rooms, r);
    // rust: grid.rooms[2] = third_rooms;
    // rust: grid
}
pub fn is_room_id(self: *Self, x: i32, y: i32, floor: usize, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.rooms[floor].get(x, y) & ID_MASK) == id
}
pub fn room_direction_1x2(self: *Self, x: i32, y: i32, floor: usize, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HORIZONTAL.into_iter().find(|&d| {
    // rust: let (dx, dz) = step(d);
    // rust: self.is_room_id(x + dx, y + dz, floor, id)
    // rust: })
}
pub fn setup_third_floor(self: *Self, r: *mut impl RandomSource) void {
}
    // rust: let mut potential = Vec::new();
    // rust: for y in 0..self.third.height {
    // rust: for x in 0..self.third.width {
    // rust: let data = self.rooms[1].get(x, y);
    // rust: if data & TYPE_MASK == ROOM_1X2 && data & DOOR_FLAG == DOOR_FLAG {
    // rust: potential.push((x, y));
}
}
}
    // rust: let (w, h) = (self.third.width, self.third.height);
    // rust: if potential.is_empty() {
    // rust: self.third.fill(0, 0, w, h, 5);
    // rust: return;
}
    // rust: let (rx, ry) = potential[r.next_int_bound(potential.len() as i32).unwrap_or(0) as usize];
    // rust: let data = self.rooms[1].get(rx, ry);
    // rust: self.rooms[1].set(rx, ry, data | STAIRS_FLAG);
    // rust: let Some(dir) = self.room_direction_1x2(rx, ry, 1, data & ID_MASK) else {
    // rust: return;
}
    // rust: let (dx, dz) = step(dir);
    // rust: let (ex, ey) = (rx + dx, ry + dz);
    // rust: for y in 0..h {
    // rust: for x in 0..w {
    // rust: if !is_house(&self.base, x, y) {
    // rust: self.third.set(x, y, 5);
    // rust: } else if x == rx && y == ry {
    // rust: self.third.set(x, y, 3);
    // rust: } else if x == ex && y == ey {
    // rust: self.third.set(x, y, 3);
    // rust: self.rooms[2].set(x, y, CORRIDOR_FLAG);
}
}
}
    // rust: let corridors: Vec<Direction> = HORIZONTAL
    // rust: .into_iter()
    // rust: .filter(|&d| {
    // rust: let (dx, dz) = step(d);
    // rust: self.third.get(ex + dx, ey + dz) == 0
    // rust: })
    // rust: .collect();
    // rust: if corridors.is_empty() {
    // rust: self.third.fill(0, 0, w, h, 5);
    // rust: self.rooms[1].set(rx, ry, data);
    // rust: } else {
    // rust: let d = corridors[r.next_int_bound(corridors.len() as i32).unwrap_or(0) as usize];
    // rust: let (dx, dz) = step(d);
    // rust: corridor(&mut self.third, r, ex + dx, ey + dz, d, 4);
    // rust: while clean_edges(&mut self.third) {}
}
}
}
    // rust: fn corridor(
    // rust: g: &mut Grid,
    // rust: r: &mut impl RandomSource,
    // rust: x: i32,
    // rust: y: i32,
    // rust: heading: Direction,
    // rust: depth: i32,
    // rust: ) {
    // rust: if depth <= 0 {
    // rust: return;
}
    // rust: let (hx, hz) = step(heading);
    // rust: g.set(x, y, 1);
    // rust: g.set_if(x + hx, y + hz, 0, 1);
    // rust: for _ in 0..8 {
    // rust: let next = from_2d(r.next_int_bound(4).unwrap_or(0));
    // rust: if next != opposite(heading) && (next != Direction::East || !r.next_boolean()) {
    // rust: let (nx, ny) = (x + hx, y + hz);
    // rust: let (dx, dz) = step(next);
    // rust: if g.get(nx + dx, ny + dz) == 0 && g.get(nx + dx * 2, ny + dz * 2) == 0 {
    // rust: corridor(g, r, x + hx + dx, y + hz + dz, next, depth - 1);
    // rust: break;
}
}
}
    // rust: let (cx, cz) = step(clockwise(heading));
    // rust: let (ax, az) = step(counter_clockwise(heading));
    // rust: g.set_if(x + cx, y + cz, 0, 2);
    // rust: g.set_if(x + ax, y + az, 0, 2);
    // rust: g.set_if(x + hx + cx, y + hz + cz, 0, 2);
    // rust: g.set_if(x + hx + ax, y + hz + az, 0, 2);
    // rust: g.set_if(x + hx * 2, y + hz * 2, 0, 2);
    // rust: g.set_if(x + cx * 2, y + cz * 2, 0, 2);
    // rust: g.set_if(x + ax * 2, y + az * 2, 0, 2);
}
pub fn clean_edges(g: *mut Grid) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut touched = false;
    // rust: for y in 0..g.height {
    // rust: for x in 0..g.width {
    // rust: if g.get(x, y) != 0 {
    // rust: continue;
}
    // rust: let house = |g: &Grid, x, y| i32::from(is_house(g, x, y));
    // rust: let direct =
    // rust: house(g, x + 1, y) + house(g, x - 1, y) + house(g, x, y + 1) + house(g, x, y - 1);
    // rust: if direct >= 3 {
    // rust: g.set(x, y, 2);
    // rust: touched = true;
    // rust: } else if direct == 2 {
    // rust: let diagonal = house(g, x + 1, y + 1)
    // rust: + house(g, x - 1, y + 1)
    // rust: + house(g, x + 1, y - 1)
    // rust: + house(g, x - 1, y - 1);
    // rust: if diagonal <= 1 {
    // rust: g.set(x, y, 2);
    // rust: touched = true;
}
}
}
}
    // rust: touched
}
pub fn identify_rooms(from: *Grid, rooms: *mut Grid, r: *mut impl RandomSource) void {
}
    // rust: let mut positions = Vec::new();
    // rust: for y in 0..from.height {
    // rust: for x in 0..from.width {
    // rust: if from.get(x, y) == 2 {
    // rust: positions.push((x, y));
}
}
}
    // rust: shuffle(&mut positions, r);
    // rust: let mut id = 10;
    // rust: for (x, y) in positions {
    // rust: if rooms.get(x, y) != 0 {
    // rust: continue;
}
    // rust: let (mut x0, mut x1, mut y0, mut y1) = (x, x, y, y);
    // rust: let mut kind = ROOM_1X1;
    // rust: let free =
    // rust: |dx: i32, dy: i32| rooms.get(x + dx, y + dy) == 0 && from.get(x + dx, y + dy) == 2;
    // rust: if free(1, 0) && free(0, 1) && free(1, 1) {
    // rust: x1 += 1;
    // rust: y1 += 1;
    // rust: kind = ROOM_2X2;
    // rust: } else if free(-1, 0) && free(0, 1) && free(-1, 1) {
    // rust: x0 -= 1;
    // rust: y1 += 1;
    // rust: kind = ROOM_2X2;
    // rust: } else if free(-1, 0) && free(0, -1) && free(-1, -1) {
    // rust: x0 -= 1;
    // rust: y0 -= 1;
    // rust: kind = ROOM_2X2;
    // rust: } else if free(1, 0) {
    // rust: x1 += 1;
    // rust: kind = ROOM_1X2;
    // rust: } else if free(0, 1) {
    // rust: y1 += 1;
    // rust: kind = ROOM_1X2;
    // rust: } else if free(-1, 0) {
    // rust: x0 -= 1;
    // rust: kind = ROOM_1X2;
    // rust: } else if free(0, -1) {
    // rust: y0 -= 1;
    // rust: kind = ROOM_1X2;
}
    // rust: let mut door_x = if r.next_boolean() { x0 } else { x1 };
    // rust: let mut door_y = if r.next_boolean() { y0 } else { y1 };
    // rust: let mut door = DOOR_FLAG;
    // rust: let swap = |v: i32, a: i32, b: i32| if v == a { b } else { a };
    // rust: if !from.edges_to(door_x, door_y, 1) {
    // rust: door_x = swap(door_x, x0, x1);
    // rust: door_y = swap(door_y, y0, y1);
    // rust: if !from.edges_to(door_x, door_y, 1) {
    // rust: door_y = swap(door_y, y0, y1);
    // rust: if !from.edges_to(door_x, door_y, 1) {
    // rust: door_x = swap(door_x, x0, x1);
    // rust: door_y = swap(door_y, y0, y1);
    // rust: if !from.edges_to(door_x, door_y, 1) {
    // rust: door = 0;
    // rust: door_x = x0;
    // rust: door_y = y0;
}
}
}
}
    // rust: for ry in y0..=y1 {
    // rust: for rx in x0..=x1 {
    // rust: if rx == door_x && ry == door_y {
    // rust: rooms.set(rx, ry, ORIGIN_FLAG | door | kind | id);
    // rust: } else {
    // rust: rooms.set(rx, ry, kind | id);
}
}
}
    // rust: id += 1;
}
}

pub const Piece = struct {
    name: []const u8,
    position: [i32,
    rotation: Rotation,
    mirror: Mirror,
};
pub const Placement = struct {
    position: [i32,
    rotation: Rotation,
    wall: *'static str,
};
pub fn up(p: [i32; 3], n: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [p[0], p[1] + n, p[2]]
}
pub fn rel(p: [i32; 3], rotation: Rotation, d: Direction, n: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: offset(p, rotation.rotate_direction(d), n)
}
/// One floor's room-template choices (First/Second/ThirdFloorRoomCollection).
pub fn room_name(floor: usize, kind: []const u8, r: *mut impl RandomSource, stairs: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut n = |b: i32| r.next_int_bound(b).unwrap_or(0) + 1;
    // rust: if floor == 0 {
    // rust: match kind {
    // rust: "1x1" => format!("1x1_a{}", n(5)),
    // rust: "1x1s" => format!("1x1_as{}", n(4)),
    // rust: "side" => format!("1x2_a{}", n(9)),
    // rust: "front" => format!("1x2_b{}", n(5)),
    // rust: "1x2s" => format!("1x2_s{}", n(2)),
    // rust: "2x2" => format!("2x2_a{}", n(4)),
    // rust: _ => "2x2_s1".into(),
}
    // rust: } else {
    // rust: match kind {
    // rust: "1x1" => format!("1x1_b{}", n(5)),
    // rust: "1x1s" => format!("1x1_as{}", n(4)),
    // rust: "side" if stairs => "1x2_c_stairs".into(),
    // rust: "side" => format!("1x2_c{}", n(4)),
    // rust: "front" if stairs => "1x2_d_stairs".into(),
    // rust: "front" => format!("1x2_d{}", n(5)),
    // rust: "1x2s" => format!("1x2_se{}", n(1)),
    // rust: "2x2" => format!("2x2_b{}", n(5)),
    // rust: _ => "2x2_s1".into(),
}
}
}
pub const Placer = struct {
    random: *'a mut R,
    pieces: std.ArrayList(Piece),
    start_x: i32,
    start_y: i32,
};
    // rust: impl<R: RandomSource> Placer<'_, R> {
    // rust: fn add(
    // rust: &mut self,
    // rust: name: impl Into<String>,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: mirror: Mirror,
    // rust: ) {
    // rust: self.pieces.push(Piece {
    // rust: name: name.into(),
    // rust: position,
    // rust: rotation,
    // rust: mirror,
    // rust: });
}
    // rust: fn grid_pos(
    // rust: &self,
    // rust: origin: [i32; 3],
    // rust: rotation: Rotation,
    // rust: x: i32,
    // rust: y: i32,
    // rust: east: i32,
    // rust: ) -> [i32; 3] {
    // rust: let p = rel(
    // rust: origin,
    // rust: rotation,
    // rust: Direction::South,
    // rust: 8 + (y - self.start_y) * 8,
    // rust: );
    // rust: rel(p, rotation, Direction::East, east + (x - self.start_x) * 8)
}
pub fn create(self: *Self, origin: [i32; 3], rotation: Rotation, mansion: *MansionGrid) void {
}
    // rust: let mut data = Placement {
    // rust: position: origin,
    // rust: rotation,
    // rust: wall: "wall_flat",
}
    // rust: let west = rotation.rotate_direction(Direction::West);
    // rust: self.add(
    // rust: "entrance",
    // rust: offset(data.position, west, 9),
    // rust: rotation,
    // rust: Mirror::None,
    // rust: );
    // rust: data.position = rel(data.position, rotation, Direction::South, 16);
    // rust: let mut second = Placement {
    // rust: position: up(data.position, 8),
    // rust: rotation: data.rotation,
    // rust: wall: "wall_window",
}
    // rust: let (base, third) = (&mansion.base, &mansion.third);
    // rust: self.start_x = mansion.entrance_x + 1;
    // rust: self.start_y = mansion.entrance_y + 1;
    // rust: let (end_x, end_y) = (mansion.entrance_x + 1, mansion.entrance_y);
    // rust: let (sx, sy) = (self.start_x, self.start_y);
    // rust: self.outer_walls(&mut data, base, Direction::South, sx, sy, end_x, end_y);
    // rust: self.outer_walls(&mut second, base, Direction::South, sx, sy, end_x, end_y);
    // rust: let mut third_data = Placement {
    // rust: position: up(data.position, 19),
    // rust: rotation: data.rotation,
    // rust: wall: "wall_window",
}
    // rust: 'done: for y in 0..third.height {
    // rust: for x in (0..third.width).rev() {
    // rust: if is_house(third, x, y) {
    // rust: third_data.position = self.grid_pos(third_data.position, rotation, x, y, 0);
    // rust: self.wall_piece(&mut third_data);
    // rust: self.outer_walls(&mut third_data, third, Direction::South, x, y, x, y);
    // rust: break 'done;
}
}
}
    // rust: self.roof(up(origin, 16), rotation, base, Some(third));
    // rust: self.roof(up(origin, 27), rotation, third, None);
    // rust: for floor in 0..3 {
    // rust: let floor_origin = up(origin, 8 * floor as i32 + if floor == 2 { 3 } else { 0 });
    // rust: let rooms = &mansion.rooms[floor];
    // rust: let grid = if floor == 2 { third } else { base };
    // rust: let south_piece = if floor == 0 {
    // rust: "carpet_south_1"
    // rust: } else {
    // rust: "carpet_south_2"
}
    // rust: let west_piece = if floor == 0 {
    // rust: "carpet_west_1"
    // rust: } else {
    // rust: "carpet_west_2"
}
    // rust: let corridor =
    // rust: |x, y| grid.get(x, y) == 1 || rooms.get(x, y) & CORRIDOR_FLAG == CORRIDOR_FLAG;
    // rust: for y in 0..grid.height {
    // rust: for x in 0..grid.width {
    // rust: if grid.get(x, y) != 1 {
    // rust: continue;
}
    // rust: let pos = self.grid_pos(floor_origin, rotation, x, y, 0);
    // rust: self.add("corridor_floor", pos, rotation, Mirror::None);
    // rust: if corridor(x, y - 1) {
    // rust: let p = up(rel(pos, rotation, Direction::East, 1), 1);
    // rust: self.add("carpet_north", p, rotation, Mirror::None);
}
    // rust: if corridor(x + 1, y) {
    // rust: let p = rel(pos, rotation, Direction::South, 1);
    // rust: let p = up(rel(p, rotation, Direction::East, 5), 1);
    // rust: self.add("carpet_east", p, rotation, Mirror::None);
}
    // rust: if corridor(x, y + 1) {
    // rust: let p = rel(pos, rotation, Direction::South, 5);
    // rust: let p = rel(p, rotation, Direction::West, 1);
    // rust: self.add(south_piece, p, rotation, Mirror::None);
}
    // rust: if corridor(x - 1, y) {
    // rust: let p = rel(pos, rotation, Direction::West, 1);
    // rust: let p = rel(p, rotation, Direction::North, 1);
    // rust: self.add(west_piece, p, rotation, Mirror::None);
}
}
}
    // rust: let wall = if floor == 0 {
    // rust: "indoors_wall_1"
    // rust: } else {
    // rust: "indoors_wall_2"
}
    // rust: let door = if floor == 0 {
    // rust: "indoors_door_1"
    // rust: } else {
    // rust: "indoors_door_2"
}
    // rust: for y in 0..grid.height {
    // rust: for x in 0..grid.width {
    // rust: let mut third_start = floor == 2 && grid.get(x, y) == 3;
    // rust: if grid.get(x, y) != 2 && !third_start {
    // rust: continue;
}
    // rust: let data = rooms.get(x, y);
    // rust: let kind = data & TYPE_MASK;
    // rust: let id = data & ID_MASK;
    // rust: third_start = third_start && data & CORRIDOR_FLAG == CORRIDOR_FLAG;
    // rust: let mut doors = Vec::new();
    // rust: if data & DOOR_FLAG == DOOR_FLAG {
    // rust: for d in HORIZONTAL {
    // rust: let (dx, dz) = step(d);
    // rust: if grid.get(x + dx, y + dz) == 1 {
    // rust: doors.push(d);
}
}
}
    // rust: let door_dir = if !doors.is_empty() {
    // rust: Some(
    // rust: doors[self.random.next_int_bound(doors.len() as i32).unwrap_or(0)
    // rust: as usize],
    // rust: )
    // rust: } else if data & ORIGIN_FLAG == ORIGIN_FLAG {
    // rust: Some(Direction::Up)
    // rust: } else {
    // rust: None
}
    // rust: let room_pos = self.grid_pos(floor_origin, rotation, x, y, -1);
    // rust: let pick = |d: Direction| if door_dir == Some(d) { door } else { wall };
    // rust: if is_house(grid, x - 1, y) && !mansion.is_room_id(x - 1, y, floor, id) {
    // rust: self.add(pick(Direction::West), room_pos, rotation, Mirror::None);
}
    // rust: if grid.get(x + 1, y) == 1 && !third_start {
    // rust: let p = rel(room_pos, rotation, Direction::East, 8);
    // rust: self.add(pick(Direction::East), p, rotation, Mirror::None);
}
    // rust: let cw90 = rotation.get_rotated(Rotation::Clockwise90);
    // rust: if is_house(grid, x, y + 1) && !mansion.is_room_id(x, y + 1, floor, id) {
    // rust: let p = rel(room_pos, rotation, Direction::South, 7);
    // rust: let p = rel(p, rotation, Direction::East, 7);
    // rust: self.add(pick(Direction::South), p, cw90, Mirror::None);
}
    // rust: if grid.get(x, y - 1) == 1 && !third_start {
    // rust: let p = rel(room_pos, rotation, Direction::North, 1);
    // rust: let p = rel(p, rotation, Direction::East, 7);
    // rust: self.add(pick(Direction::North), p, cw90, Mirror::None);
}
    // rust: if kind == ROOM_1X1 {
    // rust: self.room_1x1(room_pos, rotation, door_dir, floor);
    // rust: } else if kind == ROOM_1X2 && door_dir.is_some() {
    // rust: let room_dir = mansion.room_direction_1x2(x, y, floor, id);
    // rust: let stairs = data & STAIRS_FLAG == STAIRS_FLAG;
    // rust: if let (Some(room_dir), Some(door_dir)) = (room_dir, door_dir) {
    // rust: self.room_1x2(room_pos, rotation, room_dir, door_dir, floor, stairs);
}
    // rust: } else if kind == ROOM_2X2 && door_dir.is_some_and(|d| d != Direction::Up) {
    // rust: let door_dir = door_dir.unwrap();
    // rust: let mut room_dir = clockwise(door_dir);
    // rust: let (dx, dz) = step(room_dir);
    // rust: if !mansion.is_room_id(x + dx, y + dz, floor, id) {
    // rust: room_dir = opposite(room_dir);
}
    // rust: self.room_2x2(room_pos, rotation, room_dir, door_dir, floor);
    // rust: } else if kind == ROOM_2X2 && door_dir == Some(Direction::Up) {
    // rust: let name = room_name(floor, "2x2s", self.random, false);
    // rust: let p = rel(room_pos, rotation, Direction::East, 1);
    // rust: self.add(name, p, rotation, Mirror::None);
}
}
}
}
}
    // rust: fn outer_walls(
    // rust: &mut self,
    // rust: data: &mut Placement,
    // rust: grid: &Grid,
    // rust: direction: Direction,
    // rust: start_x: i32,
    // rust: start_y: i32,
    // rust: end_x: i32,
    // rust: end_y: i32,
    // rust: ) {
    // rust: let (mut gx, mut gy, mut dir) = (start_x, start_y, direction);
    // rust: let start_dir = direction;
    // rust: loop {
    // rust: let (dx, dz) = step(dir);
    // rust: let (cx, cz) = step(counter_clockwise(dir));
    // rust: let inner_corner = is_house(grid, gx + dx + cx, gy + dz + cz);
    // rust: if !is_house(grid, gx + dx, gy + dz) {
    // rust: data.position = rel(data.position, data.rotation, Direction::South, -1);
    // rust: self.add("wall_corner", data.position, data.rotation, Mirror::None);
    // rust: data.position = rel(data.position, data.rotation, Direction::South, -7);
    // rust: data.position = rel(data.position, data.rotation, Direction::West, -6);
    // rust: data.rotation = data.rotation.get_rotated(Rotation::Clockwise90);
    // rust: dir = clockwise(dir);
    // rust: if gx != end_x || gy != end_y || start_dir != dir {
    // rust: self.wall_piece(data);
}
    // rust: } else if inner_corner {
    // rust: data.position = rel(data.position, data.rotation, Direction::South, 6);
    // rust: data.position = rel(data.position, data.rotation, Direction::East, 8);
    // rust: data.rotation = data.rotation.get_rotated(Rotation::Counterclockwise90);
    // rust: gx += dx;
    // rust: gy += dz;
    // rust: dir = counter_clockwise(dir);
    // rust: } else {
    // rust: gx += dx;
    // rust: gy += dz;
    // rust: if gx != end_x || gy != end_y || start_dir != dir {
    // rust: self.wall_piece(data);
}
}
    // rust: if gx == end_x && gy == end_y && start_dir == dir {
    // rust: break;
}
}
}
pub fn wall_piece(self: *Self, data: *mut Placement) void {
}
    // rust: let p = rel(data.position, data.rotation, Direction::East, 7);
    // rust: self.add(data.wall, p, data.rotation, Mirror::None);
    // rust: data.position = rel(data.position, data.rotation, Direction::South, 8);
}
pub fn roof(self: *Self, origin: [i32; 3], rotation: Rotation, grid: *Grid, above: ?*Grid) void {
}
//         use Direction::{East, North, South, West};
    // rust: let r = |rot: Rotation| rotation.get_rotated(rot);
    // rust: let (cw90, cw180, ccw90) = (
    // rust: r(Rotation::Clockwise90),
    // rust: r(Rotation::Clockwise180),
    // rust: r(Rotation::Counterclockwise90),
    // rust: );
    // rust: let none = Mirror::None;
    // rust: for y in 0..grid.height {
    // rust: for x in 0..grid.width {
    // rust: let pos = self.grid_pos(origin, rotation, x, y, 0);
    // rust: let is_above = above.is_some_and(|a| is_house(a, x, y));
    // rust: if !is_house(grid, x, y) || is_above {
    // rust: continue;
}
    // rust: self.add("roof", up(pos, 3), rotation, none);
    // rust: if !is_house(grid, x + 1, y) {
    // rust: self.add("roof_front", rel(pos, rotation, East, 6), rotation, none);
}
    // rust: if !is_house(grid, x - 1, y) {
    // rust: let p = rel(rel(pos, rotation, East, 0), rotation, South, 7);
    // rust: self.add("roof_front", p, cw180, none);
}
    // rust: if !is_house(grid, x, y - 1) {
    // rust: self.add("roof_front", rel(pos, rotation, West, 1), ccw90, none);
}
    // rust: if !is_house(grid, x, y + 1) {
    // rust: let p = rel(rel(pos, rotation, East, 6), rotation, South, 6);
    // rust: self.add("roof_front", p, cw90, none);
}
}
}
    // rust: if let Some(above) = above {
    // rust: for y in 0..grid.height {
    // rust: for x in 0..grid.width {
    // rust: let pos = self.grid_pos(origin, rotation, x, y, 0);
    // rust: if !(is_house(grid, x, y) && is_house(above, x, y)) {
    // rust: continue;
}
    // rust: if !is_house(grid, x + 1, y) {
    // rust: self.add("small_wall", rel(pos, rotation, East, 7), rotation, none);
}
    // rust: if !is_house(grid, x - 1, y) {
    // rust: let p = rel(rel(pos, rotation, West, 1), rotation, South, 6);
    // rust: self.add("small_wall", p, cw180, none);
}
    // rust: if !is_house(grid, x, y - 1) {
    // rust: let p = rel(rel(pos, rotation, West, 0), rotation, North, 1);
    // rust: self.add("small_wall", p, ccw90, none);
}
    // rust: if !is_house(grid, x, y + 1) {
    // rust: let p = rel(rel(pos, rotation, East, 6), rotation, South, 7);
    // rust: self.add("small_wall", p, cw90, none);
}
    // rust: if !is_house(grid, x + 1, y) {
    // rust: if !is_house(grid, x, y - 1) {
    // rust: let p = rel(rel(pos, rotation, East, 7), rotation, North, 2);
    // rust: self.add("small_wall_corner", p, rotation, none);
}
    // rust: if !is_house(grid, x, y + 1) {
    // rust: let p = rel(rel(pos, rotation, East, 8), rotation, South, 7);
    // rust: self.add("small_wall_corner", p, cw90, none);
}
}
    // rust: if !is_house(grid, x - 1, y) {
    // rust: if !is_house(grid, x, y - 1) {
    // rust: let p = rel(rel(pos, rotation, West, 2), rotation, North, 1);
    // rust: self.add("small_wall_corner", p, ccw90, none);
}
    // rust: if !is_house(grid, x, y + 1) {
    // rust: let p = rel(rel(pos, rotation, West, 1), rotation, South, 8);
    // rust: self.add("small_wall_corner", p, cw180, none);
}
}
}
}
}
    // rust: for y in 0..grid.height {
    // rust: for x in 0..grid.width {
    // rust: let pos = self.grid_pos(origin, rotation, x, y, 0);
    // rust: let is_above = above.is_some_and(|a| is_house(a, x, y));
    // rust: if !is_house(grid, x, y) || is_above {
    // rust: continue;
}
    // rust: if !is_house(grid, x + 1, y) {
    // rust: let p2 = rel(pos, rotation, East, 6);
    // rust: if !is_house(grid, x, y + 1) {
    // rust: self.add("roof_corner", rel(p2, rotation, South, 6), rotation, none);
    // rust: } else if is_house(grid, x + 1, y + 1) {
    // rust: self.add(
    // rust: "roof_inner_corner",
    // rust: rel(p2, rotation, South, 5),
    // rust: rotation,
    // rust: none,
    // rust: );
}
    // rust: if !is_house(grid, x, y - 1) {
    // rust: self.add("roof_corner", p2, ccw90, none);
    // rust: } else if is_house(grid, x + 1, y - 1) {
    // rust: let p3 = rel(rel(pos, rotation, East, 9), rotation, North, 2);
    // rust: self.add("roof_inner_corner", p3, cw90, none);
}
}
    // rust: if !is_house(grid, x - 1, y) {
    // rust: let p2 = rel(rel(pos, rotation, East, 0), rotation, South, 0);
    // rust: if !is_house(grid, x, y + 1) {
    // rust: self.add("roof_corner", rel(p2, rotation, South, 6), cw90, none);
    // rust: } else if is_house(grid, x - 1, y + 1) {
    // rust: let p3 = rel(rel(p2, rotation, South, 8), rotation, West, 3);
    // rust: self.add("roof_inner_corner", p3, ccw90, none);
}
    // rust: if !is_house(grid, x, y - 1) {
    // rust: self.add("roof_corner", p2, cw180, none);
    // rust: } else if is_house(grid, x - 1, y - 1) {
    // rust: self.add(
    // rust: "roof_inner_corner",
    // rust: rel(p2, rotation, South, 1),
    // rust: cw180,
    // rust: none,
    // rust: );
}
}
}
}
}
    // rust: fn room_1x1(
    // rust: &mut self,
    // rust: room_pos: [i32; 3],
    // rust: rotation: Rotation,
    // rust: door: Option<Direction>,
    // rust: floor: usize,
    // rust: ) {
    // rust: let mut piece_rot = Rotation::None;
    // rust: let mut name = room_name(floor, "1x1", self.random, false);
    // rust: if door != Some(Direction::East) {
    // rust: match door {
    // rust: Some(Direction::North) => piece_rot = Rotation::Counterclockwise90,
    // rust: Some(Direction::West) => piece_rot = Rotation::Clockwise180,
    // rust: Some(Direction::South) => piece_rot = Rotation::Clockwise90,
    // rust: _ => name = room_name(floor, "1x1s", self.random, false),
}
}
    // rust: let o = match piece_rot {
    // rust: Rotation::Counterclockwise90 => [1, 0, 6],
    // rust: Rotation::Clockwise90 => [7, 0, 0],
    // rust: Rotation::Clockwise180 => [7, 0, 6],
    // rust: Rotation::None => [1, 0, 0],
}
    // rust: let piece_rot = piece_rot.get_rotated(rotation);
    // rust: let o = match rotation {
    // rust: Rotation::Clockwise90 => [-o[2], o[1], o[0]],
    // rust: Rotation::Clockwise180 => [-o[0], o[1], -o[2]],
    // rust: Rotation::Counterclockwise90 => [o[2], o[1], -o[0]],
    // rust: Rotation::None => o,
}
    // rust: let pos = [room_pos[0] + o[0], room_pos[1], room_pos[2] + o[2]];
    // rust: self.add(name, pos, piece_rot, Mirror::None);
}
    // rust: fn room_1x2(
    // rust: &mut self,
    // rust: room_pos: [i32; 3],
    // rust: rotation: Rotation,
    // rust: room: Direction,
    // rust: door: Direction,
    // rust: floor: usize,
    // rust: stairs: bool,
    // rust: ) {
//         use Direction::{East, North, South, Up, West};
    // rust: let r = |rot: Rotation| rotation.get_rotated(rot);
    // rust: let at = |east: i32, south: i32| {
    // rust: rel(rel(room_pos, rotation, East, east), rotation, South, south)
}
    // rust: let (kind, pos, rot, mirror) = match (door, room) {
    // rust: (East, South) => ("side", at(1, 0), rotation, Mirror::None),
    // rust: (East, North) => ("side", at(1, 6), rotation, Mirror::LeftRight),
    // rust: (West, North) => ("side", at(7, 6), r(Rotation::Clockwise180), Mirror::None),
    // rust: (West, South) => ("side", at(7, 0), rotation, Mirror::FrontBack),
    // rust: (South, East) => (
    // rust: "side",
    // rust: at(1, 0),
    // rust: r(Rotation::Clockwise90),
    // rust: Mirror::LeftRight,
    // rust: ),
    // rust: (South, West) => ("side", at(7, 0), r(Rotation::Clockwise90), Mirror::None),
    // rust: (North, West) => (
    // rust: "side",
    // rust: at(7, 6),
    // rust: r(Rotation::Clockwise90),
    // rust: Mirror::FrontBack,
    // rust: ),
    // rust: (North, East) => (
    // rust: "side",
    // rust: at(1, 6),
    // rust: r(Rotation::Counterclockwise90),
    // rust: Mirror::None,
    // rust: ),
    // rust: (South, North) => ("front", at(1, -8), rotation, Mirror::None),
    // rust: (North, South) => ("front", at(7, 14), r(Rotation::Clockwise180), Mirror::None),
    // rust: (West, East) => ("front", at(15, 0), r(Rotation::Clockwise90), Mirror::None),
    // rust: (East, West) => (
    // rust: "front",
    // rust: at(-7, 6),
    // rust: r(Rotation::Counterclockwise90),
    // rust: Mirror::None,
    // rust: ),
    // rust: (Up, East) => ("1x2s", at(15, 0), r(Rotation::Clockwise90), Mirror::None),
    // rust: (Up, South) => ("1x2s", at(1, 0), rotation, Mirror::None),
    // rust: _ => return,
}
    // rust: let name = room_name(floor, kind, self.random, stairs);
    // rust: self.add(name, pos, rot, mirror);
}
    // rust: fn room_2x2(
    // rust: &mut self,
    // rust: room_pos: [i32; 3],
    // rust: rotation: Rotation,
    // rust: room: Direction,
    // rust: door: Direction,
    // rust: floor: usize,
    // rust: ) {
//         use Direction::{East, North, South, West};
    // rust: let r = |rot: Rotation| rotation.get_rotated(rot);
    // rust: let (east, south, rot, mirror) = match (door, room) {
    // rust: (East, South) => (-7, 0, rotation, Mirror::None),
    // rust: (East, North) => (-7, 6, rotation, Mirror::LeftRight),
    // rust: (North, East) => (1, 14, r(Rotation::Counterclockwise90), Mirror::None),
    // rust: (North, West) => (7, 14, r(Rotation::Counterclockwise90), Mirror::LeftRight),
    // rust: (South, West) => (7, -8, r(Rotation::Clockwise90), Mirror::None),
    // rust: (South, East) => (1, -8, r(Rotation::Clockwise90), Mirror::LeftRight),
    // rust: (West, North) => (15, 6, r(Rotation::Clockwise180), Mirror::None),
    // rust: (West, South) => (15, 0, rotation, Mirror::FrontBack),
    // rust: _ => (0, 0, rotation, Mirror::None),
}
    // rust: let pos = rel(rel(room_pos, rotation, East, east), rotation, South, south);
    // rust: let name = room_name(floor, "2x2", self.random, false);
    // rust: self.add(name, pos, rot, mirror);
}
}

/// WoodlandMansionPieces.generateMansion.
    // rust: pub fn pieces(
    // rust: resources: &StructureResources,
    // rust: origin: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<Vec<TemplatePiece>> {
    // rust: let grid = MansionGrid::new(random);
    // rust: let mut placer = Placer {
    // rust: random,
    // rust: pieces: Vec::new(),
    // rust: start_x: 0,
    // rust: start_y: 0,
}
    // rust: placer.create(origin, rotation, &grid);
    // rust: let processors = Arc::new(ProcessorList::default());
    // rust: placer
    // rust: .pieces
    // rust: .into_iter()
    // rust: .map(|p| {
    // rust: let name = format!("minecraft:woodland_mansion/{}", p.name);
    // rust: Some(TemplatePiece::new(
    // rust: "minecraft:wmp",
    // rust: &name,
    // rust: resources.template(&name)?,
    // rust: p.position,
    // rust: p.rotation,
    // rust: p.mirror,
    // rust: [0; 3],
    // rust: processors.clone(),
    // rust: true,
    // rust: vec!["minecraft:structure_block".into()],
    // rust: TemplateHandler::Mansion,
    // rust: ))
    // rust: })
    // rust: .collect()
}

/// WoodlandMansionPiece.postProcess with its data markers.
pub fn post_process(piece: *TemplatePiece, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(markers) = piece.place_at(c, piece.position, &[])? else {
    // rust: return Ok(());
}
    // rust: for (marker, pos) in markers {
    // rust: if marker.starts_with("Chest") {
    // rust: let facing = match marker.as_str() {
    // rust: "ChestWest" => Direction::West,
    // rust: "ChestEast" => Direction::East,
    // rust: "ChestSouth" => Direction::South,
    // rust: _ => Direction::North,
}
    // rust: let facing = if marker == "Chest" {
    // rust: Direction::North
    // rust: } else {
    // rust: piece.rotation.rotate_direction(facing)
}
    // rust: let state = c.state_with("chest", &[("facing", direction_name(facing))]);
    // rust: create_chest(c, pos, "minecraft:chests/woodland_mansion", Some(state))?;
    // rust: } else if matches!(marker.as_str(), "Mage" | "Warrior" | "Group of Allays") {
    // rust: let (id, count) = match marker.as_str() {
    // rust: "Mage" => ("minecraft:evoker", 1),
    // rust: "Warrior" => ("minecraft:vindicator", 1),
    // rust: _ => ("minecraft:allay", c.world.level_int(3)? + 1),
}
    // rust: for _ in 0..count {
    // rust: c.world
    // rust: .entity(super::legacy::spawn_nbt(id, pos, true, true))?;
}
    // rust: c.world.set(pos, c.state("air"), 2)?;
}
}
    // rust: Ok(())
}

/// WoodlandMansionStructure.afterPlace: cobblestone columns under the pieces.
pub fn after_place(c: *mut PieceContext<'_>, boxes: *[BoundingBox]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min_y = c.world.min_y()?;
    // rust: let bb = super::temple::union(boxes);
    // rust: let y_start = bb.min[1];
    // rust: let cobble = c.state("cobblestone");
    // rust: for x in c.chunk_box.min[0]..=c.chunk_box.max[0] {
    // rust: for z in c.chunk_box.min[2]..=c.chunk_box.max[2] {
    // rust: let pos = [x, y_start, z];
    // rust: let state = c.world.block(pos)?;
    // rust: if c.is_air(state) || !bb.is_inside(pos) || !boxes.iter().any(|b| b.is_inside(pos)) {
    // rust: continue;
}
    // rust: let mut y = y_start - 1;
    // rust: while y > min_y {
    // rust: let state = c.world.block([x, y, z])?;
    // rust: if !c.is_air(state) && !c.is_liquid(state) {
    // rust: break;
}
    // rust: c.world.set([x, y, z], cobble, 2)?;
    // rust: y -= 1;
}
}
}
    // rust: Ok(())
}
