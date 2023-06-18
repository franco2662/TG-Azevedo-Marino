import React from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Dashboard from "./components/Dashboard";
import ModuloUsuario from "./components/modulo-usuario/ModuloUsuario";
import ModuloReportes from "./components/modulo-reportes/ModuloReportes";
import SignIn from "./components/SignIn";
import { AppContextProvider,useAppContext } from "./AppContext";
import {BrowserRouter,Routes,Route}from 'react-router-dom'
import ModuloArchivo from "./components/modulo-archivo/ModuloArchivo";
import ModuloHistorial from "./components/modulo-historial/ModuloHistorial";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element = {<SignIn/>}/>
        <Route path="/dashboard" element={<Dashboard/>}>          
          <Route index path="/dashboard" element = {<ModuloReportes/>}/>           
          <Route index path="/dashboard/usuarios" element = {<ModuloUsuario/>}/>
          <Route index path="/dashboard/archivo" element = {<ModuloArchivo/>}/>
          <Route index path="/dashboard/historial" element = {<ModuloHistorial/>}/>     
        </Route>                
      </Routes>
    </BrowserRouter>
  );
}

export default () => (
<AppContextProvider>
  <App></App>
</AppContextProvider>);

