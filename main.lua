lg=love.graphics
dieSound=love.audio.newSource("/Sounds/die.wav","static")
targetSound=love.audio.newSource("/Sounds/gettarget.wav","static")
--local iniLength=1
local pnum=0
points={}
inilength=0
lengthtetest=0
length=0
lengthincrease=20
local dest={}
speed=lg.getWidth()*0.3
originalSpeed=speed
debug=true
dtxt1=""
dtxt2=""
dtxt3=""
TARGET=require("target")
WALL=require("wall")
MAINMENU=require("mainmenu")
PAUSEMENU=require("pausemenu")
gamestate="mainmenu"
font1=lg.newFont("/Fonts/Vanadine Bold.ttf",lg.getWidth()*.05)
font2=lg.newFont("/Fonts/Vanadine Bold.ttf",lg.getWidth()*.025)
hs=0
keytime=0.1
keytimer=keytime
--SIZES
pl=lg.getWidth()*0.2
pth=pl*0.05
headdia=pth*2
plinc=pl*0.1
scoremod=pl
deltaRed=10
redness=225
col={225,redness,redness}
icon = love.image.newImageData("/Icon.png" )
love.window.setIcon(icon)
function love.load()
  math.randomseed(os.time())
  initmainmenu()
  inihs()
  end

function love.draw()
  if(gamestate=="mainmenu")then
    drawmenu()
  end
  if(gamestate=="game")then
    playerdraw()
    walldraw()
    tdraw()
  end
  if(gamestate=="pause")then
    playerdraw()
    walldraw()
    tdraw()
    pausemenudraw("Paused",{"Resume","Main Menu","Quit"})
    end
  if(gamestate=="gameover") then
    playerdraw()
    walldraw()
    tdraw()
    pausemenudraw("Game Over",{"Restart","Main Menu","Quit"})
    end
  if debug==true then
    lg.setColor(255,255,0,255)
    --lg.circle("line",dest[1],dest[2],25)
    lg.print(dtxt1,50,50)
    lg.print(dtxt2,50,65)
    lg.print(dtxt3,50,80)
  end
  end

function love.visible(vis)
      print(vis and "Window is visible!" or "Window is not visible!");
      if(vis==false and gamestate=="game") then gamestate="pause" end
  end

function love.update(dt)

  if(gamestate=="game")then
    updatesnake(dt)
    selfcol()
    wallcoll(points[pnum][1],points[pnum][2])
    catcht()

  end

  if (keytimer<keytime)then keytimer=keytimer+dt end
  end

function updatesnake(dtime)
  pnum=tablelength(points)
  lengthtest=0
  if pnum>2 then
    for i=2,pnum-1 do
      lengthtest=lengthtest+math.abs(({vnorm(points[i],points[i+1])})[2])
    end
    if lengthtest >=length then
      table.remove(points,1)
    else
      n=({vnorm(points[1],points[2])})
      points[1]={points[1][1]+(n[1][1]*speed*dtime),points[1][2]+(n[1][2]*speed*dtime)}
    end
  else
    lengthtest=lengthtest+math.abs(({vnorm(points[1],points[2])})[2])
    if lengthtest>=length then
      n=({vnorm(points[1],points[2])})
      points[1]={points[1][1]+(n[1][1]*speed*dtime),points[1][2]+(n[1][2]*speed*dtime)}
    end
  end
  pnum=tablelength(points)
  n=({vnorm(points[pnum],dest)})
  points[pnum]={points[pnum][1]+(ndest[1][1]*speed*dtime),points[pnum][2]+(ndest[1][2]*speed*dtime)}
  end

function love.keypressed(k)

  if(k=="escape")then
    if(gamestate=="mainmenu") then
    love.event.quit(true)
    end
    if(gamestate=="pause" and keytimer>=keytime) then
    gamestate="game"
    keytimer=0
    end
    if(gamestate=="game" and keytimer>=keytime) then
    gamestate="pause"
    pauseX=0
    pauseY=0
    keytimer=0
    end
    if(gamestate=="gameover") then
    gamestate="mainmenu"
    end
  end
  end


function love.mousepressed(x,y,b)
  if(gamestate=="game")then
  if b==1 then
    dest={x,y}
    ndest=({vnorm(points[pnum],dest)})
    table.insert(points,{points[pnum][1],points[pnum][2]})
  end
  end
  if(gamestate=="mainmenu")then
    mmpress(x,y)
    qbpress(x,y)
  end
  if(gamestate=="pause" or gamestate=="gameover") then
    pauseX=x
    pauseY=y
  end
  end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
  end

