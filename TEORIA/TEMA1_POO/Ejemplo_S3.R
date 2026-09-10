# Definir un objeto S3 para un paciente
crear_paciente <- function(nombre, edad, presion_sistolica, presion_diastolica) {
  paciente <- list(
    nombre = nombre,
    edad = edad,
    presion_sistolica = presion_sistolica,
    presion_diastolica = presion_diastolica
  )
  class(paciente) <- "paciente"
  return(paciente)
}

# Método para mostrar la información del paciente
print.paciente <- function(paciente) {
  cat("Paciente:", paciente$nombre, "\n")
  cat("Edad:", paciente$edad, "\n")
  cat("Presión arterial:", paciente$presion_sistolica, "/", paciente$presion_diastolica, "mmHg\n")
}

# Crear y mostrar un paciente
paciente_1 <- crear_paciente("Juan Pérez", 45, 120, 80)
#print(paciente_1)
print.paciente(paciente_1)
print("Hola")
