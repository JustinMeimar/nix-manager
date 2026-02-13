{ ... }:
let
  collectFilesOfType = dirPath: fileType:
    let files = builtins.readDir dirPath;
    in
      builtins.filter
          (name: (files.${name} == fileType))
          (builtins.attrNames files);
  
  fileListToContentList = dirPath: fileList:
    builtins.map
        (file: builtins.readFile "${dirPath}/${file}") 
        (fileList); 
in
{ 
  # Concat contents of regular files into a NL separated string,
  # non recursive.
  concatDirFiles = dirPath:
    let
      regularFiles = collectFilesOfType dirPath "regular";     
      contents = fileListToContentList dirPath regularFiles;
    in
      builtins.concatStringsSep "\n" contents;
}
