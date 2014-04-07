module Service
  module Importer
    class Attachments

      def initialize(opportunity,campaign_order)
        Rails.logger.info "Initializing Attachments import..."
        @oppt = opportunity
        @co   = campaign_order
        import
        Rails.logger.info "Imported #{@co.attachments.size} attachments"
      end

      def import
        unless @co.io_case.nil?
          SalesForce::Attachment.find_all_by_ParentId(@co.io_case).each do |f|
            # makes a new attachment object locally
            a = @co.attachments.find_or_create_by(sfdcid: f.Id)
            # sets the normal attributes
            a.name           = f.Name
            a.body           = f.Body 
            a.content_type   = f.ContentType
            a.created_at     = f.CreatedDate
            Rails.logger.info "Imported attachment #{a.name} attributes"
            a.save!
            request = SalesForce::Client.new.http_get(a.body)
            a.body = request.body
            a.save!
            Rails.logger.info "Imported attachment #{a.name} body"
          end
        end
      end

    end

  end
end
