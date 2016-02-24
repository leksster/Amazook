require Rails.root.join('lib', 'rails_admin', 'overview.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Overview)


RailsAdmin.config do |config|
  config.model Order do
    edit do
      field :aasm_state do
        label 'State'
      end
      field :total_price
      field :completed_date
      field :credit_card
      field :shipping
      field :billing_address
      field :shipping_address
      field :user
      field :created_at
      field :updated_at
    end
    list do
      field :aasm_state do
        label 'State'
      end
      field :total_price
      field :completed_date
      field :credit_card
      field :shipping
      field :user
      field :created_at
      field :updated_at
    end
  end

  config.model Rating do
    edit do
      field :aasm_state do
        label 'State'
      end
      field :review_text
      field :rating
      field :user
      field :book
      field :created_at
      field :updated_at
    end
    list do
      field :id
      field :aasm_state do
        label 'State'
      end
      field :review_text
      field :rating
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.authorize_with do |controller|
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  config.actions do
    overview do
      route_fragment ''
      root true
    end
    dashboard do                  # mandatory
      route_fragment 'dashboard'
    end              
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
