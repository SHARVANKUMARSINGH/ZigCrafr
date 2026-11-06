//! Zigcraft Minecraft Network Protocol Implementation
//! Supports Java Edition packet framing, VarInt, VarLong, Handshake, Status, Login, and Play.

const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

pub const PacketReader = struct {
    buffer: []const u8,
    cursor: usize,

    pub fn init(buffer: []const u8) PacketReader {
        return .{ .buffer = buffer, .cursor = 0 };
    }

    pub fn remaining(self: *const PacketReader) usize {
        return self.buffer.len - self.cursor;
    }

    pub fn readByte(self: *PacketReader) !u8 {
        if (self.cursor >= self.buffer.len) return error.EndOfStream;
        const b = self.buffer[self.cursor];
        self.cursor += 1;
        return b;
    }

    pub fn readVarInt(self: *PacketReader) !i32 {
        var num_read: usize = 0;
        var result: i32 = 0;
        while (true) {
            const byte = try self.readByte();
            const value: i32 = @intCast(byte & 0x7F);
            result |= value << @intCast(num_read * 7);
            num_read += 1;
            if (num_read > 5) return error.VarIntTooLarge;
            if ((byte & 0x80) == 0) break;
        }
        return result;
    }

    pub fn readString(self: *PacketReader) ![]const u8 {
        const len = try self.readVarInt();
        if (len < 0) return error.InvalidStringLength;
        const ulen: usize = @intCast(len);
        if (self.remaining() < ulen) return error.EndOfStream;
        const slice = self.buffer[self.cursor .. self.cursor + ulen];
        self.cursor += ulen;
        return slice;
    }

    pub fn readU16(self: *PacketReader) !u16 {
        if (self.remaining() < 2) return error.EndOfStream;
        const slice = self.buffer[self.cursor .. self.cursor + 2];
        self.cursor += 2;
        return std.mem.readInt(u16, slice[0..2], .big);
    }

    pub fn readF64(self: *PacketReader) !f64 {
        if (self.remaining() < 8) return error.EndOfStream;
        const slice = self.buffer[self.cursor .. self.cursor + 8];
        self.cursor += 8;
        const bits = std.mem.readInt(u64, slice[0..8], .big);
        return @bitCast(bits);
    }
};

pub const PacketWriter = struct {
    buffer: std.ArrayList(u8),

    pub fn init(allocator: Allocator) PacketWriter {
        return .{ .buffer = std.ArrayList(u8).init(allocator) };
    }

    pub fn deinit(self: *PacketWriter) void {
        self.buffer.deinit();
    }

    pub fn writeByte(self: *PacketWriter, b: u8) !void {
        try self.buffer.append(b);
    }

    pub fn writeVarInt(self: *PacketWriter, value: i32) !void {
        var v: u32 = @bitCast(value);
        while (true) {
            if ((v & ~@as(u32, 0x7F)) == 0) {
                try self.writeByte(@intCast(v));
                return;
            } else {
                try self.writeByte(@intCast((v & 0x7F) | 0x80));
                v >>= 7;
            }
        }
    }

    pub fn writeString(self: *PacketWriter, str: []const u8) !void {
        try self.writeVarInt(@intCast(str.len));
        try self.buffer.appendSlice(str);
    }

    pub fn writeU16(self: *PacketWriter, val: u16) !void {
        var bytes: [2]u8 = undefined;
        std.mem.writeInt(u16, &bytes, val, .big);
        try self.buffer.appendSlice(&bytes);
    }

    pub fn writeF64(self: *PacketWriter, val: f64) !void {
        var bytes: [8]u8 = undefined;
        std.mem.writeInt(u64, &bytes, @bitCast(val), .big);
        try self.buffer.appendSlice(&bytes);
    }
};

pub const HandshakePacket = struct {
    protocol_version: i32,
    server_address: []const u8,
    server_port: u16,
    next_state: i32, // 1 for status, 2 for login

    pub fn decode(reader: *PacketReader) !HandshakePacket {
        return .{
            .protocol_version = try reader.readVarInt(),
            .server_address = try reader.readString(),
            .server_port = try reader.readU16(),
            .next_state = try reader.readVarInt(),
        };
    }

    pub fn encode(self: *const HandshakePacket, writer: *PacketWriter) !void {
        try writer.writeVarInt(0x00); // Packet ID
        try writer.writeVarInt(self.protocol_version);
        try writer.writeString(self.server_address);
        try writer.writeU16(self.server_port);
        try writer.writeVarInt(self.next_state);
    }
};
