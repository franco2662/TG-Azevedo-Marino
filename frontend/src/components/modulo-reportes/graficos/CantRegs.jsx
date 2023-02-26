import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";


const CantRegs = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'categoria': 'registros', 'No Deseados': 0, 'Prob No Deseados': 0}]
const[lista,setLista] = useState(tipo_array);
const[cargado,setCargado] = useState(false);


const [options, setOptions] = useState({
    chart: {
      type: 'donut',
    },
    labels: ['No Deseados', 'Prob No Deseados'],
    title: {
      text: 'Cantidad de Registros'
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

useEffect(() => {   
    async function getListCantRegs(){
        try {
          const response = await instance.get("countRegs/"+props.id);
          setLista(JSON.parse(response.data));
        } catch (error) {
          console.log(error);
          throw new Error(error);
        } finally {   
        }      
        setChartConfig();
  };
    getListCantRegs();  
  }, [cargado]);


    return (
        <>
        {reporte()}
        </>
      );
}

export default CantRegs;