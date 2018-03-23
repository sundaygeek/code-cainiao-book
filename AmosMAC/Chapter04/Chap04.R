# ver1.0
### ----- 第4章 ----- ###

# lm函数（P.155）
# ==============

# 加载冰激凌销售量的数据icecream
icecream <- read.csv("/home/vivoadmin/mycode/myrstudio/codebookcainiao/AmosMAC/Chapter04/icecream.csv")

# 给lm函数指定模型并执行，将结果保存为ice.lm
ice.lm <- lm(销售量 ~ 气温, data = icecream)
ice.lm # 求出斜率和截距

# 用管道处理执行该操作
# 请注意data = .部分，这里是用点（.）引用了数据
library(dplyr)
icecream %>% lm(销售量 ~ 气温, data = .)

# 用summary函数求出判定系数以及零假设“斜率为0”的检验结果
summary(ice.lm)


# Code04-01（P.127 04-02）
# ========================

# 加载用于数据操作及绘图的程序包
library(dplyr)
library(ggplot2)

# 假设天羽小姐将樱田先生给的数据整理过后保存在了menus.csv中
# 数据分为“品名”、“日期”和“销售额”3列，类型依次为因子（factor）、日期和数值
# 这里是在加载数据时指定的数据类型（数据加载后也可以指定数据类型）
menus <- read.csv("/home/vivoadmin/mycode/myrstudio/codebookcainiao/AmosMAC/Chapter04/menus.csv", stringsAsFactors = FALSE, colClasses = c("factor", "Date", "numeric"))

# 查看列名
menus %>% names # 与names(menus)相同

# 查看开头部分
menus %>% head # head (menus)

# 筛选出饭团的销售额
fantuan <- menus %>%   filter (品名 == "饭团")

# 时间序列图（用scale_x_date指定）
ggplot(fantuan, aes(日期, 销售额)) + geom_line() +  scale_x_date()  + ggtitle("饭团的销售额") + theme(text = element_text(family = "Heiti SC Light"))
# 若图中的汉字无法正常显示，可通过“ + theme(text = element_text(family = "Heiti SC Light"))”指定汉字的字体
# 可以通过scale_x_date函数的参数来调整横轴上刻度的位置及日期格式
# 该函数的示例及详细信息请参考http://docs.ggplot2.org/current/scale_date.html

# 管道处理也可以用在生成图表上
fantuan %>%ggplot(aes(日期, 销售额)) + geom_line() + scale_x_date()  + ggtitle("饭团的销售额") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-02（P.128 04-02）
# =======================

# 炒饭的销售额
chaofan <- menus %>% filter (品名 == "炒饭")

# 时间序列图
chaofan  %>% ggplot(aes(日期, 销售额)) + geom_line() +  scale_x_date()  + ggtitle("炒饭的销售额") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-03（P.129 04-02）
# ========================

# 筛选出面条
noodles <- menus %>%  filter (品名 %in% c( "意大利面", "酱汁炒面", "乌冬面", "什锦面", "拉面"))

# 时间序列图
noodles %>% ggplot(aes(日期, 销售额)) + geom_line()+ facet_wrap(~品名)  + ggtitle("面条的销售额") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-04（P.131 04-03）
# ========================

# 相关系数
# 导入用于数据整形的程序包
install.packages("tidyr")
library(tidyr)

# 将用来生成相关矩阵的品名列为横轴
noodles2 <- menus %>%  filter (品名 %in% c("饭团", "味噌汤", "咖喱", "茶泡饭", "意大利面", "酱汁炒面", "乌冬面", "什锦面", "拉面")) %>% select (品名, 销售额, 日期) %>% spread(品名, 销售额)

# 查看开头
noodles2 %>% head # head(noodles2)

# 求相关系数（指定-1来忽略日期部分）
noodles2[, -1] %>% cor # cor(noodles2[, -1])

# 也可以写成
noodles2 %>% select (-日期) %>% cor

# 散点图矩阵
noodles2[, -1] %>% pairs #pairs(noodles2[, -1])


# Code04-05（P.131 04-03）
# ========================

# 乌冬面与饭团的散点图
udon <- menus %>% filter (品名 %in% c("饭团", "乌冬面")) %>% spread(品名, 销售额)
udon %>% ggplot(aes(乌冬面, 饭团)) + geom_point() + ggtitle("乌冬面与饭团的散点图") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-06（P.133 04-04）
# ========================

# 饭团与牛奶的散点图
milk <- menus %>%  filter (品名 %in% c("饭团", "牛奶"))  %>% spread(品名, 销售额)
milk %>% ggplot(aes(饭团, 牛奶)) + geom_point(size = 2, color = "grey50")  + geom_smooth(method = "lm", se = FALSE) + ggtitle("饭团与牛奶的散点图") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-07（P.133 04-04）
# ========================

# 牛奶的销售额
milk2 <-menus %>% filter (品名 == "牛奶")
# 时间序列图
milk2 %>% ggplot(aes(日期, 销售额)) + geom_line() + scale_x_date() + ggtitle("牛奶的销售额") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-08（P.140 04-05）
# ========================

# 随便创建一份数据
xy <- data.frame (X = -10:10, Y =  (-10:10)^2)
xy %>% ggplot(aes (x = X, y = Y)) + geom_point(size = 2) + ggtitle("看起来应该具有相关性") + theme(text = element_text(family = "Heiti SC Light"))


# Code04-09（P.144 04-06）
# =======================

# 回归分析
# 加载冰激凌销售量的数据icecream
icecream <- read.csv("/home/vivoadmin/mycode/myrstudio/codebookcainiao/AmosMAC/Chapter04/icecream.csv")
# icecream <- read.csv(file.choose()) # 从对话框中选择文件“Chapter04\icecream.csv”

icecream %>% head # head (icecream)

# 通过lm函数查看斜率与截距
icecream %>% lm(销售量 ~ 气温, data = .) # lm(销售量 ~ 气温, data = icecream)

# 画出气温与销售量的散点图
icecream %>% ggplot(aes(气温, 销售量)) + geom_point(size = 2) + theme(text = element_text(family = "Heiti SC Light"))

# 求相关系数
icecream %>% select(气温, 销售量) %>% cor


# Code04-10（P.147 04-06）
# =======================

# 在冰激凌销售量与气温的散点图中加入回归直线
icecream %>% ggplot(aes(气温, 销售量)) + geom_point(size = 2) + geom_smooth(method = "lm", se = FALSE) + theme(text = element_text(family = "Heiti SC Light"))

# 用summary函数求出判定系数以及零假设“斜率为0”的检验结果
summary (lm(销售量 ~ 气温, data = icecream))
# icecream %>% lm(销售量 ~ 气温, data = .) %>% summary


# 04-05（P.138）
# =============

# 身高与年收入的数据
heights <- read.csv("/home/vivoadmin/mycode/myrstudio/codebookcainiao/AmosMAC/Chapter04/heights.csv")
# heights <- read.csv(file.choose()) # 从对话框中选择文件“Chapter04\heights.csv”

heights %>% cor # cor(heights)

heights %>% ggplot(aes(身高, 年收入)) + geom_point() + ggtitle("身高与年收入的相关性") + theme(text = element_text(family = "Heiti SC Light"))

