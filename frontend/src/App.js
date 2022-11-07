import React from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Dashboard from "./components/Dashboard";
import ModuloUsuario from "./components/ModuloUsuario";
import ModuloReportes from "./components/ModuloReportes";
import SignIn from "./components/SignIn";
import { AppContextProvider,useAppContext } from "./AppContext";
import {BrowserRouter,Routes,Route}from 'react-router-dom'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Dashboard/>}>          
          <Route index path="/" element = {<ModuloReportes/>}/>           
          <Route index path="/usuarios" element = {<ModuloUsuario/>}/>     
        </Route>
        <Route path="/home" element = {<SignIn/>}/>        
      </Routes>
    </BrowserRouter>
  );
}

export default () => (
<AppContextProvider>
  <App></App>
</AppContextProvider>);

