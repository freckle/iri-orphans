{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.Aeson.ToJSON () where

import Autodocodec (Autodocodec (..))
import Data.Aeson (ToJSON)
import Iri.Data (HttpIri)
import Iri.Orphans.Autodocodec.HasCodec ()

deriving via Autodocodec HttpIri instance ToJSON HttpIri
