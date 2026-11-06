//! Transpiled from Horizon Rust crate
package horizon_client_end_gateway

import "core:fmt"
import "core:mem"
import "core:math"

// End gateway travel for the entities that step into one:
// `EndGatewayBlock.entityInside` (the gateway takes the entity in and starts
// its 40 tick cooldown), `Entity.setAsInsidePortal` and `Entity.handlePortal`
// (the entity goes through on the next tick), and
// `TheEndGatewayBlockEntity.getPortalPosition` (where it lands).
// use crate::nether_portal::{ENTITY_DELAY, PortalState};
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::{geometry::Vec3, position::BlockPos};

// The End gateway travel of one entity.
Traveller :: struct {
    // The entity's portal process and cooldown (`Entity.portalProcess`).
    state: PortalState,
}

    // rust: impl Traveller {
    // `Entity.setAsInsidePortal`: the entity is in the gateway and goes
    // through it on the next tick.
enter :: proc(self: ^Self, gateway: BlockPos) {
}
    // rust: self.state.set_inside(gateway, ENTITY_DELAY);
}

    // `Entity.handlePortal`: the entity goes through the gateway it entered
    // (the End gateway has no transition time), or stays where it is.
travel :: proc(self: ^Self, allowed: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.state.handle(allowed, 0, ENTITY_DELAY)
}

    // Whether the entity's travel is over: it has no portal process left and
    // its portal cooldown has run out.
is_done :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.state.cooldown == 0 && self.state.process.is_none()
}

    // The entity's portal cooldown, the ticks it stays out of a portal.
cooldown :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.state.cooldown
}
}

// The End gateway block an entity's box swept through
// (`Entity.checkInsideBlocks`, which calls `EndGatewayBlock.entityInside`).
    // rust: pub fn swept_gateway(
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: mut is_gateway: impl FnMut(BlockPos) -> bool,
    // rust: ) -> Option<BlockPos> {
    // rust: let half = f64::from(width) / 2.0;
    // rust: let bounds = horizon_core::geometry::Aabb::new(
    // rust: Vec3::new(to.x - half, to.y, to.z - half),
    // rust: Vec3::new(to.x + half, to.y + f64::from(height), to.z + half),
    // rust: )
    // rust: .deflate(Vec3::new(1.0e-5, 1.0e-5, 1.0e-5));
    // rust: let mut found = None;
    // rust: let _ =
    // rust: horizon_core::geometry::sweep_intersected_blocks(from, to, bounds, 1_000_000, |p, _| {
    // rust: if is_gateway(p) {
    // rust: found = Some(p);
    // rust: return false;
}
    // rust: true
    // rust: });
    // rust: found
}

// The End gateway a thrown ender pearl passed through on its last move, from
// where it started the tick to where it is (`Entity.checkInsideBlocks` from
// `ThrowableProjectile.tick`'s `applyEffectsFromBlocks`). Other projectiles
// are not looked at.
    // rust: pub fn pearl_gateway(
    // rust: pearl: &Projectile,
    // rust: is_gateway: impl FnMut(BlockPos) -> bool,
    // rust: ) -> Option<BlockPos> {
    // rust: if !matches!(pearl.kind, ProjectileKind::EnderPearl) {
    // rust: return None;
}
    // rust: let size = pearl.kind.size() as f32;
    // rust: swept_gateway(pearl.previous, pearl.position, size, size, is_gateway)
}

// A thrown ender pearl at its gateway's exit `at`
// (`EndGatewayBlock.getPortalDestination` for a `ThrownEnderpearl`: a
// `TeleportTransition` with no motion, rotation 0 and nothing relative).
// It falls from there and takes its owner where it lands.
place_pearl :: proc(pearl: ^Projectile, at: Vec3) {
}
    // rust: pearl.position = at;
    // rust: pearl.previous = at;
    // rust: pearl.velocity = Vec3::ZERO;
    // rust: pearl.yaw = 0.0;
    // rust: pearl.pitch = 0.0;
    // A server tells its clients of the jump at once.
    // rust: pearl.needs_sync = true;
}

// The bottom centre of a block (`Vec3.atBottomCenterOf`): where a traveller
// lands at a gateway's exit.
bottom_center :: proc(p: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: )
}

    // rust: mod tests {
//     use super::*;

    // The gateway of the issue: a block at [702, 100, 0] in the End.
GATEWAY :: [702, 100, 0]

at :: proc(x: f64, y: f64, z: f64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(x, y, z)
}

is_gateway :: proc(p: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: [p.x, p.y, p.z] == GATEWAY
}

an_item_and_a_mob_in_a_gateway_are_found_in_it :: proc() {
}
        // A dropped item, 0.25 wide, standing in the gateway block.
    // rust: let item = at(702.5, 100.5, 0.5);
    // rust: assert_eq!(
    // rust: swept_gateway(item, item, 0.25, 0.25, is_gateway),
    // rust: Some(BlockPos::new(702, 100, 0))
    // rust: );
        // A cow, 0.9 wide and 1.4 tall, in the same block.
    // rust: let cow = at(702.5, 100.0, 0.5);
    // rust: assert_eq!(
    // rust: swept_gateway(cow, cow, 0.9, 1.4, is_gateway),
    // rust: Some(BlockPos::new(702, 100, 0))
    // rust: );
}

