//! Transpiled from Horizon Rust crate
package horizon_client_native_mob_draw

import "core:fmt"
import "core:mem"
import "core:math"

// Mobs drawn by native mods on the client: `native_mob_submit` (vanilla's
// `EntityRenderer.submit` for a mob, NeoForge's `RenderLivingEvent.Pre` when
// it cancels) gets the mob's render state and a [`BlockEntityDraw`] posed at
// its feet and turned with its body, so a mod draws a model of its own with
// the helpers block entities draw with (`native_draw_cube`,
// `native_draw_quad`, `native_draw_block`, `native_draw_item`). A player
// has `native_player_submit` (`RenderPlayerEvent.Pre`), and every mob and
// player in view gets `native_mob_layer` after its vanilla model
// (`EntityRenderersEvent.AddLayers`), in the same frame.

// use super::{Dim, Game, native_block_entity_draw::BlockEntityDraw};
// use glam::{DVec3, Mat4};
// use horizon_client::{
    // rust: block_entity_render::diffuse_lights,
    // rust: mesher::Vertex,
    // rust: mobs::{Mob, anim, living::wrap},
}

// One mob's frame, as `EntityRenderer.extractRenderState` fills a
// `LivingEntityRenderState`: what a model reads to pose and animate itself.
// Angles are in degrees, interpolated to the frame's partial tick.
// Native mods read it; nothing in Horizon does.
NativeMobRender :: struct {
    // The mob's network id, as the mob helpers and mod messages name it.
    id: u32,
    // Its entity type (`minecraft:villager`).
    kind: ^'a str,
    // Its `CustomName` as plain text, when it has one.
    custom_name: Maybe(^'a str),
    // `isBaby`.
    baby: bool,
    // The frame's partial tick, 0 to 1.
    partial: f32,
    // `ageInTicks`: ticks lived plus the partial tick, for idle motion.
    age: f32,
    // `bodyRot`: the way the body faces (0 is south, 90 west).
    body_yaw: f32,
    // `yRot`: the head's turn from the body, -180 to 180.
    head_yaw: f32,
    // `xRot`: the head's pitch, positive looking down.
    pitch: f32,
    // `walkAnimationPos`: how far the legs have swung, for a walk cycle
    // (a vanilla quadruped's legs swing `cos(pos * 0.6662) * 1.4 * speed` radians).
    walk_position: f32,
    // `walkAnimationSpeed`: how fast it walks, 0 standing to about 1.
    walk_speed: f32,
    // Ticks left of the red hurt flash (10 when hit).
    hurt_time: i32,
    // Ticks since it died, 0 while alive (vanilla tips the body over 20).
    death_time: i32,
    on_ground: bool,
}

    // rust: impl<'a> NativeMobRender<'a> {
    // The render state of `m` at `partial` (`LivingEntityRenderer.extractRenderState`).
    // rust: pub(super) fn of(m: &'a Mob, partial: f32) -> Self {
    // rust: let body = m.previous_body_yaw + wrap(m.body_yaw - m.previous_body_yaw) * partial;
        // The walk cycle, head turn and age as the vanilla models read them:
        // no walking while riding or dead, a baby's legs three times as far
        // (`WalkAnimationState.position(partial)`, `positionScale`).
    // rust: let pose = anim::state(m, partial);
    // rust: Self {
    // rust: id: m.id,
    // rust: kind: &m.kind.id,
    // rust: custom_name: m.custom_name.as_deref(),
    // rust: baby: m.is_baby(),
    // rust: partial,
    // rust: age: pose.age,
    // rust: body_yaw: body,
    // rust: head_yaw: pose.y_rot,
    // rust: pitch: pose.x_rot,
    // rust: walk_position: pose.pos,
    // rust: walk_speed: pose.speed,
    // rust: hurt_time: m.hurt_time,
    // rust: death_time: m.death_time,
    // rust: on_ground: m.on_ground,
}
}
}

// Which player a [`NativeMobRender`] is, for `native_player_submit` and
// `native_mob_layer`.
// Native mods read it; nothing in Horizon does.
NativePlayerRender :: struct {
    // The player's profile name.
    name: ^'a str,
    // Whether it is the player of this window, drawn in third person.
    local: bool,
}

