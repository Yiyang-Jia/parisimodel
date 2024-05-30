
vec=[1,2,3,0,0,2];
test =0;
for i = 1:length(vec)
if vec(i) ==0
    continue
end
test=test+1;
vec(i) = vec(i) -1;
end
test
vec

%%
vec=[1,2,3,0,0,2];
for i = 1:length(vec)
test =0;
if vec(i)> 0
test=test+1;
vec(i) = vec(i) -1;
end
end
test
vec
%%
vpa(1/3)
aaa =double(vpa(1/3))