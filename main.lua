-- touch txtInput to button
-- y pos answers
-- numbers to table
-- -@diagnostic disable: undefined-global
local utf8 = require"utf8"
require"buttons"
finalizado = 0

function loadD()
	intentos = 0
	respuestasC = 0
	numero = 1

	numeros = {}
	for i = 1, 145, 1 do table.insert(numeros, i) end
	math.randomseed(os.time())
	function s(list)
		for i = #list, 2, -1 do
			local j = math.random(i)
			list[i], list[j] = list[j], list[i]
		end
	end
	s(numeros)
end

function love.load()
	recM = love.graphics.getWidth() / 2 + love.graphics.getWidth() / 5
	math.randomseed(os.time())
	if not love.keyboard.hasTextInput() then love.keyboard.setTextInput(true) end
	mouseON = true
	intentos = 0
	respuestasC = 0
	bPlay = newB(47, 80, 1, 20, 20)
	bEnter = newB(recM + 60, 45, 2, 50, 20)
	bTi = newB(0, 0, 3, recM, 65)
	gON = false
	rON = false
	numero = 1

	numeros = {}
	for i = 1, 145, 1 do table.insert(numeros, i) end
	math.randomseed(os.time())
	function s(list)
		for i = #list, 2, -1 do
			local j = math.random(i)
			list[i], list[j] = list[j], list[i]
		end
	end
	s(numeros)

	reloj = { inicio = 0, final = 0, isON = true }
	text = ""
	sounds = {}
	word = {
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
		"ten",
		"laptop",
		"wall",
		"umbrella",
		"keys",
		"backpack",
		"board",
		"poster",
		"chair",
		"desk",
		"door",
		"eraser",
		"pencil",
		"outlet",
		"pen",
		"book",
		"notebook",
		"window",
		"purse",
		"tablet",
		"paper",
		"television",
		"ticket",
		"box",
		"behind",
		"under",
		"Mexico",
		"Brazil",
		"China",
		"Japan",
		"Egypt",
		"pretty",
		"handsome",
		"friendly",
		"kind",
		"funny",
		"quiet",
		"serious",
		"shy",
		"short",
		"tall",
		"heavy",
		"thin",
		"jacket",
		"tie",
		"shirt",
		"suit",
		"raincoat",
		"blouse",
		"skirt",
		"coat",
		"dress",
		"pants",
		"hat",
		"gloves",
		"jeans",
		"cap",
		"scarf",
		"sweater",
		"boots",
		"shorts",
		"socks",
		"pajamas",
		"weather",
		"brown",
		"green",
		"blue",
		"gray",
		"season",
		"spring",
		"summer",
		"fall",
		"winter",
		"cold",
		"sunny",
		"rainy",
		"windy",
		"time",
		"clock",
		"morning",
		"evening",
		"swimsuits",
		"sneakers",
		"wastebasket",
		"newspaper",
		"hairbrush",
		"headphones",
		"sunglasses",
		"talkative",
		"appearance",
		"beautiful",
		"twenty",
		"thirty",
		"forty",
		"fifty",
		"sixty",
		"seventy",
		"eighty",
		"ninety",
		"dance",
		"drive",
		"listen",
		"basketball",
		"watch",
		"movie",
		"subway",
		"motorcycle",
		"downtown",
		"suburbs",
		"husband",
		"wife",
		"brother",
		"sister",
		"children",
		"daughter",
		"son",
		"schedule",
		"breakfast",
		"lunch",
		"dinner",
		"routine",
		"quarter",
		"survey",
		"afternoon",
		"shopping",
		"family",
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday",
		"Sunday",
		"weekdays",
		"weekends",
		"midnight"
	}
	result = false
	for i = 1, 145, 1 do
		table.insert(sounds, i, love.audio.newSource("sounds/" .. i .. ".wav", "static"))
	end
	-- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
	love.keyboard.setKeyRepeat(true)
end

function love.textinput(t) text = text .. t end

function love.keypressed(key)
	if key == "backspace" then
		-- get the byte offset to the last UTF-8 character in the string.
		local byteoffset = utf8.offset(text, -1)
		if byteoffset then
			-- remove the last UTF-8 character.
			-- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
			text = string.sub(text, 1, byteoffset - 1)
		end
	elseif key == "return" then
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

function verify(a)
	if a == word[numeros[numero]] then result = true
	else result = false end
	text = ""
end

function reproducir()
	if iniciarReloj(sounds[numeros[numero]]:getDuration() * 2) then love.audio.play(sounds[numeros[numero]]) end
end

function iniciarReloj(seg)
	segundos = seg or 10
	if reloj.isON then
		reloj.inicio = love.timer.getTime()
		reloj.isON = false
	end
	reloj.final = love.timer.getTime() - reloj.inicio
	if reloj.final > segundos then return false
	else return true end
end

function love.update() reproducir() end

function love.mousepressed(mx, my, mb)
	if mouseON then
		if mb == 1 then
			bPlay.update()
			bEnter.update()
			bTi.update()
			mouseON = false
		end
	end
end

function love.mousereleased(mx, my, mb) if mb == 1 then mouseON = true end end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Escribe...", 45, 20)
	love.graphics.printf(text, 50, 50, recM)
	love.graphics.rectangle("line", 47, 45, recM, 20)
	love.graphics.print("Intentos: " .. intentos, love.graphics.getWidth() - 100, 0)
	love.graphics.print("Aciertos: " .. respuestasC, love.graphics.getWidth() - 100, 25)
	love.graphics.setColor(0.6, 0.6, 0.6)
	love.graphics.print("Finalizado: " .. finalizado, 45, love.graphics.getHeight() - 50)
	bPlay.draw()
	bEnter.draw()
	if gON then
		love.graphics.setColor(0, 1, 0)
		love.graphics.print("Correcto!, sigue así :D", love.graphics.getWidth() - 200, 80)
	end
	if rON then
		love.graphics.setColor(1, 0, 0)
		love.graphics.print("Incorrecto, vuelve a intentarlo :C", love.graphics.getWidth() - 200, 100)
	end
end