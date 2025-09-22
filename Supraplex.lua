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
local Theme = {
    Background = Color3.fromRGB(13, 17, 23),
    SidebarBg = Color3.fromRGB(16, 20, 26),
    ContentBg = Color3.fromRGB(19, 23, 29),
    AccentColor = Color3.fromRGB(88, 166, 255),
    SecondaryAccent = Color3.fromRGB(147, 103, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(156, 163, 175),
    ButtonBg = Color3.fromRGB(31, 41, 55),
    InputBg = Color3.fromRGB(17, 24, 39),
    BorderColor = Color3.fromRGB(55, 65, 81),
    HoverColor = Color3.fromRGB(37, 47, 63),
    ActiveColor = Color3.fromRGB(29, 78, 216),
}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
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
function NeverloseUI:CreateSmoothTween(object, duration, properties)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    )
    return self:Tween(object, tweenInfo, properties)
end
function NeverloseUI:CreateBounceEffect(object, scale)
    scale = scale or 0.95
    local originalSize = object.Size
    self:CreateSmoothTween(object, 0.1, {Size = UDim2.new(originalSize.X.Scale * scale, originalSize.X.Offset, originalSize.Y.Scale * scale, originalSize.Y.Offset)}):Play()
    wait(0.1)
    self:CreateSmoothTween(object, 0.2, {Size = originalSize}):Play()
