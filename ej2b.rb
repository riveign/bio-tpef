require 'bio'

def obtener_secuencias
	secuencias = []
	fasta = Bio::FlatFile.open(Bio::FastaFormat, 'msa.fas')
	fasta.each_entry do |entrada|
	  secuencias << entrada.to_biosequence
	end
	return secuencias
end

def ejecutar_alineacion(secuencias)
	File.open('ex2b.out', 'w') do |f|
	  a = Bio::Alignment.new(secuencias)
	  clustalw = Bio::ClustalW.new
	  a.do_align(clustalw)
	  escribir_archivo(f, clustalw)
	end
end

def escribir_archivo(file, salida_clustalw)
	file.write(salida_clustalw.data_stdout)
end

ejecutar_alineacion(obtener_secuencias())


