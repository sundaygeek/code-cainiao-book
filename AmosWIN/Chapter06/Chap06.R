# vers. 1.1 # 2016 09 23
### ----- 第6章 ----- ###

# Code06-01（P.212 06-03）
# =======================

# 加载小太郎家的失窃数额数据
xiaotailang <- read.csv("xiaotailang.csv", colClasses = c("numeric", "factor", "Date", "factor", "factor"))

# 安装便于处理时间序列数据的程序包
install.packages("xts")
library(xts)

# 给数据设置日期
library(dplyr)
lostD <- seq(as.Date("2014-10-1"), as.Date("2015-5-30"), by = "days")
lost <- xts(xiaotailang$数额, order.by = lostD, dateFormat = "Date")

lost %>% plot(type = "l", main = "失窃数额")

# 可以通过“major.format”参数来调整横轴上的日期格式，如
# lost %>% plot(type = "l", main = "失窃数额", major.format = "%m %d\n%Y")
# 关于日期格式，可参考https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html


# Code06-02（P.213 06-03）
# =======================

# 限定时间段的时间序列图
lost[1:31] %>% plot ( type = "l",main = "失窃数额（10月）", family = "sans")
# 可以通过“family”参数来调整图中文字的字体


# Code06-03（P.216 06-04）
# =======================

# 绘制自相关图分析周期性
# 判断数据是否以2周为1个周期
lost %>% acf


# Code06-04（P.219~220 06-04）
# ===========================

# 安装添加月历图时所需的openair程序包
install.packages("openair")

# 另外，在安装的过程中若提示
# “There are binary versions available but the source versions are later”
# Do you want to install from sources the package which needs compilation? y/n:，
# （源代码编译版本比现有二进制版本的版本高，是否希望从源代码编译安装程序包）
# 选择n（否）即可
library(openair)

calendarPlot(xiaotailang, pollutant = "数额", year = c("2014"))
calendarPlot(xiaotailang, pollutant = "数额", year = c("2015"))
# 在中文Windows下，图中日期下方的“星期几”只会保留第一个字，即会显示为
# “星 星 星 星 星 星 星”，难以区分某一天到底是星期几。可以通过执行
# Sys.setlocale("LC_TIME", "English")
# 或
# Sys.setlocale("LC_TIME", "Japanese")
# 改用英文或日文的日期格式，以便于查看


# 06-05（P.222）
# =============

# 调整“周几”这一列，将周日设为一周的第一天
xiaotailang$周几 <- factor(xiaotailang$周几, levels = c("周日", "周一", "周二", "周三", "周四", "周五", "周六"))
levels(xiaotailang$周几 )

# 逻辑回归分析
xiaotailang.glm <- xiaotailang %>% glm (损失 ~ 周几 + 活动日, data = ., family = binomial)

xiaotailang.glm %>% summary


# 06-06（P.223）
# =============

# 优势比
xiaotailang.glm$coefficients %>% exp %>% round(2)


# 06-07（P.226）
# =============

# 加载统计美国新生儿体重、母亲体重以及母亲吸烟习惯的数据
load("birthwt.rda") # 或者写成load(file.choose())，从对话框中选择文件
head(birthwt)

bw.glm <- birthwt %>% glm(low ~ age + lwt + race + smoke + ptl + ht + ui + ftv, data = .,family = binomial)
# bw.glm <- glm(low ~ age + lwt + race + smoke + ptl + ht + ui + ftv, data = birthwt,family = binomial)

bw.glm %>% summary
# summary (bw.glm)

# 计算优势比
bw.glm$coefficients %>% exp %>% round(2)

