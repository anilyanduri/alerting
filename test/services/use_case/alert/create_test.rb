require 'test_helper'

class UseCaseAlertsCreate < ActiveSupport::TestCase
  test "should create an alert" do
    params = {
        "alert": {
              "reference_id": "transcription_start_1",
              "delay": 60,
              "description": "Transcription not yet started"
        } 
      }
    ac = UseCase::Alerts::Create.new(create_params: params)
    alert = ac.call
    assert alert.kind_of?(Alert)
  end

  test "should not create an alert" do
    params = {
        "alert": {
              "reference_id": "transcription_start_1",
              "description": "Transcription not yet started"
        } 
      }
    assert_raises(Exception){seCase::Alerts::Create.new(create_params: params)}
  end
end
