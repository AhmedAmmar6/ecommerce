class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
        if resource.role == 'Seller'
          if resource.store.present?
            store_path(resource.store)
          else
            new_store_path
          end
        else
            root_path
        end
    end
end