RailsAdmin.config do |config|
  config.authorize_with :cancan, RailsAdminAbility
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    edit
    delete
    show_in_app
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

    edit do
      configure :send_mail, :boolean do
        show
      end
    end
  end

  config.model 'Event' do
    configure :self_attended_users do
      hide
    end
    configure :attendances do
      hide
    end
    configure :group_attendances do
      hide
    end
    configure :groups do
      hide
    end
    configure :group_attendees do
      hide
    end
    configure :group_leader_attendees do
      hide
    end
    configure :created_at do
      hide
    end
    configure :updated_at do
      hide
    end

    configure :owner do
      associated_collection_scope do
        Proc.new do |scope|
          scope = User.real_users
        end
      end
    end

    list do
      field :mandatory
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
      enum do
        Category.identifiers.map { |k,_| [k.titleize, k] }
      end

      pretty_value do
        bindings[:object].send(:identifier).titleize
      end

      def form_value
        bindings[:object].identifier
      end
    end
  end
end
