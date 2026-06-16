[ ! "$MODPATH" ] && MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug.log
set -x

# property
if getprop | grep vulkan | grep disable | grep -qE 'true|1'; then
  setprop debug.hwui.renderer skiagl
  setprop debug.renderengine.backend skiaglthreaded
else
  setprop debug.hwui.renderer skiavk
  setprop debug.renderengine.backend skiavkthreaded
fi









