from datetime import datetime

# Example mock data for users
users_data = [
    {
        "id": 1,
        "prename": "Alice",
        "surname": "Smith",
        "home_location_lat_long": (0.0,0.0),
        "age": 25,
        "interests": ["hiking", "reading", "coding"],
        "experiences": ["software developer", "volunteer"],
        "previous_activities": ["book club", "yoga class"]
    },
    {
        "id": 2,
        "prename": "Bob",
        "surname": "Johnson",
        "home_location_lat_long": (0.0,0.0),
        "age": 30,
        "interests": ["surfing", "gaming", "traveling"],
        "experiences": ["barista", "freelance writer"],
        "previous_activities": ["coding bootcamp", "photography workshop"]
    },
    {
        "id": 3,
        "prename": "Charlie",
        "surname": "Brown",
        "home_location_lat_long": (0.0,0.0),
        "age": 22,
        "interests": ["music", "drawing", "cycling"],
        "experiences": ["student", "part-time artist"],
        "previous_activities": ["art exhibition", "charity ride"]
    },
    {
        "id": 4,
        "prename": "Diana",
        "surname": "Taylor",
        "home_location_lat_long": (0.0,0.0),
        "age": 28,
        "interests": ["cooking", "dancing", "gardening"],
        "experiences": ["chef", "dance teacher"],
        "previous_activities": ["cooking class", "salsa night"]
    },
    {
        "id": 5,
        "prename": "Ethan",
        "surname": "Harris",
        "home_location_lat_long": (0.0,0.0),
        "age": 35,
        "interests": ["tech", "investing", "basketball"],
        "experiences": ["engineer", "startup founder"],
        "previous_activities": ["tech meetup", "basketball league"]
    }
]

# Example mock data for activities
activities_data = [
    {
        "id": 1,
        "activity_desc": "Hiking in the mountains",
        "time": "2024-11-25 08:00:00",
        "location_desc": "Rocky Mountains",
        "location_lat_long": (0.0,0.0),
        "registered_people_count": 3
    },
    {
        "id": 2,
        "activity_desc": "Tech meetup",
        "time": "2024-11-26 18:30:00",
        "location_desc": "Silicon Valley",
        "location_lat_long": (0.0,0.0),
        "registered_people_count": 10
    },
    {
        "id": 3,
        "activity_desc": "Cooking class",
        "time": "2024-11-27 15:00:00",
        "location_desc": "Miami Culinary School",
        "location_lat_long": (0.0,0.0),
        "registered_people_count": 5
    },
    {
        "id": 4,
        "activity_desc": "Art exhibition visit",
        "time": "2024-11-28 10:00:00",
        "location_desc": "Chicago Art Institute",
        "location_lat_long": (0.0,0.0),
        "registered_people_count": 7
    },
    {
        "id": 5,
        "activity_desc": "Salsa night",
        "time": "2024-11-29 20:00:00",
        "location_desc": "Miami Dance Studio",
        "location_lat_long": (0.0,0.0),
        "registered_people_count": 6
    }
]

# Example mock data for matchmaker entries
matchmaker_data = [
    {
        "matchmaker_id": 1,
        "user_id": 1,
        "activity_id": 1
    },
    {
        "matchmaker_id": 2,
        "user_id": 3,
        "activity_id": 2
    }
]

# Example mock data for chat, linked to specific activities via matchmaker_id
chat_data = [
    {
        "id": 1,
        "user_id": 1,
        "matchmaker_id": 1,
        "timestamp": datetime(2024, 11, 23, 10, 30),
        "message": "Hi everyone, excited to join the hiking group!"
    },
    {
        "id": 2,
        "user_id": 2,
        "matchmaker_id": 2,
        "timestamp": datetime(2024, 11, 23, 11, 0),
        "message": "Looking forward to discussing the latest in art at the meetup!"
    },
    {
        "id": 3,
        "user_id": 3,
        "matchmaker_id": 1,
        "timestamp": datetime(2024, 11, 23, 11, 15),
        "message": "Does anyone know the weather forecast for the hike?"
    },
    {
        "id": 4,
        "user_id": 5,
        "matchmaker_id": 2,
        "timestamp": datetime(2024, 11, 23, 12, 0),
        "message": "Who else is working on a drawing? Let’s connect at the meetup!"
    }
]

