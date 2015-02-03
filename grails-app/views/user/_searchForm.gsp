<!-- Breadcrumb -->
<div class="bread-crumb pull-right">
    <g:form url='[controller: "search", action: "userSearch"]'
            id="searchableForm"
            name="searchableForm"
            method="get"
            class="navbar-search">
        <g:textField name="q" value="${params.q}" size="50" class="search-query" placeholder="Search User"/>
    </g:form>

    <g:set var="haveQuery" value="${params.q?.trim()}"/>
    <g:set var="haveResults" value="${searchResult?.results}"/>

</div>