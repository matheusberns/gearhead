class EnablePostgresqlExtensions < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'unaccent'
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'
  end
end
