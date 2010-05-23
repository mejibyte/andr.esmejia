# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_andr.esmejia.com_session',
  :secret      => '9cd6222c5eeaf2b4f6a921037c14ed8c5aef02ace4a8258cb84b1d25b06d4e57ce7e6d37c06e3aab6521c610816b4a0abbcc24cf689a2341d9e537a61a2ea36e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
