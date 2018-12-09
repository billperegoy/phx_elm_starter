module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, a, text, div, h1, h2)
import Html.Attributes exposing (href)
import Url


---- MODEL ----


type alias Model =
    { currentUrl : Url.Url
    , navigationKey : Browser.Navigation.Key
    }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    ( { currentUrl = url
      , navigationKey = navigationKey
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ClickLink Browser.UrlRequest
    | UpdateUrl Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickLink urlRequest ->
            ( model
            , urlRequestEffect model.navigationKey urlRequest
            )

        UpdateUrl url ->
            ( { model | currentUrl = url }
            , Cmd.none
            )


urlRequestEffect : Browser.Navigation.Key -> Browser.UrlRequest -> Cmd Msg
urlRequestEffect navigationKey urlRequest =
    case urlRequest of
        Browser.Internal url ->
            Browser.Navigation.pushUrl navigationKey (Url.toString url)

        Browser.External url ->
            Browser.Navigation.load url


onUrlChange : Url.Url -> Msg
onUrlChange url =
    UpdateUrl url


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest urlRequest =
    ClickLink urlRequest



---- VIEW ----


document : Model -> Browser.Document Msg
document model =
    { title = "Page title"
    , body =
        [ div []
            [ h1 [] [ text "Your Elm App is working!" ]
            , div [] [ a [ href "/" ] [ text "Home" ] ]
            , div [] [ a [ href "/about" ] [ text "About" ] ]
            , div [] [ a [ href "/contact" ] [ text "Contact" ] ]
            , div [] [ a [ href "https://guide.elm-lang.org/" ] [ text "External" ] ]
            , pageContent model.currentUrl
            ]
        ]
    }


pageContent : Url.Url -> Html Msg
pageContent url =
    let
        pageText =
            case url.path of
                "/" ->
                    "main page"

                "/about" ->
                    "about page"

                "/contact" ->
                    "contact page"

                _ ->
                    "unknown page"
    in
        h2 [] [ text pageText ]



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
