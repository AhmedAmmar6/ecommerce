class RegistrationsController < Devise::RegistrationsController
    def after_sign_up_path_for(resource)
        if resource.role == 'Seller'
          # Redirect to the seller's page
          new_store_path
        else
          # Redirect to the home page (or any other path for buyers)
          root_path
        end
    end
end