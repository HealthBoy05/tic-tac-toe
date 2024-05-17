const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
    @cInclude("SDL2/SDL2_gfxPrimitives.h");
});
const red = g.Color{ .r = 255, .g = 0, .b = 0, .a = 255 };
const g = @import("./game.zig");
const l = @import("./logic.zig");
const N = 3;

pub fn render(ren: *c.SDL_Renderer) void {
    const x1: c_int = 0;
    const x2: c_int = 500;
    const y1: c_int = 0;
    const y2: c_int = 500;
    _ = c.SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);
    _ = c.SDL_RenderDrawLine(ren, x1, y1, x2, y2);
}
