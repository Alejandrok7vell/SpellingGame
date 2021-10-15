---@diagnostic disable: redundant-parameter
function newB(x, y, t, w, h)
	local button = {}
	button.x = x or 100
	button.y = y or 100
	button.w = w or 100
	button.h = h or 100
	if t == 1 then
		-- Sound
		function button.update()
			if love.mouse.getX() > button.x and love.mouse.getY() > button.y and love.mouse.getX() < button.x + button.w and love.mouse.getY() < button.y + button.h then reloj.isON = true end
		end

		function button.draw()
			love.graphics.setColor(0, 0, 1)
			love.graphics.rectangle("fill", button.x, button.y, button.w, button.h)
			love.graphics.setColor(1, 1, 1)
			love.graphics.polygon("fill", button.x + 5, button.y + 5, button.x + button.w - 5, button.y + button.h / 2, button.x + 5, button.y + button.h - 5)
		end
	elseif t == 2 then
		-- Send
		function button.update()
			if love.mouse.getX() > button.x and love.mouse.getY() > button.y and love.mouse.getX() < button.x + button.w and love.mouse.getY() < button.y + button.h then
				verify(text)
				intentos = intentos + 1
				if result then
					respuestasC = respuestasC + 1
					if respuestasC < 145 then
						numero = numero + 1
						gON = true
						rON = false
					else
						finalizado = finalizado + 1
						loadD()
					end
				else
					rON = true
					gON = false
				end
				reloj.isON = true
			end
		end
		function button.draw()
			love.graphics.setColor(0.3, 0.6, 1)
			love.graphics.rectangle("fill", button.x, button.y, button.w, button.h)
			love.graphics.setColor(1, 1, 1)
			love.graphics.print("Enter", button.x + 5, button.y + 5)
		end
	elseif t == 3 then
		-- Set TI
		function button.update()
			if love.mouse.getX() > button.x and love.mouse.getY() > button.y and love.mouse.getX() < button.x + button.w and love.mouse.getY() < button.y + button.h then
				love.keyboard.setTextInput(true)
			end
		end
	end
	return button
end