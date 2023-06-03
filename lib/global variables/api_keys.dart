class API_KEYS{
  
  late String endPoint;
  late String project;
  late bool selfSigned;

  API_KEYS.fromAPI_KEYS(API_KEYS api_keys) {
    endPoint = api_keys.endPoint;
    project = api_keys.project;
    selfSigned = api_keys.selfSigned;
  }

  API_KEYS() {
    endPoint = 'https://cloud.appwrite.io/v1';
    project = 'Raven8617CalgaryBuddhaLumbiniKapilva';
    selfSigned = true;
  }

  String getEndPoint() {
    return endPoint;
  }

  String getProject() {
    return project;
  }

  bool getSelfSigned() {
    return selfSigned;
  }
}