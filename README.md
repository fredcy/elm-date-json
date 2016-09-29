# elm-date-json
Test experimental Json.Decode.date decoder and Json.Encode.date encoder.

I sometimes want to pass a Javascript `Date` value into an Elm app. There is currently no decoder to do that.

I forked the Elm core and created a new `Json.Decode.date` API. See the date-json-decode branch at https://github.com/fredcy/elm-lang-core

This simple Elm application tests this new API by using it to decode a JS Date value passed in via `programWithFlags` as a `Json.Decode.value` value. It also tests bringing in JS Date values over a port.

For symmetry I also test a new Json.Encode.date API that allows for sending Elm `Date` values over a port.

Note that the Elm compiler does not allow `Date` values within the value passed as flags or as values sent or received over ports.
So this app passes date values from Javascript as `Json.Decode.Value` and to Javascript as `Json.Encode.Value` and does the conversion explicitly to/from Elm `Date` values; the automatic conversion typically available with flags and ports is not possible without compiler changes.
