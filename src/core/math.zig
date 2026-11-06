//! Zigcraft Core Math Library
//! High-performance vector, matrix, AABB, and raycasting primitives.

const std = @import("std");
const math = std.math;

pub const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub const zero = Vec3{ .x = 0, .y = 0, .z = 0 };
    pub const one = Vec3{ .x = 1, .y = 1, .z = 1 };
    pub const up = Vec3{ .x = 0, .y = 1, .z = 0 };

    pub fn init(x: f32, y: f32, z: f32) Vec3 {
        return .{ .x = x, .y = y, .z = z };
    }

    pub fn add(self: Vec3, other: Vec3) Vec3 {
        return .{ .x = self.x + other.x, .y = self.y + other.y, .z = self.z + other.z };
    }

    pub fn sub(self: Vec3, other: Vec3) Vec3 {
        return .{ .x = self.x - other.x, .y = self.y - other.y, .z = self.z - other.z };
    }

    pub fn scale(self: Vec3, s: f32) Vec3 {
        return .{ .x = self.x * s, .y = self.y * s, .z = self.z * s };
    }

    pub fn dot(self: Vec3, other: Vec3) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }

    pub fn cross(self: Vec3, other: Vec3) Vec3 {
        return .{
            .x = self.y * other.z - self.z * other.y,
            .y = self.z * other.x - self.x * other.z,
            .z = self.x * other.y - self.y * other.x,
        };
    }

    pub fn lengthSq(self: Vec3) f32 {
        return self.dot(self);
    }

    pub fn length(self: Vec3) f32 {
        return @sqrt(self.lengthSq());
    }

    pub fn normalize(self: Vec3) Vec3 {
        const len = self.length();
        if (len == 0.0) return Vec3.zero;
        return self.scale(1.0 / len);
    }
};

pub const Vec3i = struct {
    x: i32,
    y: i32,
    z: i32,

    pub fn init(x: i32, y: i32, z: i32) Vec3i {
        return .{ .x = x, .y = y, .z = z };
    }

    pub fn toVec3(self: Vec3i) Vec3 {
        return Vec3.init(@floatFromInt(self.x), @floatFromInt(self.y), @floatFromInt(self.z));
    }
};

pub const AABB = struct {
    min: Vec3,
    max: Vec3,

    pub fn init(min: Vec3, max: Vec3) AABB {
        return .{ .min = min, .max = max };
    }

    pub fn intersects(self: AABB, other: AABB) bool {
        return (self.min.x <= other.max.x and self.max.x >= other.min.x) and
            (self.min.y <= other.max.y and self.max.y >= other.min.y) and
            (self.min.z <= other.max.z and self.max.z >= other.min.z);
    }

    pub fn offset(self: AABB, off: Vec3) AABB {
        return .{
            .min = self.min.add(off),
            .max = self.max.add(off),
        };
    }
};

pub const Mat4 = struct {
    data: [16]f32,

    pub const identity = Mat4{
        .data = [_]f32{
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1,
        },
    };

    pub fn perspective(fovy_rad: f32, aspect: f32, near: f32, far: f32) Mat4 {
        const tan_half_fovy = @tan(fovy_rad / 2.0);
        var res = std.mem.zeroes(Mat4);
        res.data[0] = 1.0 / (aspect * tan_half_fovy);
        res.data[5] = 1.0 / tan_half_fovy;
        res.data[10] = -(far + near) / (far - near);
        res.data[11] = -1.0;
        res.data[14] = -(2.0 * far * near) / (far - near);
        return res;
    }

    pub fn lookAt(eye: Vec3, center: Vec3, up: Vec3) Mat4 {
        const f = center.sub(eye).normalize();
        const s = f.cross(up).normalize();
        const u = s.cross(f);

        var res = Mat4.identity;
        res.data[0] = s.x;
        res.data[4] = s.y;
        res.data[8] = s.z;
        res.data[1] = u.x;
        res.data[5] = u.y;
        res.data[9] = u.z;
        res.data[2] = -f.x;
        res.data[6] = -f.y;
        res.data[10] = -f.z;
        res.data[12] = -s.dot(eye);
        res.data[13] = -u.dot(eye);
        res.data[14] = f.dot(eye);
        return res;
    }

    pub fn multiply(self: Mat4, other: Mat4) Mat4 {
        var res: Mat4 = undefined;
        var r: usize = 0;
        while (r < 4) : (r += 1) {
            var c: usize = 0;
            while (c < 4) : (c += 1) {
                var sum: f32 = 0;
                var k: usize = 0;
                while (k < 4) : (k += 1) {
                    sum += self.data[r + k * 4] * other.data[k + c * 4];
                }
                res.data[r + c * 4] = sum;
            }
        }
        return res;
    }
};
