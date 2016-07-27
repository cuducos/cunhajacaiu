module Main exposing (..)

import Date
import Html exposing (aside, br, div, h1, h2, header, img, p, text)
import Html.Attributes exposing (alt, class, src)
import Html.App
import Http
import Task
import Time exposing (second)
import Decoder
import News
import Stopwatch


--
-- Model
--


type alias Model =
    { news : News.Model
    , stopwatch : Stopwatch.Model
    , voting : Date.Date
    , fallen : Bool
    }


initialModel : Model
initialModel =
    let
        voting =
            "2016-04-17T23:37:00-03:00"

        fallen =
            False

        votingDate =
            Result.withDefault (Date.fromTime 0) (Date.fromString voting)
    in
        { news = News.Model []
        , stopwatch = Stopwatch.Model 0 0 0 0
        , voting = votingDate
        , fallen = fallen
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
        NewsMsg msg ->
            ( model, Cmd.none )

        StopwatchMsg msg ->
            ( model, Cmd.none )

        LoadNewsFailed _ ->
            ( model, Cmd.none )

        LoadNewsSucceeded news ->
            ( { model | news = News.Model news }, Cmd.none )

        Tick newTime ->
            let
                seconds =
                    if Stopwatch.toSeconds model.stopwatch == 0 then
                        round <| (newTime - (Date.toTime model.voting)) / 1000
                    else
                        (Stopwatch.toSeconds model.stopwatch) + 1

                newStopwatch =
                    Stopwatch.toStopwatch seconds
            in
                ( { model | stopwatch = newStopwatch }, Cmd.none )



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
                , p [] [ text "Não definitivamente, mas pelo menos está afastado do cargo…" ]
                ]
            else
                [ div [] [ img [ src "/static/imgs/no.png", alt "Não" ] [] ] ]

        contents =
            List.append [ h1 [] [ text "Cunha já caiu?" ] ] answer
    in
        header [] [ viewWrapper contents ]


viewNews : News.Model -> Html.Html News.Msg
viewNews model =
    aside [] [ viewWrapper <| [ News.view model ] ]


view : Model -> Html.Html Msg
view model =
    let
        stopwatchView =
            if model.fallen then
                br [] []
            else
                Stopwatch.view model.stopwatch
    in
        div []
            [ div [] [ viewQuestion model.fallen ]
            , Html.App.map StopwatchMsg stopwatchView
            , Html.App.map NewsMsg (viewNews model.news)
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


main : Program Never
main =
    Html.App.program
        { init = ( initialModel, loadNews )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
