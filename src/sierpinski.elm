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

        tri =
            makeTriangle x y z
    in
    ( Model 7 [ tri ], Cmd.none )



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


makeTriangle : Point -> Point -> Point -> Triangle
makeTriangle x y z =
    let
        a =
            Line x y

        b =
            Line y z

        c =
            Line z x
    in
    Triangle a b c


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
        x =
            Point 0 870

        y =
            Point 1000 870

        z =
            Point 500 0

        defaultTriangle =
            makeTriangle x y z

        fractal_t =
            fractal model.triangleList (Maybe.withDefault defaultTriangle (List.head model.triangleList)) model.level

        l =
            toSvgTriangleList fractal_t
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
                encTri.a.to

            y =
                encTri.b.to

            z =
                encTri.c.to

            m1 =
                Point ((x.x + y.x) // 2) ((x.y + y.y) // 2)

            m2 =
                Point ((y.x + z.x) // 2) ((y.y + z.y) // 2)

            m3 =
                Point ((z.x + x.x) // 2) ((z.y + x.y) // 2)

            newTri =
                makeTriangle m1 m2 m3

            smallTri1 =
                makeTriangle m1 m2 y

            smallTri2 =
                makeTriangle m2 m3 z

            smallTri3 =
                makeTriangle m3 m1 x

            newLt =
                [ newTri ]
                    ++ fractal lt smallTri1 (level - 1)
                    ++ fractal lt smallTri2 (level - 1)
                    ++ fractal lt smallTri3 (level - 1)
                    ++ lt
        in
        newLt

    else
        lt
