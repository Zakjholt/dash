module Dashboard exposing (Model, Msg, update, view, subscriptions, init)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Time exposing (every, hour, Time)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { daysSinceProdBroke : Int
    }


type Msg
    = DayTick Time
    | Break


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DayTick t ->
            ( { model | daysSinceProdBroke = model.daysSinceProdBroke + 1 }, Cmd.none )

        Break ->
            ( { model | daysSinceProdBroke = 0 }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ style [ ( "display", "flex" ), ( "flex-direction", "column" ), ( "justify-content", "center" ), ( "align-items", "center" ), ( "width", "100vw" ), ( "height", "100vh" ), ( "background-color", "black" ) ] ]
        [ textBlock "Days Since Prod Broke", textBlock (toString model.daysSinceProdBroke), button [ onClick Break, style [ ( "width", "400px" ), ( "height", "50px" ) ] ] [ text "Break Prod" ] ]


textBlock : String -> Html Msg
textBlock message =
    div [ style [ ( "font-size", "40px" ), ( "color", "whitesmoke" ), ( "font-family", "sans-serif" ), ( "font-weight", "300" ) ] ] [ text message ]


subscriptions : Model -> Sub Msg
subscriptions model =
    every (24 * hour) DayTick


init : ( Model, Cmd Msg )
init =
    ( { daysSinceProdBroke = 0 }, Cmd.none )
