require 'bio'

def lector
	Bio::GenBank.open(ARGV[0])
end

def procesador(archivo, data)
	archivo.write(data.to_biosequence.output_fasta) unless data.to_biosequence.to_s.empty?
end

data = lector

File.open("respuesta1.fas", 'w') { |archivo| data.each_entry { |d| procesador(archivo, d) } }
