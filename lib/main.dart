import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// =====================================================
// APP PRINCIPAL
// =====================================================

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lanterna Inteligente',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppCores.amarelo,
          brightness: Brightness.dark,
        ),

        scaffoldBackgroundColor: AppCores.fundo,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppCores.cinzaEscuro,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),

      home: const LanternaScreen(),
    );
  }
}

// =====================================================
// CORES DO APLICATIVO
// =====================================================

class AppCores {
  static const amarelo = Color(0xFFFFD700);
  static const fundo = Color(0xFF0D0D0D);
  static const cinzaEscuro = Color(0xFF1A1A1A);
  static const cinzaMedio = Color(0xFF2C2C2C);
  static const cinzaTexto = Color(0xFF888888);
  static const vermelho = Color(0xFFEF5350);
  static const azul = Color(0xFF42A5F5);
  static const verde = Color(0xFF66BB6A);
  static const roxo = Color(0xFFAB47BC);
}

// =====================================================
// TELA DA LANTERNA
// =====================================================

class LanternaScreen extends StatefulWidget {
  const LanternaScreen({super.key});

  @override
  State<LanternaScreen> createState() => _LanternaScreenState();
}

class _LanternaScreenState extends State<LanternaScreen> {
  bool _lanternaLigada = false;
  bool _modoAutomatico = false;

  // ===================================================
  // ALTERAR ESTADO DA LANTERNA
  // ===================================================

  void _alternarLanterna() {
    setState(() {
      _lanternaLigada = !_lanternaLigada;
    });
  }

  // ===================================================
  // ALTERAR MODO AUTOMÁTICO
  // ===================================================

  void _alternarModoAutomatico(bool valor) {
    setState(() {
      _modoAutomatico = valor;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1200),
        backgroundColor:
            valor ? AppCores.roxo : AppCores.cinzaMedio,
        content: Text(
          valor
              ? 'Modo Automático ativado'
              : 'Modo Automático desativado',
        ),
      ),
    );
  }

  // ===================================================
  // CONSTRUIR TELA
  // ===================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCores.fundo,

      body: SafeArea(
        child: Column(
          children: [

            // =================================================
            // CABEÇALHO
            // =================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  // Nome do aplicativo
                  const Row(
                    children: [
                      Icon(
                        Icons.flashlight_on,
                        color: AppCores.amarelo,
                        size: 28,
                      ),

                      SizedBox(width: 8),

                      Text(
                        'Lanterna',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),

                  // Badge de status
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: _lanternaLigada
                          ? AppCores.amarelo
                          : AppCores.cinzaMedio,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      _lanternaLigada
                          ? 'LIGADA'
                          : 'DESLIGADA',

                      style: TextStyle(
                        color: _lanternaLigada
                            ? Colors.black
                            : Colors.white,

                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // MODO AUTOMÁTICO
            // =================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: _modoAutomatico
                      ? AppCores.roxo.withOpacity(0.20)
                      : AppCores.cinzaEscuro,

                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(
                    color: _modoAutomatico
                        ? AppCores.roxo
                        : AppCores.cinzaMedio,
                    width: 1,
                  ),
                ),

                child: Row(
                  children: [

                    // Ícone
                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 300),

                      width: 48,
                      height: 48,

                      decoration: BoxDecoration(
                        color: _modoAutomatico
                            ? AppCores.roxo
                            : AppCores.cinzaMedio,

                        borderRadius:
                            BorderRadius.circular(14),
                      ),

                      child: Icon(
                        Icons.auto_mode,
                        color: _modoAutomatico
                            ? Colors.white
                            : AppCores.cinzaTexto,
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Texto
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Modo Automático',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'A lanterna poderá ajustar seu estado automaticamente.',
                            style: TextStyle(
                              color: AppCores.cinzaTexto,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Switch
                    Switch(
                      value: _modoAutomatico,

                      activeColor: AppCores.roxo,

                      onChanged: _alternarModoAutomatico,
                    ),
                  ],
                ),
              ),
            ),

            // =================================================
            // ÁREA PRINCIPAL DA LANTERNA
            // =================================================

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    // Texto do estado
                    AnimatedSwitcher(
                      duration:
                          const Duration(milliseconds: 300),

                      child: Text(
                        _lanternaLigada
                            ? 'Iluminando'
                            : 'Lanterna desligada',

                        key: ValueKey(_lanternaLigada),

                        style: TextStyle(
                          color: _lanternaLigada
                              ? AppCores.amarelo
                              : Colors.white,

                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // REPRESENTAÇÃO DA LANTERNA
                    // =================================================

                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 400),

                      curve: Curves.easeInOut,

                      width: _lanternaLigada
                          ? 190
                          : 140,

                      height: _lanternaLigada
                          ? 190
                          : 140,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: _lanternaLigada
                            ? AppCores.amarelo
                                .withOpacity(0.18)
                            : AppCores.cinzaEscuro,

                        border: Border.all(
                          color: _lanternaLigada
                              ? AppCores.amarelo
                              : AppCores.cinzaMedio,

                          width: 2,
                        ),

                        boxShadow: _lanternaLigada
                            ? [
                                BoxShadow(
                                  color: AppCores.amarelo
                                      .withOpacity(0.55),

                                  blurRadius: 45,

                                  spreadRadius: 12,
                                ),
                              ]
                            : [],
                      ),

                      child: Center(
                        child: AnimatedSwitcher(
                          duration:
                              const Duration(milliseconds: 400),

                          transitionBuilder:
                              (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },

                          child: Icon(
                            _lanternaLigada
                                ? Icons.flashlight_on
                                : Icons.flashlight_off,

                            key: ValueKey(
                              _lanternaLigada,
                            ),

                            size: _lanternaLigada
                                ? 95
                                : 70,

                            color: _lanternaLigada
                                ? AppCores.amarelo
                                : AppCores.cinzaTexto,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Informação
                    AnimatedSwitcher(
                      duration:
                          const Duration(milliseconds: 300),

                      child: Text(
                        _lanternaLigada
                            ? 'A iluminação está ativa'
                            : 'Pressione o botão para ligar',

                        key: ValueKey(
                          '$_lanternaLigada',
                        ),

                        style: const TextStyle(
                          color: AppCores.cinzaTexto,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =================================================
            // BOTÃO PRINCIPAL
            // =================================================

            Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
              ),

              child: GestureDetector(
                onTap: _alternarLanterna,

                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 300),

                  curve: Curves.easeInOut,

                  width: _lanternaLigada
                      ? 100
                      : 90,

                  height: _lanternaLigada
                      ? 100
                      : 90,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: _lanternaLigada
                        ? AppCores.amarelo
                        : AppCores.cinzaMedio,

                    boxShadow: _lanternaLigada
                        ? [
                            BoxShadow(
                              color: AppCores.amarelo
                                  .withOpacity(0.45),

                              blurRadius: 25,

                              spreadRadius: 5,
                            ),
                          ]
                        : [],
                  ),

                  child: AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: 250),

                    transitionBuilder:
                        (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },

                    child: Icon(
                      Icons.power_settings_new,

                      key: ValueKey(
                        _lanternaLigada,
                      ),

                      size: 40,

                      color: _lanternaLigada
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}