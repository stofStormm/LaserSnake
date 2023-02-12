title="title"
wf=.7
hf=.6
buttitles={"resume","quit"}
lg=love.graphics
titlelength=#title
fontwidth=lg.getWidth()*0.022
fonth=fontwidth*2.5
titlew=titlelength*fontwidth

font1=lg.newFont("/Fonts/Vanadine Bold.ttf",lg.getWidth()*.05)
font2=lg.newFont("/Fonts/Vanadine Bold.ttf",lg.getWidth()*.025)

function pausemenudraw(title,buttitles)
  titlelength=#title
  titlew=titlelength*fontwidth
  buttonPoints={}
lg.setFont(font1)
lg.setColor(255,255,0,255)

buttonCount=0
for i in ipairs(buttitles)do
buttonCount=buttonCount+1
end

sw=lg.getWidth()
sh=lg.getHeight()
bh=sh*0.06
w=sw*wf
bw=w*.7
h=(bh*2*buttonCount)+(fonth*2)
lg.setColor(0,0,0,255)
lg.rectangle("fill",(sw-w)/2,(sh-h)/2,w,h)
lg.setColor(255,255,0,255)
lg.rectangle("line",(sw-w)/2,(sh-h)/2,w,h)

lg.print(title,(sw-titlew)/2,((sh-h)/2)+fonth/2)


delta = bh*1.7
for i,v in ipairs(buttitles)do
  vlen=#v
  vw=vlen*fontwidth
  table.insert(buttonPoints,{(sw-bw)/2,(((sh-h)/2)+(fonth*3))+(delta*(i-1))})
lg.rectangle("line",buttonPoints[i][1],buttonPoints[i][2],bw,bh)
lg.print(v,(sw-vw)/2,buttonPoints[i][2]+fonth/15)

-- BUTTON LOGIC --
if(pauseX<=(buttonPoints[i][1]+bw)and pauseX>=buttonPoints[i][1] and pauseY<=buttonPoints[i][2]+bh and pauseY>=buttonPoints[i][2]) then
  if(v=="Main Menu") then gamestate="mainmenu"end
  if(v=="Quit")then love.event.quit(true) end
  if(v=="Resume")then gamestate="game" end
  if(v=="Restart")then inigame() end

end

end
end
