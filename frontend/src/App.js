import React from "react";
import { useState, useEffect } from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
import Feed from "./components/Feed";
function App() {

  return (
    <div className="App">
      <CssBaseline />
      <Box>
        <Navbar />
        <Stack direction="row">
          <Sidebar />
          <Feed />
        </Stack>
      </Box>
    </div>
  );
}

export default App;
