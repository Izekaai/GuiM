-- SupraplexHUD v4.0 | UI Template - Separated Architecture
-- This file contains only the UI structure and visual elements
-- To be loaded via loadstring() from raw GitHub link

local UITemplate = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

function UITemplate.createUI(callbacks)
    -- Remove old versions
    for _, old in ipairs({"SupraplexHUDv2", "SupraplexHUDv3", "SupraplexHUDv4"}) do
        if CoreGui:FindFirstChild(old) then
            CoreGui[old]:Destroy()
        end
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "SupraplexHUDv4"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = CoreGui

    -- Enhanced Blur Background with Particles
    local blurFrame = Instance.new("Frame", gui)
    blurFrame.Name = "BlurBackground"
    blurFrame.Size = UDim2.new(1,0,1,0)
    blurFrame.BackgroundColor3 = Color3.new(0,0,0)
    blurFrame.BackgroundTransparency = 0.2
    blurFrame.ZIndex = 1
    blurFrame.Visible = false

    -- Particle creation function
    local function createParticle(parent)
        local particle = Instance.new("Frame", parent)
        particle.Size = UDim2.new(0, math.random(2,6), 0, math.random(2,6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(138,43,226)
        particle.BackgroundTransparency = math.random(30,70)/100
        particle.ZIndex = 2
        Instance.new("UICorner", particle).CornerRadius = UDim.new(1,0)
        
        local tween = TweenService:Create(particle, 
            TweenInfo.new(math.random(15,25), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
            {Position = UDim2.new(math.random(), 0, math.random(), 0)}
        )
        tween:Play()
        
        spawn(function()
            while particle.Parent do
                TweenService:Create(particle, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                    {BackgroundTransparency = math.random(10,90)/100}):Play()
                wait(2)
            end
        end)
    end

    -- Create background particles
    for i = 1, 25 do
        createParticle(blurFrame)
    end

    -- Main Container with Enhanced Effects
    local main = Instance.new("Frame", gui)
    main.Name = "MainContainer"
    main.Size = UDim2.new(0,520,0,750)
    main.Position = UDim2.new(0.5,-260,0.5,-375)
    main.BackgroundColor3 = Color3.fromRGB(8,8,15)
    main.BackgroundTransparency = 0.05
    main.ZIndex = 5
    main.Active = true

    Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

    -- Enhanced Glow Effects
    local function createGlow(parent, color, thickness, transparency, zIndex)
        local glow = Instance.new("UIStroke", parent)
        glow.Color = color
        glow.Thickness = thickness
        glow.Transparency = transparency
        glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        return glow
    end

    local outerGlow = createGlow(main, Color3.fromRGB(186,85,211), 3, 0.1, 4)
    local middleGlow = createGlow(main, Color3.fromRGB(138,43,226), 6, 0.3, 3)
    local softGlow = createGlow(main, Color3.fromRGB(75,0,130), 12, 0.6, 2)

    -- Animate glow effects
    spawn(function()
        while gui.Parent do
            TweenService:Create(outerGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {Transparency = 0.4}):Play()
            TweenService:Create(middleGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {Transparency = 0.7}):Play()
            wait(0.1)
        end
    end)

    -- Enhanced Gradient Background
    local gradFrame = Instance.new("Frame", main)
    gradFrame.Size = UDim2.new(1,0,1,0)
    gradFrame.BackgroundTransparency = 0.7
    gradFrame.ZIndex = 5
    Instance.new("UICorner", gradFrame).CornerRadius = UDim.new(0,20)

    local grad = Instance.new("UIGradient", gradFrame)
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138,43,226)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(186,85,211)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(75,0,130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138,43,226)),
    }
    grad.Rotation = 45

    -- Header
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1,0,0,90)
    header.ZIndex = 15
    header.Active = true
    header.BackgroundTransparency = 1

    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(0,280,1,0)
    title.Position = UDim2.new(0,30,0,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 32
    title.Text = "✨ SUPRAPLEX ✨"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 16

    -- Profile Section
    local profileSection = Instance.new("Frame", main)
    profileSection.Size = UDim2.new(1,-40,0,110)
    profileSection.Position = UDim2.new(0,20,0,100)
    profileSection.BackgroundColor3 = Color3.fromRGB(15,15,25)
    profileSection.BackgroundTransparency = 0.1
    profileSection.ZIndex = 15
    Instance.new("UICorner", profileSection).CornerRadius = UDim.new(0,16)
    createGlow(profileSection, Color3.fromRGB(138,43,226), 2, 0.6, 14)

    local avatar = Instance.new("ImageLabel", profileSection)
    avatar.Size = UDim2.new(0,72,0,72)
    avatar.Position = UDim2.new(0,20,0.5,-36)
    avatar.BackgroundTransparency = 1
    avatar.ZIndex = 16
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)
    createGlow(avatar, Color3.fromRGB(186,85,211), 3, 0.2, 15)
    
    spawn(function()
        pcall(function()
            avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
    end)

    local nameLbl = Instance.new("TextLabel", profileSection)
    nameLbl.Size = UDim2.new(1,-120,0,36)
    nameLbl.Position = UDim2.new(0,110,0,20)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 22
    nameLbl.Text = player.DisplayName
    nameLbl.TextColor3 = Color3.new(1,1,1)
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 16
    Instance.new("UIStroke", nameLbl).Color = Color3.fromRGB(138,43,226)

    -- Content Container
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-40,1,-250)
    content.Position = UDim2.new(0,20,0,230)
    content.BackgroundTransparency = 1
    content.ZIndex = 15

    local scrollFrame = Instance.new("ScrollingFrame", content)
    scrollFrame.Size = UDim2.new(1,0,1,0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138,43,226)
    scrollFrame.ScrollBarImageTransparency = 0.2
    scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
    scrollFrame.ZIndex = 15

    local layout = Instance.new("UIListLayout", scrollFrame)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,20)

    -- UI Creation Functions
    local function addSection(name, icon)
        local sectionFrame = Instance.new("Frame", scrollFrame)
        sectionFrame.Size = UDim2.new(1,0,0,40)
        sectionFrame.BackgroundTransparency = 1
        sectionFrame.ZIndex = 16
        
        local iconLbl = Instance.new("TextLabel", sectionFrame)
        iconLbl.Size = UDim2.new(0,30,1,0)
        iconLbl.BackgroundTransparency = 1
        iconLbl.Font = Enum.Font.GothamBold
        iconLbl.TextSize = 20
        iconLbl.Text = icon or "⚡"
        iconLbl.TextColor3 = Color3.fromRGB(138,43,226)
        iconLbl.ZIndex = 17
        
        local lbl = Instance.new("TextLabel", sectionFrame)
        lbl.Size = UDim2.new(1,-40,1,0)
        lbl.Position = UDim2.new(0,40,0,0)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 20
        lbl.Text = name
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 17
        
        return sectionFrame
    end

    local function createToggleCard(title, desc, isEnabled, callback)
        local card = Instance.new("Frame", scrollFrame)
        card.Size = UDim2.new(1,-15,0,85)
        card.BackgroundColor3 = Color3.fromRGB(12,12,20)
        card.BackgroundTransparency = 0.1
        card.ZIndex = 16
        Instance.new("UICorner", card).CornerRadius = UDim.new(0,12)
        
        local cardGlow1 = createGlow(card, Color3.fromRGB(138,43,226), 1, 0.7, 15)

        local tLbl = Instance.new("TextLabel", card)
        tLbl.Size = UDim2.new(0.65,0,0,24)
        tLbl.Position = UDim2.new(0,16,0,16)
        tLbl.BackgroundTransparency = 1
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 16
        tLbl.Text = title
        tLbl.TextColor3 = Color3.new(1,1,1)
        tLbl.ZIndex = 17

        local dLbl = Instance.new("TextLabel", card)
        dLbl.Size = UDim2.new(0.8,0,0,18)
        dLbl.Position = UDim2.new(0,16,0,45)
        dLbl.BackgroundTransparency = 1
        dLbl.Font = Enum.Font.Gotham
        dLbl.TextSize = 13
        dLbl.Text = desc
        dLbl.TextColor3 = Color3.fromRGB(190,190,190)
        dLbl.ZIndex = 17

        -- Toggle Switch
        local toggleContainer = Instance.new("Frame", card)
        toggleContainer.Size = UDim2.new(0,60,0,30)
        toggleContainer.Position = UDim2.new(1,-80,0.5,-15)
        toggleContainer.BackgroundTransparency = 1
        toggleContainer.ZIndex = 17

        local bg = Instance.new("Frame", toggleContainer)
        bg.Size = UDim2.new(1,0,0,24)
        bg.Position = UDim2.new(0,0,0.5,-12)
        bg.BackgroundColor3 = isEnabled and Color3.fromRGB(138,43,226) or Color3.fromRGB(40,40,50)
        bg.ZIndex = 17
        Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
        
        local toggleGlow = createGlow(bg, Color3.fromRGB(186,85,211), 2, isEnabled and 0.3 or 1, 16)

        local knob = Instance.new("Frame", bg)
        knob.Size = UDim2.new(0,20,0,20)
        knob.Position = isEnabled and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,2,0.5,-10)
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.ZIndex = 18
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        local btn = Instance.new("TextButton", card)
        btn.Size = UDim2.new(1,0,1,0)
        btn.BackgroundTransparency = 1
        btn.AutoButtonColor = false
        btn.ZIndex = 19
        btn.Text = ""

        btn.MouseButton1Click:Connect(function()
            local newState = callback()
            TweenService:Create(knob, TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                {Position=newState and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,2,0.5,-10)}):Play()
            TweenService:Create(bg, TweenInfo.new(0.3,Enum.EasingStyle.Quad),
                {BackgroundColor3=newState and Color3.fromRGB(138,43,226) or Color3.fromRGB(40,40,50)}):Play()
            TweenService:Create(toggleGlow, TweenInfo.new(0.3,Enum.EasingStyle.Quad),
                {Transparency=newState and 0.3 or 1}):Play()
        end)

        return card
    end

    local function createSliderCard(title, desc, currentValue, minValue, maxValue, callback)
        local card = Instance.new("Frame", scrollFrame)
        card.Size = UDim2.new(1,-15,0,100)
        card.BackgroundColor3 = Color3.fromRGB(12,12,20)
        card.BackgroundTransparency = 0.1
        card.ZIndex = 16
        Instance.new("UICorner", card).CornerRadius = UDim.new(0,12)
        createGlow(card, Color3.fromRGB(138,43,226), 1, 0.7, 15)

        local tLbl = Instance.new("TextLabel", card)
        tLbl.Size = UDim2.new(1,-20,0,24)
        tLbl.Position = UDim2.new(0,16,0,10)
        tLbl.BackgroundTransparency = 1
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 16
        tLbl.Text = title
        tLbl.TextColor3 = Color3.new(1,1,1)
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.ZIndex = 17

        local dLbl = Instance.new("TextLabel", card)
        dLbl.Size = UDim2.new(1,-20,0,16)
        dLbl.Position = UDim2.new(0,16,0,34)
        dLbl.BackgroundTransparency = 1
        dLbl.Font = Enum.Font.Gotham
        dLbl.TextSize = 12
        dLbl.Text = desc
        dLbl.TextColor3 = Color3.fromRGB(150,150,150)
        dLbl.TextXAlignment = Enum.TextXAlignment.Left
        dLbl.ZIndex = 17

        -- Slider Track
        local track = Instance.new("Frame", card)
        track.Size = UDim2.new(1,-40,0,6)
        track.Position = UDim2.new(0,20,0,60)
        track.BackgroundColor3 = Color3.fromRGB(40,40,50)
        track.ZIndex = 17
        Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)

        -- Slider Fill and Knob
        local fillPercent = (currentValue - minValue) / (maxValue - minValue)
        local fill = Instance.new("Frame", track)
        fill.Size = UDim2.new(fillPercent,0,1,0)
        fill.BackgroundColor3 = Color3.fromRGB(138,43,226)
        fill.ZIndex = 18
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

        local knob = Instance.new("Frame", track)
        knob.Size = UDim2.new(0,16,0,16)
        knob.Position = UDim2.new(fillPercent,0,0.5,-8)
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.ZIndex = 19
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        local valueLbl = Instance.new("TextLabel", card)
        valueLbl.Size = UDim2.new(0,60,0,20)
        valueLbl.Position = UDim2.new(1,-70,0,8)
        valueLbl.BackgroundTransparency = 1
        valueLbl.Font = Enum.Font.GothamBold
        valueLbl.TextSize = 14
        valueLbl.Text = tostring(currentValue)
        valueLbl.TextColor3 = Color3.fromRGB(138,43,226)
        valueLbl.TextXAlignment = Enum.TextXAlignment.Center
        valueLbl.ZIndex = 17

        -- Slider interaction
        local dragging = false
        local btn = Instance.new("TextButton", track)
        btn.Size = UDim2.new(1,0,1,0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 20

        btn.MouseButton1Down:Connect(function()
            dragging = true
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local trackSize = track.AbsoluteSize.X
                local mousePos = input.Position.X - track.AbsolutePosition.X
                local percentage = math.clamp(mousePos / trackSize, 0, 1)
                local value = math.floor(minValue + (maxValue - minValue) * percentage * 100) / 100
                
                TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(percentage,0,1,0)}):Play()
                TweenService:Create(knob, TweenInfo.new(0.1), {Position = UDim2.new(percentage,0,0.5,-8)}):Play()
                valueLbl.Text = tostring(value)
                callback(value)
            end
        end)

        return card
    end

    local function createTextInput(placeholder, currentText, callback)
        local input = Instance.new("TextBox", scrollFrame)
        input.Size = UDim2.new(1,-40,0,30)
        input.BackgroundColor3 = Color3.fromRGB(25,25,40)
        input.Text = currentText or ""
        input.Font = Enum.Font.Gotham
        input.TextSize = 16
        input.TextColor3 = Color3.new(1,1,1)
        input.PlaceholderText = placeholder or "Enter text..."
        input.PlaceholderColor3 = Color3.fromRGB(150,150,150)
        input.ZIndex = 16
        Instance.new("UICorner", input).CornerRadius = UDim.new(0,8)

        local inputStroke = Instance.new("UIStroke", input)
        inputStroke.Color = Color3.fromRGB(60,60,80)
        inputStroke.Thickness = 2
        inputStroke.Transparency = 0.3

        input.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(input.Text)
            end
        end)

        return input
    end

    -- Auto-resize scrollframe
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local newSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 20)
        TweenService:Create(scrollFrame, TweenInfo.new(0.3,Enum.EasingStyle.Quad),{CanvasSize=newSize}):Play()
    end)

    -- Enhanced Drag Functionality
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = main.Position
            
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    header.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = i
        end
    end)
    
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i == dragInput then
            local delta = i.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            TweenService:Create(main, TweenInfo.new(0.1,Enum.EasingStyle.Quad),{Position=newPos}):Play()
        end
    end)

    -- Show/Hide Functions
    local function showGUI()
        main.Visible = true
        blurFrame.Visible = true
        
        main.Size = UDim2.new(0,0,0,0)
        main.Position = UDim2.new(0.5,0,0.5,0)
        blurFrame.BackgroundTransparency = 1
        
        TweenService:Create(blurFrame, TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundTransparency=0.2}):Play()
        TweenService:Create(main, TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
            Size=UDim2.new(0,520,0,750),
            Position=UDim2.new(0.5,-260,0.5,-375)
        }):Play()
    end

    local function hideGUI()
        TweenService:Create(main, TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.In),{
            Size=UDim2.new(0,0,0,0),
            Position=UDim2.new(0.5,0,0.5,0)
        }):Play()
        TweenService:Create(blurFrame, TweenInfo.new(0.3,Enum.EasingStyle.Quad),{BackgroundTransparency=1}):Play()
        
        wait(0.5)
        main.Visible = false
        blurFrame.Visible = false
    end

    -- Initialize closed
    main.Visible = false
    blurFrame.Visible = false

    -- Return UI interface
    return {
        gui = gui,
        main = main,
        blurFrame = blurFrame,
        scrollFrame = scrollFrame,
        showGUI = showGUI,
        hideGUI = hideGUI,
        addSection = addSection,
        createToggleCard = createToggleCard,
        createSliderCard = createSliderCard,
        createTextInput = createTextInput,
        isVisible = function() return main.Visible end
    }
end

return UITemplate
