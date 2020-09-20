a1="DEBUG=\"${DEBUG}\""
a2="DEBUG_FILE=\"${DEBUG_FILE}\""
[ -z "${DEBUG_FILE}" ] && a=$a1 || a=$a2

a1="MULTIPLICATOR=\"${MULTIPLICATOR}\""
a2="MULTIPLICATOR_FILE=\"${MULTIPLICATOR_FILE}\""
[ -z "${MULTIPLICATOR_FILE}" ] && a=$a1 || a=$a2

ruby index.rb ${a} ${b}