## IR PTZ

CLI to controle a Pan, Tilt, and Zoom Camera by InfraRed via an Arduino. This
is just a wrapper around
[arduino_ir_remote](https://github.com/shokai/arduino_ir_remote) that adds the following:

 - cli to replay recorded codes
 - ability to record new codes

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

## Still to do

Have writing to the Arduino not stop processing incoming key presses. Basically
I will buffer the input in one thread and write out the buffer in the other I
think.
