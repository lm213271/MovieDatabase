// JDBC libraries
import java.sql.*;

// JDK libraries
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.Scanner;
import java.util.HashMap;
import java.util.*;


public class MoviesDatabase{
   // Instance variables
   private String Username;
   private String Password;
   private Connection conn;
   
    // DB connection properties
   private String driver = "oracle.jdbc.driver.OracleDriver";
   private String jdbc_url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
   
   // Arrays storing information about the database
   private String[] Tables = {"Member", "Profile", "Watch", "Movie", "Genre", "Likes_Genre", "Movie_Genre", "Actor", "Starred_By"};
   private int[] numAttr = {5, 2, 4, 5, 1, 3, 2, 3, 2};
   private String[][] attrList = {{"member_ID", "first_name", "last_name", "card_number", "exp_date"},
            {"member_ID", "profile_name"},
            {"member_ID", "profile_name", "movie_ID", "rating"},
            {"movie_ID", "title", "movie_year", "producer", "avg_rating"},
            {"m_genre"},
            {"member_ID", "profile_name", "m_genre"},
            {"movie_ID", "m_genre"},
            {"actor_ID", "first_name", "last_name"},
            {"movie_ID", "actor_ID"}};
            
   /**
   * Default constructor
   */
   public MoviesDatabase(){}
   
   /**
   * Set the login information
   */
   private void setLogin(String user, String pass){
      this.Username = user;
      this.Password = pass;
   }
   
   /** 
   * Get the connection for the database
   * @return java.sql.Connection object
   */
   private Connection getConnection() {
    // Register the JDBC driver
      try {
         Class.forName(driver);
      } catch (ClassNotFoundException e) {
         e.printStackTrace();
      }
    // Create a connection
      Connection connection = null;
      try {
         connection = DriverManager.getConnection (jdbc_url, Username, Password);
      } catch (SQLException e) {
         e.printStackTrace();
      }
      this.conn = connection;
      return connection;
   }
  
  /**
   * Close the database connection
   * @param connection
   * @throws SQLException
   */
   public void close(Connection connection) throws SQLException{
      try{
         connection.close();
      } 
      catch (SQLException e){
         throw e;
      }
   }
  
   /**
   * Print the menu of options
   */
   private void printMenu(){
      System.out.println("\nPlease select a menu option");
      System.out.println("-----------------------------");
      System.out.println("1 - View table content");
      System.out.println("2 - Insert new record");
      System.out.println("3 - Update record");
      System.out.println("4 - Search for movies");
      System.out.println("5 - Display member's profile");
      System.out.println("6 - Exit");
   }
   
   /**
   * Print the available tables
   */
   private void printTableOptions(String custom){
      System.out.println("\nPlease select a table to "+custom);
      System.out.println("-----------------------------------");
      System.out.println("1 - Member");
      System.out.println("2 - Profile");
      System.out.println("3 - Watch");
      System.out.println("4 - Movie");
      System.out.println("5 - Genre");
      System.out.println("6 - Likes_Genre");
      System.out.println("7 - Movie_genre");
      System.out.println("8 - Actor");
      System.out.println("9 - Starred_By");
   }
   
   /**
   * Returns the corresponding table as a string given an int
   */
   private String getTable(int x){
      return Tables[x-1];
   }
   
   /**
   * Returns the list of attributes given an int representing the table
   */
   private String[] getAttributes(int x){
      return attrList[x-1];
   }
   
   /**
   * Get the given table from the database and print to user
   */
   private void displayTable(int x)throws SQLException{
      String table = Tables[x-1];
      int num = numAttr[x-1];
      String sql = String.format("SELECT * FROM %s", table);
      PreparedStatement pStmt = conn.prepareStatement(sql);
      ResultSet rset = pStmt.executeQuery();
      System.out.println("\n"+table+" Table");
      System.out.println("-----------------------");
      while(rset.next()){
         String line = "";
         for(int j=1; j<=num; j++){ 
            line = line + rset.getString(j)+" ";
         }
         line = line.substring(0,line.length()-1); 
         System.out.println(line);
      }
      rset.close();
   }
   
