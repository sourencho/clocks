-- GAME

SHOW_DEBUG = false

-- OBJECT
objs={
    player={},
    static={},
    hit_clock={},
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
            idle={
                sprites={23, 24},
                dt=0.1
            },
            run={
                sprites={25, 26, 27, 28, 29},
                dt=0.015
            },
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
        }
    }
end