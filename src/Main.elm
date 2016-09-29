port module Main exposing (main)

import Date exposing (Date)
import Html
import Html.App
import Json.Decode as Json


type alias Flags =
    { now : Json.Value
    , foo : Json.Value
    }


type alias Model =
    { flags : Flags
    , newNow : Maybe (Result String Date)
    }


type Msg
    = NewDate Json.Value


main =
    Html.App.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { flags = flags, newNow = Nothing }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg |> Debug.log "msg" of
        NewDate raw ->
            let
                newNow =
                    Json.decodeValue Json.date raw
            in
                { model | newNow = Just newNow } ! []


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
            Json.decodeValue Json.date model.flags.now

        fooResult : Result String Date
        fooResult =
            -- this should result in Err
            Json.decodeValue Json.date model.flags.foo
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
    newDate NewDate


port newDate : (Json.Value -> msg) -> Sub msg
