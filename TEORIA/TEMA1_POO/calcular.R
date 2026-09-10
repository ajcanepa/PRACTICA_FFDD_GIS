calcular <- function(x, y, type = "sumar") {
  if (type == "sumar") {
    x + y
  } else if (type == "restar") {
    x - y
  } else if (type == "multiplicar") {
    x * y
  } else if (type == "dividir") {
    x / y
  } else {
    stop("Tipo de operación desconocida")
  }
}