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
    Maybe.withDefault fileName <| List.head <| List.reverse <| String.split "." fileName


getNameWithoutExtension : String -> String
getNameWithoutExtension fileName =
    String.dropRight (String.length <| getExtension fileName) fileName


responsiveFileName : String -> Int -> String
responsiveFileName fileName size =
    let
        max =
            Maybe.withDefault 0 <| List.head (List.reverse widths)
    in
        if size == max then
            fileName
        else
            getNameWithoutExtension fileName
                ++ (toString size)
                ++ "."
                ++ getExtension fileName


srcSetItem : String -> Int -> String
srcSetItem fileName size =
    (responsiveFileName fileName size)
        ++ " "
        ++ (toString size)
        ++ "w"


srcSet : List Int -> String -> String
srcSet widths fileName =
    String.join ", " <| List.map (srcSetItem fileName) widths



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
