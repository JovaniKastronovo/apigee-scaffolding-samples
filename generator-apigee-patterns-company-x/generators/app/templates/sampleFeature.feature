Feature:
	As an API consumer I should be able to call an available resource.
    <% for (let path in api.paths){ %>
    <% for (let verb in api.paths[path]){ %>
    <% if (verb.toUpperCase() === 'GET' || verb.toUpperCase() === 'POST' || verb.toUpperCase() === 'PUT'){ %>
    Scenario: Should get a successful response from a <%- verb %> transaction on <%- path %>
        Given I set User-Agent header to apickli
        <% if(verb.toUpperCase() === 'POST' || verb.toUpperCase() === 'PUT'){%>
        <% if(parameterMap[path+verb]){ %>
        And I set Content-Type header to application/json
        And I set body to <%- JSON.stringify(parameterMap[path+verb]) %>
        <% } %>
        <% } %>
            When I <%- verb.toUpperCase() %><%= verb.toUpperCase() === 'POST' ? ' to' : '' %> <%- path %>
            <% if(api.paths[path][verb].responses){%>
            <% if(Object.keys(api.paths[path][verb].responses).includes('200')){%>
            Then response code should be 200
            <% } else if(Object.keys(api.paths[path][verb].responses).includes('201')) {%>
            Then response code should be 201
            <% } else if(Object.keys(api.paths[path][verb].responses).includes('204')) {%>
            Then response code should be 204
            <% } %>
            <% } %>
    <% } %>
    <% } %>
    <% } %>
