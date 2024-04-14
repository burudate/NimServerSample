import std/tables
import std/asyncdispatch
import ./lib/server

proc localserver(port=8080) =
  ## ローカルでサーバーを起動するコマンドです
  waitFor main(port)

const HELP = {"port": "ここに指定したポート番号でサーバーが起動します"}.toTable()

when isMainModule:
  import cligen
  dispatch(localserver, help=HELP)
