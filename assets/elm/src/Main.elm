module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
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
    let
        page =
            pageContent model.currentUrl
    in
        { title = page.title
        , body =
            [ div
                [ style "margin-left" "100px"
                , style "margin-righ" "100px"
                ]
                [ menu
                , h2 [] [ text page.content ]
                ]
            ]
        }


menu : Html Msg
menu =
    div []
        [ menuElement "/" "Home"
        , menuElement "/about" "About"
        , menuElement "/contact" "Contact"
        , menuElement "https://guide.elm-lang.org" "External"
        ]


menuElement : String -> String -> Html Msg
menuElement url string =
    span menuElementStyle
        [ a [ href url ] [ text string ] ]


menuElementStyle : List (Html.Attribute Msg)
menuElementStyle =
    [ style "margin-right" "15px"
    , style "font-size" "2em"
    ]


pageContent : Url.Url -> { title : String, content : String }
pageContent url =
    case url.path of
        "/" ->
            { title = "Home", content = "main page" }

        "/about" ->
            { title = "About", content = "about page" }

        "/contact" ->
            { title = "Contact", content = "contact page" }

        _ ->
            { title = "Unknown", content = "unknown page" }



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
