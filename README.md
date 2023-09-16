<img src="xAct/PSALTer/Documentation/Logo/GitHubLogo.png" width="1000">

# Particle Spectrum for Any Tensor Lagrangian (PSALTer)
## Version 0.0.1-developer

- Pre-release version, pending completion of pre-print and docs.
- Functionality for Weyl gauge theory and metric affine gravity removed due to ongoing collaborations with Tallinn and Tartu.
- Improved README

## License

Copyright © 2022 Will E. V. Barker

PSALTer is distributed as free software under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.en.html).

PSALTer is provided without warranty, or the implied warranty of merchantibility or fitness for a particular purpose.

## About

PSALTer is an (unofficial) part of the [xAct bundle](http://www.xact.es/). 

PSALTer is designed to predict the propagating quantum particle states in any tensorial field theory, including (but not limited to) just about any theory of gravity. The _free_ action $S_{\text{F}}$ must have the structure
```math
S_{\text{F}}=\int\mathrm{d}^4x\ \zeta(x)^{\text{T}}\cdot\Big[\mathcal{O}(\partial)\cdot\zeta(x)-j(x)\Big],
```
where the ingredients are:
- The dynamical fields $\zeta$ are real tensors, which may be a collection of distinct fields, each field having some collection of spacetime indices, perhaps with some symmetry among the indices. 
- The wave operator $\mathcal{O}$ is a real, second-order (Ostrogradsky's theorem discourages higher-derivative operators, but even if it did not we note that the apparent order may always be lowered by the introduction of extra fields) differential operator constructed from the flat-space metric $\eta$ and partial derivative $\partial$ (but _not_ the totally antisymmetric $\epsilon$ tensor), linearly parameterised by a collection of coupling coefficients.
- The source currents $j$ are conjugate to the fields $\zeta$. They encode all external interactions to second order in fields, whilst keeping the external dynamics completely anonymous.

For theories of this form, the _spin-projection operator_ (SPO) algorithm applies and the PSALTer package may be used. Of course, spectra can also be obtained for more exotic theories, but these require the algorithm to be modified beyond its minimal form.

### Example: Melichev-Percacci theory

As a demonstration, let's say our Lagrangian is the Kretschmann curvature scalar, plus the square of the torsion tensor
```math
S_{\text{F}}=\int\mathrm{d}^4x\ \Big[\alpha_1\mathcal{R}^{\mu\nu\sigma\tau}\mathcal{R}_{\mu\nu\sigma\tau}+\beta_1\mathcal{T}^{\mu\nu\sigma}\mathcal{T}_{\mu\nu\sigma}+L_{\text{M}}\Big],
```
where $L_{\text{M}}$ is the matter Lagrangian, and $\alpha_1$ (type `Alp1`) and $\beta_1$ (type `Bet1`) are coupling coefficients. The _free_ theory is the _linearisation_ of this action near Minkowski spacetime. Taking the perturbation of the tetrad field $f_{\mu\nu}$ (type `F[-m,-n]`) to be an _asymmetric_ rank-two tensor, and the perturbation of the independent connection field $A_{\mu\nu\sigma}$ (type `A[-m,-n,-s]`) to be a rank-three tensor _antisymmetric_ in the first two indices, we can expand the theory to quadratic order, with partial derivative `CD[-m]@`. Now in a notebook, load the package:
```
<<xAct`PSALTer`;
```
and plug the quadratic expansion directly into PSALTer:
```mathematica
ParticleSpectrum[
    Alp1*A[-a,-b,-c]*CD[c]@F[a,b]+<many more terms>,
    ClassName->"PoincareGaugeTheory",
    TheoryName->"MelichevPercacciTheory",	
    Method->"Hard",
    MaxLaurentDepth->3
];
```
and execute the cell. Ten minutes later, and voilà:

<img src="xAct/PSALTer/Documentation/English/MelichevPercacciTheory.png" width="1000">

To summarise the physical information that is automatically computed:
- *PSALTer results pannel:* The free action is quoted back to you.
- *Wave operator:* The wave operator is presented as a hermitian matrix in $k$-space, block-decomposed over the $J^P$ sectors of definite spin $J$ and parity $P$.
- *Saturated propagator:* The Moore-Penrose pseudoinverse of the wave operator is computed, and sandwiched between conserved source currents.
- *Source constraints:* The null spaces of the wave operator blocks encode gauge symmetries of the theory, corresponding to conservation laws satisfied by the source currents, these are quoted.
- *Massive spectrum:* There is listed the spectrum of massive states in the theory, with information about the square mass, pole residue, spin and parity of each state.
- *Massless spectrum:* There is listed the spectrum of massless propagating polarisations. Also, the spectrum of (pathological) higher-order poles is computed, up to a depth specified by `MaxLaurentDepth`.
- *Unitarity conditions:* From the requirement of positivity of the pole residues, and of the square masses, the inequality conditions on the parameters `Alp1` and `Bet1` needed to ensure unitarity of the S-matrix are computed (if the theory can be made to be unitary at all).

### General use 

#### Function syntax 

PSALTer defines _only one_ function:

```mathematica
ParticleSpectrum[
    QuadraticLagrangian_,
    ClassName->Classname_,
    TheoryName->TheoryName_,
    Method->Method_,
    MaxLaurentDepth->MaxLaurentDepth_
];
```
and the arguments and options are as follows:
- `QuadraticLagrangian_` must be a valid linearised Lagrangian; do _not_ include the term coupling the fields to their conjugate sources, this will be automatically included by PSALTer.
- `Classname_` must be a pre-defined string.
- `TheoryName_` can be any string.
- `Method_` can be `"Easy"` (default) or `"Hard"` (experimental, uses home-brewed implementations of the symbolic Moore-Penrose inverse and other innovations).
- `MaxLaurentDepth_` can be `1`, `2` or `3`.

For details about `QuadraticLagrangian_` and `Classname_`, keep reading.

#### Basic geometry

PSALTer pre-defines a flat, Minkowskian manifold with the following ingredients:

|Object|LaTeX|
|---|---|
|`G[-m,-n]`|$\eta_{\mu\nu}$|
|`CD[-m]@`|$\partial_{\mu}$|

#### Theory classes, fields and couplings

Five _theory classes_ (also called _theory modules_) are available, and these _must_ be passed to `ParticleSpectrum` via the option `ClassName`. For each module, you are only permitted to pass linearised Lagrangia which refer to the collection of fields and coupling constants defined by that module, as listed in the following table:

|Class name|Fields|LaTeX|Coupling constants|LaTeX|
|---|---|---|---|---|
|`"ScalarTheory"`|``xAct`PSALTer`ScalarTheory`Phi[]``|$\phi$|``xAct`PSALTer`ScalarTheory`Coupling1``|$\alpha_1$|
||||``xAct`PSALTer`ScalarTheory`Coupling2``|$\alpha_2$|
||||``xAct`PSALTer`ScalarTheory`Coupling3``|$\alpha_3$|
|`"VectorTheory"`|``xAct`PSALTer`VectorTheory`B[-m]``|$B_{\mu}$|``xAct`PSALTer`VectorTheory`Coupling1``|$\alpha_1$|
||||``xAct`PSALTer`VectorTheory`Coupling2``|$\alpha_2$|
||||``xAct`PSALTer`VectorTheory`Coupling3``|$\alpha_3$|
|`"TensorTheory"`|``xAct`PSALTer`TensorTheory`LinearMetric[-m,-n]``|$h_{\mu\nu}$|``xAct`PSALTer`TensorTheory`Coupling1``|$\alpha_1$|
||||``xAct`PSALTer`TensorTheory`Coupling2``|$\alpha_2$|
||||``xAct`PSALTer`TensorTheory`Coupling3``|$\alpha_3$|
|`"ScalarTensorTheory"`|``xAct`PSALTer`ScalarTensorTheory`LinearMetric[-m,-n]``|$h_{\mu\nu}$|``xAct`PSALTer`ScalarTensorTheory`Coupling1``|$\alpha_1$|
||``xAct`PSALTer`ScalarTensorTheory`Phi[]``|$\phi$|...|...|
||||``xAct`PSALTer`PoincareGaugeTheory`Coupling10``|$\alpha_{10}$|
|`"PoincareGaugeTheory"`|``xAct`PSALTer`PoincareGaugeTheory`F[-m,-n]``|$f_{\mu\nu}$|``xAct`PSALTer`PoincareGaugeTheory`kLambda``|$\lambda$|
||``xAct`PSALTer`PoincareGaugeTheory`A[-m,-n,-s]``|$A_{\mu\nu\sigma}$|``xAct`PSALTer`PoincareGaugeTheory`kR1``|$r_1$|
||||...|...|
||||``xAct`PSALTer`PoincareGaugeTheory`kR6``|$r_6$|
||||``xAct`PSALTer`PoincareGaugeTheory`kT1``|$t_1$|
||||``xAct`PSALTer`PoincareGaugeTheory`kT2``|$t_2$|
||||``xAct`PSALTer`PoincareGaugeTheory`kT3``|$t_3$|
||||``xAct`PSALTer`PoincareGaugeTheory`Alp0``|$\alpha_0$|
||||...|...|
||||``xAct`PSALTer`PoincareGaugeTheory`Alp6``|$\alpha_6$|
||||``xAct`PSALTer`PoincareGaugeTheory`Bet1``|$\beta_1$|
||||``xAct`PSALTer`PoincareGaugeTheory`Bet2``|$\beta_2$|
||||``xAct`PSALTer`PoincareGaugeTheory`Bet3``|$\beta_3$|

## Installation

### Requirements 

PSALTer has been tested in the following environment(s):
- Linux x86 (64-bit) (specifically Manjaro and Arch)
- Mathematica v 13.1.0.0
- xAct v 1.2.0
- MaTeX v 1.7.9
- xPlain v 0.0.0-developer (if running the Calibration notebook)

### Install 

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

PSALTer was improved by many useful discussions with Jaakko Annala, Stephanie Buttigieg, Mark Goodsell, Mike Hobson, Manuel Hohmann, Damianos Iosifidis, Georgios Karananas, Anthony Lasenby, Yun-Cherng Lin, Carlo Marzo, Vijay Nenmeli, Roberto Percacci, Syksy Räsänen, Cillian Rew, Claire Rigouzzo, Zhiyuan Wei, David Yallup, and Sebastian Zell.

I am grateful for the kind hospitality of Leiden University and the [Lorentz Institute](https://www.lorentz.leidenuniv.nl/), and am supported by [Girton College, Cambridge](https://www.girton.cam.ac.uk/).

## Examples

The theories which are tested in `./xAct/PSALTer/Documentation/English/Calibration.nb`, alongside a few other theories, are listed below. To understand the physical motivations, please refer to the notebook.

### Metric-affine gravity

#### Metric-affine Einstein-Hilbert theory 
<img src="xAct/PSALTer/Documentation/English/MetricAffineEinsteinHilbertTheory.png" width="1000">

#### Annala-Räsänen column one row one
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row1.png" width="1000">

#### Annala-Räsänen column one row two
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row2.png" width="1000">

#### Annala-Räsänen column one row three
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row3.png" width="1000">

#### Annala-Räsänen column one row four
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row4.png" width="1000">

#### Annala-Räsänen column one row five
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row5.png" width="1000">

### Zero-torsion Palatini gravity

#### Annala-Räsänen column three row one
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row1.png" width="1000">

#### Annala-Räsänen column three row two
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row2.png" width="1000">

#### Annala-Räsänen column three row two
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row3.png" width="1000">

#### Annala-Räsänen column three row four
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row4.png" width="1000">

### Scalar-tensor theory

#### Massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/FierzPauliTheory.png" width="1000">

#### Massive Fierz-Pauli theory 
<img src="xAct/PSALTer/Documentation/English/MassiveGravity.png" width="1000">

#### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/ThirdSickFierzPauliTheory.png" width="1000">

#### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/FirstSickFierzPauliTheory.png" width="1000">

#### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/FourthSickFierzPauliTheory.png" width="1000">

#### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/SecondSickFierzPauliTheory.png" width="1000">

#### Marzo theory 
<img src="xAct/PSALTer/Documentation/English/MarzoTheory.png" width="1000">

#### Sick massive Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/SickMassiveGravity.png" width="1000">

#### Scalar-Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/ScalarFierzPauliTheory.png" width="1000">

#### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/SpecialLambda1.png" width="1000">

#### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/SpecialLambda2.png" width="1000">

#### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/SpecialLambda3.png" width="1000">

#### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/GeneralLambda1.png" width="1000">

#### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/GeneralLambda2.png" width="1000">

#### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/GeneralLambda3.png" width="1000">

### Scalar theory

#### Massive Klein-Gordon theory 
<img src="xAct/PSALTer/Documentation/English/MassiveScalarTheory.png" width="1000">

#### Massless Klein-Gordon theory 
<img src="xAct/PSALTer/Documentation/English/MasslessScalarTheory.png" width="1000">

### Vector theory

#### Longitudinal massless vector
<img src="xAct/PSALTer/Documentation/English/LongitudinalMassless.png" width="1000">

#### Maxwell theory 
<img src="xAct/PSALTer/Documentation/English/MaxwellTheory.png" width="1000">

#### Proca theory
<img src="xAct/PSALTer/Documentation/English/ProcaTheory.png" width="1000">

#### Sick Maxwell theory
<img src="xAct/PSALTer/Documentation/English/SickMaxwellTheory.png" width="1000">

#### Sick Proca theory
<img src="xAct/PSALTer/Documentation/English/SickProcaTheory.png" width="1000">

#### Longitudinal massive vector
<img src="xAct/PSALTer/Documentation/English/LongitudinalMassive.png" width="1000">

### Poincaré gauge theory

#### Einstein-Cartan theory 
<img src="xAct/PSALTer/Documentation/English/EinsteinCartanTheory.png" width="1000">

#### General Poincaré gauge theory
<img src="xAct/PSALTer/Documentation/English/GeneralPGT.png" width="1000">

#### General relativity 
<img src="xAct/PSALTer/Documentation/English/GeneralRelativity.png" width="1000">

#### Poincaré gauge theory with massless even scalar
<img src="xAct/PSALTer/Documentation/English/MinimalEvenScalar.png" width="1000">

#### Poincaré gauge theory with massive odd scalar
<img src="xAct/PSALTer/Documentation/English/MinimalMassiveOddScalar.png" width="1000">

#### Poincaré gauge theory with massless odd scalar
<img src="xAct/PSALTer/Documentation/English/MinimalMasslessOddScalar.png" width="1000">

#### Melichev-Percacci theory 
<img src="xAct/PSALTer/Documentation/English/MelichevPercacciTheory.png" width="1000">

#### Annala-Räsänen column four 
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenColumn4.png" width="1000">

#### Lin-Hobson-Lasenby case 1
<img src="xAct/PSALTer/Documentation/English/Case1.png" width="1000">

#### Lin-Hobson-Lasenby case 2
<img src="xAct/PSALTer/Documentation/English/Case2.png" width="1000">

#### Lin-Hobson-Lasenby case 3
<img src="xAct/PSALTer/Documentation/English/Case3.png" width="1000">

#### Lin-Hobson-Lasenby case 4
<img src="xAct/PSALTer/Documentation/English/Case4.png" width="1000">

#### Lin-Hobson-Lasenby case 6
<img src="xAct/PSALTer/Documentation/English/Case6.png" width="1000">

#### Lin-Hobson-Lasenby case 7
<img src="xAct/PSALTer/Documentation/English/Case7.png" width="1000">

#### Lin-Hobson-Lasenby case 8
<img src="xAct/PSALTer/Documentation/English/Case8.png" width="1000">

#### Lin-Hobson-Lasenby case 9
<img src="xAct/PSALTer/Documentation/English/Case9.png" width="1000">

#### Lin-Hobson-Lasenby case 10
<img src="xAct/PSALTer/Documentation/English/Case10.png" width="1000">

#### Lin-Hobson-Lasenby case 12
<img src="xAct/PSALTer/Documentation/English/Case11.png" width="1000">

#### Lin-Hobson-Lasenby case 13
<img src="xAct/PSALTer/Documentation/English/Case12.png" width="1000">

#### Lin-Hobson-Lasenby case 13
<img src="xAct/PSALTer/Documentation/English/Case13.png" width="1000">

#### Lin-Hobson-Lasenby case 14
<img src="xAct/PSALTer/Documentation/English/Case14.png" width="1000">

#### Lin-Hobson-Lasenby case 15
<img src="xAct/PSALTer/Documentation/English/Case15.png" width="1000">

#### Lin-Hobson-Lasenby case 16
<img src="xAct/PSALTer/Documentation/English/Case16.png" width="1000">

#### Lin-Hobson-Lasenby case 17
<img src="xAct/PSALTer/Documentation/English/Case17.png" width="1000">

#### Lin-Hobson-Lasenby case 18
<img src="xAct/PSALTer/Documentation/English/Case18.png" width="1000">

#### Lin-Hobson-Lasenby case 19
<img src="xAct/PSALTer/Documentation/English/Case19.png" width="1000">

#### Lin-Hobson-Lasenby case 20
<img src="xAct/PSALTer/Documentation/English/Case20.png" width="1000">

#### Lin-Hobson-Lasenby case 21
<img src="xAct/PSALTer/Documentation/English/Case21.png" width="1000">

#### Lin-Hobson-Lasenby case 22
<img src="xAct/PSALTer/Documentation/English/Case22.png" width="1000">

#### Lin-Hobson-Lasenby case 23
<img src="xAct/PSALTer/Documentation/English/Case23.png" width="1000">

#### Lin-Hobson-Lasenby case 24
<img src="xAct/PSALTer/Documentation/English/Case24.png" width="1000">

#### Lin-Hobson-Lasenby case 25
<img src="xAct/PSALTer/Documentation/English/Case25.png" width="1000">

#### Lin-Hobson-Lasenby case 26
<img src="xAct/PSALTer/Documentation/English/Case26.png" width="1000">

#### Lin-Hobson-Lasenby case 27
<img src="xAct/PSALTer/Documentation/English/Case27.png" width="1000">

#### Lin-Hobson-Lasenby case 28
<img src="xAct/PSALTer/Documentation/English/Case28.png" width="1000">

#### Lin-Hobson-Lasenby case 29
<img src="xAct/PSALTer/Documentation/English/Case29.png" width="1000">

#### Lin-Hobson-Lasenby case 30
<img src="xAct/PSALTer/Documentation/English/Case30.png" width="1000">

#### Lin-Hobson-Lasenby case 31
<img src="xAct/PSALTer/Documentation/English/Case31.png" width="1000">

#### Lin-Hobson-Lasenby case 32
<img src="xAct/PSALTer/Documentation/English/Case32.png" width="1000">

#### Lin-Hobson-Lasenby case 33
<img src="xAct/PSALTer/Documentation/English/Case33.png" width="1000">

#### Lin-Hobson-Lasenby case 34
<img src="xAct/PSALTer/Documentation/English/Case34.png" width="1000">

#### Lin-Hobson-Lasenby case 35
<img src="xAct/PSALTer/Documentation/English/Case35.png" width="1000">

#### Lin-Hobson-Lasenby case 36
<img src="xAct/PSALTer/Documentation/English/Case36.png" width="1000">

#### Lin-Hobson-Lasenby case 37
<img src="xAct/PSALTer/Documentation/English/Case37.png" width="1000">

#### Lin-Hobson-Lasenby case 38
<img src="xAct/PSALTer/Documentation/English/Case38.png" width="1000">

#### Lin-Hobson-Lasenby case 39
<img src="xAct/PSALTer/Documentation/English/Case39.png" width="1000">

#### Lin-Hobson-Lasenby case 40
<img src="xAct/PSALTer/Documentation/English/Case40.png" width="1000">

#### Lin-Hobson-Lasenby case 41
<img src="xAct/PSALTer/Documentation/English/Case41.png" width="1000">

#### Lin-Hobson-Lasenby case 42
<img src="xAct/PSALTer/Documentation/English/Case42.png" width="1000">

#### Lin-Hobson-Lasenby case 43
<img src="xAct/PSALTer/Documentation/English/Case43.png" width="1000">

#### Lin-Hobson-Lasenby case 44
<img src="xAct/PSALTer/Documentation/English/Case44.png" width="1000">

#### Lin-Hobson-Lasenby case 45
<img src="xAct/PSALTer/Documentation/English/Case45.png" width="1000">

#### Lin-Hobson-Lasenby case 46
<img src="xAct/PSALTer/Documentation/English/Case46.png" width="1000">

#### Lin-Hobson-Lasenby case 47
<img src="xAct/PSALTer/Documentation/English/Case47.png" width="1000">

#### Lin-Hobson-Lasenby case 48
<img src="xAct/PSALTer/Documentation/English/Case48.png" width="1000">

#### Lin-Hobson-Lasenby case 49
<img src="xAct/PSALTer/Documentation/English/Case49.png" width="1000">

#### Lin-Hobson-Lasenby case 50
<img src="xAct/PSALTer/Documentation/English/Case50.png" width="1000">

#### Lin-Hobson-Lasenby case 51
<img src="xAct/PSALTer/Documentation/English/Case51.png" width="1000">

#### Lin-Hobson-Lasenby case 52
<img src="xAct/PSALTer/Documentation/English/Case52.png" width="1000">

#### Lin-Hobson-Lasenby case 53
<img src="xAct/PSALTer/Documentation/English/Case53.png" width="1000">

#### Lin-Hobson-Lasenby case 54
<img src="xAct/PSALTer/Documentation/English/Case54.png" width="1000">

#### Lin-Hobson-Lasenby case 55
<img src="xAct/PSALTer/Documentation/English/Case55.png" width="1000">

#### Lin-Hobson-Lasenby case 56
<img src="xAct/PSALTer/Documentation/English/Case56.png" width="1000">

#### Lin-Hobson-Lasenby case 57
<img src="xAct/PSALTer/Documentation/English/Case57.png" width="1000">

#### Lin-Hobson-Lasenby case 58
<img src="xAct/PSALTer/Documentation/English/Case58.png" width="1000">

#### Lin-Hobson-Lasenby case 59
<img src="xAct/PSALTer/Documentation/English/Case5.png" width="1000">
