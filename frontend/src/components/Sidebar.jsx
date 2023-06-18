import React from "react";
import { AppBar, Toolbar,Drawer,IconButton, styled, Typography, Box, InputBase, Badge, Grid, ListItem, ListItemButton, ListItemIcon, ListItemText, tableFooterClasses, Divider, Button } from "@mui/material";
import DashboardIcon from '@mui/icons-material/Dashboard';
import PeopleIcon from '@mui/icons-material/People';
import LayersIcon from '@mui/icons-material/Layers';
import BarChartIcon from '@mui/icons-material/BarChart';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import { useAppContext } from "../AppContext";
import { useTheme } from '@mui/material/styles';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import { Link, NavLink } from "react-router-dom";
import { useEffect } from "react";
import HistoryIcon from '@mui/icons-material/History';

const Sidebar = () => {

  const {usuarioObjeto,showSidebar,handleSidebar,getSession} = useAppContext();
  
  const theme = useTheme();
  const DrawerHeader = styled('div')(({ theme }) => ({
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: theme.spacing(0, 1),
    // necessary for content to be below app bar
    ...theme.mixins.toolbar,
  }));
  const CustomListItemButton = styled(ListItemButton)({
    minHeight: 48,
    justifyContent: showSidebar ? 'initial' : 'center',
    px: 2.5
  });

  const CustomListItemIcon = styled(ListItemIcon)({
    minWidth: 0,
    mr: showSidebar ? 3 : 'auto',
    justifyContent: 'center',
  });

  return (
    <Drawer variant="persistent" open={showSidebar}>
        <DrawerHeader sx={{backgroundColor: '#453FC6'}}>
        <IconButton onClick={handleSidebar}>
          {theme.direction === 'rtl' ? <ChevronRightIcon sx={{
            color: '#FFFFFF', backgroundColor: '#3530a1', borderRadius: 2, ":hover": {
              bgcolor: "#2a2681",
              color: "white"
            }
          }} /> : <ChevronLeftIcon sx={{
            color: '#FFFFFF', backgroundColor: '#3530a1', borderRadius: 2, ":hover": {
              bgcolor: "#2a2681",
              color: "white"
            }
          }} />}
        </IconButton>
        </DrawerHeader>
      <Box
        flex={1}
        p={4}
        sx={{ display: { xs: "none", sm: "block",backgroundColor: '#34043D',backgroundImage: "linear-gradient(to bottom,#453FC6, #34043D)" } }}
      >
        <Link to="/dashboard">
        <CustomListItemButton sx={{backgroundColor: '#453FC6',borderRadius: 2}}>
          <CustomListItemIcon>
            <BarChartIcon sx={{color: '#FFFFFF'}}/>
          </CustomListItemIcon>
          <ListItemText primary="Reportes" sx={{color: '#FFFFFF'}} />
        </CustomListItemButton>
        </Link>
        {
          usuarioObjeto.current.fk_rol.id <= 2 ?
          <> 
          <Divider/>
        <Link to="/dashboard/usuarios">
        <CustomListItemButton sx={{backgroundColor: '#453FC6',borderRadius: 2, marginTop:2.5}}>
          <CustomListItemIcon>
            <PeopleIcon sx={{color: '#FFFFFF'}}/>
          </CustomListItemIcon>
          <ListItemText primary="Usuarios" sx={{color: '#FFFFFF'}}/>
        </CustomListItemButton>
        </Link>
        </>   
        :<></>}             
        <Divider/>
        <Link to="/dashboard/archivo">
        <CustomListItemButton sx={{backgroundColor: '#453FC6',borderRadius: 2, marginTop:2.5}}>
          <CustomListItemIcon>
            <LayersIcon sx={{color: '#FFFFFF'}}/>
          </CustomListItemIcon>
          <ListItemText primary="Archivo" sx={{color: '#FFFFFF'}} />
        </CustomListItemButton>
        </Link>
        <Link to="/dashboard/historial">
        <CustomListItemButton sx={{backgroundColor: '#453FC6',borderRadius: 2, marginTop:2.5}}>
          <CustomListItemIcon>
            <HistoryIcon sx={{color: '#FFFFFF'}}/>
          </CustomListItemIcon>
          <ListItemText primary="Historial" sx={{color: '#FFFFFF'}} />
        </CustomListItemButton>
        </Link>
      </Box>
      </Drawer>
  )
}

export default Sidebar;