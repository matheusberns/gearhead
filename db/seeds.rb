# Arquivo inicializador de dados

::User.find_or_initialize_by(email: 'admin@gearhead.com.br').tap do |user|
  user.name = 'Administrador'
  user.last_name = 'Gearhead'
  user.nickname = 'Admin'
  user.birthday = '2022-09-13'
  user.cellphone = '47992853827'
  user.cpf = '10281506957'
  user.password = DEFAULT_PW
  user.password_confirmation = DEFAULT_PW
  user.is_admin = true
  user.active = true
  user.deleted_at = nil
  user.save!
end