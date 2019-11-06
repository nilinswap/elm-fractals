module Main exposing (Model, Msg(..), factorial, init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes
import Html.Events exposing (..)
import List
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { product : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 5, Cmd.none )



-- UPDATE


type Msg
    = None


factorial : Int -> Int
factorial i =
    if i == 0 then
        1

    else
        i * factorial (i - 1)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        fact =
            factorial model.product
    in
    ( { model | product = fact }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text (String.fromInt (factorial model.product)) ]

        --, button [ onClick Roll ] [ Html.text "Roll" ]
        ]
