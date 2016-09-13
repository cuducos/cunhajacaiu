module Main exposing (..)

import Date
import Decoder
import Html exposing (a, aside, br, div, footer, h1, h2, header, p, text)
import Html.App
import Html.Attributes exposing (class, href, title)
import Http
import Image
import News
import Stopwatch
import Task
import Time exposing (second)


--
-- Model
--


type alias Model =
    { news : List News.Item
    , stopwatch : Stopwatch.Model
    , voting : Date.Date
    , fallen : Bool
    }


initialModel : Model
initialModel =
    { news = []
    , stopwatch = Stopwatch.Model 0 0 0 0
    , fallen = False
    , voting = Date.fromTime 0
    }



--
-- Update
--


type Msg
    = NewsMsg News.Msg
    | StopwatchMsg Stopwatch.Msg
    | LoadNewsFailed Http.Error
    | LoadNewsSucceeded (List News.Item)
    | Tick Time.Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadNewsSucceeded news ->
            ( { model | news = news }, Cmd.none )

        Tick now ->
            let
                stopwatch =
                    Stopwatch.fromTime now (Date.toTime model.voting)
            in
                ( { model | stopwatch = stopwatch }, Cmd.none )

        _ ->
            ( model, Cmd.none )



--
-- View
--


viewWrapper : List (Html.Html a) -> Html.Html a
viewWrapper html =
    div [ class "outer" ] [ div [ class "inner" ] html ]


viewQuestion : Bool -> Html.Html Msg
viewQuestion fallen =
    let
        answer =
            if fallen then
                [ h2 [] [ text "Sim  :)" ]
                , p [] [ text "Esperamos 148 dias, 0 horas, 19 minutos e 12 segundos." ]
                ]
            else
                [ div [] [ Image.responsive "/static/imgs/no.png" "Não" ] ]

        contents =
            List.append [ h1 [] [ text "Cunha já caiu?" ] ] answer
    in
        header [] [ viewWrapper contents ]


viewNews : News.Model -> Html.Html News.Msg
viewNews model =
    aside [] [ viewWrapper <| [ News.view model ] ]


viewFooter : Html.Html Msg
viewFooter =
    let
        contents =
            [ p []
                [ text "Feito com "
                , a
                    [ title "GitHub"
                    , href "http://github.com/cuducos/cunhajacaiu"
                    ]
                    [ text "código aberto" ]
                , text " por "
                , a [ href "http://cuducos.me/" ] [ text "Cuducos" ]
                , text " e "
                , a
                    [ title "Tatiana Balachova"
                    , href "http://tatianasb.ru/"
                    ]
                    [ text "Tati" ]
                , text "."
                ]
            ]
    in
        footer [] [ viewWrapper <| contents ]


view : Model -> Html.Html Msg
view model =
    let
        stopwatchView =
            if model.fallen then
                br [] []
            else
                Stopwatch.view model.stopwatch
    in
        div [ class "wrapper" ]
            [ viewQuestion model.fallen
            , Html.App.map StopwatchMsg stopwatchView
            , Html.App.map NewsMsg (viewNews model.news)
            , viewFooter
            ]



--
-- Subscriptions
--


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick



--
-- Init
--


type alias Flags =
    { fallen : Bool
    , voting : String
    , now : Float
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        voting =
            Result.withDefault
                (Date.fromTime 0)
                (Date.fromString flags.voting)

        start =
            Date.toTime voting

        model =
            { initialModel
                | fallen = flags.fallen
                , voting = voting
                , stopwatch = Stopwatch.fromTime flags.now start
            }
    in
        ( model, loadNews )


loadNews : Cmd Msg
loadNews =
    let
        url =
            Http.url "https://www.reddit.com/search.json"
                [ ( "q", "\"Eduardo Cunha\" subreddit:brasil self:no -flair:Humor" )
                , ( "sort", "relevance" )
                , ( "t", "month" )
                ]
    in
        Task.perform
            LoadNewsFailed
            LoadNewsSucceeded
            (Http.get Decoder.news url)



--
-- App
--


main : Program Flags
main =
    Html.App.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
