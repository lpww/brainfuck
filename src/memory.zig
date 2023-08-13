const zeroes = @import("std").mem.zeroes;

const config = @import("config.zig");

pub const Memory = struct {
    data: [config.memory_size]u8 = zeroes([config.memory_size]u8),

    fn isOutOfBounds(index: usize) bool {
        return index > config.memory_size;
    }

    pub fn get(self: *Memory, index: usize) !u8 {
        if (isOutOfBounds(index)) @panic("memory out of bounds");
        return self.data[index];
    }

    pub fn set(self: *Memory, index: usize, value: u8) !void {
        if (isOutOfBounds(index)) @panic("memory out of bounds");
        self.data[index] = value;
    }
};
