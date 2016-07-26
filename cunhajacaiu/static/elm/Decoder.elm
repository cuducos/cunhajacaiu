module Decoder exposing (news, stopwatch)

import Json.Decode as Json exposing ((:=))
import News
import Stopwatch


newsItem : Json.Decoder News.Item
newsItem =
    Json.object3 News.Item
        (Json.at [ "data", "title" ] Json.string)
        (Json.at [ "data", "url" ] Json.string)
        (Json.at [ "data", "domain" ] Json.string)


news : Json.Decoder (List News.Item)
news =
    Json.at [ "data", "children" ] (Json.list newsItem)


stopwatch : Json.Decoder Stopwatch.Model
stopwatch =
    Json.object5 Stopwatch.Model
        ("days" := Json.int)
        ("hours" := Json.int)
        ("minutes" := Json.int)
        ("seconds" := Json.int)
        ("fallen" := Json.bool)
