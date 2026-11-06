package bridge

import "base:runtime"
import "../worldgen"
import "../physics"
import "../gameplay"

global_player_session: gameplay.PlayerSession
global_physics_state: physics.PhysicsState

@(export)
odin_init :: proc "c" () {
    context = runtime.default_context()
    global_player_session = gameplay.init_player_session()
    global_physics_state = physics.init_player_physics(0.0, 75.0, 0.0)
}

@(export)
odin_generate_chunk :: proc "c" (cx, cz: i32, out_blocks: [^]u16) {
    context = runtime.default_context()
    blocks_ptr := cast(^[16 * 256 * 16]u16)out_blocks
    worldgen.generate_chunk(cx, cz, blocks_ptr)
}

solid_check_dummy :: proc(bx, by, bz: i32) -> bool {
    return by < 64
}

@(export)
odin_tick_physics :: proc "c" (
    pos: ^[3]f32,
    vel: ^[3]f32,
    on_ground: ^bool,
    dt: f32,
    move_forward: f32,
    move_strafe: f32,
    yaw_rad: f32,
    jump: bool,
) {
    context = runtime.default_context()
    global_physics_state.pos.x = pos[0]
    global_physics_state.pos.y = pos[1]
    global_physics_state.pos.z = pos[2]
    global_physics_state.vel.x = vel[0]
    global_physics_state.vel.y = vel[1]
    global_physics_state.vel.z = vel[2]
    global_physics_state.on_ground = on_ground^

    physics.tick_player_physics(
        &global_physics_state,
        dt,
        move_forward,
        move_strafe,
        yaw_rad,
        jump,
        solid_check_dummy,
    )

    pos[0] = global_physics_state.pos.x
    pos[1] = global_physics_state.pos.y
    pos[2] = global_physics_state.pos.z
    vel[0] = global_physics_state.vel.x
    vel[1] = global_physics_state.vel.y
    vel[2] = global_physics_state.vel.z
    on_ground^ = global_physics_state.on_ground
}

@(export)
odin_get_world_time :: proc "c" () -> u64 {
    context = runtime.default_context()
    return global_player_session.world_time
}

@(export)
odin_tick_world_time :: proc "c" () {
    context = runtime.default_context()
    gameplay.tick_day_night(&global_player_session)
}

@(export)
odin_get_player_health :: proc "c" () -> f32 {
    context = runtime.default_context()
    return global_player_session.health
}

@(export)
odin_select_slot :: proc "c" (slot: i32) {
    context = runtime.default_context()
    if slot >= 0 && slot < 9 {
        global_player_session.selected_slot = int(slot)
    }
}

@(export)
odin_get_selected_item :: proc "c" () -> u16 {
    context = runtime.default_context()
    slot := global_player_session.selected_slot
    return global_player_session.inventory[slot].item_id
}
