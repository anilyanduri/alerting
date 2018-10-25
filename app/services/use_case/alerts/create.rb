module UseCase
  module Alerts
    class Create
    
      include ActiveModel::Validations
      attr_accessor :create_params
      validate :validate_data
    
      # {
      #   "alert": {
      #         "reference_id": "transcription_start_1",
      #         "delay": 60,
      #         "description": "Transcription not yet started"
      #   } 
      # }
      def initialize(create_params:)
        self.create_params = create_params.with_indifferent_access
        validate!
      end

      def call
        alert = Alert.new( 
                      reference_id: self.create_params.dig("alert", "reference_id"),
                      delay: self.create_params.dig("alert", "delay"),
                      description: self.create_params.dig("alert", "description"),
                      expiery_at: (Time.now + self.create_params.dig("alert", "delay").seconds),
                      status: Alert::INIT
                    )
        alert.save!
        return alert
      end

      def validate_data
        Rails.logger.info "In validate_data method #{self.create_params}"
        self.errors.add(:create_params, "Input should be a json")  and return if !self.create_params.is_a?(Hash) 
        self.errors.add(:create_params, "Input should have a key `alert`")  and return if !self.create_params.dig("alert").is_a?(Hash) 
        self.errors.add(:create_params, "Input should have a key `reference_id`") if self.create_params.dig("alert", "reference_id").blank?
        self.errors.add(:create_params, "Input should have a key `delay`") if self.create_params.dig("alert", "delay").blank?
        self.errors.add(:create_params, "Input should have a key `description`") if self.create_params.dig("alert", "description").blank?
      end
    end
  end
end