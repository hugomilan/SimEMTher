function convBHE (handles)

global tabcar simu dtTLM dl dimenmalha

if simu ~= 2
    set(handles.txtconvter,'visible','on')
    if dimenmalha == 1
        neta = tabcar(1,4)*tabcar(1,5)/(tabcar(1,6)*dtTLM)*(dl^2);
        for aeta = 2:size(tabcar,1)
            bneta = tabcar(aeta,4)*tabcar(aeta,5)/(tabcar(aeta,6)*dtTLM)*(dl^2);
            if neta > bneta
                neta = bneta;
            end
        end
    elseif dimenmalha == 2
        neta = 100*tabcar(1,4)*tabcar(1,5)/(4*tabcar(1,6)*dtTLM)*(dl^2/2);
        for aeta = 2:size(tabcar,1)
            bneta = 100*tabcar(aeta,4)*tabcar(aeta,5)/(4*tabcar(aeta,6)*dtTLM)*...
                (dl^2/2);
            if neta > bneta
                neta = bneta;
            end
        end
    end
    
    msgconvter = ['n = ',num2str(neta)];
    
    if neta > 1e12
        msgconvter = ['n = ',num2str(neta/1e12) ' T'];
    elseif neta > 1e9
        msgconvter = ['n = ',num2str(neta/1e9) ' G'];
    elseif neta > 1e6
        msgconvter = ['n = ',num2str(neta/1e6) ' M'];
    elseif neta > 1e3
        msgconvter = ['n = ',num2str(neta/1e3) ' k'];
    elseif neta < 1e-3
        msgconvter = ['n = ',num2str(neta/1e-3) ' m'];
    elseif neta < 1e-6
        msgconvter = ['n = ',num2str(neta/1e-6) ' u'];
    elseif neta < 1e-9
        msgconvter = ['n = ',num2str(neta/1e-9) ' p'];
    elseif neta < 1e-12
        msgconvter = ['n = ',num2str(neta/1e-12) ' f'];
    end

    set(handles.txtconvter,'string',msgconvter)
else
    set(handles.txtconvter,'visible','off')
end