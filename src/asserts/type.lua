local TypeError = require("src.errors.type")
local prettyValue = require("src.utils.prettyValue")

--- Asserts the object is of the specified type
---
--- If `typeStringOrMeta` is a string it uses `type()`, otherwise it uses `getmetatable`
---@param object any
---@param typeStringOrMeta type | table
---@param label? string
---@param level? number
return function(object, typeStringOrMeta, label, level)
	label = label or prettyValue(object)
	level = (level or 1) + 1

	if
		type(object) == typeStringOrMeta
		or getmetatable(object) == typeStringOrMeta
	then
		return
	end

	if type(typeStringOrMeta) == "string" then
		error(
			TypeError(
				string.format("Expected %s to be a %s", label, typeStringOrMeta)
			),
			level
		)
	end

	if type(typeStringOrMeta) == "table" then
		error(
			TypeError(
				string.format(
					"Expected %s to be an instance of %s",
					label,
					prettyValue(typeStringOrMeta)
				)
			),
			level
		)
	end

	error(TypeError("typeStringOrMeta must be either a string or a table"), 2)
end
