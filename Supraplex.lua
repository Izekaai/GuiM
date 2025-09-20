--[[
    
    _   _                     _                  _    _ _____ 
   | \ | |                   | |                | |  | |_   _|
   |  \| | _____   _____ _ __| | ___  ___  ___  | |  | | | |  
   | . ` |/ _ \ \ / / _ \ '__| |/ _ \/ __|/ _ \ | |  | | | |  
   | |\  |  __/\ V /  __/ |  | | (_) \__ \  __/ | |__| |_| |_ 
   |_| \_|\___| \_/ \___|_|  |_|\___/|___/\___|  \____/|_____|
                                                             
    Modern UI Library inspired by Neverlose
    Created for educational purposes
    
]]

local NeverLoseUI = {}
local Objects = {
    Background = {},
    Sidebar = {},
    Content = {},
    Accent = {},
    Text = {},
    Secondary = {},
    Tertiary = {}
}

-- Color Scheme inspired by Neverlose
local Theme = {
    Background = Color3.fromRGB(25, 25, 35),
    Sidebar = Color3.fromRGB(20, 20, 28),
    Content = Color3.fromRGB(30, 30, 40),
    Accent = Color3.fromRGB(130, 100, 255),
    AccentHover = Color3.fromRGB(145, 115, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    Secondary = Color3.fromRGB(35, 35, 45),
    Tertiary = Color3.fromRGB(40, 40, 50),
    Success = Color3.fromRGB(100, 255, 130),
    Warning = Color3.fromRGB(255, 200, 100),
    Error = Color3.fromRGB(255, 100, 100)
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    return instance
end

local function CreateCorner(parent, radius)
    local corner = CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, radius or 6),
        Parent = parent
    })
    return corner
end

local function CreateStroke(parent, thickness, color)
    local stroke = CreateInstance("UIStroke", {
        Thickness = thickness or 1,
        Color = color or Theme.Secondary,
        Parent = parent
    })
    return stroke
end

local function CreateGradient(parent, colors, rotation)
    local gradient = CreateInstance("UIGradient", {
        Color = colors,
        Rotation = rotation or 0,
        Parent = parent
    })
    return gradient
end

function NeverLoseUI:CreateMain(options)
    local Main = {}
    local currentTab = nil
    
    options = options or {}
    local title = options.Title or "Neverlose UI"
    local size = options.Size or UDim2.new(0, 700, 0, 500)
    local draggable = options.Draggable ~= false
    
    -- Main ScreenGui
    Main.ScreenGui = CreateInstance("ScreenGui", {
        Name = title,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    -- Main Frame
    Main.MainFrame = CreateInstance("Frame", {
        Name = "MainFrame",
        Size = size,
        Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = Main.ScreenGui
    })
    
    CreateCorner(Main.MainFrame, 8)
    CreateStroke(Main.MainFrame, 1, Theme.Secondary)
    table.insert(Objects.Background, Main.MainFrame)
    
    -- Title Bar
    Main.TitleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = Main.MainFrame
    })
    
    CreateCorner(Main.TitleBar, 8)
    table.insert(Objects.Sidebar, Main.TitleBar)
    
    -- Fix corner for title bar
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 8),
        Position = UDim2.new(0, 0, 1, -8),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = Main.TitleBar
    })
    
    -- Title Text
    Main.TitleText = CreateInstance("TextLabel", {
        Name = "TitleText",
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        Parent = Main.TitleBar
    })
    
    table.insert(Objects.Text, Main.TitleText)
    
    -- Close Button
    Main.CloseButton = CreateInstance("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = Theme.Error,
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = Main.TitleBar
    })
    
    CreateCorner(Main.CloseButton, 4)
    
    Main.CloseButton.MouseButton1Click:Connect(function()
        Main.ScreenGui:Destroy()
    })
    
    -- Sidebar
    Main.Sidebar = CreateInstance("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 150, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = Main.MainFrame
    })
    
    table.insert(Objects.Sidebar, Main.Sidebar)
    
    -- Sidebar List
    Main.SidebarList = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
        Parent = Main.Sidebar
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        Parent = Main.Sidebar
    })
    
    -- Content Frame
    Main.ContentFrame = CreateInstance("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, -150, 1, -40),
        Position = UDim2.new(0, 150, 0, 40),
        BackgroundColor3 = Theme.Content,
        BorderSizePixel = 0,
        Parent = Main.MainFrame
    })
    
    table.insert(Objects.Content, Main.ContentFrame)
    
    -- Dragging functionality
    if draggable then
        local dragToggle = nil
        local dragSpeed = 0.25
        local dragStart = nil
        local startPos = nil
        
        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                     startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(Main.MainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
        end
        
        Main.TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragToggle = true
                dragStart = input.Position
                startPos = Main.MainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if dragToggle then
                    updateInput(input)
                end
            end
        end)
    end
    
    function Main:CreateTab(name)
        local Tab = {}
        Tab.Name = name
        
        -- Tab Button
        Tab.Button = CreateInstance("TextButton", {
            Name = name .. "Tab",
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0,
            Text = name,
            TextColor3 = Theme.TextSecondary,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            Parent = Main.Sidebar
        })
        
        CreateCorner(Tab.Button, 6)
        table.insert(Objects.Secondary, Tab.Button)
        
        -- Tab Content
        Tab.Content = CreateInstance("ScrollingFrame", {
            Name = name .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = Main.ContentFrame
        })
        
        CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = Tab.Content
        })
        
        CreateInstance("UIPadding", {
            PaddingTop = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            Parent = Tab.Content
        })
        
        Tab.Button.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, child in pairs(Main.ContentFrame:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            -- Reset all tab buttons
            for _, child in pairs(Main.Sidebar:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = Theme.Secondary
                    child.TextColor3 = Theme.TextSecondary
                end
            end
            
            -- Show current tab
            Tab.Content.Visible = true
            Tab.Button.BackgroundColor3 = Theme.Accent
            Tab.Button.TextColor3 = Theme.Text
            currentTab = Tab
        end)
        
        -- Auto-select first tab
        if currentTab == nil then
            Tab.Button.BackgroundColor3 = Theme.Accent
            Tab.Button.TextColor3 = Theme.Text
            Tab.Content.Visible = true
            currentTab = Tab
        end
        
        function Tab:CreateSection(name)
            local Section = {}
            
            Section.Frame = CreateInstance("Frame", {
                Name = name .. "Section",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                Parent = Tab.Content
            })
            
            CreateCorner(Section.Frame, 6)
            table.insert(Objects.Secondary, Section.Frame)
            
            Section.Title = CreateInstance("TextLabel", {
                Name = "SectionTitle",
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                Parent = Section.Frame
            })
            
            table.insert(Objects.Text, Section.Title)
            
            Section.List = CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
                Parent = Section.Frame
            })
            
            CreateInstance("UIPadding", {
                PaddingTop = UDim.new(0, 35),
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
                Parent = Section.Frame
            })
            
            local function UpdateSize()
                Section.Frame.Size = UDim2.new(1, 0, 0, Section.List.AbsoluteContentSize.Y + 45)
                Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y)
            end
            
            Section.List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSize)
            
            function Section:CreateButton(text, callback)
                local Button = CreateInstance("TextButton", {
                    Name = text .. "Button",
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Text = text,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    Parent = Section.Frame
                })
                
                CreateCorner(Button, 4)
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.AccentHover}):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
                end)
                
                Button.MouseButton1Click:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(1, -4, 0, 28)}):Play()
                    wait(0.1)
                    TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 30)}):Play()
                    if callback then callback() end
                end)
                
                UpdateSize()
                return Button
            end
            
            function Section:CreateToggle(text, default, callback)
                local Toggle = {}
                local toggled = default or false
                
                Toggle.Frame = CreateInstance("Frame", {
                    Name = text .. "Toggle",
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = Section.Frame
                })
                
                CreateCorner(Toggle.Frame, 4)
                table.insert(Objects.Tertiary, Toggle.Frame)
                
                Toggle.Label = CreateInstance("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -50, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    Parent = Toggle.Frame
                })
                
                table.insert(Objects.Text, Toggle.Label)
                
                Toggle.Switch = CreateInstance("Frame", {
                    Name = "Switch",
                    Size = UDim2.new(0, 40, 0, 20),
                    Position = UDim2.new(1, -45, 0.5, -10),
                    BackgroundColor3 = toggled and Theme.Success or Theme.Secondary,
                    BorderSizePixel = 0,
                    Parent = Toggle.Frame
                })
                
                CreateCorner(Toggle.Switch, 10)
                
                Toggle.Knob = CreateInstance("Frame", {
                    Name = "Knob",
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Parent = Toggle.Switch
                })
                
                CreateCorner(Toggle.Knob, 8)
                
                Toggle.Button = CreateInstance("TextButton", {
                    Name = "ToggleButton",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = Toggle.Frame
                })
                
                Toggle.Button.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    
                    local switchColor = toggled and Theme.Success or Theme.Secondary
                    local knobPos = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    
                    TweenService:Create(Toggle.Switch, TweenInfo.new(0.2), {BackgroundColor3 = switchColor}):Play()
                    TweenService:Create(Toggle.Knob, TweenInfo.new(0.2), {Position = knobPos}):Play()
                    
                    if callback then callback(toggled) end
                end)
                
                UpdateSize()
                return Toggle
            end
            
            function Section:CreateSlider(text, min, max, default, callback)
                local Slider = {}
                local value = default or min
                local dragging = false
                
                Slider.Frame = CreateInstance("Frame", {
                    Name = text .. "Slider",
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = Section.Frame
                })
                
                CreateCorner(Slider.Frame, 4)
                table.insert(Objects.Tertiary, Slider.Frame)
                
                Slider.Label = CreateInstance("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -60, 0, 20),
                    Position = UDim2.new(0, 10, 0, 5),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    Parent = Slider.Frame
                })
                
                table.insert(Objects.Text, Slider.Label)
                
                Slider.ValueLabel = CreateInstance("TextLabel", {
                    Name = "ValueLabel",
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(1, -55, 0, 5),
                    BackgroundTransparency = 1,
                    Text = tostring(value),
                    TextColor3 = Theme.TextSecondary,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.Gotham,
                    Parent = Slider.Frame
                })
                
                table.insert(Objects.Text, Slider.ValueLabel)
                
                Slider.Track = CreateInstance("Frame", {
                    Name = "Track",
                    Size = UDim2.new(1, -20, 0, 4),
                    Position = UDim2.new(0, 10, 1, -15),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Parent = Slider.Frame
                })
                
                CreateCorner(Slider.Track, 2)
                table.insert(Objects.Secondary, Slider.Track)
                
                Slider.Fill = CreateInstance("Frame", {
                    Name = "Fill",
                    Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = Slider.Track
                })
                
                CreateCorner(Slider.Fill, 2)
                
                Slider.Knob = CreateInstance("Frame", {
                    Name = "Knob",
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Parent = Slider.Track
                })
                
                CreateCorner(Slider.Knob, 6)
                
                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - Slider.Track.AbsolutePosition.X) / Slider.Track.AbsoluteSize.X, 0, 1)
                    value = math.floor(min + (pos * (max - min)))
                    
                    Slider.ValueLabel.Text = tostring(value)
                    TweenService:Create(Slider.Fill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
                    TweenService:Create(Slider.Knob, TweenInfo.new(0.1), {Position = UDim2.new(pos, -6, 0.5, -6)}):Play()
                    
                    if callback then callback(value) end
                end
                
                Slider.Track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        UpdateSlider(input)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UpdateSize()
                return Slider
            end
            
            function Section:CreateDropdown(text, options, callback)
                local Dropdown = {}
                local isOpen = false
                local selected = options[1] or "None"
                
                Dropdown.Frame = CreateInstance("Frame", {
                    Name = text .. "Dropdown",
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = Section.Frame
                })
                
                CreateCorner(Dropdown.Frame, 4)
                table.insert(Objects.Tertiary, Dropdown.Frame)
                
                Dropdown.Label = CreateInstance("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(0.5, -5, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    Parent = Dropdown.Frame
                })
                
                table.insert(Objects.Text, Dropdown.Label)
                
                Dropdown.Button = CreateInstance("TextButton", {
                    Name = "DropdownButton",
                    Size = UDim2.new(0.5, -10, 1, -4),
                    Position = UDim2.new(0.5, 5, 0, 2),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = selected .. " ▼",
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    Parent = Dropdown.Frame
                })
                
                CreateCorner(Dropdown.Button, 3)
                table.insert(Objects.Secondary, Dropdown.Button)
                
                Dropdown.List = CreateInstance("Frame", {
                    Name = "DropdownList",
                    Size = UDim2.new(0.5, -10, 0, 0),
                    Position = UDim2.new(0.5, 5, 1, 2),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 10,
                    Parent = Dropdown.Frame
                })
                
                CreateCorner(Dropdown.List, 3)
                table.insert(Objects.Secondary, Dropdown.List)
                
                CreateInstance("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = Dropdown.List
                })
                
                for _, option in pairs(options) do
                    local optionButton = CreateInstance("TextButton", {
                        Name = option,
                        Size = UDim2.new(1, 0, 0, 25),
                        BackgroundColor3 = Theme.Secondary,
                        BorderSizePixel = 0,
                        Text = option,
                        TextColor3 = Theme.Text,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        Parent = Dropdown.List
                    })
                    
                    optionButton.MouseEnter:Connect(function()
                        optionButton.BackgroundColor3 = Theme.Accent
                    end)
                    
                    optionButton.MouseLeave:Connect(function()
                        optionButton.BackgroundColor3 = Theme.Secondary
                    end)
                    
                    optionButton.MouseButton1Click:Connect(function()
                        selected = option
                        Dropdown.Button.Text = selected .. " ▼"
                        Dropdown.List.Visible = false
                        isOpen = false
                        if callback then callback(selected) end
                    end)
                end
                
                Dropdown.List.Size = UDim2.new(0.5, -10, 0, #options * 25)
                
                Dropdown.Button.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    Dropdown.List.Visible = isOpen
                    Dropdown.Button.Text = selected .. (isOpen and " ▲" or " ▼")
                end)
                
                UpdateSize()
                return Dropdown
            end
            
            function Section:CreateTextBox(text, placeholder, callback)
                local TextBox = {}
                
                TextBox.Frame = CreateInstance("Frame", {
                    Name = text .. "TextBox",
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = Section.Frame
                })
                
                CreateCorner(TextBox.Frame, 4)
                table.insert(Objects.Tertiary, TextBox.Frame)
                
                TextBox.Label = CreateInstance("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(0.4, -5, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    Parent = TextBox.Frame
                })
                
                table.insert(Objects.Text, TextBox.Label)
                
                TextBox.Input = CreateInstance("TextBox", {
                    Name = "Input",
                    Size = UDim2.new(0.6, -15, 1, -4),
                    Position = UDim2.new(0.4, 5, 0, 2),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = "",
                    PlaceholderText = placeholder or "Enter text...",
                    TextColor3 = Theme.Text,
                    PlaceholderColor3 = Theme.TextSecondary,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    Parent = TextBox.Frame
                })
                
                CreateCorner(TextBox.Input, 3)
                table.insert(Objects.Secondary, TextBox.Input)
                
                TextBox.Input.FocusLost:Connect(function()
                    if callback then callback(TextBox.Input.Text) end
                end)
                
                UpdateSize()
                return TextBox
            end
            
            UpdateSize()
            return Section
        end
        
        return Tab
    end
    
    function Main:SetTheme(newTheme)
        for key, value in pairs(newTheme) do
            if Theme[key] then
                Theme[key] = value
            end
        end
        
        -- Update all objects with new theme
        for _, obj in pairs(Objects.Background) do
            obj.BackgroundColor3 = Theme.Background
        end
        
        for _, obj in pairs(Objects.Sidebar) do
            obj.BackgroundColor3 = Theme.Sidebar
        end
        
        for _, obj in pairs(Objects.Content) do
            obj.BackgroundColor3 = Theme.Content
        end
        
        for _, obj in pairs(Objects.Text) do
            if obj.TextColor3 then
                obj.TextColor3 = Theme.Text
            end
        end
        
        for _, obj in pairs(Objects.Secondary) do
            obj.BackgroundColor3 = Theme.Secondary
        end
        
        for _, obj in pairs(Objects.Tertiary) do
            obj.BackgroundColor3 = Theme.Tertiary
        end
    end
    
    function Main:Toggle()
        Main.ScreenGui.Enabled = not Main.ScreenGui.Enabled
    end
    
    function Main:Destroy()
        Main.ScreenGui:Destroy()
    end
    
    return Main
end

-- Notification System
function NeverLoseUI:CreateNotification(options)
    options = options or {}
    local title = options.Title or "Notification"
    local text = options.Text or "This is a notification"
    local duration = options.Duration or 3
    local type = options.Type or "Info" -- Info, Success, Warning, Error
    
    local colors = {
        Info = Theme.Accent,
        Success = Theme.Success,
        Warning = Theme.Warning,
        Error = Theme.Error
    }
    
    local NotificationGui = CreateInstance("ScreenGui", {
        Name = "NeverLoseNotification",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    local NotificationFrame = CreateInstance("Frame", {
        Name = "NotificationFrame",
        Size = UDim2.new(0, 300, 0, 80),
        Position = UDim2.new(1, 10, 1, -90),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = NotificationGui
    })
    
    CreateCorner(NotificationFrame, 8)
    CreateStroke(NotificationFrame, 2, colors[type])
    
    local AccentBar = CreateInstance("Frame", {
        Name = "AccentBar",
        Size = UDim2.new(0, 4, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = colors[type],
        BorderSizePixel = 0,
        Parent = NotificationFrame
    })
    
    CreateCorner(AccentBar, 8)
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 1, -4),
        Position = UDim2.new(0, 0, 0, 4),
        BackgroundColor3 = colors[type],
        BorderSizePixel = 0,
        Parent = AccentBar
    })
    
    local TitleLabel = CreateInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -50, 0, 25),
        Position = UDim2.new(0, 15, 0, 5),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        Parent = NotificationFrame
    })
    
    local TextLabel = CreateInstance("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, -50, 1, -30),
        Position = UDim2.new(0, 15, 0, 25),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Theme.TextSecondary,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        Parent = NotificationFrame
    })
    
    local CloseButton = CreateInstance("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -25, 0, 5),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.TextSecondary,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        Parent = NotificationFrame
    })
    
    -- Slide in animation
    TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(1, -310, 1, -90)
    }):Play()
    
    -- Auto close after duration
    task.spawn(function()
        task.wait(duration)
        TweenService:Create(NotificationFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 10, 1, -90)
        }):Play()
        task.wait(0.3)
        NotificationGui:Destroy()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(NotificationFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 10, 1, -90)
        }):Play()
        task.spawn(function()
            task.wait(0.3)
            NotificationGui:Destroy()
        end)
    end)
end

return NeverLoseUI
