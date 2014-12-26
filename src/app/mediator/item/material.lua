--
-- Author: Anthony
-- Date: 2014-12-03 15:44:59
-- Filename: material.lua
--
----------------------------------------------------------------
local item_helper = require("app.mediator.item.item_helper")
local configMgr = require("config.configMgr")
----------------------------------------------------------------
local material = class("material")
----------------------------------------------------------------
function material:ctor(data)
    self.__data = nil
	self:set_data(data)
end
----------------------------------------
function material:get_data()
    return self.__data
end
----------------------------------------
function material:set_data( data )
    self.__data = self:gen_new(data)
    -- dump(self.__data)
end
----------------------------------------
function material:get( key )
    if key == nil then
        return self.__data
    end
    return self.__data[key]
end
----------------------------------------
function material:setkey( key, data )
    self.__data[key] = data
end
----------------------------------------
-- 转为新数据，来自己服务端
-- 因为pb会附带其他没用信息，所有需要这步
function material:gen_new(olddata)
    return {
        GUID    = olddata.GUID,
        dataId  = olddata.dataId,
        num     = olddata.num
    }
end
----------------------------------------
--[[
        得到组合过的数据
        如果有配置文件，请放在这里处理!
]]
function material:get_info()
    local dataId = self:get( "dataId" )
	local conf = configMgr:getConfig("material")
	local conf_info = conf:get_info(dataId)

    return {
        dataId      = dataId,
        kindId      = item_helper.get_serial_classid(dataId),
        GUID        = self:get( "GUID" ),
        name        = conf_info.name,
        desc        = conf_info.desc,
        quality     = item_helper.get_serial_qualityId(dataId),
        require_level = conf_info.Level,
        money_type  = conf_info.MoneyType,
        base_price  = conf_info.BasePrice,
        icon        = conf:get_icon(dataId),
        num         = self:get( "num" ),
        -- layed_num    = conf_info.LayedNum,
    }
end

----------------------------------------------------------------
return material