local List = class("List")

function List:ctor()
    self.first = 0
    self.last = -1
    self.arr = {}
end

function List:pushfirst(value)
    local first = self.first - 1
    self.first = first
    self.arr[first] = value
    self:debuginfo()
end

function List:pushlast(value)
    local last = self.last + 1
    self.last = last
    self.arr[last] = value
    self:debuginfo()
end

function List:popfirst()
    local first = self.first
    if first > self.last then 
        return nil
    end
    local value = self.arr[first]
    self.arr[first] = nil
    self.first = first+1    
    self:debuginfo()
    return value
end

function List:poplast()
    local last = self.last
    if self.first > last then 
        return nil
    end
    local value = self.arr[last]
    self.arr[last] = nil
    self.last = last - 1
    self:debuginfo()
    return value
end

function List:getfirst()
    local first = self.first
    if first > self.last then 
        return nil
    end
    return self.arr[first]
end

function List:debuginfo()        
    local debugstr = ""
    local i = self.first
    while i<self.last  do
        debugstr = debugstr .. "  " ..  tostring(self.arr[i])
        i = i + 1
    end
    -- print("first=" .. self.first .. ",  last=" .. self.last .. "     raw:" .. debugstr)
end

function List:size()
    return self.last - self.first + 1
end

function List:clear()
    self.first = 0
    self.last = -1
    self.arr = {}
end

-- test
function List:test()
     print("..........xxx.............")
     local list  = require("base/list"):new()
     list:pushfirst(1)
     list:pushlast(2)
     list:pushfirst(3)
     list:pushlast(4)

     print("0  " .. list:popfirst())
     print("1  " .. list:popfirst())
     print("2  " .. list:popfirst())
     print("3  " .. list:popfirst())
end

return List