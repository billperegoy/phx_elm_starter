module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)


---- MODEL ----


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


document : Model -> Browser.Document Msg
document model =
    { title = "Page title"
    , body =
        [ div []
            [ img [ src "/images/logo.svg" ] []
            , h1 [] [ text "Your Elm App is working!" ]
            ]
        ]
    }



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.document
        { view = document
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
