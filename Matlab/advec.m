%Copyright &copy; 2010 to 2016. Hugo Fernando Maia Milan (hugofernando@gmail.com).

function [ADSB, ADNO, ADCON] = advec(Zterx, Ztery, Zter, Z2c, ...
    Gter, Tempin, emis, diaanimal, Kter, nnosx, nnosy)
global dimenmalha ent dl fluxosext
ADSB = 0;
ADNO = 0;
ADCON = 0;
if fluxosext(1,1) ~= 0
    if dimenmalha == 1
        vff = 1;
        ADSB = zeros(1,1);
        ADNO = zeros(1,1);
        ADCON = zeros(1,3);
        for qfl = 1:size(fluxosext,1)
            for a = 1:size(ent,2)
                if ent(1,a) == fluxosext(qfl,3)
                    ADSB(vff,1) = ceil(a/nnosx);
                    ADNO(vff,1) = (a-(ceil(a/nnosx)-1)*nnosx);
                    ADCON(vff,3) = Tempin(fluxosext(qfl,2)); %Temperatura
                    ADCON(vff,4) = fluxosext(qfl,3);
                    ADCON(vff,1) = convadvuni(Zter, Gter, Kter, diaanimal, ADCON(vff,3), fluxosext(qfl,2), fluxosext(qfl,3)); %convecção
                    ADCON(vff,2) = radadvuni(Zter, Gter, dl, emis, fluxosext(qfl,2), fluxosext(qfl,3)); %radiação
                    vff = vff + 1;
                end
            end
        end
    elseif dimenmalha == 2
        vff = 1;
        ADSB = zeros(1,2);
        ADNO = zeros(1,2);
        ADCON = zeros(1,3);
        for qfl = 1:size(fluxosext,1)
            for a = 1:size(ent,1)
                for b = 1:size(ent,2)
                if ent(a,b) == fluxosext(qfl,3)
                    ADSB(vff,:) = [ceil(a/nnosy) ceil(b/nnosx)];
                    ADNO(vff,:) = [(a-(ceil(a/nnosy)-1)*nnosy) (b-(ceil(b/nnosx)-1)*nnosx)];
                    ADCON(vff,3) = Tempin(fluxosext(qfl,2)); %Temperatura
                    ADCON(vff,1) = convadvbi(Zterx, Ztery, Z2c, Kter, diaanimal, fluxosext(qfl,2), fluxosext(qfl,3)); %convecção
                    ADCON(vff,2) = radadvbi(Zterx, Ztery, Z2c, dl, emis, 1, fluxosext(qfl,2), fluxosext(qfl,3)); %radiação
                    vff = vff + 1;
                end
                end
            end
        end
    end
end
