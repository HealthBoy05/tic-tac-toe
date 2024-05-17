pub const N: c_int = 3;
pub const SCREEN_WIDTH: c_int = 640;
pub const SCREEN_HEIGHT: c_int = 480;
pub const CELL_SIZE_X = SCREEN_WIDTH / N;
pub const CELL_SIZE_Y = SCREEN_WIDTH / N;

pub const symbol = enum { Player1, Player2, None };

pub const turn = enum {
    Player1,
    Player2,
};

pub const state = enum { Running, Tie, Quit };

pub const Color = struct {
    r: c_int,
    g: c_int,
    b: c_int,
    a: c_int,
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
