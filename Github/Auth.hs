{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
module Github.Auth where

import Control.DeepSeq (NFData)
import Data.Data       (Data, Typeable)
import GHC.Generics    (Generic)

import qualified Data.ByteString as BS

-- | The Github auth data type
data GithubAuth = GithubBasicAuth BS.ByteString BS.ByteString
                | GithubOAuth String -- ^ token
                | GithubEnterpriseOAuth String  -- custom API endpoint without
                                                -- trailing slash
                                        String  -- token
                deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData GithubAuth
