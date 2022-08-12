-- GAME

-- PARAMS
CLOCK_SPEED = 10
OBJ_IMMUNE_DUR = 2

-- DEBUG
SHOW_DEBUG_OBJ = false
SHOW_DEBUG_GRID = false

-- GRID
GRID_START_X = 2
GRID_START_Y = 2
GRID_WIDTH = 12
GRID_HEIGHT = 12
GRID_INVALIDS = {{7,7}, {7,8}, {8,7}, {8,8}}

-- OBJECT
objs={
    player={},
    static={},
    holdable={},
    hit_clock={},
    hit_player={},
    to_update={},
    to_draw0={},
    to_draw1={},
    to_draw2={},
    to_draw3={},
    to_draw4={}
}

-- ANIMATION
function init_anim_info()
    anim_info={
        player={
            idle_adult={
                sprites={23, 24},
                dt=0.1
            },
            run_adult={
                sprites={25, 26, 27, 28, 29},
                dt=0.015
            },
            dash_adult={
                sprites={37,21,22,21},
                dt=0.015
            },
            idle_baby={
                sprites={07, 08},
                dt=0.1
            },
            run_baby={
                sprites={09,10,11,12,13},
                dt=0.015
            },
            dash_baby={
                sprites={04,05,06,05},
                dt=0.015
            }
        },
        tree={
            sapling={
                sprites={39},
                dt=0.1
            },
            bush={
                sprites={40},
                dt=0.1
            },
            tree={
                sprites={41},
                dt=0.1
            },
            tree_fruit={
                sprites={42},
                dt=0.1
            },
            tree_dry={
                sprites={46},
                dt=0.1
            }
        },
        fruit={
            idle={
                sprites={57},
                dt=0.1
            }
        },
        season={
            summer={
                sprites={55},
                dt=0.1
            },
            cloud={
                sprites={59},
                dt=0.1
            },
        }
    }
end