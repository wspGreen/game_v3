--
-- Author: Anthony
-- Date: 2014-10-13 16:01:25
-- equip_mgr
-- 这里面的为背包里面的装备，如果已经使用，则该数据是会存储到hero的equips里面
-- local pairs = pairs
-- local table = table
----------------------------------------------------------------
local equip = import(".equip")
----------------------------------------------------------------
local equip_mgr = class("equip_mgr")
----------------------------------------------------------------
function equip_mgr:ctor(player)
	self.__data = {}
    self.player = player
end
----------------------------------------------------------------
--
----------------------------------------
-- 得到所有数据
function equip_mgr:get_data()
    return self.__data
end
----------------------------------------
function equip_mgr:set_data( data )
    table.walk(data, function(v, k)
        self:update(v)
    end)

    -- print("---------set_equips")
    -- dump(self.__data)
end
----------------------------------------
function equip_mgr:get_count()
    return table.nums(self.__data)
end
----------------------------------------
function equip_mgr:remove( dataId )
    self.__data[dataId] = nil
end
----------------------------------------
-- 根据dataId得到equip
function equip_mgr:get_info(dataId)
    local data = self.__data[dataId]
    if data then
        return data:get_info()
    end
    return nil
end
----------------------------------------
function equip_mgr:update(newdata)
    -- local heros = self:get_data()
    -- if heros[newdata.dataId] then
    --     print("equip_mgrs update replace ",newdata.dataId)
    -- end

    -- 添加一条新数据
    self.__data[newdata.dataId] = equip.new(newdata)
    -- print("---------update")
    -- dump(self.__data)
end
----------------------------------------------------------------
return equip_mgr