# Defined in - @ line 1
function logcat --wraps='locat -v color' --wraps='adb logcat -v color' --description 'alias logcat=adb logcat -v color'
  adb logcat -v color $argv;
end
