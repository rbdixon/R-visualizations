# http://stackoverflow.com/questions/9298765/print-latex-table-directly-to-an-image-png-or-other

tabular.png <- function(name, ...) {
  require(tools)
  require(Hmisc)
  require(tables)
  
  # Create latex document with table
  first <- name
  name <- paste(name,".tex",sep="")
  sink(file=name)
  cat('
      \\documentclass{report}
      \\usepackage[paperwidth=8in,paperheight=8in,noheadfoot,margin=0in]{geometry}
      \\begin{document}\\pagestyle{empty}
      ')
  print(latex(tabular(...)))
  cat('
      \\end{document}
      ')
  sink()
  
  # Convert to DVI and then to PNG
  texi2dvi(file=name)
  cmd <- paste("dvipng -T tight -D 120", shQuote(paste(first,".dvi",sep="")), paste("-o ", first,".png",sep=""))
  invisible(sys(cmd))
  cleaner <- c(".tex",".aux",".log",".dvi")
  invisible(file.remove(paste(first,cleaner,sep="")))
}