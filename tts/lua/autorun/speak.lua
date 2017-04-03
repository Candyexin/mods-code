--[[
	© 2016  Sorch <sorch@protonmail.ch>, TheForsakenOne <support@universegamingnetwork.com>
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]
CreateClientConVar( "tts_enables", 1, true, false)
hook.Add("OnPlayerChat","data",function(ply, text, team, dead)
	if(string.sub( text, 1, 4 ) == "+tts") then end
		local enabled = GetConVarNumber("tts_enables")
		timer.Simple(0.01,function()
			local txt2 = ""
			if ply == LocalPlayer() then txt2 = string.sub( text, 5 ) end
			if ply ~= LocalPlayer() then txt2 = string.sub( text, 5 ) end
			local TP = function()
				sound.PlayURL("http://mirrors.sorch.info/tts.php?program=espeak&text="..txt2,"mono",function(tts)
					if ( IsValid(tts) ) then
						tts:Play()
						print("Playing TTS")
					end
				end)
			end	
	local CheckDead = false
	local OOC = true
	if engine.ActiveGamemode()== "terrortown" then CheckDead = true end
	if engine.ActiveGamemode()== "darkrp" then OOC = true end
	if OOC and not CheckDead and enabled ~= 0 then 
			if ply:GetPos():Distance(LocalPlayer():GetPos())<700 then TP() end
	end
		if CheckDead==true and OOC==false and enabled ~= 0 then 
			if dead==false and ply:IsSpec()==false then 
				TP()
			end 
		end
		if CheckDead==false and OOC==false and enabled ~= 0 then 
			TP()
		end
	end)
end)
