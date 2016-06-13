function coerefl = reflfrontuni(meio, Rter, Zter, meiofron)

coerefl = (Rter(meio) + Rter(meiofron) - Zter(meio) + Zter(meiofron))/(...
    Rter(meio) + Rter(meiofron) + Zter(meio) + Zter(meiofron));

end
                   