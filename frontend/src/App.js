import React from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Navbar from "./components/Navbar";
import Feed from "./components/Feed";
import { AppContextProvider,useAppContext } from "./AppContext";

function App() {
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

export default () => (
<AppContextProvider>
  <App></App>
</AppContextProvider>);

