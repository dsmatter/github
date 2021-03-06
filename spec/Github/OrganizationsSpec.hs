{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
module Github.OrganizationsSpec where

import Github.Auth                  (GithubAuth (..))
import Github.Data                  (GithubOwner (..), SimpleOrganization (..),
                                     Team (..))
import Github.Organizations         (publicOrganizationsFor')
import Github.Organizations.Members (membersOf')

import Data.Aeson.Compat  (eitherDecodeStrict)
import Data.Either.Compat (isRight)
import Data.FileEmbed     (embedFile)
import System.Environment (lookupEnv)
import Test.Hspec         (Spec, describe, it, pendingWith, shouldBe,
                           shouldSatisfy)

fromRightS :: Show a => Either a b -> b
fromRightS (Right b) = b
fromRightS (Left a) = error $ "Expected a Right and got a Left" ++ show a

withAuth :: (GithubAuth -> IO ()) -> IO ()
withAuth action = do
  mtoken <- lookupEnv "GITHUB_TOKEN"
  case mtoken of
    Nothing    -> pendingWith "no GITHUB_TOKEN"
    Just token -> action (GithubOAuth token)

spec :: Spec
spec = do
  describe "publicOrganizationsFor'" $ do
    it "decodes simple organization json" $ do
      let orgs = eitherDecodeStrict $(embedFile "fixtures/user-organizations.json")
      simpleOrganizationLogin (head $ fromRightS orgs) `shouldBe` "github"

    it "returns information about the user's organizations" $ withAuth $ \auth -> do
      orgs <- publicOrganizationsFor' (Just auth) "mike-burns"
      orgs  `shouldSatisfy` isRight

  describe "teamsOf" $ do
    it "parse" $ do
      let ts = eitherDecodeStrict $(embedFile "fixtures/list-teams.json")
      teamName (head $ fromRightS ts) `shouldBe` "Justice League"

  describe "membersOf" $ do
    it "parse" $ do
      let ms = eitherDecodeStrict $(embedFile "fixtures/members-list.json")
      githubOwnerLogin (head $ fromRightS ms) `shouldBe` "octocat"

    it "works" $ withAuth $ \auth -> do
      ms <- membersOf' (Just auth) "haskell"
      ms `shouldSatisfy` isRight
