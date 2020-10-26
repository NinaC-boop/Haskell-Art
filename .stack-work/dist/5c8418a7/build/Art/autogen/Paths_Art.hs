{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_Art (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "D:\\Homework\\COMP3141\\Exercises\\Art\\.stack-work\\install\\baf22329\\bin"
libdir     = "D:\\Homework\\COMP3141\\Exercises\\Art\\.stack-work\\install\\baf22329\\lib\\x86_64-windows-ghc-8.2.2\\Art-1.0-2AcTTE0wgmP9J0HTnAf5fi-Art"
dynlibdir  = "D:\\Homework\\COMP3141\\Exercises\\Art\\.stack-work\\install\\baf22329\\lib\\x86_64-windows-ghc-8.2.2"
datadir    = "D:\\Homework\\COMP3141\\Exercises\\Art\\.stack-work\\install\\baf22329\\share\\x86_64-windows-ghc-8.2.2\\Art-1.0"
libexecdir = "D:\\Homework\\COMP3141\\Exercises\\Art\\.stack-work\\install\\baf22329\\libexec\\x86_64-windows-ghc-8.2.2\\Art-1.0"
sysconfdir = "D:\\Homework\\COMP3141\\Exercises\\Art\\.stack-work\\install\\baf22329\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Art_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Art_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Art_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Art_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Art_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Art_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
