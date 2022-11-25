from .models import *
from .serializers import *
import hashlib
from datetime import datetime

def user_get_password(pass_text):
    password = pass_text.encode('utf-8')
    result = hashlib.sha256(password).hexdigest()
    return result

def format_date(date_str):
    try:
        datetime_object = datetime.strptime('01/01/1900', '%d/%m/%Y').date()
        if(str(date_str).__contains__('/')):
            datetime_object = datetime.strptime(date_str, '%d/%m/%Y').date()
            return datetime_object
        elif(str(date_str).__contains__('-')):
            datetime_object = datetime.strptime(date_str, '%d-%m-%Y').date()
            return datetime_object
        else:
            datetime_object = datetime.strptime(date_str, '%d%m%Y').date()
        return datetime_object
    except:
        datetime_object = datetime.strptime('01/01/1900', '%d/%m/%Y').date()
        return datetime_object




