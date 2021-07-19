# run ONCE
# rm(list=ls())
library(magrittr)
library(data.table)
ROOT <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(ROOT)
DATA <- fread(file="/home/averri/Database/records/index/MasterIndex.csv",yaml = TRUE) 
# Seleccionar registros horizontales en roca, excluir registros de superficie
SET <- DATA[DIR=="H1" & SiteSN!="I",.(RecordSN,SiteSN,R=EpicenterDistance,
                                      M=Magnitude,Vs30=model.Vs30,
                                      Ts=model.Ts,Hs=model.Hs,
                                      PGAo=PGA,AF.PGA,
                                      IAo=IA,AF.IA)]
# Seleccionar subset de sitios
SITES <- DATA[DIR=="H1" & SiteSN!="I",.(SiteSN,Vs30=model.Vs30,
                 Ts=model.Ts,Hs=model.Hs,NEHRP=model.NEHRP)] %>% unique(by ="SiteSN")
setcolorder(SITES,neworder=c("SiteSN","Hs","Vs30","Ts"))

# Corregir columna de distancias
SET[,R:=gsub(R,pattern = "km",replacement = "")][,R:=as.numeric(R)]
# Recuperar intensidades registro en suelos
SET[,PGAg:=AF.PGA*PGAo]
SET[,IAg:=AF.IA*IAo]
# Remover columnas duplicadas o redundantes
SET[,`:=`(AF.PGA=NULL,AF.IA=NULL,Hs=NULL,Vs30=NULL,Ts=NULL)]
setcolorder(SET,neworder=c("RecordSN","PGAo","PGAg","IAo","IAg","M","R","SiteSN"))
# Guardar datos en formato plano, incluyendo header 
fwrite(SET,file="data/intensity.csv",yaml = TRUE)
fwrite(SITES,file="data/sites.csv",yaml = TRUE)
# rm(DATA)
