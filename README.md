This API server has been deployed to Heroku at:

http://yongfook-stripe-intent-server.herokuapp.com

The client has this host already hard-coded (yes, I know, yuck) in the source:
https://github.com/yongfook/stripe-intent-client

This project uses Rails Credentials. If you would like to run this API server locally, you will need to generate your own Rails `master.key` file and set up the credentials config which then gets encrypted. The credentials config should look like:

```
secret_key_base: 

stripe_publishable_key: 
stripe_secret_key: 

development:
  stripe_webhook_key: 

production:
  stripe_webhook_key: 
```

Then run

`foreman s`