   /**
   * Insert the given values into the given table in the database
   */
   private void Insert(String table, String input)throws SQLException{
      String[] attr = input.split(", ");
      String prep = "(";
      for(String i: attr){
         prep+="?, ";
      }
      prep = prep.substring(0,prep.length()-2); 
      prep+=")";
      String sql = String.format("INSERT INTO %s VALUES %s", table, prep);
      PreparedStatement pStmt = conn.prepareStatement(sql);
      pStmt.clearParameters();
      int x = 1;
      for(String a: attr){
         if(table=="Member" && x==5){
            Date date1 = Date.valueOf(a);
            pStmt.setDate(x, date1);
         }
         else if(table=="Movie" && x==4){
            double dval = Double.valueOf(a);
            pStmt.setDouble(x, dval);
         }
         else if(table=="Watch" && x==4){
            int ival = Integer.valueOf(a);
            pStmt.setInt(x, ival);
         }
         else{
            pStmt.setString(x, a);
         }
         x+=1;
      }
      try{
         int numRows = pStmt.executeUpdate();
      } 
      catch(SQLException sqle){
         System.out.println("Error Inserting");
         sqle.printStackTrace();
      }
   }
   
   /**
   * Given a string return a hashmap with the attribute name and value
   */
   private HashMap<String, String> parser(String input){
      //id=123, pid=example -> {id:123, pid:example}
      HashMap<String, String> result = new HashMap<>();
      String[] splitAttr = input.split(", ");
      for(String a: splitAttr){
         String[] splitA = a.split("=");
         result.put(splitA[0], splitA[1]);
      }
      return result;    
   }
   
   /**
   * Delete the given record from the given table in the database
   */
   private void Delete(String table, String condition)throws SQLException{
      HashMap<String, String> Attributes = parser(condition);
      String prep = "";
      for(String i: Attributes.keySet()){
         prep=prep+i+"=? and ";
      }
      prep = prep.substring(0,prep.length()-4); 
      String sql = String.format("DELETE FROM %s WHERE %s", table, prep);
      PreparedStatement pStmt = conn.prepareStatement(sql);
      
      int x = 1;
      for(String k: Attributes.keySet()){
         String val = Attributes.get(k);
         if(k=="exp_date"){
            Date date1 = Date.valueOf(val);
            pStmt.setDate(x, date1);
         }
         else if(k=="avg_rating"){
            double dval = Double.valueOf(val);
            pStmt.setDouble(x, dval);
         }
         else if(k=="rating"){
            int ival = Integer.valueOf(val);
            pStmt.setInt(x, ival);
         }
         else{
            pStmt.setString(x, val);
         }
         x+=1;
      }
      try{
         int numRows = pStmt.executeUpdate();
      } 
      catch(SQLException sqle){
         System.out.println("Error Deleting");
         sqle.printStackTrace();
      }
   }
   
   /**
   * Update the records in the database given the table, set statement, and condition
   */
   private void Update(String table, String set, String condition)throws SQLException{
      HashMap<String, String> Condition = parser(condition);
      HashMap<String, String> Set = parser(set);
      String prepc = "";
      String preps = "";
      for(String i: Condition.keySet()){
         prepc=prepc+i+"=? and ";
      }
      for(String i: Set.keySet()){
         preps=preps+i+"=?, ";
      }
      prepc = prepc.substring(0,prepc.length()-4); 
      preps = preps.substring(0,preps.length()-2); 
      String sql = String.format("UPDATE %s SET %s WHERE %s", table, preps, prepc);
      PreparedStatement pStmt = conn.prepareStatement(sql);
      
      HashMap<String, String> Attributes = Set;
      int x = 1;
      for(int y=1; y<=2; y++){
         if(y==2){Attributes = Condition;}
         for(String k: Attributes.keySet()){
            String val = Attributes.get(k);
            if(k=="exp_date"){
               Date date1 = Date.valueOf(val);
               pStmt.setDate(x, date1);
            }
            else if(k=="avg_rating"){
               double dval = Double.valueOf(val);
               pStmt.setDouble(x, dval);
            }
            else if(k=="rating"){
               int ival = Integer.valueOf(val);
               pStmt.setInt(x, ival);
            }
            else{
               pStmt.setString(x, val);
            }
            x+=1;
         }
      }
      try{
         int numR = pStmt.executeUpdate();
      } 
      catch(SQLException sqle){
         System.out.println("Error Updating");
         sqle.printStackTrace();
      }
   }
   
