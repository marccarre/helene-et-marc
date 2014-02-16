module BeAMultipartEmail
  class Matcher
    include RSpec::Matchers

    def matches?(mail)
      mail.body.should have(2).parts
      mail.body.parts.collect(&:content_type).should include('text/html; charset=UTF-8', 'text/plain; charset=UTF-8')
    end

    def description 
      "check that the provided 'mail' object's 'body' has 2 'parts', which themselves have appropriate 'content_type's."
    end
  end

  # Other helpers:
  def get_part (mail, content_type)
    mail.body.parts.find { |p| p.content_type.match content_type }.body.raw_source
  end

  # Factory usable in DSL:
  def be_a_multipart_email
    Matcher.new
  end
end

# Matcher available only to mailer specs:
RSpec.configure do |config|
  config.include BeAMultipartEmail, type: :mailer
end
