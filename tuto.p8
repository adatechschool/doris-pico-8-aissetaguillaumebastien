pico-8 cartridge // http://www.pico-8.com
version 38
__lua__



function _init()
p={
x=5,
y=5,
dx=0,
dy=0,
h=8,
w=8,
keys=0,
sprite=1
}
create_snow()
state=0

timer=0
blinking=true
init_msg()
end

function _draw()
	cls()
	if (state<=5) draw_game() 
	if (state>5) draw_gameover()
end


function  _update()

if (state<=5) update_game()
if (state>5) update_gameover()
end

function is_grounded()
bloc=mget(flr(p.x+4)/8,flr(p.y)/8+1)

return fget(bloc,0)

end



function draw_game()
cls()
draw_background()
map(0,0,0,0,127,64)

	if (is_grounded()) then
	p.y=flr(flr(p.y)/8)*8
	end
	spr(1,p.x,p.y)	
	for s in all(snow) do
	pset(s.x,s.y,s.col)
 end
 print(p.keys,camx+15,5,1)
 spr(32,camx+3,3)
 draw_msg()
 

end


function update_game()
update_camera()
p.dx=0
if not check_flag(2,(p.x+8)/8,p.y/8) then
		if (btn(0)) p.dx=-1
if not check_flag(2,(p.x+0)/8,p.y/8) then
  
  if (btn(1)) p.dx=1
  p.x+=p.dx
end
end
interact((p.x)/8,(p.y)/8)

if check_flag(1,(p.x)/8,(p.y)/8) then
	state +=1
	end
	
	


if (is_grounded()) then
p.dy=0
if(btnp(2))p.dy=-5.5
else
p.dy+=0.3
if(p.dy>4)p.dy=4

end
p.y+=p.dy

update_snow()

update_msg()

end

function update_gameover()
timer+=1
if (btn(❎)) then _init()

end
end
-->8
--camera

function update_camera()
camx=mid(0,p.x-(7.5*8),127*8)
--camy=mid(0,p.y+7.5,16)
camera(camx)
end

--fond
function draw_background()
 rectfill(0,0,127*8,127*8,13)
 rectfill(0,95,127*8,127*8,7)
 end
-->8
--effets
function update_snow()
 for s in all(snow) do
	s.y+=s.speed
  if s.y>128 then
		s.y=0
		s.x=rnd(127*8)
  end
 end
end

function create_snow()
snow={}
for i=1,150 do
local new_snow={
x=rnd(128),
y=rnd(128),
col=6,
speed=2}
add(snow, new_snow)
 end
end

-->8
-- flag 
	
function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

-->8
-- ecran de gameover
function draw_gameover()
cls()
 rectfill(0,0,128,128,0)
 print('game over !!!',p.x-18,46,2)
 print('game over !!!',p.x-18,45,8)
	if timer%20 == 0 then 
	blinking = not blinking
	end
	if blinking then 
	print('appuyez sur x', p.x-20,71,1)
	print('pour ressayer !',p.x-23,81,1)
	print('appuyez sur x', p.x-20, 70,9)
	print('pour ressayer !',p.x-23, 80,9)
	end
end
-->8
--messages 

function init_msg()
message={}
create_msg("l'eveil d'amazonia","appuyez sur ❎ pour commencer")
end

function create_msg(name,...)

msg_title=name
messages={...}
end

function update_msg()
	if btnp(❎) then
	deli(messages,1)
end
end 

