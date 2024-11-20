export const holaMundo = async (req, res) => {
  try {
    const message = "Hola";

    return res.status(200).json({ message });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Error en el servidor", error });
  }
};
