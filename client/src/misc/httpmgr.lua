-- httpÇëÇóÀà
local HttpMgr = class("HttpMgr")

function HttpMgr:ctor()
    
end

function HttpMgr:Req(url, sucessCallback, failCallback)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

    local function onReadyStateChanged()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then            
            sucessCallback(xhr.response)
        else            
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
            failCallback(xhr.status)
        end
        xhr:unregisterScriptHandler()
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    xhr:open("GET", url)
    xhr:send()
end


return HttpMgr
