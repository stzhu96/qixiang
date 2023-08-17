# 安装和加载所需的包
#install.packages("raster")
#install.packages("openxlsx")
library(raster)
library(openxlsx)

# 设置文件夹路径
folder_path <- "G:\\小论文气象数据\\10V\\2014年10V"

# 获取文件夹中所有.tif文件的路径
file_paths <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)

# 设置待提取像素值的点坐标
points <- data.frame(x = c(118.00977, 117.97811, 117.93071, 117.954285, 117.97915, 117.63846, 117.596535, 117.57363, 117.49741, 117.59658, 117.601715, 117.72821, 117.75909, 118.084595, 118.105835, 118.09272, 118.11137, 118.12838),
                     y = c(37.36603, 37.368343, 37.393974, 37.38433, 37.394554, 37.767365, 37.73119, 37.50009, 37.49463, 37.644337, 37.632206, 36.882324, 36.85312, 37.694946, 37.695988, 37.699238, 37.135174, 37.144512))

# 创建一个空的数据框用于存储结果
result_df <- data.frame()

# 循环处理每个.tif文件
for (file_path in file_paths) {
  # 读取.tif文件
  raster_data <- raster(file_path)
  
  # 获取.tif文件名称
  file_name <- tools::file_path_sans_ext(basename(file_path))
  
  # 提取点的像素值
  values <- extract(raster_data, points)
  
  # 创建数据框来存储当前文件的结果
  file_result <- data.frame(t(values))
  
  # 添加列名（点的坐标）
  colnames(file_result) <- paste("Point", seq_len(ncol(file_result)), sep = "_")
  
  # 添加行名（文件名称）
  rownames(file_result) <- file_name
  
  # 将当前文件的结果添加到总体结果数据框
  result_df <- rbind(result_df, file_result)
}

# 打印结果
#print(result_df)
head(result_df)
View(result_df)
# 将结果保存为xlsx文件
write.xlsx(result_df, file = "F:\\因变量\\10V\\2014年10V\\2014年10V.xlsx")
