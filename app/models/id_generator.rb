module IdGenerator
  ALPHA_NUM = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz'.freeze
  KEY_SIZE = ALPHA_NUM.length
  DEFAULT_LENGTH = 8

  def self.new_id(len = DEFAULT_LENGTH)
    str = ''
    len.times do
      str << ALPHA_NUM[rand(KEY_SIZE)]
    end

    str
  end
end
