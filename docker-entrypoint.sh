a="DEBUG=\"${DEBUG}\""
b="MULTIPLICATOR=\"${MULTIPLICATOR}\""

if ${DEBUG} ; then
    echo "ruby" "index.rb" ${a} ${b}
fi

ruby index.rb ${a} ${b}