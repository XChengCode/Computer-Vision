function result = plot_match( matches,img1,img2 )

[H,W]=size(img1);
img3=[img1,img2];

A=size(matches,1);

figure
imshow(img3);title('matches','FontSize',20);
hold on;
for i=1:A
    plot([matches(i,4),matches(i,2)],[matches(i,3),matches(i,1)],'rx','LineWidth',1.5,'LineStyle','-','Color',[rand(),rand(),rand()]);
end

end

