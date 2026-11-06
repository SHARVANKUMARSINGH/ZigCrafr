//! Zigcraft Android Native Interface & JNI Bridge
//! Connects Android NativeActivity and Java SurfaceView to the Zig & Odin engine.

const std = @import("std");
const math = @import("core/math.zig");
const chunk_mod = @import("world/chunk.zig");
const Chunk = chunk_mod.Chunk;
const mesher = @import("world/mesher.zig");
const ChunkMesh = mesher.ChunkMesh;
const odin = @import("bridge/odin_bridge.zig");

var initialized = false;
var player_pos = [3]f32{ 8.0, 75.0, 8.0 };
var player_vel = [3]f32{ 0.0, 0.0, 0.0 };
var on_ground = false;
var player_yaw: f32 = 0.0;
var player_pitch: f32 = 0.0;

// JNI exports
pub export fn Java_com_zigcraft_app_MainActivity_nativeInit(env: ?*anyopaque, thiz: ?*anyopaque) void {
    _ = env;
    _ = thiz;
    if (initialized) return;

    // Initialize Odin
    odin.odin_init();
    initialized = true;
}

pub export fn Java_com_zigcraft_app_MainActivity_nativeResize(env: ?*anyopaque, thiz: ?*anyopaque, width: i32, height: i32) void {
    _ = env;
    _ = thiz;
    _ = width;
    _ = height;
}

pub export fn Java_com_zigcraft_app_MainActivity_nativeRender(env: ?*anyopaque, thiz: ?*anyopaque) void {
    _ = env;
    _ = thiz;
    if (!initialized) return;

    // Tick world time and physics
    odin.odin_tick_world_time();
}

pub export fn Java_com_zigcraft_app_MainActivity_nativeTouch(
    env: ?*anyopaque,
    thiz: ?*anyopaque,
    action: i32,
    x: f32,
    y: f32,
    pointer_id: i32,
) void {
    _ = env;
    _ = thiz;
    _ = action;
    _ = x;
    _ = y;
    _ = pointer_id;
}

pub export fn Java_com_zigcraft_app_MainActivity_nativeMovementInput(
    env: ?*anyopaque,
    thiz: ?*anyopaque,
    forward: f32,
    strafe: f32,
    look_dx: f32,
    look_dy: f32,
    jump: bool,
) void {
    _ = env;
    _ = thiz;
    player_yaw += look_dx * 0.005;
    player_pitch += look_dy * 0.005;
    if (player_pitch > 1.5) player_pitch = 1.5;
    if (player_pitch < -1.5) player_pitch = -1.5;

    odin.odin_tick_physics(
        &player_pos,
        &player_vel,
        &on_ground,
        0.016, // 60 FPS delta time
        forward,
        strafe,
        player_yaw,
        jump,
    );
}

pub export fn Java_com_zigcraft_app_MainActivity_nativeDestroy(env: ?*anyopaque, thiz: ?*anyopaque) void {
    _ = env;
    _ = thiz;
    initialized = false;
}
