module UseCase
  module Alerts
    class UpdateStatus
      attr_accessor :alert
    
      def initialize(alert_id:)
        get_alert(alert_id: alert_id)
      end

      def call
        raise "Record not found" if self.alert.blank?
        update_status
      end

      private
      def get_alert(alert_id:)
        self.alert = Alert.find_by_reference_id(alert_id)
      end

      def update_status
        self.alert.status = Alert::DONE
        self.alert.save
      end
    end
  end
end