import client/lib/path.{type Path}
import client/lib/route.{type Route}
import gleam/dynamic
import gleam/option.{type Option}
import lustre_http
import shared.{type Song, Song}

pub type Msg {
  OnRouteChange(Route)

  SongsReceived(Result(GetSongsResponse, lustre_http.HttpError))
  ShowSongReceived(Result(Song, lustre_http.HttpError))

  CreateSongUpdateTitle(value: String)
  CreateSongUpdateHref(value: String)
  CreateSongUpdateFilePath(value: String)
  CreateSongUpdateError(value: Option(String))
  RequestCreateSong
  CreateSongResponded(
    resp_result: Result(MessageErrorResponse, lustre_http.HttpError),
  )
}

pub type GetSongsResponse {
  GetSongsResponse(songs: List(Song))
}

pub type MessageErrorResponse {
  MessageErrorResponse(message: Option(String), error: Option(String))
}

pub fn message_error_decoder() {
  dynamic.decode2(
    MessageErrorResponse,
    dynamic.optional_field("message", dynamic.string),
    dynamic.optional_field("error", dynamic.string),
  )
}
