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

-- Создать основное окно
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

    -- Создать вкладку
    function ui:NewTab(tabName)
        local tab = {}
        tab.Name = tabName
        tab.Sections = {}

        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "TabButton"
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.BackgroundColor3 = Theme.ButtonColor
        tabButton.Text = tabName
        tabButton.TextColor3 = Theme.TextColor
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Parent = mainFrame

        -- Создать секцию
        function tab:NewSection(sectionName)
            local section = {}
            section.Name = sectionName
            section.Elements = {}

            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = sectionName .. "Section"
            sectionFrame.Size = UDim2.new(1, -20, 0, 100)
            sectionFrame.Position = UDim2.new(0, 10, 0, 60)
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

            -- Добавить кнопку
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

            tab.Sections[sectionName] = section
            return section
        end

        ui.Tabs[tabName] = tab
        return tab
    end

    return ui
end

return Library
