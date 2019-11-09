module Main exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes
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

type alias Point = {
    x: Int,
    y: Int,
}

type alias Line = {
    to: Point,
    fro: Point
}

type alias Model =
    {
        lineList: List Line
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        to = Point 0 100
        fro = Point 100 100
        linel = Line to fro
    ( Model [linel], Cmd.none )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( Model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text (String.fromInt 2) ]
        , svg
            [ width "120", height "120", viewBox "0 0 120 120", fill "white", stroke "black", strokeWidth "3", Html.Attributes.style "padding-left" "20px" ]
            [ line
                [ x1 "100"
                , x2 "100"
                , y1 "0"
                , y2 "100"
                ]
                []
            ]
        ]


