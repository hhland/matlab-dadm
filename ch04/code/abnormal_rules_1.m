function [ flag ] = abnormal_rules_1( sale )

if sale >400 && sale <5000 || isnan(sale)
   flag=true;
   return ;
end
flag =false;

end

