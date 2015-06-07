wifi.setmode(wifi.STATIONAP);
wifi.ap.config({ssid="ESP_07_test",pwd="123456789"});
wifi.sta.config("Your_SSID","Your_password");
wifi.sta.connect();
dofile("toggle2gpios.lua")
