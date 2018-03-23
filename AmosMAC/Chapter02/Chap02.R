# vers. 1.0
### ----- 第2章 ----- ###

# 加载数据（P.88）
# ===============

# 加载面包重量的数据（breads.csv）并将其命名为breads
breads <- read.csv(file="/home/vivoadmin/mycode/myrstudio/codebookcainiao/AmosMAC/Chapter02/breads.csv")

# 另外，按下述方法执行会弹出文件对话框，我们可以从中选取数据文件（breads.csv）
breads <- read.csv (file.choose())


# Code02-01（P.71 02-06）
# ======================

install.packages("ggplot2")         # 安装程序包
library (ggplot2)                   # 使用前先加载程序包

# 通过以下命令实际绘制图表
ggplot (breads, aes(x = weight)) + geom_histogram(binwidth = 10, fill = "steelblue", colour="black",  alpha = 0.5) + xlab("面包的重量") + ylab ("个数") + ggtitle("面包数据的直方图")  + xlim(360, 420) + theme(text = element_text(family = "Heiti SC Light"))
# 若图中的汉字无法正常显示，可通过“ + theme(text = element_text(family = "Heiti SC Light"))”指定汉字的字体


# t.test函数（P.89）
# =================

# 执行t检验（均值差异检验）的函数
# mu = 400表示总体均值定为400（克）
t.test (breads$weight, mu = 400)


# Code02-02（P.75 02-08）
# ======================

# 用replicate函数执行100000次“掷100个（次）骰子的实验”，并将结果以res为名称保存
res <- replicate(100000, mean (sample(1:6, 100, replace = TRUE)))

# 简单的直方图
hist(res)

# 生成更精致的直方图
library(ggplot2)

dice <- data.frame(骰子 = res)
head(dice)

ggplot(dice, aes (x = 骰子)) + geom_histogram(aes(y = ..density..),binwidth = .1, fill = "steelblue", colour = "black", alpha = 0.5) + xlab("期望值") + ylab ("") + ggtitle("骰子平均值的平均值") + stat_function(geom="line", fun = dnorm, args=list(mean = mean (dice$骰子), sd = sd (dice$骰子))) + theme(text = element_text(family = "Heiti SC Light"))
# stat_function函数的作用是向直方图中添加正态分布的吊钟型曲线


# 02-01（P.59）
# ============

# RStudio的四则运算
1 + 2
2 * 3 * 4  # 2×3×4
8 / 4 / 2  # 计算8÷4÷2

# 1到10的整数
1:10

# 求1到10的整数的总和
sum (1:10)

# 求平均值
mean (1:10)


# 02-05（P.71）
# ============

# 从对话框中选择文件“Chapter02\breads.csv”
breads <- read.csv (file.choose())

# 或者也可以直接指定文件名，但要注意文件的存放位置
# breads <- read.csv("breads.csv")

# 只显示头几行数据
head (breads)

# 平均值
mean (breads$weight)

# 求标准差的函数
# $为分隔符，格式为“数据名$列名”
sd (breads$weight)


# 02-08（P.76）
# ============

# 正态分布（以骰子的期望值为例）
mean(sample(1:6, 10, replace = TRUE))


# 02-10（P.80）
# ============

# 均值差异检验（t检验）
t.test(breads$weight, mu = 400)

