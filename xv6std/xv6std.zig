pub extern fn fork() c_int;
pub extern fn exec([*c]const u8, [*c][*c]u8) c_int;
pub extern fn exit(c_int) noreturn;
pub extern fn wait([*c]c_int) c_int;
pub extern fn open([*c]const u8, c_int) c_int;
pub extern fn mknod([*c]const u8, c_short, c_short) c_int;
pub extern fn dup(c_int) c_int;
pub extern fn getpid() c_int;
pub extern fn printf([*c]const u8, ...) void;

pub const CONSOLE = @as(c_int, 1);
pub const O_RDONLY = @as(c_int, 0x000);
pub const O_WRONLY = @as(c_int, 0x001);
pub const O_RDWR = @as(c_int, 0x002);
pub const O_CREATE = @as(c_int, 0x200);
