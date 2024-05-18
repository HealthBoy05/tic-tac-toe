const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
    @cInclude("SDL2/SDL2_gfxPrimitives.h");
});
const print = std.debug.print;
const r = @import("./render.zig");
const g = @import("./game.zig");
const l = @import("./logic.zig");

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_EVERYTHING) != 0) {
        c.SDL_Log("error in Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    }

    const window = c.SDL_CreateWindow("tic tac toe", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, g.SCREEN_WIDTH, g.SCREEN_HEIGHT, c.SDL_WINDOW_OPENGL) orelse {
        c.SDL_Log("error in Window Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    };
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_SOFTWARE) orelse {
        c.SDL_Log("error in Render Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    };
    defer c.SDL_DestroyRenderer(renderer);

    const game: g.Game = g.Game{
        .turn = g.turn.Player1,
        .board = .{
            .{ g.symbol.None, g.symbol.None, g.symbol.None },
            .{ g.symbol.Player1, g.symbol.None, g.symbol.Player2 },
            .{ g.symbol.None, g.symbol.None, g.symbol.Player1 },
        },
        .state = g.state.Over,
    };
    var quit = false;
    var event: c.SDL_Event = undefined;
    while (!quit) {
        while (c.SDL_PollEvent(&event) == 1) {
            switch (event.type) {
                c.SDL_QUIT => quit = true,
                c.SDL_MOUSEBUTTONDOWN => {
                    var x: c_int = undefined;
                    var y: c_int = undefined;

                    _ = c.SDL_GetMouseState(&x, &y);
                    print("{} {}\n", .{ x, y });
                },
                else => {},
            }
        }
        _ = c.SDL_SetRenderDrawColor(renderer, 255, 255, 255, c.SDL_ALPHA_OPAQUE);
        _ = c.SDL_RenderClear(renderer);
        r.render(renderer, game);
        c.SDL_RenderPresent(renderer);
        c.SDL_Delay(3);
    }
}
