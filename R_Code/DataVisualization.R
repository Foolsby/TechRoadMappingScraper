setwd("/Users/fleminggoolsby/PycharmProjects/TechRoadmappingScraper/Data/")
MturkServices = read.csv("MturkServices.csv", stringsAsFactors = FALSE)
EtsyProducts = read.csv("EtsyProducts.csv", stringsAsFactors = FALSE)
AmazonProducts = read.csv("AmazonProducts_Final.csv", stringsAsFactors = FALSE)
Ebay_data = read.csv("EbayData.csv", stringsAsFactors = FALSE)

# M Turk Plots
MturkServices$Reward = as.numeric(sub(".","",MturkServices$Reward))
MturkServices$HITs = as.numeric(gsub("[\\$,]", "",MturkServices$HITs))
jpeg('../Results/M Turk - Histogram of Payment Amounts from MTurk.jpg',width = 1920/2 , height = 1080/2, quality = 100)
hist(MturkServices$Reward,
     main="Histogram of Payment Amounts from MTurk", 
     xlab="Payment [$]", 
     border="black", 
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     col="blue",breaks=50)
dev.off()
jpeg('../Results/M Turk - Payment Amounts Vs HITs.jpg',width = 1920/2 , height = 1080/2, quality = 100)
plot(MturkServices$Reward,MturkServices$HITs,
     main="Payment Amounts Vs. HITs", 
     ylab = "HITs [#]",
     ylim = c(0,50000),
     xlab="Payment [$]",
     col="black",
     bg="blue",
     pch = 24,
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     lwd=1)
dev.off()

# Etsy Plots
EtsyProducts$Ratings = as.numeric(gsub("[\\$,()]", "",EtsyProducts$Ratings))
EtsyProducts$Price = as.numeric(gsub("[\\$,+]", "",EtsyProducts$Price))
jpeg('../Results/Etsy - Histogram of Amount of Ratings.jpg',width = 1920/2 , height = 1080/2, quality = 100)
hist(EtsyProducts$Ratings,
     main="Histogram of Amount of Ratings", 
     xlab="Amount of Ratings [#]", 
     ylim=c(0,20),
     xlim = c(0,50000),
     border="black", 
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     col="green",breaks=50)
dev.off()
jpeg('../Results/Etsy - Amount of Ratings Vs Product Price.jpg',width = 1920/2 , height = 1080/2, quality = 100)
plot(EtsyProducts$Ratings,EtsyProducts$Price,
     main="Amount of Ratings Vs. Product Price ", 
     ylab = "Product Price [$]",
     ylim = c(0,100),
     xlab="Amount of Ratings [#]",
     col="black",
     bg="green",
     pch = 24,
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     lwd=1)
dev.off()

# Amazon Plots
AmazonProducts$Ratings = as.numeric(gsub("[ratings,]", "",AmazonProducts$Ratings))
AmazonProducts$Questions_Answered = as.numeric(gsub("[answered questions]", "",AmazonProducts$Questions_Answered))
AmazonProducts$Current_Price = as.numeric(gsub("[\\$,]", "",AmazonProducts$Current_Price))

combined_idxs = which(is.na(AmazonProducts$Ratings) | is.na(AmazonProducts$Questions_Answered))
Ratings = AmazonProducts$Ratings[-which(is.na(AmazonProducts$Ratings))]
Ratings_Limited = AmazonProducts$Ratings[-c(combined_idxs)]
Questions_Answered = AmazonProducts$Questions_Answered[-which(is.na(AmazonProducts$Questions_Answered))]
Questions_Answered_Limited = AmazonProducts$Questions_Answered[-c(combined_idxs)]

jpeg('../Results/Amazon - Histogram of Amount of Ratings.jpg',width = 1920/2 , height = 1080/2, quality = 100)
hist(Ratings,
     main="Histogram of Amount of Ratings", 
     xlab="Amount of Ratings [#]", 
     ylim=c(0,35),
     xlim = c(0,7000),
     border="black", 
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     col="red",breaks=50)
dev.off()

