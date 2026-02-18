import { angular } from "@angular-wave/angular.ts";

angular
  .module("app", [])
  .config([
    "$stateProvider",
    ($stateProvider) => {
      $stateProvider.state({
        name: "test",
        url: "/",
        template: "test app"
      })
    },
  ]);
