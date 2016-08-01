module Stopwatch exposing (Model, Msg, fromTime, toSeconds, view)

import Html exposing (br, div, main', p, span, strong, text)
import Html.Attributes exposing (class, id)


type Msg
    = False



--
-- Model
--


type alias Model =
    { days : Int
    , hours : Int
    , minutes : Int
    , seconds : Int
    }



--
-- Update (helper functions)
--


toSeconds : Model -> Int
toSeconds model =
    model.seconds
        + (model.minutes * 60)
        + (model.hours * 3600)
        + (model.days * 3600 * 24)


toStopwatch : Int -> Model
toStopwatch seconds =
    { days = seconds // (3600 * 24)
    , hours = (seconds % (3600 * 24)) // 3600
    , minutes = (seconds % 3600) // 60
    , seconds = seconds % 60
    }


fromTime : Float -> Float -> Model
fromTime now start =
    toStopwatch <| round <| (now - start) / 1000



--
-- View
--


pluralize : String -> Int -> String
pluralize text count =
    if count == 1 then
        text
    else
        text ++ "s"


viewStopwatchField : Int -> String -> Html.Html Msg
viewStopwatchField value label =
    div []
        [ text <| toString value
        , span [] [ text <| pluralize label value ]
        ]


viewStopwatch : Model -> Html.Html Msg
viewStopwatch model =
    if toSeconds model == 0 then
        text ""
    else
        let
            label =
                { day = "Dia"
                , hour = "Hora"
                , minute = "Minuto"
                , second = "Segundo"
                }
        in
            div [ id "stopwatch" ]
                [ viewStopwatchField model.days label.day
                , viewStopwatchField model.hours label.hour
                , viewStopwatchField model.minutes label.minute
                , viewStopwatchField model.seconds label.second
                ]


view : Model -> Html.Html Msg
view model =
    let
        details =
            [ p [ class "details" ]
                [ text "desde a votação do impeachment na Câmara, com a expectativa de que"
                , br [] []
                , strong [] [ text "o Cunha será o próximo" ]
                , text "."
                ]
            , p [ class "details" ] [ text "Ele renunciou à presidência da Câmara, mas continua como deputado e com acusação de quebra de decoro." ]
            ]
    in
        main' [] (List.append [ viewStopwatch model ] details)
