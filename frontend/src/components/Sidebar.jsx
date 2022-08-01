import React from "react";
import { AppBar, Toolbar, styled, Typography, Box, InputBase, Badge, Grid, ListItem, ListItemButton, ListItemIcon, ListItemText, tableFooterClasses, Divider } from "@mui/material";
import DashboardIcon from '@mui/icons-material/Dashboard';
import PeopleIcon from '@mui/icons-material/People';
import LayersIcon from '@mui/icons-material/Layers';
import BarChartIcon from '@mui/icons-material/BarChart';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';


const Sidebar = (props) => {

  const CustomListItemButton = styled(ListItemButton)({
    minHeight: 48,
    justifyContent: props.open ? 'initial' : 'center',
    px: 2.5
  });

  const CustomListItemIcon = styled(ListItemIcon)({
    minWidth: 0,
    mr: props.open ? 3 : 'auto',
    justifyContent: 'center',
  });

  return (
    
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
  )
}

export default Sidebar;