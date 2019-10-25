# Latex Action 

This action compiles latex file using Tectonic, which automatically downloads required dependencies.
More Information about tectonic can be found [here](https://tectonic-typesetting.github.io/en-US/).

## Inputs

### `tex-path`

**Required** Path of tex, xtx file to compile.

## Outputs
Pushes a Compiled PDF file parallel to the tex, xtx file.

## Example usage
```
on: [push]

jobs:
  latex-job:
    runs-on: ubuntu-latest
    name: A job to Compile Latex file
    steps:
    - uses: actions/checkout@v1
    - name: Compilation
      uses: vinay0410/tectonic-action@master
      env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tex_path: 'dir/file.tex'
```