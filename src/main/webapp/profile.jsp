
<%@page import="java.util.ArrayList"%>
<%@page import="com.helper.ConnectionProvider"%>
<%@page import="com.dao.PostDao"%>

<%@page import="com.entities.Message"%>
<%@page import="com.entities.Categories"%>

<%@page import="com.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--css-->  
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 78%, 80% 100%, 39% 87%, 0 100%, 0 0);
            }
             body{
                background:url(img/backg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>

    </head>
    <body>
        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background"> 
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-bell-o"></span> Learn Code <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#"> Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> Contact</a>
                    </li>


                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-plus-circle"></span> Add Post</a>
                    </li>


                </ul>

                <ul class="navbar-nav mr-right">

                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%> </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> Log Out </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!--end of navbar-->

        <%
           
        Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>

        <div class="alert <%= m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }


        %>

        <!--profile modal-->

        <!--main body of the page-->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first column-->
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0, this)" class=" c-link list-group-item list-group-item-success primary-background  btn-outline-light btn-lg btn" >
                                All posts
                            </a>

                            <%                                PostDao dao = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Categories> list1 = dao.getAllCategories();
                                for (Categories cc : list1) {
                            %>
                            <a  href = "#" onclick="getPosts(<%= cc.getCid()%>, this)" class="c-link list-group-item list-group-item-success btn-outline-light btn-lg btn"><%= cc.getName()%></a>

                            <%
                                }
                            %>
                        </div>
                    </div>
                    <!--second column-->
                    <div class="col-md-8" >
                        <!--post-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-3x fa-spin"></i>
                            <h3 class="mt-2">Loading..........</h3>
                        </div>
                        <div class="container-fluid" id="post-container">

                        </div>      

                    </div>
                </div>


            </div>  



        </main>




        <!--end of main body of the page-->

<!--//profile modal-->
        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Techblog</h5>

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:10% ;max-width: 150px">
                            <br> 
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">Id: </th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email: </th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender: </th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Status: </th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on: </th>
                                            <td><%= user.getDateTime().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--profile edit-->
                            <div id="profile-edit"style="display: none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <th scope="row">Id: </th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email: </th>
                                            <td><input type="email" name="user_email" class="form-control" value="<%= user.getEmail()%>"></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Name: </th>
                                            <td><input type="text" name="user_name" class="form-control" value="<%= user.getName()%>"></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Password: </th>
                                            <td><input type="password" name="user_password" class="form-control" value="<%= user.getPassword()%>"></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">New Profile Picture: </th>
                                            <td><input type="file" name="image" class="form-control"></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender: </th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About: </th>
                                            <td>
                                                <textarea rows="4" class="form-control" name="user_about"><%= user.getAbout()%>
                                                </textarea>
                                            </td>

                                        </tr>
                                    </table>
                                    <div class="container" >
                                        <button type="submit" class="btn primary-background btn-lg btn-outline-light">
                                            Save
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div> 

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary primary-background text-white ">EDIT</button>
                    </div>
                </div>
            </div>
        </div>

        <!--end of profile modal-->

        <!--add post modal-->


        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide post details...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="POST">
                            <div class="form-group" id="cat">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Categories> list = postd.getAllCategories();
                                        for (Categories c : list) {
                                    %>

                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <% }%>

                                    <br>
                                </select>
                            </div> 

                            <div class="form-check">
                                <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1" onclick="myFun()">
                                <label class="form-check-label" for="exampleCheck1">Want to write in any other category</label>
                            </div>
                            <br>
                            <div class="form-group" id="cName" style="display: none" >
                                <input name="cName" type="text" placeholder="Enter Category name" class="form-control" />
                            </div>     
                            <div class="form-group" id="cDescription" style="display: none">
                                <input name="cDescription" type="text" placeholder="Enter Category description" class="form-control"/>
                            </div>     



                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>

                            </div>

                            <div class="form-group">
                                <textarea name="pContent" placeholder="Enter your content" class="form-control" style="height: 180px;"></textarea>

                            </div>
                            <div class="form-group">
                                <textarea name="pCode" placeholder="Enter your code(if any)" class="form-control"></textarea>

                            </div>

                            <div class="form-group">
                                <label>Select your pic...</label>
                                <br>
                                <input type="file" name="pic">
                            </div>

                            <div class="container text-center" >
                                <button type="submit" class="btn primary-background btn-lg btn-outline-light">Post</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>


        <!--end add post modal-->


        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script src="js/myjs.js" type="text/javascript"></script>

        <script>
                                    $(document).ready(function () {
                                        let editStatus = false;
                                        $('#edit-profile-button').click(function () {
                                            if (editStatus == false) {
                                                $("#profile-details").hide();
                                                $("#profile-edit").show();
                                                editStatus = true;
                                                $(this).text("Back");
                                            } else {
                                                $("#profile-details").show();
                                                $("#profile-edit").hide();
                                                editStatus = false;
                                                $(this).text("Edit");
                                            }

                                        });
                                    });
        </script>

        <!--add post js-->
        <script>
            $(document).ready(function (e) {
                //
                $('#add-post-form').on("submit", function (event) {
                    event.preventDefault();
                    console.log("you have clicked on submit");
                    let form = new FormData(this);
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() === 'done') {
                                swal("Good job!", "Saved Successfully", "success");
                            } else {
                                swal("Error!!", "Something went wrong, try again", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        },
                        processData: false,
                        contentType: false

                    })
                })
            })


        </script>

        <!--other category-->
        <script>
            function myFun() {

                $("#cName").show();
                $("#cDescription").show();
            }

        </script>
        <!--loading post page-->
        <script>
            function getPosts(catId, temp) {

                $('#loader').show();
                $('#post-container').hide();
                $(".c-link").removeClass('primary-background');
                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $('#loader').hide();
                        $('#post-container').show();
                        $('#post-container').html(data);
                        $(temp).addClass('primary-background');
                       }
                   });
            }
            $(document).ready(function(e){
                let allPostref=$('.c-link')[0];
                getPosts(0,allPostref);
            });
            
        </script>
        
   
        

    </body>
</html>
