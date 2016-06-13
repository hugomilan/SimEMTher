function mostra_tabela(handles)
global simu tabcar coledi colfor colnam colwid rosan cpsan tsan msgflux ...
    idioma Altitude Latitude Ta Tgn VV Dgn

switch simu
    case 1
        
        set(handles.simuemter,'Value',1)
        
        
        set(handles.tabelacar,'data', tabcar)
        set(handles.tabelacar,'ColumnEditable', coledi)
        set(handles.tabelacar,'ColumnFormat', colfor)
        set(handles.tabelacar,'ColumnName', colnam)
        set(handles.tabelacar,'ColumnWidth', colwid)
        
        set(handles.edrosan,'Visible','on')
        set(handles.txtrosan,'Visible','on')
        set(handles.txtvrosan,'Visible','on')
        set(handles.txtvrosan,'string',num2str(rosan))
        
        set(handles.edcpsan,'Visible','on')
        set(handles.txtcpsan,'Visible','on')
        set(handles.txtvcpsan,'Visible','on')
        set(handles.txtvcpsan,'string',num2str(cpsan))
        
        set(handles.edtsan,'Visible','on')
        set(handles.txttsan,'Visible','on')
        set(handles.txtvtsan,'Visible','on')
        set(handles.txtvtsan,'string',num2str(tsan))
        
        set(handles.edAltitude,'Visible','on')
        set(handles.txtAltitude,'Visible','on')
        set(handles.txtvAltitude,'Visible','on')
        set(handles.txtvAltitude,'string',num2str(Altitude))
        
        set(handles.edLatitude,'Visible','on')
        set(handles.txtLatitude,'Visible','on')
        set(handles.txtvLatitude,'Visible','on')
        set(handles.txtvLatitude,'string',num2str(Latitude))
        
        set(handles.edTa,'Visible','on')
        set(handles.txtTa,'Visible','on')
        set(handles.txtvTa,'Visible','on')
        set(handles.txtvTa,'string',num2str(Ta))
        
        set(handles.edTgn,'Visible','on')
        set(handles.txtTgn,'Visible','on')
        set(handles.txtvTgn,'Visible','on')
        set(handles.txtvTgn,'string',num2str(Tgn))
        
        set(handles.edVV,'Visible','on')
        set(handles.txtVV,'Visible','on')
        set(handles.txtvVV,'Visible','on')
        set(handles.txtvVV,'string',num2str(VV))
        
        set(handles.edDgn,'Visible','on')
        set(handles.txtDgn,'Visible','on')
        set(handles.txtvDgn,'Visible','on')
        set(handles.txtvDgn,'string',num2str(Dgn))
        
        set(handles.cbfluxrad,'Visible','on')
        set(handles.cbfluxrad,'Value',0)
        
        set(handles.cbfluxconv,'Visible','on')
        set(handles.cbfluxconv,'Value',0)
        
        set(handles.pupmeiosflux,'Visible','on')
        set(handles.pupmeiosflux,'String',msgflux(:,idioma))
        
        set(handles.txtdtter,'Visible','off')
        set(handles.eddt,'Visible','off')
        
        set(handles.fluxextbtn,'Visible','on')
        
    case 2
        %Somente eletromagnético
        set(handles.simuem,'Value',1)
        
        colfor2 = cell(1,3);
        colfor2{1} = colfor{1};colfor2{2} = colfor{2};
        colfor2{3} = colfor{3};
        
        colnam2 = cell(1,3);
        colnam2{1} = colnam{1};colnam2{2} = colnam{2};
        colnam2{3} = colnam{3};
        
        colwid2 = cell(1,3);
        colwid2{1} = colwid{1};colwid2{2} = colwid{2};
        colwid2{3} = colwid{3};
        
        set(handles.tabelacar,'data', tabcar(:,[1 2 3]))
        set(handles.tabelacar,'ColumnEditable', coledi([1 2 3]))
        set(handles.tabelacar,'ColumnFormat', colfor2)
        set(handles.tabelacar,'ColumnName', colnam2)
        set(handles.tabelacar,'ColumnWidth', colwid2)
        
        set(handles.edrosan,'Visible','off')
        set(handles.txtrosan,'Visible','off')
        set(handles.txtvrosan,'Visible','off')
        
        set(handles.edcpsan,'Visible','off')
        set(handles.txtcpsan,'Visible','off')
        set(handles.txtvcpsan,'Visible','off')
        
        set(handles.edtsan,'Visible','off')
        set(handles.txttsan,'Visible','off')
        set(handles.txtvtsan,'Visible','off')
        
        set(handles.edAltitude,'Visible','off')
        set(handles.txtAltitude,'Visible','off')
        set(handles.txtvAltitude,'Visible','off')
        
        set(handles.edLatitude,'Visible','off')
        set(handles.txtLatitude,'Visible','off')
        set(handles.txtvLatitude,'Visible','off')
        
        set(handles.edTa,'Visible','off')
        set(handles.txtTa,'Visible','off')
        set(handles.txtvTa,'Visible','off')
        
        set(handles.edTgn,'Visible','off')
        set(handles.txtTgn,'Visible','off')
        set(handles.txtvTgn,'Visible','off')
        
        set(handles.edVV,'Visible','off')
        set(handles.txtVV,'Visible','off')
        set(handles.txtvVV,'Visible','off')
        
        set(handles.edDgn,'Visible','off')
        set(handles.txtDgn,'Visible','off')
        set(handles.txtvDgn,'Visible','off')
        
        set(handles.cbfluxrad,'Visible','off')
        set(handles.cbfluxrad,'Value',0)
        
        set(handles.cbfluxconv,'Visible','off')
        set(handles.cbfluxconv,'Value',0)
        
        set(handles.pupmeiosflux,'Visible','off')
        
        set(handles.txtdtter,'Visible','off')
        set(handles.eddt,'Visible','off')
        
        set(handles.fluxextbtn,'Visible','off')
        
    case 3
        set(handles.simuter,'Value',1)
        set(handles.txtdtter,'Visible','on')
        set(handles.eddt,'Visible','on')
        
        
        colfor2 = cell(1,7);
        colfor2{1} = colfor{4};colfor2{2} = colfor{5};
        colfor2{3} = colfor{6};colfor2{4} = colfor{7};
        colfor2{5} = colfor{8};colfor2{6} = colfor{9};
        colfor2{7} = colfor{10};
        
        colnam2 = cell(1,7);
        colnam2{1} = colnam{4};colnam2{2} = colnam{5};
        colnam2{3} = colnam{6};colnam2{4} = colnam{7};
        colnam2{5} = colnam{8};colnam2{6} = colnam{9};
        colnam2{7} = colnam{10};
        
        colwid2 = cell(1,7);
        colwid2{1} = colwid{4};colwid2{2} = colwid{5};
        colwid2{3} = colwid{6};colwid2{4} = colwid{7};
        colwid2{5} = colwid{8};colwid2{6} = colwid{9};
        colwid2{7} = colwid{10};
        
        set(handles.tabelacar,'data', tabcar(:,4:10))
        set(handles.tabelacar,'ColumnEditable', coledi(4:10))
        set(handles.tabelacar,'ColumnFormat', colfor2)
        set(handles.tabelacar,'ColumnName', colnam2)
        set(handles.tabelacar,'ColumnWidth', colwid2)
        
        set(handles.edrosan,'Visible','on')
        set(handles.txtrosan,'Visible','on')
        set(handles.txtvrosan,'Visible','on')
        set(handles.txtvrosan,'string',num2str(rosan))
        
        set(handles.edcpsan,'Visible','on')
        set(handles.txtcpsan,'Visible','on')
        set(handles.txtvcpsan,'Visible','on')
        set(handles.txtvcpsan,'string',num2str(cpsan))
        
        set(handles.edtsan,'Visible','on')
        set(handles.txttsan,'Visible','on')
        set(handles.txtvtsan,'Visible','on')
        set(handles.txtvtsan,'string',num2str(tsan))
        
        set(handles.edAltitude,'Visible','on')
        set(handles.txtAltitude,'Visible','on')
        set(handles.txtvAltitude,'Visible','on')
        set(handles.txtvAltitude,'string',num2str(Altitude))
        
        set(handles.edLatitude,'Visible','on')
        set(handles.txtLatitude,'Visible','on')
        set(handles.txtvLatitude,'Visible','on')
        set(handles.txtvLatitude,'string',num2str(Latitude))
        
        set(handles.edTa,'Visible','on')
        set(handles.txtTa,'Visible','on')
        set(handles.txtvTa,'Visible','on')
        set(handles.txtvTa,'string',num2str(Ta))
        
        set(handles.edTgn,'Visible','on')
        set(handles.txtTgn,'Visible','on')
        set(handles.txtvTgn,'Visible','on')
        set(handles.txtvTgn,'string',num2str(Tgn))
        
        set(handles.edVV,'Visible','on')
        set(handles.txtVV,'Visible','on')
        set(handles.txtvVV,'Visible','on')
        set(handles.txtvVV,'string',num2str(VV))
        
        set(handles.edDgn,'Visible','on')
        set(handles.txtDgn,'Visible','on')
        set(handles.txtvDgn,'Visible','on')
        set(handles.txtvDgn,'string',num2str(Dgn))
        
        set(handles.cbfluxrad,'Visible','on')
        set(handles.cbfluxrad,'Value',0)
        
        set(handles.cbfluxconv,'Visible','on')
        set(handles.cbfluxconv,'Value',0)
        
        set(handles.pupmeiosflux,'Visible','on')
        set(handles.pupmeiosflux,'String',msgflux(:,idioma))
        
        set(handles.txtdtter,'Visible','on')
        set(handles.eddt,'Visible','on')
        
        set(handles.fluxextbtn,'Visible','on')
end