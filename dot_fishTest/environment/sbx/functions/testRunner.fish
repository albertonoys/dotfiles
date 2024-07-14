function testRunner --description 'Wrapper for iats test'
    if test -e tests.log
        rm tests.log
    end
    set testTotalCount (count $argv)
    set testTotalCount (printf '%02d' "$testTotalCount")
    set testNumber 01
    for arg in $argv
        set_color 673ab7
        set testCorrectPath (echo $arg | sed -e 's/module\///')
        set shortTestName (echo $arg | awk -F '/' '{print $NF}')
        set characters (echo -n $testCorrectPath | wc -c)
        set testCount (printf '%02d' "$testNumber")
        printf '%s%s' "[$testCount/$testTotalCount] "
        echo -n $shortTestName
        for i in (seq $characters 100)
            echo -n ' '
        end
        set_color normal
        set testNumber (math $testNumber + 01)
        executeTest "$testCorrectPath"
    end

    set_color normal
    if test -e tests.log
        bat --paging=never --wrap=never -l log tests.log
        rm tests.log
    end
    tput bel
end

function executeTest
    if string match --regex --quiet 'js$' "$argv[1]"
        runJavascriptTest "$argv[1]"
    else
        runPhpTest "$argv[1]"
    end
end

function runPhpTest
    set oldIFS "$IFS"
    set -l IFS ""
    set output (sudo -u www-data iats test run "$argv[1]")
    printResult "$output"
end

function runJavascriptTest
    set testNameUnderscores (echo "$argv[1]" | sed 's/\//_/'g | sed 's/_UITEST//')
    set testname (basename $testNameUnderscores)
    set oldIFS "$IFS"
    set -l IFS ""
    set output (sudo -u sb-1 iats test run $testname 2>&1)
    printResult "$output"
end

function printResult
    if echo "$argv[1]" | grep -q 'pass in'
        set seconds (echo $argv[1] | grep 'pass in' | sed -e 's/.*pass in //')
        set_color 4caf50
        echo "[OK] ($seconds)"
    else if echo "$argv[1]" | grep -q 'OK ('
        set_color 4caf50
        echo "[OK]"
    else
        set_color f44336
        set seconds (echo $argv[1] | egrep -o '[0-9]+.[0-9]+s$')
        echo "[FAIL] ($seconds)"
    end
    echo "$argv[1]" >> tests.log
    echo '-----------------------------------------------' >> tests.log
    set_color normal
end
