class LoadDataToOptionals < ActiveRecord::Migration[7.0]
  def change
    ::Optional.find_or_create_by(name: "Ar condicionado")
    ::Optional.find_or_create_by(name: "Direção hidráulica")
    ::Optional.find_or_create_by(name: "Vidro elétrico")
    ::Optional.find_or_create_by(name: "Trava elétrica")
    ::Optional.find_or_create_by(name: "Air bag")
    ::Optional.find_or_create_by(name: "Alarme")
    ::Optional.find_or_create_by(name: "Som")
    ::Optional.find_or_create_by(name: "Sensor de ré")
    ::Optional.find_or_create_by(name: "Câmera de ré")
    ::Optional.find_or_create_by(name: "Blindado")
    ::Optional.find_or_create_by(name: "Teto solar")
  end
end
