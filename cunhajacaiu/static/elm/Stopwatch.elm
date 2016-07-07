module Stopwatch exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (style)
import Http
import Json.Decode as Json exposing ((:=))
import Task
import Time exposing (second)


--
-- Init app
--


init : (Model, Cmd Msg)
init = (Model 0 0 0 0, loadStopwatch)

main : Program Never
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


--
-- Model
--

type alias Model =
    { days: Int
    , hours: Int
    , minutes: Int
    , seconds: Int
    }


--
-- Update
--

toSeconds : Model -> Int
toSeconds model =
    model.seconds +
    model.minutes * 60 +
    model.hours * 3600 +
    model.days * 3600 * 24

toStopwatch : Int -> Model
toStopwatch seconds =
    { days = seconds // (3600 * 24)
    , hours = (seconds % (3600 * 24)) // 3600
    , minutes = (seconds % 3600) // 60
    , seconds = seconds % 60
    }

loadStopwatch : Cmd Msg
loadStopwatch =
  let
    url = "/api/stopwatch/"
  in
    Task.perform AjaxFail AjaxSucceed (Http.get decodeStopwatch url)

decodeStopwatch : Json.Decoder Model
decodeStopwatch =
  Json.object4 Model
    ("days" := Json.int)
    ("hours" := Json.int)
    ("minutes" := Json.int)
    ("seconds" := Json.int)

type Msg
    = Tick Time.Time
    | LoadStopwatch
    | AjaxSucceed Model
    | AjaxFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of

        Tick newTime ->
            let
                updatedStopwatch = toStopwatch <| toSeconds(model) + 1
            in 
                (updatedStopwatch, Cmd.none)

        LoadStopwatch ->
            (model, loadStopwatch)

        AjaxSucceed stopwatch ->
            (stopwatch, Cmd.none)

        AjaxFail _ ->
            (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick

--
-- View
--

pluralize : String -> Int -> String
pluralize text count =
    if count == 1 then text else text ++ "s"

stopwatchView : Int -> String -> Html Msg
stopwatchView value label =
    div []
        [ text <| toString value
        , span [] [ text <| pluralize label value ]
        ]

visibility : Model -> String
visibility model =
    if toSeconds model == 0 then "hidden" else "visible"

view : Model -> Html Msg
view model =
    let
        label =
            { day = "Dia"
            , hour = "Hora"
            , minute = "Minuto"
            , second = "Segundo"
            }
    in
        div [ style [ ( "visibility", visibility model ) ] ]
            [ stopwatchView model.days label.day
            , stopwatchView model.hours label.hour
            , stopwatchView model.minutes label.minute
            , stopwatchView model.seconds label.second
            ]
