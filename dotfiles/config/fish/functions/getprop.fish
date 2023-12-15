# Defined in - @ line 1
function getprop --wraps='adb shell getprop' --description 'alias getprop=adb shell getprop'
  adb shell getprop $argv;
end
