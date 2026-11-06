const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const is_android = b.option(bool, "android", "Build for Android shared library") orelse false;
    const sysroot = b.option([]const u8, "sysroot", "Path to Android NDK sysroot");

    if (is_android) {
        // Android Shared Library (.so)
        const lib = b.addSharedLibrary(.{
            .name = "zigcraft",
            .root_source_file = b.path("src/android_main.zig"),
            .target = target,
            .optimize = optimize,
        });

        if (sysroot) |sr| {
            lib.addSystemIncludePath(.{ .cwd_relative = b.fmt("{s}/usr/include", .{sr}) });
            lib.addLibraryPath(.{ .cwd_relative = b.fmt("{s}/usr/lib", .{sr}) });
        }

        lib.addObjectFile(b.path("libodin.a"));
        lib.linkLibC();
        b.installArtifact(lib);
    } else {
        // Desktop Executable
        const exe = b.addExecutable(.{
            .name = "zigcraft",
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        });

        exe.addObjectFile(b.path("libodin.a"));
        exe.linkLibC();
        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }

        const run_step = b.step("run", "Run the Zigcraft game engine");
        run_step.dependOn(&run_cmd.step);
    }
}
