public without sharing class AnimalLocator {

    private static String getAnimalNameById(Integer animalId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        String animalName;

        // Set endpoint with dynamic Id passed into the method
        // Set the GET method as we want to return values from the endpoint
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + animalId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200){
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            // Generate a map of attributes for the Animal object
            Map<String, Object> animalAttributes = (Map<String, Object>) results.get('animal');

            // Stringify the value of the name attribute to return
            animalName = String.valueOf(animalAttributes.get('name'));
        }

        return animalName;
    }
}