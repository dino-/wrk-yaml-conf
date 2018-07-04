{-# LANGUAGE DeriveGeneric #-}

import Data.Text ( Text )
import Data.Yaml ( FromJSON, ParseException, ToJSON,
  decodeFileEither, encodeFile )
import GHC.Generics
import System.Directory ( doesFileExist )
import System.Environment ( getArgs )


data Config = Config
  { able :: Text
  , baker :: Int
  , charlieHorse :: String
  , delta :: Bool
  , echo :: Maybe Double
  , foxtrot :: Maybe Text
  , golf :: [Text]
  }
  deriving ( Generic, Show )

instance FromJSON Config

instance ToJSON Config


sampleConfig :: Config
sampleConfig = Config
  { able = "alpha"
  , baker = 10
  , charlieHorse = "Don't call him 'Charlie'"
  , delta = True
  , echo = Just 1.26
  , foxtrot = Nothing
  , golf = ["foo", "bar", "baz"]
  }


main :: IO ()
main = do
  (filename : _) <- getArgs

  exists <- doesFileExist filename

  if exists
    then do
      decoded <- decodeFileEither filename :: IO (Either ParseException Config)
      print decoded
    else do
      encodeFile filename sampleConfig
