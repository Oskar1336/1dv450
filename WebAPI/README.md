#The Open Education Resource Handler

Målgruppen till denna tjänst är främst lärare och utbildare som använder sig av öppna digitala lärresurser i sin undervisning. Detta kan vara bilder, videoklipp, artiklar, blogginlägg, exempelkod m.m. som kan tänkas länkas in som lärresurser i en kurs. Tjänsten samlar liknande resurser för ett kollegium.

##Exempel
###Postman
Här finns det en postman collection som man kan importera för att testa apiet.
[Postman collection](https://www.getpostman.com/collections/1d5278291cc9110e115a)

###Resurser
####Hämta alla resurser
```
http://localhost:3000/api/v1/resource?apikey=yourapikey
```
#####Resultat
```
{
	"status": 200,
	"resources": [
		{
      "resource_id": 2,
      "resource_name": "Test2",
      "description": "Test2",
      "url": "/test2",
      "created": "2014-02-12T22:48:40.000Z",
      "resource_type": {
          "id": 2,
          "resourcetype": "Media"
      },
      "user": {
          "firstname": "Mike",
          "lastname": "Ross",
          "username": "mike",
          "email": "mike@suits.com"
      },
      "licence": {
          "id": 2,
          "licence": "Attribution-ShadeAlike CC BY-SA"
      },
      "tags": [
          {
              "tag": "School"
          }
      ]
  	},
  	....
	]
}
```
####Hämta ut en resurs
```
http://localhost:3000/api/v1/resource/:id?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "resource": {
    "resource_id": 2,
    "resource_name": "Test2",
    "description": "Test2",
    "url": "/test2",
    "created": "2014-02-12T22:48:40.000Z",
    "resource_type": {
      "id": 2,
      "resourcetype": "Media"
    },
    "user": {
      "firstname": "Mike",
      "lastname": "Ross",
      "username": "mike",
      "email": "mike@suits.com"
    },
    "licence": {
      "id": 2,
      "licence": "Attribution-ShadeAlike CC BY-SA"
    },
    "tags": [
      {
        "tag": "School"
      }
    ]
  }
}
```
####Sök efter resurs
För att söka efter en resurs så krävs parametern resourcename. Man söker då på resursnamnet.
```
http://localhost:3000/api/v1/resource?apikey=yourapikey&resourcename=pic
```
#####Resultat
```
{
  "status": 200,
  "resources": [
    {
      "resource_id": 14,
      "resource_name": "Updated pic",
      "description": "This is a updated picture",
      "url": "/testpic",
      "created": "2014-02-17T22:46:51.091Z",
      "resource_type": {
        "id": 1,
        "resourcetype": "Picture"
      },
      "user": {
        "firstname": "Testuser",
        "lastname": "Testing",
        "username": "test",
        "email": "test@test.se"
      },
      "licence": {
        "id": 1,
        "licence": "Attribution CC BY"
      },
      "tags": [
        {
          "tag": "Picture"
        },
        {
          "tag": "Helpfull"
        },
        {
          "tag": "Work"
        },
        {
          "tag": "School"
        }
      ]
    },
    ....
  ]
}
```
####Ta bort en resurs
För att ta bort en resurs så måste den auktoriserad användaren äga resursen.
```

```
#####Resultat
```

```
