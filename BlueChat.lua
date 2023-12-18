local Main = {}

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local MarketplaceService = game:GetService("MarketplaceService")

local MessageProperties = Instance.new("TextChatMessageProperties")
local BubbleProperties = Instance.new("BubbleChatMessageProperties")

local errorMessage = "Problem with TextSource; source doesn't exist or is missing"

function Main:CreateNewChatProperty(Type, Id, Rank, Tag, TagColor, BubbleTextColor, BubbleBackgroundColor, BubbleFont)

	-- // User
	if Type == "User" then

		TextChatService.OnIncomingMessage = function(message: TextChatMessage)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if Player.UserId == tonumber(Id) then
					MessageProperties.PrefixText = string.format(`<font color="{TagColor}">{Tag}</font> ` .. message.PrefixText)
				else
					return
				end
			else
				warn(errorMessage)
			end

			return MessageProperties
		end

		TextChatService.OnBubbleAdded = function(message: TextChatMessage, adornee: Instance)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if Player.UserId == tonumber(Id) then
					BubbleProperties.TextColor3 = Color3.fromHex(BubbleTextColor)
					BubbleProperties.BackgroundColor3 = Color3.fromHex(BubbleBackgroundColor)
					BubbleProperties.FontFace = Font.fromEnum(BubbleFont)
				end
			else
				return warn(errorMessage)
			end

			return BubbleProperties
		end

		-- // Group
	elseif Type == "Group" then

		TextChatService.OnIncomingMessage = function(message: TextChatMessage)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if tonumber(Rank) == nil then
					return warn("Rank is set to Nil")
				else
					if Player:GetRankInGroup(tonumber(Id)) == tonumber(Rank) then
						MessageProperties.PrefixText = string.format(`<font color="{TagColor}">{Tag}</font> ` .. message.PrefixText)
					end
				end
			else
				return warn(errorMessage)
			end

			return MessageProperties
		end

		TextChatService.OnBubbleAdded = function(message: TextChatMessage, adornee: Instance)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if tonumber(Rank) == nil then
					return warn("Rank is set to nil")
				else
					if Player:GetRankInGroup(tonumber(Id)) == tonumber(Rank) then
						BubbleProperties.TextColor3 = Color3.fromHex(BubbleTextColor)
						BubbleProperties.BackgroundColor3 = Color3.fromHex(BubbleBackgroundColor)
						BubbleProperties.FontFace = Font.fromEnum(BubbleFont)
					end
				end
			else
				return warn(errorMessage)
			end

			return BubbleProperties
		end

		-- // Game Passes
	elseif Type == "Pass" then

		TextChatService.OnIncomingMessage = function(message: TextChatMessage)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if MarketplaceService:UserOwnsGamePassAsync(Player.UserId, tonumber(Id)) then
					MessageProperties.PrefixText = string.format(`<font color="{TagColor}">{Tag}</font> ` .. message.PrefixText)
				else
					return
				end
			else
				return warn(errorMessage)
			end

			return MessageProperties
		end

		TextChatService.OnBubbleAdded = function(message: TextChatMessage, adornee: Instance)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if MarketplaceService:UserOwnsGamePassAsync(Player.UserId, tonumber(Id)) then
					BubbleProperties.TextColor3 = Color3.fromHex(BubbleTextColor)
					BubbleProperties.BackgroundColor3 = Color3.fromHex(BubbleBackgroundColor)
					BubbleProperties.FontFace = Font.fromEnum(BubbleFont)
				else
					return
				end
			end
		end

	end
end

function Main:CreateNewBubbleChatProperty(Type, Id, Rank, BubbleTextColor, BubbleBackgroundColor, BubbleFont)
	-- // User
	if Type == "User" then
		TextChatService.OnBubbleAdded = function(message: TextChatMessage, adornee: Instance)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if Player.UserId == tonumber(Id) then
					BubbleProperties.TextColor3 = Color3.fromHex(BubbleTextColor)
					BubbleProperties.BackgroundColor3 = Color3.fromHex(BubbleBackgroundColor)
					BubbleProperties.FontFace = Font.fromEnum(BubbleFont)
				end
			else
				return warn(errorMessage)
			end

			return BubbleProperties
		end

		-- // Group
	elseif Type == "Group" then
		TextChatService.OnBubbleAdded = function(message: TextChatMessage, adornee: Instance)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if tonumber(Rank) == nil then
					return warn("Rank is set to nil")
				else
					if Player:GetRankInGroup(tonumber(Id)) == tonumber(Rank) then
						BubbleProperties.TextColor3 = Color3.fromHex(BubbleTextColor)
						BubbleProperties.BackgroundColor3 = Color3.fromHex(BubbleBackgroundColor)
						BubbleProperties.FontFace = Font.fromEnum(BubbleFont)
					end
				end
			else
				return warn(errorMessage)
			end

			return BubbleProperties
		end

		-- // Game Passes
	elseif Type == "Pass" then
		TextChatService.OnBubbleAdded = function(message: TextChatMessage, adornee: Instance)
			if message.TextSource then
				local Player = Players:GetPlayerByUserId(message.TextSource.UserId)

				if MarketplaceService:UserOwnsGamePassAsync(Player.UserId, tonumber(Id)) then
					BubbleProperties.TextColor3 = Color3.fromHex(BubbleTextColor)
					BubbleProperties.BackgroundColor3 = Color3.fromHex(BubbleBackgroundColor)
					BubbleProperties.FontFace = Font.fromEnum(BubbleFont)
				else
					return
				end
			end
		end

	end
end

return Main
