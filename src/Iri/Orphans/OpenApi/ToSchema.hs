{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.OpenApi.ToSchema () where

import Prelude

import Control.Lens ((&), (?~))
import Data.OpenApi
import Iri.Data (HttpIri)

instance ToSchema HttpIri where
  declareNamedSchema _ =
    pure
      $ NamedSchema (Just "HttpIri")
      $ mempty & type_ ?~ OpenApiString
