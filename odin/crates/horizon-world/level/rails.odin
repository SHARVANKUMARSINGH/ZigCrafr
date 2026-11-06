//! Transpiled from Horizon Rust crate
package horizon_world_rails

import "core:fmt"
import "core:mem"
import "core:math"

// Rails (`BaseRailBlock`, `RailState`, powered/activator rails) and
// tripwires (`TripWireBlock`, `TripWireHookBlock`).
// use super::{
    // rust: LevelAccess, LevelEvent, Sim,
    // rust: classes::Class,
    // rust: states::BlockId,
    // rust: update::{above, below, rel},
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

RailShape :: enum {
    NorthSouth,
    EastWest,
    AscendingEast,
    AscendingWest,
    AscendingNorth,
    AscendingSouth,
    SouthEast,
    SouthWest,
    NorthWest,
    NorthEast,
}
    // rust: impl RailShape {
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match text {
    // rust: "east_west" => Self::EastWest,
    // rust: "ascending_east" => Self::AscendingEast,
    // rust: "ascending_west" => Self::AscendingWest,
    // rust: "ascending_north" => Self::AscendingNorth,
    // rust: "ascending_south" => Self::AscendingSouth,
    // rust: "south_east" => Self::SouthEast,
    // rust: "south_west" => Self::SouthWest,
    // rust: "north_west" => Self::NorthWest,
    // rust: "north_east" => Self::NorthEast,
    // rust: _ => Self::NorthSouth,
}
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::NorthSouth => "north_south",
    // rust: Self::EastWest => "east_west",
    // rust: Self::AscendingEast => "ascending_east",
    // rust: Self::AscendingWest => "ascending_west",
    // rust: Self::AscendingNorth => "ascending_north",
    // rust: Self::AscendingSouth => "ascending_south",
    // rust: Self::SouthEast => "south_east",
    // rust: Self::SouthWest => "south_west",
    // rust: Self::NorthWest => "north_west",
    // rust: Self::NorthEast => "north_east",
}
}
is_slope :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: Self::AscendingEast | Self::AscendingWest | Self::AscendingNorth | Self::AscendingSouth
    // rust: )
}
}

