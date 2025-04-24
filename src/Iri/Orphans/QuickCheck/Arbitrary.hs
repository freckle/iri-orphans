{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.QuickCheck.Arbitrary () where

import Prelude

import Data.ByteString qualified as BS
import Data.Text qualified as T
import Data.Vector qualified as V
import Data.WideWord.Word128
import Iri.Data
import Net.IPv4
import Net.IPv6
import Test.QuickCheck.Arbitrary.Generic
import Test.QuickCheck.Gen (choose, listOf, listOf1)

deriving via GenericArbitrary HttpIri instance Arbitrary HttpIri
deriving via GenericArbitrary Port instance Arbitrary Port
deriving via GenericArbitrary Word128 instance Arbitrary Word128

deriving newtype instance Arbitrary IPv4
deriving newtype instance Arbitrary IPv6
deriving newtype instance Arbitrary Security

instance Arbitrary DomainLabel where
  arbitrary = DomainLabel . T.pack <$> listOf1 (choose ('a', 'z'))

instance Arbitrary Fragment where
  arbitrary = Fragment . BS.pack <$> listOf (choose (97, 122))

instance Arbitrary Host where
  arbitrary = NamedHost <$> arbitrary

instance Arbitrary Path where
  arbitrary = Path . V.fromList <$> listOf arbitrary

instance Arbitrary PathSegment where
  arbitrary = PathSegment . BS.pack <$> listOf1 (choose (97, 122))

instance Arbitrary Query where
  arbitrary = Query . BS.pack <$> listOf (choose (97, 122))

instance Arbitrary RegName where
  arbitrary = RegName . V.fromList <$> listOf1 arbitrary
