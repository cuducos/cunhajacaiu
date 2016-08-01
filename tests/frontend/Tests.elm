module Tests exposing (..)

import ElmTest exposing (Test, assertEqual, defaultTest, runSuite, suite)
import TestStopwatch


all : Test
all =
    suite "A Test Suite"
        [ TestStopwatch.all ]


main : Program Never
main =
    runSuite all
