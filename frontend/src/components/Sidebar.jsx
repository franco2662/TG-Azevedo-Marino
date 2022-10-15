import React from "react";
import { AppBar, Toolbar,Drawer,IconButton, styled, Typography, Box, InputBase, Badge, Grid, ListItem, ListItemButton, ListItemIcon, ListItemText, tableFooterClasses, Divider } from "@mui/material";
import DashboardIcon from '@mui/icons-material/Dashboard';
import PeopleIcon from '@mui/icons-material/People';
import LayersIcon from '@mui/icons-material/Layers';
import BarChartIcon from '@mui/icons-material/BarChart';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import { useAppContext } from "../AppContext";
import { useTheme } from '@mui/material/styles';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';

const Sidebar = () => {

  const {usuarioPrueba,cambiarUsuario,showSidebar,handleSidebar} = useAppContext();
  
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
    <Drawer variant="persistent" open={showSidebar} >
        <DrawerHeader>
          <IconButton onClick={handleSidebar}>
            {theme.direction === 'rtl' ? <ChevronRightIcon /> : <ChevronLeftIcon />}
          </IconButton>
        </DrawerHeader>
        <Divider />
      <Box
        flex={1}
        p={4}
        sx={{ display: { xs: "none", sm: "block" } }}
      >
        <CustomListItemButton>
          <CustomListItemIcon>
            <DashboardIcon />
          </CustomListItemIcon>
          <ListItemText primary="Dashboard" />
        </CustomListItemButton>
        <Divider />
        <CustomListItemButton>
          <CustomListItemIcon>
            <ShoppingCartIcon />
          </CustomListItemIcon>
          <ListItemText primary="Orders" />
        </CustomListItemButton>
        <Divider/>
        <CustomListItemButton>
          <CustomListItemIcon>
            <PeopleIcon />
          </CustomListItemIcon>
          <ListItemText primary="Customers" />
        </CustomListItemButton>
        <Divider/>
        <CustomListItemButton>
          <CustomListItemIcon>
            <BarChartIcon />
          </CustomListItemIcon>
          <ListItemText primary="Reports" />
        </CustomListItemButton>
        <Divider/>
        <CustomListItemButton>
          <CustomListItemIcon>
            <LayersIcon />
          </CustomListItemIcon>
          <ListItemText primary="Integrations" />
        </CustomListItemButton>
      </Box>
      </Drawer>
  )
}

export default Sidebar;