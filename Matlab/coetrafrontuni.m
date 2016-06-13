function coetrans = coetrafrontuni(meio, Rter, Zter, meiofron)
coetrans = 2*(Zter(meio))/...
    (Rter(meio) + Rter(meiofron) + Zter(meio) + Zter(meiofron));
end