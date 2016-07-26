module Main exposing (..)

import Html exposing (aside, div, h1, h2, header, img, p, text)
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
    }


initialModel : Model
initialModel =
    { news = News.Model []
    , stopwatch = Stopwatch.Model 0 0 0 0 False
    }



--
-- Update
--


type Msg
    = NewsMsg News.Msg
    | StopwatchMsg Stopwatch.Msg
    | LoadNewsFailed Http.Error
    | LoadNewsSucceeded (List News.Item)
    | LoadStopwatchFailed Http.Error
    | LoadStopwatchSucceeded Stopwatch.Model
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

        LoadStopwatchFailed _ ->
            ( model, Cmd.none )

        LoadStopwatchSucceeded stopwatch ->
            ( { model | stopwatch = stopwatch }, Cmd.none )

        Tick _ ->
            let
                stopwatch =
                    Stopwatch.toStopwatch
                        (Stopwatch.toSeconds (model.stopwatch) + 1)
                        model.stopwatch.fallen
            in
                ( { model | stopwatch = stopwatch }, Cmd.none )



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
    div []
        [ div [] [ viewQuestion model.stopwatch.fallen ]
        , Html.App.map StopwatchMsg (Stopwatch.view model.stopwatch)
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


loadStopwatch : Cmd Msg
loadStopwatch =
    Task.perform
        LoadStopwatchFailed
        LoadStopwatchSucceeded
        (Http.get Decoder.stopwatch "/api/")


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
        { init = ( initialModel, Cmd.batch [ loadStopwatch, loadNews ] )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
