{-# LANGUAGE OverloadedStrings #-}

module Web.Action.NewRecord (newRecordAction) where

import           Control.Monad          (when)
import           Control.Monad.IO.Class (liftIO)
import qualified Data.Time.Clock        as TM
import qualified Data.Time.LocalTime    as TM
import qualified Entity.User            as User
import           Model.WeightRecord
    ( NewWRecord (NewWRecord)
    , insertNewWRecord
    )
import           Web.Core               (WRAction, runSqlite, wrconUser)
import           Web.Spock              (getContext, param, redirect)
import           Web.View.Main          (mainView)

newRecordAction :: WRAction a
newRecordAction = do
    mWeight <- param "weight"  -- 体重を取得。
    case mWeight of
      Nothing -> mainView (Just "体重が誤っています") -- 体重の取得失敗を通知、mainViewは後で実装。
      Just weight -> do
        -- [FIXED] `Just`に直接パターンマッチできなかったので一度取り出してから case-of で判定
        mu <- wrconUser <$> getContext  -- wrconUserからユーザを取得。
        case mu of
          Just user -> do
            now <- liftIO utcTime
            let record = NewWRecord (User.id user) now weight
            n <- runSqlite $ insertNewWRecord record
            when (n == 0) $ mainView (Just "記録に失敗しました")
            redirect "/"
          -- [FIXED] 暫定
          Nothing -> do
            redirect "/"
  where
    utcTime = TM.utcToLocalTime TM.utc <$> TM.getCurrentTime
