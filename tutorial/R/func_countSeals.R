
require(EBImage)

#countSeals returns a mask layer that contains labels for each voronoi space
#img1 = the image that is being used
#level = scalar for image lighting

countSeals<- function(img1, level, os_val){   
  # blur the image
	colorMode(img1) = Grayscale
	
	#Thresholding
	nmask = thresh(img1, w=70, h=70, offset= os_val)
	
	#Fill shape
	nmask = opening(nmask*level, makeBrush(11, shape='Gaussian'))
	nmask = fillHull(nmask)
	
	#Segmentation
	nmask = bwlabel(nmask)
	display(nmask)

	#Mask
	ctmask = opening(img1, makeBrush(11, shape='Gaussian'))
	cmask = propagate(img1, seeds=nmask, mask=ctmask)
	
	#Draw Voronoi spaces 
	segmented = paintObjects(cmask, img1, col='#FFFFFF')

 
 	#Display spaces mask
  	display(segmented, all=TRUE)
  	  	cat('# of candidate seals in this image =', max(bwlabel(nmask)),'\n')

  #Return mask
  return(cmask)
}

