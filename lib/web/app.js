import { angular } from "@angular-wave/angular.ts";

angular
  .module("app", [])
  .config([
    "$stateProvider",
    "$locationProvider",
    ($stateProvider, $locationProvider) => {},
  ]);
