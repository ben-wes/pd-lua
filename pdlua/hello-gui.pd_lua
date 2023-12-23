local hello = pd.Class:new():register("hello-gui")

function hello:initialize(sel, atoms)
    self.inlets = 1

    self.circle_x = 480
    self.circle_y = 15
    self.circle_radius = 15
    self.animation_speed = 2

    self.draggable_rect_x = 550
    self.draggable_rect_y = 130
    self.draggable_rect_size = 50
    self.dragging_rect = false
    self.mouse_down_pos = {0, 0}
    self.rect_down_pos = {0, 0}

    self.gui = 1
    gfx.set_size(630, 230)
    return true
end

function math.clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

function hello:postinitialize()
    self.clock = pd.Clock:new():register(self, "tick")
    self.clock:delay(16)
end

function hello:finalize()
    self.clock:destruct()
end

function hello:mouse_down(x, y)
    if x > self.draggable_rect_x and y > self.draggable_rect_y and x < self.draggable_rect_x + self.draggable_rect_size and y < self.draggable_rect_y + self.draggable_rect_size then
        dragging_rect = true
        self.mouse_down_pos[0] = x
        self.mouse_down_pos[1] = y
        self.rect_down_pos[0] = self.draggable_rect_x
        self.rect_down_pos[1] = self.draggable_rect_y
    else
        dragging_rect = false
    end
end

function hello:mouse_drag(x, y)
    if dragging_rect == true then
        self.draggable_rect_x = self.rect_down_pos[0] + (x - self.mouse_down_pos[0])
        self.draggable_rect_y = self.rect_down_pos[1] + (y - self.mouse_down_pos[1])
        self.draggable_rect_x = math.clamp(self.draggable_rect_x, 0, 620 - self.draggable_rect_size)
        self.draggable_rect_y = math.clamp(self.draggable_rect_y, 0, 230 - self.draggable_rect_size)
        self:repaint()
    end
end

function hello:paint()
    gfx.set_color(250, 200, 240)
    gfx.fill_all()

    -- Filled examples
    gfx.set_color(66, 207, 201, 0.3)
    gfx.fill_ellipse(30, 50, 30, 30)
    gfx.set_color(0, 159, 147, 1)
    gfx.fill_rect(120, 50, 30, 30)
    gfx.set_color(250, 84, 108, 1)
    gfx.fill_rounded_rect(210, 50, 30, 30, 5)

    gfx.set_color(252, 118, 81, 1)

    -- Star using line_to paths
    local starX1, starY1 = 310, 45
    local starSize = 15

    gfx.start_path(starX1, starY1)

    -- Star using line_to paths
    gfx.line_to(starX1 + 5, starY1 + 14)
    gfx.line_to(starX1 + 20, starY1 + 14)
    gfx.line_to(starX1 + 8, starY1 + 22)
    gfx.line_to(starX1 + 14, starY1 + 36)
    gfx.line_to(starX1, starY1 + 27)
    gfx.line_to(starX1 - 14, starY1 + 36)
    gfx.line_to(starX1 - 6, starY1 + 22)
    gfx.line_to(starX1 - 18, starY1 + 14)
    gfx.line_to(starX1 - 3, starY1 + 14)
    gfx.close_path()
    gfx.fill_path()

    gfx.set_color(255, 219, 96, 1)
    -- Bezier curve example
    gfx.translate(140, 20)
    gfx.scale(0.5, 1.0)
    gfx.start_path(450, 50)
    gfx.cubic_to(500, 30, 550, 70, 600, 50)
    gfx.close_path()
    gfx.stroke_path(2)
    gfx.reset_transform()

    -- Stroked examples
    gfx.set_color(66, 207, 201, 1)
    gfx.stroke_ellipse(30, 150, 30, 30, 2)
    gfx.set_color(0, 159, 147, 1)
    gfx.stroke_rect(120, 150, 30, 30, 2)
    gfx.set_color(250, 84, 108, 1)
    gfx.stroke_rounded_rect(210, 150, 30, 30, 5, 2)

    gfx.set_color(252, 118, 81, 1)

    local starX2, starY2 = 310, 145
    local starSize = 15

    -- Star using line_to paths
    gfx.start_path(starX2, starY2)
    gfx.line_to(starX2 + 5, starY2 + 14)
    gfx.line_to(starX2 + 20, starY2 + 14)
    gfx.line_to(starX2 + 8, starY2 + 22)
    gfx.line_to(starX2 + 14, starY2 + 36)
    gfx.line_to(starX2, starY2 + 27)
    gfx.line_to(starX2 - 14, starY2 + 36)
    gfx.line_to(starX2 - 6, starY2 + 22)
    gfx.line_to(starX2 - 18, starY2 + 14)
    gfx.line_to(starX2 - 3, starY2 + 14)
    gfx.close_path()
    gfx.stroke_path(2)

    gfx.set_color(255, 219, 96, 1)
    -- Bezier curve example
    gfx.translate(140, 20)
    gfx.scale(0.5, 1.0)
    gfx.start_path(450, 150)
    gfx.cubic_to(500, 130, 550, 170, 600, 150)
    gfx.fill_path()
    gfx.reset_transform()

    -- Draggable rectangle
    gfx.set_color(66, 207, 201, 1)
    gfx.fill_rounded_rect(self.draggable_rect_x, self.draggable_rect_y, self.draggable_rect_size, self.draggable_rect_size, 5)
    gfx.set_color(0, 0, 0, 1)
    gfx.draw_text("Drag me!", self.draggable_rect_x + 8, self.draggable_rect_y + 20, self.draggable_rect_size, 10)

    -- Titles
    gfx.set_color(252, 118, 81, 1)
    gfx.draw_text("Ellipse", 32, 190, 120, 10)
    gfx.draw_text("Rectangle", 116, 190, 120, 10)
    gfx.draw_text("Rounded Rectangle", 188, 190, 120, 10)
    gfx.draw_text("Paths", 300, 190, 120, 10)
    gfx.draw_text("Bezier Paths", 380, 190, 120, 10)
    gfx.draw_text("Animation", 470, 190, 120, 10)
    gfx.draw_text("Mouse Interaction", 540, 190, 120, 10)

    gfx.set_color(250, 84, 108, 1)
    gfx.fill_ellipse(self.circle_x, self.circle_y, self.circle_radius, self.circle_radius)
end

function hello:tick()
    self.circle_y = self.circle_y + self.animation_speed
    if self.circle_y > 160 + self.circle_radius then
        self.circle_y = -self.circle_radius
    end
    self:repaint()
    self.clock:delay(16)
end


function hello:in_1_bang()
    self:repaint()
end