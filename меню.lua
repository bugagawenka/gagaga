-- Библиотека UI
local Library = {}

-- Тема (вы можете настроить под себя)
local Theme = {
    BackgroundColor = Color3.fromRGB(30, 30, 30),
    HeaderColor = Color3.fromRGB(45, 45, 45),
    SectionColor = Color3.fromRGB(40, 40, 40),
    ButtonColor = Color3.fromRGB(55, 55, 55),
    ToggleOnColor = Color3.fromRGB(85, 170, 85),
    ToggleOffColor = Color3.fromRGB(55, 55, 55),
    TextColor = Color3.fromRGB(255, 255, 255),
    SliderColor = Color3.fromRGB(100, 100, 255),
    DropdownColor = Color3.fromRGB(70, 70, 70)
}

-- Функция для создания UI библиотеки
function Library.CreateLib(title, themeName)
    local ui = {}

    -- Главное окно
    local gui = Instance.new("ScreenGui")
    gui.Name = title
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Theme.BackgroundColor
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = mainFrame

    -- Заголовок окна
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = Theme.HeaderColor
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 10)
    headerCorner.Parent = header

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Theme.TextColor
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = header

    -- Таблицы для хранения вкладок
    ui.Tabs = {}

    -- Функция для создания вкладки
    function ui:NewTab(tabName)
        local tab = {}
        tab.Name = tabName
        tab.Sections = {}

        -- Создание вкладки
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "TabButton"
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.BackgroundColor3 = Theme.ButtonColor
        tabButton.Text = tabName
        tabButton.TextColor3 = Theme.TextColor
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Position = UDim2.new(0, 10, 0, 50) -- Позиция вкладки
        tabButton.Parent = mainFrame

        -- Создание секции
        function tab:NewSection(sectionName)
            local section = {}
            section.Name = sectionName
            section.Elements = {}

            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = sectionName .. "Section"
            sectionFrame.Size = UDim2.new(1, -20, 0, 100)
            sectionFrame.Position = UDim2.new(0, 10, 0, 60) -- Позиция секции
            sectionFrame.BackgroundColor3 = Theme.SectionColor
            sectionFrame.Parent = mainFrame

            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 10)
            sectionCorner.Parent = sectionFrame

            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Name = "SectionLabel"
            sectionLabel.Size = UDim2.new(1, -10, 0, 30)
            sectionLabel.Position = UDim2.new(0, 10, 0, 10)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = sectionName
            sectionLabel.TextColor3 = Theme.TextColor
            sectionLabel.Font = Enum.Font.Gotham
            sectionLabel.TextSize = 16
            sectionLabel.Parent = sectionFrame

            -- Функция для добавления кнопки в секцию
            function section:NewButton(buttonText, buttonInfo, callback)
                local button = Instance.new("TextButton")
                button.Name = buttonText .. "Button"
                button.Size = UDim2.new(1, -20, 0, 30)
                button.Position = UDim2.new(0, 10, 0, 40)
                button.BackgroundColor3 = Theme.ButtonColor
                button.Text = buttonText
                button.TextColor3 = Theme.TextColor
                button.Font = Enum.Font.Gotham
                button.TextSize = 14
                button.Parent = sectionFrame

                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 10)
                buttonCorner.Parent = button

                button.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
            end

            -- Добавить переключатель
            function section:NewToggle(toggleText, toggleInfo, callback)
                local toggle = Instance.new("TextButton")
                toggle.Name = toggleText .. "Toggle"
                toggle.Size = UDim2.new(0, 150, 0, 30)
                toggle.Position = UDim2.new(0, 10, 0, 80)
                toggle.BackgroundColor3 = Theme.ToggleOffColor
                toggle.Text = toggleText
                toggle.TextColor3 = Theme.TextColor
                toggle.Font = Enum.Font.Gotham
                toggle.TextSize = 14
                toggle.Parent = sectionFrame

                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 10)
                toggleCorner.Parent = toggle

                toggle.MouseButton1Click:Connect(function()
                    if toggle.BackgroundColor3 == Theme.ToggleOffColor then
                        toggle.BackgroundColor3 = Theme.ToggleOnColor
                    else
                        toggle.BackgroundColor3 = Theme.ToggleOffColor
                    end
                    pcall(callback, toggle.BackgroundColor3 == Theme.ToggleOnColor)
                end)
            end

            -- Добавить слайдер
            function section:NewSlider(sliderText, sliderInfo, maxVal, minVal, callback)
                local slider = Instance.new("Frame")
                slider.Name = sliderText .. "Slider"
                slider.Size = UDim2.new(0, 250, 0, 30)
                slider.Position = UDim2.new(0, 10, 0, 120)
                slider.BackgroundColor3 = Theme.SliderColor
                slider.Parent = sectionFrame

                local sliderCorner = Instance.new("UICorner")
                sliderCorner.CornerRadius = UDim.new(0, 10)
                sliderCorner.Parent = slider

                local sliderButton = Instance.new("TextButton")
                sliderButton.Size = UDim2.new(0, 10, 1, 0)
                sliderButton.Position = UDim2.new(0, 0, 0, 0)
                sliderButton.BackgroundColor3 = Theme.TextColor
                sliderButton.Text = ""
                sliderButton.Parent = slider

                local dragging = false
                local value = 0
                sliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)

                sliderButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                slider.InputChanged:Connect(function(input)
                    if dragging then
                        local newX = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
                        sliderButton.Position = UDim2.new(0, newX, 0, 0)
                        value = math.floor((newX / slider.AbsoluteSize.X) * (maxVal - minVal) + minVal)
                        callback(value)
                    end
                end)
            end

            tab.Sections[sectionName] = section
            return section
        end

        ui.Tabs[tabName] = tab
        return tab
    end

    return ui
end

return Library