function draw_msg()
if messages[1] then
local y=15


 rectfill(7,y,7+#msg_title*4,y+20,2)
 print (msg_title,10,y+2,9)

 rectfill(3,y+8,124,y+24,4)
 rect(3,y+8,124,y+24,4)
 print(messages[1],6,y+11,15)
end
end
-->8
-- objets

function next_tile(x,y)
local sprite=mget(x,y)
mset(x,y,sprite+1)
end

function pick_up_key(x,y)
next_tile(x,y)
p.keys+=1
end


function interact(x,y)
if check_flag(3,x,y)then
pick_up_key(x,y)
--elseif check_flag(4,x,y)
--and p.keys>0 then 
--open_door(x,y)
 end
end

function open_door(x,y)
next_tile(x,y)
p.keys-=1
end  
 
 
 
 
 
 
 
 
 
 
 
 
__gfx__
0000000000039a000000000000039a00000000006666666611111111609820d03333333366333334666333336666566677555577000000000000000000000000
000000000334446000039a000334443000011100666666661111111156666d5033333333d3944449563333336665dd6657686875000000000000000000000000
00700700334414660334443033414410011ccc106666666611111111000600003333b3b339433363534333336665556657666675000000000000000000000000
0007700033444406334144103344444011c0cc0066666666111111110550550033333b33343f363333343333665dddd655566555000000000000000000000000
00077000000b400633444440000b4b0011ccccc055555555111111116066d0d03333b33334336333333343336655555677111177000000000000000000000000
0070070000bb7446000b4b0000b7b7000006c60077777777111111119055502033333333343637733333377365dddddd77655677000000000000000000000000
000000000bbbb06600b7b7000b4bb4000067670066666666111111110060d00033b3333334633f7733333f776655555677677677000000000000000000000000
00000000000550600bb4bb4000000000066c6c0066666666111111110660dd00333333334933337f333333f36666666676677667000000000000000000000000
0000000000055000777677767776777777667777767777761111111111111144111111114411111111111111dddddddd55555555000000000000000000000000
49444494055000007cc7ccc67ccccc767cc7cc777cccccc71111111111111144111111114411111111111111dddddddd55555555000000000000000000000000
44000094565500006cccc7c77cc7ccc77cccc7c77cccc7c71111111111111144111111114411111111111111dddd11dd55555555000000000000000000000000
04900440566550006cccccc77ccc6cc67c7cccc677ccccc71111111111111144111111114411111111111111ddd1551d55555555000000000000000000000000
00444400566651006c7ccc7776ccccc77ccc6cc666ccccc7171ffff11111114411ffffff44111111ffffff11d115551d55555555000000000000000000000000
00094000552661107ccccc7777c7ccc77ccc6cc776ccccc6155555511111114411ffffff44111111ffffff11d555555d55555555000000000000000000000000
000440005652661177ccccc77cccc77767ccccc7777ccc771411114111111144555555554411111155555555d565655d55555555000000000000000000000000
0004400056661661767777767776777776776777776667771411114111111144555555554411111155555555d555555d55555555000000000000000000000000
0aa00000000000006cccccc70000000077777777ddddddddc0c00c0c0000000066666666dddddddd66666666d565655d00000000000000000000000000000000
aaaa0000000000006c77c7c70000000077777777dddddddd0c6776c00000000066666666dddddddd66666666d555555d00000000000000000000000000000000
a9aaaaaa0000000016ccc6660000000077667777ddddd7ddc667766c00000000655556665dd5555566666666d565655d00000000000000000000000000000000
a0aaaaaa00000000116c7c110000a10077667777dd76dd6d0006c00000000000657775665dd5656566666666d555555d00000000000000000000000000000000
aaaa9a9a000000001116cc11000aa10066666677d7776ddd070c600000000000677777565dd5555566666666d565655d00000000000000000000000000000000
9aa90909000000001111c11100aaaa1066666677dd76ddddc660066c00000000677777565dd5656566666666d555555d00000000000000000000000000000000
0990000900000000111111110aaaaaa166666677ddddd67d0c6006c000000000677777565dd5555566666666d555555d00000000000000000000000000000000
0000000000000000111111110aaaaaa166666677ddddddddc0c00c0c00000000657775565dd5656566666666d555555d00000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000060ddd0d00000000000000000000000007777777700000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000568686500000000000000000000000007777677600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000006660000000000000000000000000006676676600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000055055000000000000000000000000006666666600000000000000000000000000000000
000000000000000000000000000000000000000000000000000000006066d0d00000000000000000000000006666666600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000905550200000000000000000000000006666666600000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000060d0000000000000000000000000006666666600000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000660dd000000000000000000000000006666666600000000000000000000000000000000
__gff__
0000000000000002000000000000000000000505050500000000000000000000080000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
00000d000000000d00000000000d000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000025000000002500000000002500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000025000000000025000000000d000000000000002500000000250000000000000000000000000025000000250000000000250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000002500000000000000000000000000000000000000000000250000000000000000000000000000250000000000000000000000000000000000000000121200001200000012000012000000120012121212121200000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000d0000000000000d00000025000d0000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001212000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000d0000000d000000000000000d000000000000000000000000000000000000000000000000000000000000000000000000002500000000000000000000000000000000250000000000000000000000250000001212120000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000d000000000000000000000d000000000000000d00000000000000000000000000000000000000000000000000000000000000121200000000000000000000000000001212120000000000001212121200000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000025000000000000121212121212121212121212000000000000000000001212121212000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000d00000000000000000000000000000000000000000000000000000d00000000200000000700000000000000000025000000000000000000000000000000000000000000000000000000000012120000001212121212121212121200000000000000000000000000000000000000000000000000000000000000000000
0d0000000000000000000d000000000000001b121212121200000000000000000000001212121212000000000000001b0000000000000000000000000000000000000000000000000000000000000000000000000012121212121212121200000000000000000000000000000000000000000000000000000000000000000000
0000000000000007000000000000000000002b1b1b00001b00000000000000000000000000000000000000000000002b0000000000000000000000000000121212121212121212000000000000000000000000000012121212121212121200000000000000000000000000000000000000000000000000000000000000000000
0000000000000012131314121415000000002b2b2b00002b001b1b00070000000000000000000000000000000000002b1b00000000000000000000000012121212121212121212000000000012120000000000002312121212121212120000000000000000000000000000000000000000000000000000000000000000000000
0000000000000012131522121213000000002b2b2b00002b002b2b00121414150000000000000000000000000000002b2b2b000000000000000000001212121212121212121212000000000000000000000000001212121212121212120000000000000000000000000000000000000000000000000000000000000000000000
0000000000000012222206222214000000000000000000000000000000000000000000000000000000000000000000000000000000000012121212121212121212121212121212000000000000000000000000001212121212121212122300000000000000000000000000000000000000000000000000000000000000000000
0020000000000012060606060613000000000000000000000000000000000000000000000000000000000020000000000000000000001212121212121212121212121212121212000012120000000000000000001212121212121212121200000000000000000000000000000000000000000000000000000000000000000000
00000000000000120617181a1915000000000000000000000000000000000000000000000000000000232313132323000000000000121212121212121212121212121212121212000000000000000000000000001212121212121212121200000000000000000000000000000000000000000000000000000000000000000000
1212121212121212121212121212121212151515151515151515151515151515151515151515151515151515151515151515151515151515151512151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
