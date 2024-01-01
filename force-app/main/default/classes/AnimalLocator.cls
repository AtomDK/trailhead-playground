public without sharing class AnimalLocator {

    private static String getAnimalNameById(Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        String animalName;

        // Set endpoint with dynamic Id passed into the method
        // Set the GET method as we want to return values from the endpoint
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');

        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200){
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, String> results = (Map<String, String>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            animalName = results.get('name');
        }

        return animalName;
    }
}