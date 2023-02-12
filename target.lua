pt={0,0}
rpct=0.01
buffer=25
ttpct=0.5

function tinit()
  buffer=(lg.getWidth()*0.02)+(topwallt/2)
  pt={math.random(buffer,lg.getWidth()-buffer),math.random(buffer,lg.getHeight()-buffer)}
  r=lg.getWidth()*rpct
  tt=r*ttpct
  end

function tdraw()
  lg.setColor(255,255,0,255)
  lg.setLineWidth(tt)
  lg.circle("line",pt[1],pt[2],r)
  end

function tmove()
pt={math.random(buffer,lg.getWidth()-buffer),math.random(buffer,lg.getHeight()-buffer)}
end
