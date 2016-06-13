function [Tbster Tbterdk] = vunitergen (mt, malha, Tbster, nsdx, Tbterdk)

bp = 1;

%|x|-|-|

    %lado esquerdo
    Tbster(bp,1) = Tbterdk(1,2) + Tbterdk(1,1)*malha{bp}{1}(mt,1);
    
    Tbterdk(1,2) = (Tbterdk(1,6) - Tbterdk(1,5)*Tbterdk(1,2)/Tbterdk(1,3) - Tbterdk(1,4)*malha{bp}{1}(mt,1))*Tbterdk(1,3);
   
    %lado direito
    Tbster(bp,2) = malha{bp+1}{1}(mt,1);
    
    


bp = nsdx;

%|_|_|x|

%lado esquerdo
Tbster(bp,1) = malha{bp-1}{end}(mt,2);

%lado direito
Tbster(bp,2) = Tbterdk(2,2) + Tbterdk(2,1)*malha{bp}{end}(mt,2);

Tbterdk(2,2) = (Tbterdk(2,6) - Tbterdk(2,5)*Tbterdk(2,2)/Tbterdk(2,3) - Tbterdk(2,4)*malha{bp}{end}(mt,2))*Tbterdk(2,3);

for bp = 2:(nsdx-1)
    
    %|_|x|_|
    
    %lado esquerdo
    Tbster(bp,1) = malha{bp-1}{end}(mt,2);
    
    %lado direito
    Tbster(bp,2) = malha{bp+1}{1}(mt,1);
    
    
end
end