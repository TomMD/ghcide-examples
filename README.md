# ghcide is broken for multi-target project using cabal.project

Consider the project:

```
.
├── cabal.project
├── hie.yaml
├── x
│   ├── CHANGELOG.md
│   ├── LICENSE
│   ├── Setup.hs
│   ├── src
│   │   └── X.hs
│   └── x.cabal
└── y
    ├── CHANGELOG.md
    ├── LICENSE
    ├── Setup.hs
    ├── cabal.project
    ├── src
    │   └── Y.hs
    └── y.cabal

4 directories, 13 files
```

The run fails:

```
ghcide version: 0.1.0 (GHC: 8.6.4) (PATH: /Users/tommd/.cabal/store/ghc-8.6.4/ghcd-0.0.3-ad29d5d6/bin/ghcide) (GIT hash: 8b328bb7c5f3e09280788b56abd6fb6d0bfb08ce)
Ghcide setup tester in /private/tmp/xyz/broken-multi-target-cabal-project.
Report bugs at https://github.com/digital-asset/ghcide/issues

Step 1/6: Finding files to test in /private/tmp/xyz/broken-multi-target-cabal-project
Found 4 files

Step 2/6: Looking for hie.yaml files that control setup
Found 1 cradle

Step 3/6, Cradle 1/1: Loading /private/tmp/xyz/broken-multi-target-cabal-project/hie.yaml

Step 4/6, Cradle 1/1: Loading GHC Session
ghcide: CradleError ExitSuccess ["Multi Cradle: No prefixes matched","pwd: /private/tmp/xyz/broken-multi-target-cabal-project","filepath: /private/tmp/xyz/broken-multi-target-cabal-project","prefixes:","(\"./x\",Cabal {component = Just \"lib:x\"})","(\"./y\",Cabal {component = Just \"lib:y\"})"]
```

# ghcide works for single-target cabal.project builds

Consider the project:

```
.
├── CHANGELOG.md
├── LICENSE
├── Setup.hs
├── cabal.project
├── hie.yaml
├── src
│   └── Y.hs
├── x
│   ├── CHANGELOG.md
│   ├── LICENSE
│   ├── Setup.hs
│   ├── src
│   │   └── X.hs
│   └── x.cabal
└── y.cabal

5 directories, 13 files
```

ghcide succeeds:

```
Ghcide setup tester in /private/tmp/xyz/working-single-target-cabal-project.
Report bugs at https://github.com/digital-asset/ghcide/issues

Step 1/6: Finding files to test in /private/tmp/xyz/working-single-target-cabal-project
Found 4 files

Step 2/6: Looking for hie.yaml files that control setup
Found 1 cradle

Step 3/6, Cradle 1/1: Loading /private/tmp/xyz/working-single-target-cabal-project/hie.yaml

Step 4/6, Cradle 1/1: Loading GHC Session
> Resolving dependencies...
> Build profile: -w ghc-8.6.4 -O1
> In order, the following will be built (use -v for more details):
>  - x-0.1.0.0 (lib) (first run)
>  - y-0.1.0.0 (lib) (first run)
> Configuring library for x-0.1.0.0..
> Warning: Packages using 'cabal-version: >= 1.10' must specify the
> 'default-language' field for each component (e.g. Haskell98 or Haskell2010).
> If a component uses different languages in different modules then list the
> other ones in the 'other-languages' field.
> Preprocessing library for x-0.1.0.0..
> Building library for x-0.1.0.0..
> [1 of 1] Compiling X                ( src/X.hs, /private/tmp/xyz/working-single-target-cabal-project/dist-newstyle/build/x86_64-osx/ghc-8.6.4/x-0.1.0.0/build/X.o )
> Configuring library for y-0.1.0.0..
> Warning: Packages using 'cabal-version: >= 1.10' must specify the
> 'default-language' field for each component (e.g. Haskell98 or Haskell2010).
> If a component uses different languages in different modules then list the
> other ones in the 'other-languages' field.
> Preprocessing library for y-0.1.0.0..

Step 5/6: Initializing the IDE

Step 6/6: Type checking the files
File:     /private/tmp/xyz/working-single-target-cabal-project/Setup.hs
Hidden:   no
Range:    1:7-1:26
Source:   not found
Severity: DsError
Message: 
  [0;91mCould not load module ‘Distribution.Simple’
  It is a member of the hidden package ‘Cabal-3.0.0.0’.
  Perhaps you need to add ‘Cabal’ to the build-depends in your .cabal file.
  It is a member of the hidden package ‘Cabal-3.0.0.0’.
  Perhaps you need to add ‘Cabal’ to the build-depends in your .cabal file.
  It is a member of the hidden package ‘Cabal-2.4.0.1’.
  Perhaps you need to add ‘Cabal’ to the build-depends in your .cabal file.[0m
File:     /private/tmp/xyz/working-single-target-cabal-project/x/Setup.hs
Hidden:   no
Range:    1:7-1:26
Source:   not found
Severity: DsError
Message: 
  [0;91mCould not load module ‘Distribution.Simple’
  It is a member of the hidden package ‘Cabal-3.0.0.0’.
  Perhaps you need to add ‘Cabal’ to the build-depends in your .cabal file.
  It is a member of the hidden package ‘Cabal-3.0.0.0’.
  Perhaps you need to add ‘Cabal’ to the build-depends in your .cabal file.
  It is a member of the hidden package ‘Cabal-2.4.0.1’.
  Perhaps you need to add ‘Cabal’ to the build-depends in your .cabal file.[0m
Files that failed:
 * /private/tmp/xyz/working-single-target-cabal-project/Setup.hs
 * /private/tmp/xyz/working-single-target-cabal-project/x/Setup.hs

Completed (2 files worked, 2 files failed)
```

