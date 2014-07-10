// Create a global variable and assign pin9 to it
lightsensor <- hardware.pin9;
// Configure it as analog input
lightsensor.configure(ANALOG_IN)

local lightreading = null;
local limit = 10000;
local status = "OFF";

// Function to read data and send it to agent
function getLight() {
    // Keep the imp awake
    imp.wakeup(60, getLight);
    
    // Get light sensor reading
    lightreading = lightsensor.read();
    server.log("Light level: " + lightreading);
    
    local newStatus = status;

    if (lightreading > limit) {
        newStatus = "ON";
    } else {
        newStatus = "OFF";
    }
    
    if (status != newStatus) {
        status = newStatus;
        // Send data to agent
        local data = {"light":status};
        agent.send("light",data)
        server.log("Sending status: " + status);
    } 
}

// Initialize
getLight();