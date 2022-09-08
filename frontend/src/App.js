import React from "react";
import { useState, useEffect } from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
import Feed from "./components/Feed";
//import axios from "axios";
function App() {
  const baseURL = "http://127.0.0.1:8000/users/";
//   { axios.get(baseURL+'users/')
// .then(function (response) {
// 	console.log(response);
// })}
  return (
    <div className="App">
      <CssBaseline />
      <Box>
        <Navbar />        
        <Feed />
      </Box>
    </div>
  );
}

export default App;
