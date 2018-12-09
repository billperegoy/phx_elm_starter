module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, a, text, div, h1, h2)
import Html.Attributes exposing (href)
import Url


---- MODEL ----


type alias Model =
    { currentUrl : Url.Url }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url _ =
    ( { currentUrl = url
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp
    | UpdateUrl Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateUrl url ->
            ( model, Cmd.none )



---- VIEW ----


document : Model -> Browser.Document Msg
document model =
    { title = "Page title"
    , body =
        [ div []
            [ h1 [] [ text "Your Elm App is working!" ]
            , div [] [ a [ href "/about" ] [ text "About" ] ]
            , div [] [ a [ href "/contact" ] [ text "Contact" ] ]
            , pageContent model.currentUrl
            ]
        ]
    }


pageContent : Url.Url -> Html Msg
pageContent url =
    h2 [] [ text "My page" ]


onUrlChange : Url.Url -> Msg
onUrlChange url =
    UpdateUrl url


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
