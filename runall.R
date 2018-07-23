plotfiles <- grep("Plot.*R", dir(), value = TRUE)
for (file in plotfiles) source(file)
