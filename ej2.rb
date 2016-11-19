require 'bio'

def lector_fasta
  Bio::FlatFile.open(Bio::FastaFormat, ARGV[0])
end

def blast
  Bio::Blast.remote('blastn', 'dbest', '-e 0.001', 'genomenet')
end

def iterador_fasta(archivo, blast_1, fasta)
  fasta.each_entry do |data|
    iterador_blast(archivo,blast_1, data)
  end
end

def iterador_blast(archivo, blast_1, data)
  query = blast_1.query(data.seq)
  impresion(archivo, query)
end

def impresion(archivo, query)
  query.hits.each_with_index do |h, i|
    archivo.puts "#{i}"
    archivo.puts h.accession
    archivo.puts h.definition
    archivo.puts " #{h.len} - Tamaño"
    archivo.puts " #{h.identity} - Identidad"
    archivo.puts " #{h.overlap} - Superposicion"
    archivo.puts " #{h.percent_identity}"
    archivo.puts " #{h.query_seq}"
    archivo.puts " #{h.target_seq}"
    puts Bio::Sequence.auto(h.target_seq).output_fasta
    h.hsps.each_with_index do |hsps, hsps_index|
      archivo.puts " - Bit score: #{hsps.bit_score}"
      archivo.puts " - Gaps: #{hsps.gaps}"
    end
  end
end

archivo_fasta = lector_fasta
archivo_blast = blast

File.open("respuestaej2A.out", 'w') do |archivo|
  iterador_fasta(archivo, archivo_blast, archivo_fasta)
end
