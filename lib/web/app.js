import { angular } from "@angular-wave/angular.ts";

angular.module("app", []).config([
  "$stateProvider",
  "$locationProvider",
  ($stateProvider, $locationProvider) => {
    $locationProvider.hashPrefix = "";
    $locationProvider.html5Mode({
      enabled: true,
      requireBase: false,
      rewriteLinks: false,
    });

    $stateProvider.state({
      name: "home",
      url: "/",
      templateUrl: "/_home",
    });
  },
]);
