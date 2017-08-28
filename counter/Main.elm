module Main exposing (..)
import Html exposing (..)

main =
  div []
      [ button [] [ text "-" ]
      , div [] [ text (toString 1) ]
      , button [] [ text "+" ]
      , button [] [ text "Reset"]
      ]

type alias Model =
  Int

type Msg
  = Increment
  | Decrement
  | Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
      0
