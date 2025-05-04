# function
apply_script() {
. $MODPATH/service.sh
NAME=debug.hwui.renderer
VAL=`getprop $NAME`
ui_print "  $NAME=$VAL"
NAME=debug.renderengine.backend
VAL=`getprop $NAME`
ui_print "  $NAME=$VAL"
}
remove_sepolicy_rule() {
rm -rf /metadata/magisk/"$MODID"\
 /mnt/vendor/persist/magisk/"$MODID"\
 /persist/magisk/"$MODID"\
 /data/unencrypted/magisk/"$MODID"\
 /cache/magisk/"$MODID"\
 /cust/magisk/"$MODID"
}


