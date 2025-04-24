{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.Serialise.Serialise () where

import Codec.Serialise (Serialise)
import Data.WideWord.Word128 (Word128)
import Iri.Data
import Net.IPv4 (IPv4)
import Net.IPv6 (IPv6)

instance Serialise DomainLabel
instance Serialise Fragment
instance Serialise Host
instance Serialise HttpIri
instance Serialise IPv4
instance Serialise IPv6
instance Serialise Path
instance Serialise PathSegment
instance Serialise Port
instance Serialise Query
instance Serialise RegName
instance Serialise Security
instance Serialise Word128
