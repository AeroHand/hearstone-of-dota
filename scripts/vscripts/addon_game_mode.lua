-- Generated from template
require('helper')
require('gameinit')


prenothappen=true

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = HSdotaGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function HSdota:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
end

-- Evaluate the state of the game
function HSdota:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
	  if prenothappen then	
		--开始抽牌准备时间
		curstate="prepare"
		prenothappen=false
        PrepareTime=GameRules:GetGameTime()
        initialgame()
        --draw 5 cards for each player
        for j=1,5 do
            draw(0)
            draw(1)
            sleep(1)
        end
      else
      	if curstate=="prepare" then
      		if (GameRules:GetGameTime()-PrepareTime>=60) then
      			--如果准备回合已经过去60秒了
      			--结束准备回合 进入下一个回合
      			curstate=1
      		    curplayer=math.random(1) --随机生成先攻玩家
                startturn(curplayer,curstate)
            end
        else
            if (GameRules:GetGameTime()-turnstarttime>=60) then
            	--如果这个回合已经结束
                endcurturn()
            	curstate=curstate+1
            	curplayer=1-curplayer
            	startturn(curplayer,curstate)
            end	
        end    
      end      	
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 0.1
end