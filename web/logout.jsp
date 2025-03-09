<%-- 
    Document   : logout
    Created on : 9 Mar 2025, 13:15:24
    Author     : Sanduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Clear the session
    session.invalidate();

    // Redirect to the login page
    response.sendRedirect("login.jsp");
%>