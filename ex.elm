module Counter exposing (main)

import Html exposing (Html, div, text, button, input)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Dom exposing (focus)
import Task


type alias Model =
    { numInputs : Int
    , error : Maybe String
    }


model : Model
model =
    { numInputs = 3
    , error = Nothing
    }


type Msg
    = FocusOn String
    | FocusResult (Result Dom.Error ())
    | AddAndFocus


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusOn id ->
            model ! [ Task.attempt FocusResult (focus id) ]

        FocusResult result ->
            case result of
                Err (Dom.NotFound id) ->
                    { model | error = Just ("Could not find dom id: " ++ id) } ! []

                Ok () ->
                    { model | error = Nothing } ! []

        AddAndFocus ->
            let
                newId =
                    model.numInputs + 1
            in
                { model | numInputs = newId } ! [ Task.attempt FocusResult (focus (getDomId newId)) ]


view : Model -> Html Msg
view model =
    div []
        (List.concat
            [ (List.map inputView (List.range 1 model.numInputs))
            , [ div [] [ button [ onClick (FocusOn "badId") ] [ text "Bad focus" ] ]
              , errorView model.error
              , div [] [ button [ onClick AddAndFocus ] [ text "Add and focus" ] ]
              ]
            ]
        )


errorView : Maybe String -> Html msg
errorView error =
    case error of
        Just errorMsg ->
            div [] [ text errorMsg ]

        Nothing ->
            text ""


inputView : Int -> Html Msg
inputView index =
    let
        domId =
            getDomId index
    in
        div []
            [ input [ id domId ] []
            , button [ onClick (FocusOn domId) ] [ text "Focus" ]
            ]


getDomId : Int -> String
getDomId index =
    "field" ++ toString index


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = ( model, Cmd.none )
        }
