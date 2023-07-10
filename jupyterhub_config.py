# Import the OktaAuthenticator from the installed package
from oktaauthenticator import OktaAuthenticator

# Use OktaAuthenticator for authentication
c.JupyterHub.authenticator_class = OktaAuthenticator

# Okta configuration
c.OktaAuthenticator.okta_url = '<Okta URL>'
c.OktaAuthenticator.client_id = '<Okta Client ID>'
c.OktaAuthenticator.client_secret = '<Okta Client Secret>'
c.OktaAuthenticator.oauth_callback_url = '<Callback URL>'
