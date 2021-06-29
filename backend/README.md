# User data structure
```json
{
  "id": "0001",
  "name": "Andrew"
}
```

# Device information data structure
```json
  {
    "id": "3i-A4-2018-31",
    "brand": "APPLE",
    "name": "iPhone 6S",
    "color": "black",
    "os": "iOS 10",
    "available": true,
    "description": "액정 파손"
  }
```

# Reservation data structure
```json
{
  "device_id": "3i-A4-2018-31",
  "reserver_name": "Andrew",
  "start_date": "",
  "end_date": "",
  "start_time": "",
  "end_time": ""
}
```


## lombok 

Lombok is used to reduce boilerplate code for model/data objects

 It can generate getters and setters for those object automatically by using Lombok annotations. The easiest way is to use the @Data annotation.


Official page - https://projectlombok.org/
Introduction_kr - https://taetaetae.github.io/2017/02/22/lombok/
