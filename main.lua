function love.load()
    -- Configuração da janela
    love.window.setMode(800, 600)
    
    -- Definição das raquetes
    player1X, player1Y = 50, 250  -- Posição inicial da raquete esquerda
    player2X, player2Y = 730, 250 -- Posição inicial da raquete direita
    paddleWidth, paddleHeight = 20, 100 -- Tamanho das raquetes
    
    -- Definição da bola
    ballX, ballY = 400, 300       -- Posição inicial da bola
    ballRadius = 10               -- Tamanho da bola
    ballSpeedX, ballSpeedY = 200, 200 -- Velocidade da bola em cada eixo (x e y)

    -- Placar
    score1, score2 = 0, 0
end

function love.update(dt)
    -- Movimenta a raquete esquerda
    if love.keyboard.isDown("w") then
        player1Y = player1Y - 200 * dt
    elseif love.keyboard.isDown("s") then
        player1Y = player1Y + 200 * dt
    end
    
    -- Movimenta a raquete direita
    if love.keyboard.isDown("up") then
        player2Y = player2Y - 200 * dt
    elseif love.keyboard.isDown("down") then
        player2Y = player2Y + 200 * dt
    end

    -- Movimento da bola
    ballX = ballX + ballSpeedX * dt
    ballY = ballY + ballSpeedY * dt
    
    -- Colisão com as bordas superior e inferior
    if ballY <= 0 or ballY >= 600 then
        ballSpeedY = -ballSpeedY
    end

    -- Colisão com as raquetes
    if ballX <= player1X + paddleWidth and
       ballY >= player1Y and
       ballY <= player1Y + paddleHeight then
        ballSpeedX = -ballSpeedX
    end

    if ballX >= player2X - ballRadius and
       ballY >= player2Y and
       ballY <= player2Y + paddleHeight then
        ballSpeedX = -ballSpeedX
    end

    -- Colisão com as bordas laterais
    if ballX <= 0 or ballX >= 800 then

        -- Atualiza o placar
        if ballX <= 0 then
            score2 = score2 + 1
        else
            score1 = score1 + 1
        end

        -- Reposiciona a bola no centro
        ballX, ballY = 400, 300

        -- A bola vai para o lado oposto
        ballSpeedX = -ballSpeedX

        -- Atualiza o placar

    end



end

function love.draw()
    -- Desenhar a raquete do jogador 1 (esquerda)
    love.graphics.rectangle("fill", player1X, player1Y, paddleWidth, paddleHeight)
    
    -- Desenhar a raquete do jogador 2 (direita)
    love.graphics.rectangle("fill", player2X, player2Y, paddleWidth, paddleHeight)
    
    -- Desenhar a bola
    love.graphics.circle("fill", ballX, ballY, ballRadius)

    -- Desenhar a linha central
    love.graphics.line(400, 0, 400, 600)

    -- Desenhar o placar
    love.graphics.print(score1, 300, 20, 0, 2, 2)
    love.graphics.print(score2, 500, 20, 0, 2, 2)
end
