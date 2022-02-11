module PublicId
  extend ActiveSupport::Concern
  # Set public_id on an object

  included do
    before_validation do
      generate_non_duplicate_id(public_id_length) if public_id.nil?
    end
  end

  protected

  def generate_non_duplicate_id(id_length, lower_case: false)
    loop do
      possible_id = IdGenerator.new_id(id_length, lower_case)

      unless self.class.default_scoped.where(public_id: possible_id).exists?
        self.public_id = possible_id
        break
      end
    end

    attributes['public_id']
  end

  def public_id_length
    8
  end
end
