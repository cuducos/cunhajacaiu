module News exposing (Item, Model, Msg, view)

import Html exposing (a, li, span, text, ul)
import Html.Attributes exposing (href)


type Msg
    = False



--
-- Model
--


type alias Item =
    { title : String
    , url : String
    , domain : String
    }


type alias Model =
    List Item



--
-- View
--


viewItem : Item -> Html.Html Msg
viewItem news =
    let
        linkText =
            [ text news.title
            , span [] [ text (" " ++ news.domain) ]
            ]
    in
        li [] [ a [ href news.url ] linkText ]


view : Model -> Html.Html Msg
view model =
    if List.length model == 0 then
        text ""
    else
        ul [] (List.map viewItem <| List.take 7 model)
