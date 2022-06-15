pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
#include config.p8
#include core.p8
#include object.p8
#include physics.p8
#include graphics.p8
#include player.p8
#include static.p8
#include coroutine.p8
#include graphics_util.p8
#include physics_util.p8
#include util.p8
#include clock.p8
#include tree.p8
#include fruit.p8
#include season.p8
__gfx__
00000000222222222222222000000000000000000077a0000077a000000000000000000000000000000000000000000000000000000000000000000000000000
000000002e2222e22e2222e2000700000007000007222a0007222a00000000000007700000077000000770000000000000000000000000000007707000000000
0070070022772772222222220072a0000072a0000700090007000900000000000007700000077000000770000007700000077000000770000007707007077000
000770002777277222eeee2207202900072029000a0009000a000900000000007777777707777700007770000007700000077000000770000777770007077000
00077000777222770222222002aa920002aa920002aa920002aa9200000000000007700070077077070777700077700000777700077777007007700000777700
00700700022222200222222000a2900000a2900000a2900000a29000000000000007777000077700070770000077770007077700700770770007770000077070
00000000022222200222222000a029000a20900000a029000a209000000000000007000007700070077007000770070007777070000770000007007007707070
00000000220000222200002200200200020020000020020002002000000000000070000000000000000000700000070000007000000700000007000000007000
00000000000000000000000000000000000000000000000000000000077777700000000007777770077777700000000000000000000000000000000000000000
0000000000000000000000000777aa000777aa000000000000000000077d7d7007777770077d7d70077d7d700777777007777770077777707777770077777700
00000000000000000000000007222a0007222a00000000000000000007777770077d7d700777777007777770077d7d70077d7d70077d7d7077d7d70077d7d700
00000000000000000000000007000900070009000000000000000000077777700777777007777770077777700777777007777770077777707777770777777700
0000000000000000000000000aaa99000aaa99000000000000000000007007000777777000700707000707000777777007777770077777707777777077777700
00000000000000000000000002a2920002a292000000000000000000007007000070070000700070077000770007070000070700007007000700000007000070
00000000000000000000000000a029000a2090000000000000000000007007000700007007000000000000000770007000700070007000700700000007000070
00000000000000000000000000200200020020000000000000000000007007000070070000000000000000000000000707000700070000707000000070000700
00000000000000000000000000070000000700000000000000000000000000000000000000bbbb0000bbbb00009a99000076770000bbbb000040000000000000
0000000000000000000000000072a0000072a000000000000000000000000000000000000bbbbbb00b9bbbb00a9999a0077767600b9bbbb000240400000b0b00
00000000000000000000000007202a0007202a00000000000000000000000000000bb0000bbbbbb00bbbb9b009999a90067777700bbbb9b0000242000003b300
000000000000000000000000070009000a00090000000000000000000000000000bbbb000bbbbbb00bb9bbb009a99990077676700bb9bbb0040040400000b000
00000000000000000000000002aa920002aa9200000000000000000000b0b00000bbbb0003bbbb3003bbbb300299a9200677776003bbbb300240442000444440
00000000000000000000000000a2900000a290000000000000000000003b30000034430000344300003443000024420000644600003443000024420000244420
00000000000000000000000000a029000a2090000000000000000000000b00000004400000044000000440000004400000044000000440000004400000044400
00000000000000000000000000200200020020000000000000000000000300000002200000022000000220000002200000022000000220000002200000044400
000000000000000000000000007aa000007aa0000000000000000000000000000006600000000000007000000000000000000000000000000000000000000000
00000000000000000000000007222a0007222a00000000000000000000aaaa000005660000003000707070000066600000000000000000000000000000000000
000000000000000000000000720002907200029000000000000000000aaaaaa00000566000099300c7c7c0000666660000000000000000000000000000000000
0000000000000000000000002a0009202a00092000000000000000000aaaaaa00000066000999900070700000666666000000000000000000000000000000000
00000000000000000000000002aa920002aa920000000000000000000aaaaaa000000660009999007c7c70000555555000000000000000000000000000000000
00000000000000000000000000a2900000a29000000000000000000009aaaa900000665000499400c070c00000c00c0000000000000000000000000000000000
00000000000000000000000000a029000a209000000000000000000000999900006665000004400000c000000c00c00000000000000000000000000000000000
00000000000000000000000000200200020020000000000000000000000000000055500000000000000000000000000000000000000000000000000000000000
000aaaaaaaaaaaaaaaaaa000aaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
00aaaaaaaaaaaaaaaaaaaa00aaaaaaaaaaaa99999999aaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaaaaaaaaaaaaaaaaaaaa0aaaaaaaaaaa9000000009aaa00000000000000000000000770000000000000000000000000000000000000000000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000aaa00000000000000000000007777000000000000000000000000000000000000000000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000aaa00000000000000000000007777000000000000000000000000000000000000000000000000000000
aaaaaaaa99999999aaaaaaaaaaaaaaaaaaaa00000000aaaa00000077000000000000007777000000000000007700000000000000000000000000007700000000
aaaaaaa9999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000777700000000000006776000000000000077770000000000000077000000000077770000000
aaaaaa990000000099aaaaaa99999999999999999999999900000777770000000000000660000000000000777770000000000000777700000000077777000000
aaaaaa900000000009aaaaaa00aaaaaaaaaaaa000000000000000677770000000000000000000000000000777760000000000007777700000000067777000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000067760000000000000000000000000000677600000000000007777600000000006776000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000006600000000000000000000000000000066000000000000006776000000000000660000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000660000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa000000000000aaaaaa00aaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaa0000000000aaaaaaa9999999999999999999999990000000770000000777777000000000000777777000000000000000000000000a666666000000000
aaaaaaaa00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000007777000000677776000000000000677776000000000000000000000000a666666000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999aaaa0000007777000000066660000000000000066660000000000000000000666600a666666000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9000000009aaa00000077770000000000000000000000000000000000000000000000066666609666666000000000
9aaaaaaaaaaaaaaaaaaaaaa9aaaaaaaaaaa0000000000aaa00000067760000000000000000000000000000000000000000000000066666600666666000000000
99aaaaaaaaaaaaaaaaaaaa99aaaaaaaaaaa0000000000aaa00000006600000000000000000000000000000000000000000000000a66666600566665000000000
999aaaaaaaaaaaaaaaaaa999aaaaaaaaaaaa00000000aaaa00000000000000000000000007777000000000000007777000000000a66666600055550000000000
999999999999999999999999aaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000077777700000000000077777700000000a66666600000000000000000
09999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00999999999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000043434344454343430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0040414141414141414141414141420000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0050464700000048490000004a4b520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054565700000058590000005a5b530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00546b0000000000000000000069536d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00546a0000000000000000000068536e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00544a4b00000000000000004e4f530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00545a5b00000066670000005e5f530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0060616161616161616161616161620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070717163636364656363637171720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
