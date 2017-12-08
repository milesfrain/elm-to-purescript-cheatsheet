module Buttons.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Data.Const (Const)
import Data.Monoid (mempty)
import Spork.Html (Html, div, text, button, onClick)
import Common.BeginnerApp (BeginnerApp)
import Common.BeginnerApp as BeginnerApp
import Spork.Interpreter as Interpreter

type Model = Int

data Msg = Increment | Decrement

render :: Model -> Html Msg
render model =
    div []
        [ button [ onClick (const $ Just Decrement) ] [ text "-" ]
        , div [] [ text (show model) ]
        , button [ onClick (const $ Just Increment) ] [ text "plus" ]
        ]


update :: Model -> Msg -> Model
update model msg =
    case msg of
        Increment -> model + 1
        Decrement -> model - 1

app :: BeginnerApp Model Msg
app =
    { render
    , update
    , model: 0
    }

main :: Eff _ Unit
main = do
    inst <- BeginnerApp.makeWithSelector app "#app"
    inst.run