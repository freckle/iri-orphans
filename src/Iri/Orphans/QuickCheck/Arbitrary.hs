{-# OPTIONS_GHC -Wno-orphans #-}

module Iri.Orphans.QuickCheck.Arbitrary () where

import Prelude

import Data.Text qualified as T
import Data.Text.Encoding qualified as T
import Data.Vector qualified as V
import Iri.Data
  ( DomainLabel (..)
  , Fragment (..)
  , Host (..)
  , HttpIri
  , Path (..)
  , PathSegment (..)
  , Port
  , Query (..)
  , RegName (..)
  , Security (..)
  )
import Test.QuickCheck
  ( Arbitrary
  , Gen
  , arbitrary
  , choose
  , elements
  , listOf
  , listOf1
  , oneof
  )
import Test.QuickCheck.Arbitrary.Generic
  ( GenericArbitrary
  , genericArbitrary
  )
import Test.QuickCheck.Arbitrary.Generic qualified

instance Arbitrary DomainLabel where
  arbitrary = DomainLabel . T.pack <$> listOf1 char
   where
    char =
      oneof
        [ choose ('a', 'z')
        , choose ('A', 'Z')
        , choose ('0', '9')
        , elements "-_~!$&'()*+,;="
        ]

instance Arbitrary Fragment where
  arbitrary = Fragment . T.encodeUtf8 . T.pack <$> listOf char
   where
    char =
      oneof
        [ choose ('a', 'z')
        , choose ('A', 'Z')
        , choose ('0', '9')
        , elements "-._~:@/?|"
        , ucs
        ]

instance Arbitrary Host where
  -- Don't generate an IPv6 host because
  -- https://github.com/nikita-volkov/iri/issues/2
  arbitrary =
    oneof
      [ NamedHost <$> arbitrary
      , IpV4Host <$> genericArbitrary
      ]

deriving via
  GenericArbitrary HttpIri
  instance
    Arbitrary HttpIri

instance Arbitrary Path where
  arbitrary = Path . V.fromList <$> listOf arbitrary

instance Arbitrary PathSegment where
  arbitrary = PathSegment . T.encodeUtf8 . T.pack <$> listOf1 char
   where
    char =
      oneof
        [ choose ('a', 'z')
        , choose ('A', 'Z')
        , choose ('0', '9')
        , elements "-._~:@"
        , ucs
        ]

deriving via
  GenericArbitrary Port
  instance
    Arbitrary Port

instance Arbitrary Query where
  arbitrary = Query . T.encodeUtf8 . T.pack <$> listOf1 char
   where
    char =
      oneof
        [ choose ('a', 'z')
        , choose ('A', 'Z')
        , choose ('0', '9')
        , elements "-._~:@/?|"
        , ucs
        , private
        ]

instance Arbitrary RegName where
  arbitrary = RegName . V.fromList <$> listOf1 arbitrary

deriving newtype instance
  Arbitrary Security

ucs :: Gen Char
ucs =
  oneof
    [ choose ('\xA0', '\xD7FF')
    , choose ('\xF900', '\xFDCF')
    , choose ('\xFDF0', '\xFFEF')
    , choose ('\x10000', '\x1FFFD')
    , choose ('\x20000', '\x2FFFD')
    , choose ('\x30000', '\x3FFFD')
    , choose ('\x40000', '\x4FFFD')
    , choose ('\x50000', '\x5FFFD')
    , choose ('\x60000', '\x6FFFD')
    , choose ('\x70000', '\x7FFFD')
    , choose ('\x80000', '\x8FFFD')
    , choose ('\x90000', '\x9FFFD')
    , choose ('\xA0000', '\xAFFFD')
    , choose ('\xB0000', '\xBFFFD')
    , choose ('\xC0000', '\xCFFFD')
    , choose ('\xD0000', '\xDFFFD')
    , choose ('\xE1000', '\xEFFFD')
    ]

private :: Gen Char
private =
  oneof
    [ choose ('\xE000', '\xF8FF')
    , choose ('\xF0000', '\xFFFFD')
    , choose ('\x100000', '\x10FFFD')
    ]
