# Arquivo inicializador de dados

::User.find_or_initialize_by(email: 'admin@gearhead.com.br').tap do |user|
  user.name = 'Administrador'
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

::User.find_or_initialize_by(email: 'matheusberns@gearhead.com.br').tap do |user|
  user.name = 'Matheus'
  user.nickname = 'Berns'
  user.birthday = '1999-04-16'
  user.cellphone = '47992853827'
  user.cpf = ''
  user.password = DEFAULT_PW
  user.password_confirmation = DEFAULT_PW
  user.is_admin = false
  user.active = true
  user.deleted_at = nil
  user.save!
end

::User.find_or_initialize_by(email: 'matheusborges@gearhead.com.br').tap do |user|
  user.name = 'Matheus'
  user.nickname = 'Borges'
  user.birthday = ''
  user.cellphone = ''
  user.cpf = ''
  user.password = DEFAULT_PW
  user.password_confirmation = DEFAULT_PW
  user.is_admin = false
  user.active = true
  user.deleted_at = nil
  user.save!
end