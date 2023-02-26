import { React,useState, useEffect} from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";


const CantDirs = (props) =>{

const {usuarioObjeto,baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'categoria': 'directorios', 'No Deseados': 0, 'Prob No Deseados': 0}]
const[lista,setLista] = useState(tipo_array);
const[cargado,setCargado] = useState(false);


const [options, setOptions] = useState({
    chart: {
      type: 'donut',
    },
    labels: ['No Deseados', 'Prob No Deseados'],
    title: {
      text: 'Cantidad de Directorios'
    },
    colors: ['#991111', '#DBAD23'],
    fill: {
      type: 'gradient',
    },
    responsive: [{
      breakpoint: undefined,
      options: {
        chart: {
          width: 200
        },
        fill: {
          type: 'gradient',
        },
        legend: {
          position: 'bottom'
        }
      }
    }]
  });
   
  
const [series,setSeries] = useState([]);

const setChartConfig = () =>{
  setSeries([lista['No Deseados'],lista['Prob No Deseados']])
  setCargado(true);
}

const reporte = () =>{ 
    if(series[0]==undefined){
      return(<>cargando chart</>);
    }
       return(    
        <Chart redraw="true" options={options} series={series} type="pie" width={500} height={400}/>    
    );
}

async function verifyIdAnalisis(){
  if(props.id==0){
    try {
      const response = await instance.get("lastIdAnalisisByUser/"+usuarioObjeto.current.id);
      console.log(JSON.parse(response.data));
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {   
    }
  }

};

useEffect(() => {
  verifyIdAnalisis();
  async function getListCantDirs(){
    try {
      const response = await instance.get("countDirs/"+props.id);
      setLista(JSON.parse(response.data));
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {   
    }      
    setChartConfig();
  }
    getListCantDirs();  
  }, [cargado]); 

    return (
        <>
        {reporte()}
        </>
      );
}

export default CantDirs;