module Email
  class Message

    attr_accessor :subject, :from, :to, :date, :msgid

    def initialize(m)
      #@envelope = m.envelope
      @subject   = m.subject
      @from      = m.from.first.mailbox + '@' + m.from.first.host
      @to        = m.to.first.mailbox + '@' + m.to.first.host
      @date      = m.date.to_time
      @msgid     = m.message_id
      @gmailobj  = m
      @co        = nil
      @label     = nil
      @export    = nil
      @result    = nil
      @i         = nil
    end

    def process
      Rails.logger.info "SFDCID = #{sfdcid}"
      begin
        @i = ::Importer.new(self.sfdcid,@msgid).import
        @co = @i.campaign_order
        @label = 'ICF/imported'
        @export = true
      rescue Exceptions::OpportunityAlreadyImportedLocallyAndNotForcedError => e
        Rails.logger.error "Exceptions::OpportunityAlreadyImportedLocallyAndNotForcedError"
        @result = "This opportunity was already imported in the ICF database. (CO##{e.message})"
        @co = CampaignOrder.find_by(sfdcid: sfdcid)
        @label = 'ICF/notcreated'
        @export = true
      rescue Exceptions::MissingSalesForceOpportunityID => f
        Rails.logger.error "MissingSalesForceOpportunityID"
        @result = "Not a valid SalesForce Opportunity ID: SFDCID=#{f.message}"
        @co = nil
        @label = 'ICF/error'
        @export = false
      rescue Exceptions::JiraAlreadyExistsError => g
        Rails.logger.error "Exceptions::JiraAlreadyExistsError"
        @result = "A JIRA for this opportunity already exists #{g.message}"
        @co = nil
        @label = 'ICF/skipped'
        @export = false
      rescue => h
        Rails.logger.error "Exceptions::General"
        @result = "Different exception #{h.message}"
        @label = 'ICF/error'
        @export = false
      ensure
        Rails.logger.error "Ensuring the rest..."
        @label = 'ICF/error' if (!@label or @label.nil?)
        self.move_to(@label)
        self.archive!
      end
      Rails.logger.warn "#{@result}"
      unless (!@co || @co.nil?)
        @co.messageid = self.msgid
        @co.result = @result
        @i.campaign_order = @co
        @i.export if @export
      end
    end


    def sfdcid
      r = @subject.match (/0068000000\w{5}/)
      r.nil? ? false : r[0]
    end

    def archive!
      @gmailobj.archive!
    end

    def move_to(predefinedlabel)
      @gmailobj.add_label(predefinedlabel)
    end

  end

end
