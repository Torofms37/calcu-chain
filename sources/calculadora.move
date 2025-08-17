module calculadora::calculadora;

use std::option::{Self, Option};
use std::string;
use sui::object;
use sui::transfer;
use sui::tx_context::TxContext;

const YA_REALIZADA: u64 = 1;

public struct Operacion has key {
    id: UID,
    valor: Option<Valor>,
}

public struct Valor has drop, store {
    first: u64,
    second: u64,
    resolved: u64,
    tipo: string::String,
}

#[allow(lint(self_transfer))]
public fun crea_operaciones(ctx: &mut TxContext) {
    let operacion = Operacion {
        id: object::new(ctx),
        valor: option::none<Valor>(),
    };
    transfer::transfer(operacion, ctx.sender())
}

public fun agregar_suma(operacion: &mut Operacion, first: u64, second: u64) {
    //si se cumple esto, no ejecuta el código de abajo, en caso de no existir agarra los valores y los agrega
    assert!(option::is_none(&operacion.valor), YA_REALIZADA);

    let resultado = first + second;

    let tipo_str = string::utf8(b"suma");

    let valor = Valor {
        first: first,
        second: second,
        resolved: resultado,
        tipo: tipo_str,
    };

    option::fill(&mut operacion.valor, valor);
}

public fun agregar_resta(operacion: &mut Operacion, first: u64, second: u64) {
    assert!(option::is_none(&operacion.valor), YA_REALIZADA);

    let resultado = first - second;

    let tipo_str = string::utf8(b"resta");

    let valor = Valor {
        first: first,
        second: second,
        resolved: resultado,
        tipo: tipo_str,
    };

    option::fill(&mut operacion.valor, valor);
}

public fun agregar_multiplicacion(operacion: &mut Operacion, first: u64, second: u64) {
    assert!(option::is_none(&operacion.valor), YA_REALIZADA);

    let resultado = first * second;

    let tipo_str = string::utf8(b"multiplicacion");

    let valor = Valor {
        first: first,
        second: second,
        resolved: resultado,
        tipo: tipo_str,
    };

    option::fill(&mut operacion.valor, valor);
}

public fun agregar_division(operacion: &mut Operacion, first: u64, second: u64) {
    assert!(option::is_none(&operacion.valor), YA_REALIZADA);

    let resultado = first / second;

    let tipo_str = string::utf8(b"division");

    let valor = Valor {
        first: first,
        second: second,
        resolved: resultado,
        tipo: tipo_str,
    };

    option::fill(&mut operacion.valor, valor);
}

public fun remove_operacion(operacion: &mut Operacion) {
    if (option::is_none(&operacion.valor)) {
        let _prev: Valor = option::extract(&mut operacion.valor);
    }
}
