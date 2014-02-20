#The Open Education Resource Handler

Målgruppen till denna tjänst är främst lärare och utbildare som använder sig av öppna digitala lärresurser i sin undervisning. Detta kan vara bilder, videoklipp, artiklar, blogginlägg, exempelkod m.m. som kan tänkas länkas in som lärresurser i en kurs. Tjänsten samlar liknande resurser för ett kollegium.

##Exempel
###Postman
Här finns det en postman collection som man kan importera för att testa apiet.
[Postman collection](https://www.getpostman.com/collections/1d5278291cc9110e115a)

###Resurser
####Hämta alla resurser
```
http://localhost:3000/api/v1/resource?apikey=apikey
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
