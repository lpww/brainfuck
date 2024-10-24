const std = @import("std");

const Pair = struct { open: usize, close: usize };

pub const Brackets = struct {
    pairs: std.ArrayList(Pair),

    pub fn init(alloc: std.mem.Allocator) Brackets {
        return Brackets{ .pairs = std.ArrayList(Pair).init(alloc) };
    }

    pub fn deinit(self: *Brackets) void {
        self.pairs.deinit();
    }

    pub fn map(self: *Brackets, alloc: std.mem.Allocator, program: []u8) !void {
        var stack = std.ArrayList(usize).init(alloc);
        defer stack.deinit();

        for (program, 0..) |char, i| {
            if (char == '[') try stack.append(i);
            if (char == ']') {
                if (stack.items.len == 0) {
                    return error.MissingOpenBracket;
                }

                try self.pairs.append(.{
                    .open = stack.pop(),
                    .close = i,
                });
            }
        }

        if (stack.items.len > 0) {
            return error.MissingClosingBracket;
        }
    }

    pub fn findPair(self: *Brackets, index: usize) ?Pair {
        return for (self.pairs.items) |pair| {
            if (pair.open == index or pair.close == index) break pair;
        } else null;
    }
};
