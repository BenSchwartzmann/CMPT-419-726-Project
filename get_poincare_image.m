function image = get_poincare_image(a)

image=zeros(30,30);

for i=1:size(a,1)-1
image(min(round(30*(a(i))),30),min(round(30*a((i+1))),30))=1;
end