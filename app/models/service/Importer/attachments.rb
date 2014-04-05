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
            a = @co.attachments.find_or_create_by(sfdcid: f.Id)
            a.name           = f.Name
            a.content_type   = f.ContentType
            a.body           = f.Body
            a.created_at     = f.CreatedDate
            a.save!
          end
        end
      end

    end

  end
end
