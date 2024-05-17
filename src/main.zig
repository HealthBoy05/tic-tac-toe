const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
});
const r = @import("./render.zig");
const g = @import("./game.zig");
const l = @import("./logic.zig");

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_EVERYTHING) != 0) {
        c.SDL_Log("error in Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    }

    const window = c.SDL_CreateWindow("tic tac toe", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, g.SCREEN_HEIGHT, g.SCREEN_WIDTH, c.SDL_WINDOW_OPENGL) orelse {
        c.SDL_Log("error in Window Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    };
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_SOFTWARE) orelse {
        c.SDL_Log("error in Render Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    };
    defer c.SDL_DestroyRenderer(renderer);

    var quit = false;
    var event: c.SDL_Event = undefined;
    while (!quit) {
        while (c.SDL_PollEvent(&event) == 1) {
            switch (event.type) {
                c.SDL_QUIT => quit = true,
                else => {},
            }
        }
        _ = c.SDL_RenderClear(renderer);
        _ = c.SDL_SetRenderDrawColor(renderer, 125, 125, 125, c.SDL_ALPHA_OPAQUE);
        _ = c.SDL_RenderDrawLine(renderer, 0, 0, 480, 600);
        _ = c.SDL_RenderDrawLine(renderer, 480, 600, 0, 0);
        c.SDL_RenderPresent(renderer);
        r.render(renderer);
        c.SDL_Delay(3);
    }
}
