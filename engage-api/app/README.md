# API Documentation

This document provides an overview of the API endpoints, their respective models, and the functionality provided by each route. The API enables interaction with data related to activities, chats, matchmakers, subscriptions, and users.

---

## Models

### Activity
- **id (int):** Unique identifier for the activity.
- **activity_desc (str):** Description of the activity.
- **time (datetime):** Scheduled time of the activity.
- **location_desc (Optional[str]):** Description of the location.
- **location_lat_long (Tuple[float, float]):** Latitude and longitude of the activity location.
- **registered_people_count (int):** Number of people currently registered.
- **max_people_count (int):** Maximum capacity of the activity.

---

### Chat
- **matchmaker_id (int):** Identifier of the matchmaker associated with the chat.
- **user_id (int):** Identifier of the user sending the message.
- **timestamp (datetime):** Timestamp of the message.
- **message (str):** Content of the message.

---

### Matchmaker
- **matchmaker_id (Optional[int]):** Unique identifier for the matchmaker.
- **users (List[int]):** List of user IDs involved in the matchmaker.
- **activity_id (int):** Identifier of the associated activity.

---

### Subscription
- **subscription_id (Optional[int]):** Unique identifier for the subscription.
- **user (User):** Details of the user who subscribed.
- **activity (Activity):** Details of the activity subscribed to.

---

### User
- **user_id (Optional[int]):** Unique identifier for the user.
- **prename (str):** User's first name.
- **surname (str):** User's last name.
- **gender (str):** User's gender.
- **home_location_lat_long (Tuple[float, float]):** Home latitude and longitude.
- **age (int):** User's age.
- **interests (List[str]):** User's interests.
- **experiences (List[str]):** User's previous experiences.
- **previous_activities (List[str]):** List of previous activities participated in by the user.

---

## Endpoints

### Activity Routes

#### Get All Activities
**GET** `/activities/`
- **Parameters:** 
  - `categories (List[str])`: Categories to filter activities.
- **Response:** `List[Activity]`

#### Get Single Activity
**GET** `/activities/{activity_id}`
- **Parameters:** 
  - `activity_id (int)`: ID of the activity to retrieve.
- **Response:** `Activity`

#### Create Activity
**POST** `/activities/`
- **Request Body:** `Activity`
- **Response:** `Activity`

#### Delete Activity
**DELETE** `/activities/{activity_id}`
- **Parameters:**
  - `activity_id (int)`: ID of the activity to delete.
- **Response:** 
  - `{"message": "Activity deleted successfully"}`

---

### Chat Routes

#### Get Messages
**GET** `/chats/{matchmaker_id}`
- **Parameters:**
  - `matchmaker_id (int)`: ID of the matchmaker to retrieve messages for.
- **Response:** `List[Chat]`

#### Send Message
**POST** `/chats/send_message`
- **Request Body:** `Chat`
- **Response:** `Chat`

---

### Matchmaker Routes

#### Get All Matchmakers
**GET** `/matchmakers/`
- **Response:** `List[Matchmaker]`

#### Accept Match
**POST** `/matchmakers/accept_match`
- **Request Body:** 
  - `users (List[int])`: List of user IDs to match.
  - `activity_id (int)`: ID of the activity.
- **Response:** `int` (New matchmaker ID)

#### Delete Matchmaker
**DELETE** `/matchmakers/{matchmaker_id}`
- **Parameters:**
  - `matchmaker_id (int)`: ID of the matchmaker to delete.
- **Response:** 
  - `{"message": "Matchmaker deleted successfully"}`

---

### Subscription Routes

#### Get All Subscriptions
**GET** `/subscriptions/`
- **Response:** `List[Subscription]`

#### Subscribe to an Activity
**POST** `/subscriptions/subscribe`
- **Request Body:** `Subscription`
- **Response:** `Subscription`

#### Find Matching Subscription
**GET** `/subscriptions/find_matching_subscription/`
- **Parameters:**
  - `user_id (int)`: ID of the user looking for a subscription.
  - `preferences (List[str])`: List of user preferences.
- **Response:** `Subscription`

#### Delete Subscription
**DELETE** `/subscriptions/{subscription_id}`
- **Parameters:**
  - `subscription_id (int)`: ID of the subscription to delete.
- **Response:** 
  - `{"message": "Subscription deleted successfully"}`

---

### User Routes

#### Get All Users
**GET** `/users/`
- **Response:** `List[User]`

#### Get Single User
**GET** `/users/{user_id}`
- **Parameters:**
  - `user_id (int)`: ID of the user to retrieve.
- **Response:** `User`

#### Create User
**POST** `/users/`
- **Request Body:** `User`
- **Response:** `User`

#### Delete User
**DELETE** `/users/{user_id}`
- **Parameters:**
  - `user_id (int)`: ID of the user to delete.
- **Response:** 
  - `{"message": "User deleted successfully"}`

---

## Notes
1. **Error Handling:** All endpoints return appropriate HTTP status codes and error messages when issues arise (e.g., `404` for not found, `400` for bad request).
2. **Global Variables:** Placeholder data (`activities_data`, `chat_data`, etc.) are used in the examples for managing in-memory storage.
3. **Scalability:** Database integration and enhanced filtering/sorting capabilities are recommended for production use.