But without the hie.yaml it will fail:

```
ghcide version: 0.1.0 (GHC: 8.6.4) (PATH: /Users/tommd/.cabal/store/ghc-8.6.4/ghcd-0.0.3-ad29d5d6/bin/ghcide) (GIT hash: 8b328bb7c5f3e09280788b56abd6fb6d0bfb08ce)
Ghcide setup tester in /private/tmp/xyz/working-single-target-cabal-project.
Report bugs at https://github.com/digital-asset/ghcide/issues

Step 1/6: Finding files to test in /private/tmp/xyz/working-single-target-cabal-project
Found 4 files

Step 2/6: Looking for hie.yaml files that control setup
Found 1 cradle

Step 3/6, Cradle 1/1: Implicit cradle for /private/tmp/xyz/working-single-target-cabal-project
Cradle {cradleRootDir = "/private/tmp/xyz/working-single-target-cabal-project", cradleOptsProg = CradleAction: Cabal}

Step 4/6, Cradle 1/1: Loading GHC Session
> cabal: Unrecognised target syntax for ''.
> 
ghcide: CradleError (ExitFailure 1) ["Failed to parse result of calling cabal","","cabal: Unrecognised target syntax for ''.\n\n",""]
```

# ghcide works for single-target project.cabal builds

Consider the project:

```
.
├── CHANGELOG.md
├── LICENSE
├── Setup.hs
├── src
│   └── X.hs
└── x.cabal

1 directory, 5 files
```

ghcide succeeds but in an ugly way because it tries to build Setup.hs:

```
ghcide version: 0.1.0 (GHC: 8.6.4) (PATH: /Users/tommd/.cabal/store/ghc-8.6.4/ghcd-0.0.3-ad29d5d6/bin/ghcide) (GIT hash: 8b328bb7c5f3e09280788b56abd6fb6d0bfb08ce)
Loaded package environment from /Users/tommd/.ghc/x86_64-darwin-8.6.4/environments/default
Ghcide setup tester in /private/tmp/xyz/working-single-target-project-dot-cabal.
Report bugs at https://github.com/digital-asset/ghcide/issues

Step 1/6: Finding files to test in /private/tmp/xyz/working-single-target-project-dot-cabal
Found 2 files

Step 2/6: Looking for hie.yaml files that control setup
Found 1 cradle

Step 3/6, Cradle 1/1: Implicit cradle for /private/tmp/xyz/working-single-target-project-dot-cabal
Cradle {cradleRootDir = "/private/tmp/xyz/working-single-target-project-dot-cabal", cradleOptsProg = CradleAction: Default}

Step 4/6, Cradle 1/1: Loading GHC Session

Step 5/6: Initializing the IDE

Step 6/6: Type checking the files
File:     /private/tmp/xyz/working-single-target-project-dot-cabal/Setup.hs
Hidden:   no
Range:    1:7-1:26
Source:   not found
Severity: DsError
Message: 
  [0;91mCould not load module ‘Distribution.Simple’
  It is a member of the hidden package ‘Cabal-3.0.0.0’.
  You can run ‘:set -package Cabal’ to expose it.
  (Note: this unloads all the modules in the current scope.)
  It is a member of the hidden package ‘Cabal-3.0.0.0’.
  You can run ‘:set -package Cabal’ to expose it.
  (Note: this unloads all the modules in the current scope.)
  It is a member of the hidden package ‘Cabal-2.4.0.1’.
  You can run ‘:set -package Cabal’ to expose it.
  (Note: this unloads all the modules in the current scope.)[0m
Files that failed:
 * /private/tmp/xyz/working-single-target-project-dot-cabal/Setup.hs

Completed (1 file worked, 1 file failed)
```
