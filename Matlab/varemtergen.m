function [Tbs, Tbster] = varemtergen (mt, malha, Tbs, Tbster, nsdy, nsdx, ...
    Tbdk, Tbterdk, sw1, sw2)

for bp = 1:nsdx*nsdy
    if bp == 1
        
        %|x|-|-|
        %|_|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = Tbdk{bp}(xx,1)*malha{bp}{xx,1}(mt,2);
            
            %lado direito
            Tbs{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = Tbterdk{bp}(xx,1,2) + Tbterdk{bp}(xx,1,1)*malha{bp}{xx,1}(mt,7);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,7);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %verrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = Tbdk{bp}(1,xx)*malha{bp}{1,xx}(mt,3);
            
            %lado inferior
            Tbs{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
            %lado superior
            Tbster{bp}(1,xx) = Tbterdk{bp}(1,xx,2) + Tbterdk{bp}(1,xx,1)*malha{bp}{1,xx}(mt,8);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,8);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = Tbdk{bp}(2,2)*malha{bp}{1,1}(mt,3);
        %canto direito superior
        Tbs{bp}(2,end-1) = Tbdk{bp}(2,end-1)*malha{bp}{1,end}(mt,3);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = Tbterdk{bp}(2,2,2) + Tbterdk{bp}(2,2,1)*malha{bp}{1,1}(mt,8);
        %canto direito superior
        Tbster{bp}(2,end-1) = Tbterdk{bp}(2,end-1,2) + Tbterdk{bp}(2,end-1,1)*malha{bp}{1,end}(mt,8);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,8);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,8);
        
    elseif bp < nsdy
        
        %|-|-|-|
        %|x|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = Tbdk{bp}(xx,1)*malha{bp}{xx,1}(mt,2);
            
            %lado direito
            Tbs{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = Tbterdk{bp}(xx,1,2) + Tbterdk{bp}(xx,1,1)*malha{bp}{xx,1}(mt,7);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,7);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %varrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbs{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,6);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,8);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbs{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,6);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,6);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,8);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,8);
        
    elseif bp == nsdy
        
        %|-|-|-|
        %|_|_|_|
        %|x|_|_|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = Tbdk{bp}(xx,1)*malha{bp}{xx,1}(mt,2);
            
            %lado direito
            Tbs{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = Tbterdk{bp}(xx,1,2) + Tbterdk{bp}(xx,1,1)*malha{bp}{xx,1}(mt,7);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,7);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %varrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbs{bp}(end,xx) = Tbdk{bp}(end,xx)*malha{bp}{end,xx}(mt,1);
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,6);
            
            %lado inferior
            Tbster{bp}(end,xx) = Tbterdk{bp}(end,xx,2) + Tbterdk{bp}(end,xx,1)*malha{bp}{end,xx}(mt,6);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbs{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = Tbdk{bp}(end-1,2)*malha{bp}{end,1}(mt,1);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = Tbdk{bp}(end-1,end-1)*malha{bp}{end,end}(mt,1);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,6);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,6);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = Tbterdk{bp}(end-1,2,2) + Tbterdk{bp}(end-1,2,1)*malha{bp}{end,1}(mt,6);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = Tbterdk{bp}(end-1,end-1,2) + Tbterdk{bp}(end-1,end-1,1)*malha{bp}{end,end}(mt,6);
        
    elseif any(bp == sw1)
        
        %|-|x|-|
        %|_|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbs{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,9);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,7);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %varrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = Tbdk{bp}(1,xx)*malha{bp}{1,xx}(mt,3);
            
            %lado inferior
            Tbs{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
            %lado superior
            Tbster{bp}(1,xx) = Tbterdk{bp}(1,xx,2) + Tbterdk{bp}(1,xx,1)*malha{bp}{1,xx}(mt,8);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,8);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = Tbdk{bp}(2,2)*malha{bp}{1,1}(mt,3);
        %canto direito superior
        Tbs{bp}(2,end-1) = Tbdk{bp}(2,end-1)*malha{bp}{1,end}(mt,3);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = Tbterdk{bp}(2,2,2) + Tbterdk{bp}(2,2,1)*malha{bp}{1,1}(mt,8);
        %canto direito superior
        Tbster{bp}(2,end-1) = Tbterdk{bp}(2,end-1,2) + Tbterdk{bp}(2,end-1,1)*malha{bp}{1,end}(mt,8);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,8);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,8);
        
        
    elseif any(bp == sw2)
        
        %|-|-|-|
        %|_|_|_|
        %|_|x|_|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbs{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,9);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,7);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %varrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbs{bp}(end,xx) = Tbdk{bp}(end,xx)*malha{bp}{end,xx}(mt,1);
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,6);
            
            %lado inferior
            Tbster{bp}(end,xx) = Tbterdk{bp}(end,xx,2) + Tbterdk{bp}(end,xx,1)*malha{bp}{end,xx}(mt,6);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbs{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = Tbdk{bp}(end-1,2)*malha{bp}{end,1}(mt,1);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = Tbdk{bp}(end-1,end-1)*malha{bp}{end,end}(mt,1);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,6);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,6);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = Tbterdk{bp}(end-1,2,2) + Tbterdk{bp}(end-1,2,1)*malha{bp}{end,1}(mt,6);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = Tbterdk{bp}(end-1,end-1,2) + Tbterdk{bp}(end-1,end-1,1)*malha{bp}{end,end}(mt,6);
        
    elseif bp == (nsdy*(nsdx-1) + 1)
        
        %|-|-|x|
        %|_|_|_|
        %|_|_|_|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbs{bp}(xx,end) = Tbdk{bp}(xx,end)*malha{bp}{xx,end}(mt,4);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,9);
            
            %lado direito
            Tbster{bp}(xx,end) = Tbterdk{bp}(xx,end,2) + Tbterdk{bp}(xx,end,1)*malha{bp}{xx,end}(mt,9);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %varrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = Tbdk{bp}(1,xx)*malha{bp}{1,xx}(mt,3);
            
            %lado inferior
            Tbs{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
            %lado superior
            Tbster{bp}(1,xx) = Tbterdk{bp}(1,xx,2) + Tbterdk{bp}(1,xx,1)*malha{bp}{1,xx}(mt,8);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,8);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = Tbdk{bp}(2,2)*malha{bp}{1,1}(mt,3);
        %canto direito superior
        Tbs{bp}(2,end-1) = Tbdk{bp}(2,end-1)*malha{bp}{1,end}(mt,3);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = Tbterdk{bp}(2,2,2) + Tbterdk{bp}(2,2,1)*malha{bp}{1,1}(mt,8);
        %canto direito superior
        Tbster{bp}(2,end-1) = Tbterdk{bp}(2,end-1,2) + Tbterdk{bp}(2,end-1,1)*malha{bp}{1,end}(mt,8);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,8);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,8);
        
        
    elseif bp > (nsdy*(nsdx-1) + 1) && bp ~= nsdx*nsdy
        
        %|-|-|-|
        %|_|_|x|
        %|_|_|_|
        
        for xx = 1:size(Tbs{bp},1)
            
            %lado esquerdo
            Tbs{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbs{bp}(xx,end) = Tbdk{bp}(xx,end)*malha{bp}{xx,end}(mt,4);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,9);
            
            %lado direito
            Tbster{bp}(xx,end) = Tbterdk{bp}(xx,end,2) + Tbterdk{bp}(xx,end,1)*malha{bp}{xx,end}(mt,9);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1)
            
            %lado superior
            Tbs{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbs{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,6);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,8);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbs{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,6);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,6);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,8);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,8);
        
        
        
        
    elseif bp == nsdy*nsdx
        
        %|-|-|-|
        %|_|_|_|
        %|_|_|x|
        
        for xx = 1:size(Tbs{bp},1) %varrendo y
            
            %lado esquerdo
            Tbs{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbs{bp}(xx,end) = Tbdk{bp}(xx,end)*malha{bp}{xx,end}(mt,4);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,9);
            
            %lado direito
            Tbster{bp}(xx,end) = Tbterdk{bp}(xx,end,2) + Tbterdk{bp}(xx,end,1)*malha{bp}{xx,end}(mt,9);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1) %varrendo x
            
            %lado superior
            Tbs{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbs{bp}(end,xx) = Tbdk{bp}(end,xx)*malha{bp}{end,xx}(mt,1);
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,6);
            
            %lado inferior
            Tbster{bp}(end,xx) = Tbterdk{bp}(end,xx,2) + Tbterdk{bp}(end,xx,1)*malha{bp}{end,xx}(mt,6);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbs{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = Tbdk{bp}(end-1,2)*malha{bp}{end,1}(mt,1);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = Tbdk{bp}(end-1,end-1)*malha{bp}{end,end}(mt,1);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,6);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,6);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = Tbterdk{bp}(end-1,2,2) + Tbterdk{bp}(end-1,2,1)*malha{bp}{end,1}(mt,6);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = Tbterdk{bp}(end-1,end-1,2) + Tbterdk{bp}(end-1,end-1,1)*malha{bp}{end,end}(mt,6);
        
    else
        %|-|-|-|
        %|_|x|_|
        %|_|_|_|
        
        for xx = 1:size(Tbs{bp},1)
            
            %lado esquerdo
            Tbs{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,4);
            
            %lado direito
            Tbs{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,2);
            
            %lado esquerdo
            Tbster{bp}(xx,1) = malha{bp-nsdy}{xx,end}(mt,9);
            
            %lado direito
            Tbster{bp}(xx,end) = malha{bp+nsdy}{xx,1}(mt,7);
            
        end
        
        for xx = 2:(size(Tbs{bp},2)-1)
            
            %lado superior
            Tbs{bp}(1,xx) = malha{bp-1}{end,xx}(mt,1);
            
            %lado inferior
            Tbs{bp}(end,xx) = malha{bp+1}{1,xx}(mt,3);
            
            %lado superior
            Tbster{bp}(1,xx) = malha{bp-1}{end,xx}(mt,6);
            
            %lado inferior
            Tbster{bp}(end,xx) = malha{bp+1}{1,xx}(mt,8);
            
        end
        
        %canto esquerdo superior
        Tbs{bp}(2,2) = malha{bp-1}{end,1}(mt,1);
        %canto direito superior
        Tbs{bp}(2,end-1) = malha{bp-1}{end,end}(mt,1);
        %canto esquerdo inferior
        Tbs{bp}(end-1,2) = malha{bp+1}{1,1}(mt,3);
        %canto direito inferior
        Tbs{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,3);
        
        %canto esquerdo superior
        Tbster{bp}(2,2) = malha{bp-1}{end,1}(mt,6);
        %canto direito superior
        Tbster{bp}(2,end-1) = malha{bp-1}{end,end}(mt,6);
        %canto esquerdo inferior
        Tbster{bp}(end-1,2) = malha{bp+1}{1,1}(mt,8);
        %canto direito inferior
        Tbster{bp}(end-1,end-1) = malha{bp+1}{1,end}(mt,8);
        
    end
end