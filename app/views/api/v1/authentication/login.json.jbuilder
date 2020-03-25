json.user do
  json.id @user.id
  json.name @user.name
  json.username @user.username
  json.email @user.email
end
json.token @token
json.time @time
json.status @status
