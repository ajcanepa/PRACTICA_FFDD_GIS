Transcripcion <- function(secuencia_dna = seq_dna){
  seq_arn = chartr("T","U", secuencia_dna)
  seq_arn = paste(seq_arn, collapse = "")
  return(seq_arn)
}