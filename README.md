# Latex Action 

This action compiles latex files using [Tectonic](https://tectonic-typesetting.github.io/en-US/), which automatically downloads necessary dependencies, and compiles to pdf.

## Inputs

### `tex-path`

**Required** Path of tex, xtx file to compile.

### `push`

**Optional** Compiled PDF is pushed, if `push` is passed as 'yes'.

### `switches`

**Optional** Command line switches passed to the Tectonic engine (snipped below from the [official manual](https://tectonic-typesetting.github.io/book/latest/cli/index.html)).
<details> 
  <summary><p>Tectonic's command line flags and options</summary>
 
   <table><thead><tr><th align="left">Short</th><th align="left">Full</th><th align="left">Explanation</th></tr></thead><tbody>
<tr><td align="left"><code>-h</code></td><td align="left"><code>--help</code></td><td align="left">Prints help information</td></tr>
<tr><td align="left"><code>-k</code></td><td align="left"><code>--keep-intermediates</code></td><td align="left">Keep the intermediate files generated during processing</td></tr>
<tr><td align="left"></td><td align="left"><code>--keep-logs</code></td><td align="left">Keep the log files generated during processing</td></tr>
<tr><td align="left"><code>-C</code></td><td align="left"><code>--only-cached</code></td><td align="left">Use only resource files cached locally</td></tr>
<tr><td align="left"><code>-p</code></td><td align="left"><code>--print</code></td><td align="left">Print the engine's chatter during processing</td></tr>
<tr><td align="left"></td><td align="left"><code>--synctex</code></td><td align="left">Generate SyncTeX data</td></tr>
<tr><td align="left"><code>-V</code></td><td align="left"><code>--version</code></td><td align="left">Prints version information</td></tr>
</tbody></table>
<p>The following are the available options.</p>
<table><thead><tr><th align="left">Short</th><th align="left">Full</th><th align="left">Explanation</th></tr></thead><tbody>
<tr><td align="left"><code>-b</code></td><td align="left"><code>--bundle &lt;PATH&gt;</code></td><td align="left">Use this Zip-format bundle file to find resource files instead of the default</td></tr>
<tr><td align="left"><code>-c</code></td><td align="left"><code>--chatter &lt;LEVEL&gt;</code></td><td align="left">How much chatter to print when running [default: default]  [possible values: default, minimal]</td></tr>
<tr><td align="left"></td><td align="left"><code>--format &lt;PATH&gt;</code></td><td align="left">The name of the &quot;format&quot; file used to initialize the TeX engine [default: latex]</td></tr>
<tr><td align="left"></td><td align="left"><code>--hide &lt;PATH&gt;...</code></td><td align="left">Tell the engine that no file at <PATH> exists, if it tries to read it</td></tr>
<tr><td align="left"></td><td align="left"><code>--makefile-rules &lt;PATH&gt;</code></td><td align="left">Write Makefile-format rules expressing the dependencies of this run to <PATH></td></tr>
<tr><td align="left"><code>-o</code></td><td align="left"><code>--outdir &lt;OUTDIR&gt;</code></td><td align="left">The directory in which to place output files [default: the directory containing INPUT]</td></tr>
<tr><td align="left"></td><td align="left"><code>--outfmt &lt;FORMAT&gt;</code></td><td align="left">The kind of output to generate [default: pdf]  [possible values: pdf, html, xdv, aux, format]</td></tr>
<tr><td align="left"></td><td align="left"><code>--pass &lt;PASS&gt;</code></td><td align="left">Which engines to run [default: default]  [possible values: default, tex, bibtex_first]</td></tr>
<tr><td align="left"><code>-r</code></td><td align="left"><code>--reruns &lt;COUNT&gt;</code></td><td align="left">Rerun the TeX engine exactly this many times after the first</td></tr>
<tr><td align="left"><code>-w</code></td><td align="left"><code>--web-bundle &lt;URL&gt;</code></td><td align="left">Use this URL find resource files instead of the default</td></tr>
</tbody></table>
</details>

## Outputs
Pushes a Compiled PDF file parallel to the tex, xtx file, if push is passed as 'yes'.

## Example usage

### Pushes Compiled PDF

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
        push: 'yes'
```

### Doesn't Push Compiled PDF

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

### CLI Switches

Suppose we want three reruns after the first and to print the TeX engine's chatter during processing. We adapt `Pushes Compiled PDF` example to our purpose as follows:

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
        push: 'yes'
        swtiches: --reruns 3 --print
```
