#The Open Education Resource Handler

Målgruppen till denna tjänst är främst lärare och utbildare som använder sig av öppna digitala lärresurser i sin undervisning. Detta kan vara bilder, videoklipp, artiklar, blogginlägg, exempelkod m.m. som kan tänkas länkas in som lärresurser i en kurs. Tjänsten samlar liknande resurser för ett kollegium.

##Exempel
###Postman
Här finns det en postman collection som man kan importera för att testa apiet.
[Postman collection](https://www.getpostman.com/collections/f2092af5b7d587bdf6fd)

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
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om ingen resurs hittas så returneras en 404 Not Found samt en error body.
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
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om resursen inte hittas så returneras en 404 Not Found samt en error body.
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
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om ingen resurs hittas så returneras en 404 Not Found samt en error body.
####Ta bort en resurs
För att ta bort en resurs så måste den auktoriserad användaren äga resursen.
```
http://localhost:3000/api/v1/resource/:id?apikey=yourapikey
```
#####Resultat
Här returneras en 204 no content status.
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om användaren inte äger resursen så returneras en 403 Forbidden.

Om resursen inte hittas så returneras en 404 Not Found.

Om användaren har fel inloggningsuppgifter så returneras en 401 Unauthorized.
####Ändra en resurs
```
http://localhost:3000/api/v1/resource/:id?apikey=yourapikey
```
För att ändra en resurs så skickar man en json body till servern med de parametrar man vill uppdatera.
Man måste ha parametren "resource", annars så är alla parametrar frivilliga om man vill ha med eller inte. Om en parameter är tom så kommer den inte att uppdateras.
```
{
  "resource": {
    "resourcetype":"", 
    "licencetype":"",
    "description":"",
    "url":"",
    "name":"",
    "tags":[
      "",
      ...
    ]
  }
}
```
#####Resultat
Man får tillbaka den uppdaterade resursen.
```
{
  "status": 200,
  "resource": {
    "resource_id": 11,
    "resource_name": "Updated pic",
    "description": "This is a updated picture",
    "url": "/testpic",
    "created": "2014-02-17T21:44:19.097Z",
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
        "tag": "Helpfull"
      }
    ]
  }
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om parameternas värde inte går igenom valideringen så returneras en 400 Bad Request.

Om den auktoriserade användaren inte äger resursen som ska ändras så returneras en 403 Forbidden.

Om parametern "resource" fattas så returneras en 400 Bad Request.

Om resursen inte finns så returneras en 404 Not Found.

Om användaren har fel inloggningsuppgifter så returneras en 401 Unauthorized.
####Skapa en resurs
```
http://localhost:3000/api/v1/resource?apikey=yourapikey
```
När man ska skapa en resurs så måste man ha med "resourcetype", "licencetype", "name" och "url".
```
{
  "resource": {
    "resourcetype":"Picture",
    "licencetype":"Attribution CC BY",
    "description":"A awesome picture",
    "url":"/awesomepic",
    "name":"My awesome picture",
    "tags":[
      "Picture",
      "Awesome"
    ]
  }
}
```
#####Resultat
```
{
  "status": 201,
  "resource": {
    "resource_id": 18,
    "resource_name": "My awesome picture",
    "description": "A awesome picture",
    "url": "/awesomepic",
    "created": "2014-02-20T15:37:40.321Z",
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
        "tag": "Awesome"
      }
    ]
  }
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om parameternas värde inte går igenom valideringen så returneras en 400 Bad Request.

Om parametrar som måste finnas saknas så returneras en 400 Bad Request.

Om parametern "resource" fattas så returneras en 400 Bad Request.

Om användaren har fel inloggningsuppgifter så returneras en 401 Unauthorized.
###License
####Hämta alla licenser
```
http://localhost:3000/api/v1/licence?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "licences": [
    {
      "id": 1,
      "licence": "Attribution CC BY"
    },
    ....
  ]
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om inga licenser hittas så returneras en 404 Not Found.
####Hämta alla resurser för en license
```
http://localhost:3000/api/v1/licence/:id?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "licenceid": {
    "id": 1,
    "licence": "Attribution CC BY"
  },
  "resources": [
    {
      "resource_id": 7,
      "resource_name": "My Document",
      "description": "Document",
      "url": "/test7",
      "created": "2014-02-12T22:49:55.000Z",
      "resource_type": {
        "id": 7,
        "resourcetype": "Excel"
      },
      "user": {
        "firstname": "Sarah",
        "lastname": "Connor",
        "username": "sarah",
        "email": "sarah@terminator.com"
      },
      "licence": {
        "id": 1,
        "licence": "Attribution CC BY"
      },
      "tags": [
        {
          "tag": "Optional"
        }
      ]
    },
    ....
  ]
}
```
#####Error
Om den efterfrågade resursen inte finns så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
###Resourcetype
####Hämta alla resurstyper
```
http://localhost:3000/api/v1/resourcetype?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "resourcetypes": [
    {
      "id": 1,
      "resourcetype": "Picture"
    },
    ....
  ]
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om inga resurstyper hittas så returneras en 404 Not Found.
####Hämta alla resurser för en resurstyp
:resourcetype är en sök sträng. Där skriver man in vilken resurstyp man vill söka efter och hämtar alla resurser för den resurstypen.
```
http://localhost:3000/api/v1/resourcetype/:resourcetype?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "result": [
    {
      "resourcetype": {
        "id": 1,
        "resourcetype": "Picture"
      },
      "resources": [
        {
          "resource_id": 11,
          "resource_name": "Updated pic",
          "description": "This is a updated picture",
          "url": "/testpic",
          "created": "2014-02-17T21:44:19.097Z",
          "resource_type": {
            "id": 1,
            "resourcetype": "Picture"
          },
          "user": {
            "firstname": "Sarah",
            "lastname": "Connor",
            "username": "sarah",
            "email": "sarah@terminator.se"
          },
          "licence": {
            "id": 1,
            "licence": "Attribution CC BY"
          },
          "tags": [
            {
              "tag": "Helpfull"
            }
          ]
        },
        ....
      ]
    }
}
```
#####Error
Om den efterfrågade resursen inte finns så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
###Tag
####Hämta ut alla taggar
```
http://localhost:3000/api/v1/tag?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "tags": [
    {
      "tag": "Picture"
    },
    ....
  ]
}
```
#####Error
Om inga taggar hittas så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
####Hämta ut alla resurser för en tag
:tag är en parameter där tagnamnet ska skrivas in.
```
http://localhost:3000/api/v1/tag/:tag?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "tag": {
    "tag": "Picture"
  },
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
#####Error
Om den efterfrågade taggen inte finns så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
###User
####Hämta alla användare
```
http://localhost:3000/api/v1/user?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "users": [
    {
      "firstname": "Mike",
      "lastname": "Ross",
      "username": "mike",
      "email": "mike@suits.com"
    },
    ....
  ]
}
```
#####Error
Om inga användare hittas så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
####Hämta alla resurser en användare äger
:username är en sträng som innehåller en användares användarnamn.
```
http://localhost:3000/api/v1/user/:username?apikey=yourapikey
```
#####Resultat
```
{
  "status": 200,
  "username": "test",
  "resources": [
    {
      "resource_id": 11,
      "resource_name": "Updated pic",
      "description": "This is a updated picture",
      "url": "/testpic",
      "created": "2014-02-17T21:44:19.097Z",
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
            "tag": "Helpfull"
          }
      ]
    },
    ....
  ]
}
```
#####Error
Om användaren inte hittas så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

