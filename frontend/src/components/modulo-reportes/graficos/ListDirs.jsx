import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";


const ListDirs = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'proceso': '', 'id_tipo': 0, 'porcentaje': 0.00}]
const[lista,setLista] = useState(tipo_array);
const[colores,setColores] = useState([]);


const [options, setOptions] = useState({
  chart: {
    type: 'Bar',
    width:300
  },
  title: {
    text: 'Lista de Directorios'
  },
  plotOptions: {
    bar: {
      barHeight: '30%',
      distributed: false,
      horizontal: true,
      dataLabels: {
        position: 'bottom'
      },
    }
  },
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
  let data_serie = [];
  lista.map((item) => {
    data_serie.push({x:item["directorio"],y:item["porcentaje"]});
    
  }
  )
  setSeries([{name: 'porcentaje',data:data_serie,color:'#7358CB'}]);
}

const reporte = () =>{
  if(series[0]==undefined){
    return(<>cargando chart</>);
  }
       return(    
        <Chart redraw="true" options={options} series={series} type="bar" width={500} height={400}/>    
    );
}

useEffect(() => {   
    async function getListDirs(){
        try {
          const response = await instance.get("listBadDirs/"+props.id);
          setLista(JSON.parse(response.data));
        } catch (error) {
          console.log(error);
          throw new Error(error);
        } finally {   
        }      
        setChartConfig();
      };
    getListDirs();  
  }, [lista]);


    return (
        <>
        {reporte()}
        </>
      );
}

export default ListDirs;