// zinit: xv6-riscv init system in zig
const std = @import("xv6std/xv6std.zig");

pub export fn main() u8 {
    var pid: c_int = undefined;
    var wpid: c_int = undefined;
    const initpid: c_int = std.getpid();

    if (std.open("console", std.O_RDWR) != 0) {
        _ = std.mknod("console", std.CONSOLE, 0);
        _ = std.open("console", std.O_RDWR);
    }

    _ = std.dup(0); // stdout
    _ = std.dup(0); // stderr
    std.printf("zinit: console, stdout and stderr initialized\n");

    if (initpid != 1) {
        std.printf("zinit: cannot run as pid %d\n", initpid);
        std.exit(127);
    }

    const argv = &[_:null]?[*:0]const u8{"sh"};
    while (true) {
        std.printf("zinit: starting sh\n");
        pid = std.fork();
        if (pid < 0) {
            std.printf("zinit: fork failed\n");
            _ = std.exit(1);
        }
        if (pid == 0) {
            _ = std.exec("sh", @constCast(@ptrCast(argv)));
            std.printf("zinit: exec sh failed\n");
            _ = std.exit(1);
        }
        while (true) {
            wpid = std.wait(@as([*c]c_int, 0));
            if (wpid == pid) {
                break;
            } else if (wpid < 0) {
                std.printf("zinit: wait returned an error\n");
                _ = std.exit(1);
            } else {}
        }
    }
    return 0;
}
