import pytest
from src.app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_hello_world(client):
    """Test the main route returns Hello World!"""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, World!" in response.data