   /**
   * Print the movies in the database by partial search for either an actor or a title
   */
   private void SearchMovie(int x, String[] inputs)throws SQLException{
      // search by title
      if(x==1){
         String title = inputs[0];
         String sql = "SELECT title, movie_year, avg_rating FROM Movie WHERE title LIKE ?";
         PreparedStatement pStmt = conn.prepareStatement(sql);
         pStmt.setString(1, "%"+title+"%");
         try{
            ResultSet rset = pStmt.executeQuery();
            System.out.println("\nMovies Found");
            System.out.println("-----------------------");
            while(rset.next()){
               String line = "";
               for(int j=1; j<=3; j++){ 
                  line = line + rset.getString(j)+" ";
               }
               line = line.substring(0,line.length()-1); 
               System.out.println(line);
            }
            rset.close();
         
         } 
         catch(SQLException sqle){
            System.out.println("Error Searching");
            sqle.printStackTrace();
         }
      }
      // search by actor
      if(x==2){
         String first_name = inputs[0];
         String last_name = inputs[1];
         String sql = "SELECT title, movie_year, avg_rating FROM Movie WHERE movie_ID IN (SELECT movie_ID FROM Starred_By NATURAL JOIN Actor WHERE first_name LIKE ? and last_name LIKE ?)";
         PreparedStatement pStmt = conn.prepareStatement(sql);
         pStmt.setString(1, "%"+first_name+"%");
         pStmt.setString(2, "%"+last_name+"%");
         try{
            ResultSet rset = pStmt.executeQuery();
            System.out.println("\nMovies Found");
            System.out.println("-----------------------");
            while(rset.next()){
               String line = "";
               for(int j=1; j<=3; j++){ 
                  line = line + rset.getString(j)+" ";
               }
               line = line.substring(0,line.length()-1); 
               System.out.println(line);
            }
            rset.close();
         } 
         catch(SQLException sqle){
            System.out.println("Error Searching");
            sqle.printStackTrace();
         }
      }
   }

   /**
   * Print the rental history for a given member_ID and profile_name
   */
   private void getWatchHistory(String memberID, String profile)throws SQLException{
      // form sql query
      String sql = "SELECT title, rating FROM Watch NATURAL JOIN Movie WHERE member_ID=? and profile_name=?";
      PreparedStatement pStmt = conn.prepareStatement(sql);
      pStmt.setString(1, memberID);
      pStmt.setString(2, profile);
      // execute query
      ResultSet rset = pStmt.executeQuery();
      System.out.println("\nRental History");
      System.out.println("-----------------------");
      while(rset.next()){
         String line = "";
         for(int j=1; j<=2; j++){ 
            line = line + rset.getString(j)+" ";
         }
         line = line.substring(0,line.length()-1); 
         System.out.println(line);
      }
      rset.close();
   }

