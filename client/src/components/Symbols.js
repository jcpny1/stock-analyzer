import React from 'react';
import {Form, Grid, Table} from 'semantic-ui-react';

const Symbols = (props) => {
  const {symbols, symbolName} = props;

  function columnTitles() {
    return (
      <Table.Row>
        <Table.HeaderCell>Name</Table.HeaderCell>
        <Table.HeaderCell>Symbol</Table.HeaderCell>
      </Table.Row>
    );
  }

  function listSymbols() {
    return symbols.map((symbol,index) => {
      return (
        <Table.Row key={index}>
          <Table.Cell width={8}>{symbol.long_name}</Table.Cell>
          <Table.Cell width={3}>{symbol.name}</Table.Cell>
        </Table.Row>
      );
    });
  }

  return (
    <Grid style={{'marginLeft': '1rem'}}>
      <Grid.Row>
        <Grid.Column>
          <Form>
            <Form.Input width={4} className='icon' icon='search' placeholder='Description' name='value' value={symbolName} onChange={props.onChange}/>
          </Form>
        </Grid.Column>
      </Grid.Row>
      <Grid.Row>
        <Grid.Column>
          <Table columns={2} striped>
            <Table.Header>{columnTitles()}</Table.Header>
            <Table.Body>{listSymbols()}</Table.Body>
          </Table>
        </Grid.Column>
      </Grid.Row>
    </Grid>
  );
}

export default Symbols;
