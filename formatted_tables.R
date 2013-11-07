# From 'tables' vingette

library(tables)
data(iris)

tabular( (Species + 1) ~ (n=1) + Format(digits=2)*(Sepal.Length + Sepal.Width)*(mean + sd), data=iris )

# Sample data
set.seed(100)
X <- rnorm(10)
A <- sample(letters[1:2], 10, rep=TRUE)
F <- factor(A)
F

tabular(F + 1 ~ 1)
tabular( X*F*(mean + sd) ~ 1 )
tabular( X*F ~ mean + sd )

# Rename columns
tabular( X*(Newname=F) ~ mean + sd )

# Factors group the table
# Each row listed as the index of X by casting to a factor
# Then for X, A, and F show their values
# Casting F to a character prevents this from being split up by factor
tabular( (i = factor(seq_along(X))) ~ Heading('Test')*identity*(X+A + (F = as.character(F) ) ) ) 

# Logical vector
tabular((X>0)+(X<0) + 1 ~ ((n = 1) + X*(mean + sd)) )

# Fancy functions
data(mtcars)
tabular( (Factor(gear, "Gears") + 1)*((n=1) + Percent() + (RowPct=Percent("row")) + (ColPct=Percent("col")))
         ~ (Factor(carb, "Carburetors") + 1)*Format(digits=1), data=mtcars )

# Pull columns from data frame
tabular( Species ~ Heading()*mean*All(iris), data=iris)