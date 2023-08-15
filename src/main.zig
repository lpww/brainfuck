const std = @import("std");

const config = @import("config.zig");
const Brainfuck = @import("brainfuck.zig").Brainfuck;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const file_path = args[1];
    const file = try std.fs.cwd().openFile(file_path, .{ .mode = .read_only });
    defer file.close();

    var buffered_reader = std.io.bufferedReader(file.reader());
    const reader = buffered_reader.reader();
    const program = try reader.readAllAlloc(allocator, config.max_file_size);
    defer allocator.free(program);

    var bf = Brainfuck.init(allocator);
    defer bf.deinit();
    try bf.run(program);
}
