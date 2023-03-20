--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    -- Add a probability of shiny of 3%
    self.isShiny = math.random() <= 0.03
    self.shinyColor = 1
end

function Tile:update(dt)
    if self.isShiny and (self.shinyColor == 1) then
        -- draw shiny tile varying color 
        self.shinyColor = 0.5
        Timer.tween(1, {
            [self] = {shinyColor = 1}
        })
    end
end

function Tile:render(x, y)
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, self.shinyColor)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw normal tile itself
    --love.graphics.setColor(self.shinyColor, self.shinyColor, self.shinyColor, self.shinyColor)
    love.graphics.setColor(1, 1, 1, self.shinyColor)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)
end