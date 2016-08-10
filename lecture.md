# Sinatra

## Cookies
- In the header, can contain nearly anything
- We usually just put a really unique identifier and store the actual information someplace else (like our DB, or an application cache)
- `cookies[:something] = 'foobar'`
- Never trust cookie data with authentication or access control. ie `cookie[:user_id] = 1 or cookie[:is_admin] = true`

## Sessions
- Uses a cookie to identify the user and session
- data stored in the session hash is local to the app, but not shared to the client directly. Indirectly, you may show information from the session like: Who is logged in, items in their shopping cart, etc.

## Login
- Started off with storing the password in clear text in the database.
- Made a migration to remove our `password` and replace it with `password_hash`. Then implemented BCrypt::Password reader/writer accessors on `password` for our User model.
- Updated our code to find a user by email only, then compare the password. Discussed why order matters in this comparison.
- BCrypt: https://github.com/codahale/bcrypt-ruby

A very quick look at partials in Sinatra using `erb :partial_name, locals: { item: value }` in an erb.


## Flash Messages

https://github.com/treeder/rack-flash

---

# TODO
- flash
- partials
- helpers
- before
- bcrypt

## A review of HTTP methods and status codes:
- response codes: https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
- idempotency: http://restcookbook.com/HTTP%20Methods/idempotency/
- Why we use a DELETE method vs a GET with a delete action to delete stuff.

Then onto more sinatra features!
- Use our skeleton downloaded as a ZIP for your apps:
  https://github.com/lighthouse-labs/sinatra-skeleton
 - halt your action on an error and return a status
 ```ruby
 halt :403, "No Thank You"
 ```
 - before and after for all your actions
 ```ruby
 before do
   @promo = Promo.todays_promo
```
- We can use before on a named route as well
```ruby
before '/admin*' do
  redirect '/login' if !logged_in?
  halt 403 if !is_admin?
end
```

More sinatra reading: http://www.sinatrarb.com/intro.html

BCrypt: https://github.com/codahale/bcrypt-ruby

Best practices on resetting passwords: https://www.owasp.org/index.php/Forgot_Password_Cheat_Sheet
