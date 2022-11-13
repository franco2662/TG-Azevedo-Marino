import { React,useState, useEffect } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import GraficoBarra from "./GraficoBarra";
import GraficoDonut from "./GraficoDonut";


const ModuloReportes = () =>{

    return (
      
      <Container sx={{display:'flex'}}>
      <GraficoBarra idChart ="idPrueba"/>
      <GraficoDonut/>      
      </Container>
      );
}

export default ModuloReportes;