#导入必要的R包
library(raster)
library(ncdf4)
library(rasterVis)
library(lattice)
#导入长时间序列NC格式数据
ncfile<-nc_open("G:\\小论文气象数据\\2014年10V.nc")
#查看变量名
names(ncfile$var)
input_file <- "G:\\小论文气象数据\\2014年10V.nc"
varname <- "v10"

# 读取数据为RasterBrick对象
raster_brick <- brick(input_file, varname = varname)
layer_names <- names(raster_brick)

for (i in 1:length(layer_names)) {
  file_name <- paste0("G:\\小论文气象数据\\10V\\2014年10V\\", layer_names[i], ".tif")
  writeRaster(raster_brick[[i]], filename = file_name)
}