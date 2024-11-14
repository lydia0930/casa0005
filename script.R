# 读取世界地图的空间数据
world_map <- st_read("World_Countries_(Generalized)_9029012925078512962.geojson")
# 读取性别不平等指数数据
gender_data <- read.csv("HDR23-24_Composite_indices_complete_time_series.csv")
# 查看世界地图数据的结构
str(world_map)
# 查看性别不平等指数数据的结构
str(gender_data)
# 将 gender_data 中的 iso3 代码转换为 iso2 代码
gender_data$iso2 <- countrycode(gender_data$iso3, "iso3c", "iso2c")
# 合并数据集，使用 ISO 3166-1 alpha-2 代码进行匹配
merged_data <- left_join(world_map, gender_data, by = c("ISO" = "iso2"))
# 查看合并后的数据
head(merged_data)
# 计算2010年与2019年的差异
merged_data$hdi_difference <- merged_data$hdi_2019 - merged_data$hdi_2010
# 查看计算结果
head(merged_data[, c("ISO", "hdi_2010", "hdi_2019", "hdi_difference")])
# 保存更新后的数据为 CSV 文件
write.csv(merged_data, "updated_gender_inequality_data.csv", row.names = FALSE)