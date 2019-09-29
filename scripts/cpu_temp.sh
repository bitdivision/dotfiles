# If you want the decimal place
#sensors | grep "Physical id" | tail -n 1 | cut -d "+" -f2 | cut -d "(" -f1 | cut -d "." -f1 | awk '{$1=$1};1' | rev | cut -c 4- | rev

intel_temp=$( sensors | grep "Core 0" )
ryzen_temp=$( sensors | grep "Tdie" )

if [ -n "$intel_temp" ]; then
    # Gets the physical id temp from sensors and then strip stuff to just a number
    echo $intel_temp | cut -d "+" -f2 | cut -d "(" -f1 | cut -d "." -f1 | awk '{$1=$1};1'
else
    # Ryzen doesn't show up as a core on lm_sensors yet
    echo $ryzen_temp | cut -d "+" -f2 | cut -d "(" -f1 | cut -d "." -f1 | awk '{$1=$1};1'
fi