// The pose a mod's mob model starts from: at the feet, `at` (relative to the
// camera), turned with the body so +z is the way it faces, +x its left and +y
// up, in blocks.
    // rust: pub(super) fn mob_pose(at: DVec3, body_yaw: f32) -> Mat4 {
    // rust: Mat4::from_translation(at.as_vec3()) * Mat4::from_rotation_y((-body_yaw).to_radians())
}

    // rust: impl Game<'_> {
    // `native_mob_submit` for `mob`, lit by `light` (packed as the entity
    // pass packs it): true when a mod drew it, and its vanilla model, armour
    // and held items are left out. The name tag, shadow, fire and a glowing
    // outline still draw as for any mob.
    // rust: pub(super) fn mod_mob_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: partial: f32,
    // rust: camera: DVec3,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) -> bool {
    // rust: self.mod_entity_draw(mob, partial, camera, light, out, |render, draw| {
    // rust: let mut drawn = false;
    // rust: self.native_mob_submit(render, draw, &mut drawn);
    // rust: drawn
    // rust: })
}
    // `native_player_submit` for the player `mob` (`who` says which): true
    // when a mod drew it and the vanilla model, armour, held items, cape and
    // other layers are left out.
    // rust: pub(super) fn mod_player_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: who: NativePlayerRender<'_>,
    // rust: partial: f32,
    // rust: camera: DVec3,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) -> bool {
        // Posing a player for the mods costs, each frame: only when one listens.
    // rust: let mut listened = false;
    // rust: self.native_player_render_listened(&mut listened);
    // rust: if !listened {
    // rust: return false;
}
    // rust: self.mod_entity_draw(mob, partial, camera, light, out, |render, draw| {
    // rust: let mut drawn = false;
    // rust: self.native_player_submit(render, &who, draw, &mut drawn);
    // rust: drawn
    // rust: })
}
    // `native_mob_layer` for `mob` (`who` set for a player): what a mod adds
    // is kept, drawn after the vanilla model and its layers.
    // rust: pub(super) fn mod_mob_layer_geometry(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: who: Option<NativePlayerRender<'_>>,
    // rust: partial: f32,
    // rust: camera: DVec3,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
        // Every mob in view each frame: only when a mod listens.
    // rust: let mut listened = false;
    // rust: self.native_player_render_listened(&mut listened);
    // rust: if !listened {
    // rust: return;
}
    // rust: self.mod_entity_draw(mob, partial, camera, light, out, |render, draw| {
    // rust: self.native_mob_layer(render, who.as_ref(), draw);
    // rust: true
    // rust: });
}
    // Gives `hook` the frame of `mob` and a draw posed at its feet; what it
    // added to `out` stays when it answers true.
    // rust: fn mod_entity_draw(
    // rust: &self,
    // rust: mob: &Mob,
    // rust: partial: f32,
    // rust: camera: DVec3,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: hook: impl FnOnce(&NativeMobRender<'_>, &mut BlockEntityDraw) -> bool,
    // rust: ) -> bool {
    // rust: let render = NativeMobRender::of(mob, partial);
    // rust: let a = f64::from(partial);
    // rust: let feet = mob.previous.lerp(mob.position, a);
    // rust: let feet = DVec3::new(feet.x, feet.y, feet.z);
    // rust: let start = out.len();
    // rust: let mut draw = BlockEntityDraw::posed(
    // rust: partial,
    // rust: self.world.game_time,
    // rust: light,
    // rust: [feet.x, feet.y, feet.z].map(|c| c.floor() as i32),
    // rust: mob_pose(feet - camera, render.body_yaw),
    // rust: diffuse_lights(self.dim == Dim::Nether),
    // rust: std::mem::take(out),
    // rust: );
    // rust: let keep = hook(&render, &mut draw);
    // rust: *out = draw.into_vertices();
    // rust: if !keep {
    // rust: out.truncate(start);
}
    // rust: keep
}
}

    // rust: mod tests {
//     use super::*;
//     use glam::Vec3;

close :: proc(a: Vec3, b: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (a - b).length() < 1e-5
}

the_pose_faces_where_the_body_faces :: proc() {
}
        // Entity yaw 0 faces south (+z), 90 west (-x), 180 north, 270 east.
    // rust: for (yaw, ahead, left) in [
    // rust: (0.0, Vec3::Z, Vec3::X),
    // rust: (90.0, Vec3::NEG_X, Vec3::Z),
    // rust: (180.0, Vec3::NEG_Z, Vec3::NEG_X),
    // rust: (270.0, Vec3::X, Vec3::NEG_Z),
    // rust: ] {
    // rust: let pose = mob_pose(DVec3::ZERO, yaw);
    // rust: assert!(close(pose.transform_vector3(Vec3::Z), ahead), "{yaw}");
    // rust: assert!(close(pose.transform_vector3(Vec3::X), left), "{yaw}");
    // rust: assert!(close(pose.transform_vector3(Vec3::Y), Vec3::Y), "{yaw}");
}
}

the_pose_starts_at_the_feet :: proc() {
}
    // rust: let at = DVec3::new(3.0, -1.5, 0.25);
    // rust: let pose = mob_pose(at, 37.0);
    // rust: assert!(close(pose.transform_point3(Vec3::ZERO), at.as_vec3()));
}
}
