from datetime import datetime
from services.opendata.muc.activities import MunichOpenDataClient
import random
from datetime import datetime, timedelta
from models.activities import Activity
from models.users import User
from models.matchmaker import Matchmaker
from models.subscriptions import Subscription
from models.chat import Chat

def get_weekday_dates(weekday: str, time: str, x_weeks: int):
    weekdays = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
    if weekday not in weekdays:
        raise ValueError(f"Invalid weekday: {weekday}. Must be one of {weekdays}.")
    
    hour, minute = map(int, time.split(":"))
    today = datetime.now()
    target_idx = weekdays.index(weekday)
    days_until_target = (target_idx - today.weekday()) % 7
    start_date = today + timedelta(days=days_until_target)
    start_date = start_date.replace(hour=hour, minute=minute, second=0, microsecond=0)

    return [start_date + timedelta(days=7 * i) for i in range(x_weeks)]

# Example mock data for activities
opendata = MunichOpenDataClient()
activities_data = []
idx = 1
for act in opendata.fetch_sport_offers(limit=200):
    max = random.randint(2,14)
    for i in get_weekday_dates(act.weekday, act.start_time, x_weeks=1):
        activities_data.append(
            Activity(
                id=idx,
                activity_desc=act.sport,
                time=i,
                location_desc=act.school_name,
                location_lat_long=(act.latitude, act.longitude),
                registered_people_count=random.randint(0,max),
                max_people_count=max)
            )
        idx+=1

activities_data.append(
    Activity(
        id=idx+1,
        activity_desc="Sports evening at the Olympic Park",
        time=datetime(2024, 11, 25, 18, 30),
        location_desc="Olympic Park, Munich",
        location_lat_long=(48.1731, 11.5466),
        registered_people_count=1,
        max_people_count=20
    )
)

# Generate users
users_data = [
    User(
        user_id=1,
        prename="Vincent",
        surname="Johnson",
        gender="Male",
        home_location_lat_long=(48.1351, 11.5820),
        age=28,
        interests=["hiking", "tennis", "reading"],
        experiences=["marathon", "club tennis"],
        previous_activities=["Munich city run"]
    ),
    User(
        user_id=2,
        prename="Nicolai",
        surname="Smith",
        gender="Male",
        home_location_lat_long=(48.1486, 11.5690),
        age=27,
        interests=["swimming", "hiking"],
        experiences=["local yoga group"],
        previous_activities=["Open pool event"]
    ),
    User(
        user_id=3,
        prename="Sophie",
        surname="Weber",
        gender="Female",
        home_location_lat_long=(48.1186, 11.6016),
        age=25,
        interests=["dancing", "football"],
        experiences=["dance classes", "football fan club"],
        previous_activities=["Football watch party"]
    ),
    User(
        user_id=4,
        prename="Emilia",
        surname="Fischer",
        gender="Female",
        home_location_lat_long=(48.1555, 11.5976),
        age=30,
        interests=["running", "climbing"],
        experiences=["trail running", "rock climbing"],
        previous_activities=["Rock climbing event"]
    ),
    User(
        user_id=5,
        prename="Mia",
        surname="Wagner",
        gender="Female",
        home_location_lat_long=(48.1298, 11.5842),
        age=27,
        interests=["kayaking", "painting"],
        experiences=["river kayaking"],
        previous_activities=["Kayak challenge"]
    ),
    User(
        user_id=6,
        prename="Maximilian",
        surname="Huber",
        gender="Male",
        home_location_lat_long=(48.1347, 11.5551),
        age=33,
        interests=["cycling", "basketball"],
        experiences=["mountain biking"],
        previous_activities=["Basketball tournament"]
    ),
    User(
        user_id=7,
        prename="Felix",
        surname="Bauer",
        gender="Male",
        home_location_lat_long=(48.1445, 11.5799),
        age=29,
        interests=["football", "gaming"],
        experiences=["local football team"],
        previous_activities=["E-sports tournament"]
    ),
    User(
        user_id=8,
        prename="Lukas",
        surname="Schuster",
        gender="Male",
        home_location_lat_long=(48.1501, 11.5800),
        age=31,
        interests=["hiking", "photography"],
        experiences=["nature hikes"],
        previous_activities=["Photography walk"]
    ),
    User(
        user_id=9,
        prename="Jonas",
        surname="Beck",
        gender="Male",
        home_location_lat_long=(48.1223, 11.6123),
        age=26,
        interests=["rock climbing", "board games"],
        experiences=["indoor climbing"],
        previous_activities=["Climbing meetup"]
    ),
    User(
        user_id=10,
        prename="Sebastian",
        surname="Wolf",
        gender="Male",
        home_location_lat_long=(48.1388, 11.5567),
        age=34,
        interests=["cooking", "football"],
        experiences=["cooking classes"],
        previous_activities=["Charity cook-off"]
    )
]

# Generate a subscription
subscription_data = [Subscription(
    subscription_id=1,
    user=users_data[0],
    activity=activities_data[-1]
)]

# Generate a matchmaker linking Anna Müller to a similar user
matchmaker_data = [Matchmaker(
    matchmaker_id=1,
    users=[1, 2],
    activity_id=activities_data[-1].id
)]

from datetime import datetime, timedelta

# Generate chat messages
chat_data = [
]