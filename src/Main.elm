module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    -- あとで拡張できるようにレコード型にしておくと便利！
    { phase : Phase
    }


type
    Phase
    -- 初期状態/イベント5
    = Start
      -- イベント1
    | AfterWin
      -- イベント2
    | AfterDraw
      -- イベント3
    | AfterLose
      -- イベント4
    | AfterClickingGoat


{-| 初期状態
-}
init : Model
init =
    { phase = Start
    }



-- Message


type Msg
    = PressGuu
    | PressChoki
    | PressPaa
    | ClickGoat
    | PressAgain


update : Msg -> Model -> Model
update msg model =
    case msg of
        PressGuu ->
            { phase = AfterWin
            }

        PressChoki ->
            { phase = AfterDraw
            }

        PressPaa ->
            { phase = AfterLose
            }

        ClickGoat ->
            { phase = AfterClickingGoat
            }

        PressAgain ->
            { phase = Start
            }



-- View


view : Model -> Html Msg
view model =
    div
        []
        [ img
            [ src <|
                case model.phase of
                    Start ->
                        "./img/goat/normal.jpg"

                    AfterWin ->
                        "./img/goat/loser.jpg"

                    AfterDraw ->
                        "./img/goat/draw.jpg"

                    AfterLose ->
                        "./img/goat/winner.jpg"

                    AfterClickingGoat ->
                        "./img/goat/wild.jpg"
            , if model.phase == Start then
                Events.onClick ClickGoat

              else
                -- 何も属性がないときのテクニック
                class ""
            ]
            []
        , h1
            []
            [ text <|
                case model.phase of
                    Start ->
                        "じゃ〜んけ〜ん"

                    AfterWin ->
                        "かち！"

                    AfterDraw ->
                        "あいこ！"

                    AfterLose ->
                        "まけ！"

                    AfterClickingGoat ->
                        "じゃ〜んけ〜ん"
            ]
        , h2
            []
            [ text <|
                case model.phase of
                    Start ->
                        "すきな ぼたんを おしてね！"

                    AfterWin ->
                        "ヤギさんにも ようしゃが ないね！"

                    AfterDraw ->
                        "きが あうね！"

                    AfterLose ->
                        "ほもさぴえんすって よわい いきものだね！"

                    AfterClickingGoat ->
                        "やぎさんじゃなくて ぼたんをおしてね！"
            ]
        , if model.phase == Start || model.phase == AfterClickingGoat then
            div
                []
                [ button
                    [ type_ "button"
                    , Events.onClick PressGuu
                    ]
                    [ text "ぐー"
                    ]
                , button
                    [ type_ "button"
                    , Events.onClick PressChoki
                    ]
                    [ text "ちょき"
                    ]
                , button
                    [ type_ "button"
                    , Events.onClick PressPaa
                    ]
                    [ text "ぱー"
                    ]
                ]

          else
            div
                []
                [ button
                    [ type_ "button"
                    , Events.onClick PressAgain
                    ]
                    [ text "もういっかい"
                    ]
                ]
        ]
