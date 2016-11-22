require 'bio'

def asignacion_parametros
	@entrada = ARGV[0]
	@salida_orf = 'ex4-orf.out'
  @salida_opf = 'ex4-opf.out'
end

asignacion_parametros

Bio::EMBOSS.run('prosextract', '-prositedir', "#{Dir.pwd}")

fasta = Bio::FlatFile.open(Bio::FastaFormat, @entrada)
blast = Bio::Blast.remote('blastn', 'dbest', '-e 0.001', 'genomenet')

File.open(@salida_orf, 'w') do |f|
  f.puts Bio::EMBOSS.run('getorf', '-sequence', @entrada)
end

File.open(@salida_opf, 'w') do |f|
  f.puts Bio::EMBOSS.run('patmatmotifs', '-full', '-noprune', '-sequence', @entrada)
end


