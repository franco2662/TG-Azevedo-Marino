import React from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Dashboard from "./components/Dashboard";
import ModuloUsuario from "./components/modulo-usuario/ModuloUsuario";
import ModuloReportes from "./components/modulo-reportes/ModuloReportes";
import SignIn from "./components/SignIn";
import { AppContextProvider,useAppContext } from "./AppContext";
import {BrowserRouter,Routes,Route}from 'react-router-dom'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element = {<SignIn/>}/>
        <Route path="/dashboard" element={<Dashboard/>}>          
          <Route index path="/dashboard" element = {<ModuloReportes/>}/>           
          <Route index path="/dashboard/usuarios" element = {<ModuloUsuario/>}/>     
        </Route>                
      </Routes>
    </BrowserRouter>
  );
}

export default () => (
<AppContextProvider>
  <App></App>
</AppContextProvider>);

