#? stdtmpl | standard
#proc displayView*(path:string, files:seq[string]): string =
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Current Directory Files</title>
  </head>
  <body>
    # let urlPath = if path == "/": "" else: path
    <h1>Directory listing for ${path}</h1>
    <hr>
    #if files.len > 0:
      <ul>
        #for file in files:
          <li><a href="${urlPath}/${file}">${file}</a></li>
        #end for
      </ul>
    #end if
    <hr>
  </body>
</html>
