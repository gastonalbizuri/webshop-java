/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Gaston
 */
public class Conexion {
     private String USERNAME = "root";
    private String PASSWORD = "gaston"; //gaston
    private String HOST = "localhost"; //127.0.0.1
    private String PORT = "3306";
    private String DATABASE = "db_minimercado";
    private String CLASSNAME = "com.mysql.jdbc.Driver";
    private String URL = "jdbc:mysql://"+HOST+":"+PORT+"/"+DATABASE+ "?autoReconnect=true&useSSL=false";
    //private String URL = "jdbc:mysql://node168828-env-0040420.jelastic.dogado.eu/albicar";
    private Connection con;
    
    public Conexion(){
        try {
            Class.forName(CLASSNAME);
            con = DriverManager.getConnection(URL,USERNAME,PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: "+e);
        } catch (SQLException e ){
            System.err.println("ERROR: "+e);
        }
    }
    
    public Connection getConexion(){
        return con;
    }
}

