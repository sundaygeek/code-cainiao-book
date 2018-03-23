# vers. 1.0
### ----- 第3章 ----- ###

# chisq.test函数（P.118）
# ======================

survey <- read.csv("survey.csv")
# 或者用file.choose()代替文件名，从对话框里选择对应文件
survey <- read.csv (file.choose())

install.packages ("dplyr")
library (dplyr)
survey %>% head # 等同于head (survey)

# 卡方检验
# 验证零假设“店主与顾客的回答是独立的”
survey  %>% select (立场, 回答6) %>% table %>% chisq.test


# Code03-01（P.108 03-06）
# =======================

# 选择“立场”和“回答6”这2列制成列联表
table1 <- survey  %>% select (立场, 回答6) %>% table
table1

# 生成条形图
library(ggplot2)
table1 %>% as.data.frame %>% ggplot(aes (x = 立场, y = Freq, fill = 回答6 )) + geom_bar(stat="identity") + ylab("人数") #+ scale_fill_grey(start = 0.4, end = 0.8)
# 加上scale_fill_grey函数即可绘制出黑白的条形图

# 不使用管道运算符%>%也能绘制出同样的图
# ggplot(as.data.frame (table1), aes (x = 立场, y = Freq, fill = 回答6 )) + geom_bar(stat="identity") + ylab("人数")

# 实际上，用下面的命令就可以绘制出简单的条形图
table1 %>% plot # 也可以写成plot (table1)


# 03-04（P.101~103）
# =================

# 将数据制成列联表
dat <- read.csv("sample.csv") # 输入dat<- read.csv(file.choose())则可以通过对话框指定sample.csv
dat

# 生成列联表
table (dat)

# 安装用于进行管道处理的程序包（有关如何安装程序包请参考书后的《番外篇》）
install.packages ("dplyr")

# 声明使用dplyr程序包
library (dplyr)

# 使用管道运算符
# 用左边的数据生成表
dat %>% table

# 保存列联表，命名为dat2
dat2 <- dat %>% table
dat2


# 03-05（P.104）
# =============

# 执行卡方检验
chisq.test (dat2)

# 用管道运算符也能得到相同的结果
dat2 %>% chisq.test


# 03-07（P.112）
# ============

# 选择“立场”和“回答7”这2列制成列联表
survey %>% select (立场, 回答7)  %>% table

