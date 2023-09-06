<img src="xAct/PSALTer/Documentation/Logo/GitHubLogo.png" width="1000">

# Particle Spectrum for Any Tensor Lagrangian (PSALTer)
## Version 0.0.0-developer

- Pre-release version, pending completion of preprint and docs.
- Functionality for Weyl gauge theory and metric affine gravity removed due to ongoing collaborations with Tallinn and Tartu.

## License

Copyright © 2022 Will E. V. Barker

PSALTer is distributed as free software under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.en.html).

PSALTer is provided without warranty, or the implied warranty of merchantibility or fitness for a particular purpose.

## About

PSALTer is an (unofficial) part of the [xAct bundle](http://www.xact.es/). 

PSALTer is designed to predict the propagating quantum particle states in any tensorial field theory, including (but not limited to) just about any theory of gravity.

As a demonstration, let's say our Lagrangian is the Kretschmann curvature scalar, plus the square of the torsion tensor. We simply linearise the theory near Minkowski spacetime (in terms of the connection and tetrad perturbation), plug it into PSALTer and voilà:
<img src="xAct/PSALTer/Documentation/English/MelichevPercacciTheory.png" width="1000">

## Installation

#### Requirements 

PSALTer has been tested in the following environment(s):
- Linux x86 (64-bit) (specifically Manjaro and Arch)
- Mathematica v 13.1.0.0
- xAct v 1.2.0
- MaTeX v 1.7.9
- xPlain v 0.0.0-developer (if running the Calibration notebook)

#### Install 

1. Make sure you have [installed xAct](http://www.xact.es/download.html).
2. Make sure you have [installed MaTeX](http://szhorvat.net/pelican/latex-typesetting-in-mathematica.html).
3. Download PSALTer:
	```bash, git
	git clone https://github.com/wevbarker/PSALTer-devel
	cd PSALTer-devel 
	```
4. Place the `./xAct/PSALTer` directory relative to your xAct install. A global install might have ended up at: 
	```bash
	/usr/share/Mathematica/Applications/xAct
	```
## Quickstart 

1. In the cloned PSALTer repository, open the example notebook at `./xAct/PSALTer/Documentation/English/Calibration.nb`, scroll through *without running* to understand the capabilities and scope of PSALTer.
2. Make sure you have [installed xPlain](https://github.com/wevbarker/xPlain) if you want to run `Calibration.nb`, then simply execute the single line of code in the first (and only) input cell (you should first delete all the output using `Cell -> Delete All Output` in the Mathematica front-end).
3. The first time you run `Calibration.nb` after a fresh install, PSALTer will rebuild certain binary files. This may take some time, especially on Windows machines.
4. After the install completes successfully, delete the build output cells as before, and re-run the first input cell.
5. To see how the examples are implemented, and to test your own theories, go to the Wolfram Language file at `./xAct/PSALTer/Documentation/English/Calibration.m`, and all the various sub-files referred to therein under the path `./xAct/PSALTer/Documentation/English/Calibration/`.

## Contribute

Please do! I'm always responsive to emails (about science), so be sure to reach out at [wb263@cam.ac.uk](mailto:wb263@cam.ac.uk). I will also do my best to get your code working if you are just trying to use PSALTer.

## Acknowledgements

This work was performed using resources provided by the Cambridge Service for Data Driven Discovery (CSD3) operated by the University of Cambridge Research Computing Service ([www.csd3.cam.ac.uk](www.csd3.cam.ac.uk)), provided by Dell EMC and Intel using Tier-2 funding from the Engineering and Physical Sciences Research Council (capital grant EP/T022159/1), and DiRAC funding from the Science and Technology Facilities Council ([www.dirac.ac.uk](www.dirac.ac.uk)).

This work was also performed using the Newton server, access to which was provisioned by Will Handley.

PSALTer was improved by many useful discussions with Jaakko Annala, Stephanie Buttigieg, Mike Hobson, Manuel Hohmann, Damianos Iosifidis, Georgios Karananas, Anthony Lasenby, Yun-Cherng Lin, Carlo Marzo, Vijay Nenmeli, Roberto Percacci, Syksy Räsänen, Cillian Rew, Claire Rigouzzo, Zhiyuan Wei, David Yallup, and Sebastian Zell.

I am grateful for the kind hospitality of Leiden University and the [Lorentz Institute](https://www.lorentz.leidenuniv.nl/), and am supported by [Girton College, Cambridge](https://www.girton.cam.ac.uk/).
