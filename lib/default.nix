{ ... }:

{
  # Concatenate all files in a directory into a single string
  concatFilesInDir = dirPath:
    let
      files = builtins.attrNames (builtins.readDir dirPath);
      regularFiles =
        builtins.filter (name: (builtins.readDir dirPath).${name} == "regular")
        files;
      contents =
        map (file: builtins.readFile "${dirPath}/${file}") regularFiles;
    in builtins.concatStringsSep "" contents;

  # Add more utility functions here as needed
}
