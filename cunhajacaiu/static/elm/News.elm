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
    { news : List Item }



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
    if List.length model.news == 0 then
        text ""
    else
        ul [] (List.map viewItem model.news)
