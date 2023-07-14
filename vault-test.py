import requests

# Vault API endpoint
vault_url = 'https://vault.example.com/v1'

# Credentials for authentication
username = 'your_username'
password = 'your_password'

# Path to the secret in Vault
secret_path = 'secret/mysecret'

# Construct the API URL
api_url = f'{vault_url}/{secret_path}'

# Send GET request to retrieve the secret
response = requests.get(api_url, auth=(username, password))

# Check if the request was successful
if response.status_code == 200:
    # Extract the secret value from the response
    secret_data = response.json()['data']
    secret_value = secret_data['key_name']  # Replace with your specific key name
    print(f"The secret value is: {secret_value}")
else:
    print(f"Failed to retrieve secret. Status code: {response.status_code}")
    print(f"Response content: {response.text}")
