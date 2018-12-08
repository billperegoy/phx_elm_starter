module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Url


---- MODEL ----


type alias Model =
    {}


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ =
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


onUrlChange : Url.Url -> Msg
onUrlChange _ =
    NoOp


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
    NoOp



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = document
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        }
