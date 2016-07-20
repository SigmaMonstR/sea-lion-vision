#Mech Turk
#Use binary segmentation to identify candidate seal locations in a photo
#Cut out photos into a folder, then manually sort out

###Set Directories
  base <- "/Users/sigmamonstr/Github/noaa_seals/tutorial"
  
  source_img_dir <- "/images"
  code_dir <- "/R"
  
  target_folder <- "/target_folder"
  dest_dir <- paste(base,target_folder,sep="")


###Set Libraries
  library(EBImage)
  source(paste(code_dir,"func_countSeals.R",sep="/"))
  source(paste(code_dir,"func_cookiecutter.R",sep="/"))

###MASKING
#Get data
setwd(paste(base,source_img_dir,sep=""))

datasets = list.files(pattern="*.jpg")

for(z in 1:length(datasets)){
  setwd(source_img_dir)  

#Read in image
  seals <- readImage(datasets[z])
  display(seals)
  
#Create mask(image, levels_adjustment, offset or threshold of image)
  masked <- countSeals(seals, 0.5,0.2) 

###USER-BASED CANDIDATE SEAL SCREENING
#Set target directory
  setwd(dest_dir)

#Run training set builder
  cookiecutter(seals,masked,max(masked),datasets[z])

}
