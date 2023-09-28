const std = @import("std");

pub fn main() !void {
    const writer = std.io.getStdOut().writer();
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    if (args.len < 3) return error.ExpectedArgument;

    const num1 = try std.fmt.parseInt(i32, args[1], 10);
    const num2 = try std.fmt.parseInt(i32, args[3], 10);
    const operator = args[2];

    if (std.mem.eql(u8, operator, "+")) {
        try writer.print("{d}\n", .{num1 + num2});
    } else if (std.mem.eql(u8, operator, "-")) {
        try writer.print("{d}\n", .{num1 - num2});
    } else if (std.mem.eql(u8, operator, "*")) {
        try writer.print("{d}\n", .{num1 * num2});
    } else if (std.mem.eql(u8, operator, "/")) {
        try writer.print("{d}\n", .{@divTrunc(num1, num2)});
    } else {
        try writer.print("Unknown operator: {s}\n", .{operator});
    }
}
