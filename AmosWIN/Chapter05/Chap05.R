# ver1.1 # 2016 09 23
### ----- 第5章 ----- ###

## 由于软件版本和作品版权等问题，本节中的部分内容不便汉化，敬请谅解。
## 各位读者可以通过从本书中学习到的思路，使用适当的软件版本
## （如MeCab-Chinese、“结巴”中文分词的R语言版本等）和中文语料进行实践
##
## MeCab-Chinese                   https://github.com/panyang/MeCab-Chinese
## “结巴”中文分词的R语言版本       https://github.com/qinwf/jiebaR/
##                                                           ——译者注

# 在安装RMeCab前需要先安装MeCab
# 安装时可以参考https://sites.google.com/site/rmecab/home/install
# 或http://taku910.github.io/mecab/（这两个网站只有日文版）
# 在Windows下安装时，进入到选择词典字符集（Dictionary Charset）的步骤后，建议选择默认选项的“SHIFT-JIS”

# 为了能在网络图（书中图05-04）中正常显示日文，需要使用本书为读者专门准备的设置文件
# 在控制台输入下述命令并敲击Enter，即可完成设置文件的下载和保存
# source("http://rmecab.jp/R/Rprofile.R")
# 如果想查看该文件的内容，可以将引号中的URL直接输入浏览器打开
#
# 注意，其实该命令只是把http://rmecab.jp/R/dot.Rprofile.txt的内容以.Rprofile格式放在了用户根目录（C:\用户\用户名）下
# 若正在使用自定义的.Rprofile文件，请各位事先做好该文件的备份
# 另外，需要重启R或RStudio，才能使该设置生效


# Code05-01（P.173 05-02）
# =======================

# 安装MeCab与R联动的RMeCab
install.packages("RMeCab", repos = "http://rmecab.jp/R")

# 加载RMeCab，为后面的使用做准备
library(RMeCab)

# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

# 读取《奔跑吧梅勒斯》全文并进行词素分析
# 从解析结果中抽取出名词、形容词和动词
m <- NgramDF("melos.txt", type = 1, pos = c("名詞", "形容詞", "動詞"))

# 在Windows下的RStudio中（使用Github时）执行上面的代码后，会出现如下警告信息
# Warning message:
#  In grepl("\n", lines, fixed = TRUE) :
#  input string 1 is invalid in this locale]
# 该警告信息不会影响之后的处理，忽略即可

library (dplyr)

nrow(m) #若使用管道处理，可写为 m %>% nrow

# 数据量较大，只显示开头部分
# 若输出的是乱码，可改用View(head(m))查看
head(m) # m %>% head

# 筛选出使用频率达到一定程度的词汇（这里筛选了使用次数超过2次的词汇）
m.df <- m %>% filter(Freq > 2)

# 安装并加载绘制网络图的程序包
install.packages("igraph")
library(igraph)

# 将词汇的关联网络化
m.g <- graph.data.frame(m.df)
E(m.g)$weight <- m.df[,3]

# 绘制网络图（会弹出另一窗口）
tkplot(m.g, vertex.label = V(m.g)$name, edge.label = E(m.g)$weight , vertex.size = 23, vertex.color = "SkyBlue")

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# Code05-02（P.175 05-03）
# =======================

# 对比森鸥外和夏目漱石的写作习惯
# 文件夹literature中保存着森鸥外和夏目漱石的共计8部作品（均为日文）
# 分析文字之间的接续情况（需花费数秒）
m <- docNgram ("literature", type = 0)

# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

# 缺省列名时会直接使用文件名，所以改为更直观的名称
colnames (m) <- c("欧外1", "欧外2", "欧外3", "欧外4", "漱石1", "漱石2", "漱石3", "漱石4")

# 现阶段m中存有海量信息。这里仅筛选出8种助词与逗号的组合
m <- m [ rownames(m) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]", "[に-、]", "[ら-、]", "[も-、]" ) , ]

# 为了得到与书中相同的结果，在中文Windows下需将行名先按五十音图排序
m <- m[order(rownames(m)), ]

# 查看筛选出的数据（8行8列）
# 若输出的是乱码，可改用View(m)查看
m

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# Code05-03（P.176 05-03）
# =======================

# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

# 将“で、”与“が、”的频数制成散点图
dega <- data.frame(が = m[1,] ,で = m[3,], 作家 = c("欧外", "欧外", "欧外", "欧外", "漱石", "漱石", "漱石", "漱石"))

# 若输出的是乱码，可改用View(dega)查看
dega

library(ggplot2)
dega %>% ggplot(aes(x = が, y = で, group=作家) ) + geom_point(aes(shape = 作家), size = 6) + scale_shape(solid = FALSE)

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# Code05-04（P.177 05-03）
# =======================

