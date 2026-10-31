# ============================================================================
# Centinela del Dengue · Fase 1 · Script 01
# Descarga SIVIGILA (evento dengue, 2007-2025) con sivirep y agrega los casos
# por municipio y semana epidemiológica para los 10 municipios del dataset
# satelital de PhysioNet.
# Equipo: Sergio Alexander Cardozo Ovadia · Cesar Augusto Coy Velandia
# Regla de datos: los microdatos (una fila por caso) se quedan en data_raw/ y
# NUNCA se suben a GitHub ni se pegan en un asistente de IA. Este script solo
# imprime esquemas y conteos agregados.
# ============================================================================


# ---- 0. Paquetes ------------------------------------------------------------
paquetes_cran <- c("dplyr", "readr", "purrr", "tidyr", "digest")
faltantes <- setdiff(paquetes_cran, rownames(installed.packages()))
if (length(faltantes) > 0) install.packages(faltantes)

# sivirep salió de CRAN: se instala desde r-universe de Epiverse
if (!requireNamespace("sivirep", quietly = TRUE)) {
  install.packages("sivirep",
                   repos = c("https://epiverse-trace.r-universe.dev",
                             "https://cloud.r-project.org"))
}

library(sivirep)
library(dplyr)
library(readr)
library(purrr)
library(tidyr)
library(digest)

cat("R:", R.version.string, "| sivirep:", as.character(packageVersion("sivirep")),
    "| fecha de ejecución:", format(Sys.Date()), "\n")


# ---- 1. Carpetas del proyecto -----------------------------------------------
# Ajusta la ruta si quieres el proyecto en otra carpeta
dir_proyecto <- "C:/Users/ASUS/Documents/Maestria_CienciaDatos_USTA/Maest_CienciaDatos/RedesNeuronales/centinela-dengue"
dir.create(file.path(dir_proyecto, "data_raw"), recursive = TRUE, showWarnings = FALSE)
dir.create(file.path(dir_proyecto, "data"),     recursive = TRUE, showWarnings = FALSE)
setwd(dir_proyecto)


# ---- 2. Municipios del dataset satelital (códigos DIVIPOLA) -----------------
municipios <- tribble(
  ~divipola, ~municipio,
  "05001", "Medellín",
  "05360", "Itagüí",
  "08001", "Barranquilla",
  "23001", "Montería",
  "41001", "Neiva",
  "50001", "Villavicencio",
  "54001", "Cúcuta",
  "68001", "Bucaramanga",
  "73001", "Ibagué",
  "76001", "Cali"
)


# ---- 3. Descarga año por año (con caché local) ------------------------------
# Si un año ya se descargó, se lee de data_raw/ y no se vuelve a pedir al INS
anios <- 2007:2025

descargar_anio <- function(anio) {
  ruta <- file.path("data_raw", paste0("dengue_", anio, ".rds"))
  if (file.exists(ruta)) return(readRDS(ruta))
  datos <- tryCatch(
    # ruta_dir es obligatorio cuando cache = FALSE: sivirep baja ahí el .xls
    # temporal, lo lee y lo borra (ver sección 3 de la bitácora, entrada E-2)
    import_data_event(nombre_event = "dengue", years = anio,
                      ruta_dir = file.path(dir_proyecto, "data_raw", "tmp_xls"),
                      cache = FALSE),
    error = function(e) {
      message("Año ", anio, " falló: ", conditionMessage(e))
      NULL
    }
  )
  if (!is.null(datos)) saveRDS(datos, ruta)
  datos
}

lista_anios <- map(anios, descargar_anio)
names(lista_anios) <- anios


# ---- 4. SALIDA A · Resumen de la descarga (pegar en el chat) ----------------
resumen_descarga <- tibble(
  anio     = anios,
  filas    = map_int(lista_anios, ~ if (is.null(.x)) NA_integer_ else nrow(.x)),
  columnas = map_int(lista_anios, ~ if (is.null(.x)) NA_integer_ else ncol(.x))
)
cat("\n===== SALIDA A · Filas y columnas por año =====\n")
print(resumen_descarga, n = Inf)


# ---- 5. SALIDA B · Esquema (solo nombres de columnas, sin registros) --------
cat("\n===== SALIDA B · Nombres de columnas (año 2016) =====\n")
print(names(lista_anios[["2016"]]))


# ---- 6. Unir años con solo las columnas necesarias (minimización) -----------
# E-3: sivirep limpia los encabezados y la columna se llama "ajuste" (no "ajuste_")
columnas_utiles <- c("cod_eve", "ano", "semana", "cod_dpto_o", "cod_mun_o", "ajuste")

