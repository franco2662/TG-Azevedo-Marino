import { React,useState, useEffect, useRef } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useNavigate } from "react-router-dom";
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import CantProcs from "./graficos/CantProcs";
import CantDirs from "./graficos/CantDirs";
import CantRegs from "./graficos/CantRegs";
import ListProcs from "./graficos/ListProcs";
import ListDirs from "./graficos/ListDirs";
import ListRegs from "./graficos/ListRegs";
import ProcsAvgCant from "./graficos/ProcsAvgCant";
import ProcsAvgPerc from "./graficos/ProcsAvgPerc";
import DirsAvgCant from "./graficos/DirsAvgCant";
import DirsAvgPerc from "./graficos/DirsAvgPerc";
import RegsAvgCant from "./graficos/RegsAvgCant";
import RegsAvgPerc from "./graficos/RegsAvgPerc";
import ChartLoad from '../../assets/chart_loading.gif'

const ModuloReportes = () =>{
  
  const {usuarioObjeto,baseURL,idAnalisisFromHistory} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;
  instance.defaults.timeout = 18000000;
  const navigate = useNavigate();
  const tipo_array = [{'id_analisis':0,'analisis':''}]
  const [listaAnalisis, setListaAnalisis] = useState([]);
  const [idAnalisis, setIdAnalisis] = useState(idAnalisisFromHistory.current);
  const [isBusy,setIsBusy] = useState(true);


  function handleChange(event){
    setIdAnalisis(event.target.value);
  };

  function seleccionarId(){
    setIsBusy(true);
    if(idAnalisis==0 && listaAnalisis.length>0){
      setIdAnalisis(listaAnalisis[0]['id_analisis'])
      setIsBusy(false);
    }
    setIsBusy(false);   
  }

  const reportes =()=>{         
    if(isBusy)
      return(<>cargando</>)
    else{
      if(listaAnalisis.length>0){ 
      return(
        <>
        <Box id="box-graficos"sx={{ maxWidth: '30%',marginBottom:10}}>
        <FormControl fullWidth>
          <InputLabel id="analisis-label">Analisis</InputLabel>
          <Select
            labelId="analisis-label"
            id="analisis-select"               
            value={idAnalisis}
            label="Analisis"
            onChange={(event)=>handleChange(event)}
            onClick={seleccionarId}
            
          >
            {listaAnalisis.map((row) => (
            <MenuItem key={row.id_analisis} value={row.id_analisis} >{row.analisis}</MenuItem>
            ))}
            
          </Select>
        </FormControl>
      </Box>
      <Container id="cont-graficos" sx={{display:'flex',flexDirection: 'row',flexWrap: 'wrap',justifyContent : 'space-between'}}>
      <CantProcs id={idAnalisis} />
      <CantDirs id={idAnalisis}/>
      <CantRegs id={idAnalisis}/>
      <ListProcs id={idAnalisis}/> 
      <ListDirs id={idAnalisis}/>
      <ListRegs id={idAnalisis}/>
      <ProcsAvgCant id={idAnalisis}/>
      <ProcsAvgPerc id={idAnalisis}/>
      <DirsAvgCant id={idAnalisis}/>
      <DirsAvgPerc id={idAnalisis}/>
      <RegsAvgCant id={idAnalisis}/>
      <RegsAvgPerc id={idAnalisis}/>
      </Container>
      </>
      )
      }        
      else
        return (
        <Box sx={{display:'flex',flexDirection:'column' , alignItems:"center",justifyContent : 'space-between'}}>
          <Typography variant="h4">No se encontraron análisis!</Typography>
          <Typography variant="h5" sx={{marginBottom:10}}>Ingrese al módulo Archivo para cargar los datos</Typography>
           <img src={ChartLoad} />
           </Box>
           )
    }   
  }

  useEffect(() => {   
    async function getAnalisisList(){
      if(usuarioObjeto.current.id=="")return;
      try {
        const response = await instance.get("listAnalisisByUser/"+usuarioObjeto.current.id);
        setListaAnalisis(JSON.parse(response.data));
      } catch (error) {              
        setIdAnalisis(0);
      } finally {      
      }
      setIsBusy(false);
      if(listaAnalisis.length>0){
        setIdAnalisis(listaAnalisis[0]['id_analisis'])
      }
      return true;
    };         
    getAnalisisList();
  }, []);

  useEffect(() => {
    seleccionarId()
  }, [idAnalisis, listaAnalisis]);
  
    return (     
      <>
    {reportes()}
    </>
      );
}

export default ModuloReportes;