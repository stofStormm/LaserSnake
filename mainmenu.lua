
--PLAY BUTTON
lg=love.graphics
lf=love.filesystem
pbw=lg.getWidth()*0.3
pbh=pbw*0.3
mmlab="PLAY"
hslab="Highscore:"
mmlabelength=#mmlab
fontwidth=lg.getWidth()*0.022
fonth=fontwidth*3
mmlabw=mmlabelength*fontwidth

--QUIT BUTTON
qbrct=lg.getWidth()*.02
qbbuf=lg.getWidth()*0.05
qbw=lg.getWidth()*.2
qbh=pqh
qblab="Quit"
qblabelength=#qblab
qblabw=qblabelength*fontwidth
qbp={qbbuf,qbbuf,qblabw+(2*qbrct),fonth+(2*qbrct)}


function initmainmenu()
  mmp={(lg.getWidth()-pbw)/2,(lg.getHeight()-pbh)/2,pbh+(lg.getWidth()-pbh)/2,pbw+(lg.getHeight()-pbw)/2}
  end

function drawmenu()
  lg.setFont(font1)
  lg.setLineWidth(1)
  lg.setColor(255,255,0,255)
  lg.print(mmlab,(lg.getWidth()-mmlabw)/2,(lg.getHeight()-fonth)/2)
  lg.rectangle("line",mmp[1],mmp[2],pbw,pbh)
  drawquitbutton()
  hslab="Highscore:"..hs
  hslablength=#hslab
  mmlabhs=(hslablength+2)*fontwidth
  lg.print(hslab,(lg.getWidth()-(mmlabhs))/2,(lg.getHeight()-fonth-lg.getWidth()*.5)/2)
  end

function mmpress(x,y)
  if(x<=(mmp[1]+pbw)and x>=mmp[1] and y<=mmp[2]+pbh and y>=mmp[2]) then
    gamestate="game"
    inigame()
  end
  end

function drawquitbutton()
  lg.print(qblab,qbp[1]+(qbp[3]/2)-(qblabw/2),qbp[2]+(qbp[4]/2)-(fonth/2))
  lg.rectangle("line",qbp[1],qbp[2],qbp[3],qbp[4])
  end
function qbpress(x,y)
  if(x<=(qbp[1]+qbp[3])and x>=qbp[1] and y<=(qbp[2]+qbp[4]) and y>=qbp[2]) then
    love.event.quit(true)
  end
  end
