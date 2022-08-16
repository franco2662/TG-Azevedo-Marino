from .models import *
from .serializers import *
import hashlib

def user_get_password(pass_text):
    password = pass_text.encode('utf-8')
    result = hashlib.sha256(password).hexdigest()
    return result