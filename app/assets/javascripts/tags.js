var app = window.app = {};

app.tags = function() {    
    $("select#tags_list").tokenize({
        datas: "/tags/search",
        dataType: "json",
        searchParam: "term",
        valueField: "text",
        maxElements: 5
    })
}



