import std/os
import std/strutils

proc getFiles*(path:string):seq[string] =
  let currentPath = getCurrentDir() / path
  var files = newSeq[string]()
  for row in walkDir(currentPath, relative=true):
    # ディレクトリにあるものがディレクトリもしくは拡張子があるものの絶対パスを配列に追加していく
    # →バイナリは含めない
    if row.kind == pcDir or row.path.contains("."):
      files.add(row.path)
  return files
