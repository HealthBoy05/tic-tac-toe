pub const N: c_int = 3;
pub const SCREEN_WIDTH: c_int = 640;
pub const SCREEN_HEIGHT: c_int = 480;
pub const CELL_SIZE_X = SCREEN_WIDTH / N;
pub const CELL_SIZE_Y = SCREEN_HEIGHT / N;
pub const PLAYER_X_COLOR = Color{ .r = 255, .g = 0, .b = 0, .a = 255 };
pub const PLAYER_Y_COLOR = Color{ .r = 0, .g = 0, .b = 255, .a = 255 };
pub const PLAYING_COLOR = Color{ .r = 125, .g = 125, .b = 125, .a = 255 };

pub const symbol = enum { Player1, Player2, None };

pub const turn = enum {
    Player1,
    Player2,
};

pub const state = enum { Running, Tie, Over, Quit };

pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

pub const Player = struct {
    symbol: u8,
    color: Color,
};

pub const Game = struct {
    board: [3][3]symbol,
    turn: turn,
    state: state,
};
