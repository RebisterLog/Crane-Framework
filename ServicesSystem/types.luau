export type ServiceClass = {
    Priority: number?,
    onStart: () -> (),
    onTick: (deltaTime: number) -> (),
}

return {}