   /**
   * Main function
   */
   public static void main(String[]args){
      Scanner scan = new Scanner(System.in);
      MoviesDatabase mv = new MoviesDatabase();
      // Get login information
      System.out.println("Please enter your login information.");
      System.out.print("Username: ");
      String user = scan.nextLine();
      System.out.print("Password: "); 
      String pass = scan.nextLine();
      mv.setLogin(user, pass);
      // Get the database connection
      Connection conn = mv.getConnection();
      
      // Menu of options
      int check=0;
      while(check!=1){
         // Display menu and store selection
         mv.printMenu();
         int selection = scan.nextInt();
         scan.nextLine();
         // Execute the request
         switch(selection){
         
            // View table content
            case 1:
               mv.printTableOptions("display");
               int sel = scan.nextInt();
               scan.nextLine();
               try{
                  mv.displayTable(sel);
               }
               catch(SQLException sqlException){
                  sqlException.printStackTrace();
               }
               break;
               
            // Insert new record
            case 2:
               mv.printTableOptions("insert into");
               int sel2 = scan.nextInt();
               scan.nextLine();
               String t = mv.getTable(sel2);
               String[] at = mv.getAttributes(sel2);
               System.out.println("\nThe Attributes for "+t+" are: "+Arrays.toString(at));
               System.out.println("Enter the information to insert in the following format: one, two, three");
               String input = scan.nextLine();
               try{
                  mv.Insert(t, input);
               }
               catch(SQLException sqlException){
                  sqlException.printStackTrace();
               }
               break;
               
            // Update record
            case 3:
               System.out.println("\nWould you like to update or delete?");
               System.out.println("1 - Update");
               System.out.println("2 - Delete");
               int sel3 = scan.nextInt();
               scan.nextLine();
               if(sel3==1){
                  mv.printTableOptions("update");
                  int select1 = scan.nextInt();
                  scan.nextLine();
                  String t2 = mv.getTable(select1);
                  String[] at2 = mv.getAttributes(select1);
                  System.out.println("\nThe Attributes for "+t2+" are: "+Arrays.toString(at2));
                  System.out.println("\nEnter the information to update in the following format: key1=val1, key2=val2");
                  System.out.print("Set: ");
                  String select2 = scan.nextLine();
                  System.out.print("Condition: ");
                  String select3 = scan.nextLine();
                  System.out.println();
                  try{
                     mv.Update(t2, select2, select3);
                  }
                  catch(SQLException sqlException){
                     sqlException.printStackTrace();
                  }
               }
               if(sel3==2){
                  mv.printTableOptions("delete from");
                  int select1 = scan.nextInt();
                  scan.nextLine();
                  String t3 = mv.getTable(select1);
                  String[] at3 = mv.getAttributes(select1);
                  System.out.println("\nThe Attributes for "+t3+" are: "+Arrays.toString(at3));
                  System.out.println("\nEnter the information to delete in the following format: key1=val1, key2=val2");
                  System.out.print("Condition: ");
                  String select2 = scan.nextLine();
                  try{
                     mv.Delete(t3, select2);
                  }
                  catch(SQLException sqlException){
                     sqlException.printStackTrace();
                  }
               }
               break;
               
            // Search for movies  
            case 4:
               System.out.println("Would you like to search by title or actor?");
               System.out.println("1 - Title");
               System.out.println("2 - Actor");
               int sel4 = scan.nextInt();
               scan.nextLine();
               String[] inputs = new String[2];
               if(sel4==1){
                  System.out.print("\nEnter title: ");
                  String title = scan.nextLine();
                  System.out.println();
                  inputs[0] = title;
               }
               if(sel4==2){
                  System.out.println("\nPlease enter the actor");
                  System.out.print("First Name: ");
                  String first = scan.nextLine();
                  System.out.print("Last Name: ");
                  String last = scan.nextLine();
                  System.out.println();
                  inputs[0] = first;
                  inputs[1] = last;
               }
               try{
                  mv.SearchMovie(sel4, inputs);
               }
               catch(SQLException sqlException){
                  sqlException.printStackTrace();
               }
               break;
               
            // View member profile rental history
            case 5:
               System.out.println("Please enter profile information");
               System.out.print("Member ID: ");
               String mid = scan.nextLine();
               System.out.print("Profile Name: ");
               String profile = scan.nextLine();
               try{
                  mv.getWatchHistory(mid, profile);
               }
               catch(SQLException sqlException){
                  sqlException.printStackTrace();
               }
               break;
               
            // Exit the program
            case 6:
               try{
                  mv.close(conn);
               }
               catch(SQLException sqlException){
                  System.out.println("Couldn't close connection");
               }
               System.out.println("Goodbye! :)");
               check=1;
               break;
               
            // Command not supported
            default:
               System.out.println("Command not supported");
               break;
         }   
      }
   }
}
