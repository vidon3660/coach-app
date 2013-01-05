ActiveAdmin.register User do

  filter :first_name
  filter :last_name
  filter :status

    form do |f|
      f.inputs "Informations" do
        f.input :first_name
        f.input :last_name
      end

      f.buttons
    end

end
