return function(instance, attribute, callback)
	local destructor

	local function changed()
		if destructor then
			destructor()
		end
		destructor = callback(instance:GetAttribute(attribute))
	end

	if instance:GetAttribute(attribute) ~= nil then
		task.spawn(changed)
	end

	local connection = instance:GetAttributeChangedSignal(attribute):Connect(changed)

	return function()
		connection:Disconnect()
	end
end
