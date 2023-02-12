wallt=0
walltpct=0.015
wallp={}
slab="LENGTH:"
slabelength=#slab
font2width=lg.getWidth()*0.01
font2h=font2width*3
slabw=slabelength*font2width

-- SCORE BOX

function wallinit()
  wallt=lg.getWidth()*walltpct
  topwallt=lg.getWidth()*0.1
  table.insert(wallp,{0,0})
  table.insert(wallp,{lg.getWidth(),0})
  table.insert(wallp,{lg.getWidth(),lg.getHeight()})
  table.insert(wallp,{0,lg.getHeight()})
  scoreboxinit()
  end

function scoreboxinit()
  sbw=lg.getWidth()*0.2
  sbh=sbw*.2
  end

function walldraw()
  lg.setLineWidth(wallt)
  lg.setColor(255,255,0,255)
  pnum=tablelength(wallp)
  for i =1,pnum-1,1 do
        lg.line(wallp[i][1], wallp[i][2], wallp[i+1][1], wallp[i+1][2])
  end
  lg.line(wallp[1][1], wallp[1][2], wallp[pnum][1], wallp[pnum][2])
  lg.setLineWidth(topwallt)
  lg.line(wallp[1][1], wallp[1][2], wallp[2][1], wallp[1][2])
  drawscore()
  end

function wallcoll(px,py)
  if(px<=(wallt/2) or px>=(lg.getWidth()-(wallt/2)) or py<=(topwallt/2) or py>=(lg.getHeight()-(wallt/2))) then
    playerdie()
  end
  end

function drawscore()
  lg.setColor(0,0,0,255)
  lg.rectangle("fill",(lg.getWidth()-sbw)/2,((topwallt/2)-sbh)/2,sbw,sbh)
  lg.setColor(255,255,0,255)
  lg.setFont(font2)
  slab="Length: "..(length/scoremod)
  slabelength=#slab
  slabw=slabelength*font2width
  lg.print(slab,(lg.getWidth()-slabw)/2,((topwallt/2)-font2h)/2)
  end
