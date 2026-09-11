# Funciones en R ----------------------------------------------------------

# * Condicionales ---------------------------------------------------------

# ** Condicional `if` -----------------------------------------------------
# Determinar si un paciente tiene presión arterial alta. 
# La presión arterial alta se define aquí como una presión sistólica mayor a 140 mmHg.

# Definir la presión arterial sistólica de un paciente
presion_sistolica <- 145

# Utilizar una estructura if para verificar si la presión arterial es alta
if (presion_sistolica > 140) {
  print("El paciente tiene presión arterial alta.")
}


# ** Condicional `if-else` ------------------------------------------------
# Ahora vamos a realizar una clasificación más detallada de la presión arterial. 
# La presión arterial se considera normal si es menor o igual a 120 mmHg, alta si está entre 121 y 140 mmHg, y muy alta si es mayor a 140 mmHg.

# Definir la presión arterial sistólica de un paciente
presion_sistolica <- 135

# Utilizar una estructura if-else para clasificar la presión arterial
if (presion_sistolica <= 120) {
  print("La presión arterial del paciente es normal.")
} else if (presion_sistolica <= 140) {
  print("El paciente tiene presión arterial alta.")
} else {
  print("El paciente tiene presión arterial muy alta.")
}


# ** Condicional `ifelse` -------------------------------------------------
# Usaremos ifelse para aplicar una función vectorial a un conjunto de datos. 
# Supongamos que tenemos un vector con las presiones arteriales de varios pacientes y queremos etiquetarlos como "Normal", "Alta" o "Muy alta".

# Definir un vector con las presiones arteriales de varios pacientes
presiones_sistolicas <- c(115, 130, 145, 125, 110)

# Utilizar ifelse para clasificar cada valor en el vector
clasificacion <- ifelse(
  presiones_sistolicas <= 120, 
  "Normal", 
  ifelse(
    presiones_sistolicas <= 140, 
    "Alta", 
    "Muy alta"
  )
)

# Mostrar la clasificación
print(clasificacion)



# * Iteraciones -----------------------------------------------------------

# ** tapply / apply -------------------------------------------------------

#  *** `tapply()` ---------------------------------------------------------
# El comando tapply en R se utiliza para aplicar una función a subconjuntos de datos, agrupados por una variable.
# Supongamos que tenemos un conjunto de datos sobre pacientes diabéticos y queremos calcular la media de los niveles de glucosa en sangre para diferentes categorías de índice de masa corporal (IMC).

# Crear un dataframe con datos simulados sobre pacientes diabéticos
datos <- data.frame(
  paciente = 1:10,
  glucosa = c(120, 135, 140, 125, 130, 155, 145, 160, 150, 165),
  imc_categoria = c('Normal', 'Sobrepeso', 'Obesidad', 'Normal', 'Sobrepeso', 
                    'Obesidad', 'Obesidad', 'Sobrepeso', 'Normal', 'Obesidad')
)

# Usar tapply para calcular la media de los niveles de glucosa por categoría de IMC
media_glucosa <- tapply(datos$glucosa, datos$imc_categoria, mean)

# Mostrar los resultados
print(media_glucosa)

# tapply: Aplica la función mean a los valores en glucosa, agrupados por la variable imc_categoria. Esto devuelve la media de glucosa para cada categoría de IMC.
# tapply: Es útil cuando tienes un dataframe y quieres aplicar una función a grupos de datos definidos por una variable categórica.


# *** `apply()` -----------------------------------------------------------
# El comando apply en R se utiliza para aplicar una función a las márgenes de una matriz o dataframe
# Supongamos que tenemos una matriz con niveles de glucosa en sangre para varios pacientes en diferentes momentos y queremos calcular la media de glucosa para cada paciente.

# Crear una matriz con datos simulados sobre niveles de glucosa en sangre
glucosa_matriz <- matrix(
  c(120, 135, 140, 
    125, 130, 155, 
    145, 160, 150, 
    165, 170, 175), 
  nrow = 4, 
  byrow = TRUE,
  dimnames = list(paciente = paste("Paciente", 1:4), 
                  momento = paste("Momento", 1:3))
)

glucosa_matriz

# Usar apply para calcular la media de los niveles de glucosa por paciente
media_por_paciente <- apply(glucosa_matriz, MARGIN = 1, FUN = mean)

# Mostrar los resultados
print(media_por_paciente)

# apply: Aplica la función mean a las filas (MARGIN = 1) de la matriz. Esto devuelve la media de glucosa para cada paciente.
# apply: Es útil cuando trabajas con matrices o dataframes y quieres aplicar una función a lo largo de una dimensión específica (filas o columnas).

# ** While Loop -----------------------------------------------------------
# Monitoreo de Nivel de Glucosa en Sangre
# Necesitamos medir los niveles diarios de glucosa hasta que el nivel de glucosa sea menor o igual a un valor objetivo (por ejemplo, 120 mg/dL)

# Definir el nivel de glucosa objetivo
nivel_objetivo <- 120

# Inicializar el nivel de glucosa del paciente
nivel_glucosa <- 150

# Inicializar un contador para registrar las lecturas
contador <- 0

