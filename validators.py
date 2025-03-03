from datetime import datetime

def validate_date(date_text):
    try:
        datetime.strptime(date_text, '%Y-%m-%d')
        return True
    except ValueError:
        return False

def validate_time(time_text):
    try:
        datetime.strptime(time_text, '%H:%M:%S')
        return True
    except ValueError:
        return False
    
def assign_register():
    today = datetime.today()
    if today < datetime.strptime("2025-01-01", '%Y-%m-%d') or today > datetime.strptime("2025-06-01", '%Y-%m-%d'):
        return True
    else:
        return False