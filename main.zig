const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    _ = try stdout.write("Hello, world!\n");
}
