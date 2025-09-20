--[[
    Neverlose UI Library Template
    Inspired by Neverlose.cc interface design
    Made for educational purposes only
]]

local NeverloseUI = {}
local Objects = {
    Background = {},
    SidebarBg = {},
    ContentBg = {},
    AccentColor = {},
    TextColor = {},
    SubTextColor = {},
    ButtonBg = {},
    InputBg = {}
}

-- Theme Configuration (Neverlose-inspired colors)
local Theme = {
    Background = Color3.fromRGB(15, 15, 17),           -- Main dark background
    SidebarBg = Color3.fromRGB(20, 20, 23),            -- Sidebar background
    ContentBg = Color3.fromRGB(25, 25, 28),            -- Content area background
    AccentColor = Color3.fromRGB(147, 103, 255),       -- Purple accent (Neverlose signature)
    TextColor = Color3.fromRGB(255, 255, 255),         -- White text
    SubTextColor = Color3.fromRGB(170, 170, 170),      -- Gray subtext
    ButtonBg = Color3.fromRGB(35, 35, 38),             -- Button background
    InputBg = Color3.fromRGB(30, 30, 33),              -- Input field background
    BorderColor = Color3.fromRGB(45, 45, 48),          -- Border color
    HoverColor = Color3.fromRGB(40, 40, 43),           -- Hover state
}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Utility Functions
function NeverloseUI:Create(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

function NeverloseUI:Tween(object, info, properties)
    return TweenService:Create(object, info, properties)
end

-- Main Window Creation
function NeverloseUI:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "Neverlose"
    local windowSize = config.Size or UDim2.new(0, 850, 0, 600)
    
    local Window = {}
    local currentTab = nil
    
    -- Main ScreenGui
    Window.ScreenGui = self:Create("ScreenGui", {
        Name = windowName,
        Parent = CoreGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    -- Main Frame
    Window.MainFrame = self:Create("Frame", {
        Name = "MainFrame",
        Parent = Window.ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = windowSize,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
    })
    table.insert(Objects.Background, Window.MainFrame)
    
    -- Corner rounding
    self:Create("UICorner", {
        Parent = Window.MainFrame,
        CornerRadius = UDim.new(0, 6)
    })
    
    -- Drop shadow effect
    self:Create("ImageLabel", {
        Name = "Shadow",
        Parent = Window.MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 20, 1, 20),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.8,
        ZIndex = -1
    })
    
    -- Title Bar
    Window.TitleBar = self:Create("Frame", {
        Name = "TitleBar",
        Parent = Window.MainFrame,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Theme.SidebarBg,
        BorderSizePixel = 0
    })
    table.insert(Objects.SidebarBg, Window.TitleBar)
    
    self:Create("UICorner", {
        Parent = Window.TitleBar,
        CornerRadius = UDim.new(0, 6)
    })
    
    -- Title bar bottom corners should be square
    self:Create("Frame", {
        Parent = Window.TitleBar,
        Position = UDim2.new(0, 0, 0.7, 0),
        Size = UDim2.new(1, 0, 0.3, 0),
        BackgroundColor3 = Theme.SidebarBg,
        BorderSizePixel = 0
    })
    
    -- Window Title
    Window.Title = self:Create("TextLabel", {
        Name = "Title",
        Parent = Window.TitleBar,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(0, 200, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = Theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    table.insert(Objects.TextColor, Window.Title)
    
    -- Close Button
    Window.CloseButton = self:Create("TextButton", {
        Name = "CloseButton",
        Parent = Window.TitleBar,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 5),
        Size = UDim2.new(0, 25, 0, 25),
        BackgroundColor3 = Theme.ButtonBg,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Theme.TextColor,
        TextSize = 16
    })
    table.insert(Objects.ButtonBg, Window.CloseButton)
    
    self:Create("UICorner", {
        Parent = Window.CloseButton,
        CornerRadius = UDim.new(0, 4)
    })
    
    -- Sidebar
    Window.Sidebar = self:Create("Frame", {
        Name = "Sidebar",
        Parent = Window.MainFrame,
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(0, 200, 1, -35),
        BackgroundColor3 = Theme.SidebarBg,
        BorderSizePixel = 0
    })
    table.insert(Objects.SidebarBg, Window.Sidebar)
    
    -- Content Area
    Window.ContentArea = self:Create("Frame", {
        Name = "ContentArea",
        Parent = Window.MainFrame,
        Position = UDim2.new(0, 200, 0, 35),
        Size = UDim2.new(1, -200, 1, -35),
        BackgroundColor3 = Theme.ContentBg,
        BorderSizePixel = 0
    })
    table.insert(Objects.ContentBg, Window.ContentArea)
    
    -- Sidebar corner rounding
    self:Create("UICorner", {
        Parent = Window.Sidebar,
        CornerRadius = UDim.new(0, 0)
    })
    
    -- Content area corner rounding
    self:Create("UICorner", {
        Parent = Window.ContentArea,
        CornerRadius = UDim.new(0, 6)
    })
    
    -- Fix content area corners
    self:Create("Frame", {
        Parent = Window.ContentArea,
        Position = UDim2.new(0, -6, 0, 0),
        Size = UDim2.new(0, 6, 1, 0),
        BackgroundColor3 = Theme.ContentBg,
        BorderSizePixel = 0
    })
    
    self:Create("Frame", {
        Parent = Window.ContentArea,
        Position = UDim2.new(0, 0, 0, -6),
        Size = UDim2.new(1, 0, 0, 6),
        BackgroundColor3 = Theme.ContentBg,
        BorderSizePixel = 0
    })
    
    -- Tab Container in Sidebar
    Window.TabContainer = self:Create("ScrollingFrame", {
        Name = "TabContainer",
        Parent = Window.Sidebar,
        Position = UDim2.new(0, 0, 0, 10),
        Size = UDim2.new(1, 0, 1, -20),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
    })
    
    self:Create("UIListLayout", {
        Parent = Window.TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    self:Create("UIPadding", {
        Parent = Window.TabContainer,
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 5)
    })
    
    -- Dragging functionality
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    Window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Window.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Close button functionality
    Window.CloseButton.MouseButton1Click:Connect(function()
        Window.ScreenGui:Destroy()
    end)
    
    -- Tab Creation Function
    function Window:CreateTab(tabName)
        local Tab = {}
        
        -- Tab Button
        Tab.Button = NeverloseUI:Create("TextButton", {
            Name = tabName,
            Parent = Window.TabContainer,
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = Theme.ButtonBg,
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            Text = tabName,
            TextColor3 = Theme.SubTextColor,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        table.insert(Objects.ButtonBg, Tab.Button)
        
        NeverloseUI:Create("UICorner", {
            Parent = Tab.Button,
            CornerRadius = UDim.new(0, 4)
        })
        
        NeverloseUI:Create("UIPadding", {
            Parent = Tab.Button,
            PaddingLeft = UDim.new(0, 15)
        })
        
        -- Tab Content
        Tab.Content = NeverloseUI:Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Parent = Window.ContentArea,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.AccentColor,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false
        })
        
        NeverloseUI:Create("UIListLayout", {
            Parent = Tab.Content,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })
        
        NeverloseUI:Create("UIPadding", {
            Parent = Tab.Content,
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20),
            PaddingTop = UDim.new(0, 20)
        })
        
        -- Tab Selection Logic
        Tab.Button.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, child in pairs(Window.ContentArea:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            -- Reset all tab buttons
            for _, child in pairs(Window.TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = Theme.ButtonBg
                    child.TextColor3 = Theme.SubTextColor
                end
            end
            
            -- Activate current tab
            Tab.Content.Visible = true
            Tab.Button.BackgroundColor3 = Theme.AccentColor
            Tab.Button.TextColor3 = Theme.TextColor
            currentTab = Tab
        end)
        
        -- Auto-select first tab
        if currentTab == nil then
            Tab.Button.BackgroundColor3 = Theme.AccentColor
            Tab.Button.TextColor3 = Theme.TextColor
            Tab.Content.Visible = true
            currentTab = Tab
        end
        
        -- Update canvas size
        Window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, Window.TabContainer.UIListLayout.AbsoluteContentSize.Y + 10)
        
        -- Tab Elements Creation
        function Tab:CreateSection(sectionName)
            local Section = {}
            
            Section.Frame = NeverloseUI:Create("Frame", {
                Name = sectionName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })
            
            Section.Title = NeverloseUI:Create("TextLabel", {
                Parent = Section.Frame,
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = sectionName,
                TextColor3 = Theme.TextColor,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Section.Title)
            
            Section.Line = NeverloseUI:Create("Frame", {
                Parent = Section.Frame,
                Position = UDim2.new(0, 0, 0, 30),
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Theme.AccentColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.AccentColor, Section.Line)
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 40)
            
            return Section
        end
        
        function Tab:CreateButton(buttonName, callback)
            local Button = NeverloseUI:Create("TextButton", {
                Name = buttonName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                Text = buttonName,
                TextColor3 = Theme.TextColor,
                TextSize = 13
            })
            table.insert(Objects.ButtonBg, Button)
            
            NeverloseUI:Create("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 4)
            })
            
            -- Hover effect
            Button.MouseEnter:Connect(function()
                NeverloseUI:Tween(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.HoverColor}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                NeverloseUI:Tween(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ButtonBg}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 45)
            
            return Button
        end
        
        function Tab:CreateToggle(toggleName, defaultState, callback)
            local Toggle = {}
            defaultState = defaultState or false
            
            Toggle.Frame = NeverloseUI:Create("Frame", {
                Name = toggleName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Toggle.Frame)
            
            NeverloseUI:Create("UICorner", {
                Parent = Toggle.Frame,
                CornerRadius = UDim.new(0, 4)
            })
            
            Toggle.Label = NeverloseUI:Create("TextLabel", {
                Parent = Toggle.Frame,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -60, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = toggleName,
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Toggle.Label)
            
            Toggle.Switch = NeverloseUI:Create("Frame", {
                Parent = Toggle.Frame,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -15, 0.5, 0),
                Size = UDim2.new(0, 40, 0, 20),
                BackgroundColor3 = defaultState and Theme.AccentColor or Theme.BorderColor,
                BorderSizePixel = 0
            })
            
            NeverloseUI:Create("UICorner", {
                Parent = Toggle.Switch,
                CornerRadius = UDim.new(1, 0)
            })
            
            Toggle.Knob = NeverloseUI:Create("Frame", {
                Parent = Toggle.Switch,
                Position = defaultState and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundColor3 = Theme.TextColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.TextColor, Toggle.Knob)
            
            NeverloseUI:Create("UICorner", {
                Parent = Toggle.Knob,
                CornerRadius = UDim.new(1, 0)
            })
            
            Toggle.State = defaultState
            
            local function UpdateToggle()
                NeverloseUI:Tween(Toggle.Switch, TweenInfo.new(0.2), {
                    BackgroundColor3 = Toggle.State and Theme.AccentColor or Theme.BorderColor
                }):Play()
                
                NeverloseUI:Tween(Toggle.Knob, TweenInfo.new(0.2), {
                    Position = Toggle.State and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                }):Play()
            end
            
            Toggle.Button = NeverloseUI:Create("TextButton", {
                Parent = Toggle.Frame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = ""
            })
            
            Toggle.Button.MouseButton1Click:Connect(function()
                Toggle.State = not Toggle.State
                UpdateToggle()
                if callback then callback(Toggle.State) end
            end)
            
            function Toggle:SetState(state)
                Toggle.State = state
                UpdateToggle()
            end
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 45)
            
            return Toggle
        end
        
        function Tab:CreateSlider(sliderName, minValue, maxValue, defaultValue, callback)
            local Slider = {}
            minValue = minValue or 0
            maxValue = maxValue or 100
            defaultValue = defaultValue or minValue
            
            Slider.Frame = NeverloseUI:Create("Frame", {
                Name = sliderName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 55),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Slider.Frame)
            
            NeverloseUI:Create("UICorner", {
                Parent = Slider.Frame,
                CornerRadius = UDim.new(0, 4)
            })
            
            -- Subtle border
            local border = NeverloseUI:Create("UIStroke", {
                Parent = Slider.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            
            Slider.Label = NeverloseUI:Create("TextLabel", {
                Parent = Slider.Frame,
                Position = UDim2.new(0, 15, 0, 8),
                Size = UDim2.new(1, -80, 0, 18),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = sliderName,
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Slider.Label)
            
            -- Value input box
            Slider.ValueInput = NeverloseUI:Create("TextBox", {
                Parent = Slider.Frame,
                Position = UDim2.new(1, -70, 0, 5),
                Size = UDim2.new(0, 55, 0, 24),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0,
                Font = Enum.Font.GothamMedium,
                Text = tostring(defaultValue),
                TextColor3 = Theme.AccentColor,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Center
            })
            table.insert(Objects.AccentColor, Slider.ValueInput)
            
            NeverloseUI:Create("UICorner", {
                Parent = Slider.ValueInput,
                CornerRadius = UDim.new(0, 3)
            })
            
            NeverloseUI:Create("UIStroke", {
                Parent = Slider.ValueInput,
                Color = Theme.AccentColor,
                Thickness = 1,
                Transparency = 0.7
            })
            
            -- Track background
            Slider.Track = NeverloseUI:Create("Frame", {
                Parent = Slider.Frame,
                Position = UDim2.new(0, 15, 0, 35),
                Size = UDim2.new(1, -30, 0, 6),
                BackgroundColor3 = Theme.BorderColor,
                BorderSizePixel = 0
            })
            
            NeverloseUI:Create("UICorner", {
                Parent = Slider.Track,
                CornerRadius = UDim.new(1, 0)
            })
            
            -- Fill bar
            Slider.Fill = NeverloseUI:Create("Frame", {
                Parent = Slider.Track,
                Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0),
                BackgroundColor3 = Theme.AccentColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.AccentColor, Slider.Fill)
            
            NeverloseUI:Create("UICorner", {
                Parent = Slider.Fill,
                CornerRadius = UDim.new(1, 0)
            })
            
            -- Slider knob
            Slider.Knob = NeverloseUI:Create("Frame", {
                Parent = Slider.Track,
                Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -6, 0, -3),
                Size = UDim2.new(0, 12, 0, 12),
                BackgroundColor3 = Theme.TextColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.TextColor, Slider.Knob)
            
            NeverloseUI:Create("UICorner", {
                Parent = Slider.Knob,
                CornerRadius = UDim.new(1, 0)
            })
            
            NeverloseUI:Create("UIStroke", {
                Parent = Slider.Knob,
                Color = Theme.AccentColor,
                Thickness = 2
            })
            
            Slider.Value = defaultValue
            local dragging = false
            
            local function UpdateSlider(percent, fromInput)
                percent = math.clamp(percent, 0, 1)
                Slider.Value = math.floor(minValue + (maxValue - minValue) * percent)
                
                if not fromInput then
                    Slider.ValueInput.Text = tostring(Slider.Value)
                end
                
                NeverloseUI:Tween(Slider.Fill, TweenInfo.new(0.1), {
                    Size = UDim2.new(percent, 0, 1, 0)
                }):Play()
                
                NeverloseUI:Tween(Slider.Knob, TweenInfo.new(0.1), {
                    Position = UDim2.new(percent, -6, 0, -3)
                }):Play()
                
                if callback then callback(Slider.Value) end
            end
            
            local function HandleInput(input)
                local percent = math.clamp((input.Position.X - Slider.Track.AbsolutePosition.X) / Slider.Track.AbsoluteSize.X, 0, 1)
                UpdateSlider(percent)
            end
            
            Slider.Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    HandleInput(input)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    HandleInput(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            -- Handle direct input
            Slider.ValueInput.FocusLost:Connect(function()
                local value = tonumber(Slider.ValueInput.Text)
                if value then
                    value = math.clamp(value, minValue, maxValue)
                    local percent = (value - minValue) / (maxValue - minValue)
                    UpdateSlider(percent, true)
                else
                    Slider.ValueInput.Text = tostring(Slider.Value)
                end
            end)
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 65)
            
            return Slider
        end
        
        function Tab:CreateKeybind(keybindName, defaultKey, callback)
            local Keybind = {}
            
            Keybind.Frame = NeverloseUI:Create("Frame", {
                Name = keybindName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 50),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Keybind.Frame)
            
            NeverloseUI:Create("UICorner", {
                Parent = Keybind.Frame,
                CornerRadius = UDim.new(0, 4)
            })
            
            NeverloseUI:Create("UIStroke", {
                Parent = Keybind.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            
            Keybind.Label = NeverloseUI:Create("TextLabel", {
                Parent = Keybind.Frame,
                Position = UDim2.new(0, 15, 0, 8),
                Size = UDim2.new(1, -120, 0, 18),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = keybindName,
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Keybind.Label)
            
            -- Key display button
            Keybind.KeyButton = NeverloseUI:Create("TextButton", {
                Parent = Keybind.Frame,
                Position = UDim2.new(1, -105, 0, 12),
                Size = UDim2.new(0, 90, 0, 26),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0,
                Font = Enum.Font.GothamMedium,
                Text = defaultKey and defaultKey.Name or "None",
                TextColor3 = Theme.AccentColor,
                TextSize = 12
            })
            table.insert(Objects.AccentColor, Keybind.KeyButton)
            
            NeverloseUI:Create("UICorner", {
                Parent = Keybind.KeyButton,
                CornerRadius = UDim.new(0, 4)
            })
            
            NeverloseUI:Create("UIStroke", {
                Parent = Keybind.KeyButton,
                Color = Theme.AccentColor,
                Thickness = 1,
                Transparency = 0.6
            })
            
            Keybind.CurrentKey = defaultKey
            Keybind.Recording = false
            local inputConnection = nil
            local keyConnection = nil
            
            -- Key recording functionality
            Keybind.KeyButton.MouseButton1Click:Connect(function()
                if Keybind.Recording then return end
                
                Keybind.Recording = true
                Keybind.KeyButton.Text = "Press any key..."
                Keybind.KeyButton.TextColor3 = Theme.TextColor
                
                -- Animate button to show recording state
                NeverloseUI:Tween(Keybind.KeyButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Theme.AccentColor
                }):Play()
                
                inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == Enum.KeyCode.Escape then
                            -- Clear keybind
                            Keybind.CurrentKey = nil
                            Keybind.KeyButton.Text = "None"
                        else
                            -- Set new keybind
                            Keybind.CurrentKey = input.KeyCode
                            Keybind.KeyButton.Text = input.KeyCode.Name
                        end
                        
                        Keybind.Recording = false
                        Keybind.KeyButton.TextColor3 = Theme.AccentColor
                        
                        NeverloseUI:Tween(Keybind.KeyButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Theme.InputBg
                        }):Play()
                        
                        if inputConnection then
                            inputConnection:Disconnect()
                            inputConnection = nil
                        end
                        
                        -- Setup key detection
                        if keyConnection then
                            keyConnection:Disconnect()
                        end
                        
                        if Keybind.CurrentKey then
                            keyConnection = UserInputService.InputBegan:Connect(function(keyInput, processed)
                                if processed then return end
                                if keyInput.KeyCode == Keybind.CurrentKey then
                                    if callback then callback(Keybind.CurrentKey) end
                                end
                            end)
                        end
                    end
                end)
                
                -- Auto-cancel after 5 seconds
                game:GetService("Debris"):AddItem(spawn(function()
                    wait(5)
                    if Keybind.Recording then
                        Keybind.Recording = false
                        Keybind.KeyButton.Text = Keybind.CurrentKey and Keybind.CurrentKey.Name or "None"
                        Keybind.KeyButton.TextColor3 = Theme.AccentColor
                        NeverloseUI:Tween(Keybind.KeyButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Theme.InputBg
                        }):Play()
                        
                        if inputConnection then
                            inputConnection:Disconnect()
                            inputConnection = nil
                        end
                    end
                end), 0)
            end)
            
            -- Setup initial key detection if default key exists
            if defaultKey then
                keyConnection = UserInputService.InputBegan:Connect(function(keyInput, processed)
                    if processed then return end
                    if keyInput.KeyCode == Keybind.CurrentKey then
                        if callback then callback(Keybind.CurrentKey) end
                    end
                end)
            end
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 60)
            
            return Keybind
        end
        
        function Tab:CreateDropdown(dropdownName, options, defaultOption, callback)
            local Dropdown = {}
            options = options or {}
            
            Dropdown.Frame = NeverloseUI:Create("Frame", {
                Name = dropdownName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 50),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0,
                ClipsDescendants = false
            })
            table.insert(Objects.ButtonBg, Dropdown.Frame)
            
            NeverloseUI:Create("UICorner", {
                Parent = Dropdown.Frame,
                CornerRadius = UDim.new(0, 4)
            })
            
            NeverloseUI:Create("UIStroke", {
                Parent = Dropdown.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            
            Dropdown.Label = NeverloseUI:Create("TextLabel", {
                Parent = Dropdown.Frame,
                Position = UDim2.new(0, 15, 0, 8),
                Size = UDim2.new(1, -30, 0, 18),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = dropdownName,
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Dropdown.Label)
            
            -- Main dropdown button
            Dropdown.Button = NeverloseUI:Create("TextButton", {
                Parent = Dropdown.Frame,
                Position = UDim2.new(0, 15, 0, 25),
                Size = UDim2.new(1, -30, 0, 20),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                Text = defaultOption or (options[1] or "Select..."),
                TextColor3 = Theme.TextColor,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.InputBg, Dropdown.Button)
            
            NeverloseUI:Create("UICorner", {
                Parent = Dropdown.Button,
                CornerRadius = UDim.new(0, 3)
            })
            
            NeverloseUI:Create("UIPadding", {
                Parent = Dropdown.Button,
                PaddingLeft = UDim.new(0, 10)
            })
            
            -- Dropdown arrow
            Dropdown.Arrow = NeverloseUI:Create("TextLabel", {
                Parent = Dropdown.Button,
                Position = UDim2.new(1, -20, 0, 0),
                Size = UDim2.new(0, 20, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = "▼",
                TextColor3 = Theme.AccentColor,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Center
            })
            table.insert(Objects.AccentColor, Dropdown.Arrow)
            
            -- Options container
            Dropdown.OptionsFrame = NeverloseUI:Create("Frame", {
                Parent = Dropdown.Frame,
                Position = UDim2.new(0, 15, 0, 45),
                Size = UDim2.new(1, -30, 0, 0),
                BackgroundColor3 = Theme.ContentBg,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                ZIndex = 10
            })
            table.insert(Objects.ContentBg, Dropdown.OptionsFrame)
            
            NeverloseUI:Create("UICorner", {
                Parent = Dropdown.OptionsFrame,
                CornerRadius = UDim.new(0, 4)
            })
            
            NeverloseUI:Create("UIStroke", {
                Parent = Dropdown.OptionsFrame,
                Color = Theme.AccentColor,
                Thickness = 1,
                Transparency = 0.7
            })
            
            NeverloseUI:Create("UIListLayout", {
                Parent = Dropdown.OptionsFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2)
            })
            
            NeverloseUI:Create("UIPadding", {
                Parent = Dropdown.OptionsFrame,
                PaddingTop = UDim.new(0, 5),
                PaddingBottom = UDim.new(0, 5),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5)
            })
            
            Dropdown.IsOpen = false
            Dropdown.SelectedValue = defaultOption or options[1]
            
            local function CreateOptions()
                -- Clear existing options
                for _, child in pairs(Dropdown.OptionsFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                for _, option in pairs(options) do
                    local optionButton = NeverloseUI:Create("TextButton", {
                        Parent = Dropdown.OptionsFrame,
                        Size = UDim2.new(1, 0, 0, 25),
                        BackgroundColor3 = Theme.ButtonBg,
                        BorderSizePixel = 0,
                        Font = Enum.Font.Gotham,
                        Text = option,
                        TextColor3 = Theme.TextColor,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                    
                    NeverloseUI:Create("UICorner", {
                        Parent = optionButton,
                        CornerRadius = UDim.new(0, 3)
                    })
                    
                    NeverloseUI:Create("UIPadding", {
                        Parent = optionButton,
                        PaddingLeft = UDim.new(0, 8)
                    })
                    
                    -- Highlight selected option
                    if option == Dropdown.SelectedValue then
                        optionButton.BackgroundColor3 = Theme.AccentColor
                    end
                    
                    optionButton.MouseEnter:Connect(function()
                        if option ~= Dropdown.SelectedValue then
                            NeverloseUI:Tween(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.HoverColor}):Play()
                        end
                    end)
                    
                    optionButton.MouseLeave:Connect(function()
                        if option ~= Dropdown.SelectedValue then
                            NeverloseUI:Tween(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.ButtonBg}):Play()
                        end
                    end)
                    
                    optionButton.MouseButton1Click:Connect(function()
                        Dropdown.SelectedValue = option
                        Dropdown.Button.Text = option
                        
                        -- Close dropdown
                        Dropdown.IsOpen = false
                        NeverloseUI:Tween(Dropdown.OptionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -30, 0, 0)}):Play()
                        NeverloseUI:Tween(Dropdown.Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                        
                        CreateOptions() -- Refresh to highlight new selection
                        
                        if callback then callback(option) end
                    end)
                end
            end
            
            CreateOptions()
            
            Dropdown.Button.MouseButton1Click:Connect(function()
                Dropdown.IsOpen = not Dropdown.IsOpen
                
                if Dropdown.IsOpen then
                    local optionsHeight = math.min(#options * 27 + 10, 150) -- Max height of 150
                    NeverloseUI:Tween(Dropdown.OptionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -30, 0, optionsHeight)}):Play()
                    NeverloseUI:Tween(Dropdown.Arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
                    
                    -- Expand parent frame if needed
                    local newFrameHeight = 50 + optionsHeight
                    NeverloseUI:Tween(Dropdown.Frame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, newFrameHeight)}):Play()
                else
                    NeverloseUI:Tween(Dropdown.OptionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -30, 0, 0)}):Play()
                    NeverloseUI:Tween(Dropdown.Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    NeverloseUI:Tween(Dropdown.Frame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 50)}):Play()
                end
            end)
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 60)
            
            return Dropdown
        end
        
        function Tab:CreateTextbox(textboxName, placeholderText, callback)
            local Textbox = {}
            
            Textbox.Frame = NeverloseUI:Create("Frame", {
                Name = textboxName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 50),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Textbox.Frame)
            
            NeverloseUI:Create("UICorner", {
                Parent = Textbox.Frame,
                CornerRadius = UDim.new(0, 4)
            })
            
            Textbox.Label = NeverloseUI:Create("TextLabel", {
                Parent = Textbox.Frame,
                Position = UDim2.new(0, 15, 0, 5),
                Size = UDim2.new(1, -30, 0, 20),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = textboxName,
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Textbox.Label)
            
            Textbox.Input = NeverloseUI:Create("TextBox", {
                Parent = Textbox.Frame,
                Position = UDim2.new(0, 15, 0, 25),
                Size = UDim2.new(1, -30, 0, 20),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                PlaceholderText = placeholderText or "Enter text...",
                PlaceholderColor3 = Theme.SubTextColor,
                Text = "",
                TextColor3 = Theme.TextColor,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.InputBg, Textbox.Input)
            table.insert(Objects.TextColor, Textbox.Input)
            
            NeverloseUI:Create("UICorner", {
                Parent = Textbox.Input,
                CornerRadius = UDim.new(0, 4)
            })
            
            NeverloseUI:Create("UIPadding", {
                Parent = Textbox.Input,
                PaddingLeft = UDim.new(0, 10)
            })
            
            Textbox.Input.FocusLost:Connect(function()
                if callback then callback(Textbox.Input.Text) end
            end)
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 60)
            
            return Textbox
        end
        
        return Tab
    end
    
    return Window
end

-- Theme Management
function NeverloseUI:SetTheme(themeName, color)
    if Theme[themeName] then
        Theme[themeName] = color
        
        local objectList = Objects[themeName] or {}
        for _, object in pairs(objectList) do
            if object and object.Parent then
                if object:IsA("Frame") or object:IsA("TextButton") then
                    object.BackgroundColor3 = color
                elseif object:IsA("TextLabel") or object:IsA("TextBox") then
                    if themeName == "TextColor" then
                        object.TextColor3 = color
                    else
                        object.BackgroundColor3 = color
                    end
                end
            end
        end
    end
end

return NeverloseUI
