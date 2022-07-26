import React from "react";
import { useState,useEffect } from "react";
import { CssBaseline } from "@mui/material";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
function App() {

  return (
    <div className="App">
     <CssBaseline/>
     <Navbar/>
     <Sidebar/> 
    </div>
  );
}

export default App;
