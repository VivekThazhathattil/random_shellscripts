DEVICE_ID=`xinput | grep -i touchpad | grep --only-matching "id\=[0-9]\+" | grep --only-matching "[0-9]\+"`;
PROP_NUM=`xinput list-props $DEVICE_ID | grep --ignore-case "tapping enabled (" | grep --only-matching "[0-9][0-9][0-9]"`;
xinput set-prop $DEVICE_ID $PROP_NUM 1;
