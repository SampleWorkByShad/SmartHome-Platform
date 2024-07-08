export const newSession = () => {
  const hashParameters = new URLSearchParams(window.location.hash.substring(1))
  if (hashParameters.has("id_token")) {
    const piniaState = {}
    piniaState.idToken = hashParameters.get("id_token")
    if (hashParameters.has("state")) {
      piniaState.state = hashParameters.get("state")
    }
    sessionStorage.setItem("auth", JSON.stringify(piniaState))
    const finalDestiniation = window.location.pathname + window.location.search
    window.location.replace(finalDestiniation)
    return true
  }
  return false
}