# Simular la toma de lecturas de glucosa hasta alcanzar el nivel objetivo
while (nivel_glucosa > nivel_objetivo) {
  # Aumentar el contador
  contador <- contador + 1
  
  # Simular la toma de una nueva lectura de glucosa
  # Aquí usamos una función aleatoria para simular la variación en el nivel de glucosa
  nivel_glucosa <- nivel_glucosa - sample(1:10, 1)
  
  # Mostrar el nivel de glucosa actual y el número de lecturas tomadas
  cat("Lectura", contador, ": Nivel de glucosa =", nivel_glucosa, "mg/dL\n")
}

cat("El nivel de glucosa ha alcanzado o está por debajo del objetivo después de", contador, "lecturas.\n")

# ** For Loop -------------------------------------------------------------

# *** For loop sencillo  --------------------------------------------------
# Queremos asignar a cada paciente a una habitación disponible. Usaremos un for loop para hacer esta asignación.

# Número de habitaciones disponibles
num_habitaciones <- 5

# Crear una lista de pacientes
pacientes <- c("Paciente1", "Paciente2", "Paciente3", "Paciente4", "Paciente5", "Paciente6")

# Inicializar un vector para almacenar la asignación de habitaciones
asignacion <- vector("list", length(pacientes))

# Asignar habitaciones a los pacientes
# Usamos seq_along(pacientes) en lugar de 1:length(pacientes): si el vector
# estuviese vacío, 1:length(x) generaría c(1, 0) y provocaría iteraciones no deseadas
for (i in seq_along(pacientes)) {
  # Calcular la habitación asignada utilizando el operador módulo
  habitacion <- ((i - 1) %% num_habitaciones) + 1
  
  # Guardar la asignación en el vector
  asignacion[[i]] <- paste(pacientes[i], "se asigna a la habitación", habitacion)
}

# Mostrar los resultados de la asignación
for (asignacion_paciente in asignacion) {
  cat(asignacion_paciente, "\n")
}

# *** For loop anidado ----------------------------------------------------
# cada paciente debe someterse a exámenes de radiografía en diferentes fechas. Usaremos for loops anidados para asignar fechas de examen a cada paciente.

# Crear una lista de pacientes
pacientes <- c("Paciente1", "Paciente2", "Paciente3")

# Crear un vector con las fechas de los exámenes
fechas_examen <- c("2024-09-01", "2024-09-15", "2024-10-01")

# Inicializar una lista para almacenar la programación de exámenes
programacion_examenes <- list()

# Loop para asignar fechas a pacientes
for (paciente in pacientes) {
  # Inicializar una lista para almacenar las fechas de examen para un paciente
  programacion_examenes[[paciente]] <- vector("list", length(fechas_examen))
  
  # Loop anidado para asignar fechas de examen a cada paciente
  for (fecha in fechas_examen) {
    # Guardar la fecha de examen en la lista correspondiente al paciente
    programacion_examenes[[paciente]][[fecha]] <- paste("Examen de radiografía programado para", fecha)
  }
}

# Mostrar la programación de exámenes para cada paciente
for (paciente in names(programacion_examenes)) {
  cat("\n", paciente, ":\n")
  for (examen in programacion_examenes[[paciente]]) {
    cat(" -", examen, "\n")
  }
}



# * Funciones Propias en R ------------------------------------------------
# Trabajo con secuencias genéticas


# ** Conteo de nucleótidos ------------------------------------------------
# definimos la cadena de DNA
seq_dna <- c("ATGTCACCACAAACAGAGACT")
seq_dna

# Crear una función `contar_nucleotidos()`, que nos permitirá contar el número de cada uno de los nucleótidos que tenemos en nuestra secuencia.
contar_nucleotidos <- function(secuencia_dna = seq_dna){
  conteo_nucleotidos = unlist(strsplit(x = secuencia_dna, split = "", fixed = TRUE))
  print(table(conteo_nucleotidos))
}

# Usamos la función
contar_nucleotidos(secuencia_dna = seq_dna)


# ** Cadena complementaria ------------------------------------------------
# Cada vez que un nucleótido de nuestra cadena sea `A`, en la cadena complementaria correspondiente, el nucleótido que le tocaría sería el `T`.
# Crear una función que realice esta acción a la que llamaremos `Complementaria()`.
Complementaria <- function(secuencia_dna = seq_dna){
  complementaria_adn = chartr("ATGC","TACG", secuencia_dna)
  complementaria_adn = paste(complementaria_adn, collapse = "")
  return(complementaria_adn)
}

# Usando la función
seq_dna
Complementaria(seq_dna)


# ** Transcripción --------------------------------------------------------
# Necesitamos *transcribir* la información desde la cadena de ADN a una cadena de ARN.
# Las correspondencias en este caso cambian y tenemos que la *Timina* es reemplazada por el *Uracilo*
Transcripcion <- function(secuencia_dna = seq_dna){
  seq_arn = chartr("T","U", secuencia_dna)
  seq_arn = paste(seq_arn, collapse = "")
  return(seq_arn)
}

# Usando la función
print(seq_dna)
Transcripcion(seq_dna)

# Importando la función
source("INPUT/FUNCTIONS/Transcripcion.R")
print(seq_dna)
Transcripcion(seq_dna)