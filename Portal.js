const reactNative = require("react-native");
const react = require('react');
const reactTransitionGroup = require("react-native-transitiongroup");
const PropTypes = require("prop-types");
const reactNavigation = require('react-navigation');

//Class to register all dependencies required by systemjs
//export default class Portal {
//const Portal = {
    export function registerDependencies (System){
        if (System) {
            System.register("react-native", ["react"], function (exports) {
                var React;
                return {
                    setters: [
                        function (React_1) {
                            React = React_1;
                        }
                    ],
                    execute: function () {
						delete reactNative.Navigator;
						delete reactNative.BackAndroid;
						delete reactNative.NavigatorIOS;
                        exports(reactNative);
                    }
                }
            });
            System.register("react", [], function (exports) {
                return {
                    setters: [],
                    execute: function () {
                        exports(react);
                    }
                }
            });
            System.register("prop-types", [], function (exports) {
                return {
                    setters: [],
                    execute: function () {
                        exports("default", PropTypes);
                    }
                }
            });
            System.register("react-navigation", [], function (exports) {
                return {
                    setters: [],
                    execute: function () {
                        exports(reactNavigation);
                    }
                }
            });
            System.register("react-native-transitiongroup", [], function (exports) {
                return {
                    setters: [],
                    execute: function () {
                        exports(reactTransitionGroup);
                    }
                }
            });
        }
    } 
    export function bootstrapPortal(System){
        return new Promise((resolve, reject) => {
            console.log("trying to import");
            System.import("IDS.Web.UI.React/ReactBootstrapper").then(module => {
                console.log("Import succesfull");
                module.default.then(component => {
                    resolve(component);
                }).catch(error => {
                    reject(error);
                })
            }).catch(error => {
                reject(error)
            });
        });
        
    }
//};

//exports.Portal = Portal;
//}