crudo <- lista_anios |>
  compact() |>
  map(~ .x |>
        select(any_of(columnas_utiles)) |>
        mutate(across(everything(), as.character))) |>
  bind_rows()

stopifnot("Falta la columna ajuste" = "ajuste" %in% names(crudo))  # E-3: fallar en voz alta


# ---- 7. SALIDA C · Huella de crudeza (antes de limpiar) ---------------------
cat("\n===== SALIDA C · Huella de crudeza =====\n")
cat("Casos crudos totales 2007-2025:", nrow(crudo), "\n")
cat("Porcentaje de vacíos por columna:\n")
print(crudo |> summarise(across(everything(),
                                ~ round(100 * mean(is.na(.x) | .x == ""), 2))))
cat("Casos por código de evento:\n")
print(table(crudo$cod_eve, useNA = "ifany"))
cat("Casos por valor de ajuste (6 y D = descartados):\n")
print(table(crudo$ajuste, useNA = "ifany"))


# ---- 8. Agregación municipio-semana (municipio de procedencia) -------------
casos_semana <- crudo |>
  filter(cod_eve %in% c("210", "220"),        # E-4: dengue + dengue grave; 580 (mortalidad) duplicaría casos
         !(ajuste %in% c("6", "D"))) |>   # E-3: sin descartados
  mutate(
    divipola = sprintf("%02d%03d", as.integer(cod_dpto_o), as.integer(cod_mun_o)),
    anio     = as.integer(ano),
    semana   = as.integer(semana)
  ) |>
  filter(divipola %in% municipios$divipola) |>
  count(divipola, anio, semana, name = "casos")

# Rejilla completa: las semanas sin casos quedan con 0 (no como vacío)
semanas_por_anio <- crudo |>
  mutate(anio = as.integer(ano), semana = as.integer(semana)) |>
  group_by(anio) |>
  summarise(max_semana = max(semana, na.rm = TRUE), .groups = "drop")
cat("\n===== SALIDA C2 · Semanas epidemiológicas por año =====\n")
print(semanas_por_anio, n = Inf)

rejilla <- semanas_por_anio |>
  rowwise() |>
  mutate(semana = list(seq_len(max_semana))) |>
  unnest(semana) |>
  select(anio, semana) |>
  crossing(divipola = municipios$divipola)

dengue_mun_semana <- rejilla |>
  left_join(casos_semana, by = c("divipola", "anio", "semana")) |>
  mutate(casos = replace_na(casos, 0L)) |>
  left_join(municipios, by = "divipola") |>
  arrange(divipola, anio, semana)


# ---- 9. SALIDA D · Resumen por municipio (agregado) -------------------------
cat("\n===== SALIDA D · Resumen por municipio =====\n")
print(
  dengue_mun_semana |>
    group_by(divipola, municipio) |>
    summarise(
      semanas          = n(),
      casos_totales    = sum(casos),
      media_semanal    = round(mean(casos), 1),
      maximo_semanal   = max(casos),
      pct_semanas_menos_5 = round(100 * mean(casos < 5), 1),
      .groups = "drop"
    ),
  n = Inf
)


# ---- 10. SALIDA E · Anexo A: prueba de acoplamiento (10 filas) --------------
anexo_a <- dengue_mun_semana |>
  filter(divipola == "08001", anio == 2016, semana <= 10) |>
  mutate(
    clave   = sprintf("(08001, 2016-SE%02d)", semana),
    archivo = sprintf("image_%s.tiff",
                      format(as.Date("2016-01-03") + 7 * (semana - 1), "%Y-%m-%d"))
  ) |>
  select(clave, archivo, casos)

cat("\n===== SALIDA E · Anexo A =====\n")
print(anexo_a, n = Inf)


# ---- 11. SALIDA F · Guardar el agregado y su huella SHA-256 -----------------
ruta_csv <- "data/dengue_10mun_semana.csv"
write_csv(dengue_mun_semana, ruta_csv)

cat("\n===== SALIDA F · Archivo agregado =====\n")
cat("Archivo:", ruta_csv, "\n")
cat("Filas x columnas:", nrow(dengue_mun_semana), "x", ncol(dengue_mun_semana), "\n")
cat("SHA-256:", digest(file = ruta_csv, algo = "sha256"), "\n")
cat("Fecha de descarga:", format(Sys.Date()), "\n")
