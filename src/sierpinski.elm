module Main exposing (Line, Model, Msg(..), Point, Triangle, fractal, init, main, subscriptions, toAtrMsg, toLineList, toSvg, toSvgList, toSvgTriangleList, update, view)

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


type alias Triangle =
    { a : Line
    , b : Line
    , c : Line
    }


type alias Model =
    { level : Int
    , triangleList : List Triangle
    , length : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        x =
            Point 0 870

        y =
            Point 1000 870

        z =
            Point 500 0

        a =
            Line x y

        b =
            Line y z

        c =
            Line z x

        tri =
            Triangle a b c
    in
    ( Model 2 [ tri ] 1000, Cmd.none )



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


toLineList : Triangle -> List Line
toLineList t =
    [ t.a, t.b, t.c ]


toSvgTriangleList : List Triangle -> List (Svg msg)
toSvgTriangleList listri =
    let
        listoflist =
            List.map toLineList listri

        listoflines =
            List.concat listoflist
    in
    toSvgList listoflines



-- VIEW


view : Model -> Html Msg
view model =
    let
        to =
            Point 0 100

        fro =
            Point 100 100

        linel =
            Line to fro

        --        fractal_l =
        --            fractal model.lineList (Maybe.withDefault linel (List.head model.lineList)) model.level
        l =
            toSvgTriangleList model.triangleList
    in
    div []
        [ h1 [] [ Html.text (String.fromInt model.level) ]
        , svg
            [ width "1000", height "1000", viewBox "0 0 2000 2000", fill "white", stroke "black", strokeWidth "3", Html.Attributes.style "padding-left" "20px" ]
            l
        ]


fractal : List Triangle -> Triangle -> Int -> List Triangle
fractal lt encTri level =
    if not (level == 0) then
        let
            x =
                Point ((encTri.a.to.x + encTri.b.to.x) // 2) ((encTri.a.to.y + encTri.b.to.y) // 2)

            y =
                Point ((encTri.b.to.x + encTri.c.to.x) // 2) ((encTri.b.to.y + encTri.c.to.y) // 2)

            z =
                Point ((encTri.c.to.x + encTri.a.to.x) // 2) ((encTri.c.to.y + encTri.a.to.y) // 2)

            a =
                Line x y

            b =
                Line y z

            c =
                Line z x

            newTri =
                Triangle a b c

            newLt =
                [ newTri ]
        in
        lt

    else
        lt
