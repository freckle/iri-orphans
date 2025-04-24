module Iri.Orphans.QuickCheck.ArbitrarySpec
  ( spec
  ) where

import Prelude

import Test.Hspec

import Data.List (intercalate)
import Iri.Data (HttpIri (..))
import Iri.Parsing.Text qualified
import Iri.Rendering.Text qualified
import Iri.Orphans.QuickCheck()
import Test.QuickCheck (counterexample, property)

spec :: Spec
spec =
  it "generates only parseable values" $ property $ \x ->
    counterexample
      ( let HttpIri security host port path query fragment = x
        in  intercalate
              ", "
              [ show security
              , show host
              , show port
              , show path
              , show query
              , show fragment
              ]
      )
      $ Iri.Parsing.Text.httpIri (Iri.Rendering.Text.httpIri x) == Right x
