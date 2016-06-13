# SimEMTher
Transmission-line matrix simulator. Solver with graphical interface for 2D electromagnetism scattering and temperature propagation (see below).

Copyright &copy; 2010 to 2016. Hugo Fernando Maia Milan (hugofernando@gmail.com).

I developed this software in Matlab years ago (2010 to 2012) and I did not work on it since then. However, considering that code for TLM is scarce, I decided to upload it as it is (or better, as "it was"). It uses GNU GPL v3 so, feel free to modify and use it.

A discussion about SimEMTher was published in Milan et al. (2012). Then, I used it in Milan et al. (2014) and Maia et al. (2014). I had programmed it to solve the electromagnetism scattering for 2D TM and TE modes and the temperature propagation in biological tissues (if you are looking for TLM to solve the bioheat equation, it will be better to use https://github.com/hugomilan/tlmbht). Below is a simplified instruction on how to run it.



The software is to run directly. Below is some instructions. Please, if there are any think that you can't to do or want to do to improve the software, don't hesitate to contact to me.

The first screen that appears is the home screen. Select the dimensional that you want to simulate. Latter, go to input mesh, select the number of nodes, the size of each node and generate the mesh. After, go to characteristics editor, select the type of fields to simulate (electromagnetic and thermal), input the characteristics of the medium and add how much mediums you want. Make sure that (when using EM in 2D) is selected the propagation of EM (TM or TE).
Input the characteristics of the mesh and finally edit the boundaries of the simulation. To EM there are boundaries based in the reflection coefficient. To thermal, there are the same and boundaries to conduction.

After the creation and edition of the mesh, return to the initial screen, select the number of time-steps you want to simulate and how much time-steps you want to pass to save a point, i.e. if you has been selected 1000 time-steps and 10, at each 10 time-steps the software will save a point.

Go to the source and input the energy's sources.

Be careful in saving the mesh after prepared (this will save your time) in File->Save. You can save in any place of your computer, and respectively, you can load from any place. So, go to simulate and run to solve your problem. When the simulations are finished, the software will save three types of files: malhasav.mat; todas.mat; resuln.mat; The file todas.mat is to visualize the end results (contain variables about time-steps, size...); malhasav.mat save the end time-step simulated by the software; resuln.mat contain the results of simulation, where n is a natural number. At each time you simulate, the software will replace this three files in the folder that the software is. Take careful in cutting and past this three files in different places to preserve your data.

Suppose that you has been simulate an medium and want to continue this simulation. You can use the check box "Load Previous Result" in the GUI Simulate. To do so, the software will reload the file malhasav.mat and will continue the simulation with the data in malhasav.mat as initial values.

Finally, to view the results, go to Results. To process the results, the software will reload todas.mat and resuln.mat. So, this files must be steady at the folder of the software.

When using thermal propagation, don't care if you are using Kelvin or Celsius.


<b>References</b>

Maia ASC, Milan HFM, Gebremedhin KG. Analytical and numerical modeling of skin surface temperature in livestock. 20th International Congress of Biometeorology, Cleveland - OH, 2014.

Milan HFM, Carvalho Jr CAT, Egoavil CJ, Watanabe CYV, Oliveira CHL, da Silva RM. Thermal-electromagnetic coupled system simulator using transmission-line matrix (TLM). WAP 2(1):60-68, 2012. http://waprogramming.com/index.php?action=journal&page=showpaper&jid=1&iid=6&pid=57

Milan, H.F.M., Carvalho Jr., C.A.T., Maia, A.S.C., Gebremedhin, K.G., 2014. Graded meshes in bio-thermal problems with transmission-line modeling method. J. Therm. Biol. 45,43-53.
