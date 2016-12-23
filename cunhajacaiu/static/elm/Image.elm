module Image exposing (responsive)

import Html exposing (img)
import Html.Attributes exposing (alt, attribute, src)
import List
import String


--
-- Settings
--


widths : List Int
widths =
    [ 240, 360, 480, 640, 800, 960, 1024, 1152, 1280, 1366, 1440, 1600, 1920, 2048 ]



--
-- Auxiliar functions
--


getExtension : String -> String
getExtension fileName =
    fileName
        |> String.split "."
        |> List.reverse
        |> List.head
        |> Maybe.withDefault fileName


getNameWithoutExtension : String -> String
getNameWithoutExtension fileName =
    String.dropRight
        (getExtension fileName |> String.length)
        fileName


responsiveFileName : String -> Int -> String
responsiveFileName fileName size =
    let
        max =
            widths
                |> List.reverse
                |> List.head
                |> Maybe.withDefault 0
    in
        if size == max then
            fileName
        else
            String.concat
                [ getNameWithoutExtension fileName
                , toString size
                , "."
                , getExtension fileName
                ]


srcSetItem : String -> Int -> String
srcSetItem fileName size =
    String.concat
        [ responsiveFileName fileName size
        , " "
        , (toString size)
        , "w"
        ]


srcSet : List Int -> String -> String
srcSet widths fileName =
    widths
        |> List.map (srcSetItem fileName)
        |> String.join ", "



--
-- Main
--


responsive : String -> String -> Html.Html a
responsive fileName text =
    img
        [ alt text
        , src fileName
        , attribute "sizes" "(min-width: 560px) 37vw, (min-width: 960px) 50vw, 34vw"
        , attribute "srcset" (srcSet widths fileName)
        ]
        []
