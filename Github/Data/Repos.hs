{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
module Github.Data.Repos where

import Github.Data.Definitions
import Github.Data.Id          (Id)
import Github.Data.Name        (Name)

import Control.DeepSeq (NFData)
import Data.Data       (Data, Typeable)
import Data.Text       (Text)
import GHC.Generics    (Generic)

data Repo = Repo {
   repoSshUrl          :: !(Maybe Text)
  ,repoDescription     :: !(Maybe Text)
  ,repoCreatedAt       :: !(Maybe GithubDate)
  ,repoHtmlUrl         :: !Text
  ,repoSvnUrl          :: !(Maybe Text)
  ,repoForks           :: !(Maybe Int)
  ,repoHomepage        :: !(Maybe Text)
  ,repoFork            :: !(Maybe Bool)
  ,repoGitUrl          :: !(Maybe Text)
  ,repoPrivate         :: !Bool
  ,repoCloneUrl        :: !(Maybe Text)
  ,repoSize            :: !(Maybe Int)
  ,repoUpdatedAt       :: !(Maybe GithubDate)
  ,repoWatchers        :: !(Maybe Int)
  ,repoOwner           :: !GithubOwner
  ,repoName            :: !(Name Repo)
  ,repoLanguage        :: !(Maybe Text)
  ,repoMasterBranch    :: !(Maybe Text)
  ,repoPushedAt        :: !(Maybe GithubDate)   -- ^ this is Nothing for new repositories
  ,repoId              :: !(Id Repo)
  ,repoUrl             :: !Text
  ,repoOpenIssues      :: !(Maybe Int)
  ,repoHasWiki         :: !(Maybe Bool)
  ,repoHasIssues       :: !(Maybe Bool)
  ,repoHasDownloads    :: !(Maybe Bool)
  ,repoParent          :: !(Maybe RepoRef)
  ,repoSource          :: !(Maybe RepoRef)
  ,repoHooksUrl        :: !Text
  ,repoStargazersCount :: !Int
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData Repo

data RepoRef = RepoRef GithubOwner (Name Repo) -- Repo owner and name
 deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData RepoRef

data NewRepo = NewRepo {
  newRepoName        :: !(Name Repo)
, newRepoDescription :: !(Maybe Text)
, newRepoHomepage    :: !(Maybe Text)
, newRepoPrivate     :: !(Maybe Bool)
, newRepoHasIssues   :: !(Maybe Bool)
, newRepoHasWiki     :: !(Maybe Bool)
, newRepoAutoInit    :: !(Maybe Bool)
} deriving (Eq, Ord, Show, Data, Typeable, Generic)

instance NFData NewRepo

newRepo :: Name Repo -> NewRepo
newRepo name = NewRepo name Nothing Nothing Nothing Nothing Nothing Nothing

data EditRepo = EditRepo {
  editName         :: !(Maybe (Name Repo))
, editDescription  :: !(Maybe Text)
, editHomepage     :: !(Maybe Text)
, editPublic       :: !(Maybe Bool)
, editHasIssues    :: !(Maybe Bool)
, editHasWiki      :: !(Maybe Bool)
, editHasDownloads :: !(Maybe Bool)
} deriving (Eq, Ord, Show, Data, Typeable, Generic)

instance NFData EditRepo

-- | Filter the list of the user's repos using any of these constructors.
data RepoPublicity =
    All     -- ^ All repos accessible to the user.
  | Owner   -- ^ Only repos owned by the user.
  | Public  -- ^ Only public repos.
  | Private -- ^ Only private repos.
  | Member  -- ^ Only repos to which the user is a member but not an owner.
 deriving (Show, Eq, Ord, Typeable, Data, Generic)

-- | This is only used for the FromJSON instance.
data Languages = Languages { getLanguages :: [Language] }
  deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData Languages

-- | A programming language with the name and number of characters written in
-- it.
data Language = Language Text Int
 deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData Language
