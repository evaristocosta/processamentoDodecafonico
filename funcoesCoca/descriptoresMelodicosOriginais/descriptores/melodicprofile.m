function [mp_asc,mp_dsc,mp_const] = melodicprofile(x)
[asc,dsc,const]=discriminterv(x);

mp_asc=length(asc)/(length(x)-1);
mp_dsc=length(dsc)/(length(x)-1);
mp_const=length(const)/(length(x)-1);


