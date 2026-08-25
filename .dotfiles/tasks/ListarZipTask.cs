using Cake.Common.Diagnostics;
using Cake.Core.Diagnostics;
using Cake.Frosting;
using System;
using System.IO;
using System.IO.Compression;

[TaskName("ListarZip")]
public sealed class ListarZipTask : FrostingTask<BuildContext>
{
    public override void Run(BuildContext context)
    {
        if (string.IsNullOrWhiteSpace(context.Path))
        {
            context.Error("O caminho do arquivo ZIP não foi informado. Use: --zip=\"caminho/do/arquivo.zip\"");
            return;
        }

        // Resolve o caminho absoluto (útil se o caminho for relativo ao rodar o comando)

        if (!File.Exists(context.Path))
        {
            context.Error($"Arquivo não encontrado: {context.Path}");
            return;
        }

        // Cabeçalho da tabela
        context.Information(string.Format("{0,-40} | {1,-15} | {2}", "Nome", "Tamanho (Bytes)", "Última Modificação"));
        context.Information(new string('-', 85));

        try
        {
            // Abre o ZIP e itera sobre os arquivos
            using (var archive = ZipFile.OpenRead(context.Path))
            {
                foreach (var entry in archive.Entries)
                {
                    context.Information(string.Format("{0,-40} | {1,-15} | {2}",
                        entry.Name,
                        entry.Length,
                        entry.LastWriteTime));
                }
            }
        }
        catch (Exception ex)
        {
            context.Error($"Erro ao processar o arquivo ZIP: {ex.Message}");
        }
    }
}