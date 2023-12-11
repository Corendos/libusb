const std = @import("std");

pub fn build(b: *std.Build) !void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const libusb = b.addStaticLibrary(.{
        .target = target,
        .optimize = optimize,
        .name = "usb",
    });

    libusb.addIncludePath(.{ .path = "./" });
    libusb.addIncludePath(.{ .path = "./libusb/" });
    libusb.addIncludePath(.{ .path = "./libusb/os/" });
    libusb.addCSourceFiles(.{ .files = &.{
        "./libusb/core.c",
        "./libusb/descriptor.c",
        "./libusb/hotplug.c",
        "./libusb/io.c",
        "./libusb/strerror.c",
        "./libusb/sync.c",
    } });
    libusb.linkLibC();

    b.installArtifact(libusb);
}
