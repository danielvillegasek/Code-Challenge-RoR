require 'roo'

class ImportsController < ApplicationController

    def new
    end

    def create
        file = params[:file] #obtener el archivo
        if file.nil? # si no se selecciono ningun archivo, regresar
            redirect_to new_import_path, notice: "No se ha seleccionado ningun archivo"
            return
        end
        xlsx = Roo::Spreadsheet.open(file.path) # abrir el archivo, se instaló la gema roo
        data = xlsx.sheet(0).parse(headers: true)  # obtener los datos de la hoja 0, con encabezados

        # modo transaccion para que si falla no se guarde nada
        ActiveRecord::Base.transaction do 
            global_total = 0
            data.each_with_index do |row, index| 
                puts row
                next if index == 0  
                rvl = row.values  # rvl as row values list
                cliente = rvl[0]
                desc_prod = rvl[1]
                precio_pieza = rvl[2]
                num_piezas = rvl[3]
                dir_vend = rvl[4]
                nom_vend = rvl[5]
        
                # [REVISAR] no hay como saber mas que por nombre, tendriamos que tener un id del sistema anterior para asegurar asignar al cliente sus ventas
                client = Client.find_or_create_by(name: cliente)
                provider = Provider.find_or_create_by(name: nom_vend)
                product = Product.find_or_create_by(name: desc_prod, provider_id: provider.id)
                product.update(description: desc_prod, price: precio_pieza)

                total = product.price * num_piezas.to_i
                sale = Sale.create(client_id: client.id, total: total)
                SaleItem.create(product_id: product.id, quantity: num_piezas, sale_id: sale.id)
                global_total += total
                # puts row_list_values
            end 
            global_total = ActionController::Base.helpers.number_to_currency(global_total)
            mensaje = "Se importaron #{data.length - 1} registros, con un total de #{global_total}"
            redirect_to new_import_path, notice: mensaje
        end
    end
end
