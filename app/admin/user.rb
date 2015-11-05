ActiveAdmin.register User do

permit_params :first_name, :last_name, :picture, :email, :password, :password_confirmation

  member_action :lock, method: :put do
    resource.lock_access!
    redirect_to :back, notice: "User is Locked" 
  end

   member_action :unlock, method: :put do
    resource.unlock_access!
    redirect_to :back, notice: "User is UnLocked" 
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :picture do |u|
    image_tag u.picture.url, height: '50', width: '60'
    end
    column :link do |t|
      #link_to "Lock/Unlock", lock_admin_user_path(t),method: :put
      link_to t.access_locked? ? "Unlock" : "Lock" , t.access_locked? ? unlock_admin_user_path(t) : lock_admin_user_path(t) ,method: :put
    end
    # column :link do |t|
    #   link_to :Unlock, unlock_admin_user_path(t),method: :put
    # end

    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    	f.input :picture
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :image do 
        image_tag user.picture.url 
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end



end


  # def unlock
  #   user = User.find(params[:id])
  #   user.unlock_access!
  #   redirect_to users_path
  # end
