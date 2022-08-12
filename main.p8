pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
#include config.p8
#include mouse.p8
#include core.p8
#include object.p8
#include physics.p8
#include graphics.p8
#include grid.p8
#include spawner.p8
#include player.p8
#include static.p8
#include coroutine.p8
#include particle.p8
#include text.p8
#include graphics_util.p8
#include physics_util.p8
#include util.p8
#include clock.p8
#include tree.p8
#include fruit.p8
#include season.p8
__gfx__
00000000222222222222222077000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000002e2222e22e2222e270000007000000000000000000077700000777000000000000077700000777000000000000000000000000000000000000000000
007007002277277222222222000000000000000000077700007d7d70007d7d7000077700007d7d70007d7d700007770000077700000777000077700000777000
000770002777277222eeee220000000000077700007d7d700077770000777700007d7d700077770000777700007d7d70007d7d70007d7d7007d7d70707d7d700
00077000777222770222222000000000007d7d700077770000000000007007000077770000700707000707000077770000777700007777000777777007777700
00700700022222200222222000000000007777000000000000000000007007000070070000700070077000770007070000070700007007000700000007000070
00000000022222200222222070000007000000000000000000000000007007000700007007000000000000000770007000700070007000700700000007000070
00000000220000222200002277000077000000000000000000000000007007000070070000000000000000000000000707000700070000707000000070000700
00000000000000000000000088000088000000000000000007777770077777700000000007777770077777700000000000000000000000000000000000000000
000000000000000000000000800000080000000007777770077d7d70077d7d7007777770077d7d70077d7d700777777007777770077777707777770077777700
0000000000000000000000000000000007777770077d7d700777777007777770077d7d700777777007777770077d7d70077d7d70077d7d7077d7d70077d7d700
00000000000000000000000000000000077d7d700777777007777770077777700777777007777770077777700777777007777770077777707777770777777700
00000000000000000000000000000000077777700777777000000000007007000777777000700707000707000777777007777770077777707777777077777700
00000000000000000000000000000000077777700000000000000000007007000070070000700070077000770007070000070700007007000700000007000070
00000000000000000000000080000008000000000000000000000000007007000700007007000000000000000770007000700070007000700700000007000070
00000000000000000000000088000088000000000000000000000000007007000070070000000000000000000000000707000700070000707000000070000700
00000000000000000000000000000000000000000000000000000000000000000000000000bbbb0000bbbb00009a99000076770000bbbb000040000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000bbbbbb00b9bbbb00a9999a0077767600b9bbbb000240400000b0b00
0000000000000000000000000000000000000000000000000000000000000000000bb0000bbbbbb00bbbb9b009999a90067777700bbbb9b0000242000003b300
0000000000000000000000000000000000000000000000000000000000b0b00000bbbb000bbbbbb00bb9bbb009a99990077676700bb9bbb0040040400000b000
00000000000000000000000000000000000000000000000000000000003b300000bbbb0003bbbb3003bbbb300299a9200677776003bbbb300240442000444440
00000000000000000000000000000000000000000000000000000000000b00000034430000344300003443000024420000644600003443000024420000244420
00000000000000000000000000000000000000000000000000000000000300000004400000044000000440000004400000044000000440000004400000044400
00000000000000000000000000000000000000000000000000000000000000000002200000022000000220000002200000022000000220000002200000044400
000000000077a0000077a00000000000000000000000000000000000000000000006600000000000007000000000000000000000000000000000000000000000
0000000007222a0007222a000000000000000000000000000000000000aaaa000005660000003000707070000066600000000000000000000000000000000000
000000000700090007000900000000000000000000000000000000000aaaaaa00000566000099300c7c7c0000666660000444400004444000000000000000000
000000000a0009000a000900000000000000000000000000000000000aaaaaa00000066000999900070700000666666004999940042222400000000000000000
0000000002aa920002aa9200000000000000000000000000000000000aaaaaa000000660009999007c7c70000555555004999940042222400000000000000000
0000000000a2900000a290000000000000000000000000000000000009aaaa900000665000499400c070c00000c00c0002444420024444200000000000000000
0000000000a029000a2090000000000000000000000000000000000000999900006665000004400000c000000c00c00000222200002222000000000000000000
00000000002002000200200000000000000000000000000000000000000000000055500000000000000000000000000000000000000000000000000000000000
000aaaaaaaaaaaaaaaaaa000aaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
00aaaaaaaaaaaaaaaaaaaa00aaaaaaaaaaaa99999999aaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaaaaaaaaaaaaaaaaaaaa0aaaaaaaaaaa9000000009aaa00000000000000000000000770000000000000000000000000000000000000000000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000aaa00000000000000000000007777000000000000000000000000000000000000000000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000aaa00000000000000000000007777000000000000000000000000000000000000000000000000000000
aaaaaaaa99999999aaaaaaaaaaaaaaaaaaaa00000000aaaa00000077000000000000007777000000000000007700000000000000000000000000007700000000
aaaaaaa9999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000777700000000000006776000000000000077770000000000000077000000000077770000000
aaaaaa990000000099aaaaaa99999999999999999999999900000777770000000000000660000000000000777770000000000000777700000000077777000000
aaaaaa900000000009aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000677770000000000000000000000000000777760000000000007777700000000067777000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000067760000000000000000000000000000677600000000000007777600000000006776000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000006600000000000000000000000000000066000000000000006776000000000000660000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000000000000000000000000000000000000000000000000000000660000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa00aaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaa0000000000aaaaaaa9999999999999999999999990000000770000000777777000000000000777777000000000000000000000000a666660000000000
aaaaaaaa00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000007777000000677776000000000000677776000000000000000000000000a666660000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999aaaa0000007777000000066660000000000000066660000000000000000000000000a666660000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9000000009aaa00000077770000000000000000000000000000000000000000000000006660009666660000000000
9aaaaaaaaaaaaaaaaaaaaaa9aaaaaaaaaaa0000000000aaa00000067760000000000000000000000000000000000000000000000066666000566650000000000
99aaaaaaaaaaaaaaaaaaaa99aaaaaaaaaaa0000000000aaa00000006600000000000000000000000000000000000000000000000a66666000055500000000000
999aaaaaaaaaaaaaaaaaa999aaaaaaaaaaaa00000000aaaa00000000000000000000000007777000000000000007777000000000a66666000000000000000000
999999999999999999999999aaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000077777700000000000077777700000000a66666000000000000000000
09999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00999999999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000006363636465636363000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000005555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000004343434445434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000004041414141414141414141414142000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000050464700000048490000004a4b52000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000054565700000058590000005a5b53000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005400000000000000000000000053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005400000000000000000000000053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005400000000000000000000000053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000546b0000000000000000000069536d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000546a0000000000000000000068536e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005400000000000000000000000053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005400000000000000000000000053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005400000000000000000000000053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000544a4b00000000000000004e4f53000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000545a5b00000066670000005e5f53000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000006061616161616161616161616162000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000007071716363636465636363717172000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000005555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000004343434445434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
