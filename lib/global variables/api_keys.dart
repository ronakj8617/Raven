class API_KEYS{
  
  late String endPoint;
  late String project;
  late bool selfSigned;

  API_KEYS.fromAPI_KEYS(API_KEYS api_keys){
    this.endPoint = api_keys.endPoint;
    this.project = api_keys.project;
    this.selfSigned = api_keys.selfSigned;
  }

  API_KEYS(){
    this.endPoint = 'https://cloud.appwrite.io/v1';
    this.project = 'Raven8617CalgaryBuddhaLumbiniKapilva';
    this.selfSigned = true;
  }  
  String getEndPoint(){
    return endPoint;
  }

  String getProject(){
    return project;
  }

  bool getSelfSigned(){
    return selfSigned;
  }
}