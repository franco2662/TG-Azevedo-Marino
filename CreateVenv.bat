if not exist %~dp0\backend\venv (
call cd backend
call python -m venv venv
call venv\Scripts\activate.bat
call pip install -r requirements.txt
call deactivate
call cd ..
)

