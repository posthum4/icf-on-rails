require "spec_helper"

describe CampaignOrdersController do
  describe "routing" do

    it "routes to #index" do
      get("/campaign_orders").should route_to("campaign_orders#index")
    end

    it "routes to #new" do
      get("/campaign_orders/new").should route_to("campaign_orders#new")
    end

    it "routes to #show" do
      get("/campaign_orders/1").should route_to("campaign_orders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/campaign_orders/1/edit").should route_to("campaign_orders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/campaign_orders").should route_to("campaign_orders#create")
    end

    it "routes to #update" do
      put("/campaign_orders/1").should route_to("campaign_orders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/campaign_orders/1").should route_to("campaign_orders#destroy", :id => "1")
    end

  end
end
