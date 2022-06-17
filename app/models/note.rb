class Note < Prawn::Document

    @record = Record.find(params[:id])

    def initialize
      super()
      font_families.update('Test' => { normal: 'app/assets/fonts/KosugiMaru-Regular.ttf' })
      font 'Test'


        header

    end

    def header
       # font 'app/assets/fonts/KosugiMaru-Regular.ttf',

        text "借用書", :align => :center, :size => 58
        move_down 20
        text "#{@record.name}殿",:size => 22
        move_down 20


    end
end