function vnorm(a,b)
  v={b[1]-a[1],b[2]-a[2]}
  mag=math.sqrt((v[1]^2)+(v[2]^2))
  norm={v[1]/mag,v[2]/mag}
  return norm,mag
  end

function catcht()
  dist=({vnorm(points[pnum],pt)})[2]
  if math.abs(dist)<=(r+tt+(headdia/2)) then
    tmove()
    targetSound:play()
    length=length+plinc
    speed=speed+(lg.getWidth()*0.3*.03)
    redness=redness-deltaRed
    col={225,redness,redness}
  end
  end

function playerdraw()
  lg.setColor(col[1],col[2],col[3],255)
  lg.setLineWidth(pth)
  pnum=tablelength(points)
  lg.circle("fill",points[pnum][1],points[pnum][2],headdia)

  for i =1,pnum-1,1
      do
        lg.line(points[i][1], points[i][2], points[i+1][1], points[i+1][2])
      end
      lg.setColor(0,0,255,255)
      lg.setLineWidth(pth*.2)
      lg.circle("fill",points[pnum][1],points[pnum][2],headdia)
      for i =1,pnum-1,1
          do
            lg.line(points[i][1], points[i][2], points[i+1][1], points[i+1][2])
          end
  for i=2,pnum-1
    do
      lg.circle("fill",points[i][1],points[i][2],pth*1.2)
    end
    lg.setColor(0,0,0,255)
    lg.circle("fill",points[pnum][1],points[pnum][2],pth*1.5)
    for i=2,pnum-1
      do
        lg.circle("fill",points[i][1],points[i][2],pth*0.8)
      end
  end

function inigame()
  points={}
  inilength=0
  table.insert(points, {(lg.getWidth()/2)+inilength,(lg.getHeight()/2)})
  table.insert(points, {points[1][1]-inilength,points[1][2]})
  inilength=pl
  length=inilength
  dest={points[2][1],points[2][2]-200}
  ndest=({vnorm(points[2],dest)})
  speed=lg.getWidth()*0.3
  wallinit()
  tinit()
  gamestate="game"
  end

function selfcol()
  pnum=tablelength(points)
  for i=1,pnum-3 do
    if math.abs(points[i][1]-points[i+1][1])<=10 then
      if math.abs(points[pnum][1]-points[i][1])<0.1 and points[pnum][2]<=math.max(points[i][2],points[i+1][2]) and points[pnum][2]>=math.min(points[i][2],points[i+1][2]) then
        playerdie()
      end
    else if math.abs(points[i][2]-points[i+1][2])==0 then
      if math.abs(points[pnum][2]-points[i][2])<0.1 and points[pnum][1]<=math.max(points[i][1],points[i+1][1]) and points[pnum][1]>=math.min(points[i][1],points[i+1][1]) then
        playerdie()
      end
    else
      if(points[pnum][1]<=math.max(points[i][1],points[i+1][1]) and
      points[pnum][1]>=math.min(points[i][1],points[i+1][1]) and
      points[pnum][2]<=math.max(points[i][2],points[i+1][2]) and
     points[pnum][2]>=math.min(points[i][2],points[i+1][2])) then
      m=-(points[i][2]-points[i+1][2])/(points[i][1]-points[i+1][1])
    --  dtxt2=m
      c=-points[i][2]-(m*points[i][1])
        --    dtxt3=c
            --dtxt1=math.abs(points[pnum][2]-(m*points[pnum][1])-c)
      if math.abs(-points[pnum][2]-(m*points[pnum][1])-c)<10 then
        playerdie()
        --dtxt1="selfcol"
      end
    end
    end
  end
  end
  end

function playerdie()
  updatehs()
  love.system.vibrate(0.5)
  dieSound:play()
  speed=originalSpeed
  pauseX=0
  pauseY=0
  gamestate="gameover"
  end

function inihs()
  --love.filesystem.remove("hs")
      if(love.filesystem.read("hs")==nil) then
      hs=0
      else
      hs=love.filesystem.read("hs")
      end
      end

function updatehs()
  if(length>tonumber(hs*scoremod))then
    hs=length
    love.filesystem.write("hs",hs/scoremod)
    inihs()
  end
  end
