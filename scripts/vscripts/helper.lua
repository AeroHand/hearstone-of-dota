
--stop the whole logic for certain amount of time
function sleep(sec)
	local pretime=GameRules:GetGameTime()
	local count=0
	while ((GameRules:GetGameTime()-pretime)<sec) do
      count=count+1
	end	
	print(count.." times loop has been used!")
end

--draw a card for one specific player
function draw(pid)
    
end	

--start a new turn for one specific player
function startturn(pid,curstate)
   turnstarttime=GameRules:GetGameTime()
end	

--end current turn
function endturn()

end