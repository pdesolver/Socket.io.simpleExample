{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Monad (forever)

import qualified Control.Concurrent.STM as STM
import qualified Network.EngineIO as EIO
import qualified Network.EngineIO.Snap as EIOSnap
import qualified Snap.Core as Snap
import qualified Snap.Util.FileServe as Snap
import qualified Snap.Http.Server as Snap

import Data.Text as T
import System.Directory


main :: IO ()
main = deployServer (*2)

deployServer :: (Double -> Double) -> IO ()
deployServer f = do
  eio <- EIO.initialize
  Snap.quickHttpServe $ do
    dataDir <- liftIO getCurrentDirectory
    Snap.route [ ("/engine.io", EIO.handler eio (handler f) EIOSnap.snapAPI)
               , ("/", Snap.serveDirectory dataDir)
               ]
  

handler :: (Read a,Show b,Monad m) =>(a->b) -> EIO.Socket -> m EIO.SocketApp
handler f s = return EIO.SocketApp
 	 { EIO.saApp = forever $
	      STM.atomically $ EIO.receive s >>= (EIO.send s).(doToPacket f)
	  , EIO.saOnDisconnect = return ()
	  }
    where		
	doToPacket g (EIO.TextPacket a)= EIO.TextPacket $ T.pack $ show $ g $read $ T.unpack a






