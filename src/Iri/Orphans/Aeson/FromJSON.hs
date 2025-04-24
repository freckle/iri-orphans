{-# options_ghc  -Wno-orphans #-}

module Iri.Orphans.Aeson.FromJSON () where

import Autodocodec (Autodocodec (..))
import Data.Aeson (FromJSON)
import Iri.Data (HttpIri)
import Iri.Orphans.Autodocodec.HasCodec()

deriving via Autodocodec HttpIri instance FromJSON HttpIri
