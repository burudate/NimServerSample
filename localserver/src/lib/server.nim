import std/asynchttpserver
import std/asyncdispatch
import std/os
import std/asyncfile
import std/mimetypes
import std/strutils
import ./file
import ./view

proc main*(port:int) {.async.} =
  var server = newAsyncHttpServer()
  proc cb(req: Request) {.async.} =
    let filepath = getCurrentDir() / req.url.path
    if fileExists(filepath):
      let file = openAsync(filepath, fmRead)
      defer: file.close()
      let data = file.readAll().await

      echo (req.reqMethod, req.url, req.headers)
      let ext = req.url.path.split(".")[^1]
      let contentType = newMimetypes().getMimetype(ext)
      let headers = newHttpHeaders()
      headers["Content-Type"] = contentType
      await req.respond(Http200, data, headers)
    else:
      let files = getFiles(req.url.path)
      let body = displayView(req.url.path, files)
      let headers = newHttpHeaders()
      await req.respond(Http200, body, headers)

  server.listen(Port(port)) # or Port(8080) to hardcode the standard HTTP port.
  let port = server.getPort
  echo "test this with: curl localhost:" & $port.uint16 & "/"
  while true:
    if server.shouldAcceptRequest():
      await server.acceptRequest(cb)
    else:
      await sleepAsync(500)
