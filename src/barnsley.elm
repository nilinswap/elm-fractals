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
    { level : Int
    , lineList : List Line
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        to =
            Point 0 1000

        fro =
            Point 1000 1000

        linel =
            Line to fro
    in
    ( Model 7 [ linel ], Cmd.none )



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
        to =
            Point 0 100

        fro =
            Point 100 100

        linel =
            Line to fro

        fractal_l =
            fractal model.lineList (Maybe.withDefault linel (List.head model.lineList)) model.level

        l =
            toSvgList fractal_l
    in
    div []
        [ h1 [] [ Html.text (String.fromInt model.level) ]
        , svg
            [ width "1000", height "1000", viewBox "0 0 2000 2000", fill "white", stroke "black", strokeWidth "3", Html.Attributes.style "padding-left" "20px" ]
            l
        ]


fractal : List Line -> Line -> Int -> List Line
fractal ll fissionLine level =
    if not (level == 0) then
        let
            m =
                Point ((fissionLine.to.x + fissionLine.fro.x) // 2) ((fissionLine.to.y + fissionLine.fro.y) // 2)

            lll =
                if fissionLine.to.x == fissionLine.fro.x then
                    let
                        a =
                            Point (m.x + (abs fissionLine.to.y - fissionLine.fro.y) // 2) m.y

                        -- mid to right
                        b =
                            Point (m.x - (abs fissionLine.to.y - fissionLine.fro.y) // 2) m.y

                        -- mid to left
                        c =
                            Point m.x fissionLine.fro.y

                        ld =
                            [ Line m a
                            , Line m b
                            , Line m c
                            ]

                        llll =
                            ld
                                ++ fractal ll (Line m a) (level - 1)
                                ++ fractal ll (Line m b) (level - 1)
                                ++ fractal ll (Line m c) (level - 1)
                    in
                    llll

                else if fissionLine.to.y == fissionLine.fro.y then
                    let
                        a =
                            Point m.x (m.y + (abs fissionLine.to.x - fissionLine.fro.x) // 2)

                        -- mid to right
                        b =
                            Point m.x (m.y - (abs fissionLine.to.x - fissionLine.fro.x) // 2)

                        -- mid to left
                        c =
                            Point fissionLine.fro.x m.y

                        ld =
                            [ Line m a
                            , Line m b
                            , Line m c
                            ]

                        llll =
                            ld
                                ++ fractal ll (Line m a) (level - 1)
                                ++ fractal ll (Line m b) (level - 1)
                                ++ fractal ll (Line m c) (level - 1)
                    in
                    llll

                else
                    ll
        in
        lll

    else
        ll
