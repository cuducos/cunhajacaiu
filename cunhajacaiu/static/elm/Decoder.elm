module Decoder exposing (news)

import Json.Decode as Json exposing ((:=))
import News


newsItem : Json.Decoder News.Item
newsItem =
    Json.object3 News.Item
        (Json.at [ "data", "title" ] Json.string)
        (Json.at [ "data", "url" ] Json.string)
        (Json.at [ "data", "domain" ] Json.string)


news : Json.Decoder (List News.Item)
news =
    Json.at [ "data", "children" ] (Json.list newsItem)
