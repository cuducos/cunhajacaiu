module Stopwatch exposing (..)

import Html exposing (..)
import Html.App as Html
import Time exposing (second)


--
-- Model
--

type alias Model =
    { days: Int
    , hours: Int
    , minutes: Int
    , seconds: Int
    , label: 
        { day: String
        , hour: String
        , minute: String
        , second: String
        }
    }

model : Model
model =
    { days = 0
    , hours = 0
    , minutes = 0
    , seconds = 0
    , label = 
        { day = "Dia"
        , hour = "Hora"
        , minute = "Minuto"
        , second = "Segundo"
        }
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

toStopwatch : Int -> Model -> Model
toStopwatch seconds model =
    { model 
    | days = seconds // (3600 * 24)
    , hours = (seconds % (3600 * 24)) // 3600
    , minutes = (seconds % 3600) // 60
    , seconds = seconds % 60
    }

type Msg = Tick Time.Time | Load { days: Int , hours: Int , minutes: Int , seconds: Int }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick newTime ->
            let
                updatedSeconds = toSeconds(model) + 1
            in 
                (toStopwatch updatedSeconds model, Cmd.none)
        Load stopwatch ->
            -- TODO: Load current stopwatch from HTML or API
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

view : Model -> Html Msg
view model =
  div []
    [ div []
        [ text <| toString model.days
        , span [] [ text pluralize model.label.day model.days ]
        ]
    , div []
        [ text <| toString model.hours
        , span [] [ text pluralize model.label.hour model.hours ]
        ]
    , div []
        [ text <| toString model.minutes
        , span [] [ text pluralize model.label.minute model.minutes ]
        ]
    , div []
        [ text <| toString model.seconds
        , span [] [ text pluralize model.label.second model.seconds ]
        ]
    ]


--
-- Init app
--

init : (Model, Cmd Msg)
init = (model, Cmd.none)

main : Program Never
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
