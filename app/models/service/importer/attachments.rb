module Service
  module Importer
    class Attachments

      #remove slashes, unicode characters, and other filename incompatible chars from a string
      #http://stackoverflow.com/questions/1939333/how-to-make-a-ruby-string-safe-for-a-filesystem
      def sanitize_filename(filename)
        # Split the name when finding a period which is preceded by some
        # character, and is followed by some character other than a period,
        # if there is no following period that is followed by something
        # other than a period (yeah, confusing, I know)
        fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m

        # We now have one or two parts (depending on whether we could find
        # a suitable period). For each of these parts, replace any unwanted
        # sequence of characters with an underscore
        fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }

        # Finally, join the parts with a period and return the result
        return fn.join '.'
      end

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
            a.name           = sanitize_filename(f.Name)
            a.body           = f.Body
            a.content_type   = f.ContentType
            a.created_at     = f.CreatedDate
            Rails.logger.info "Imported attachment #{a.name} attributes"
            a.save!
            request = SalesForce::Client.new.http_get(a.body)
            fileloc="/tmp/#{a.name}"
            File.open(fileloc, 'wb') { |f| f.write(request.body) }
            # curl -D- -u {username}:{password} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@{path/to/image}" http://{base-url}/rest/api/2/issue/{issue-key}/attachments
            Rails.logger.info "Imported attachment #{a.name} body"
          end
        end
      end

    end

  end
end
