const std = @import("std");

const Memory = @import("memory.zig").Memory;
const Registers = @import("registers.zig").Registers;
const Brackets = @import("brackets.zig").Brackets;

pub const Brainfuck = struct {
    alloc: std.mem.Allocator,
    brackets: Brackets,
    mem: Memory = Memory{},
    reg: Registers = Registers{},

    pub fn init(alloc: std.mem.Allocator) Brainfuck {
        return Brainfuck{
            .alloc = alloc,
            .brackets = Brackets.init(alloc),
        };
    }

    pub fn deinit(self: *Brainfuck) void {
        self.brackets.deinit();
    }

    pub fn run(self: *Brainfuck, program: []u8) !void {
        std.debug.print("Executing brainfuck:\n\n{s} \n", .{program});

        try self.brackets.map(self.alloc, program);

        while (self.reg.program_counter < program.len) {
            const char = program[self.reg.program_counter];

            switch (char) {
                '>' => self.movePointerRight(),
                '<' => self.movePointerLeft(),
                '+' => try self.increaseCell(),
                '-' => try self.decreaseCell(),
                '.' => try self.logCell(),
                ',' => try self.replaceValue(),
                '[' => try self.jumpToClose(),
                ']' => try self.jumpToOpen(),
                else => {},
            }

            self.reg.program_counter = self.reg.program_counter + 1;
        }
    }

    fn movePointerRight(self: *Brainfuck) void {
        self.reg.address_pointer += 1;
    }

    fn movePointerLeft(self: *Brainfuck) void {
        self.reg.address_pointer -= 1;
    }

    fn increaseCell(self: *Brainfuck) !void {
        const value = try self.mem.get(self.reg.address_pointer);
        const new = value +% 1;
        try self.mem.set(self.reg.address_pointer, new);
    }

    fn decreaseCell(self: *Brainfuck) !void {
        const value = try self.mem.get(self.reg.address_pointer);
        const new = value -% 1;
        try self.mem.set(self.reg.address_pointer, new);
    }

    fn logCell(self: *Brainfuck) !void {
        const stdout = std.io.getStdOut().writer();
        const value = try self.mem.get(self.reg.address_pointer);
        try stdout.writeByte(value);
    }

    fn replaceValue(self: *Brainfuck) !void {
        const stdin = std.io.getStdIn().reader();
        const value = try stdin.readByte();
        try self.mem.set(self.reg.address_pointer, value);
    }

    fn jumpToClose(self: *Brainfuck) !void {
        const value = try self.mem.get(self.reg.address_pointer);
        if (value > 0) {
            return;
        }

        const pair = self.brackets.findPair(self.reg.program_counter).?;
        self.reg.program_counter = pair.close;
    }

    fn jumpToOpen(self: *Brainfuck) !void {
        const value = try self.mem.get(self.reg.address_pointer);
        if (value == 0) {
            return;
        }

        const pair = self.brackets.findPair(self.reg.program_counter).?;
        self.reg.program_counter = pair.open;
    }
};
