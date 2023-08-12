const std = @import("std");

const max_file_size = 1024;

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
    const content = try reader.readAllAlloc(allocator, max_file_size);
    defer allocator.free(content);

    std.debug.print("Executing brainfuck:\n\n{s} \n", .{content});
}
