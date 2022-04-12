package com.dao;

import com.entities.Categories;
import com.entities.Post;
import com.entities.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

//import javax.smartcardio.Card;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Categories> getAllCategories() {
        ArrayList<Categories> list = new ArrayList<>();

        try {
            String q = "select * from categories";
            PreparedStatement pstmt = con.prepareStatement(q);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Categories c = new Categories(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean getOtherCategory(Categories cat) {
        boolean f = false;
        try {
            String q = "insert into categories(name,description) values(?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(q);

            pstmt.setString(1, cat.getName());
            pstmt.setString(2, cat.getDescription());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;

    }

    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    public int getCategoryId(String name) {
        int cid = 0;
        try {
            String q = "select * from categories where name=?";
            PreparedStatement pstmt = con.prepareStatement(q);

            pstmt.setString(1, name);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                cid = set.getInt("cid");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cid;
    }
    //get all posts 

    public List<Post> getAllPosts() throws SQLException {
        List<Post> list = new ArrayList<>();

        //fetch all posts
        try {
            PreparedStatement p = con.prepareStatement("select * from posts order by pId desc");

            ResultSet set = p.executeQuery();

            while (set.next()) {
                int pId = set.getInt("pId");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                Post post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> getPostbyCatId(int catId) {
        List<Post> list = new ArrayList<>();
        //fetch all post by id;
        try {
            PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();

            while (set.next()) {
                int pId = set.getInt("pId");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");

                int userId = set.getInt("userId");

                Post post;
                post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post getPostbyPostId(int postId) {
        Post p = null;
        String q = "select * from posts where pId=?";

        try {

            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1, postId);

            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                int pId = set.getInt("pId");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                p = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

  

}
