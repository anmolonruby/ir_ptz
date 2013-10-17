## IR PTZ

CLI to controle a Pan, Tilt, and Zoom Camera by InfraRed via an Arduino. This
is just a simple wrapper around
[arduino_ir_remote](https://github.com/shokai/arduino_ir_remote) that adds a
cli to pass recorded signals to a camera.

## Requirements

* Arduino Uno
* [IR Shield](http://store.linksprite.com/linksprite-infrared-shield-for-arduino/) or IR LED and an IR Reviever
* USB cable (printer cabel)

## Hardware Installation

* Connect the shield to the Arduino
* Connect arduino via USB to yoru computer

Note if you are not using a shield the IR LED should be connected to PIN 3 and
the IR Receiver should be connected to PIN 11

## Software installation

Install this gem

    $ gem install ir_ptz

You will need to install the Arduino SDK and load the sketch from this gem. To
find the sketch run the following:

    $ gem contents ir_ptz | grep arduino.ino
    /PATH_TO_GEMS/1.9.1/gems/ir_ptz-x.x.x/arduino/arduino.ino

Then in the SDK open the output from above (e.g. `/PATH_TO_GEMS/1.9.1/gems/ir_ptz-x.x.x/arduino/arduino.ino`)

## Rerecording IR Signals

If for some reason you want to change the signals (maybe you have a different
model) you can rerecord them manually. To do you there are two steps:

1. run `arduino_ir_remote --read tilt_up`
2. when the command prints 'reading...' press and release the remote

It will should you the output that was recorded to `~/.ir_remote.yml`
