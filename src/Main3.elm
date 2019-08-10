module Main3 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Html.Events.Extra as Events


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model



-- あとで拡張できるようにレコード型にしておいてよかった！
type alias Model =
    { phase : Phase
    , name : String
    }


type Phase
    -- 初期状態 / イベントex1
    = Setting
    -- イベント5 / イベントex2
    | Start
    -- イベント1'
    | AfterWin
    -- イベント2'
    | AfterDraw
    -- イベント3'
    | AfterLose
    -- イベント4
    | AfterClickingGoat


{-| 初期状態
-}
init : Model
init =
    { phase = Setting
    , name = ""
    }



-- Message


type Msg
    = PressGuu
    | PressChoki
    | PressPaa
    | ClickGoat
    | PressAgain
    -- イベントex1
    | ChangeName String
    -- イベントex2
    | SubmitName


update : Msg -> Model -> Model
update msg model =
    case msg of
        PressGuu ->
            { model
                | phase = AfterWin
            }

        PressChoki ->
            { model
                | phase = AfterDraw
            }

        PressPaa ->
            { model
                | phase = AfterLose
            }

        ClickGoat ->
            { model
                | phase = AfterClickingGoat
            }

        PressAgain ->
            { model
                | phase = Start
            }

        ChangeName str ->
            { model
                | name = str
            }

        SubmitName ->
            { model
                | phase = Start
            }


-- View


view : Model -> Html Msg
view model =
    case model.phase of
        Setting ->
            settingView model

        _ ->
            gameView model


settingView : Model -> Html Msg
settingView model =
    div
        []
        [ h1
            []
            [ text "あなたの名前を教えてください"
            ]
        , h2
            []
            [ text "結果の表示に使います"
            ]
        , input
            [ type_ "text"
            , value model.name
            , Events.onChange ChangeName
            ]
            []
        , button
            [ type_ "button"
            , Events.onClick SubmitName
            ]
            [ text "決定" ]
        ]


gameView : Model -> Html Msg
gameView model =
    div
        []
        [ img
            [ src <| goatSrc model.phase
            , if model.phase == Start then
                Events.onClick ClickGoat

              else
                -- 何も属性がないときのテクニック
                class ""
            ]
            []
        , h1
            []
            [ text <| mainMessage model
            ]
        , h2
            []
            [ text <| subMessage model.phase
            ]
        , buttons model.phase
        ]


{-| ヤギ画像
-}
goatSrc : Phase -> String
goatSrc phase =
    case phase of
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

        Setting ->
            ""


{-| メインメッセージ
-}
mainMessage : Model -> String
mainMessage model =
    case model.phase of
        Start ->
            "じゃ〜んけ〜ん"

        AfterWin ->
            model.name ++ "さんの かち！"

        AfterDraw ->
            "あいこ！"

        AfterLose ->
            model.name ++ "さんの まけ！"

        AfterClickingGoat ->
            "じゃ〜んけ〜ん"

        Setting ->
            ""


{-| サブメッセージ
-}
subMessage : Phase -> String
subMessage phase =
    case phase of
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

        Setting ->
            ""


{-| ボタンエリア
-}
buttons : Phase -> Html Msg
buttons phase =
    case phase of
        Start ->
            guuChokiParrButtons

        AfterClickingGoat ->
            guuChokiParrButtons

        _ ->
            againButtons


guuChokiParrButtons : Html Msg
guuChokiParrButtons =
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


againButtons : Html Msg
againButtons =
    div
        []
        [ button
            [ type_ "button"
            , Events.onClick PressAgain
            ]
            [ text "もういっかい"
            ]
        ]
