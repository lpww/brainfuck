const std = @import("std");

const Memory = @import("memory.zig").Memory;
const Registers = @import("registers.zig").Registers;

pub const Brainfuck = struct {
    alloc: std.mem.Allocator,
    mem: Memory = Memory{},
    reg: Registers = Registers{},

    pub fn run(self: *Brainfuck, program: []u8) !void {
        std.debug.print("Executing brainfuck:\n\n{s} \n", .{program});
        std.debug.print("address_pointer: {any}\n", .{self.reg.address_pointer});
        std.debug.print("program_counter: {any}\n", .{self.reg.program_counter});
        try self.mem.set(0, 12);
        const res = try self.mem.get(0);
        std.debug.print("res: {any}", .{res});
        self.reg.address_pointer = self.reg.address_pointer + 1;
        std.debug.print("address_pointer: {any}\n", .{self.reg.address_pointer});
    }
};
