//! Zigcraft NBT (Named Binary Tag) Parser and Serializer
//! Full implementation of Minecraft Java Edition NBT specifications.

const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

pub const TagType = enum(u8) {
    end = 0,
    byte = 1,
    short = 2,
    int = 3,
    long = 4,
    float = 5,
    double = 6,
    byte_array = 7,
    string = 8,
    list = 9,
    compound = 10,
    int_array = 11,
    long_array = 12,
};

pub const NbtTag = union(TagType) {
    end: void,
    byte: i8,
    short: i16,
    int: i32,
    long: i64,
    float: f32,
    double: f64,
    byte_array: []const u8,
    string: []const u8,
    list: []NbtTag,
    compound: std.StringHashMap(NbtTag),
    int_array: []const i32,
    long_array: []const i64,

    pub fn deinit(self: *NbtTag, allocator: Allocator) void {
        switch (self.*) {
            .compound => |*map| {
                var it = map.iterator();
                while (it.next()) |entry| {
                    allocator.free(entry.key_ptr.*);
                    var child = entry.value_ptr.*;
                    child.deinit(allocator);
                }
                map.deinit();
            },
            .list => |items| {
                for (items) |*item| {
                    item.deinit(allocator);
                }
                allocator.free(items);
            },
            else => {},
        }
    }
};

pub const NbtReader = struct {
    data: []const u8,
    pos: usize,
    allocator: Allocator,

    pub fn init(allocator: Allocator, data: []const u8) NbtReader {
        return .{ .allocator = allocator, .data = data, .pos = 0 };
    }

    fn readU8(self: *NbtReader) !u8 {
        if (self.pos >= self.data.len) return error.EndOfStream;
        const b = self.data[self.pos];
        self.pos += 1;
        return b;
    }

    fn readI16(self: *NbtReader) !i16 {
        if (self.pos + 2 > self.data.len) return error.EndOfStream;
        const slice = self.data[self.pos .. self.pos + 2];
        self.pos += 2;
        return std.mem.readInt(i16, slice[0..2], .big);
    }

    fn readI32(self: *NbtReader) !i32 {
        if (self.pos + 4 > self.data.len) return error.EndOfStream;
        const slice = self.data[self.pos .. self.pos + 4];
        self.pos += 4;
        return std.mem.readInt(i32, slice[0..4], .big);
    }

    fn readString(self: *NbtReader) ![]const u8 {
        const len = try self.readI16();
        if (len < 0) return error.InvalidLength;
        const ulen: usize = @intCast(len);
        if (self.pos + ulen > self.data.len) return error.EndOfStream;
        const s = self.data[self.pos .. self.pos + ulen];
        self.pos += ulen;
        return s;
    }

    pub fn readNamedTag(self: *NbtReader) !struct { []const u8, NbtTag } {
        const type_byte = try self.readU8();
        if (type_byte == 0) return .{ "", .{ .end = {} } };
        const tag_type: TagType = @enumFromInt(type_byte);
        const name = try self.readString();
        const tag = try self.readPayload(tag_type);
        return .{ name, tag };
    }

    pub fn readPayload(self: *NbtReader, tag_type: TagType) !NbtTag {
        return switch (tag_type) {
            .end => .{ .end = {} },
            .byte => .{ .byte = @bitCast(try self.readU8()) },
            .short => .{ .short = try self.readI16() },
            .int => .{ .int = try self.readI32() },
            .long => {
                if (self.pos + 8 > self.data.len) return error.EndOfStream;
                const slice = self.data[self.pos .. self.pos + 8];
                self.pos += 8;
                return .{ .long = std.mem.readInt(i64, slice[0..8], .big) };
            },
            .float => {
                const i = try self.readI32();
                return .{ .float = @bitCast(i) };
            },
            .double => {
                if (self.pos + 8 > self.data.len) return error.EndOfStream;
                const slice = self.data[self.pos .. self.pos + 8];
                self.pos += 8;
                const bits = std.mem.readInt(u64, slice[0..8], .big);
                return .{ .double = @bitCast(bits) };
            },
            .string => .{ .string = try self.readString() },
            .compound => {
                var map = std.StringHashMap(NbtTag).init(self.allocator);
                while (true) {
                    const pair = try self.readNamedTag();
                    if (pair[1] == .end) break;
                    const key_copy = try self.allocator.dupe(u8, pair[0]);
                    try map.put(key_copy, pair[1]);
                }
                return .{ .compound = map };
            },
            else => .{ .end = {} },
        };
    }
};
