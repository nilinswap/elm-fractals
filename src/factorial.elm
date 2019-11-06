module Main exposing (Model, Msg(..), factorial, init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { num : Int
    , fact : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 5 120, Cmd.none )



-- UPDATE


type Msg
    = Num String


factorial : Int -> Int
factorial i =
    if i == 0 then
        1

    else
        i * factorial (i - 1)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Num s ->
            let
                num =
                    Maybe.withDefault 0 (String.toInt s)

                fact =
                    factorial num
            in
            ( { model | fact = fact, num = num }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "number" (String.fromInt model.num) Num
        , h1 [] [ Html.text (String.fromInt model.fact) ]

        --, button [ onClick Roll ] [ Html.text "Roll" ]
        ]
