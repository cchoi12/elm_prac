module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)

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

view: Model -> Html Msg
view model =
  div []
      [ button [ onClick Increment ] [ text "+" ]
      , div [] [ text (toString model) ]
      , button [ onClick Decrement ] [ text "-" ]
      , button [ onClick Reset ] [ text "Reset" ]
      ]

main =
  Html.beginnerProgram
    { model = 0
    , view = view
    , update = update
    }
