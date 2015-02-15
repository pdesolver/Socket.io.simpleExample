# Socket.io.simpleExample
A minimal haskell webserver vending a html page which it can communicate with using node.js socket.io (engine.io).

This should work out of the box, just open main.hs in ghci and type main and hit enter,
open up a browser and point it to localhost:8000 and you should see a webpage where you can enter a number, push a button and have that number sent from the browser through the websocket to the haskell program, who multiplies the number by 2 and returns it through the websocket to the browser who displays it in another text box.

you will of course have to install all the dependancies by hand using cabal, simply type 
cabal install snap-core
for example, if ghc throws an error similar to "cant find module Snap.Core".

it should also build and run if you run
cabal run
then navigate a browser to "localhost:8000"


