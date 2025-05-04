[ ! "$MODPATH" ] && MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug.log
set -x

# property
if dumpsys SurfaceFlinger | grep -i vulkan | grep -Ei 'true|enabled'; then
  setprop debug.hwui.renderer skiavk
  setprop debug.renderengine.backend skiavkthreaded
else
  setprop debug.hwui.renderer skiagl
  setprop debug.renderengine.backend skiaglthreaded
fi









