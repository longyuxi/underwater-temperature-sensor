# Underwater Temperature Sensor via Raspberry Pi
Ever want to monitor the temperature of your fish tank, and let notification be pushed to you every hour? This underwater temperature sensor is a Raspberry Pi powered by a solar panel, connected to a waterproof temperature sensor, runs a python script, reports the temperature regularly through [Twitter](https://twitter.com/rpinotification) and has a website that report the current temperature. 

This project is based on the code from [this repository](https://github.com/Shmoopty/rpi-appliance-monitor) but with additional features.
# Components
- Raspberry Pi (I am using a Raspberry Pi 3 B+, but pretty much any Pi works)
- A micro SD card
- Waterproof DS18B20 temperature sensor like [this](https://www.adafruit.com/product/642)
- Solar power supply ([The one I am using](https://www.adafruit.com/product/390))
- Power supply for the Pi
- Soldering iron and solder
- Internet connection
- Some jumper cables
# Setting up the hardware
### To connect the temperature sensor
Refer to  wiring in [this tutorial](https://bigl.es/ds18b20-temperature-sensor-with-python-raspberry-pi/). 
### To connect to the solar power supply
Refer to the the manual from the manufacturer of your solar power supply. It usually involves connecting a solar panel board to a controller and a rechargeable battery pack, and then connect them to one of the power ports on your Pi. [pinout.xyz](pinout.xyz) is a great place to reference the location of the ports.

### To make it service-ready
You will need a waterproof case. Technically any waterproof enclosure will work, but [this](http://openh.io/rubicon/) would be a wise choice. Drill a hole on the side of the case just big enough for the temperature sensor to come through and seal it with silicone if possible.
Then you need to solder its connection with the temperature sensor either onto a breadboard or between jumper cables so that it will not come off during service.
# Setting up the software
Use [Etcher](https://www.balena.io/etcher/) to flash [Rasbpian](https://www.raspberrypi.org/downloads/raspbian/) (any of these versions will work) onto the Raspberry Pi. Your next step would be to connect it to the network and set up SSH on the Pi. You can then choose to either connect to an HDMI TV and set it up from there, or go the [hardcore way](https://github.com/Shmoopty/rpi-appliance-monitor#step-1-create-the-os). In the end, you need to be able to SSH to the Pi through `ssh pi@{your hostname}` and run the following commands.

```
sudo apt-get update
sudo apt-get upgrade
```
Then, use SFTP (in another window) to transfer files to the Pi, 
```
sftp pi@{your hostname}
put {drag and drop your file here}
put {another file}
```
or simply clone this repository
```
git clone https://github.com/longyuxi/underwater-temperature-sensor
```
and your files should be in your home directory.

There are just a few more software-side things to do now:
- Set up python environment by running `sudo su` then `pip install -r packages.txt`
- Set up Apache2 for our webpage by running `sudo apt-get install apache2`. You should be able to go to `{your hostname}` in your browser and see the default welcome page of Apache.
- Set up a means to push your update from [this list](https://github.com/Shmoopty/rpi-appliance-monitor#step-3-create-the-software) and specify the keys to each means of your choice in  `temperature_settings.ini`.
- Autorun your code when the Pi boots by adding the command to run your code (very likely `sudo python /home/pi/temperature.py /home/pi/temperature_settings.ini `) in `/etc/rc.local` before the `exit 0` line (via `sudo nano /etc/rc.local`) 
- To change the frequency of push notification, change the number behind `time_between_each_message` in the `temperature_settings.ini`. The period between each notification is (1+[time to get temperature]) seconds, which and usuall find to be around 2 seconds, times the number specified there. So the default number of 1800 means about an hour between each message.

If the temperature sensor is set up properly, you should be able to read the temperature by running
`sudo python temperature_test.py` and read the temperature from the command window. After you are done setting up everything, run `sudo python temperature.py temperature_settings.ini`. The code will push notification through the means of your choice and will update a webpage with the latest temperature at `{your hostname}`. 