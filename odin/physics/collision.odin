package physics

import "core:math"

Vec3 :: struct {
    x, y, z: f32,
}

AABB :: struct {
    min: Vec3,
    max: Vec3,
}

PhysicsState :: struct {
    pos: Vec3,
    vel: Vec3,
    on_ground: bool,
    width: f32,   // 0.6 for Minecraft player
    height: f32,  // 1.8 for Minecraft player
}

GRAVITY :: 28.0
JUMP_IMPULSE :: 8.5
TERMINAL_VELOCITY :: 60.0
AIR_DRAG :: 0.98
GROUND_DRAG :: 0.6

init_player_physics :: proc(x, y, z: f32) -> PhysicsState {
    return PhysicsState{
        pos = Vec3{x, y, z},
        vel = Vec3{0, 0, 0},
        on_ground = false,
        width = 0.6,
        height = 1.8,
    }
}

get_player_aabb :: proc(state: ^PhysicsState) -> AABB {
    half_w := state.width * 0.5
    return AABB{
        min = Vec3{state.pos.x - half_w, state.pos.y, state.pos.z - half_w},
        max = Vec3{state.pos.x + half_w, state.pos.y + state.height, state.pos.z + half_w},
    }
}

// Ticks physics with delta time and inputs (forward, strafe, jump)
tick_player_physics :: proc(
    state: ^PhysicsState,
    dt: f32,
    move_forward, move_strafe: f32,
    yaw_rad: f32,
    jump: bool,
    is_solid_block: proc(bx, by, bz: i32) -> bool,
) {
    // Apply gravity
    if !state.on_ground {
        state.vel.y -= GRAVITY * dt
        if state.vel.y < -TERMINAL_VELOCITY {
            state.vel.y = -TERMINAL_VELOCITY
        }
    }

    // Jump
    if jump && state.on_ground {
        state.vel.y = JUMP_IMPULSE
        state.on_ground = false
    }

    // Calculate movement vector in world space from yaw
    sin_yaw := math.sin(yaw_rad)
    cos_yaw := math.cos(yaw_rad)

    speed: f32 = state.on_ground ? 5.5 : 3.0
    desired_vx := (move_strafe * cos_yaw - move_forward * sin_yaw) * speed
    desired_vz := (move_strafe * sin_yaw + move_forward * cos_yaw) * speed

    drag: f32 = state.on_ground ? GROUND_DRAG : AIR_DRAG
    state.vel.x = state.vel.x * drag + desired_vx * (1.0 - drag)
    state.vel.z = state.vel.z * drag + desired_vz * (1.0 - drag)

    // Integrate position with collision check
    dx := state.vel.x * dt
    dy := state.vel.y * dt
    dz := state.vel.z * dt

    // Simple vertical check
    target_y := state.pos.y + dy
    block_y := i32(math.floor(target_y))
    block_x := i32(math.floor(state.pos.x))
    block_z := i32(math.floor(state.pos.z))

    if dy < 0 && is_solid_block(block_x, block_y, block_z) {
        state.pos.y = f32(block_y + 1)
        state.vel.y = 0
        state.on_ground = true
    } else {
        state.pos.y = target_y
        state.on_ground = false
    }

    // Horizontal movement
    state.pos.x += dx
    state.pos.z += dz
}
