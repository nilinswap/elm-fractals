module Main exposing (Model, Msg(..), init, main, subscriptions, svgCirclesForDieFace, update, view)

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


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model, Cmd.none )



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


svgCirclesForDieFace : Int -> List (Svg Msg)
svgCirclesForDieFace dieFace =
    case dieFace of
        1 ->
            [ circle [ cx "50", cy "50", r "10", fill "black" ] [] ]

        2 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        3 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "50", cy "50", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        4 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "25", r "10", fill "black" ] []
            , circle [ cx "25", cy "75", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        5 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "25", r "10", fill "black" ] []
            , circle [ cx "25", cy "75", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            , circle [ cx "50", cy "50", r "10", fill "black" ] []
            ]

        6 ->
            [ circle [ cx "25", cy "20", r "10", fill "black" ] []
            , circle [ cx "25", cy "50", r "10", fill "black" ] []
            , circle [ cx "25", cy "80", r "10", fill "black" ] []
            , circle [ cx "75", cy "20", r "10", fill "black" ] []
            , circle [ cx "75", cy "50", r "10", fill "black" ] []
            , circle [ cx "75", cy "80", r "10", fill "black" ] []
            ]

        _ ->
            [ circle [ cx "50", cy "50", r "50", fill "red", stroke "none" ] [] ]