an_entity_out_of_the_gateway_is_not_in_it :: proc() {
}
        // Two blocks above the gateway: nothing to travel through.
    // rust: let above = at(702.5, 102.5, 0.5);
    // rust: assert_eq!(swept_gateway(above, above, 0.25, 0.25, is_gateway), None);
        // Beside the gateway, outside its block.
    // rust: let beside = at(704.5, 100.5, 0.5);
    // rust: assert_eq!(swept_gateway(beside, beside, 0.9, 1.4, is_gateway), None);
}

an_entity_falling_through_the_gateway_goes_through_it :: proc() {
}
        // A cow falling past the gateway block passes through it
        // (Entity.checkInsideBlocks visits the blocks along the way).
    // rust: let from = at(702.5, 103.0, 0.5);
    // rust: let to = at(702.5, 99.0, 0.5);
    // rust: assert_eq!(
    // rust: swept_gateway(from, to, 0.9, 1.4, is_gateway),
    // rust: Some(BlockPos::new(702, 100, 0))
    // rust: );
}
an_entity_goes_through_the_gateway_on_the_tick_after_it_entered :: proc() {
}
    // rust: let gateway = BlockPos::new(702, 100, 0);
    // rust: let mut traveller = Traveller::default();
        // Nothing happens while the entity is outside the gateway.
    // rust: assert_eq!(traveller.travel(true), None);
        // It enters the gateway, and goes through on the next tick.
    // rust: traveller.enter(gateway);
    // rust: assert_eq!(traveller.travel(true), Some(gateway));
        // Its portal cooldown keeps it from going back at once.
    // rust: assert_eq!(traveller.cooldown(), ENTITY_DELAY);
    // rust: assert!(!traveller.is_done());
}

an_entity_that_may_not_use_portals_stays_in_the_gateway :: proc() {
}
    // rust: let gateway = BlockPos::new(702, 100, 0);
    // rust: let mut traveller = Traveller::default();
    // rust: traveller.enter(gateway);
        // A mob that cannot use a portal does not go through.
    // rust: assert_eq!(traveller.travel(false), None);
}

    // A world with no blocks in the way and nothing to hit: the gateway
    // block has no collision shape, so a projectile flies into it.
Open :: struct {
    // rust: impl crate::projectiles::ProjectileWorld for Open {
clip :: proc(self: ^Self, _: Vec3, _: Vec3) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
in_water :: proc(self: ^Self, _: horizon_core::geometry::Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
targets :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &[]
}
}

    // The ticks a projectile flies, thrown east at the gateway, until its
    // move goes through one (`None` if it never does in 5 ticks).
thrown_at_gateway :: proc(kind: ProjectileKind) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut shot = Projectile::new(kind, at(699.5, 100.3, 0.5), None);
    // rust: shot.velocity = at(1.5, 0.0, 0.0);
    // rust: for _ in 0..5 {
    // rust: shot.tick(&Open);
    // rust: if let Some(g) = pearl_gateway(&shot, is_gateway) {
    // rust: return (shot, Some(g));
}
}
    // rust: (shot, None)
}

a_thrown_pearl_goes_through_the_gateway_and_falls_from_its_exit :: proc() {
}
    // rust: let (mut pearl, found) = thrown_at_gateway(ProjectileKind::EnderPearl);
    // rust: let gateway = BlockPos::new(702, 100, 0);
        // ThrownEnderpearl in the gateway block: EndGatewayBlock.entityInside
        // takes it in, and it goes through on the next tick.
    // rust: assert_eq!(found, Some(gateway));
    // rust: let mut traveller = Traveller::default();
    // rust: traveller.enter(gateway);
    // rust: assert_eq!(traveller.travel(true), Some(gateway));
        // getPortalDestination: at the exit, no motion and rotation 0.
    // rust: let exit = bottom_center([8, 100, 0]);
    // rust: place_pearl(&mut pearl, exit);
    // rust: assert_eq!(pearl.position, exit);
    // rust: assert_eq!(pearl.previous, exit);
    // rust: assert_eq!(pearl.velocity, Vec3::ZERO);
    // rust: assert_eq!((pearl.yaw, pearl.pitch), (0.0, 0.0));
        // It falls straight down from the exit (ThrowableProjectile gravity,
        // then inertia), where it lands and takes its owner along.
    // rust: pearl.tick(&Open);
    // rust: assert_eq!((pearl.position.x, pearl.position.z), (8.5, 0.5));
    // rust: assert!((pearl.position.y - (100.0 - 0.03 * 0.99)).abs() < 1e-9);
        // The pearl is out of the gateway: it does not go back at once.
    // rust: assert_eq!(traveller.travel(true), None);
    // rust: assert_eq!(traveller.cooldown(), ENTITY_DELAY - 1);
}

a_pearl_flying_past_the_gateway_stays_out_of_it :: proc() {
}
        // Thrown one block higher, over the gateway block.
    // rust: let mut pearl = Projectile::new(ProjectileKind::EnderPearl, at(699.5, 101.3, 0.5), None);
    // rust: pearl.velocity = at(1.5, 0.0, 0.0);
    // rust: for _ in 0..5 {
    // rust: pearl.tick(&Open);
    // rust: assert_eq!(pearl_gateway(&pearl, is_gateway), None);
}
        // Only the pearl travels: a snowball on the same path is not taken in.
    // rust: assert_eq!(thrown_at_gateway(ProjectileKind::Snowball).1, None);
}

a_traveller_lands_at_the_bottom_centre_of_the_exit :: proc() {
}
        // TheEndGatewayBlockEntity.getPortalPosition: the exit's bottom
        // centre, the same spot the player arrives at.
    // rust: assert_eq!(bottom_center([8, 100, 0]), at(8.5, 100.0, 0.5));
}
}
