require Rails.root.join('lib', 'rails_admin', 'download_attendees')
RailsAdmin::Config::Actions.register(
  RailsAdmin::Config::Actions::DownloadAttendees
)

RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'
  config.authorize_with :cancan, RailsAdminAbility
  config.current_user_method do |controller|
    controller.send(:current_user)
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    clone
    edit
    delete
    show_in_app
    import
    download_attendees do
      only %w(Event)
    end
  end

  config.model 'Camp' do
    configure(:id) { hide }
    configure(:created_at) { hide }
    configure(:updated_at) { hide }
    configure(:schema_name) { hide }
    configure(:subdomain) { hide }
    configure(:organization) { hide }

    configure :welcome_mail do
      html_attributes cols: 70, rows: 20
    end
  end

  config.model 'News' do
    configure :id do
      hide
    end
    configure :created_at do
      hide
    end
  end

  config.model 'User' do
    configure :id do
      hide
    end
    configure :confirmation_token do
      hide
    end
    configure :invitation_token do
      hide
    end
    configure :created_at do
      hide
    end
    configure :updated_at do
      hide
    end
    configure :avatar do
      hide
    end
    configure :owned_events do
      hide
    end
    configure :attendances do
      hide
    end
    configure :self_attended_events do
      hide
    end
    configure :memberships do
      hide
    end
    configure :group_events do
      hide
    end
    configure :leaded_group_events do
      hide
    end
    configure :leaded_groups do
      hide
    end
    configure :groups do
      hide
    end
    configure :guest do
      hide
    end
    configure :password_confirmation do
      hide
    end
    configure :organization do
      hide
    end

    edit do
      configure :send_mail, :boolean do
        show
      end
    end

    list do
      scopes %i(real_users guests)
    end

    object_label_method do
      :fullname
    end

    import do
      mapping_key :email
    end
  end

  config.model 'Event' do
    edit do
      field :title
      field :owner
      field :teaser
      field :description
      field :meeting_point
      field :starts
      field :ends
      field :lock_at
      field :max_attendees
      field :category
      field :groups_only
      field :impression
      field :youtube_url
      field :self_attended_users
    end

    configure :owner do
      associated_collection_scope do
        Proc.new do |scope|
          scope = User.real_users
        end
      end
    end

    list do
      field :owner
      field :title
      field :starts do
        pretty_value do
          value.strftime('%a %H:%M')
        end
      end
      field :ends do
        pretty_value do
          value.strftime('%a %H:%M')
        end
      end
      field :max_attendees
      field :category

      scopes %i(all today in_future mandatory info group_events without_mandatory without_group_events)
    end

    object_label_method do
      :event_label
    end
  end

  config.model 'Group' do
    object_label_method do
      :name_with_leader
    end
    configure :memberships do
      hide
    end
    configure :group_attendances do
      hide
    end
    configure :created_at do
      hide
    end
    configure :updated_at do
      hide
    end

    configure :leader do
      associated_collection_scope do
        Proc.new do |scope|
          scope = User.real_users
        end
      end
    end

    configure :users do
      associated_collection_scope do
        Proc.new do |scope|
          scope = User.real_users
        end
      end
    end

    configure :events do
      associated_collection_scope do
        Proc.new do |scope|
          scope = Event.group_events
        end
      end
    end
  end

  config.model 'Category' do
    configure :created_at do
      hide
    end
    configure :updated_at do
      hide
    end
    configure :events do
      hide
    end

    configure :identifier, :enum do
      searchable false

      pretty_value do
        bindings[:object].send(:identifier).titleize
      end

      def form_value
        bindings[:object].identifier
      end
    end
  end

  config.model 'Map' do
    configure(:id) { hide }
    configure(:created_at) { hide }
    configure(:updated_at) { hide }

    list do
      field :name
      field :description
      field :order
    end
  end

  config.model 'EmergencyNumber' do
    configure(:id) { hide }
    configure(:created_at) { hide }
    configure(:updated_at) { hide }

    configure :color, :enum do
      searchable false

      pretty_value do
        bindings[:object].send(:color).titleize
      end

      def form_value
        bindings[:object].color
      end
    end
  end

  config.model 'PicOfTheDay' do
  end
end
