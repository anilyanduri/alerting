module UseCase
  module Alerts
    class List
      attr_accessor :alerts, :decorated_alerts
    
      def initialize()
        self.decorated_alerts = { alerts: []}
      end

      def call
        get_alerts
        decorate
      end

      private
      def get_alerts
        self.alerts = Alert.where(status: Alert::INIT)
      end

      def decorate
        self.decorated_alerts[:alerts] = alerts.map { |alert| 
          {
            reference_id: alert.reference_id,
            delay: alert.delay,
            description: alert.description,
          }  
        }
      end
    end
  end
end