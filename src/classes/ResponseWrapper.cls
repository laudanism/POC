global with sharing class ResponseWrapper {
    global String Success;
    global String Message;
    global List<Double> Records;

    global ResponseWrapper(String success, String message, List<Double> records)
    {
    	Success = success;
    	Message = message;
        Records = new List<Double>();
        Records = records;
    }
}