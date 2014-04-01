

angular.module("TOERH.Resource").filter("tagFilter", [
    function () {
        return function (resources, selectedTag) {
            if (resources != null && selectedTag.length > 0) {
                var tmpResources = [];
                angular.forEach(selectedTag, function (tag) {
                    angular.forEach(resources, function (resource) {
                        angular.forEach(resource.tags, function (currentTag) {
                            if (angular.equals(currentTag.tag, tag)) {
                                tmpResources.push(resource);
                            }
                        });
                    });
                });
                return tmpResources;
            }
            return resources;
        };
    }
]);