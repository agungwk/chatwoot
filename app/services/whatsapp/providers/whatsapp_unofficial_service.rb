class Whatsapp::Providers::WhatsappUnofficialService < Whatsapp::Providers::BaseService
  def send_message(phone_number, message)
    Rails.logger.info "configs: #{whatsapp_channel.provider_config}"
    Rails.logger.info "Sending message to #{phone_number}"
    HTTParty.post(
      'http://localhost:8086/send-wa',
      body: {
        messaging_product: 'whatsapp',
        to: phone_number,
        text: { body: message.content },
        type: 'text',
        msg: message.content
      }.to_json
    )
  end

  def send_template(phone_number, _template_info)
    Rails.logger.info "Sending template to #{phone_number}"
  end

  def sync_templates
    Rails.logger.info 'Syncing templates'
  end

  def validate_provider_config?; end

  def api_headers
    Rails.logger.info "api_headers: #{whatsapp_channel.provider_config}"
  end

  def media_url(media_id)
    Rails.logger.info "media_url: #{media_id}"
  end

  # private

  # # TODO: See if we can unify the API versions and for both paths and make it consistent with out facebook app API versions
  # def phone_id_path
  #   "https://graph.facebook.com/v13.0/#{whatsapp_channel.provider_config['phone_number_id']}"
  # end

  # def business_account_path
  #   "https://graph.facebook.com/v14.0/#{whatsapp_channel.provider_config['business_account_id']}"
  # end

  # def send_text_message(phone_number, message)
  #   response = HTTParty.post(
  #     "#{phone_id_path}/messages",
  #     headers: api_headers,
  #     body: {
  #       messaging_product: 'whatsapp',
  #       to: phone_number,
  #       text: { body: message.content },
  #       type: 'text'
  #     }.to_json
  #   )

  #   process_response(response)
  # end

  # def send_attachment_message(phone_number, message)
  #   attachment = message.attachments.first
  #   type = %w[image audio video].include?(attachment.file_type) ? attachment.file_type : 'document'
  #   attachment_url = attachment.download_url
  #   type_content = {
  #     'link': attachment_url
  #   }
  #   type_content['caption'] = message.content if type != 'audio'
  #   response = HTTParty.post(
  #     "#{phone_id_path}/messages",
  #     headers: api_headers,
  #     body: {
  #       messaging_product: 'whatsapp',
  #       'to' => phone_number,
  #       'type' => type,
  #       type.to_s => type_content
  #     }.to_json
  #   )

  #   process_response(response)
  # end

  # def process_response(response)
  #   if response.success?
  #     response['messages'].first['id']
  #   else
  #     Rails.logger.error response.body
  #     nil
  #   end
  # end

  # def template_body_parameters(template_info)
  #   {
  #     name: template_info[:name],
  #     language: {
  #       policy: 'deterministic',
  #       code: template_info[:lang_code]
  #     },
  #     components: [{
  #       type: 'body',
  #       parameters: template_info[:parameters]
  #     }]
  #   }
  # end
end
