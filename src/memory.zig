const std = @import("std");

const config = @import("config.zig");

pub const Memory = struct {
    data: [config.memory_size]u8 = std.mem.zeroes([config.memory_size]u8),

    fn isOutOfBounds(index: usize) bool {
        return index > config.memory_size;
    }

    pub fn get(self: *Memory, index: usize) !u8 {
        if (isOutOfBounds(index)) return error.OutOfMemory;
        return self.data[index];
    }

    pub fn set(self: *Memory, index: usize, value: u8) !void {
        if (isOutOfBounds(index)) return error.OutOfMemory;
        self.data[index] = value;
    }
};

test "memory.data: should init with zeroes" {
    const mem = Memory{};
    for (mem.data) |value| {
        try std.testing.expect(value == 0);
    }
}

test "memory.set: should set the memory" {
    var mem: Memory = Memory{};
    const index = 0;
    const value = 1;

    try mem.set(index, value);

    try std.testing.expect(mem.data[index] == value);
}

test "memory.set: should error if setting memory out of bounds" {
    var mem: Memory = Memory{};
    const index = 50000;
    const value = 1;

    const result = mem.set(index, value);
    try std.testing.expectError(error.OutOfMemory, result);
}

test "memory.get: should get the memory" {
    var mem: Memory = Memory{};

    const index = 0;
    const expect = 100;
    try mem.set(index, expect);

    const result = try mem.get(index);

    try std.testing.expect(result == expect);
}

test "memory.get: should error if getting the memory out of bounds" {
    var mem: Memory = Memory{};

    const result = mem.get(50000);
    try std.testing.expectError(error.OutOfMemory, result);
}
