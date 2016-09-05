module RailsAdmin
  module Config
    module Actions
      class DownloadAttendees < RailsAdmin::Config::Actions::Base
        register_instance_option :visible? do
          authorized?
        end

        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-download'
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :controller do
          Proc.new do
            data = CSV.generate do |csv|
              csv << %w(Firstname Lastname)
              @object.users.pluck(:firstname, :name).each do |firstname, name|
                csv << [firstname, name]
              end
            end
            send_data data, type: 'text/csv; charset=utf-8; header=present', disposition: "attachment; filename=#{@object.event_label}.csv"
          end
        end
      end
    end
  end
end
