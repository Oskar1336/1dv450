#The Open Education Resource Handler

Målgruppen till denna tjänst är främst lärare och utbildare som använder sig av öppna digitala lärresurser i sin undervisning. Detta kan vara bilder, videoklipp, artiklar, blogginlägg, exempelkod m.m. som kan tänkas länkas in som lärresurser i en kurs. Tjänsten samlar liknande resurser för ett kollegium.

##Exempel
###Postman
Här finns det en postman collection som man kan importera för att testa apiet.
[Postman collection](https://www.getpostman.com/collections/f7608ac5f0d72e0512bd)

###Resurser
####Hämta alla resurser
```
GET: http://localhost:3000/api/v1/resource?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurser det ska vara på varje sida.
```
#####Resultat
```
{
	status: 200
  -resources: [
    {
      resource_id: 55
      resource_name: "Google"
      description: "Search engine"
      url: http://google.se
      created: "2014-03-19T16:34:22.001Z"
      updated: "2014-03-20T16:08:46.301Z"
      resource_type: {
        id: 959440
        resourcetype: "Search engine"
      }
      user: "Oskar1336"
      licence: {
        id: 1
        licence: "Attribution CC BY"
      }
      tags: [
        "Search engine"
        "Searchengine"
        "search engine"
      ]
    }
  ]
  nextPage: http://localhost:3000/api/v1/resource?apikey=yourapikey&page=2&limit=5&resourcename=Google
  previousPage: http://localhost:3000/api/v1/resource?apikey=yourapikey&page=1&limit=5&resourcename=Google
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om ingen resurs hittas så returneras en 404 Not Found samt en error body.
####Hämta ut en resurs
```
GET: http://localhost:3000/api/v1/resource/:id?apikey=yourapikey
```
#####Resultat
```
{
  status: 200
  resource: {
    resource_id: 55
    resource_name: "Google"
    description: "Search engine"
    url: http://google.se
    created: "2014-03-19T16:34:22.001Z"
    updated: "2014-03-20T16:08:46.301Z"
    resource_type: {
      id: 959440
      resourcetype: "Search engine"
    }
    user: "Oskar1336"
    licence: {
      id: 1
      licence: "Attribution CC BY"
    }
    tags: [
      "Search engine"
      "Searchengine"
      "search engine"
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
GET: http://localhost:3000/api/v1/resource?apikey=yourapikey&resourcename=pic
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurser det ska vara på varje sida.
```
#####Resultat
```
{
  status: 200
  -resources: [
    -{
      resource_id: 55
      resource_name: "Google"
      description: "Search engine"
      url: http://google.se
      created: "2014-03-19T16:34:22.001Z"
      updated: "2014-03-20T16:08:46.301Z"
      -resource_type: {
        id: 959440
        resourcetype: "Search engine"
      }
      user: "Oskar1336"
      -licence: {
        id: 1
        licence: "Attribution CC BY"
      }
      -tags: [
        "Search engine"
        "Searchengine"
        "search engine"
      ]
    }
  ]
  nextPage: http://localhost:3000/api/v1/resource?apikey=yourapikey&page=2&limit=5&resourcename=Google
  previousPage: http://localhost:3000/api/v1/resource?apikey=yourapikey&page=1&limit=5&resourcename=Google
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om ingen resurs hittas så returneras en 404 Not Found samt en error body.
####Ta bort en resurs
För att ta bort en resurs så måste den auktoriserad användaren äga resursen.
Kräver inloggning med http basic auth eller GitHub.
```
DELETE: http://localhost:3000/api/v1/resource/:id?apikey=yourapikey
```
#####Resultat
Här returneras en 204 no content status.
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om användaren inte äger resursen så returneras en 403 Forbidden.

Om resursen inte hittas så returneras en 404 Not Found.

Om användaren har fel inloggningsuppgifter så returneras en 401 Unauthorized.
####Ändra en resurs
Kräver inloggning med http basic auth eller GitHub.
```
PUT: http://localhost:3000/api/v1/resource/:id?apikey=yourapikey
```
För att ändra en resurs så skickar man en json body till servern med de parametrar man vill uppdatera.
Man måste ha parametren "resource", annars så är alla parametrar frivilliga om man vill ha med eller inte. Om en parameter är tom så kommer den inte att uppdateras.
```
{
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
```
#####Resultat
Man får tillbaka den uppdaterade resursen.
```
{
  status: 200
  -resource: {
    resource_id: 55
    resource_name: "Google"
    description: "Search engine"
    url: http://google.se
    created: "2014-03-19T16:34:22.001Z"
    updated: "2014-03-20T16:08:46.301Z"
    -resource_type: {
      id: 959440
      resourcetype: "Search engine"
    }
    user: "Oskar1336"
    -licence: {
      id: 1
      licence: "Attribution CC BY"
    }
    -tags: [
      "Search engine"
      "Searchengine"
      "search engine"
    ]
  }
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om parameternas värde inte går igenom valideringen så returneras en 400 Bad Request.

Om den auktoriserade användaren inte äger resursen som ska ändras så returneras en 403 Forbidden.

Om resursen inte finns så returneras en 404 Not Found.

Om användaren har fel inloggningsuppgifter så returneras en 401 Unauthorized.
####Skapa en resurs
Kräver inloggning med http basic auth eller GitHub.
```
POST: http://localhost:3000/api/v1/resource?apikey=yourapikey
```
När man ska skapa en resurs så måste man ha med "resourcetype", "licencetype", "name" och "url".
```
{
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
```
#####Resultat
```
{
  status: 201,
  resource: {
    resource_id: 55
    resource_name: "Google"
    description: "Search engine"
    url: http://google.se
    created: "2014-03-19T16:34:22.001Z"
    updated: "2014-03-20T16:08:46.301Z"
    -resource_type: {
      id: 959440
      resourcetype: "Search engine"
    }
    user: "Oskar1336"
    -licence: {
      id: 1
      licence: "Attribution CC BY"
    }
    -tags: [
      "Search engine"
      "Searchengine"
      "search engine"
    ]
  }
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om parameternas värde inte går igenom valideringen så returneras en 400 Bad Request.

Om parametrar som måste finnas saknas så returneras en 400 Bad Request.

Om användaren har fel inloggningsuppgifter så returneras en 401 Unauthorized.
###License
####Hämta alla licenser
```
GET: http://localhost:3000/api/v1/licence?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många licenser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många licenser det ska vara på varje sida.
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
  ],
  nextPage: http://localhost:3000/api/v1/licence?apikey=yourapikey&page=2&limit=10,
  previousPage: http://localhost:3000/api/v1/licence?apikey=yourapikey&page=1&limit=10
}
```
#####Error
Om api nyckeln inte finns eller inte är korrekt så returneras en 401 Unauthorized.

Om inga licenser hittas så returneras en 404 Not Found.
####Hämta alla resurser för en license
```
GET: http://localhost:3000/api/v1/licence/:id?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurser det ska vara på varje sida.
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
      resource_id: 55
      resource_name: "Google"
      description: "Search engine"
      url: http://google.se
      created: "2014-03-19T16:34:22.001Z"
      updated: "2014-03-20T16:08:46.301Z"
      -resource_type: {
        id: 959440
        resourcetype: "Search engine"
      }
      user: "Oskar1336"
      -licence: {
        id: 1
        licence: "Attribution CC BY"
      }
      -tags: [
        "Search engine"
        "Searchengine"
        "search engine"
      ]
    },
    ....
  ],
  nextPage: http://localhost:3000/api/v1/licence/1?apikey=yourapikey&page=2&limit=5,
  previousPage: http://localhost:3000/api/v1/licence/1?apikey=yourapikey&page=1&limit=5
}
```
#####Error
Om den efterfrågade resursen inte finns så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
###Resourcetype
####Hämta alla resurstyper
```
GET: http://localhost:3000/api/v1/resourcetype?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurstyper som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurstyper det ska vara på varje sida.
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
  ],
  nextPage: http://localhost:3000/api/v1/resourcetype?apikey=yourapikey&page=2&limit=5,
  previousPage: http://localhost:3000/api/v1/resourcetype?apikey=yourapikey&page=1&limit=5
}
```
#####Error
Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.

Om inga resurstyper hittas så returneras en 404 Not Found.
####Hämta alla resurser för en resurstyp
:resourcetype är en sök sträng. Där skriver man in vilken resurstyp man vill söka efter och hämtar alla resurser för den resurstypen.
```
GET: http://localhost:3000/api/v1/resourcetype/:resourcetype?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurser det ska vara på varje sida.
```
#####Resultat
```
{
  "status": 200,
  resources: [
    -{
      resource_id: 81
      resource_name: "Nytt test1"
      description: "test"
      url: "test"
      created: "2014-03-20T16:30:47.714Z"
      updated: "2014-03-20T16:30:47.715Z"
      -resource_type: {
        id: 959441
        resourcetype: "test"
      }
      user: "Oskar1336"
      -licence: {
        id: 1
        licence: "Attribution CC BY"
      }
      -tags: [
        "test"
      ]
    }
    ....
  ],
  nextPage: http://localhost:3000/api/v1/resourcetype/test?apikey=yourapikey&page=2&limit=5,
  previousPage: http://localhost:3000/api/v1/resourcetype/test?apikey=yourapikey&page=1&limit=5
}
```
#####Error
Om den efterfrågade resursen inte finns så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
###Tag
####Hämta ut alla taggar
```
GET: http://localhost:3000/api/v1/tag?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många taggar som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många taggar det ska vara på varje sida.
```
#####Resultat
```
{
  "status": 200,
  "tags": [
    "Picture",
    ....
  ],
  nextPage: http://localhost:3000/api/v1/tag?apikey=yourapikey&page=2&limit=5,
  previousPage: http://localhost:3000/api/v1/tag?apikey=yourapikey&page=1&limit=5
}
```
#####Error
Om inga taggar hittas så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
####Hämta ut alla resurser för en tag
:tag är en parameter där tagnamnet ska skrivas in.
```
GET: http://localhost:3000/api/v1/tag/:tag?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurser det ska vara på varje sida.
```
#####Resultat
```
{
  "status": 200,
  "tag": "test",
  "resources": [
    {
      resource_id: 81
      resource_name: "Nytt test1"
      description: "test"
      url: "test"
      created: "2014-03-20T16:30:47.714Z"
      updated: "2014-03-20T16:30:47.715Z"
      -resource_type: {
        id: 959441
        resourcetype: "test"
      }
      user: "Oskar1336"
      -licence: {
        id: 1
        licence: "Attribution CC BY"
      }
      -tags: [
        "test"
      ]
    },
    ....
  ],
  nextPage: http://localhost:3000/api/v1/tag/test?apikey=yourapikey&page=2&limit=2,
  previousPage: http://localhost:3000/api/v1/tag/test?apikey=yourapikey&page=1&limit=2
}
```
#####Error
Om den efterfrågade taggen inte finns så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
###User
####Hämta alla användare
```
GET: http://localhost:3000/api/v1/user?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många användare som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många användare det ska vara på varje sida.
```
#####Resultat
```
{
  status: 200,
  users: [
    "Oskar1336",
    ....
  ],
  nextPage: http://localhost:3000/api/v1/user?apikey=yourapikey&page=2&limit=1,
  previousPage: http://localhost:3000/api/v1/user?apikey=yourapikey&page=1&limit=1
}
```
#####Error
Om inga användare hittas så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
####Hämta alla resurser en användare äger
:username är en sträng som innehåller en användares användarnamn.
```
GET: http://localhost:3000/api/v1/user/:username?apikey=yourapikey
```
Ytterliggare parametrar:
```
&limit=number - Sätter hur många resurser som ska returneras.
&page=page - Hämtar enbart den angivna sidan. Kan komineras med &limit för att välja hur många resurser det ska vara på varje sida.
```
#####Resultat
```
{
  status: 200,
  username: "Oskar1336",
  resources: [
    {
      resource_id: 55
      resource_name: "Google"
      description: "Search engine"
      url: http://google.se
      created: "2014-03-19T16:34:22.001Z"
      updated: "2014-03-20T16:08:46.301Z"
      -resource_type: {
        id: 959440
        resourcetype: "Search engine"
      }
      user: "Oskar1336"
      -licence: {
        id: 1
        licence: "Attribution CC BY"
      }
      -tags: [
        "Search engine"
        "Searchengine"
        "search engine"
      ]
    },
    ....
  ],
  nextPage: http://localhost:3000/api/v1/user/Oskar1336?apikey=yourapikey&page=2&limit=5,
  previousPage: http://localhost:3000/api/v1/user/Oskar1336?apikey=yourapikey&page=1&limit=5
}
```
#####Error
Om användaren inte hittas så returneras en 404 Not Found.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
####Skapa en ny användare
Kräver inloggning med http basic auth eller GitHub.
```
POST: http://localhost:3000/api/v1/user?apikey=yourapikey
```
Request body
```
{
  "user":{
    "email":"",
    "name":"",
    "username":"",
    "password":""
  }
}
```
#####Resultat
```
Statuskod 204 No Content returneras.
```
#####Error
400 Om parametrarna inte går igenom valideringen.
400 Om en parameter fattas.
400 Om "user" fattas.

Om api nyckeln inte finns eller är korrekt så returneras en 401 Unauthorized.
