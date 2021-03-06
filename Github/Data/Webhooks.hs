{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
module Github.Data.Webhooks where

import Github.Data.Definitions
import Github.Data.Id          (Id)

import Control.DeepSeq (NFData)
import Data.Data       (Data, Typeable)
import Data.Text       (Text)
import GHC.Generics    (Generic)

import qualified Data.Map as M

data RepoWebhook = RepoWebhook {
   repoWebhookUrl          :: !Text
  ,repoWebhookTestUrl      :: !Text
  ,repoWebhookId           :: !(Id RepoWebhook)
  ,repoWebhookName         :: !Text
  ,repoWebhookActive       :: !Bool
  ,repoWebhookEvents       :: ![RepoWebhookEvent]
  ,repoWebhookConfig       :: !(M.Map Text Text)
  ,repoWebhookLastResponse :: !RepoWebhookResponse
  ,repoWebhookUpdatedAt    :: !GithubDate
  ,repoWebhookCreatedAt    :: !GithubDate
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData RepoWebhook

data RepoWebhookEvent =
   WebhookWildcardEvent
 | WebhookCommitCommentEvent
 | WebhookCreateEvent
 | WebhookDeleteEvent
 | WebhookDeploymentEvent
 | WebhookDeploymentStatusEvent
 | WebhookForkEvent
 | WebhookGollumEvent
 | WebhookIssueCommentEvent
 | WebhookIssuesEvent
 | WebhookMemberEvent
 | WebhookPageBuildEvent
 | WebhookPublicEvent
 | WebhookPullRequestReviewCommentEvent
 | WebhookPullRequestEvent
 | WebhookPushEvent
 | WebhookReleaseEvent
 | WebhookStatusEvent
 | WebhookTeamAddEvent
 | WebhookWatchEvent
   deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData RepoWebhookEvent

data RepoWebhookResponse = RepoWebhookResponse {
   repoWebhookResponseCode    :: !(Maybe Int)
  ,repoWebhookResponseStatus  :: !Text
  ,repoWebhookResponseMessage :: !(Maybe Text)
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData RepoWebhookResponse

data PingEvent = PingEvent {
   pingEventZen    :: !Text
  ,pingEventHook   :: !RepoWebhook
  ,pingEventHookId :: !(Id RepoWebhook)
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData PingEvent

data NewRepoWebhook = NewRepoWebhook {
  newRepoWebhookName   :: !Text
 ,newRepoWebhookConfig :: !(M.Map Text Text)
 ,newRepoWebhookEvents :: !(Maybe [RepoWebhookEvent])
 ,newRepoWebhookActive :: !(Maybe Bool)
} deriving (Eq, Ord, Show, Typeable, Data, Generic)

instance NFData NewRepoWebhook

data EditRepoWebhook = EditRepoWebhook {
  editRepoWebhookConfig       :: !(Maybe (M.Map Text Text))
 ,editRepoWebhookEvents       :: !(Maybe [RepoWebhookEvent])
 ,editRepoWebhookAddEvents    :: !(Maybe [RepoWebhookEvent])
 ,editRepoWebhookRemoveEvents :: !(Maybe [RepoWebhookEvent])
 ,editRepoWebhookActive       :: !(Maybe Bool)
} deriving (Eq, Ord, Show, Typeable, Data, Generic)

instance NFData EditRepoWebhook
