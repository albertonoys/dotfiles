#! /usr/bin/fish

function manualRegressionTests
        #TODO: search for all @p_manualRegression
        set regressionTests (find module/portal/SELENIUM/manualRegression/ -name "*.unit.php")
        testRunner $regressionTests
end