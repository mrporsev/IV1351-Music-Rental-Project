/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package se.kth.iv1351.jdbcintro;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

/**
 * A small program that illustrates how to write a simple JDBC program.
 */
public class BasicJdbc {
  private static final String TABLE_NAME = "personTest";
  private static final String TABLE_INSTRUMENT = "instrument";
  private PreparedStatement listInstrumentByTypeStmt;
  private PreparedStatement numberRentedInstrumentsStmt;
  private PreparedStatement insertRentalStmt;
  private PreparedStatement terminateRentalStmt;


  private void accessDB() {
    try (Connection connection = createConnection()) {
      createTable(connection);
      prepareStatements(connection);
      Scanner scanner = new Scanner(System.in);

      System.out.println("\n\n1. list instrument by type\n2. rent instrument\n3. terminate rental");
      int answer = scanner.nextInt();
      switch(answer) {
        case 1:
          System.out.println("What instrument?");
          String instrument = scanner.next();
          //skriv Drums
          listInstrumentByTypeStmt.setString(1, instrument);
          listAllInstruments();
          break;
        case 2:
            System.out.println("What is your student id?");
            //svara 1
            int student_id = scanner.nextInt();
            System.out.println("What instrument id?");
            //svara 7
            int instrument_id = scanner.nextInt();

            //student_id, rental_start_date, rental_end_date, instrument_id
            numberRentedInstrumentsStmt.setInt(1,student_id);
            insertRentalStmt.setInt(1, student_id);
            insertRentalStmt.setString(2, "2020-01-01");
            insertRentalStmt.setString(3, "2021-01-01");
            insertRentalStmt.setInt(4, instrument_id);
            rentInstrument();
            break;
        case 3:
          System.out.println("What is your student id?");
          //svara 1
          int student_idTerminate = scanner.nextInt();
          System.out.println("What is the rental id to be terminated?");
          //svara 21
          int rental_idTerminate = scanner.nextInt();

          terminateRentalStmt.setInt(1,student_idTerminate);
          terminateRentalStmt.setInt(2, rental_idTerminate);
          terminateInstrument();
          break;
      }
    } catch (SQLException | ClassNotFoundException exc) {
      exc.printStackTrace();
    }
  }

  private Connection createConnection() throws SQLException, ClassNotFoundException {
    Class.forName("org.postgresql.Driver");
    return DriverManager.getConnection("jdbc:postgresql://localhost:5432/newest_soundgood",
      "postgres", "example");
    // Class.forName("com.mysql.cj.jdbc.Driver");
    // return DriverManager.getConnection(
    // "jdbc:mysql://localhost:3306/simplejdbc?serverTimezone=UTC",
    // "root", "javajava");
  }

  private void createTable(Connection connection) {
    try (Statement stmt = connection.createStatement()) {
      if (!tableExists(connection)) {
        stmt.executeUpdate(
            "create table " + TABLE_NAME + " (name varchar(32) primary key, phone varchar(12), age int)");
      }
    } catch (SQLException sqle) {
      sqle.printStackTrace();
    }
  }

  private boolean tableExists(Connection connection) throws SQLException {
    DatabaseMetaData metaData = connection.getMetaData();
    ResultSet tableMetaData = metaData.getTables(null, null, null, null);
    while (tableMetaData.next()) {
      String tableName = tableMetaData.getString(3);
      if (tableName.equalsIgnoreCase(TABLE_NAME)) {
        return true;
      }
    }
    return false;
  }

  private void listAllInstruments() {
    try (ResultSet instruments = listInstrumentByTypeStmt.executeQuery()) {
      while(instruments.next()) {
        System.out.println("instrument_id: " + instruments.getString(1) + ", type: " + instruments.getString(2) + ", cost per month: " + instruments.getInt(3));
      }
    } catch (SQLException e) {
        e.printStackTrace();
    }
  }

  private void rentInstrument() {
    boolean statement = true;
    try (ResultSet instruments_rented = numberRentedInstrumentsStmt.executeQuery()) {
      while(instruments_rented.next() && statement) {
        System.out.println("INSTRUMENTS RENTED:" + instruments_rented.getInt(2));
        if (instruments_rented.getInt(2) <= 1) {
          //System.out.println("INNUTI IF:EN");
          insertRentalStmt.executeUpdate();
          statement = false;
        } else {
          System.out.println("Can't rent, student has reached maximum rental already.");
          statement = false;
        }
      }
      if(statement) {
        insertRentalStmt.executeUpdate();
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  /**
   * Will set rental_end_date as NULL (terminated) for the specified rental_id
   * @throws SQLException sql exception
   */
  private void terminateInstrument() throws SQLException {
    terminateRentalStmt.executeUpdate();
    System.out.println("Specific rental terminated");
  }

  private void prepareStatements(Connection connection) throws SQLException {
    listInstrumentByTypeStmt = connection.prepareStatement("SELECT * FROM " + TABLE_INSTRUMENT + " WHERE type_of_instrument = ? AND is_rented = false");
    numberRentedInstrumentsStmt = connection.prepareStatement("SELECT student_id, COUNT(r.student_id) AS rented_instruments FROM rental AS r WHERE r.student_id = ? AND r.rental_end_date <> 'NULL' GROUP BY student_id");
    insertRentalStmt = connection.prepareStatement("INSERT INTO rental (student_id, rental_start_date, rental_end_date, instrument_id) VALUES(?, ?, ?, ?)");
    terminateRentalStmt = connection.prepareStatement("UPDATE rental SET rental_end_date = null WHERE student_id = ? AND rental_id = ?");
  }

  public static void main(String[] args) {
    new BasicJdbc().accessDB();
  }
}
