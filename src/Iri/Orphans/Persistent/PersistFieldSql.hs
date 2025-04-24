{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.Persistent.PersistFieldSql () where

import Prelude

import Data.Proxy
import Data.Text (Text)
import Database.Persist.Sql
import Iri.Data (HttpIri)
import Iri.Orphans.Persistent.PersistField ()

instance PersistFieldSql HttpIri where
  sqlType _ = sqlType $ Proxy @Text
