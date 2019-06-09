import { NativeModules } from "react-native"

const { NativeHttpService } = NativeModules;  
console.log("Nilesh");
//NativeHttpService.get("","").then(result=> console.log(result)).catch(error=> console.log(error));
console.log("Gokhale");
export default NativeHttpService;