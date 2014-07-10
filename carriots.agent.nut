const Carriots_API_KEY = "YOUR APIKEY";
const Carriots_Device = "YOUR DEVICE ID DEVELOPER";

function Post(data) {
    local url = "https://api.carriots.com/streams/";
    local streamData = { "protocol": "v2", "checksum": "", "device": Carriots_Device , "at": "now", "data": data };
    local headers = { "carriots.apikey" : Carriots_API_KEY, "Content-Type":"application/json", "User-Agent" : "Carriots-Imp/1.0" };
    local request = http.post(url, headers, http.jsonencode(streamData));

    local response = request.sendsync();
    server.log("Data sent to Carriots. Response: "+response.statuscode+" -> "+response.body);
    return response.statuscode == 200;
}

device.on("light",Post)