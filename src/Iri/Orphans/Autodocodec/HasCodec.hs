{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.Autodocodec.HasCodec () where

import Prelude

import Autodocodec (HasCodec (codec), bimapCodec)
import Data.Bifunctor (first)
import Data.Text (Text)
import Data.Text qualified as T
import Iri.Data (HttpIri)
import Iri.Parsing.Text qualified
import Iri.Rendering.Text qualified

instance HasCodec HttpIri where
  codec =
    bimapCodec
      (first T.unpack . Iri.Parsing.Text.httpIri)
      Iri.Rendering.Text.httpIri
      (codec @Text)
