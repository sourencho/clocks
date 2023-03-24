-- GAME

-- PARAMS
CLOCK_SPEED = 10
OBJ_IMMUNE_DUR = 3

-- DEBUG
SHOW_DEBUG_OBJ = false
SHOW_DEBUG_GRID = false

-- GRID
GRID_START_X = 2
GRID_START_Y = 2
GRID_WIDTH = 12
GRID_HEIGHT = 12
GRID_INVALIDS = {{7,7}, {7,8}, {8,7}, {8,8}}

-- POINTS
points={
    tree_tree=1,
    flower_bloom=1,
    fruit_orange=2
}

-- OBJECT
objs={
    player={},
    collides={},
    holdable={},
    bee_target={},
    hit_bee={},
    hit_clock={},
    hit_player={},
    to_update={},
    to_draw0={},
    to_draw1={},
    to_draw2={},
    to_draw3={},
    to_draw4={},
}

-- ANIMATION
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
            sprites={21,22,21},
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
        plum={
            sprites={57},
            dt=0.1
        },
        cherry={
            sprites={53},
            dt=0.1
        },
        orange={
            sprites={62},
            dt=0.1
        },
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
    },
    portal={
        idle={
            sprites={36,37,38},
            dt=0.05
        }
    },
    sider={
        egg={
            sprites={16},
            dt=0.1,
        },
        side3={
            sprites={1,2},
            dt=0.1,
        },
        side4={
            sprites={17,18},
            dt=0.1,
        },
        side6={
            sprites={49,50},
            dt=0.1,
        },
        side41={
            sprites={35},
            dt=0.1,
        }
    },
    bee={
        idle={
            sprites={115,116},
            dt=0.1
        }
    },
    beehive={
        idle={
            sprites={120},
            dt=0.1
        }
    },
    flower={
        sprout={
            sprites={39},
            dt=0.1
        },
        bloom={
            sprites={118},
            dt=0.1
        }
    }
}