# 分析加入了4部太宰治作品的文件夹
m2 <- docNgram ("taizai", type = 0)

# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

colnames(m2) <- c("太宰1","太宰2","太宰3","太宰4",
"欧外1","欧外2","欧外3","欧外4",
"漱石1","漱石2","漱石3","漱石4")

m2 <- m2 [ rownames(m2) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]",  "[に-、]",  "[ら-、]",  "[も-、]" ) ,  ]

# 为了得到与书中相同的结果，在中文Windows下需将行名先按五十音图排序
m2 <- m2[ order(rownames(m2)), ]

dega2 <- data.frame(が = m2[1,], で = m2[3,],
作家 = c("太宰","太宰","太宰","太宰",
"欧外","欧外","欧外","欧外",
"漱石","漱石","漱石","漱石"))

# 若输出的是乱码，可改用View(dega2)查看
dega2

library(ggplot2)
dega2 %>% ggplot(aes(x = が, y = で, group = 作家)) + geom_point(aes(shape = 作家), size = 6) + scale_shape_manual(values = c(21, 15, 24))

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# Code05-05（P.178 05-03）
# =======================

# 主成分分析
# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

# 在管道处理的中间加一个t函数，将数据横过来（即行列互换）
m2.pca <- m2 %>% t %>% prcomp

m2.pca %>% biplot (cex = 1.8) # cex = 1.8这个值可以调整文字大小

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# Code05-06（P.178 05-03）
# =======================

# 显示用主成分分析压缩信息后的结果
# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

# 若输出的是乱码，可改用View(round(m2.pca[[2]], 2))查看
round (m2.pca[[2]], 2)

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# Code05-07（P.187 05-05）
# =======================

# 安装用于抓取网页的程序包rvest，并加载
install.packages("rvest")
library(rvest)
library(dplyr)

# 获取花札的维基百科页面，耗时约2秒
wiki <- read_html("https://zh.wikipedia.org/wiki/%E8%8A%B1%E6%9C%AD")
# 若使用的是老版本的rvest，则要改用
# wiki <- html("https://zh.wikipedia.org/wiki/%E8%8A%B1%E6%9C%AD")

# 若因网络原因无法访问维基百科，可改用
# wiki <- read_html("花札-Wikipedia-zh.html")
# 读取当前目录下事先下载好的花札的维基百科页面

huazha <- wiki %>% html_nodes("table") %>% .[[5]] %>% html_nodes("td") %>% html_text()
dim(huazha) <- c(6,12)
huazha %>% t %>% as.table


# Code05-08（P.193 05-05）
# =======================

# 分析口碑数据
# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")

reviewsdata <- read.csv("reviewsdata.csv", row.name = 1)

reviewsdata %>% head


# Code05-09（P.194 05-05）
# =======================

# 绘制系统树图
reviews.clus <- reviewsdata %>% t %>% dist %>% hclust

# 根据执行结果生成图表
reviews.clus %>% plot

# 使用专用程序包绘制系统树图
install.packages("ggdendro")
library("ggdendro")
library(ggplot2)
reviews.clus %>% ggdendrogram(rotate = FALSE,size = 20) + labs(title= "口碑的聚类") + xlab ("聚类") + ylab("相似度") + theme_bw(base_size = 18)


# Code05-10（P.195 05-05）
# =======================

# 对应分析
reviews.cor <- reviewsdata %>% MASS::corresp(nf = 2)

reviews.cor %>% biplot(cex = 1.6) # cex = 1.6这个值可以调整文字大小


# 05-04（P.182）
# =============

# 临时将当前语言改为日语
Sys.setlocale("LC_ALL", "JPN")

# 加载投诉邮件与留言的数据（日文）
comment <- read.csv("mb.csv", row.name = 1)
# comment <- read.csv(file.choose(), row.name = 1)

# 若输出的是乱码，可改用View(comment)查看
comment

# 主成分分析
blog <- comment %>% prcomp

# 用biplot把blog做成双标图
blog %>% biplot (cex = 1.2)

# 将当前语言还原为中文
Sys.setlocale("LC_ALL", "CHS")


# 对应分析（P.201）
# ================

# 欧美人的发色和瞳色数据
HairEyeColor

# 取出女性的发色和瞳色数据
HE <- matrix(HairEyeColor[17:32], nrow = 4, ncol = 4, byrow = FALSE,
             dimnames = (list(头发 = c("黑", "茶", "红", "金"), 瞳孔 = c("茶", "蓝", "棕", "绿"))))
HE

# 进行对应分析
HEca <- HE %>% MASS::corresp(nf = 2)

# 绘制双标图
HEca %>% biplot
