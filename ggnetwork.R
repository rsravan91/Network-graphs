library(network)
library(sna)
library(ggplot2)
library(ggnetwork)

n <- network(rgraph(10, tprob = 0.2), directed = FALSE)

n %v% "family" <- sample(letters[1:3], 10, replace = TRUE)
n %v% "importance" <- sample(1:3, 10, replace = TRUE)

e<-network.edgecount(n)

set.edge.attribute(n,"type",sample(letters[24:26],e,replace = TRUE))
set.edge.attribute(n,"day",sample(1:3,e,replace = TRUE))

ggnetwork(n, layout = "fruchtermanreingold", cell.jitter = 0.75)
ggnetwork(n, layout = "target", niter = 100)

# top of the dataframe contains self loops to force every node to be drawn
head(ggnetwork(n))
# end of the dataframe contains edge attributes
tail(ggnetwork(n))
# total rows in the dataframe is N+E

g<-ggplot(n, aes(x=x,y=y,xend=xend,yend=yend)) # ggplot is intiitalized with matrix above related data
g.e<-g+geom_edges(aes(linetype=type,weights="day"),curvature = 0.3) # draw edges using their attribute, setting curvature helps to produce curved edges
g.e.n<-g.e+geom_nodes(aes(color=family,size=importance)) # draw nodes with attributes
g.e.n.t <- g.e.n+geom_nodetext(aes(label=LETTERS[vertex.names]),fontface="bold") 
g.e.n.t+theme_classic()

# Mapping a color to both a vertex attribute and an edge attribute will create a
# single color scale that incorrectly merges both attributes into one


