# elm-date-json
Test experimental Json.Decode.date decoder.

I sometimes want to pass a Javascript `Date` value into an Elm app. There is currently no decoder to do that.

I forked the Elm core and created a new `Json.Decode.date` API. See the date-json-decode branch at https://github.com/fredcy/elm-lang-core

This simple Elm application tests this new API by using it to decode a JS Date value passed in via `programWithFlags` as a `Json.Decode.value` value.
Note that the Elm compiler does not allow `Date` values within the value passed as flags.
