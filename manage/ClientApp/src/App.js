import React from 'react';
import { Route } from 'react-router';
import Layout from './components/Layout';
import Home from './components/Home';
import FetchEmployees from './components/FetchEmployees';
import DetailsEmployee from './components/DetailsEmployee';

export default () => (
    <Layout>
        <Route exact path='/' component={Home} />
        <Route path='/fetchemployees' component={FetchEmployees} />
        <Route path='/detailsemployee/:id?' component={DetailsEmployee} />
    </Layout>
);
