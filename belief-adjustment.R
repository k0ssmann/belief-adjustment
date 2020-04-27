# Implementation of the Belief-Adjustment-Model by Hogarth & Einhorn (1992)
# Adrian Kossmann, April 2020
# adrian.kossmann(at)s2015.tu-chemnitz.de
# 
##### Basic usage ##### 
#
# Insert subjective evaluations of evidence in subjective_evidence. However, note that the value range
# depends on the used mode. If applying an evaluation task, elements of subjective_evidence can take values between [-1, 1].
# In estimation tasks elements of subjective_evidence should take values between [0, 1].
# Next, set the initial strength of belief initial_strength, where 0 <= initial_strength <= 1.
# For example, setting initial_strength to 0.5 can be interpreted as a neutral belief in some hypothesis.
# Furthermore, you can change alpha and beta, where 0 <= (alpha, beta) <= 1. Alpha represents the sensitivity
# to negative evidence, beta the sensitivity to positive evidence. For example, beta = 0 and alpha = 1 represents the position
# of the skeptic who is highly sensitive to negative evidence but ignores positive evidence. Beta = 1 and alpha = 0
# represents the advocate who ignores negative evidence but is highly sensitive to positive evidence.
# Finally, select the mode (evaluation or estimation) and the process (Step-by-Step, or End-of-Sequence).
# However, Estimation mode x End-of-Sequence process is not possible and will result in an error message.
#
##### Model parameters #####
# 
# The Belief-adjustment-model is represented by the equation
# degree_of_belief[k] = degree_of_belief[k-1] + w[k] * (subjective_evidence[k] - R)
# 
# degree_of_belief - Degree of belief
# degree_of_belief[k-1] - Anchor or prior opinion
# subjective_evidence[k] - subjective evaluation of the kth piece of evidence
# R - the reference point or background against which the impact of the kth piece of evidence is evaluated
# w[k] - adjustment weight for the kth piece of evidence
# alpha - sensitivity to negative evidence
# beta - sensitivty to positive evidence
#
# Implementation based on
# Hogarth, R. M., & Einhorn, H. J. (1992). Order effects in belief updating: The belief-adjustment model. 
# Cognitive Psychology, 24(1), 1–55. doi: 10.1016/0010-0285(92)90002-j 

if(!require("tidyverse")) install.packages("tidyverse")
require("tidyverse")


##### Parameters #####

subjective_evidence <- c(.9,.6)  
initial_strength <- 0.5
alpha = 0.5
beta = 0.5
mode <- "estimation" # Evaluation or estimation
process <- "sbs" # eos or sbs

##### Simulation  ######
num_of_beliefs <- length(subjective_evidence)+1
degree_of_belief <- rep(0, num_of_beliefs)
degree_of_belief[1] <- initial_strength

for(i in 2:num_of_beliefs){
  
  if(process == "sbs"){
    if(mode == "estimation"){
      if(subjective_evidence[i-1] <= degree_of_belief[i-1])
        degree_of_belief[i] <- degree_of_belief[i-1] + alpha * (subjective_evidence[i-1] - degree_of_belief[i-1])
      else
        degree_of_belief[i] <- degree_of_belief[i-1] + beta * (subjective_evidence[i-1] - degree_of_belief[i-1])
    }
    if(mode == "evaluation"){
      if(subjective_evidence[i-1] <= 0)
        degree_of_belief[i] <- degree_of_belief[i-1] + alpha * (subjective_evidence[i-1])
      else
        degree_of_belief[i] <- degree_of_belief[i-1] + beta * (subjective_evidence[i-1])
    }
  }
  if(process == "eos"){
    if(mode == "estimation") stop("Estimation impossible for EOS")
    if(mode == "evaluation") {
      if(subjective_evidence[i-1] <= 0)
        degree_of_belief[i] <- degree_of_belief[1] + alpha * (subjective_evidence[i-1])
      else
        degree_of_belief[i] <- degree_of_belief[1] + beta * (subjective_evidence[i-1])
    }
  }
  degree_of_belief[degree_of_belief > 1] <- 1
  degree_of_belief[degree_of_belief < 0] <- 0
}

##### Plot results #####

df <- data.frame("belief" = degree_of_belief, "iteration" = factor(0:(num_of_beliefs-1)))

ggplot(df, aes(iteration,belief)) + 
  geom_line(aes(group = 1)) + geom_point() + 
  ylim(0,1) + ylab("Degree of belief")


              