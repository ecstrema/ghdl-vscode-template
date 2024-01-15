# GHDL template

Run GHDL in WSL. This template is for VSCode.

The default build script works for standalone scripts.

For projects, run:

```bash
ghdl -i --workdir=work *.vhd *.vhdl
ghdl -m --workdir=work <top-level-entity>
ghdl -r --workdir=work <top-level-entity>
```
