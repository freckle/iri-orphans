{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.DebugPrint.ToDebugPrintValue () where

import Prelude

import Data.Text (Text)
import DebugPrint (ToDebugPrintValue (..))
import Iri.Data (HttpIri)
import Iri.Rendering.Text qualified

instance ToDebugPrintValue HttpIri where
  toDebugPrintValue =
    toDebugPrintValue @Text . Iri.Rendering.Text.httpIri
