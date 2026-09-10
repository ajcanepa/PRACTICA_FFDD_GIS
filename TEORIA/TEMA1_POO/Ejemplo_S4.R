# Definir una clase S4 para un paciente
setClass(
  "Paciente",
  slots = list(
    nombre = "character",
    edad = "numeric",
    presion_sistolica = "numeric",
    presion_diastolica = "numeric"
  )
)

# Constructor de la clase Paciente
Paciente <- function(nombre, edad, presion_sistolica, presion_diastolica) {
  new("Paciente", 
      nombre = nombre, 
      edad = edad, 
      presion_sistolica = presion_sistolica, 
      presion_diastolica = presion_diastolica)
}

# Método para mostrar la información del paciente
setMethod("show", "Paciente", function(object) {
  cat("Paciente:", object@nombre, "\n")
  cat("Edad:", object@edad, "\n")
  cat("Presión arterial:", object@presion_sistolica, "/", object@presion_diastolica, "mmHg\n")
})

# Crear y mostrar un paciente
paciente_2 <- Paciente("Ana Gómez", 30, 110, 70)
show(paciente_2)

paciente_3 <- Paciente("Ana Gómez", "Hola", 110, 70)
show(paciente_3)

paciente_4 <- Paciente("Ana Gómez", 1100, 110, 70)
show(paciente_4)