jpeg('../Results/Amazon - Amount of Ratings Vs Questions Answered.jpg',width = 1920/2 , height = 1080/2, quality = 100)
plot(Ratings_Limited,Questions_Answered_Limited,
     main="Amount of Ratings Vs. Questions Answered by Seller ", 
     ylab = "Questions Answered by Seller [#]",
     ylim = c(0,40),
     xlab="Amount of Ratings [#]",
     col="black",
     xlim = c(0,300),
     bg="red",
     pch = 24,
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     lwd=1)
dev.off()

combined_idxs = which(is.na(AmazonProducts$Ratings) | is.na(AmazonProducts$Current_Price))
Ratings_Limited = AmazonProducts$Ratings[-c(combined_idxs)]
Current_Price_Limited = AmazonProducts$Current_Price[-c(combined_idxs)]

jpeg('../Results/Amazon - Amount of Ratings Vs Product Price.jpg',width = 1920/2 , height = 1080/2, quality = 100)
plot(Ratings_Limited,Current_Price_Limited,
     main="Amount of Ratings Vs. Product Price ", 
     ylab = "Product Price [$]",
     xlab="Amount of Ratings [#]",
     col="black",
     bg="red",
     pch = 24,
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     lwd=1)
dev.off()



# Ebay Plots
Ebay_data$Watchers..Normalized. = as.numeric(Ebay_data$Watchers..Normalized.)
Ebay_data$Inventory..Approx.... = as.numeric(gsub("[\\$,]", "",Ebay_data$Inventory..Approx....))

idxs = which(is.na(Ebay_data$Inventory..Approx....) | Ebay_data$Inventory..Approx.... == 0)
WatchersNorm = Ebay_data$Watchers..Normalized[-c(idxs)]
InventoryApprox = Ebay_data$Inventory..Approx....[-c(idxs)]
idxs = which(Ebay_data$Sale.Auction.Duration..Mins. == 0)
AuctionDuration = Ebay_data$Sale.Auction.Duration..Mins.[-c(idxs)]
WatchersNormDuration = Ebay_data$Watchers..Normalized[-c(idxs)]

jpeg('../Results/Ebay - Histogram of Watchers on Ebay Auctions.jpg',width = 1920/2 , height = 1080/2, quality = 100)
hist(WatchersNorm,
     main="Histogram of Watchers on Ebay Auctions", 
     xlab="Watchers [Normalized]", 
     border="black", 
     ylim = c(0,25),
     xlim = c(0,3000),
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     col="yellow",breaks=50)
dev.off()

jpeg('../Results/Ebay - Histogram of Invetory on Ebay Auctions.jpg',width = 1920/2 , height = 1080/2, quality = 100)
hist(InventoryApprox,
     main="Histogram of Invetory on Ebay Auctions", 
     xlab="Inventory [#]", 
     border="black", 
     ylim = c(0,35),
     xlim = c(0,8000),
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     col="yellow",breaks=50)
dev.off()

jpeg('../Results/Ebay - Watchers Vs Inventory Remaining.jpg',width = 1920/2 , height = 1080/2, quality = 100)
plot(WatchersNorm,InventoryApprox,
     main= "Watchers Vs. Inventory Remaining", 
     ylab = "Inventory Remaining [#]",
     xlab="Watchers [Normalized]",
     col="black",
     bg="yellow",
     pch = 24,
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     lwd=1)
dev.off()

jpeg('../Results/Ebay - Auction Duraction Vs Watchers.jpg',width = 1920/2 , height = 1080/2, quality = 100)
plot(AuctionDuration, WatchersNormDuration,
     main= "Auction Duraction Vs. Watchers", 
     ylab = "Watchers [Normalized]",
     xlab="Auction Duration [mins]",
     col="black",
     bg="yellow",
     pch = 24,
     cex = 2,
     cex.main=2,
     cex.lab=1.4,
     lwd=1)
dev.off()






