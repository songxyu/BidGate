cd ..

@echo on

echo add email, password, signup_time, last_signin_time, last_signin_ip,  on table users

rails generate migration AddColumnsToUsers email:string  password:string  signup_time:datetime  last_signin_time:datetime  last_signin_ip:string

pause