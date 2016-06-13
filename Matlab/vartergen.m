function [Tbster] = vartergen (mt, malha, Tbster, nsdy, nsdx, Tbterdk, sw1, sw2)

for bp = 1:nsdx*nsdy
    if bp == 1
        
        %|x|-|-|
        %|_|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            %lado esquerdo
            Tbster{bp}(xx,1) = Tbterdk{bp}(xx,1,2) + Tbterdk{bp}(xx,1,1)*malha{bp}{xx,1}(mt,2);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %verrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = Tbterdk{bp}(1,xx,2) + Tbterdk{bp}(1,xx,1)*malha{bp}{1,xx}(mt,3);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = Tbterdk{bp}(2,2,2) + Tbterdk{bp}(2,2,1)*malha{bp}{1,1}(mt,3);
        %canto direito superior
        Tbster{bp}(2,end-1) = Tbterdk{bp}(2,end-1,2) + Tbterdk{bp}(2,end-1,1)*malha{bp}{1,end}(mt,3);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
    elseif bp < nsdy
        
        %|-|-|-|
        %|x|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            
            %lado esquerdo
            Tbster{bp}(xx,1) = Tbterdk{bp}(xx,1,2) + Tbterdk{bp}(xx,1,1)*malha{bp}{xx,1}(mt,2);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %varrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
    elseif bp == nsdy
        
        %|-|-|-|
        %|_|_|_|
        %|x|_|_|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            
            %lado esquerdo
            Tbster{bp}(xx,1) = Tbterdk{bp}(xx,1,2) + Tbterdk{bp}(xx,1,1)*malha{bp}{xx,1}(mt,2);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %varrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbster{bp}(end,xx) = Tbterdk{bp}(end,xx,2) + Tbterdk{bp}(end,xx,1)*malha{bp}{end,xx}(mt,1);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = Tbterdk{bp}(end-1,2,2) + Tbterdk{bp}(end-1,2,1)*malha{bp}{end,1}(mt,1);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = Tbterdk{bp}(end-1,end-1,2) + Tbterdk{bp}(end-1,end-1,1)*malha{bp}{end,end}(mt,1);
        
    elseif any(bp == sw1)
        
        %|-|x|-|
        %|_|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %varrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = Tbterdk{bp}(1,xx,2) + Tbterdk{bp}(1,xx,1)*malha{bp}{1,xx}(mt,3);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = Tbterdk{bp}(2,2,2) + Tbterdk{bp}(2,2,1)*malha{bp}{1,1}(mt,3);
        %canto direito superior
        Tbster{bp}(2,end-1) = Tbterdk{bp}(2,end-1,2) + Tbterdk{bp}(2,end-1,1)*malha{bp}{1,end}(mt,3);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        
    elseif any(bp == sw2)
        
        %|-|-|-|
        %|_|_|_|
        %|_|x|_|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %varrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbster{bp}(end,xx) = Tbterdk{bp}(end,xx,2) + Tbterdk{bp}(end,xx,1)*malha{bp}{end,xx}(mt,1);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = Tbterdk{bp}(end-1,2,2) + Tbterdk{bp}(end-1,2,1)*malha{bp}{end,1}(mt,1);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = Tbterdk{bp}(end-1,end-1,2) + Tbterdk{bp}(end-1,end-1,1)*malha{bp}{end,end}(mt,1);
        
    elseif bp == (nsdy*(nsdx-1) + 1)
        
        %|-|-|x|
        %|_|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbster{bp}(xx,end) = Tbterdk{bp}(xx,end,2) + Tbterdk{bp}(xx,end,1)*malha{bp}{xx,end}(mt,4);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %varrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = Tbterdk{bp}(1,xx,2) + Tbterdk{bp}(1,xx,1)*malha{bp}{1,xx}(mt,3);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = Tbterdk{bp}(2,2,2) + Tbterdk{bp}(2,2,1)*malha{bp}{1,1}(mt,3);
        %canto direito superior
        Tbster{bp}(2,end-1) = Tbterdk{bp}(2,end-1,2) + Tbterdk{bp}(2,end-1,1)*malha{bp}{1,end}(mt,3);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        
    elseif bp > (nsdy*(nsdx-1) + 1) && bp ~= nsdx*nsdy
        
        %|-|-|-|
        %|_|_|x|
        %|_|_|_|
        
        for xx = 1:size(Tbster{bp},1)
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbster{bp}(xx,end) = Tbterdk{bp}(xx,end,2) + Tbterdk{bp}(xx,end,1)*malha{bp}{xx,end}(mt,4);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1)
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        
        
        
    elseif bp == nsdy*nsdx
        
        %|-|-|-|
        %|_|_|_|
        %|_|_|x|
        
        for xx = 1:size(Tbster{bp},1) %varrendo y
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbster{bp}(xx,end) = Tbterdk{bp}(xx,end,2) + Tbterdk{bp}(xx,end,1)*malha{bp}{xx,end}(mt,4);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1) %varrendo x
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbster{bp}(end,xx) = Tbterdk{bp}(end,xx,2) + Tbterdk{bp}(end,xx,1)*malha{bp}{end,xx}(mt,1);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = Tbterdk{bp}(end-1,2,2) + Tbterdk{bp}(end-1,2,1)*malha{bp}{end,1}(mt,1);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = Tbterdk{bp}(end-1,end-1,2) + Tbterdk{bp}(end-1,end-1,1)*malha{bp}{end,end}(mt,1);
        
    else
        %|-|-|-|
        %|_|x|_|
        %|_|_|_|
        
        for xx = 1:size(Tbster{bp},1)
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
        end
        
        for xx = 2:(size(Tbster{bp},2)-1)
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
        end
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
    end
end
end