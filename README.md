# SimEMTher
Transmission-line matrix simulator. Solver with graphical interface for 2D electromagnetism scattering and temperature propagation (see below).

Copyright &copy; 2010 to 2016. Hugo Fernando Maia Milan.

I developed this software in Matlab years ago (2010 to 2014) and I did not work on it since then. However, considering that code for TLM is scarce, I decided to upload it as it is (or better, as "it was"). I choose to release it under the GNU GPL v3 license but I may change it. However, what I will not change is to keep this software open-source and free for research/education. If you have any concern, please fell free to contact me.

A discussion about SimEMTher was published in Milan et al. (2012). Then, I used it in Milan et al. (2014) and Maia et al. (2014). I had programmed it to solve the electromagnetism scattering for 2D TM and TE modes and the temperature propagation in biological tissues (if you are looking for TLM to solve the bioheat equation, it will be better to use <a href=https://github.com/hugomilan/tlmbht>tlmbht</a>). Below is a simplified instruction on how to run it.

The software runs on top of matlab. Run tlm.m to start it.

The first screen that appears is the home screen. Select the dimension that you want to simulate. After, go to input mesh, and select the number of nodes, the size of each node and click on generate the mesh. Then, go to characteristics editor, select the type of fields to simulate (electromagnetic and thermal), input the characteristics of the medium and add how much mediums you want. Make sure that, when using EM in 2D, the propagation mode (TM or TE) is selected. Input the characteristics of the mesh and finally edit the boundaries of the simulation. To EM there are boundaries based in the reflection coefficient.

After the creation and edition of the mesh, return to the initial screen, select the number of time-steps you want to simulate and how much time-steps you want to skip to save a point, i.e. if you have selected 1000 time-steps and 10, at each 10 time-steps the software will save a point.

Go to the source and input the energy's sources.

Remeber to save the mesh after creation in File->Save. You can save it in any place, and respectively, you can load from any place. After saving, go to simulate and run to solve your problem. When the simulations are finished, the software will save three types of files: malhasav.mat; todas.mat; resuln.mat. The file todas.mat is to visualize the final results (contain variables about time-steps, size...); malhasav.mat save the final time-step simulated by the software (so that it can continue later on); resuln.mat contain the results of simulation, where n is a natural number. At each time you simulate, the software will replace this three files in the folder that the software is. Remeber to cut and past this three files in different places to preserve your data.

Suppose that you have a simulation that you want to continue. You can use the check box "Load Previous Result" in the GUI Simulate. Then, the software will reload the file malhasav.mat and will continue the simulation with the data in malhasav.mat as initial values.

Finally, to view the results, go to Results. To show the results, the software will reload todas.mat and resuln.mat. So, this files must be in the folder of the software.

<b>Known limitations and (possible) future works</b>

First of all, I don't have an explicitly desire to keep working on that. You can do that if you want to (and maybe I get excitated about the idea). Below are some points from the top of my head that have to be improved on SimEMTher.

&bull; The internal code is commented in Portuguese (sorry).

&bull; Matlab is known to help in rapid prototyping but kind of slower than other languages.

&bull; Saving and loading is odd.

&bull; The only geometry that the solver solves is the one that it creates. It should be able to read more advanced geometries from Gmsh (at least).

&bull; The nodes for EM are 2D and rectangular. It should use more advanced formulations, like the triangular node from Sewell (Sewell et al., 2004ab).

&bull; There is no EM 3D.

&bull; General programming revision for speed up and parallelization.


<b>Acknowledgment</b>

Brazilian National Counsel of Technological and Scientific Development (CNPq) and University of Rondonia (UNIR) for (institutional research assistant) scholarship to HFMM.


<b>References</b>

Christopoulos, C., 1995. The Transmission Line Modeling Method. IEEE Press.

Christopoulos, C., 2006. The Transmission Line Modeling (TLM) Method in Electromagnetics. Morgan & Claypool.

Maia ASC, Milan HFM, Gebremedhin KG. Analytical and numerical modeling of skin surface temperature in livestock. 20th International Congress of Biometeorology, Cleveland - OH, 2014.

Milan HFM, Carvalho Jr CAT, Egoavil CJ, Watanabe CYV, Oliveira CHL, da Silva RM. Thermal-electromagnetic coupled system simulator using transmission-line matrix (TLM). WAP 2(1):60-68, 2012. http://waprogramming.com/index.php?action=journal&page=showpaper&jid=1&iid=6&pid=57

Milan, H.F.M., Carvalho Jr., C.A.T., Maia, A.S.C., Gebremedhin, K.G., 2014. Graded meshes in bio-thermal problems with transmission-line modeling method. J. Therm. Biol. 45,43-53.

Sewell, P., Wykes, J., Benson, T., Christopoulos, C., Thomas, D.W.P., Vukovic, A., 2004a. Transmission-line modeling using unstructured triangular meshes. IEEE T. Microw. Theory Tech. 52, 1490-1497.

Sewell, P., Wykes, J.G., Benson, T., Thomas, D.W.P., Vukovic, A., Christopoulos, C., 2004b. Transmission line modelling using unstructured meshes. IEE Proc.-Sci. Meas. Technol. 151, 445-448.
