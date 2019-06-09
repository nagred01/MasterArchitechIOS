import React, { Component } from 'react';
import { View, Text, DeviceEventEmitter, Alert } from 'react-native';
import { Root } from 'native-base';
import { registerDependencies, bootstrapPortal } from "./Portal";
import styles from './styles';
global.styles = styles;
this.styles = styles;
import { NativeModules } from "react-native";
// const { NativeHttpService } = NativeModules;
const NativeHttpService = require('NativeModules').NativeHttpService
const devBaseUrl = "http://192.168.1.48/UI";
export default class App extends Component {

  constructor(props) {
    super(props);
  }

  componentDidMount() { 
    NativeHttpService.isdebug().then(result => {
      console.log('NativeHttpService.isdebug',result)
    })
    //NativeHttpService.isdebug((res)=> console.log('NativeHttpService',res))
    NativeHttpService.isdebug().then(result => {
      if (result === true || result === "true") {
        NativeHttpService.get("/UI/api/Native/bundle",null)
          .then(result => {
            eval(result);
            DeviceEventEmitter.addListener("backPressed", function(e) {
              if(Router){
                Router.goBack();
              }
            });
            registerDependencies(System);
            NativeHttpService.get("/UI/api/Native/Config?pageName=Accounts%2FAccountSummary",null).then(result=> {
              eval(result);
              if (HttpService) {
                HttpService.setNativeHttpService(NativeHttpService);
              }    
              if (System) {
                bootstrapPortal(System).then(component => {
                  this.setState({ component });
                }).catch(error => {
                  console.log(error);
                })
              }
            });
          })
      } else {
        console.log("non debug");
        if (System) {
          System.config({ baseUrl:""});
          console.log(System);
          if (HttpService) {
            HttpService.setNativeHttpService(NativeHttpService);
          }
              
          DeviceEventEmitter.addListener("backPressed", function(e){
            if(Router){
              Router.goBack();
            }
          });
          registerDependencies(System);
          bootstrapPortal(System).then(component => {
            console.log(component);
            this.setState({ component });
          })
        }
      }
    });  
  }

  render() {
    var val = this.state && this.state.message ? this.state.message : "Loading App please wait...";
    var App = this.state && this.state.component ? this.state.component : null;
    if (App) {
      return <Root>
        <View style={{ flex: 1, backgroundColor: '#ffffff' }}>{App}</View>
      </Root>;
    } else{
    return <Root><View style={{ flex: 1, backgroundColor: '#ffffff' }}><Text>{val}</Text></View></Root>;
    }
  }

}
