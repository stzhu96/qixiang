
library(openxlsx)
#########################################################################计算平均值
# 读取数据集
data <- read.xlsx("F:\\因变量\\10V\\2014年10V\\2014年10V.xlsx")
#str(data)
# 将数据集拆分成每24行一组
grouped_data <- split(data, rep(1:ceiling(nrow(data)/24), each = 24, length.out = nrow(data)))

# 计算每组的平均值
group_means <- lapply(grouped_data, function(group) {
  col_means <- colMeans(group, na.rm = TRUE)  # 每列的平均值
  col_means[is.nan(col_means)] <- NA  # 将NaN替换为NA
  col_means
})

# 合并每个组的平均值为一个数据框
result_table <- do.call(rbind, group_means)
str(result_table)

# 导出结果表格为CSV文件;
write.csv(result_table, file = "F:\\因变量\\10V\\2014年10V\\2014年10V平均值.csv", row.names = FALSE)