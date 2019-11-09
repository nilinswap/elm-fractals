module Main exposing (Line, Model, Msg(..), Point, init, main, subscriptions, update, view)

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


type alias Point =
    { x : Int
    , y : Int
    }


type alias Line =
    { to : Point
    , fro : Point
    }


type alias Model =
    { lineList : List Line
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        to =
            Point 0 100

        fro =
            Point 100 100

        linel =
            Line to fro
    in
    ( Model [ linel ], Cmd.none )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


toAtrMsg : Line -> List (Svg.Attribute msg)
toAtrMsg l =
    [ x1 (String.fromInt l.to.x)
    , y1 (String.fromInt l.to.y)
    , x2 (String.fromInt l.fro.x)
    , y2 (String.fromInt l.fro.y)
    ]


toSvg : List (Svg.Attribute msg) -> Svg msg
toSvg l =
    line l []


toSvgList : List Line -> List (Svg msg)
toSvgList listl =
    let
        l =
            List.map toAtrMsg listl

        -- list of list of attr msg
    in
    List.map toSvg l



-- VIEW


view : Model -> Html Msg
view model =
    let
        l =
            toSvgList model.lineList
    in
    div []
        [ h1 [] [ Html.text (String.fromInt 2) ]
        , svg
            [ width "120", height "120", viewBox "0 0 120 120", fill "white", stroke "black", strokeWidth "3", Html.Attributes.style "padding-left" "20px" ]
            l
        ]
