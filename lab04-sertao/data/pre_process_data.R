library(readr)
library(plyr)

info_agua <- read_csv("~/Projects/UFCG/16_2/DataViz/lab04-sertao/data/dados_snis_filtrados/info_agua.csv")
info_qualidade <- read_csv("~/Projects/UFCG/16_2/DataViz/lab04-sertao/data/dados_snis_filtrados/info_qualidade.csv")
info_geral <- read_csv("~/Projects/UFCG/16_2/DataViz/lab04-sertao/data/dados_snis_filtrados/info_geral.csv")
info_coleta_seletiva <- read_csv("~/Projects/UFCG/16_2/DataViz/lab04-sertao/data/dados_snis_filtrados/info_coleta_seletiva_triagem.csv")
geodata <- read_csv("~/Projects/UFCG/16_2/DataViz/lab04-sertao/data/municipios_sab.csv")

sum(is.na(info_coleta_seletiva$CS001...Existe.coleta.seletiva.no.município...Sim.Não.))

info_agua$Código.do.Município <- as.factor(info_agua$Código.do.Município)
info_geral$Código.do.Município <- as.factor(info_geral$Código.do.Município)
info_qualidade$Código.do.Município <- as.factor(info_qualidade$Código.do.Município)

cols_select <- c("GEOCODIGO", "Código.do.Município", "POP_TOT...População.total.do.município.do.ano.de.referência..Fonte..IBGE....Habitantes.", "G12A...População.total.residente.do.s..município.s..com.abastecimento.de.água..segundo.o.IBGE..Habitantes.", "G12B...População.total.residente.do.s..município.s..com.esgotamento.sanitário..segundo.o.IBGE..Habitantes.", "QD002...Quantidades.de.paralisações.no.sistema.de.distribuição.de.água..Paralisações.ano.", "CS001...Existe.coleta.seletiva.no.município...Sim.Não.")

df <- merge(info_agua, info_geral, by="Código.do.Município")
df <- merge(df, geodata, by="Código.do.Município")
df <- merge(df, info_coleta_seletiva, by="Código.do.Município")
df <- merge(df, info_qualidade, by="Código.do.Município")[, cols_select]

col_names <- c("geoid", "city_code", "pop_total", "pop_with_water_supply", "pop_with_sewer_service", "qty_water_supply_paralizations", "has_selective_waste_collection")

colnames(df) <- col_names

df$has_selective_waste_collection <- as.factor(revalue(df$has_selective_waste_collection, c("Não"=FALSE, "Sim"=TRUE)))

View(df)

write.csv(df, file="data_sertao.csv")
