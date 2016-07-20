
#trainerMaker
##Description: Function to take a spectral analysis mask, cut out parts of mask, and allow user to tag images. Results: (1) new folders based on multiple choice options, (2) square image cut out for each mask and saved as a jpeg in native resolution, (3) a dataset in wide format following user-specified dimensions

##Parameters:
#image = input image
#mask = result of countSeal
#number_samples = # of samples to be validated


cookiecutter <- function(image, mask, number_samples,image_name){
	
	print("setup")
	#Libraries
		require(svDialogs)
		require(EBImage)
		rotate <- function(x) t(apply(x, 2, rev))
		
	#Set up file
		mask_index <- mask@.Data[,,1]
	   	a <- min(mask_index)
		 b <- max(mask_index)
	    ints <- round((b - a)/number_samples)
	
	#Loop through images
	
		for(k in seq(a,b, ints)){
			
			print(k)
			
			#Subset image
				test <- which(mask_index ==k, arr.ind = T)
				
		 #Bounding box
			min_row<-min(test[,1])
			max_row<-max(test[,1])
	
			min_col<-min(test[,2])
			max_col<-max(test[,2])
	
		 #Initial size calculation
			size_row <- max_row - min_row
			size_col <- max_col - min_col
			dims <- dim(image)		
		
			#Show image and prompt input
				print(k)
				
			#Display image and save, route to the right folder
				temp_slice<-image[min_row:(min_row+min(size_col,size_row)), 
									min_col:(min_col+min(size_col,size_row)),]
				writeImage(temp_slice, paste(getwd(),"/",image_name,"_",k,".jpg",sep=""), quality = 100)
			
		 
	print("done")
		}
}

