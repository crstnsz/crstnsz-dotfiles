using Cake.Common.Diagnostics;
using Cake.Common.IO;
using Cake.Core;
using Cake.Core.Diagnostics;
using Cake.Core.IO;
using Cake.Frosting;
using System;
using System.IO;
using System.Linq;
using System.Reflection.PortableExecutable;

[TaskName("CheckDllArchitecture")]
public sealed class CheckDllArchitecture : FrostingTask<BuildContext>
{
    public override void Run(BuildContext context)
    {
        if (!Directory.Exists(context.Path))
        {
            context.Error($"Pasta não encontrada: {context.Path}");
            return;
        }

        CheckAllFiles(context, ".dll");
        CheckAllFiles(context, ".exe");
    }

    private void CheckAllFiles(BuildContext context, string searchPattern)
    {
        var files = context.GetFiles($"{context.Path}/*{searchPattern}").ToList();

        if (!files.Any())
        {
            context.Warning($"Nenhuma {searchPattern} encontrada na pasta.");
            return;
        }

        context.Information($"Analisando {files.Count} arquivo(s) {searchPattern}...");
        context.Information(string.Format("{0,-50} {1}", "Arquivo", "Arquitetura"));
        context.Information(new string('-', 70));

        foreach (var dll in files)
        {
            string architecture = "Desconhecido";
            try
            {
                using var stream = File.OpenRead(dll.FullPath);
                using var peReader = new PEReader(stream);

                architecture = GetArchitectureDescription(
                    peReader.PEHeaders.CoffHeader.Machine,
                    peReader.PEHeaders.CorHeader?.Flags);
            }
            catch (BadImageFormatException)
            {
                architecture = "Não é uma DLL .NET válida (ex: biblioteca nativa)";
            }
            catch (Exception ex)
            {
                architecture = $"Erro: {ex.Message}";
            }

            context.Information(string.Format("{0,-50} {1}", dll.GetFilename().ToString(), architecture));
        }
    }

    private string GetArchitectureDescription(Machine machine, CorFlags? corFlags)
    {
        if (corFlags == null)
        {
            return machine switch
            {
                Machine.I386 => "x86 - No Core flags (32 bits)",
                Machine.Amd64 => "x64 - No Core flags (64 bits)",
                Machine.Arm64 => "ARM64 - No Core flags",
                _ => $"Outra ({machine}) - No Core flags",
            };

            
        }

        bool isILOnly = (corFlags & CorFlags.ILOnly) != 0;
        bool is32BitRequired = (corFlags & CorFlags.Requires32Bit) != 0;
        bool is32BitPreferred = (corFlags & CorFlags.Prefers32Bit) != 0;

        return machine switch
        {
            Machine.I386 => isILOnly
                ? (is32BitRequired 
                    ? "x86 (com Requires32Bit / 32-Bit Required)"
                    : is32BitPreferred
                        ? "Any CPU (com Prefer 32-Bit)"
                        : "Any CPU (64-bit e 32-bit compatível)")
                : "x86 Nativo / C++ CLI (32 bits)",
            Machine.Amd64 => "x64 Nativo (64 bits)",
            Machine.Arm64 => "ARM64",
            _ => $"Outra ({machine})",
        };
    }
}