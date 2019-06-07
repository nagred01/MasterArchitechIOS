import { StyleSheet } from 'react-native';

const styles = StyleSheet.create ({
  // Default styles
    container: {
      flex: 1,
      paddingTop: 20,
      paddingBottom: 20,
      backgroundColor: '#FFFFFF'
    },
    defaultText: {
      fontSize: 16,
      color: '#0061b8'
    },
    defaultButton: {
      alignSelf: 'flex-end',
      height: 40,
      margin: 10,
      paddingLeft: 10,
      paddingRight: 10,
      paddingBottom:7,
      fontSize: 16,
      color: '#0061b8',
    },
    defaultTextBox: {
      height: 40, 
      borderColor: '#212121', 
      borderWidth: 2,
    },

  // Style for Module Header 
    moduleHeader: {
      height: 100,
    },
    moduleTitleContainer: {
      paddingTop: 16,
      paddingBottom: 16,
      paddingRight: 24,
      paddingLeft: 24,
    },
    moduleTitle: {
      fontSize: 30,
      color: '#212121',
      borderBottomWidth: 1,
      borderColor: '#d7d7d7',
      paddingBottom: 10,
    },

  // Style for Account Summary Module    
    tertiaryRowContainer: {
      display: 'flex',
      alignSelf: 'flex-end',
      justifyContent: 'center',
      flexDirection: 'column',
      lineHeight: 24
    },
    block: {
      display: 'flex',
      alignSelf: 'flex-start',
      justifyContent: 'center',
      flexDirection: 'column',
      lineHeight: 24
    },
    flexContainer: {
      display: 'flex',
      justifyContent: 'space-between',
      flexDirection: 'row',
      lineHeight: 24,
      paddingTop: 16,
      paddingBottom: 16,
      paddingRight: 24,
      paddingLeft: 24,
      borderTopWidth: 1,
      borderBottomWidth: 0.5,
      borderColor: '#d7d7d7'
    },
    searchClosed: {
        alignSelf: 'flex-end',
        height: 40,
        margin: 10,
        paddingLeft: 10,
        paddingRight: 10,
        paddingBottom:7,
        fontSize: 16,
        color: '#0061b8',
    },
    searchOpened: {
        alignSelf: 'flex-end',
        height: 40,
        margin: 10,
        paddingLeft: 10,
        paddingRight: 10,
        paddingBottom:7,
        fontSize: 16,
        color: '#0061b8',
    },
    listBody: {
        paddingTop: 16,
        paddingRight: 24,
        paddingBottom: 16,
        paddingLeft: 24,
        borderBottomWidth: 1,
        borderColor: '#d7d7d7',
        borderWidth: 0.5,
        lineHeight: 20
      },
      listHeader: {
        backgroundColor: '#f5f5f5',
        borderBottomWidth: 2,
        borderColor: '#d7d7d7',
        borderWidth: 0.5,
        height: 30,
      },
      listHeaderText: {
        paddingTop: 0,
        paddingBottom: 0,
        paddingRight: 18,
        paddingRight: 18,
        fontSize: 15
      },
      listItemValuePrimary: {
        marginBottom: 3,
        color: '#212121',
        fontSize: 14,
        fontWeight: "600",
      },
      listItemValueSecondary: {
        fontSize: 14,
        color: '#424242'
      },
      listItemPrimaryAmount: {
        fontSize: 16,
        fontWeight: 'bold',
      },
      primaryAccountRowValue: {
        color: '#0061b8',
        fontSize: 18,
        overflow: 'hidden',
      },
      listItemPrimaryAccountAmount: {
        alignSelf: 'flex-end',
        fontSize: 18,
        fontWeight: "400",
      },
      secondaryRowValue: {
        color: '#424242',
        fontSize: 16,
        lineHeight: 24
      },
      listItemPrimaryAccountBalanceLabel: {
        color: '#424242',
        alignSelf: 'flex-end',
        fontSize: 16,
        lineHeight: 24
      },

      // Style for AccountOverview Module
      accountOverviewName: {
        fontSize: 18,
        fontWeight: 'normal',
        color: '#424242',
        paddingBottom: 2,
      },
      accountOverviewNumber: {
        fontSize: 14,
        fontWeight: 'normal',
        color: '#424242',
        marginTop: 3,
        marginBottom: 12,
      },
      accountOverviewBalance: {
        fontSize: 18,
        fontWeight: 'normal',
        color: '#424242',
        marginBottom: 3,
      },
      accountOverviewBalanceLabel: {
        fontSize: 14,
        fontWeight: 'normal',
        color: '#424242',
      },
      accountOverview: {
        display: 'flex',
        flexDirection: 'column',
        paddingTop: 24,
        paddingBottom: 24,
        paddingLeft: 24,
        paddingRight: 24,
        borderTopWidth: 1,
        borderStyle:'solid',
        borderColor: '#e3e3e3'
      },
      row: {
        display: 'flex',
        marginTop: 12,
        flexDirection: 'row',
      },
      accountOverviewAvailable: {
        display: 'flex',
        flex: 0.5,
        alignSelf: 'flex-start',
        justifyContent: 'center',
        flexDirection: 'column',
        paddingLeft: 8,
        borderLeftWidth: 3,
        borderStyle:'solid',
        borderColor: '#9e9e9e',
      },
      accountOverviewCurrent: {
        display: 'flex',
        flex: 0.5,
        alignSelf: 'flex-end',
        justifyContent: 'center',
        flexDirection: 'column',
        paddingLeft: 8,
        borderLeftWidth: 3,
        borderStyle:'solid',
        borderColor: '#9e9e9e',
      },
      bar: {
        display: 'flex',
        flexDirection: 'row',
        paddingTop: 20,
        paddingBottom: 20,
        paddingLeft: 24,
        paddingRight: 24,
      },
      buttonGroup: {
        paddingLeft: 12,
        paddingRight: 24,
        borderLeftWidth: 2,
        borderStyle:'solid',
        borderColor: '#0061b8',
        fontSize: 16,
        color: '#0061b8',
      },
      accountOverview:{
        paddingLeft:10,
        paddingRight:10,
        paddingBottom:10,
        paddingTop: 10,
        height: 100
      }
  });

  export default styles;