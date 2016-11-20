require 'bio'
patron = ARGV[0]
coincidencias =  File.open("respuestaej2A.out").grep(/#{patron}/)
coincidencias = coincidencias.join("\n\n")
File.open('respuestaej3.out', 'w') do |f|
  f.write("Coincidencias")
  f.write(coincidencias)
end