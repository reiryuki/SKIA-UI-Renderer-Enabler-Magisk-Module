# space
ui_print " "

# var
UID=`id -u`
[ ! "$UID" ] && UID=0

# log
if [ "$BOOTMODE" != true ]; then
  FILE=/data/media/"$UID"/$MODID\_recovery.log
  ui_print "- Log will be saved at $FILE"
  exec 2>$FILE
  ui_print " "
fi

# optionals
OPTIONALS=/data/media/"$UID"/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# debug
if [ "`grep_prop debug.log $OPTIONALS`" == 1 ]; then
  ui_print "- The install log will contain detailed information"
  set -x
  ui_print " "
fi

# recovery
if [ "$BOOTMODE" != true ]; then
  MODPATH_UPDATE=`echo $MODPATH | sed 's|modules/|modules_update/|g'`
  rm -f $MODPATH/update
  rm -rf $MODPATH_UPDATE
fi

# run
. $MODPATH/function.sh

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
if [ "$KSU" == true ]; then
  ui_print " KSUVersion=$KSU_VER"
  ui_print " KSUVersionCode=$KSU_VER_CODE"
  ui_print " KSUKernelVersionCode=$KSU_KERNEL_VER_CODE"
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# cleaning
ui_print "- Cleaning..."
remove_sepolicy_rule
ui_print " "

# mode
if [ "`grep_prop skia.enable $OPTIONALS`" == 0 ]; then
  ui_print "- This module will force disable SKIA renderer"
  ui_print "  instead of enable"
  FILE=$MODPATH/service.sh
  sed -i 's|skiavkthreaded|threaded|g' $FILE
  sed -i 's|skiaglthreaded|threaded|g' $FILE
  sed -i 's|skiavk|vulkan|g' $FILE
  sed -i 's|skiagl|opengl|g' $FILE
  MODNAME2=`echo $MODNAME | sed 's|Enabler|Disabler|g'`
  sed -i "s|$MODNAME|$MODNAME2|g" $MODPATH/module.prop
  ui_print " "
fi

# apply
if [ "$BOOTMODE" == true ]; then
  if [ "`grep_prop skia.enable $OPTIONALS`" == 0 ]; then
    ui_print "- Disables SKIA renderer now..."
    ui_print " "
    apply_script
    ui_print " "
    ui_print "  SKIA renderer is already disabled"
    ui_print "  so you don't need to reboot"
    ui_print "  but keep this module installed"
    ui_print "  to disable SKIA renderer in every device boot"
  else
    ui_print "- Enables SKIA renderer now..."
    ui_print " "
    apply_script
    ui_print " "
    ui_print "  SKIA renderer is already enabled"
    ui_print "  so you don't need to reboot"
    ui_print "  but keep this module installed"
    ui_print "  to enable SKIA renderer in every device boot"
  fi
  ui_print " "
fi