// `RailState`.
Rail :: struct {
    pos: BlockPos,
    state: BlockStateId,
    straight: bool,
    connections: [dynamic]BlockPos,
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // rust: pub(crate) fn rail_shape(&self, state: BlockStateId) -> &str {
    // rust: self.b.table.text(state, self.b.props.shape)
}
is_rail :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.in_set(state, &self.b.tags.rails) && self.b.instance_of(state, Class::BaseRail)
}
is_rail_at :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_rail(self.state(pos))
}
rail_connections :: proc(pos: BlockPos, shape: RailShape) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (n, s, w, e) = (
    // rust: rel(pos, Direction::North),
    // rust: rel(pos, Direction::South),
    // rust: rel(pos, Direction::West),
    // rust: rel(pos, Direction::East),
    // rust: );
    // rust: match shape {
    // rust: RailShape::NorthSouth => vec![n, s],
    // rust: RailShape::EastWest => vec![w, e],
    // rust: RailShape::AscendingEast => vec![w, above(e)],
    // rust: RailShape::AscendingWest => vec![above(w), e],
    // rust: RailShape::AscendingNorth => vec![above(n), s],
    // rust: RailShape::AscendingSouth => vec![n, above(s)],
    // rust: RailShape::SouthEast => vec![e, s],
    // rust: RailShape::SouthWest => vec![w, s],
    // rust: RailShape::NorthWest => vec![w, n],
    // rust: RailShape::NorthEast => vec![e, n],
}
}
rail_new :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let shape = RailShape::parse(self.rail_shape(state));
    // rust: Rail {
    // rust: pos,
    // rust: state,
    // rust: straight: !self.b.data(state).is(Class::Rail),
    // rust: connections: Self::rail_connections(pos, shape),
}
}
rail_get :: proc(self: ^Self, pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: for test in [pos, above(pos), below(pos)] {
    // rust: let state = self.state(test);
    // rust: if self.is_rail(state) {
    // rust: return Some(self.rail_new(test, state));
}
}
    // rust: None
}
rail_has_connection :: proc(rail: ^Rail, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: rail.connections
    // rust: .iter()
    // rust: .any(|c| c.x == pos.x && c.z == pos.z)
}
rail_remove_soft_connections :: proc(self: ^Self, rail: ^Rail) {
}
    // rust: let mut i = 0;
    // rust: while i < rail.connections.len() {
    // rust: match self.rail_get(rail.connections[i]) {
    // rust: Some(other) if Self::rail_has_connection(&other, rail.pos) => {
    // rust: rail.connections[i] = other.pos;
    // rust: i += 1;
}
    // rust: _ => {
    // rust: rail.connections.remove(i);
}
}
}
}
rail_can_connect_to :: proc(rail: ^Rail, other: ^Rail) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Self::rail_has_connection(rail, other.pos) || rail.connections.len() != 2
}
rail_has_neighbor_rail :: proc(self: ^Self, rail: ^Rail, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.rail_get(pos) {
    // rust: Some(mut neighbour) => {
    // rust: self.rail_remove_soft_connections(&mut neighbour);
    // rust: Self::rail_can_connect_to(&neighbour, rail)
}
    // rust: None => false,
}
}
rail_count_potential_connections :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: super::update::HORIZONTAL
    // rust: .into_iter()
    // rust: .filter(|d| {
    // rust: let p = rel(pos, *d);
    // rust: self.is_rail_at(p) || self.is_rail_at(above(p)) || self.is_rail_at(below(p))
    // rust: })
    // rust: .count() as i32
}
rail_slopes :: proc(self: ^Self, pos: BlockPos, shape: Maybe(RailShape)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (n, s, w, e) = (
    // rust: rel(pos, Direction::North),
    // rust: rel(pos, Direction::South),
    // rust: rel(pos, Direction::West),
    // rust: rel(pos, Direction::East),
    // rust: );
    // rust: let mut shape = shape;
    // rust: if shape == Some(RailShape::NorthSouth) {
    // rust: if self.is_rail_at(above(n)) {
    // rust: shape = Some(RailShape::AscendingNorth);
}
    // rust: if self.is_rail_at(above(s)) {
    // rust: shape = Some(RailShape::AscendingSouth);
}
}
    // rust: if shape == Some(RailShape::EastWest) {
    // rust: if self.is_rail_at(above(e)) {
    // rust: shape = Some(RailShape::AscendingEast);
}
    // rust: if self.is_rail_at(above(w)) {
    // rust: shape = Some(RailShape::AscendingWest);
}
}
    // rust: shape
}
rail_set_shape :: proc(self: ^Self, state: BlockStateId, shape: RailShape) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.b
    // rust: .table
    // rust: .set_text(state, self.b.props.shape, shape.name())
}
rail_connect_to :: proc(self: ^Self, rail: ^Rail, other_pos: BlockPos) {
}
    // rust: rail.connections.push(other_pos);
    // rust: let pos = rail.pos;
    // rust: let n = Self::rail_has_connection(rail, rel(pos, Direction::North));
    // rust: let s = Self::rail_has_connection(rail, rel(pos, Direction::South));
    // rust: let w = Self::rail_has_connection(rail, rel(pos, Direction::West));
    // rust: let e = Self::rail_has_connection(rail, rel(pos, Direction::East));
    // rust: let mut shape = None;
    // rust: if n || s {
    // rust: shape = Some(RailShape::NorthSouth);
}
    // rust: if w || e {
    // rust: shape = Some(RailShape::EastWest);
}
    // rust: if !rail.straight {
    // rust: if s && e && !n && !w {
    // rust: shape = Some(RailShape::SouthEast);
}
    // rust: if s && w && !n && !e {
    // rust: shape = Some(RailShape::SouthWest);
}
    // rust: if n && w && !s && !e {
    // rust: shape = Some(RailShape::NorthWest);
}
    // rust: if n && e && !s && !w {
    // rust: shape = Some(RailShape::NorthEast);
}
}
    // rust: let shape = self
    // rust: .rail_slopes(pos, shape)
    // rust: .unwrap_or(RailShape::NorthSouth);
    // rust: rail.state = self.rail_set_shape(rail.state, shape);
    // rust: self.set_block_and_update(pos, rail.state);
}
    // `RailState.place`; returns the resulting state.
    // rust: fn rail_place(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: has_signal: bool,
    // rust: first: bool,
    // rust: default: RailShape,
    // rust: ) -> BlockStateId {
    // rust: let mut rail = self.rail_new(pos, state);
    // rust: let n = self.rail_has_neighbor_rail(&rail, rel(pos, Direction::North));
    // rust: let s = self.rail_has_neighbor_rail(&rail, rel(pos, Direction::South));
    // rust: let w = self.rail_has_neighbor_rail(&rail, rel(pos, Direction::West));
    // rust: let e = self.rail_has_neighbor_rail(&rail, rel(pos, Direction::East));
    // rust: let mut shape = None;
    // rust: let ns = n || s;
    // rust: let we = w || e;
    // rust: if ns && !we {
    // rust: shape = Some(RailShape::NorthSouth);
}
    // rust: if we && !ns {
    // rust: shape = Some(RailShape::EastWest);
}
    // rust: let (se, sw, ne, nw) = (s && e, s && w, n && e, n && w);
    // rust: if !rail.straight {
    // rust: if se && !n && !w {
    // rust: shape = Some(RailShape::SouthEast);
}
    // rust: if sw && !n && !e {
    // rust: shape = Some(RailShape::SouthWest);
}
    // rust: if nw && !s && !e {
    // rust: shape = Some(RailShape::NorthWest);
}
    // rust: if ne && !s && !w {
    // rust: shape = Some(RailShape::NorthEast);
}
}
    // rust: if shape.is_none() {
    // rust: if ns && we {
    // rust: shape = Some(default);
    // rust: } else if ns {
    // rust: shape = Some(RailShape::NorthSouth);
    // rust: } else if we {
    // rust: shape = Some(RailShape::EastWest);
}
    // rust: if !rail.straight {
    // rust: if has_signal {
    // rust: for (cond, s) in [
    // rust: (se, RailShape::SouthEast),
    // rust: (sw, RailShape::SouthWest),
    // rust: (ne, RailShape::NorthEast),
    // rust: (nw, RailShape::NorthWest),
    // rust: ] {
    // rust: if cond {
    // rust: shape = Some(s);
}
}
    // rust: } else {
    // rust: for (cond, s) in [
    // rust: (nw, RailShape::NorthWest),
    // rust: (ne, RailShape::NorthEast),
    // rust: (sw, RailShape::SouthWest),
    // rust: (se, RailShape::SouthEast),
    // rust: ] {
    // rust: if cond {
    // rust: shape = Some(s);
}
}
}
}
}
    // rust: let shape = self.rail_slopes(pos, shape).unwrap_or(default);
    // rust: rail.connections = Self::rail_connections(pos, shape);
    // rust: rail.state = self.rail_set_shape(rail.state, shape);
    // rust: if first || self.state(pos) != rail.state {
    // rust: self.set_block_and_update(pos, rail.state);
    // rust: for i in 0..rail.connections.len() {
    // rust: if let Some(mut neighbour) = self.rail_get(rail.connections[i]) {
    // rust: self.rail_remove_soft_connections(&mut neighbour);
    // rust: if Self::rail_can_connect_to(&neighbour, &rail) {
    // rust: self.rail_connect_to(&mut neighbour, rail.pos);
}
}
}
}
    // rust: rail.state
}
rail_update_dir :: proc(self: ^Self, pos: BlockPos, state: BlockStateId, first: bool) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let current = RailShape::parse(self.rail_shape(state));
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: self.rail_place(pos, state, signal, first, current)
}
    // `BaseRailBlock.updateState(state, level, pos, movedByPiston)`.
    // rust: pub(crate) fn rail_update_state(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: moved: bool,
    // rust: ) -> BlockStateId {
    // rust: let state = self.rail_update_dir(pos, state, true);
    // rust: if !self.b.data(state).is(Class::Rail) {
    // rust: let block = self.b.block(state);
    // rust: self.neighbor_changed_full(state, pos, block, moved);
}
    // rust: state
}
    // rust: pub(crate) fn rail_neighbor_changed(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: changed: BlockId,
    // rust: moved: bool,
    // rust: ) {
    // rust: let b = self.b;
    // rust: if !b.is_block(self.state(pos), b.block(state)) {
    // rust: return;
}
    // rust: let shape = RailShape::parse(self.rail_shape(state));
    // rust: let support = |sim: &Self, p: BlockPos| sim.can_support_rigid_block(p);
    // rust: let remove = !support(self, below(pos))
    // rust: || match shape {
    // rust: RailShape::AscendingEast => !support(self, rel(pos, Direction::East)),
    // rust: RailShape::AscendingWest => !support(self, rel(pos, Direction::West)),
    // rust: RailShape::AscendingNorth => !support(self, rel(pos, Direction::North)),
    // rust: RailShape::AscendingSouth => !support(self, rel(pos, Direction::South)),
    // rust: _ => false,
}
    // rust: if remove {
    // rust: self.drop_resources(state, pos);
    // rust: self.remove_block(pos, moved);
    // rust: return;
}
    // rust: let data = b.data(state);
    // rust: if data.is(Class::PoweredRail) {
    // rust: self.powered_rail_update(pos, state);
    // rust: } else if data.is(Class::Rail) {
    // rust: let changed_default = b.default_of(changed);
    // rust: if self.is_signal_source_default(changed_default)
    // rust: && self.rail_count_potential_connections(pos) == 3
    // rust: {
    // rust: self.rail_update_dir(pos, state, false);
}
}
}
is_signal_source_default :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b
    // rust: .has_flag(state, super::data::state_flags::SIGNAL_SOURCE)
}
powered_rail_update :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let powered = b.table.bool(state, b.props.powered);
    // rust: let should = self.has_neighbor_signal(pos)
    // rust: || self.powered_rail_find(pos, state, true, 0)
    // rust: || self.powered_rail_find(pos, state, false, 0);
    // rust: if should != powered {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.powered, should));
    // rust: let block = b.block(state);
    // rust: self.update_neighbors_at(below(pos), block);
    // rust: if RailShape::parse(self.rail_shape(state)).is_slope() {
    // rust: self.update_neighbors_at(above(pos), block);
}
}
}
    // rust: fn powered_rail_find(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: forward: bool,
    // rust: depth: i32,
    // rust: ) -> bool {
    // rust: if depth >= 8 {
    // rust: return false;
}
    // rust: let (mut x, mut y, mut z) = (pos.x, pos.y, pos.z);
    // rust: let mut check_below = true;
    // rust: let mut shape = RailShape::parse(self.rail_shape(state));
    // rust: match shape {
    // rust: RailShape::NorthSouth => z += if forward { 1 } else { -1 },
    // rust: RailShape::EastWest => x += if forward { -1 } else { 1 },
    // rust: RailShape::AscendingEast => {
    // rust: if forward {
    // rust: x -= 1;
    // rust: } else {
    // rust: x += 1;
    // rust: y += 1;
    // rust: check_below = false;
}
    // rust: shape = RailShape::EastWest;
}
    // rust: RailShape::AscendingWest => {
    // rust: if forward {
    // rust: x -= 1;
    // rust: y += 1;
    // rust: check_below = false;
    // rust: } else {
    // rust: x += 1;
}
    // rust: shape = RailShape::EastWest;
}
    // rust: RailShape::AscendingNorth => {
    // rust: if forward {
    // rust: z += 1;
    // rust: } else {
    // rust: z -= 1;
    // rust: y += 1;
    // rust: check_below = false;
}
    // rust: shape = RailShape::NorthSouth;
}
    // rust: RailShape::AscendingSouth => {
    // rust: if forward {
    // rust: z += 1;
    // rust: y += 1;
    // rust: check_below = false;
    // rust: } else {
    // rust: z -= 1;
}
    // rust: shape = RailShape::NorthSouth;
}
    // rust: _ => {}
}
    // rust: let block = self.b.block(state);
    // rust: self.powered_rail_same_with_power(BlockPos::new(x, y, z), block, forward, depth, shape)
    // rust: || (check_below
    // rust: && self.powered_rail_same_with_power(
    // rust: BlockPos::new(x, y - 1, z),
    // rust: block,
    // rust: forward,
    // rust: depth,
    // rust: shape,
    // rust: ))
}
    // rust: fn powered_rail_same_with_power(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: forward: bool,
    // rust: depth: i32,
    // rust: dir: RailShape,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if !b.is_block(state, block) {
    // rust: return false;
}
    // rust: let mine = RailShape::parse(self.rail_shape(state));
    // rust: if dir == RailShape::EastWest
    // rust: && matches!(
    // rust: mine,
    // rust: RailShape::NorthSouth | RailShape::AscendingNorth | RailShape::AscendingSouth
    // rust: )
    // rust: {
    // rust: return false;
}
    // rust: if dir == RailShape::NorthSouth
    // rust: && matches!(
    // rust: mine,
    // rust: RailShape::EastWest | RailShape::AscendingEast | RailShape::AscendingWest
    // rust: )
    // rust: {
    // rust: return false;
}
    // rust: if !b.table.bool(state, b.props.powered) {
    // rust: return false;
}
    // rust: self.has_neighbor_signal(pos) || self.powered_rail_find(pos, state, forward, depth + 1)
}

    // ---- tripwire ----

    // `TripWireBlock.updateSource`.
    // rust: pub(crate) fn tripwire_update_source(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: for direction in [Direction::South, Direction::West] {
    // rust: for i in 1..42 {
    // rust: let [dx, dy, dz] = direction.normal();
    // rust: let test = pos.offset(dx * i, dy * i, dz * i);
    // rust: let block = self.state(test);
    // rust: if b.is_block(block, b.named.tripwire_hook) {
    // rust: if b.facing(block) == direction.opposite() {
    // rust: self.tripwire_hook_calculate(test, block, false, true, i, Some(state));
}
    // rust: break;
}
    // rust: if !b.is_block(block, b.named.tripwire) {
    // rust: break;
}
}
}
}
    // `DetectorRailBlock.checkPressed`.
    // rust: pub(crate) fn detector_rail_check_pressed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if !self.can_survive(state, pos) || !b.is_block(self.state(pos), b.block(state)) {
    // rust: return;
}
    // rust: let was = b.table.bool(state, b.props.powered);
        // getInteractingMinecartOfType: the 0.2-inset search box.
    // rust: let (x, y, z) = (f64::from(pos.x), f64::from(pos.y), f64::from(pos.z));
    // rust: let area = Aabb::new(
    // rust: Vec3::new(x + 0.2, y, z + 0.2),
    // rust: Vec3::new(x + 0.8, y + 0.8, z + 0.8),
    // rust: );
    // rust: let pressed = self
    // rust: .level
    // rust: .count_entities(area, super::EntityQuery::Minecart)
    // rust: > 0;
    // rust: let block = b.block(state);
    // rust: if pressed != was {
    // rust: let next = b.table.set_bool(state, b.props.powered, pressed);
    // rust: self.set_block_and_update(pos, next);
    // rust: let rail = self.rail_new(pos, next);
    // rust: for connection in rail.connections {
    // rust: let at = self.state(connection);
    // rust: self.neighbor_changed_full(at, connection, b.block(at), false);
}
    // rust: self.update_neighbors_at(pos, block);
    // rust: self.update_neighbors_at(below(pos), block);
}
    // rust: if pressed {
    // rust: self.schedule_tick(pos, block, 20);
}
    // rust: self.update_neighbour_for_output_signal(pos, block);
}
    // rust: pub(crate) fn tripwire_tick(&mut self, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if b.table.bool(state, b.props.powered) {
    // rust: self.tripwire_check_pressed(pos);
}
}
    // `TripWireBlock.checkPressed` with the entities currently inside.
    // rust: pub(crate) fn tripwire_check_pressed(&mut self, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: let was = b.table.bool(state, b.props.powered);
    // rust: let top = if b.table.bool(state, b.props.attached) {
    // rust: 2.5 / 16.0
    // rust: } else {
    // rust: 8.0 / 16.0
}
    // rust: let area = Aabb::new(
    // rust: Vec3::new(
    // rust: f64::from(pos.x),
    // rust: f64::from(pos.y) + 1.0 / 16.0,
    // rust: f64::from(pos.z),
    // rust: ),
    // rust: Vec3::new(
    // rust: f64::from(pos.x) + 1.0,
    // rust: f64::from(pos.y) + top,
    // rust: f64::from(pos.z) + 1.0,
    // rust: ),
    // rust: );
    // rust: let pressed = self
    // rust: .level
    // rust: .count_entities(area, super::EntityQuery::Everything)
    // rust: > 0;
    // rust: let block = b.block(state);
    // rust: if pressed != was {
    // rust: let next = b.table.set_bool(state, b.props.powered, pressed);
    // rust: self.set_block_and_update(pos, next);
    // rust: self.tripwire_update_source(pos, next);
}
    // rust: if pressed {
    // rust: self.schedule_tick(pos, block, 10);
    // rust: } else if was {
    // rust: self.schedule_tick(pos, block, 1);
}
}
tripwire_hook_notify :: proc(self: ^Self, block: BlockId, pos: BlockPos, direction: Direction) {
}
    // rust: let front = direction.opposite();
    // rust: let orientation = self.initial_orientation(Some(front), Some(Direction::Up));
    // rust: self.update_neighbors_at_oriented(pos, block, orientation);
    // rust: self.update_neighbors_at_oriented(rel(pos, front), block, orientation);
}
    // rust: fn tripwire_emit(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: attached: bool,
    // rust: powered: bool,
    // rust: was_attached: bool,
    // rust: was_powered: bool,
    // rust: ) {
    // rust: let (sound, volume, pitch, event) = if powered && !was_powered {
    // rust: (
    // rust: "minecraft:block.tripwire.click_on",
    // rust: 0.4,
    // rust: 0.6,
    // rust: "minecraft:block_activate",
    // rust: )
    // rust: } else if !powered && was_powered {
    // rust: (
    // rust: "minecraft:block.tripwire.click_off",
    // rust: 0.4,
    // rust: 0.5,
    // rust: "minecraft:block_deactivate",
    // rust: )
    // rust: } else if attached && !was_attached {
    // rust: (
    // rust: "minecraft:block.tripwire.attach",
    // rust: 0.4,
    // rust: 0.7,
    // rust: "minecraft:block_attach",
    // rust: )
    // rust: } else if !attached && was_attached {
    // rust: let pitch = 1.2 / (self.random().next_float() * 0.2 + 0.9);
    // rust: (
    // rust: "minecraft:block.tripwire.detach",
    // rust: 0.4,
    // rust: pitch,
    // rust: "minecraft:block_detach",
    // rust: )
    // rust: } else {
    // rust: return;
}
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: sound.into(),
    // rust: volume,
    // rust: pitch,
    // rust: });
    // rust: self.game_event(pos, event);
}
    // `TripWireHookBlock.calculateState`.
    // rust: pub(crate) fn tripwire_hook_calculate(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: destroyed: bool,
    // rust: can_update: bool,
    // rust: wire_source: i32,
    // rust: wire_source_state: Option<BlockStateId>,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let Some(direction) = b.table.dir(state, p.facing) else {
    // rust: return;
}
    // rust: let was_attached = b.table.bool(state, p.attached);
    // rust: let was_powered = b.table.bool(state, p.powered);
    // rust: let block = b.block(state);
    // rust: let mut attached = !destroyed;
    // rust: let mut powered = false;
    // rust: let mut receiver = 0;
    // rust: let mut wires: Vec<Option<BlockStateId>> = vec![None; 42];
    // rust: let [dx, dy, dz] = direction.normal();
    // rust: for i in 1..42 {
    // rust: let test = pos.offset(dx * i, dy * i, dz * i);
    // rust: let mut wire = self.state(test);
    // rust: if b.is_block(wire, b.named.tripwire_hook) {
    // rust: if b.facing(wire) == direction.opposite() {
    // rust: receiver = i;
}
    // rust: break;
}
    // rust: if !b.is_block(wire, b.named.tripwire) && i != wire_source {
    // rust: wires[i as usize] = None;
    // rust: attached = false;
    // rust: } else {
    // rust: if i == wire_source {
    // rust: wire = wire_source_state.unwrap_or(wire);
}
    // rust: let armed = !b.table.bool(wire, p.disarmed);
    // rust: let wire_powered = b.table.bool(wire, p.powered);
    // rust: powered |= armed && wire_powered;
    // rust: wires[i as usize] = Some(wire);
    // rust: if i == wire_source {
    // rust: self.schedule_tick(pos, block, 10);
    // rust: attached &= armed;
}
}
}
    // rust: attached &= receiver > 1;
    // rust: powered &= attached;
    // rust: let new_state = b.table.set_bool(
    // rust: b.table.set_bool(b.default_of(block), p.attached, attached),
    // rust: p.powered,
    // rust: powered,
    // rust: );
    // rust: if receiver > 0 {
    // rust: let test = pos.offset(dx * receiver, dy * receiver, dz * receiver);
    // rust: let opposite = direction.opposite();
    // rust: self.set_block_and_update(test, b.table.set_dir(new_state, p.facing, opposite));
    // rust: self.tripwire_hook_notify(block, test, opposite);
    // rust: if !b.is_block(self.state(pos), b.named.tripwire_hook) {
    // rust: self.tripwire_hook_removed(pos, new_state);
    // rust: return;
}
    // rust: self.tripwire_emit(test, attached, powered, was_attached, was_powered);
}
    // rust: self.tripwire_emit(pos, attached, powered, was_attached, was_powered);
    // rust: if !destroyed {
    // rust: self.set_block_and_update(pos, b.table.set_dir(new_state, p.facing, direction));
    // rust: if can_update {
    // rust: self.tripwire_hook_notify(block, pos, direction);
}
}
    // rust: if was_attached != attached {
    // rust: for i in 1..receiver {
    // rust: let test = pos.offset(dx * i, dy * i, dz * i);
    // rust: if let Some(wire) = wires[i as usize] {
    // rust: let current = self.state(test);
    // rust: if b.is_block(current, b.named.tripwire)
    // rust: || b.is_block(current, b.named.tripwire_hook)
    // rust: {
    // rust: let next = b
    // rust: .table
    // rust: .with_bool(wire, p.attached, attached)
    // rust: .unwrap_or(wire);
    // rust: self.set_block_and_update(test, next);
}
}
}
}
}
    // `TripWireHookBlock.onRemoved`.
    // rust: pub(crate) fn tripwire_hook_removed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let attached = b.table.bool(state, b.props.attached);
    // rust: let powered = b.table.bool(state, b.props.powered);
    // rust: if attached || powered {
    // rust: self.tripwire_hook_calculate(pos, state, true, false, -1, None);
}
    // rust: if powered {
    // rust: let facing = b.facing(state);
    // rust: self.tripwire_hook_notify(b.block(state), pos, facing);
}
}
}
