# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "google"
    uid "robbie@rocketfuelinc.com"
    name "Robbie the Robot"
  end
end
