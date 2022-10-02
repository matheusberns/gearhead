# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable, :omniauthable, :confirmable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  include DeviseTokenAuth::Concerns::User

  # Accessors

  # Concerns

  # Active storage
  has_one_attached :photo

  # Enumerations

  # Belongs_to associations

  # Has_many associations

  # Many-to-many associations

  # Has-one through

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
  }
  scope :show, lambda {
    select("#{table_name}.*")
  }
  scope :autocomplete, lambda {
    select(:id, :name)
  }
  scope :birthdays, lambda {
    select("#{table_name}.*")
  }
  scope :by_name, lambda { |name|
    where("UNACCENT(#{table_name}.name) ILIKE :name",
          name: "%#{I18n.transliterate(name)}%")
  }
  scope :by_cpf, lambda { |cpf|
    where("UNACCENT(#{table_name}.cpf) ILIKE :cpf",
          cpf: "%#{I18n.transliterate(cpf)}%")
  }
  scope :by_email, ->(email) { where("UNACCENT(#{table_name}.email) ILIKE UNACCENT(:email)", email: "%#{email}%") }

  # Callbacks
  before_validation :set_uid
  before_validation :format_cpf

  # Validations
  validates_presence_of :email, {
    if: :email_required?,
    message: :need_email_or_cpf
  }
  validates_uniqueness_of :email,
                          allow_blank: true,
                          conditions: -> { where(active: true, deleted_at: nil) }
  validates_format_of :email,
                      with: /\A[^@\s]+@[^@\s]+\z/,
                      allow_blank: true,
                      if: :email_changed?

  validates_uniqueness_of :uid,
                          scope: :provider,
                          conditions: -> { where(active: true, deleted_at: nil) }

  validates_confirmation_of :password, if: :password_required?
  validates_format_of :password,
                      with: /(?=.*[a-z])(?=.*[A-Z])/,
                      message: :invalid_case_format,
                      if: -> { password.present? }
  validates_format_of :password,
                      with: /(?=.*[0-9])/,
                      message: :invalid_number_format,
                      if: -> { password.present? }
  validates_format_of :password,
                      with: /(?=.*[^A-Za-z0-9])/,
                      message: :invalid_special_character,
                      if: -> { password.present? }

  validates_uniqueness_of :uuid
  validates :name, presence: true, length: { maximum: 255 }

  validate :cpf_valid

  def administrator?
    is_admin
  end

  def keep_current_token(current_token)
    tokens.keep_if { |key| key == current_token }
    save!
  end

  def remove_all_tokens
    update_columns(tokens: {})
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  private

  def cpf_valid
    errors.add(:cpf, :invalid_format) unless ::CPF.new(cpf)&.valid? || Rails.env.test? || !cpf.present?
  end

  def set_uid
    self.uid = email
  end

  def format_cpf
    cpf&.remove!(/\W/)
  end

end
