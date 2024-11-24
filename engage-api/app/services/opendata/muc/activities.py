from typing import Optional, List
from pydantic import BaseModel, Field
import requests
from typing import List, Optional

class SportOffer(BaseModel):
    id: int = Field(alias="_id", description="Unique identifier of the sport offer record")
    sport: str = Field(alias="Sportangebot", description="Type of sport activity")
    weekday: str = Field(alias="Wochentag", description="Day of the week")
    start_time: str = Field(alias="Uhrzeit_Start", description="Start time of the activity")
    end_time: str = Field(alias="Uhrzeit_Ende", description="End time of the activity")
    street: Optional[str] = Field(alias="Strasse", description="Street address")
    house_number: Optional[str] = Field(alias="Hausnummer", description="House number")
    house_number_addition: Optional[str] = Field(alias="HN-Zusatz", description="Additional information about the house number")
    district: Optional[str] = Field(alias="Stadteil", description="District in Munich")
    school_name: Optional[str] = Field(alias="Schulnamen", description="Name of the school or facility")
    latitude: Optional[float] = Field(alias="Lat", description="Latitude for geolocation")
    longitude: Optional[float] = Field(alias="Long", description="Longitude for geolocation")
    additional_info: Optional[str] = Field(alias="Zusatzinformationen", description="Additional information")
    website: Optional[str] = Field(alias="Webseite", description="Website for more information")


class MunichOpenDataClient:
    BASE_URL = "https://opendata.muenchen.de/api/3/action/datastore_search"
    
    def __init__(self):
        pass

    def fetch_sport_offers(self, limit: int = 200) -> List[SportOffer]:
        resource_id="c242c94b-4d18-4259-90a5-7e474179de47"
        """
        Fetches the sport offers from the open data API.

        Returns:
            List[SportOffer]: A list of sport offers retrieved from the API.
        """
        response = requests.get(self.BASE_URL, params={"resource_id": resource_id, "limit": limit})
        response.raise_for_status()
        data = response.json()

        if not data.get("success", False):
            raise Exception("Failed to fetch data from the API")

        records = data["result"]["records"]
        return sorted([SportOffer(**record) for record in records], key=lambda offer: offer.start_time)
