# 安装和加载所需的包
if (!require("ed50")) {
  install.packages("ed50")
}
library(ed50)
if (!require("boot")) {
  install.packages("boot")
}
library(boot)

# 剂量
# doseSequence <- c(2.5,2.7,2.9,3.1,3.3,3.1,3.3,3.5,3.3,3.5,3.7,3.5,3.3,3.5,3.7,3.9,3.7,3.5,3.7,3.9,3.7,3.9,3.7,3.5,3.7,3.9,3.7,3.9,3.7,3.5,3.7,3.9,3.7,3.5,3.3,3.5)
# 对应剂量的反应
# responseSequence <- c(0,0,0,0,1,0,0,1,0,0,1,1,0,0,0,1,1,0,0,1,0,1,1,0,0,1,0,1,1,0,0,1,1,1,0,0)
# 创建一个数据框
# groupS <- data.frame(doseSequence = doseSequence, responseSequence = responseSequence)

# 读 CSV 文件
groupS <- read.csv("./pieb.csv", 1, encoding='UTF-8')
print(groupS)

pavaData <- preparePava(groupS)
print(pavaData)

bootResult <- boot(data = groupS,
              statistic = bootIsotonicRegression,
                      R = 2000,
                    sim = "parametric",
                ran.gen = bootIsotonicResample,
                    mle = list(baselinePava = pavaData,
                                  firstDose = 7,
                          PROBABILITY.GAMMA = 0.9),
           baselinePava = pavaData,
      PROBABILITY.GAMMA = 0.9)
print(bootResult)

result = bootBC.ci(tObserved = bootResult$t0[3],
                       tBoot = bootResult$t[, 3],
                        conf = 0.95)
print(result)
