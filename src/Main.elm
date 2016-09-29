module Main exposing (main)

import Date exposing (Date)
import Html
import Html.App
import Json.Decode as Json


type alias Flags =
    { now : Json.Value
    , foo : Json.Value
    }


type alias Model =
    Flags


type Msg
    = NoOp


main =
    Html.App.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( flags, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.div [] [ Html.h2 [] [ Html.text "model" ], Html.text (toString model) ]
        , viewDate model
        ]


viewDate : Model -> Html.Html Msg
viewDate model =
    let
        dateResult : Result String Date
        dateResult =
            -- this is what's newly possible
            Json.decodeValue Json.date model.now

        fooResult : Result String Date
        fooResult =
            -- this should result in Err
            Json.decodeValue Json.date model.foo
    in
        Html.div []
            [ Html.h2 [] [ Html.text "date" ]
            , Html.div [] [ Html.text <| toString dateResult ]
            , Html.div [] [ Html.text <| toString (Result.map Date.toTime dateResult) ]
            , Html.h2 [] [ Html.text "foo" ]
            , Html.div [] [ Html.text <| toString fooResult ]
            ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
