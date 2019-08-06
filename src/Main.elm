module Main exposing (Buttons(..), Goat(..), Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    { goat : Goat
    , mainMessage : String
    , subMessage : String
    , buttons : Buttons
    }


type Goat
    = NormalGoat
    | LoserGoat
    | DrawGoat
    | WinnerGoat
    | WildGoat


type Buttons
    = NoButtons
    | GuuChokiPaaButtons
    | AgainButton


init : Model
init =
    { goat = NormalGoat
    , mainMessage = "じゃ〜んけ〜ん"
    , subMessage = "すきな ぼたんを おしてね！"
    , buttons = GuuChokiPaaButtons
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
            -- * ヤギ: 悔しそうなやぎ
            -- * メインメッセージ: 「かち！」
            -- * サブメッセージ: 「ヤギさんにも ようしゃが ないね！」
            -- * ボタンエリア
            --     * 「もういっかい」
            { goat = LoserGoat
            , mainMessage = "かち！"
            , subMessage = "ヤギさんにも ようしゃが ないね！"
            , buttons = AgainButton
            }

        PressChoki ->
            -- * ヤギ: 絶妙な表情のヤギ
            -- * メインメッセージ: 「あいこ！」
            -- * サブメッセージ: 「きが あうね！」
            -- * ボタンエリア
            --     * 「もういっかい」
            { goat = DrawGoat
            , mainMessage = "あいこ！"
            , subMessage = "きが あうね！"
            , buttons = AgainButton
            }

        PressPaa ->
            -- * ヤギ: 嬉しいヤギ
            -- * メインメッセージ: 「まけ！」
            -- * サブメッセージ: 「ほもさぴえんすって よわい いきものだね！」
            -- * ボタンエリア
            --     * 「もういっかい」
            { goat = WinnerGoat
            , mainMessage = "まけ！"
            , subMessage = "ほもさぴえんすって よわい いきものだね！"
            , buttons = AgainButton
            }

        ClickGoat ->
            -- * ヤギ: 荒ぶるやぎ
            -- * メインメッセージ: 「じゃ〜んけ〜ん」
            -- * サブメッセージ: 「やぎさんじゃなくて ぼたんをおしてね！」
            -- * ボタンエリア:
            --     * 「ぐー」
            --     * 「ちょき」
            --     * 「ぱー」
            { goat = WildGoat
            , mainMessage = "じゃ〜んけ〜ん"
            , subMessage = "やぎさんじゃなくて ぼたんをおしてね！"
            , buttons = GuuChokiPaaButtons
            }

        PressAgain ->
            -- 初期状態と一緒だからズルしちゃおう！
            init



-- View


view : Model -> Html Msg
view model =
    div
        []
        [ img
            [ src <|
                case model.goat of
                    NormalGoat ->
                        "./img/goat/normal.jpg"

                    LoserGoat ->
                        "./img/goat/loser.jpg"

                    DrawGoat ->
                        "./img/goat/draw.jpg"

                    WinnerGoat ->
                        "./img/goat/winner.jpg"

                    WildGoat ->
                        "./img/goat/wild.jpg"
            , Events.onClick ClickGoat
            ]
            []
        , h1
            []
            [ text model.mainMessage
            ]
        , h2
            []
            [ text model.subMessage
            ]
        , case model.buttons of
            NoButtons ->
                text ""

            GuuChokiPaaButtons ->
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

            AgainButton ->
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
