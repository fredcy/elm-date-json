build: elm.js

elm.js: src/Main.elm
	elm make src/Main.elm --yes --output=elm.js

clean:
	-rm elm.js
	-rm -r elm-stuff/build-artifacts

