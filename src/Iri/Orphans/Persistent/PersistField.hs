{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.Persistent.PersistField () where

import Prelude

import Control.Monad ((<=<))
import Data.Text (Text)
import Database.Persist
import Iri.Data (HttpIri)
import Iri.Parsing.Text qualified
import Iri.Rendering.Text qualified

instance PersistField HttpIri where
  toPersistValue = toPersistValue @Text . Iri.Rendering.Text.httpIri
  fromPersistValue = Iri.Parsing.Text.httpIri <=< fromPersistValue @Text