end
function NeverloseUI:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "NEVERLOSE"
    local windowSize = config.Size or UDim2.new(0, 900, 0, 650)
    local Window = {}
    local currentTab = nil
    Window.ScreenGui = self:Create("ScreenGui", {
        Name = windowName,
        Parent = CoreGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true
    })
    Window.BlurFrame = self:Create("Frame", {
        Name = "BlurFrame",
        Parent = Window.ScreenGui,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        ZIndex = 0
    })
    Window.MainFrame = self:Create("Frame", {
        Name = "MainFrame",
        Parent = Window.ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = windowSize,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 1
    })
    table.insert(Objects.Background, Window.MainFrame)
    self:Create("UICorner", {
        Parent = Window.MainFrame,
        CornerRadius = UDim.new(0, 8)
    })
    Window.ShadowFrame = self:Create("Frame", {
        Name = "ShadowFrame",
        Parent = Window.ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 3),
        Size = UDim2.new(windowSize.X.Scale, windowSize.X.Offset + 30, windowSize.Y.Scale, windowSize.Y.Offset + 30),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        ZIndex = 0
    })
    self:Create("UICorner", {
        Parent = Window.ShadowFrame,
        CornerRadius = UDim.new(0, 15)
    })
    self:Create("UIStroke", {
        Parent = Window.MainFrame,
        Color = Theme.AccentColor,
        Thickness = 1,
        Transparency = 0.8
    })
    Window.TitleBar = self:Create("Frame", {
        Name = "TitleBar",
        Parent = Window.MainFrame,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.SidebarBg,
        BorderSizePixel = 0
    })
    table.insert(Objects.SidebarBg, Window.TitleBar)
    self:Create("UICorner", {
        Parent = Window.TitleBar,
        CornerRadius = UDim.new(0, 8)
    })
    self:Create("Frame", {
        Parent = Window.TitleBar,
        Position = UDim2.new(0, 0, 0.6, 0),
        Size = UDim2.new(1, 0, 0.4, 0),
        BackgroundColor3 = Theme.SidebarBg,
        BorderSizePixel = 0
    })
    Window.TitleIcon = self:Create("Frame", {
        Name = "TitleIcon",
        Parent = Window.TitleBar,
        Position = UDim2.new(0, 15, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundColor3 = Theme.AccentColor,
        BorderSizePixel = 0
    })
    self:Create("UICorner", {
        Parent = Window.TitleIcon,
        CornerRadius = UDim.new(0, 3)
    })
    Window.Title = self:Create("TextLabel", {
        Name = "Title",
        Parent = Window.TitleBar,
        Position = UDim2.new(0, 45, 0, 0),
        Size = UDim2.new(0, 200, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = Theme.TextColor,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    table.insert(Objects.TextColor, Window.Title)
    Window.MinimizeButton = self:Create("TextButton", {
        Name = "MinimizeButton",
        Parent = Window.TitleBar,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -50, 0, 8),
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundColor3 = Theme.ButtonBg,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = "─",
        TextColor3 = Theme.SubTextColor,
        TextSize = 14
    })
    self:Create("UICorner", {
        Parent = Window.MinimizeButton,
        CornerRadius = UDim.new(0, 4)
    })
    Window.CloseButton = self:Create("TextButton", {
        Name = "CloseButton",
        Parent = Window.TitleBar,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -15, 0, 8),
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundColor3 = Color3.fromRGB(220, 53, 69),
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Theme.TextColor,
        TextSize = 16
    })
    self:Create("UICorner", {
        Parent = Window.CloseButton,
        CornerRadius = UDim.new(0, 4)
    })
    Window.Sidebar = self:Create("Frame", {
        Name = "Sidebar",
        Parent = Window.MainFrame,
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(0, 220, 1, -40),
        BackgroundColor3 = Theme.SidebarBg,
        BorderSizePixel = 0
    })
    table.insert(Objects.SidebarBg, Window.Sidebar)
    Window.ContentArea = self:Create("Frame", {
        Name = "ContentArea",
        Parent = Window.MainFrame,
        Position = UDim2.new(0, 220, 0, 40),
        Size = UDim2.new(1, -220, 1, -40),
        BackgroundColor3 = Theme.ContentBg,
        BorderSizePixel = 0
    })
    table.insert(Objects.ContentBg, Window.ContentArea)
    self:Create("Frame", {
        Parent = Window.MainFrame,
        Position = UDim2.new(0, 219, 0, 40),
        Size = UDim2.new(0, 1, 1, -40),
        BackgroundColor3 = Theme.BorderColor,
        BorderSizePixel = 0
    })
    self:Create("UICorner", {
        Parent = Window.ContentArea,
        CornerRadius = UDim.new(0, 8)
    })
    self:Create("Frame", {
        Parent = Window.ContentArea,
        Position = UDim2.new(0, -8, 0, 0),
        Size = UDim2.new(0, 8, 1, 0),
        BackgroundColor3 = Theme.ContentBg,
        BorderSizePixel = 0
    })
    self:Create("Frame", {
        Parent = Window.ContentArea,
        Position = UDim2.new(0, 0, 0, -8),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Theme.ContentBg,
        BorderSizePixel = 0
    })
    Window.SearchFrame = self:Create("Frame", {
        Name = "SearchFrame",
        Parent = Window.Sidebar,
        Position = UDim2.new(0, 15, 0, 15),
        Size = UDim2.new(1, -30, 0, 35),
        BackgroundColor3 = Theme.InputBg,
        BorderSizePixel = 0
    })
    self:Create("UICorner", {
        Parent = Window.SearchFrame,
        CornerRadius = UDim.new(0, 6)
    })
    Window.SearchBox = self:Create("TextBox", {
        Parent = Window.SearchFrame,
        Position = UDim2.new(0, 35, 0, 0),
        Size = UDim2.new(1, -40, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        PlaceholderText = "Search...",
        PlaceholderColor3 = Theme.SubTextColor,
        Text = "",
        TextColor3 = Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    Window.SearchIcon = self:Create("TextLabel", {
        Parent = Window.SearchFrame,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 35, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = "🔍",
        TextColor3 = Theme.SubTextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    Window.TabContainer = self:Create("ScrollingFrame", {
        Name = "TabContainer",
        Parent = Window.Sidebar,
        Position = UDim2.new(0, 15, 0, 65),
        Size = UDim2.new(1, -30, 1, -80),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.AccentColor,
        CanvasSize = UDim2.new(0, 0, 0, 0),
    })
    self:Create("UIListLayout", {
        Parent = Window.TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    })
    self:Create("UIPadding", {
        Parent = Window.TabContainer,
        PaddingTop = UDim.new(0, 5)
    })
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
            Window.ShadowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y + 3)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    local function setupButtonHover(button, hoverColor, normalColor)
        button.MouseEnter:Connect(function()
            self:CreateSmoothTween(button, 0.2, {BackgroundColor3 = hoverColor}):Play()
        end)
        button.MouseLeave:Connect(function()
            self:CreateSmoothTween(button, 0.2, {BackgroundColor3 = normalColor}):Play()
        end
    end
    setupButtonHover(Window.MinimizeButton, Theme.HoverColor, Theme.ButtonBg)
    setupButtonHover(Window.CloseButton, Color3.fromRGB(185, 28, 28), Color3.fromRGB(220, 53, 69))
    local isMinimized = false
    local originalSize = windowSize
    Window.MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            self:CreateSmoothTween(Window.MainFrame, 0.3, {Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 40)}):Play()
            self:CreateSmoothTween(Window.ShadowFrame, 0.3, {Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 30, 0, 70)}):Play()
            Window.MinimizeButton.Text = "□"
        else
            self:CreateSmoothTween(Window.MainFrame, 0.3, {Size = originalSize}):Play()
            self:CreateSmoothTween(Window.ShadowFrame, 0.3, {Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 30, originalSize.Y.Scale, originalSize.Y.Offset + 30)}):Play()
            Window.MinimizeButton.Text = "─"
        end
    end)
    Window.CloseButton.MouseButton1Click:Connect(function()
        self:CreateSmoothTween(Window.MainFrame, 0.3, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        self:CreateSmoothTween(Window.ShadowFrame, 0.3, {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        self:CreateSmoothTween(Window.BlurFrame, 0.3, {BackgroundTransparency = 1}):Play()
        wait(0.3)
        Window.ScreenGui:Destroy()
    end)
    function Window:CreateTab(tabName, iconText)
        local Tab = {}
        iconText = iconText or "●"
        Tab.Button = NeverloseUI:Create("TextButton", {
            Name = tabName,
            Parent = Window.TabContainer,
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = Theme.ButtonBg,
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            Text = "",
            AutoButtonColor = false
        })
        table.insert(Objects.ButtonBg, Tab.Button)
        NeverloseUI:Create("UICorner", {
            Parent = Tab.Button,
            CornerRadius = UDim.new(0, 6)
        })
        Tab.Icon = NeverloseUI:Create("TextLabel", {
            Parent = Tab.Button,
            Position = UDim2.new(0, 15, 0, 0),
            Size = UDim2.new(0, 20, 1, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            Text = iconText,
            TextColor3 = Theme.SubTextColor,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Center
        })
        Tab.Label = NeverloseUI:Create("TextLabel", {
            Parent = Tab.Button,
            Position = UDim2.new(0, 45, 0, 0),
            Size = UDim2.new(1, -55, 1, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            Text = tabName,
            TextColor3 = Theme.SubTextColor,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        Tab.ActiveIndicator = NeverloseUI:Create("Frame", {
            Parent = Tab.Button,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 3, 1, 0),
            BackgroundColor3 = Theme.AccentColor,
            BorderSizePixel = 0,
            Visible = false
        })
        NeverloseUI:Create("UICorner", {
            Parent = Tab.ActiveIndicator,
            CornerRadius = UDim.new(0, 2)
        })
        Tab.Content = NeverloseUI:Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Parent = Window.ContentArea,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Theme.AccentColor,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ElasticBehavior = Enum.ElasticBehavior.Never
        })
        NeverloseUI:Create("UIListLayout", {
            Parent = Tab.Content,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        NeverloseUI:Create("UIPadding", {
            Parent = Tab.Content,
            PaddingLeft = UDim.new(0, 25),
            PaddingRight = UDim.new(0, 25),
            PaddingTop = UDim.new(0, 25),
            PaddingBottom = UDim.new(0, 25)
        })
        Tab.Button.MouseButton1Click:Connect(function()
            NeverloseUI:CreateBounceEffect(Tab.Button, 0.96)
            for _, child in pairs(Window.ContentArea:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            for _, child in pairs(Window.TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    NeverloseUI:CreateSmoothTween(child, 0.2, {BackgroundColor3 = Theme.ButtonBg}):Play()
                    if child:FindFirstChild("Icon") then
                        NeverloseUI:CreateSmoothTween(child.Icon, 0.2, {TextColor3 = Theme.SubTextColor}):Play()
                    end
                    if child:FindFirstChild("Label") then
                        NeverloseUI:CreateSmoothTween(child.Label, 0.2, {TextColor3 = Theme.SubTextColor}):Play()
                    end
                    if child:FindFirstChild("ActiveIndicator") then
                        child.ActiveIndicator.Visible = false
                    end
                end
            end
            Tab.Content.Visible = true
            NeverloseUI:CreateSmoothTween(Tab.Button, 0.2, {BackgroundColor3 = Theme.ActiveColor}):Play()
            NeverloseUI:CreateSmoothTween(Tab.Icon, 0.2, {TextColor3 = Theme.TextColor}):Play()
            NeverloseUI:CreateSmoothTween(Tab.Label, 0.2, {TextColor3 = Theme.TextColor}):Play()
            Tab.ActiveIndicator.Visible = true
            currentTab = Tab
        end)
        Tab.Button.MouseEnter:Connect(function()
            if currentTab ~= Tab then
                NeverloseUI:CreateSmoothTween(Tab.Button, 0.2, {BackgroundColor3 = Theme.HoverColor}):Play()
            end
        end)
        Tab.Button.MouseLeave:Connect(function()
            if currentTab ~= Tab then
                NeverloseUI:CreateSmoothTween(Tab.Button, 0.2, {BackgroundColor3 = Theme.ButtonBg}):Play()
            end
        end)
        if currentTab == nil then
            Tab.Button.BackgroundColor3 = Theme.ActiveColor
            Tab.Icon.TextColor3 = Theme.TextColor
            Tab.Label.TextColor3 = Theme.TextColor
            Tab.ActiveIndicator.Visible = true
            Tab.Content.Visible = true
            currentTab = Tab
        end
        Window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, Window.TabContainer.UIListLayout.AbsoluteContentSize.Y + 15)
        function Tab:CreateSection(sectionName)
            local Section = {}
            Section.Frame = NeverloseUI:Create("Frame", {
                Name = sectionName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 50),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })
            Section.Title = NeverloseUI:Create("TextLabel", {
                Parent = Section.Frame,
                Position = UDim2.new(0, 0, 0, 5),
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = sectionName,
                TextColor3 = Theme.TextColor,
                TextSize = 18,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Section.Title)
            Section.Line = NeverloseUI:Create("Frame", {
                Parent = Section.Frame,
                Position = UDim2.new(0, 0, 0, 35),
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = Theme.AccentColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.AccentColor, Section.Line)
            NeverloseUI:Create("UICorner", {
                Parent = Section.Line,
                CornerRadius = UDim.new(0, 1)
            })
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 62)
            return Section
        end
        function Tab:CreateButton(buttonName, callback)
            local Button = NeverloseUI:Create("TextButton", {
                Name = buttonName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 42),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0,
                Font = Enum.Font.GothamMedium,
                Text = buttonName,
                TextColor3 = Theme.TextColor,
                TextSize = 14,
                AutoButtonColor = false
            })
            table.insert(Objects.ButtonBg, Button)
            NeverloseUI:Create("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 6)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Button,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.7
            })
            Button.MouseEnter:Connect(function()
                NeverloseUI:CreateSmoothTween(Button, 0.2, {
                    BackgroundColor3 = Theme.HoverColor,
                    Size = UDim2.new(1, 0, 0, 44)
                }):Play()
            end)
            Button.MouseLeave:Connect(function()
                NeverloseUI:CreateSmoothTween(Button, 0.2, {
                    BackgroundColor3 = Theme.ButtonBg,
                    Size = UDim2.new(1, 0, 0, 42)
                }):Play()
            end)
            Button.MouseButton1Click:Connect(function()
                NeverloseUI:CreateBounceEffect(Button, 0.95)
                if callback then callback() end
            end)
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 54)
            return Button
        end
        function Tab:CreateToggle(toggleName, defaultState, callback)
            local Toggle = {}
            defaultState = defaultState or false
            Toggle.Frame = NeverloseUI:Create("Frame", {
                Name = toggleName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Toggle.Frame)
            NeverloseUI:Create("UICorner", {
                Parent = Toggle.Frame,
                CornerRadius = UDim.new(0, 8)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Toggle.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            Toggle.Label = NeverloseUI:Create("TextLabel", {
                Parent = Toggle.Frame,
                Position = UDim2.new(0, 18, 0, 0),
                Size = UDim2.new(1, -80, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = toggleName,
                TextColor3 = Theme.TextColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Toggle.Label)
            Toggle.SwitchBg = NeverloseUI:Create("Frame", {
                Parent = Toggle.Frame,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -18, 0.5, 0),
                Size = UDim2.new(0, 48, 0, 24),
                BackgroundColor3 = defaultState and Theme.AccentColor or Theme.BorderColor,
                BorderSizePixel = 0
            })
            NeverloseUI:Create("UICorner", {
                Parent = Toggle.SwitchBg,
                CornerRadius = UDim.new(1, 0)
            })
            Toggle.SwitchKnob = NeverloseUI:Create("Frame", {
                Parent = Toggle.SwitchBg,
                Position = defaultState and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(0, 20, 0, 20),
                BackgroundColor3 = Theme.TextColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.TextColor, Toggle.SwitchKnob)
            NeverloseUI:Create("UICorner", {
                Parent = Toggle.SwitchKnob,
                CornerRadius = UDim.new(1, 0)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Toggle.SwitchKnob,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 1,
                Transparency = 0.9
            })
            Toggle.State = defaultState
            local function UpdateToggle()
                local targetColor = Toggle.State and Theme.AccentColor or Theme.BorderColor
                local targetPosition = Toggle.State and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2)
                NeverloseUI:CreateSmoothTween(Toggle.SwitchBg, 0.25, {BackgroundColor3 = targetColor}):Play()
                NeverloseUI:CreateSmoothTween(Toggle.SwitchKnob, 0.25, {Position = targetPosition}):Play()
                NeverloseUI:CreateSmoothTween(Toggle.SwitchKnob, 0.1, {Size = UDim2.new(0, 18, 0, 18)}):Play()
                wait(0.1)
                NeverloseUI:CreateSmoothTween(Toggle.SwitchKnob, 0.15, {Size = UDim2.new(0, 20, 0, 20)}):Play()
            end
            Toggle.Button = NeverloseUI:Create("TextButton", {
                Parent = Toggle.Frame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false
            })
            Toggle.Button.MouseEnter:Connect(function()
                NeverloseUI:CreateSmoothTween(Toggle.Frame, 0.2, {BackgroundColor3 = Theme.HoverColor}):Play()
            end)
            Toggle.Button.MouseLeave:Connect(function()
                NeverloseUI:CreateSmoothTween(Toggle.Frame, 0.2, {BackgroundColor3 = Theme.ButtonBg}):Play()
            end)
            Toggle.Button.MouseButton1Click:Connect(function()
                Toggle.State = not Toggle.State
                UpdateToggle()
                if callback then callback(Toggle.State) end
            end)
            function Toggle:SetState(state)
                Toggle.State = state
                UpdateToggle()
            end
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 64)
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
                Size = UDim2.new(1, 0, 0, 78),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Slider.Frame)
            NeverloseUI:Create("UICorner", {
                Parent = Slider.Frame,
                CornerRadius = UDim.new(0, 8)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Slider.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            Slider.HeaderFrame = NeverloseUI:Create("Frame", {
                Parent = Slider.Frame,
                Position = UDim2.new(0, 18, 0, 8),
                Size = UDim2.new(1, -36, 0, 25),
                BackgroundTransparency = 1
            })
            Slider.Label = NeverloseUI:Create("TextLabel", {
                Parent = Slider.HeaderFrame,
                Size = UDim2.new(1, -80, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = sliderName,
                TextColor3 = Theme.TextColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Slider.Label)
            Slider.ValueFrame = NeverloseUI:Create("Frame", {
                Parent = Slider.HeaderFrame,
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(0, 65, 1, 0),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0
            })
            NeverloseUI:Create("UICorner", {
                Parent = Slider.ValueFrame,
                CornerRadius = UDim.new(0, 4)
            })
            Slider.ValueDisplay = NeverloseUI:Create("TextLabel", {
                Parent = Slider.ValueFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = tostring(defaultValue),
                TextColor3 = Theme.AccentColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Center
            })
            table.insert(Objects.AccentColor, Slider.ValueDisplay)
            Slider.TrackBg = NeverloseUI:Create("Frame", {
                Parent = Slider.Frame,
                Position = UDim2.new(0, 18, 0, 45),
                Size = UDim2.new(1, -36, 0, 8),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0
            })
            NeverloseUI:Create("UICorner", {
                Parent = Slider.TrackBg,
                CornerRadius = UDim.new(1, 0)
            })
            Slider.Fill = NeverloseUI:Create("Frame", {
                Parent = Slider.TrackBg,
                Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0),
                BackgroundColor3 = Theme.AccentColor,
                BorderSizePixel = 0
            })
            table.insert(Objects.AccentColor, Slider.Fill)
            NeverloseUI:Create("UICorner", {
                Parent = Slider.Fill,
                CornerRadius = UDim.new(1, 0)
            })
            Slider.Knob = NeverloseUI:Create("Frame", {
                Parent = Slider.TrackBg,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 0.5, 0),
                Size = UDim2.new(0, 16, 0, 16),
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
                Thickness = 3,
                Transparency = 0.7
            })
            Slider.Value = defaultValue
            local dragging = false
            local isDragging = false
            local function UpdateSlider(percent, animate)
                percent = math.clamp(percent, 0, 1)
                Slider.Value = math.floor(minValue + (maxValue - minValue) * percent + 0.5)
                Slider.ValueDisplay.Text = tostring(Slider.Value)
                local tweenTime = animate and 0.15 or 0.05
                NeverloseUI:CreateSmoothTween(Slider.Fill, tweenTime, {
                    Size = UDim2.new(percent, 0, 1, 0)
                }):Play()
                NeverloseUI:CreateSmoothTween(Slider.Knob, tweenTime, {
                    Position = UDim2.new(percent, 0, 0.5, 0)
                }):Play()
                if callback then callback(Slider.Value) end
            end
            local function HandleInput(input)
                local trackPos = Slider.TrackBg.AbsolutePosition
                local trackSize = Slider.TrackBg.AbsoluteSize
                local percent = math.clamp((input.Position.X - trackPos.X) / trackSize.X, 0, 1)
                UpdateSlider(percent, false)
            end
            Slider.TrackBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true
                    HandleInput(input)
                    NeverloseUI:CreateSmoothTween(Slider.Knob, 0.1, {Size = UDim2.new(0, 20, 0, 20)}):Play()
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    HandleInput(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
                    isDragging = false
                    NeverloseUI:CreateSmoothTween(Slider.Knob, 0.15, {Size = UDim2.new(0, 16, 0, 16)}):Play()
                end
            end)
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 90)
            return Slider
        end
		function Tab:CreateKeybind(keybindName, defaultKey, callback)
			local Keybind = {}
			Keybind.Frame = NeverloseUI:Create("Frame", {
				Name = keybindName,
				Parent = Tab.Content,
				Size = UDim2.new(1, 0, 0, 62),
				BackgroundColor3 = Theme.ButtonBg,
				BorderSizePixel = 0
			})
			table.insert(Objects.ButtonBg, Keybind.Frame)
			NeverloseUI:Create("UICorner", {
				Parent = Keybind.Frame,
				CornerRadius = UDim.new(0, 8)
			})
			NeverloseUI:Create("UIStroke", {
				Parent = Keybind.Frame,
				Color = Theme.BorderColor,
				Thickness = 1,
				Transparency = 0.8
			})
			Keybind.Label = NeverloseUI:Create("TextLabel", {
				Parent = Keybind.Frame,
				Position = UDim2.new(0, 18, 0, 8),
				Size = UDim2.new(1, -140, 0, 20),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				Text = keybindName,
				TextColor3 = Theme.TextColor,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			table.insert(Objects.TextColor, Keybind.Label)
			Keybind.StatusLabel = NeverloseUI:Create("TextLabel", {
				Parent = Keybind.Frame,
				Position = UDim2.new(0, 18, 0, 28),
				Size = UDim2.new(1, -140, 0, 16),
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham,
				Text = "Click to bind a key",
				TextColor3 = Theme.SubTextColor,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			Keybind.KeyButton = NeverloseUI:Create("TextButton", {
				Parent = Keybind.Frame,
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, -18, 0, 12),
				Size = UDim2.new(0, 110, 0, 38),
				BackgroundColor3 = Theme.InputBg,
				BorderSizePixel = 0,
				Font = Enum.Font.GothamBold,
				Text = defaultKey and (defaultKey == Enum.UserInputType.MouseButton2 and "RIGHT CLICK" or defaultKey.Name) or "NONE",
				TextColor3 = defaultKey and Theme.AccentColor or Theme.SubTextColor,
				TextSize = 13,
				AutoButtonColor = false
			})
			NeverloseUI:Create("UICorner", {
				Parent = Keybind.KeyButton,
				CornerRadius = UDim.new(0, 6)
			})
			NeverloseUI:Create("UIStroke", {
				Parent = Keybind.KeyButton,
				Color = defaultKey and Theme.AccentColor or Theme.BorderColor,
				Thickness = 2,
				Transparency = defaultKey and 0.3 or 0.7
			})
			Keybind.CurrentKey = defaultKey
			Keybind.Recording = false
			local inputConnection = nil
			local keyConnection = nil
			local holdConnection = nil
			local isKeyHeld = false
			local lastTriggerTime = 0
			local triggerInterval = 0.05
			local function UpdateKeyDisplay()
				if Keybind.CurrentKey then
					if Keybind.CurrentKey == Enum.UserInputType.MouseButton2 then
						Keybind.KeyButton.Text = "RIGHT CLICK"
					elseif Keybind.CurrentKey.Name then
						Keybind.KeyButton.Text = Keybind.CurrentKey.Name
					else
						Keybind.KeyButton.Text = tostring(Keybind.CurrentKey)
					end
					Keybind.KeyButton.TextColor3 = Theme.AccentColor
					Keybind.KeyButton.UIStroke.Color = Theme.AccentColor
					Keybind.KeyButton.UIStroke.Transparency = 0.3
					Keybind.StatusLabel.Text = "Key bound successfully"
				else
					Keybind.KeyButton.Text = "NONE"
					Keybind.KeyButton.TextColor3 = Theme.SubTextColor
					Keybind.KeyButton.UIStroke.Color = Theme.BorderColor
					Keybind.KeyButton.UIStroke.Transparency = 0.7
					Keybind.StatusLabel.Text = "No key bound"
				end
			end
			local function SetupKeyDetection()
				if keyConnection then
					keyConnection:Disconnect()
				end
				if holdConnection then
					holdConnection:Disconnect()
				end
				if not Keybind.CurrentKey then return end
				if Keybind.CurrentKey == Enum.UserInputType.MouseButton2 then
					keyConnection = UserInputService.InputBegan:Connect(function(input, processed)
						if processed then return end
						if input.UserInputType == Enum.UserInputType.MouseButton2 then
							if not isKeyHeld then
								isKeyHeld = true
								lastTriggerTime = tick()
								NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.1, {
									BackgroundColor3 = Theme.AccentColor
								}):Play()
								if callback then callback(Keybind.CurrentKey) end
							end
						end
					end)
					local endConnection = UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton2 then
							isKeyHeld = false
							NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.2, {
								BackgroundColor3 = Theme.InputBg
							}):Play()
						end
					end)
					holdConnection = RunService.Heartbeat:Connect(function()
						if isKeyHeld then
							local currentTime = tick()
							if currentTime - lastTriggerTime >= triggerInterval then
								lastTriggerTime = currentTime
								if callback then callback(Keybind.CurrentKey) end
							end
						end
					end)
				else
					keyConnection = UserInputService.InputBegan:Connect(function(keyInput, processed)
						if processed then return end
						if keyInput.UserInputType == Enum.UserInputType.Keyboard and 
						   keyInput.KeyCode == Keybind.CurrentKey then
							if not isKeyHeld then
								isKeyHeld = true
								lastTriggerTime = tick()
								NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.1, {
									BackgroundColor3 = Theme.AccentColor
								}):Play()
								if callback then callback(Keybind.CurrentKey) end
							end
						end
					end)
					local endConnection = UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.Keyboard and
						   input.KeyCode == Keybind.CurrentKey then
							isKeyHeld = false
							NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.2, {
								BackgroundColor3 = Theme.InputBg
							}):Play()
						end
					end)
					holdConnection = RunService.Heartbeat:Connect(function()
						if isKeyHeld then
							local currentTime = tick()
							if currentTime - lastTriggerTime >= triggerInterval then
								lastTriggerTime = currentTime
								if callback then callback(Keybind.CurrentKey) end
							end
						end
					end)
				end
			end
			Keybind.KeyButton.MouseButton1Click:Connect(function()
				if Keybind.Recording then return end
				Keybind.Recording = true
				isKeyHeld = false
				Keybind.KeyButton.Text = "PRESS KEY..."
				Keybind.KeyButton.TextColor3 = Theme.TextColor
				Keybind.StatusLabel.Text = "Listening for key input..."
				NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.2, {
					BackgroundColor3 = Theme.AccentColor,
					Size = UDim2.new(0, 115, 0, 40)
				}):Play()
				local pulseConnection
				pulseConnection = RunService.Heartbeat:Connect(function()
					if not Keybind.Recording then
						pulseConnection:Disconnect()
						return
					end
					local pulse = math.sin(tick() * 6) * 0.5 + 0.5
					Keybind.KeyButton.UIStroke.Transparency = 0.2 + pulse * 0.3
				end)
				inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed or not Keybind.Recording then return end
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == Enum.KeyCode.Escape then
							Keybind.CurrentKey = nil
							Keybind.StatusLabel.Text = "Keybind cleared"
						else
							Keybind.CurrentKey = input.KeyCode
							Keybind.StatusLabel.Text = "Key bound: " .. input.KeyCode.Name
						end
					elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
						Keybind.CurrentKey = Enum.UserInputType.MouseButton2
						Keybind.StatusLabel.Text = "Key bound: Right Click"
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 or 
						   input.UserInputType == Enum.UserInputType.MouseButton3 then
						return
					end
					Keybind.Recording = false
					isKeyHeld = false
					NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.3, {
						BackgroundColor3 = Theme.InputBg,
						Size = UDim2.new(0, 110, 0, 38)
					}):Play()
					UpdateKeyDisplay()
					if inputConnection then
						inputConnection:Disconnect()
						inputConnection = nil
					end
					SetupKeyDetection()
				end)
				spawn(function()
					wait(8)
					if Keybind.Recording then
						Keybind.Recording = false
						isKeyHeld = false
						Keybind.StatusLabel.Text = "Recording timed out"
						NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.3, {
							BackgroundColor3 = Theme.InputBg,
							Size = UDim2.new(0, 110, 0, 38)
						}):Play()
						UpdateKeyDisplay()
						if inputConnection then
							inputConnection:Disconnect()
							inputConnection = nil
						end
					end
				end)
			end)
			Keybind.KeyButton.MouseEnter:Connect(function()
				if not Keybind.Recording and not isKeyHeld then
					NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.2, {
						BackgroundColor3 = Theme.HoverColor
					}):Play()
				end
			end)
			Keybind.KeyButton.MouseLeave:Connect(function()
				if not Keybind.Recording and not isKeyHeld then
					NeverloseUI:CreateSmoothTween(Keybind.KeyButton, 0.2, {
						BackgroundColor3 = Theme.InputBg
					}):Play()
				end
			end)
			UpdateKeyDisplay()
			if defaultKey then
				SetupKeyDetection()
			end
			Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 74)
			return Keybind
		end
        function Tab:CreateDropdown(dropdownName, options, defaultOption, callback)
            local Dropdown = {}
            options = options or {}
            Dropdown.Frame = NeverloseUI:Create("Frame", {
                Name = dropdownName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 62),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0,
                ClipsDescendants = false,
                ZIndex = 1
            })
            table.insert(Objects.ButtonBg, Dropdown.Frame)
            NeverloseUI:Create("UICorner", {
                Parent = Dropdown.Frame,
                CornerRadius = UDim.new(0, 8)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Dropdown.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            Dropdown.Label = NeverloseUI:Create("TextLabel", {
                Parent = Dropdown.Frame,
                Position = UDim2.new(0, 18, 0, 8),
                Size = UDim2.new(1, -36, 0, 20),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = dropdownName,
                TextColor3 = Theme.TextColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Dropdown.Label)
            Dropdown.Button = NeverloseUI:Create("TextButton", {
                Parent = Dropdown.Frame,
                Position = UDim2.new(0, 18, 0, 30),
                Size = UDim2.new(1, -36, 0, 24),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 2
            })
            table.insert(Objects.InputBg, Dropdown.Button)
            NeverloseUI:Create("UICorner", {
                Parent = Dropdown.Button,
                CornerRadius = UDim.new(0, 6)
            })
            Dropdown.SelectedText = NeverloseUI:Create("TextLabel", {
                Parent = Dropdown.Button,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -35, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = defaultOption or (options[1] or "Select option..."),
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2
            })
            table.insert(Objects.TextColor, Dropdown.SelectedText)
            Dropdown.Arrow = NeverloseUI:Create("TextLabel", {
                Parent = Dropdown.Button,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = "▼",
                TextColor3 = Theme.AccentColor,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Center,
                Rotation = 0,
                ZIndex = 2
            })
            table.insert(Objects.AccentColor, Dropdown.Arrow)
            Dropdown.OptionsFrame = NeverloseUI:Create("Frame", {
                Parent = Dropdown.Frame,
                Position = UDim2.new(0, 18, 0, 54),
                Size = UDim2.new(1, -36, 0, 0),
                BackgroundColor3 = Theme.ContentBg,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                ZIndex = 10
            })
            table.insert(Objects.ContentBg, Dropdown.OptionsFrame)
            NeverloseUI:Create("UICorner", {
                Parent = Dropdown.OptionsFrame,
                CornerRadius = UDim.new(0, 6)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Dropdown.OptionsFrame,
                Color = Theme.AccentColor,
                Thickness = 1,
                Transparency = 0.6
            })
            Dropdown.OptionsScroll = NeverloseUI:Create("ScrollingFrame", {
                Parent = Dropdown.OptionsFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarThickness = 4,
                ScrollBarImageColor3 = Theme.AccentColor,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ZIndex = 11
            })
            NeverloseUI:Create("UIListLayout", {
                Parent = Dropdown.OptionsScroll,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2)
            })
            NeverloseUI:Create("UIPadding", {
                Parent = Dropdown.OptionsScroll,
                PaddingTop = UDim.new(0, 6),
                PaddingBottom = UDim.new(0, 6),
                PaddingLeft = UDim.new(0, 6),
                PaddingRight = UDim.new(0, 6)
            })
            Dropdown.IsOpen = false
            Dropdown.SelectedValue = defaultOption or options[1]
            local function CreateOptions()
                for _, child in pairs(Dropdown.OptionsScroll:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                for i, option in pairs(options) do
                    local optionButton = NeverloseUI:Create("TextButton", {
                        Parent = Dropdown.OptionsScroll,
                        Size = UDim2.new(1, 0, 0, 32),
                        BackgroundColor3 = option == Dropdown.SelectedValue and Theme.AccentColor or Theme.ButtonBg,
                        BorderSizePixel = 0,
                        Font = Enum.Font.GothamMedium,
                        Text = option,
                        TextColor3 = option == Dropdown.SelectedValue and Theme.TextColor or Theme.SubTextColor,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false,
                        ZIndex = 12,
                        LayoutOrder = i
                    })
                    NeverloseUI:Create("UICorner", {
                        Parent = optionButton,
                        CornerRadius = UDim.new(0, 4)
                    })
                    NeverloseUI:Create("UIPadding", {
                        Parent = optionButton,
                        PaddingLeft = UDim.new(0, 10)
                    })
                    optionButton.MouseEnter:Connect(function()
                        if option ~= Dropdown.SelectedValue then
                            NeverloseUI:CreateSmoothTween(optionButton, 0.15, {
                                BackgroundColor3 = Theme.HoverColor,
                                TextColor3 = Theme.TextColor
                            }):Play()
                        end
                    end)
                    optionButton.MouseLeave:Connect(function()
                        if option ~= Dropdown.SelectedValue then
                            NeverloseUI:CreateSmoothTween(optionButton, 0.15, {
                                BackgroundColor3 = Theme.ButtonBg,
                                TextColor3 = Theme.SubTextColor
                            }):Play()
                        end
                    end)
                    optionButton.MouseButton1Click:Connect(function()
                        Dropdown.SelectedValue = option
                        Dropdown.SelectedText.Text = option
                        Dropdown.IsOpen = false
                        NeverloseUI:CreateSmoothTween(Dropdown.OptionsFrame, 0.25, {Size = UDim2.new(1, -36, 0, 0)}):Play()
                        NeverloseUI:CreateSmoothTween(Dropdown.Arrow, 0.25, {Rotation = 0}):Play()
                        NeverloseUI:CreateSmoothTween(Dropdown.Frame, 0.25, {Size = UDim2.new(1, 0, 0, 62)}):Play()
                        wait(0.1)
                        CreateOptions()
                        if callback then callback(option) end
                    end)
                end
                Dropdown.OptionsScroll.CanvasSize = UDim2.new(0, 0, 0, Dropdown.OptionsScroll.UIListLayout.AbsoluteContentSize.Y + 12)
            end
            CreateOptions()
            Dropdown.Button.MouseButton1Click:Connect(function()
                Dropdown.IsOpen = not Dropdown.IsOpen
                if Dropdown.IsOpen then
                    local maxHeight = 150
                    local optionsHeight = math.min(#options * 34 + 12, maxHeight)
                    NeverloseUI:CreateSmoothTween(Dropdown.OptionsFrame, 0.25, {
                        Size = UDim2.new(1, -36, 0, optionsHeight)
                    }):Play()
                    NeverloseUI:CreateSmoothTween(Dropdown.Arrow, 0.25, {Rotation = 180}):Play()
                    local newFrameHeight = 62 + optionsHeight + 5
                    NeverloseUI:CreateSmoothTween(Dropdown.Frame, 0.25, {
                        Size = UDim2.new(1, 0, 0, newFrameHeight)
                    }):Play()
                    Dropdown.Frame.ZIndex = 100
                else
                    NeverloseUI:CreateSmoothTween(Dropdown.OptionsFrame, 0.25, {
                        Size = UDim2.new(1, -36, 0, 0)
                    }):Play()
                    NeverloseUI:CreateSmoothTween(Dropdown.Arrow, 0.25, {Rotation = 0}):Play()
                    NeverloseUI:CreateSmoothTween(Dropdown.Frame, 0.25, {Size = UDim2.new(1, 0, 0, 62)}):Play()
                    Dropdown.Frame.ZIndex = 1
                end
            end)
            Dropdown.Button.MouseEnter:Connect(function()
                if not Dropdown.IsOpen then
                    NeverloseUI:CreateSmoothTween(Dropdown.Button, 0.2, {
                        BackgroundColor3 = Theme.HoverColor
                    }):Play()
                end
            end)
            Dropdown.Button.MouseLeave:Connect(function()
                if not Dropdown.IsOpen then
                    NeverloseUI:CreateSmoothTween(Dropdown.Button, 0.2, {
                        BackgroundColor3 = Theme.InputBg
                    }):Play()
                end
            end)
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 74)
            return Dropdown
        end
        function Tab:CreateTextbox(textboxName, placeholderText, callback)
            local Textbox = {}
            Textbox.Frame = NeverloseUI:Create("Frame", {
                Name = textboxName,
                Parent = Tab.Content,
                Size = UDim2.new(1, 0, 0, 62),
                BackgroundColor3 = Theme.ButtonBg,
                BorderSizePixel = 0
            })
            table.insert(Objects.ButtonBg, Textbox.Frame)
            NeverloseUI:Create("UICorner", {
                Parent = Textbox.Frame,
                CornerRadius = UDim.new(0, 8)
            })
            NeverloseUI:Create("UIStroke", {
                Parent = Textbox.Frame,
                Color = Theme.BorderColor,
                Thickness = 1,
                Transparency = 0.8
            })
            Textbox.Label = NeverloseUI:Create("TextLabel", {
                Parent = Textbox.Frame,
                Position = UDim2.new(0, 18, 0, 8),
                Size = UDim2.new(1, -36, 0, 20),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = textboxName,
                TextColor3 = Theme.TextColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(Objects.TextColor, Textbox.Label)
            Textbox.Input = NeverloseUI:Create("TextBox", {
                Parent = Textbox.Frame,
                Position = UDim2.new(0, 18, 0, 30),
                Size = UDim2.new(1, -36, 0, 24),
                BackgroundColor3 = Theme.InputBg,
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                PlaceholderText = placeholderText or "Enter text...",
                PlaceholderColor3 = Theme.SubTextColor,
                Text = "",
                TextColor3 = Theme.TextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false
            })
            table.insert(Objects.InputBg, Textbox.Input)
            table.insert(Objects.TextColor, Textbox.Input)
            NeverloseUI:Create("UICorner", {
                Parent = Textbox.Input,
                CornerRadius = UDim.new(0, 6)
            })
            NeverloseUI:Create("UIPadding", {
                Parent = Textbox.Input,
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12)
            })
            Textbox.Input.Focused:Connect(function()
                NeverloseUI:CreateSmoothTween(Textbox.Input, 0.2, {
                    BackgroundColor3 = Theme.HoverColor
                }):Play()
                NeverloseUI:CreateSmoothTween(Textbox.Frame.UIStroke, 0.2, {
                    Color = Theme.AccentColor,
                    Transparency = 0.4
                }):Play()
            end)
            Textbox.Input.FocusLost:Connect(function(enterPressed)
                NeverloseUI:CreateSmoothTween(Textbox.Input, 0.2, {
                    BackgroundColor3 = Theme.InputBg
                }):Play()
                NeverloseUI:CreateSmoothTween(Textbox.Frame.UIStroke, 0.2, {
                    Color = Theme.BorderColor,
                    Transparency = 0.8
                }):Play()
                if callback then callback(Textbox.Input.Text, enterPressed) end
            end)
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, Tab.Content.UIListLayout.AbsoluteContentSize.Y + 74)
            return Textbox
        end
        return Tab
    end
    return Window
end
function NeverloseUI:SetTheme(themeName, color)
    if Theme[themeName] then
        Theme[themeName] = color
        local objectList = Objects[themeName] or {}
        for _, object in pairs(objectList) do
            if object and object.Parent then
                if object:IsA("Frame") or object:IsA("TextButton") then
                    self:CreateSmoothTween(object, 0.3, {BackgroundColor3 = color}):Play()
                elseif object:IsA("TextLabel") or object:IsA("TextBox") then
                    if themeName == "TextColor" then
                        self:CreateSmoothTween(object, 0.3, {TextColor3 = color}):Play()
                    else
                        self:CreateSmoothTween(object, 0.3, {BackgroundColor3 = color}):Play()
                    end
                end
            end
        end
    end
end
function NeverloseUI:CreateNotification(title, message, duration)
    duration = duration or 5
    local notification = self:Create("Frame", {
        Parent = CoreGui,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -20, 0, -100),
        Size = UDim2.new(0, 300, 0, 80),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 1000
    })
    self:Create("UICorner", {
        Parent = notification,
        CornerRadius = UDim.new(0, 8)
    })
    self:Create("UIStroke", {
        Parent = notification,
        Color = Theme.AccentColor,
        Thickness = 2,
        Transparency = 0.5
    })
    local titleLabel = self:Create("TextLabel", {
        Parent = notification,
        Position = UDim2.new(0, 15, 0, 8),
        Size = UDim2.new(1, -30, 0, 20),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    local messageLabel = self:Create("TextLabel", {
        Parent = notification,
        Position = UDim2.new(0, 15, 0, 28),
        Size = UDim2.new(1, -30, 0, 44),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = message,
        TextColor3 = Theme.SubTextColor,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    self:CreateSmoothTween(notification, 0.4, {Position = UDim2.new(1, -20, 0, 20)}):Play()
    spawn(function()
        wait(duration)
        self:CreateSmoothTween(notification, 0.4, {
            Position = UDim2.new(1, -20, 0, -100),
            BackgroundTransparency = 1
        }):Play()
        wait(0.4)
        notification:Destroy()
    end)
    return notification
end
function NeverloseUI:CreateLoadingSpinner(parent, size)
    size = size or UDim2.new(0, 24, 0, 24)
    local spinner = self:Create("Frame", {
        Parent = parent,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = size,
        BackgroundTransparency = 1
    })
    for i = 1, 8 do
        local dot = self:Create("Frame", {
            Parent = spinner,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(
                0.5 + 0.3 * math.cos((i - 1) * math.pi / 4),
                0,
                0.5 + 0.3 * math.sin((i - 1) * math.pi / 4),
                0
            ),
            Size = UDim2.new(0, 4, 0, 4),
            BackgroundColor3 = Theme.AccentColor,
            BorderSizePixel = 0
        })
        self:Create("UICorner", {
            Parent = dot,
            CornerRadius = UDim.new(1, 0)
        })
        spawn(function()
            while dot.Parent do
                self:CreateSmoothTween(dot, 0.6, {BackgroundTransparency = 0.8}):Play()
                wait(0.6)
                self:CreateSmoothTween(dot, 0.6, {BackgroundTransparency = 0}):Play()
                wait((8 - i) * 0.1)
            end
            end)
    end
    return spinner
end
return NeverloseUI
