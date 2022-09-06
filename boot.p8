pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
#include config.p8
#include coroutine.p8
#include mouse.p8
#include main.p8
#include object.p8
#include physics.p8
#include graphics.p8
#include grid.p8
#include spawner.p8
#include player.p8
#include static.p8
#include particle.p8
#include text.p8
#include graphics_util.p8
#include physics_util.p8
#include util.p8
#include clock.p8
#include tree.p8
#include fruit.p8
#include season.p8
#include sider.p8
#include portal.p8
#include bee.p8
#include beehive.p8
#include level.p8
__gfx__
00000000000000000000000077000077000000000000000000088000000880000000000000088000000880000000000000000000000000000000000000000000
00000000000700000007000070000007000000000008800000077700000777000008800000077700000777000008800000088000000880000088000000880000
007007000072a0000072a000000000000008800000077700007d7d70007d7d7000077700007d7d70007d7d700007770000077700000777000077700000777000
0007700007202900072029000000000000077700007d7d700077770000777700007d7d700077770000777700007d7d70007d7d70007d7d7007d7d70707d7d700
0007700002aa920002aa920000000000007d7d700077770000000000007007000077770000700707000707000077770000777700007777000777777007777700
0070070000a2900000a2900000000000007777000000000000000000007007000070070000700070077000770007070000070700007007000700000007000070
0000000000a029000a20900070000007000000000000000000000000007007000700007007000000000000000770007000700070007000700700000007000070
00000000002002000200200077000077000000000000000000000000007007000070070000000000000000000000000707000700070000707000000070000700
00000000000000000000000000000000000000000000000007777770077777700000000007777770077777700000000000000000000000000000000000000000
000000000777aa000777aa00000000000000000007777770077d7d70077d7d7007777770077d7d70077d7d700777777007777770077777707777770077777700
0007a00007222a0007222a000000000007777770077d7d700777777007777770077d7d700777777007777770077d7d70077d7d70077d7d7077d7d70077d7d700
00722a00070009000700090000000000077d7d700777777007777770077777700777777007777770077777700777777007777770077777707777770777777700
007009000aaa99000aaa990000000000077777700777777000000000007007000777777000700707000707000777777007777770077777707777777077777700
0029920002a2920002a2920000000000077777700000000000000000007007000070070000700070077000770007070000070700007007000700000007000070
0002200000a029000a20900000000000000000000000000000000000007007000700007007000000000000000770007000700070007000700700000007000070
00000000002002000200200000000000000000000000000000000000007007000070070000000000000000000000000707000700070000707000000070000700
00aaaa0000070000000700000007a000066666600666666006666660000000000000000000bbbb0000bbbb00009a99000076770000bbbb000040000000000000
0a1111a00072a0000072a00000722a006cccccc66cccccc66dddddd600000000000000000bbbbbb00bfbbbb00a9999a0077767600b9bbbb000240400000b0b00
a119111a07202a0007202a00072002a06cccccc66cddddc66dccccd600000000000bb0000bbbbbb00bbbbfb009999a90067777700bbbb9b0000242000003b300
a119111a070009000a000900070000906ccddcc66cdccdc66dccccd600b0b00000bbbb000bbbbbb00bbfbbb009a99990077676700bb9bbb0040040400000b000
a119991a02aa920002aa92000a0000906cccccc66cddddc66dccccd6003b300000bbbb0003bbbb3003bbbb300299a9200677776003bbbb300240442000444440
a111111a00a2900000a2900002aa99206cccccc66cccccc66dddddd6000b00000034430000344300003443000023420000644600003443000024420000244420
0a1111a000a029000a20900000222200566666655666666556666665000300000004400000044000000440000004400000044000000440000004400000044400
00aaaa00002002000200200000000000055555500555555005555550000000000002200000022000000220000002200000022000000220000002200000044400
00000000007aa000007aa0000077a0000077a0000000000000000000000000000006600000000000007000000000000000000000000000000000000000b0bb00
00a00a0007222a0007222a0007222a0007222a00000bb00000b0bb0000aaaa00000566000000b00070707000006660000000000000000000000b0000000bb000
009aa9007200029072000290070009000700090000b0b000000bb0000aaaaaa000005660000ddb00c7c7c00006666600004444000044440000b9900000099000
0a0aa0a02a0009202a0009200a0009000a00090008800b0000eeee000aaaaaa00000066000dddd00070700000666666004999940042222400099990000999900
09eeee9002aa920002aa920002aa920002aa92000880088000eeee000aaaaaa00000066000dddd007c7c70000555555004999940042222400099990000999900
002ee20000a2900000a2900000a2900000a290000220088000eeee0009aaaa9000006650005dd500c070c00000c00c0002444420024444200049940000499400
00a22a0000a029000a20900000a029000a20900000000220002ee20000999900006665000005500000c000000c00c00000222200002222000004400000099000
00900900002002000200200000200200020020000000000000022000000000000055500000000000000000000000000000000000000000000000000000044000
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
00999999999999999999990000000000000000000000000000000eee0000eee00044400000099000000000000000000000000000000000000000000000000000
00099999999999999999900000dada0000000000000000000eee0e2e0000e1e004444400009aa900000000000000000000000000000000000000000000000000
0000000000000000000000000adada0000dada00000000000e2e0eee0b00eee00fffff0009aaaa90000000000000000000000000000000000000000000000000
00000000000000000000000009dad9000adada00000000000eee02b2b3b02b2004444400049aa940000000000000000000000000000000000000000000000000
0000000000000000000000000099900009dad9000000000002b20b3030b0b3000fffff0000499400000000000000000000000000000000000000000000000000
000000000000000000000000000000000099900000000000003b0b0000b0b0000244420000044000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000030300003030000022200000000000000000000000000000000000000000000000000000000000
__map__
0000000043434344454343430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0040414141414141414141414141420000404141414141414141414141414200004041414141414141414141414142000040414141414141414141414141420000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0050000000000048490000000000520000500000000000000000000000285200005000000000000000000000000052000050000000000000000000000000520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00540046470000000000004a4b00530000540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00540056570000000000005a5b00530000540000000000000000000000005300005400000000000000003700000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000540000000000000000000000005300005400000000000000000000000053000054000000000000007800000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00546b0000000000000000000069536d00540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00546a0000000000000000000068536e00540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000000000000000000530000540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054004a4b0000000000004e4f00530000540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054005a5b0000000000005e5f00530000540000000000000000000000005300005400000000000000000000000053000054000000000000000000000000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054000000000066670000000000530000542800000000000000000000245300005428000000000000000000002453000054270000000000000000000024530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0060616161616161616161616161620000606161616161616161616161616200006061616161616161616161616162000060616161616161616161616161620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070717163636364656363637171720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
