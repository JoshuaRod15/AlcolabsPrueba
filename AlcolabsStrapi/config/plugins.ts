export default () => ({
    upload: {
      config: {
        provider: 'local', // Utiliza el proveedor local
        providerOptions: {
          sizeOptimization: false, // Desactiva la optimización que usa sharp
        },
      },
    },
  });
  