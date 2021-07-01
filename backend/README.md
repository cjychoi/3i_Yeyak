# User data structure
```json
{
  "id": "%s",
  "user_name": "Andrew",
  "team": "Mobile"
}
```

# Device information data structure
```json
  {
    "device_id": "3i-A4-2018-31",
    "manufacturer": "APPLE",
    "model": "iPhone 6S",
    "color": "black",
    "os": "iOS 10",
    "availability": true,
    "description": "액정 파손"
  }
```

# Reservation data structure
```json
{
  "device_id": "3i-A4-2018-31",
  "reservation_name": "Andrew",
  "start_date": "",
  "end_date": "",
  "start_time": "",
  "end_time": ""
}
```

Lombok is used to reduce boilerplate code for model/data objects

 It can generate getters and setters for those object automatically by using Lombok annotations. The easiest way is to use the @Data annotation.


Official page - https://projectlombok.org/
Introduction_kr - https://taetaetae.github.io/2017/02/22/lombok/
