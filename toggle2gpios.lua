redled = 6 --GPIO 12
greenled = 5 --GPIO 14
gpio.mode(redled, gpio.OUTPUT)
gpio.mode(greenled, gpio.OUTPUT)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        file.open("index.html","r");
            line = file.readline();
            while line ~= nil
			do
				buf = buf..line;
				line = file.readline();
			end
		local _on,_off = "",""
        if(_GET.pin == "ON1")then
              gpio.write(redled, gpio.LOW);
        elseif(_GET.pin == "OFF1")then
              gpio.write(redled, gpio.HIGH);
        elseif(_GET.pin == "ON2")then
              gpio.write(greenled, gpio.LOW);
        elseif(_GET.pin == "OFF2")then
              gpio.write(greenled, gpio.HIGH);
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
